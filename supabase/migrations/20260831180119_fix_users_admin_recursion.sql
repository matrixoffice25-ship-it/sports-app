-- Fix: replace the self-referencing admin check with a security-definer
-- function, which breaks the infinite recursion.
create or replace function is_admin() returns boolean
language sql security definer set search_path = public as $$
  select exists (select 1 from users where user_id = auth.uid() and role = 'admin');
$$;

drop policy if exists users_admin_all on users;

create policy users_admin_all on users for all
  using (is_admin());