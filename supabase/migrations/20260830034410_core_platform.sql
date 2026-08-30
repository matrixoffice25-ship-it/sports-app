-- ============================================================
-- EPIC 0: CORE PLATFORM SCHEMA
-- Multi-sport portable from day one — every content table in every
-- future segment carries sport_id, no exceptions.
-- ============================================================

create extension if not exists "pgcrypto"; -- for gen_random_uuid()

-- ------------------------------------------------------------
-- 0.1 Sport verticals, users, subscriptions
-- ------------------------------------------------------------
create table if not exists sport_verticals (
  sport_id      uuid primary key default gen_random_uuid(),
  slug          text unique not null,          -- 'golf', later 'tennis'
  display_name  text not null,
  is_active     boolean not null default true,
  created_at    timestamptz not null default now()
);

insert into sport_verticals (slug, display_name) values ('golf', 'Golf')
  on conflict (slug) do nothing;

-- Mirrors auth.users 1:1 — never store credentials here, Supabase Auth owns those.
create table if not exists users (
  user_id          uuid primary key references auth.users(id) on delete cascade,
  display_name     text not null,
  role             text not null default 'fan'
                     check (role in ('fan', 'verified_pro', 'admin')),
  active_sport_id  uuid references sport_verticals(sport_id),
  photo_url        text,
  created_at       timestamptz not null default now()
);

create table if not exists subscriptions (
  subscription_id           uuid primary key default gen_random_uuid(),
  user_id                   uuid not null references users(user_id) on delete cascade,
  sport_id                  uuid not null references sport_verticals(sport_id),
  segment                   text not null check (segment in ('lessons', 'fitness')),
  store                     text not null check (store in ('apple', 'google')),
  original_transaction_id   text not null,
  status                    text not null check (status in ('active', 'grace', 'expired', 'revoked')),
  expires_at                timestamptz not null,
  created_at                timestamptz not null default now(),
  unique (user_id, sport_id, segment),
  unique (original_transaction_id)   -- prevents receipt replay across different users
);

create index if not exists idx_subscriptions_user on subscriptions(user_id);

-- ------------------------------------------------------------
-- 0.2 Row Level Security
-- ------------------------------------------------------------
alter table users enable row level security;
alter table subscriptions enable row level security;
alter table sport_verticals enable row level security;

-- Users can read/update only their own row. Role changes are NOT
-- allowed via this policy (see admin-only policy below) — a user
-- editing their own row can never grant themselves 'admin'.
create policy users_select_own on users for select
  using (auth.uid() = user_id);

create policy users_update_own on users for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id and role = (select role from users where user_id = auth.uid()));

create policy users_insert_self on users for insert
  with check (auth.uid() = user_id and role = 'fan'); -- can only ever self-insert as 'fan'

-- Admins can read/update any user row (for pro verification, role changes).
create policy users_admin_all on users for all
  using (exists (select 1 from users u where u.user_id = auth.uid() and u.role = 'admin'));

-- Subscriptions: user can read only their own; writes happen exclusively
-- through the entitlement/IAP Edge Function using the service_role key,
-- never directly from the client.
create policy subscriptions_select_own on subscriptions for select
  using (auth.uid() = user_id);

create policy sport_verticals_select_all on sport_verticals for select
  using (true); -- public reference data, no sensitive info

-- ------------------------------------------------------------
-- 0.3 Entitlement check as a reusable SQL function
-- (the Edge Function in edge_check_entitlement.ts calls this)
-- ------------------------------------------------------------
create or replace function fn_check_entitlement(
  p_user_id uuid,
  p_sport_id uuid,
  p_segment text
) returns jsonb
language plpgsql
security definer -- runs with elevated privilege so it can read subscriptions regardless of RLS nuance
as $$
declare
  v_sub subscriptions%rowtype;
begin
  select * into v_sub
  from subscriptions
  where user_id = p_user_id and sport_id = p_sport_id and segment = p_segment
  order by expires_at desc
  limit 1;

  if v_sub is null then
    return jsonb_build_object('entitled', false, 'status', 'none');
  end if;

  -- Billing grace period (Apple/Google retry failed renewals ~16 days
  -- before hard revocation) still counts as entitled — do not churn
  -- payers over a transient card decline.
  if v_sub.status in ('active', 'grace') and v_sub.expires_at > now() - interval '16 days' then
    return jsonb_build_object(
      'entitled', true,
      'status', v_sub.status,
      'expires_at', v_sub.expires_at
    );
  end if;

  return jsonb_build_object('entitled', false, 'status', v_sub.status, 'expires_at', v_sub.expires_at);
end;
$$;

-- ------------------------------------------------------------
-- ACCEPTANCE TESTS
-- ------------------------------------------------------------
-- 1. insert into subscriptions ... status='expired', expires_at = now() - interval '1 day'
--    => fn_check_entitlement(...) returns entitled:false
-- 2. insert into subscriptions ... status='grace', expires_at = now() - interval '2 days'
--    => fn_check_entitlement(...) returns entitled:true, status:'grace'  (billing retry window)
-- 3. As a non-admin user, attempt: update users set role = 'admin' where user_id = auth.uid()
--    => must be rejected by users_update_own's WITH CHECK clause
-- 4. As User A, attempt: select * from subscriptions where user_id = <User B's id>
--    => must return zero rows (RLS blocks cross-user reads)
