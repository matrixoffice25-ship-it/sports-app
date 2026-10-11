SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict bBNBiF2hT8EB0hbetsgUtOcnyVQiL99w9pmA0AT2cOs4QEjfdml5DKcFdL2DU0M

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.11

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES
	('00000000-0000-0000-0000-000000000000', 'c0f0f4a2-8855-42ec-a887-c9deed1cfc95', 'authenticated', 'authenticated', 'test@gmail.com', '$2a$10$HgUKoscy.N4MxSVCKcRiw.jeMhH9hxenUbjydEDZBvVkY4ntpNh6m', '2026-09-02 17:20:41.028959+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-09-13 17:29:58.420399+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "c0f0f4a2-8855-42ec-a887-c9deed1cfc95", "email": "test@gmail.com", "display_name": "test", "email_verified": true, "phone_verified": false}', NULL, '2026-09-02 17:20:40.985089+00', '2026-09-15 05:11:06.566543+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'c2244e9d-689e-44d4-8767-005ce8764b56', 'authenticated', 'authenticated', 'samc1218@gmail.com', '$2a$10$flZJmwElzN0GjjzHqblq3eme9ZzMOJ6UkuokowW810Pg4Jm6CU.MC', '2026-09-01 16:28:35.924502+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-10-09 19:03:03.041824+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "c2244e9d-689e-44d4-8767-005ce8764b56", "email": "samc1218@gmail.com", "display_name": "Samantha Cebrero", "email_verified": true, "phone_verified": false}', NULL, '2026-09-01 16:28:35.904914+00', '2026-10-11 20:10:42.568933+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'afaa1119-7ccd-40ad-855b-8a711c864e42', 'authenticated', 'authenticated', 'terryrowles@gmail.com', '$2a$10$Bp/9wZttmFJr36gGBvcY4.zug/JBGGei7MHhN7EE/qu3DlnUA73NK', '2026-09-03 17:21:07.437756+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-09-24 02:41:32.018212+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "afaa1119-7ccd-40ad-855b-8a711c864e42", "email": "terryrowles@gmail.com", "display_name": "Terry Rowles", "email_verified": true, "phone_verified": false}', NULL, '2026-09-03 17:21:07.405713+00', '2026-09-24 02:41:32.092136+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '06ab125b-7a8c-478b-9eb5-ed50dd842d50', 'authenticated', 'authenticated', 'vigneshthc@gmail.com', '$2a$10$jwq9/s0rurLZTJKOksvtWOpZuCNUbkdrzR1a5WOVkbPAGjWgTCwP6', '2026-09-11 17:23:50.784862+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-09-11 17:23:50.799864+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "06ab125b-7a8c-478b-9eb5-ed50dd842d50", "email": "vigneshthc@gmail.com", "display_name": "Vignesh K Murthy", "email_verified": true, "phone_verified": false}', NULL, '2026-09-11 17:23:50.732329+00', '2026-09-11 17:23:50.842435+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '9f5a5fc7-3f06-4726-8f6e-1ddd43a74714', 'authenticated', 'authenticated', 'pink.test.athlete@gmail.com', '$2a$10$mRNJSjNtNfmO8z.jIdBpR.yndSxCF39dEXME.19wqskxwSg5z9bya', '2026-10-11 09:56:24.321331+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-10-11 10:07:00.942451+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "9f5a5fc7-3f06-4726-8f6e-1ddd43a74714", "email": "pink.test.athlete@gmail.com", "display_name": "Pink Test Athlete", "email_verified": true, "phone_verified": false}', NULL, '2026-10-11 09:56:24.282881+00', '2026-10-11 10:07:00.960103+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES
	('c2244e9d-689e-44d4-8767-005ce8764b56', 'c2244e9d-689e-44d4-8767-005ce8764b56', '{"sub": "c2244e9d-689e-44d4-8767-005ce8764b56", "email": "samc1218@gmail.com", "display_name": "Samantha Cebrero", "email_verified": false, "phone_verified": false}', 'email', '2026-09-01 16:28:35.919849+00', '2026-09-01 16:28:35.919898+00', '2026-09-01 16:28:35.919898+00', '14602d92-cf1f-42f1-96f7-e5992d3ad5d4'),
	('c0f0f4a2-8855-42ec-a887-c9deed1cfc95', 'c0f0f4a2-8855-42ec-a887-c9deed1cfc95', '{"sub": "c0f0f4a2-8855-42ec-a887-c9deed1cfc95", "email": "test@gmail.com", "display_name": "test", "email_verified": false, "phone_verified": false}', 'email', '2026-09-02 17:20:41.019624+00', '2026-09-02 17:20:41.019693+00', '2026-09-02 17:20:41.019693+00', '77984913-4649-44ab-ae31-858f81bc3bb1'),
	('afaa1119-7ccd-40ad-855b-8a711c864e42', 'afaa1119-7ccd-40ad-855b-8a711c864e42', '{"sub": "afaa1119-7ccd-40ad-855b-8a711c864e42", "email": "terryrowles@gmail.com", "display_name": "Terry Rowles", "email_verified": false, "phone_verified": false}', 'email', '2026-09-03 17:21:07.427507+00', '2026-09-03 17:21:07.427611+00', '2026-09-03 17:21:07.427611+00', 'de57b8f4-a0b2-491a-8910-af24a0cd6083'),
	('06ab125b-7a8c-478b-9eb5-ed50dd842d50', '06ab125b-7a8c-478b-9eb5-ed50dd842d50', '{"sub": "06ab125b-7a8c-478b-9eb5-ed50dd842d50", "email": "vigneshthc@gmail.com", "display_name": "Vignesh K Murthy", "email_verified": false, "phone_verified": false}', 'email', '2026-09-11 17:23:50.770455+00', '2026-09-11 17:23:50.770517+00', '2026-09-11 17:23:50.770517+00', 'f02ba5a9-cc42-4e0e-9d5c-e3ab0960bff9'),
	('9f5a5fc7-3f06-4726-8f6e-1ddd43a74714', '9f5a5fc7-3f06-4726-8f6e-1ddd43a74714', '{"sub": "9f5a5fc7-3f06-4726-8f6e-1ddd43a74714", "email": "pink.test.athlete@gmail.com", "display_name": "Pink Test Athlete", "email_verified": false, "phone_verified": false}', 'email', '2026-10-11 09:56:24.311213+00', '2026-10-11 09:56:24.311267+00', '2026-10-11 09:56:24.311267+00', '5c5e98a6-05ff-42f8-88c1-a3c6f16d440c');


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."sessions" ("id", "user_id", "created_at", "updated_at", "factor_id", "aal", "not_after", "refreshed_at", "user_agent", "ip", "tag", "oauth_client_id", "refresh_token_hmac_key", "refresh_token_counter", "scopes") VALUES
	('8080c9e2-c699-4394-aefe-f7ccdcc5f0ba', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-20 00:44:43.418555+00', '2026-09-20 03:20:50.719417+00', NULL, 'aal1', NULL, '2026-09-20 03:20:50.71928', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('a2747445-6ec8-4789-98fd-7a633dfaad7c', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-21 02:09:25.04046+00', '2026-09-21 03:07:45.240056+00', NULL, 'aal1', NULL, '2026-09-21 03:07:45.239914', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('23036206-2987-4207-b6ab-84a732a79284', 'c0f0f4a2-8855-42ec-a887-c9deed1cfc95', '2026-09-13 17:29:58.421088+00', '2026-09-15 05:11:06.590798+00', NULL, 'aal1', NULL, '2026-09-15 05:11:06.590664', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('e6c65222-fa26-4c9e-8f91-877819f5e7d5', '06ab125b-7a8c-478b-9eb5-ed50dd842d50', '2026-09-11 17:23:50.800008+00', '2026-09-11 17:23:50.800008+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36', '49.37.182.20', NULL, NULL, NULL, NULL, NULL),
	('1a26d7de-9333-4423-806e-8c812a77c39b', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-20 03:22:45.204288+00', '2026-09-20 03:22:45.204288+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('b3c397d6-56a2-4557-91ba-649a95b9c1ba', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-20 06:48:40.935441+00', '2026-09-20 13:17:48.944501+00', NULL, 'aal1', NULL, '2026-09-20 13:17:48.944341', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.6.1 Mobile/15E148 Safari/604.1', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('48daf13e-729d-43cd-82b8-bb3e773c24d8', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-13 17:59:21.251309+00', '2026-09-14 00:10:40.505908+00', NULL, 'aal1', NULL, '2026-09-14 00:10:40.505791', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('df6dc267-cc55-40f7-a17d-5bfc9a901942', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-14 00:15:21.641146+00', '2026-09-14 00:15:21.641146+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('18ac3250-52fe-4fd5-b50d-d35e76c530ea', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-14 00:36:44.992642+00', '2026-09-14 00:36:44.992642+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('4f2c067a-eff1-4ef1-b0ee-6dec95d6720c', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-14 00:51:36.821008+00', '2026-09-14 00:51:36.821008+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('3ddf2e69-b3d9-4061-b27f-7507b44437b0', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-14 01:16:15.565657+00', '2026-09-14 01:16:15.565657+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('85c882d1-cc42-49fd-9935-1585a374e30c', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-14 01:48:41.134503+00', '2026-09-14 01:48:41.134503+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('8dba1cdf-50d9-4174-9ad4-02f5bb2961e4', 'afaa1119-7ccd-40ad-855b-8a711c864e42', '2026-09-13 12:35:15.649337+00', '2026-09-13 12:35:15.649337+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.6.1 Mobile/15E148 Safari/604.1', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('6bd69e11-d6cc-41de-890f-94bff8522940', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-14 01:51:25.524267+00', '2026-09-19 01:07:59.70886+00', NULL, 'aal1', NULL, '2026-09-19 01:07:59.708749', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('109558b9-a237-48ca-ac14-f9a669d7ba70', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-13 17:07:41.405439+00', '2026-09-13 17:07:41.405439+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('c0e6ba60-dcec-4a77-bfae-5b6c9c6c33c7', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-20 08:40:17.947353+00', '2026-09-20 18:16:40.920684+00', NULL, 'aal1', NULL, '2026-09-20 18:16:40.920574', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('2afcef38-b217-4d1b-9bc4-510b56af9786', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-20 18:35:52.215851+00', '2026-09-20 18:35:52.215851+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('49618d4d-6a79-4d91-a96a-638b9af82a2a', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-13 17:16:59.582795+00', '2026-09-20 18:51:08.641089+00', NULL, 'aal1', NULL, '2026-09-20 18:51:08.640963', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('09bd8cbb-7d48-4eb3-895a-0405e8b071a4', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-13 14:08:17.755474+00', '2026-09-20 06:27:31.282581+00', NULL, 'aal1', NULL, '2026-09-20 06:27:31.282475', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.6.1 Mobile/15E148 Safari/604.1', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('592155e4-5cb3-4569-adde-7203ff0f5ddb', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-19 01:08:10.661066+00', '2026-09-20 00:42:39.723035+00', NULL, 'aal1', NULL, '2026-09-20 00:42:39.722779', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('4a5f15d8-4041-4d03-95db-3a2de43aa2d1', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-20 03:48:50.119533+00', '2026-09-20 06:55:41.247388+00', NULL, 'aal1', NULL, '2026-09-20 06:55:41.247257', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('4fa259de-681d-4a7b-a98d-e813e35aafec', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-20 19:10:25.930532+00', '2026-09-20 19:10:25.930532+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('7d33b2ad-db19-4eae-bf2b-8301f5691a2a', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-20 19:35:53.293694+00', '2026-09-20 19:35:53.293694+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('814862f5-2c64-4b57-b906-eb524818dcc7', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-25 23:50:44.56988+00', '2026-10-11 17:46:17.973467+00', NULL, 'aal1', NULL, '2026-10-11 17:46:17.973307', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '73.189.49.38', NULL, NULL, NULL, NULL, NULL),
	('794ef60f-16ae-4620-8cd5-e46727a6533d', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-20 06:56:53.729062+00', '2026-09-20 08:38:46.116666+00', NULL, 'aal1', NULL, '2026-09-20 08:38:46.11652', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('f4c6e690-1fc0-4ccb-ae01-39639b16d5bb', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-20 19:43:43.971687+00', '2026-09-21 02:04:16.796861+00', NULL, 'aal1', NULL, '2026-09-21 02:04:16.796726', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('3fd0a311-0df9-49ba-9acb-717966f78108', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-21 02:04:36.051227+00', '2026-09-21 02:04:36.051227+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('129c0bf2-883b-4c42-b004-b69c2d7fae0b', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-21 03:33:51.544749+00', '2026-09-23 01:33:33.061025+00', NULL, 'aal1', NULL, '2026-09-23 01:33:33.060893', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('e01c3362-1180-468a-93f6-2866d76dbcdb', 'afaa1119-7ccd-40ad-855b-8a711c864e42', '2026-09-24 02:41:32.019509+00', '2026-09-24 02:41:32.019509+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/27.0 Mobile/15E148 Safari/604.1', '108.41.123.203', NULL, NULL, NULL, NULL, NULL),
	('1a6a5b46-adac-4a87-b6f2-b4c904d22d29', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-23 02:08:19.4848+00', '2026-09-25 22:15:32.808677+00', NULL, 'aal1', NULL, '2026-09-25 22:15:32.80854', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '73.189.49.38', NULL, NULL, NULL, NULL, NULL),
	('c80785f6-c21e-44e9-9085-e19f5ee58e33', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-25 22:15:42.997602+00', '2026-09-25 22:15:42.997602+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '73.189.49.38', NULL, NULL, NULL, NULL, NULL),
	('5fd7893d-4644-4743-892a-e24fe4d08130', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-25 22:16:37.72716+00', '2026-09-25 23:14:36.992998+00', NULL, 'aal1', NULL, '2026-09-25 23:14:36.992879', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '73.189.49.38', NULL, NULL, NULL, NULL, NULL),
	('e5a6ee72-7f15-4aeb-8475-ffb72f4b0c5c', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-21 04:50:13.756692+00', '2026-10-11 20:10:42.595174+00', NULL, 'aal1', NULL, '2026-10-11 20:10:42.595032', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '73.189.49.38', NULL, NULL, NULL, NULL, NULL),
	('277de953-3b21-44e7-a638-8042181ef513', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-21 03:59:59.936547+00', '2026-09-26 15:30:24.727272+00', NULL, 'aal1', NULL, '2026-09-26 15:30:24.727134', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/27.0 Mobile/15E148 Safari/604.1', '73.189.49.38', NULL, NULL, NULL, NULL, NULL),
	('de5a1f9d-c0d8-4fd8-bd12-9ad9cb5d4fd1', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-10-09 19:03:03.042669+00', '2026-10-10 16:27:09.98164+00', NULL, 'aal1', NULL, '2026-10-10 16:27:09.98153', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '73.189.49.38', NULL, NULL, NULL, NULL, NULL),
	('af08357c-1827-4ae7-b27c-650d5f9165ca', '9f5a5fc7-3f06-4726-8f6e-1ddd43a74714', '2026-10-11 10:07:00.943892+00', '2026-10-11 10:07:00.943892+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/155.0.0.0 Safari/537.36', '108.41.123.203', NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") VALUES
	('e6c65222-fa26-4c9e-8f91-877819f5e7d5', '2026-09-11 17:23:50.843254+00', '2026-09-11 17:23:50.843254+00', 'password', '0e99ced8-4871-45bc-b391-ba23864b05d7'),
	('8dba1cdf-50d9-4174-9ad4-02f5bb2961e4', '2026-09-13 12:35:15.699706+00', '2026-09-13 12:35:15.699706+00', 'password', '85cb40ee-1cf2-4b48-98bf-966fd2c2a6d2'),
	('09bd8cbb-7d48-4eb3-895a-0405e8b071a4', '2026-09-13 14:08:17.777344+00', '2026-09-13 14:08:17.777344+00', 'password', '6b4651ef-aa12-4601-8ddf-30befac187a1'),
	('109558b9-a237-48ca-ac14-f9a669d7ba70', '2026-09-13 17:07:41.481812+00', '2026-09-13 17:07:41.481812+00', 'password', '89bbf783-df8f-45e2-9552-5513201dcc11'),
	('49618d4d-6a79-4d91-a96a-638b9af82a2a', '2026-09-13 17:16:59.59792+00', '2026-09-13 17:16:59.59792+00', 'password', '3d4bd3c7-a3fd-4067-bdf4-89c06c20dcce'),
	('23036206-2987-4207-b6ab-84a732a79284', '2026-09-13 17:29:58.43614+00', '2026-09-13 17:29:58.43614+00', 'password', 'dc62aab9-ab8a-485f-801b-56c52cd4c82d'),
	('48daf13e-729d-43cd-82b8-bb3e773c24d8', '2026-09-13 17:59:21.297859+00', '2026-09-13 17:59:21.297859+00', 'password', '3122d255-7c64-4901-b260-42bd27a9b3a7'),
	('df6dc267-cc55-40f7-a17d-5bfc9a901942', '2026-09-14 00:15:21.668459+00', '2026-09-14 00:15:21.668459+00', 'password', 'e8b8f9bb-0e6a-4b32-a27e-3911d0bfbb93'),
	('18ac3250-52fe-4fd5-b50d-d35e76c530ea', '2026-09-14 00:36:45.040593+00', '2026-09-14 00:36:45.040593+00', 'password', '5c72a0f5-a642-4a4a-b23a-111046659937'),
	('4f2c067a-eff1-4ef1-b0ee-6dec95d6720c', '2026-09-14 00:51:36.903975+00', '2026-09-14 00:51:36.903975+00', 'password', 'c9573772-0932-44f7-8bfa-02feb31b0754'),
	('3ddf2e69-b3d9-4061-b27f-7507b44437b0', '2026-09-14 01:16:15.619134+00', '2026-09-14 01:16:15.619134+00', 'password', '399f6695-0d6a-4cb0-b2eb-dc1b0bbf0dcd'),
	('85c882d1-cc42-49fd-9935-1585a374e30c', '2026-09-14 01:48:41.175048+00', '2026-09-14 01:48:41.175048+00', 'password', 'c041b111-473c-4b9e-9eaa-a60fcdccdb85'),
	('6bd69e11-d6cc-41de-890f-94bff8522940', '2026-09-14 01:51:25.541311+00', '2026-09-14 01:51:25.541311+00', 'password', '708b6691-e511-4c0c-90fd-8094db821680'),
	('592155e4-5cb3-4569-adde-7203ff0f5ddb', '2026-09-19 01:08:10.6843+00', '2026-09-19 01:08:10.6843+00', 'password', '483c3841-0fc6-4e89-80dd-d9c4858b5741'),
	('8080c9e2-c699-4394-aefe-f7ccdcc5f0ba', '2026-09-20 00:44:43.466221+00', '2026-09-20 00:44:43.466221+00', 'password', '5c1ffcce-045c-4482-989f-96d1c0d8f855'),
	('1a26d7de-9333-4423-806e-8c812a77c39b', '2026-09-20 03:22:45.243199+00', '2026-09-20 03:22:45.243199+00', 'password', 'b9ea4f78-999c-4261-9825-ef6ab7e9d378'),
	('4a5f15d8-4041-4d03-95db-3a2de43aa2d1', '2026-09-20 03:48:50.184186+00', '2026-09-20 03:48:50.184186+00', 'password', 'ce617739-acf1-4770-bb8f-316bcdda1b83'),
	('b3c397d6-56a2-4557-91ba-649a95b9c1ba', '2026-09-20 06:48:41.016243+00', '2026-09-20 06:48:41.016243+00', 'password', '62653799-f6a4-459f-8f9a-07119e6d1f3f'),
	('794ef60f-16ae-4620-8cd5-e46727a6533d', '2026-09-20 06:56:53.738271+00', '2026-09-20 06:56:53.738271+00', 'password', 'cc42eee3-bffd-416e-aeb0-50c2a512969c'),
	('c0e6ba60-dcec-4a77-bfae-5b6c9c6c33c7', '2026-09-20 08:40:17.986646+00', '2026-09-20 08:40:17.986646+00', 'password', '466de774-5a1f-45bb-b213-b3c39b7c7d12'),
	('2afcef38-b217-4d1b-9bc4-510b56af9786', '2026-09-20 18:35:52.26022+00', '2026-09-20 18:35:52.26022+00', 'password', '570d0729-7a0d-4fa8-a16d-e4bbd8d35086'),
	('4fa259de-681d-4a7b-a98d-e813e35aafec', '2026-09-20 19:10:25.991643+00', '2026-09-20 19:10:25.991643+00', 'password', '0f927d86-a8b8-498b-8658-40d1b1f9bd79'),
	('7d33b2ad-db19-4eae-bf2b-8301f5691a2a', '2026-09-20 19:35:53.363782+00', '2026-09-20 19:35:53.363782+00', 'password', 'd507bc9b-c1fa-4c8f-b367-e33623b0ee7f'),
	('f4c6e690-1fc0-4ccb-ae01-39639b16d5bb', '2026-09-20 19:43:44.051522+00', '2026-09-20 19:43:44.051522+00', 'password', 'eba87c05-c5ff-4b86-99b5-be681634fa6d'),
	('3fd0a311-0df9-49ba-9acb-717966f78108', '2026-09-21 02:04:36.078096+00', '2026-09-21 02:04:36.078096+00', 'password', '340a912c-18eb-4463-b8d5-317257aacc93'),
	('a2747445-6ec8-4789-98fd-7a633dfaad7c', '2026-09-21 02:09:25.079804+00', '2026-09-21 02:09:25.079804+00', 'password', 'a96f821d-2b52-4f7f-82a6-06ece03cdf96'),
	('129c0bf2-883b-4c42-b004-b69c2d7fae0b', '2026-09-21 03:33:51.624572+00', '2026-09-21 03:33:51.624572+00', 'password', 'f58f38b2-2c3d-4e04-9212-6c65776c6f89'),
	('277de953-3b21-44e7-a638-8042181ef513', '2026-09-21 03:59:59.995464+00', '2026-09-21 03:59:59.995464+00', 'password', '27a13a70-9705-42be-89a2-8dd01c55b008'),
	('e5a6ee72-7f15-4aeb-8475-ffb72f4b0c5c', '2026-09-21 04:50:13.808646+00', '2026-09-21 04:50:13.808646+00', 'password', '939e0214-976f-420c-857d-84891fc86f08'),
	('1a6a5b46-adac-4a87-b6f2-b4c904d22d29', '2026-09-23 02:08:19.512431+00', '2026-09-23 02:08:19.512431+00', 'password', '711cf0bc-6d89-442d-bacf-2d38869f5b3f'),
	('e01c3362-1180-468a-93f6-2866d76dbcdb', '2026-09-24 02:41:32.110769+00', '2026-09-24 02:41:32.110769+00', 'password', '072c6499-fd7e-42db-8d4b-f4a4581d4546'),
	('c80785f6-c21e-44e9-9085-e19f5ee58e33', '2026-09-25 22:15:43.029504+00', '2026-09-25 22:15:43.029504+00', 'password', '6a75b2cf-d2b3-4ceb-8edf-b7d3a609ddb5'),
	('5fd7893d-4644-4743-892a-e24fe4d08130', '2026-09-25 22:16:37.731432+00', '2026-09-25 22:16:37.731432+00', 'password', '078565e8-7236-4526-a117-de7b2ead1a70'),
	('814862f5-2c64-4b57-b906-eb524818dcc7', '2026-09-25 23:50:44.610248+00', '2026-09-25 23:50:44.610248+00', 'password', '96f8a598-fcc1-4323-96b4-3569bae1cc32'),
	('de5a1f9d-c0d8-4fd8-bd12-9ad9cb5d4fd1', '2026-10-09 19:03:03.124021+00', '2026-10-09 19:03:03.124021+00', 'password', 'e622064a-dd0e-46c2-8b6f-79745b3dd170'),
	('af08357c-1827-4ae7-b27c-650d5f9165ca', '2026-10-11 10:07:00.962522+00', '2026-10-11 10:07:00.962522+00', 'password', '6a00f694-e43b-4067-a436-434429cf4ce7');


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_recovery_code_sets; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_recovery_codes; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") VALUES
	('00000000-0000-0000-0000-000000000000', 272, 'zxeh3lkdrjri', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-15 16:41:30.960887+00', '2026-09-18 05:02:22.974306+00', 'p4qamvurckrr', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 279, 'vntjinqpmsnu', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-18 05:02:22.984835+00', '2026-09-18 06:31:41.398501+00', 'zxeh3lkdrjri', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 278, '6v62rdoobc6n', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-18 01:54:23.300554+00', '2026-09-18 06:34:16.998349+00', 'pb2hhi4a2ull', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 233, 'hie3czettzqn', 'afaa1119-7ccd-40ad-855b-8a711c864e42', false, '2026-09-13 12:35:15.679014+00', '2026-09-13 12:35:15.679014+00', NULL, '8dba1cdf-50d9-4174-9ad4-02f5bb2961e4'),
	('00000000-0000-0000-0000-000000000000', 281, 'cj3hn3ug44gk', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-18 06:34:17.006832+00', '2026-09-18 12:43:54.56433+00', '6v62rdoobc6n', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 282, 'b5nbmlxvqlkz', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-18 12:43:54.581677+00', '2026-09-18 14:20:43.536529+00', 'cj3hn3ug44gk', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 236, 'thq74nv5jaqv', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-13 17:07:41.442447+00', '2026-09-13 17:07:41.442447+00', NULL, '109558b9-a237-48ca-ac14-f9a669d7ba70'),
	('00000000-0000-0000-0000-000000000000', 280, '577vl4mnt62p', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-18 06:31:41.417858+00', '2026-09-18 19:07:43.800039+00', 'vntjinqpmsnu', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 273, '5gnheariylo2', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-15 16:41:32.722815+00', '2026-09-18 22:39:13.754081+00', '3d5wic6zxrki', '6bd69e11-d6cc-41de-890f-94bff8522940'),
	('00000000-0000-0000-0000-000000000000', 235, 'caiqbevlw5hj', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-13 14:08:17.766777+00', '2026-09-13 18:26:50.89943+00', NULL, '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 238, '4u66xubwuw7z', 'c0f0f4a2-8855-42ec-a887-c9deed1cfc95', true, '2026-09-13 17:29:58.430284+00', '2026-09-13 18:30:16.337211+00', NULL, '23036206-2987-4207-b6ab-84a732a79284'),
	('00000000-0000-0000-0000-000000000000', 239, 'ta3333jy3wbo', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-13 17:59:21.271929+00', '2026-09-13 18:57:28.252449+00', NULL, '48daf13e-729d-43cd-82b8-bb3e773c24d8'),
	('00000000-0000-0000-0000-000000000000', 240, 'nwjgqb62xm7g', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-13 18:26:50.921706+00', '2026-09-13 20:25:35.150694+00', 'caiqbevlw5hj', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 242, 'grduj3widfvq', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-13 18:57:28.269539+00', '2026-09-13 20:38:21.64771+00', 'ta3333jy3wbo', '48daf13e-729d-43cd-82b8-bb3e773c24d8'),
	('00000000-0000-0000-0000-000000000000', 237, 'fw5k2bcr33hq', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-13 17:16:59.590469+00', '2026-09-13 20:38:39.674011+00', NULL, '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 243, 'dqmhoajmfraq', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-13 20:25:35.168334+00', '2026-09-13 22:28:38.794933+00', 'nwjgqb62xm7g', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 245, 'esnevukgmxde', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-13 20:38:39.675012+00', '2026-09-13 23:49:56.17709+00', 'fw5k2bcr33hq', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 244, '67yhp5git2jo', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-13 20:38:21.658937+00', '2026-09-14 00:10:40.467178+00', 'grduj3widfvq', '48daf13e-729d-43cd-82b8-bb3e773c24d8'),
	('00000000-0000-0000-0000-000000000000', 248, 'zi5lb6gkjnpg', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-14 00:10:40.47703+00', '2026-09-14 00:10:40.47703+00', '67yhp5git2jo', '48daf13e-729d-43cd-82b8-bb3e773c24d8'),
	('00000000-0000-0000-0000-000000000000', 249, 'mxgxpr3oa35s', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-14 00:15:21.655095+00', '2026-09-14 00:15:21.655095+00', NULL, 'df6dc267-cc55-40f7-a17d-5bfc9a901942'),
	('00000000-0000-0000-0000-000000000000', 241, 'hqvudjlktfd7', 'c0f0f4a2-8855-42ec-a887-c9deed1cfc95', true, '2026-09-13 18:30:16.341088+00', '2026-09-14 00:23:20.144041+00', '4u66xubwuw7z', '23036206-2987-4207-b6ab-84a732a79284'),
	('00000000-0000-0000-0000-000000000000', 251, 'aj45wb7noedo', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-14 00:36:45.011834+00', '2026-09-14 00:36:45.011834+00', NULL, '18ac3250-52fe-4fd5-b50d-d35e76c530ea'),
	('00000000-0000-0000-0000-000000000000', 247, 'kcyxzjbinva7', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-13 23:49:56.192884+00', '2026-09-14 00:50:53.356259+00', 'esnevukgmxde', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 253, 'qb53dfdybsdj', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-14 00:51:36.874583+00', '2026-09-14 00:51:36.874583+00', NULL, '4f2c067a-eff1-4ef1-b0ee-6dec95d6720c'),
	('00000000-0000-0000-0000-000000000000', 254, '2c2jsfc6rwmy', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-14 01:16:15.589196+00', '2026-09-14 01:16:15.589196+00', NULL, '3ddf2e69-b3d9-4061-b27f-7507b44437b0'),
	('00000000-0000-0000-0000-000000000000', 255, 'gffb66i5p4ps', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-14 01:48:41.153759+00', '2026-09-14 01:48:41.153759+00', NULL, '85c882d1-cc42-49fd-9935-1585a374e30c'),
	('00000000-0000-0000-0000-000000000000', 252, 'p5r4kbvczyj4', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-14 00:50:53.365+00', '2026-09-14 01:49:24.88033+00', 'kcyxzjbinva7', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 250, 'dd3kp2eqj6lu', 'c0f0f4a2-8855-42ec-a887-c9deed1cfc95', true, '2026-09-14 00:23:20.163738+00', '2026-09-14 01:53:48.383068+00', 'hqvudjlktfd7', '23036206-2987-4207-b6ab-84a732a79284'),
	('00000000-0000-0000-0000-000000000000', 246, 'llipiddberqu', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-13 22:28:38.810983+00', '2026-09-14 02:16:58.433737+00', 'dqmhoajmfraq', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 256, 'yuq43zfgprp5', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-14 01:49:24.887016+00', '2026-09-14 02:47:49.552856+00', 'p5r4kbvczyj4', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 257, 'tbz6yzphx7oa', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-14 01:51:25.535975+00', '2026-09-14 05:02:47.175436+00', NULL, '6bd69e11-d6cc-41de-890f-94bff8522940'),
	('00000000-0000-0000-0000-000000000000', 260, 'jqz6c2zyw4rl', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-14 02:47:49.569243+00', '2026-09-14 05:02:50.562415+00', 'yuq43zfgprp5', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 262, 'sl4l7ulnui66', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-14 05:02:50.563045+00', '2026-09-14 14:49:14.127817+00', 'jqz6c2zyw4rl', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 261, 'gsammcjdmfn2', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-14 05:02:47.183056+00', '2026-09-14 14:49:15.113937+00', 'tbz6yzphx7oa', '6bd69e11-d6cc-41de-890f-94bff8522940'),
	('00000000-0000-0000-0000-000000000000', 220, 'rnmiim2i46gx', '06ab125b-7a8c-478b-9eb5-ed50dd842d50', false, '2026-09-11 17:23:50.825301+00', '2026-09-11 17:23:50.825301+00', NULL, 'e6c65222-fa26-4c9e-8f91-877819f5e7d5'),
	('00000000-0000-0000-0000-000000000000', 259, 'ausayyfdzit5', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-14 02:16:58.44809+00', '2026-09-14 15:46:36.59395+00', 'llipiddberqu', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 265, 'hoqadyo2ontt', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-14 15:46:36.614515+00', '2026-09-14 21:02:08.631478+00', 'ausayyfdzit5', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 266, '2gb73zrp6iii', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-14 21:02:08.643867+00', '2026-09-15 00:41:39.752845+00', 'hoqadyo2ontt', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 263, '2dxbonpeq244', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-14 14:49:14.138064+00', '2026-09-15 04:27:28.785566+00', 'sl4l7ulnui66', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 264, 'afjof4z5oxef', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-14 14:49:15.114689+00', '2026-09-15 04:27:54.192095+00', 'gsammcjdmfn2', '6bd69e11-d6cc-41de-890f-94bff8522940'),
	('00000000-0000-0000-0000-000000000000', 258, '5zi3hwepvozr', 'c0f0f4a2-8855-42ec-a887-c9deed1cfc95', true, '2026-09-14 01:53:48.410871+00', '2026-09-15 05:11:06.54143+00', 'dd3kp2eqj6lu', '23036206-2987-4207-b6ab-84a732a79284'),
	('00000000-0000-0000-0000-000000000000', 270, 'rtepzc7slvey', 'c0f0f4a2-8855-42ec-a887-c9deed1cfc95', false, '2026-09-15 05:11:06.557861+00', '2026-09-15 05:11:06.557861+00', '5zi3hwepvozr', '23036206-2987-4207-b6ab-84a732a79284'),
	('00000000-0000-0000-0000-000000000000', 267, 'h4v5fdyie4ap', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-15 00:41:39.76781+00', '2026-09-15 11:03:41.930633+00', '2gb73zrp6iii', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 268, 'p4qamvurckrr', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-15 04:27:28.802628+00', '2026-09-15 16:41:30.948781+00', '2dxbonpeq244', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 269, '3d5wic6zxrki', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-15 04:27:54.194119+00', '2026-09-15 16:41:32.721331+00', 'afjof4z5oxef', '6bd69e11-d6cc-41de-890f-94bff8522940'),
	('00000000-0000-0000-0000-000000000000', 271, 'qqdaap6hfi45', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-15 11:03:41.947691+00', '2026-09-15 16:44:53.367025+00', 'h4v5fdyie4ap', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 274, 'flnq44fclkss', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-15 16:44:53.380519+00', '2026-09-15 21:24:50.97647+00', 'qqdaap6hfi45', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 275, 'gyabjdzkfisf', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-15 21:24:50.994219+00', '2026-09-17 21:04:33.025351+00', 'flnq44fclkss', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 276, 'jjphco3ooj4v', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-17 21:04:33.048822+00', '2026-09-17 22:19:14.240562+00', 'gyabjdzkfisf', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 277, 'pb2hhi4a2ull', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-17 22:19:14.2571+00', '2026-09-18 01:54:23.283709+00', 'jjphco3ooj4v', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 374, 'ugulsspinpby', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-25 22:16:37.728519+00', '2026-09-25 23:14:36.939619+00', NULL, '5fd7893d-4644-4743-892a-e24fe4d08130'),
	('00000000-0000-0000-0000-000000000000', 284, 'njcfd6uxk3c4', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-18 19:07:43.814891+00', '2026-09-18 20:05:44.525809+00', '577vl4mnt62p', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 283, 'wrbqchjcmthz', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-18 14:20:43.550119+00', '2026-09-18 20:37:33.667063+00', 'b5nbmlxvqlkz', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 285, 'aieus2tcqbd6', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-18 20:05:44.534129+00', '2026-09-18 21:39:18.901825+00', 'njcfd6uxk3c4', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 286, 'td7hbm3s7sjq', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-18 20:37:33.673635+00', '2026-09-18 22:23:24.600147+00', 'wrbqchjcmthz', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 287, 'ijiu7gx54pc5', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-18 21:39:18.918647+00', '2026-09-18 22:37:39.191848+00', 'aieus2tcqbd6', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 288, 'npuy5pbzokxd', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-18 22:23:24.621254+00', '2026-09-19 00:46:42.987467+00', 'td7hbm3s7sjq', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 289, '7pru6sinaa4s', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-18 22:37:39.199504+00', '2026-09-19 00:58:27.300517+00', 'ijiu7gx54pc5', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 290, '6okhkpgoa42b', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-18 22:39:13.758285+00', '2026-09-19 01:07:59.665225+00', '5gnheariylo2', '6bd69e11-d6cc-41de-890f-94bff8522940'),
	('00000000-0000-0000-0000-000000000000', 293, 'ccmhvdmqno75', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-19 01:07:59.684195+00', '2026-09-19 01:07:59.684195+00', '6okhkpgoa42b', '6bd69e11-d6cc-41de-890f-94bff8522940'),
	('00000000-0000-0000-0000-000000000000', 292, 'myd2syi4v7st', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-19 00:58:27.309708+00', '2026-09-19 01:56:28.304011+00', '7pru6sinaa4s', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 295, 'fsznery4y7lt', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-19 01:56:28.318039+00', '2026-09-19 02:54:58.352812+00', 'myd2syi4v7st', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 296, 'vciopxozwhyj', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-19 02:54:58.371467+00', '2026-09-19 03:53:28.331973+00', 'fsznery4y7lt', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 291, 'k34uaqupfwmf', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-19 00:46:43.000802+00', '2026-09-19 12:15:18.584823+00', 'npuy5pbzokxd', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 298, '2jrx3clp4jpz', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-19 12:15:18.598228+00', '2026-09-19 13:29:53.455692+00', 'k34uaqupfwmf', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 297, 'qwizbstj7kvy', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-19 03:53:28.35133+00', '2026-09-20 00:42:19.063786+00', 'vciopxozwhyj', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 294, '7y7dnc4uqo7w', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-19 01:08:10.675666+00', '2026-09-20 00:42:39.713043+00', NULL, '592155e4-5cb3-4569-adde-7203ff0f5ddb'),
	('00000000-0000-0000-0000-000000000000', 301, 'tq4ktlyq2bfc', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-20 00:42:39.717705+00', '2026-09-20 00:42:39.717705+00', '7y7dnc4uqo7w', '592155e4-5cb3-4569-adde-7203ff0f5ddb'),
	('00000000-0000-0000-0000-000000000000', 299, 'zizcc2n6wj2k', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-19 13:29:53.471102+00', '2026-09-20 01:00:33.266666+00', '2jrx3clp4jpz', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 300, 'wvi6ecnj7vqk', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-20 00:42:19.078305+00', '2026-09-20 01:40:21.660133+00', 'qwizbstj7kvy', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 302, '7kuhnsm75vng', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-20 00:44:43.443077+00', '2026-09-20 01:43:04.467127+00', NULL, '8080c9e2-c699-4394-aefe-f7ccdcc5f0ba'),
	('00000000-0000-0000-0000-000000000000', 303, 'ymxpl3zuwdzk', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-20 01:00:33.275795+00', '2026-09-20 02:28:02.480311+00', 'zizcc2n6wj2k', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 305, 'guurjhdhqq47', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-20 01:43:04.477075+00', '2026-09-20 03:20:50.675348+00', '7kuhnsm75vng', '8080c9e2-c699-4394-aefe-f7ccdcc5f0ba'),
	('00000000-0000-0000-0000-000000000000', 307, 'b5o3t44er6ya', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-20 03:20:50.687564+00', '2026-09-20 03:20:50.687564+00', 'guurjhdhqq47', '8080c9e2-c699-4394-aefe-f7ccdcc5f0ba'),
	('00000000-0000-0000-0000-000000000000', 304, 't3y6yupak52r', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-20 01:40:21.677215+00', '2026-09-20 03:21:08.09942+00', 'wvi6ecnj7vqk', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 309, 'twxfxw7k44mb', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-20 03:22:45.227926+00', '2026-09-20 03:22:45.227926+00', NULL, '1a26d7de-9333-4423-806e-8c812a77c39b'),
	('00000000-0000-0000-0000-000000000000', 306, 'askufv3jni64', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-20 02:28:02.489946+00', '2026-09-20 03:26:17.593864+00', 'ymxpl3zuwdzk', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 310, 'ixbg7pbwpdra', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-20 03:26:17.601579+00', '2026-09-20 04:24:25.610082+00', 'askufv3jni64', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 308, 'ryk3adr4dkz6', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-20 03:21:08.100316+00', '2026-09-20 04:25:47.098117+00', 't3y6yupak52r', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 312, 'p3bkkpk7ibcf', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-20 04:24:25.624224+00', '2026-09-20 05:22:28.586791+00', 'ixbg7pbwpdra', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 313, '2dzu4mtivn2u', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-20 04:25:47.105296+00', '2026-09-20 05:24:10.354028+00', 'ryk3adr4dkz6', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 311, '3bqqrqo5cjci', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-20 03:48:50.153131+00', '2026-09-20 05:24:26.559828+00', NULL, '4a5f15d8-4041-4d03-95db-3a2de43aa2d1'),
	('00000000-0000-0000-0000-000000000000', 315, 'bsoimxygghkx', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-20 05:24:10.357651+00', '2026-09-20 06:22:26.662997+00', '2dzu4mtivn2u', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 314, 'uclhig46ttjt', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-20 05:22:28.607964+00', '2026-09-20 06:27:31.251759+00', 'p3bkkpk7ibcf', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 318, 'e56th4gr3y2z', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-20 06:27:31.258531+00', '2026-09-20 06:27:31.258531+00', 'uclhig46ttjt', '09bd8cbb-7d48-4eb3-895a-0405e8b071a4'),
	('00000000-0000-0000-0000-000000000000', 316, 'ajj4dnyk4bpt', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-20 05:24:26.560259+00', '2026-09-20 06:55:41.211702+00', '3bqqrqo5cjci', '4a5f15d8-4041-4d03-95db-3a2de43aa2d1'),
	('00000000-0000-0000-0000-000000000000', 320, 'dcfskras2x2y', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-20 06:55:41.2213+00', '2026-09-20 06:55:41.2213+00', 'ajj4dnyk4bpt', '4a5f15d8-4041-4d03-95db-3a2de43aa2d1'),
	('00000000-0000-0000-0000-000000000000', 319, 'pqpsklep4vtw', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-20 06:48:40.97623+00', '2026-09-20 07:46:44.323098+00', NULL, 'b3c397d6-56a2-4557-91ba-649a95b9c1ba'),
	('00000000-0000-0000-0000-000000000000', 321, '2f2hxop4dbhd', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-20 06:56:53.735011+00', '2026-09-20 08:38:46.072471+00', NULL, '794ef60f-16ae-4620-8cd5-e46727a6533d'),
	('00000000-0000-0000-0000-000000000000', 323, 'gpinu4caadwx', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-20 08:38:46.084663+00', '2026-09-20 08:38:46.084663+00', '2f2hxop4dbhd', '794ef60f-16ae-4620-8cd5-e46727a6533d'),
	('00000000-0000-0000-0000-000000000000', 322, 'ghdepjmstq5u', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-20 07:46:44.342742+00', '2026-09-20 08:47:04.360121+00', 'pqpsklep4vtw', 'b3c397d6-56a2-4557-91ba-649a95b9c1ba'),
	('00000000-0000-0000-0000-000000000000', 325, 'akvowz325x5c', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-20 08:47:04.367244+00', '2026-09-20 13:17:48.902386+00', 'ghdepjmstq5u', 'b3c397d6-56a2-4557-91ba-649a95b9c1ba'),
	('00000000-0000-0000-0000-000000000000', 326, '6go4a3u5fixy', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-20 13:17:48.914959+00', '2026-09-20 13:17:48.914959+00', 'akvowz325x5c', 'b3c397d6-56a2-4557-91ba-649a95b9c1ba'),
	('00000000-0000-0000-0000-000000000000', 324, 'oyoskvwyzceg', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-20 08:40:17.972969+00', '2026-09-20 16:20:37.14621+00', NULL, 'c0e6ba60-dcec-4a77-bfae-5b6c9c6c33c7'),
	('00000000-0000-0000-0000-000000000000', 327, 'oo63rze3tomz', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-20 16:20:37.16278+00', '2026-09-20 17:18:40.842695+00', 'oyoskvwyzceg', 'c0e6ba60-dcec-4a77-bfae-5b6c9c6c33c7'),
	('00000000-0000-0000-0000-000000000000', 328, 'aafzhkpp23jo', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-20 17:18:40.856995+00', '2026-09-20 18:16:40.871677+00', 'oo63rze3tomz', 'c0e6ba60-dcec-4a77-bfae-5b6c9c6c33c7'),
	('00000000-0000-0000-0000-000000000000', 329, 'ojny4trieczt', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-20 18:16:40.891294+00', '2026-09-20 18:16:40.891294+00', 'aafzhkpp23jo', 'c0e6ba60-dcec-4a77-bfae-5b6c9c6c33c7'),
	('00000000-0000-0000-0000-000000000000', 330, '2x7ploxerhtm', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-20 18:35:52.244987+00', '2026-09-20 18:35:52.244987+00', NULL, '2afcef38-b217-4d1b-9bc4-510b56af9786'),
	('00000000-0000-0000-0000-000000000000', 317, '4kz5zhm7qwp5', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-20 06:22:26.678476+00', '2026-09-20 18:51:08.595321+00', 'bsoimxygghkx', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 331, 'kd5lrxhinu2e', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-20 18:51:08.608697+00', '2026-09-20 18:51:08.608697+00', '4kz5zhm7qwp5', '49618d4d-6a79-4d91-a96a-638b9af82a2a'),
	('00000000-0000-0000-0000-000000000000', 332, '37pfcv24lun2', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-20 19:10:25.959317+00', '2026-09-20 19:10:25.959317+00', NULL, '4fa259de-681d-4a7b-a98d-e813e35aafec'),
	('00000000-0000-0000-0000-000000000000', 333, '5u3emaifwu56', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-20 19:35:53.330596+00', '2026-09-20 19:35:53.330596+00', NULL, '7d33b2ad-db19-4eae-bf2b-8301f5691a2a'),
	('00000000-0000-0000-0000-000000000000', 375, 'zdbfyxxvjjxw', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-25 23:14:36.959508+00', '2026-09-25 23:14:36.959508+00', 'ugulsspinpby', '5fd7893d-4644-4743-892a-e24fe4d08130'),
	('00000000-0000-0000-0000-000000000000', 334, 'vtb4rs7oq5mp', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-20 19:43:44.01864+00', '2026-09-21 02:04:16.753401+00', NULL, 'f4c6e690-1fc0-4ccb-ae01-39639b16d5bb'),
	('00000000-0000-0000-0000-000000000000', 335, '3ktkdpel2e7p', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-21 02:04:16.765438+00', '2026-09-21 02:04:16.765438+00', 'vtb4rs7oq5mp', 'f4c6e690-1fc0-4ccb-ae01-39639b16d5bb'),
	('00000000-0000-0000-0000-000000000000', 336, 'reks7z7rw6hs', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-21 02:04:36.069989+00', '2026-09-21 02:04:36.069989+00', NULL, '3fd0a311-0df9-49ba-9acb-717966f78108'),
	('00000000-0000-0000-0000-000000000000', 371, 'khxpjjhcy4c7', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-25 21:56:52.603701+00', '2026-09-25 23:47:25.148329+00', 'zft4khg46bej', 'e5a6ee72-7f15-4aeb-8475-ffb72f4b0c5c'),
	('00000000-0000-0000-0000-000000000000', 337, 'gqhorox7uv3m', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-21 02:09:25.061887+00', '2026-09-21 03:07:45.199013+00', NULL, 'a2747445-6ec8-4789-98fd-7a633dfaad7c'),
	('00000000-0000-0000-0000-000000000000', 338, 'hiqunp2gy6xw', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-21 03:07:45.213957+00', '2026-09-21 03:07:45.213957+00', 'gqhorox7uv3m', 'a2747445-6ec8-4789-98fd-7a633dfaad7c'),
	('00000000-0000-0000-0000-000000000000', 370, 'ntgvelbw3s3g', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-24 12:36:57.731725+00', '2026-09-26 15:30:24.673014+00', 'zltghl4fhvxx', '277de953-3b21-44e7-a638-8042181ef513'),
	('00000000-0000-0000-0000-000000000000', 340, '2pzbumgqbe2z', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-21 03:59:59.972449+00', '2026-09-21 05:01:30.398041+00', NULL, '277de953-3b21-44e7-a638-8042181ef513'),
	('00000000-0000-0000-0000-000000000000', 378, 'pjvopulflkke', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-26 15:30:24.687797+00', '2026-09-26 15:30:24.687797+00', 'ntgvelbw3s3g', '277de953-3b21-44e7-a638-8042181ef513'),
	('00000000-0000-0000-0000-000000000000', 342, 'g7ff34kiagh3', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-21 05:01:30.415813+00', '2026-09-21 11:20:01.818757+00', '2pzbumgqbe2z', '277de953-3b21-44e7-a638-8042181ef513'),
	('00000000-0000-0000-0000-000000000000', 377, '5gco5i4tedjw', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-25 23:50:44.598593+00', '2026-09-26 15:54:39.962225+00', NULL, '814862f5-2c64-4b57-b906-eb524818dcc7'),
	('00000000-0000-0000-0000-000000000000', 343, 'raom6eqribgw', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-21 11:20:01.837646+00', '2026-09-21 13:22:52.992012+00', 'g7ff34kiagh3', '277de953-3b21-44e7-a638-8042181ef513'),
	('00000000-0000-0000-0000-000000000000', 341, 'edce6fo2qimh', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-21 04:50:13.779806+00', '2026-09-21 19:16:49.426845+00', NULL, 'e5a6ee72-7f15-4aeb-8475-ffb72f4b0c5c'),
	('00000000-0000-0000-0000-000000000000', 379, 'ujfs6ufubcjv', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-26 15:54:39.980605+00', '2026-09-29 14:09:07.188563+00', '5gco5i4tedjw', '814862f5-2c64-4b57-b906-eb524818dcc7'),
	('00000000-0000-0000-0000-000000000000', 339, '7qlyqjmvhqeg', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-21 03:33:51.585329+00', '2026-09-21 19:17:21.834958+00', NULL, '129c0bf2-883b-4c42-b004-b69c2d7fae0b'),
	('00000000-0000-0000-0000-000000000000', 344, 'wavedjgo342y', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-21 13:22:53.003383+00', '2026-09-21 23:38:25.110928+00', 'raom6eqribgw', '277de953-3b21-44e7-a638-8042181ef513'),
	('00000000-0000-0000-0000-000000000000', 380, 'uozq2cojlf2l', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-29 14:09:07.204518+00', '2026-10-01 18:27:09.795189+00', 'ujfs6ufubcjv', '814862f5-2c64-4b57-b906-eb524818dcc7'),
	('00000000-0000-0000-0000-000000000000', 347, 'jg4tup3y67ve', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-21 23:38:25.126861+00', '2026-09-22 00:57:16.161628+00', 'wavedjgo342y', '277de953-3b21-44e7-a638-8042181ef513'),
	('00000000-0000-0000-0000-000000000000', 345, '3r66l3kndzf4', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-21 19:16:49.441939+00', '2026-09-22 02:41:21.830837+00', 'edce6fo2qimh', 'e5a6ee72-7f15-4aeb-8475-ffb72f4b0c5c'),
	('00000000-0000-0000-0000-000000000000', 376, 'oxzx5ajtnvf6', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-25 23:47:25.15723+00', '2026-10-01 18:27:15.532768+00', 'khxpjjhcy4c7', 'e5a6ee72-7f15-4aeb-8475-ffb72f4b0c5c'),
	('00000000-0000-0000-0000-000000000000', 346, 'scentlneclmj', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-21 19:17:21.846555+00', '2026-09-22 02:41:52.638007+00', '7qlyqjmvhqeg', '129c0bf2-883b-4c42-b004-b69c2d7fae0b'),
	('00000000-0000-0000-0000-000000000000', 350, 'kbasiezvscda', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-22 02:41:52.646348+00', '2026-09-22 22:51:56.933431+00', 'scentlneclmj', '129c0bf2-883b-4c42-b004-b69c2d7fae0b'),
	('00000000-0000-0000-0000-000000000000', 349, 'cp3vdw3atmld', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-22 02:41:21.855498+00', '2026-09-22 22:52:20.011056+00', '3r66l3kndzf4', 'e5a6ee72-7f15-4aeb-8475-ffb72f4b0c5c'),
	('00000000-0000-0000-0000-000000000000', 383, 'wjm2udcofadp', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-10-09 19:03:03.082633+00', '2026-10-09 20:01:29.04817+00', NULL, 'de5a1f9d-c0d8-4fd8-bd12-9ad9cb5d4fd1'),
	('00000000-0000-0000-0000-000000000000', 351, '22id7zwcbrz4', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-22 22:51:56.946188+00', '2026-09-23 00:35:03.050492+00', 'kbasiezvscda', '129c0bf2-883b-4c42-b004-b69c2d7fae0b'),
	('00000000-0000-0000-0000-000000000000', 353, 'tixnmt6askmn', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-23 00:35:03.064207+00', '2026-09-23 01:33:33.017594+00', '22id7zwcbrz4', '129c0bf2-883b-4c42-b004-b69c2d7fae0b'),
	('00000000-0000-0000-0000-000000000000', 354, 'alskfvk4ncfr', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-23 01:33:33.029045+00', '2026-09-23 01:33:33.029045+00', 'tixnmt6askmn', '129c0bf2-883b-4c42-b004-b69c2d7fae0b'),
	('00000000-0000-0000-0000-000000000000', 352, 'cptw7zmfwnyz', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-22 22:52:20.012046+00', '2026-09-23 02:06:58.787406+00', 'cp3vdw3atmld', 'e5a6ee72-7f15-4aeb-8475-ffb72f4b0c5c'),
	('00000000-0000-0000-0000-000000000000', 384, 'nvfnpw5z6xat', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-10-09 20:01:29.061915+00', '2026-10-09 20:59:28.891131+00', 'wjm2udcofadp', 'de5a1f9d-c0d8-4fd8-bd12-9ad9cb5d4fd1'),
	('00000000-0000-0000-0000-000000000000', 382, 't2bjtwa5fkv7', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-10-01 18:27:15.533232+00', '2026-10-10 17:22:55.519986+00', 'oxzx5ajtnvf6', 'e5a6ee72-7f15-4aeb-8475-ffb72f4b0c5c'),
	('00000000-0000-0000-0000-000000000000', 348, 'wycuthxoqr43', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-22 00:57:16.181467+00', '2026-09-23 02:23:34.073111+00', 'jg4tup3y67ve', '277de953-3b21-44e7-a638-8042181ef513'),
	('00000000-0000-0000-0000-000000000000', 381, 'ockh34eqszva', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-10-01 18:27:09.808954+00', '2026-10-11 03:33:53.701642+00', 'uozq2cojlf2l', '814862f5-2c64-4b57-b906-eb524818dcc7'),
	('00000000-0000-0000-0000-000000000000', 355, 'n3v46zyf45fo', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-23 02:06:58.79801+00', '2026-09-23 16:05:32.355491+00', 'cptw7zmfwnyz', 'e5a6ee72-7f15-4aeb-8475-ffb72f4b0c5c'),
	('00000000-0000-0000-0000-000000000000', 356, 'whjfxot7c6as', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-23 02:08:19.504805+00', '2026-09-23 16:05:51.268652+00', NULL, '1a6a5b46-adac-4a87-b6f2-b4c904d22d29'),
	('00000000-0000-0000-0000-000000000000', 358, 'pm4mg2h2kpqa', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-23 16:05:32.371241+00', '2026-09-23 17:04:00.44302+00', 'n3v46zyf45fo', 'e5a6ee72-7f15-4aeb-8475-ffb72f4b0c5c'),
	('00000000-0000-0000-0000-000000000000', 360, 'sf3eok5vks6j', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-23 17:04:00.460342+00', '2026-09-23 18:02:00.536078+00', 'pm4mg2h2kpqa', 'e5a6ee72-7f15-4aeb-8475-ffb72f4b0c5c'),
	('00000000-0000-0000-0000-000000000000', 361, 'wjlubzti6xfu', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-23 18:02:00.546238+00', '2026-09-24 01:58:35.310072+00', 'sf3eok5vks6j', 'e5a6ee72-7f15-4aeb-8475-ffb72f4b0c5c'),
	('00000000-0000-0000-0000-000000000000', 359, 'q756o33u6ubx', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-23 16:05:51.271787+00', '2026-09-24 01:58:57.341864+00', 'whjfxot7c6as', '1a6a5b46-adac-4a87-b6f2-b4c904d22d29'),
	('00000000-0000-0000-0000-000000000000', 357, 'btzsijzqfrzc', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-23 02:23:34.090066+00', '2026-09-24 02:08:15.302917+00', 'wycuthxoqr43', '277de953-3b21-44e7-a638-8042181ef513'),
	('00000000-0000-0000-0000-000000000000', 365, 'jqcfv4nx5n7j', 'afaa1119-7ccd-40ad-855b-8a711c864e42', false, '2026-09-24 02:41:32.065261+00', '2026-09-24 02:41:32.065261+00', NULL, 'e01c3362-1180-468a-93f6-2866d76dbcdb'),
	('00000000-0000-0000-0000-000000000000', 362, 'kyuyqzf5nayi', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-24 01:58:35.331717+00', '2026-09-24 02:56:52.925281+00', 'wjlubzti6xfu', 'e5a6ee72-7f15-4aeb-8475-ffb72f4b0c5c'),
	('00000000-0000-0000-0000-000000000000', 366, '7qx7nhqhf5tj', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-24 02:56:52.932872+00', '2026-09-24 03:54:53.332115+00', 'kyuyqzf5nayi', 'e5a6ee72-7f15-4aeb-8475-ffb72f4b0c5c'),
	('00000000-0000-0000-0000-000000000000', 364, 'txk7mrullzg6', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-24 02:08:15.312762+00', '2026-09-24 04:37:53.753973+00', 'btzsijzqfrzc', '277de953-3b21-44e7-a638-8042181ef513'),
	('00000000-0000-0000-0000-000000000000', 368, '3f6b3dc7egn3', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-24 04:37:53.768624+00', '2026-09-24 11:30:06.631182+00', 'txk7mrullzg6', '277de953-3b21-44e7-a638-8042181ef513'),
	('00000000-0000-0000-0000-000000000000', 369, 'zltghl4fhvxx', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-24 11:30:06.650448+00', '2026-09-24 12:36:57.71804+00', '3f6b3dc7egn3', '277de953-3b21-44e7-a638-8042181ef513'),
	('00000000-0000-0000-0000-000000000000', 367, 'zft4khg46bej', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-24 03:54:53.351857+00', '2026-09-25 21:56:52.586951+00', '7qx7nhqhf5tj', 'e5a6ee72-7f15-4aeb-8475-ffb72f4b0c5c'),
	('00000000-0000-0000-0000-000000000000', 363, 'x7szn7oaj3cy', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-09-24 01:58:57.343221+00', '2026-09-25 22:15:32.771116+00', 'q756o33u6ubx', '1a6a5b46-adac-4a87-b6f2-b4c904d22d29'),
	('00000000-0000-0000-0000-000000000000', 372, 'krngparu6nif', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-25 22:15:32.781231+00', '2026-09-25 22:15:32.781231+00', 'x7szn7oaj3cy', '1a6a5b46-adac-4a87-b6f2-b4c904d22d29'),
	('00000000-0000-0000-0000-000000000000', 373, 'gszsbqkrqb3m', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-09-25 22:15:43.019128+00', '2026-09-25 22:15:43.019128+00', NULL, 'c80785f6-c21e-44e9-9085-e19f5ee58e33'),
	('00000000-0000-0000-0000-000000000000', 385, 'sdnhapchu52d', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-10-09 20:59:28.902391+00', '2026-10-10 00:00:08.009918+00', 'nvfnpw5z6xat', 'de5a1f9d-c0d8-4fd8-bd12-9ad9cb5d4fd1'),
	('00000000-0000-0000-0000-000000000000', 386, 'ycs7npqnuin5', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-10-10 00:00:08.027624+00', '2026-10-10 16:27:09.93546+00', 'sdnhapchu52d', 'de5a1f9d-c0d8-4fd8-bd12-9ad9cb5d4fd1'),
	('00000000-0000-0000-0000-000000000000', 387, 'lxcbv67wboxw', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-10-10 16:27:09.95299+00', '2026-10-10 16:27:09.95299+00', 'ycs7npqnuin5', 'de5a1f9d-c0d8-4fd8-bd12-9ad9cb5d4fd1'),
	('00000000-0000-0000-0000-000000000000', 388, 'rscl5lttab6g', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-10-10 17:22:55.540578+00', '2026-10-11 03:33:40.243031+00', 't2bjtwa5fkv7', 'e5a6ee72-7f15-4aeb-8475-ffb72f4b0c5c'),
	('00000000-0000-0000-0000-000000000000', 389, 's6r27if65uxm', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-10-11 03:33:40.256551+00', '2026-10-11 08:30:43.746461+00', 'rscl5lttab6g', 'e5a6ee72-7f15-4aeb-8475-ffb72f4b0c5c'),
	('00000000-0000-0000-0000-000000000000', 395, 'reoz6d3jn6tb', '9f5a5fc7-3f06-4726-8f6e-1ddd43a74714', false, '2026-10-11 10:07:00.958186+00', '2026-10-11 10:07:00.958186+00', NULL, 'af08357c-1827-4ae7-b27c-650d5f9165ca'),
	('00000000-0000-0000-0000-000000000000', 391, 'mqcavu4leu6c', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-10-11 08:30:43.762604+00', '2026-10-11 17:46:05.007219+00', 's6r27if65uxm', 'e5a6ee72-7f15-4aeb-8475-ffb72f4b0c5c'),
	('00000000-0000-0000-0000-000000000000', 390, 'grbqflb4iwpg', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-10-11 03:33:53.70224+00', '2026-10-11 17:46:17.941572+00', 'ockh34eqszva', '814862f5-2c64-4b57-b906-eb524818dcc7'),
	('00000000-0000-0000-0000-000000000000', 397, '5owbgwqeo3lq', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-10-11 17:46:17.946439+00', '2026-10-11 17:46:17.946439+00', 'grbqflb4iwpg', '814862f5-2c64-4b57-b906-eb524818dcc7'),
	('00000000-0000-0000-0000-000000000000', 396, 'jzrfc36262b4', 'c2244e9d-689e-44d4-8767-005ce8764b56', true, '2026-10-11 17:46:05.024157+00', '2026-10-11 20:10:42.545303+00', 'mqcavu4leu6c', 'e5a6ee72-7f15-4aeb-8475-ffb72f4b0c5c'),
	('00000000-0000-0000-0000-000000000000', 398, 'gn3kktcwypzb', 'c2244e9d-689e-44d4-8767-005ce8764b56', false, '2026-10-11 20:10:42.559254+00', '2026-10-11 20:10:42.559254+00', 'jzrfc36262b4', 'e5a6ee72-7f15-4aeb-8475-ffb72f4b0c5c');


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: scim_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: scim_users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: app_content_labels; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."app_content_labels" ("label_key", "value", "updated_at") VALUES
	('podcast_eyebrow', 'Shows & Conversations', '2026-09-08 02:21:49.761749+00'),
	('podcast_title', '1-2-3 Podcast', '2026-09-08 02:21:49.761749+00'),
	('gear_eyebrow', 'Equipment & Fitting', '2026-09-08 02:21:49.761749+00'),
	('gear_title', 'Independent Gear Lab', '2026-09-08 02:21:49.761749+00'),
	('swingtype_unlimited_retakes', 'true', '2026-09-13 17:59:30.78075+00'),
	('swingtype_open_access_all_users', 'true', '2026-09-13 17:59:36.27072+00'),
	('podcast_featured_title', 'More Episodes', '2026-09-20 04:33:24.091194+00'),
	('gear_featured_title', 'More Gear Videos', '2026-09-20 04:33:24.091194+00'),
	('news_brief_feed_title', 'NEWS BRIEF FEED', '2026-09-20 07:06:00.673769+00'),
	('podcast_summary_title', 'Episode Summary', '2026-09-20 08:36:23.848434+00'),
	('gear_summary_title', 'Episode Summary', '2026-09-20 08:36:23.848434+00'),
	('social_instagram', 'https://www.instagram.com/Buko_Network', '2026-09-21 03:20:12.439+00'),
	('social_youtube', 'https://www.youtube.com/@buko_network?si=mt_z1udTqGcvmWmd', '2026-09-21 03:20:12.743+00'),
	('social_facebook', 'https://www.facebook.com/Buko.Network', '2026-09-21 03:20:12.933+00'),
	('social_x', '', '2026-09-21 03:20:13.133+00'),
	('social_tiktok', 'https://www.tiktok.com/@Buko_Network', '2026-09-21 03:20:13.331+00'),
	('social_linkedin', 'https://www.linkedin.com/in/buko-network-b614a9438', '2026-09-21 03:20:13.495+00'),
	('social_heading', 'FOLLOW US', '2026-09-21 03:20:13.635+00'),
	('podcast_eyebrow@78b718e1-689b-4eb2-8629-f330090db34c', 'Shows & Conversations', '2026-09-20 18:38:31.92+00'),
	('podcast_title@78b718e1-689b-4eb2-8629-f330090db34c', 'Podcast', '2026-09-20 18:38:32.254+00'),
	('podcast_featured_title@78b718e1-689b-4eb2-8629-f330090db34c', 'More Episodes', '2026-09-20 18:38:32.562+00'),
	('podcast_summary_title@78b718e1-689b-4eb2-8629-f330090db34c', 'Episode Summary', '2026-09-20 18:38:32.847+00'),
	('podcast_eyebrow@bbf203db-2c10-4e7d-86bd-8b9ad4977e37', 'Shows & Conversations', '2026-09-20 19:46:27.848+00'),
	('podcast_title@bbf203db-2c10-4e7d-86bd-8b9ad4977e37', 'Podcast', '2026-09-20 19:46:28.259+00'),
	('podcast_featured_title@bbf203db-2c10-4e7d-86bd-8b9ad4977e37', 'More Episodes', '2026-09-20 19:46:28.534+00'),
	('podcast_summary_title@bbf203db-2c10-4e7d-86bd-8b9ad4977e37', 'Episode Summary', '2026-09-20 19:46:28.895+00'),
	('summary_empty_text', 'No summary added yet.', '2026-09-20 08:36:23.848434+00');


--
-- Data for Name: news_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."news_categories" ("slug", "label", "sort_order", "is_active", "sport_id") VALUES
	('technology', '⚙️ Technology', 2, true, NULL),
	('featured', '🥤 Featured', 3, true, NULL),
	('news', '📰 News', 1, true, NULL);


--
-- Data for Name: sport_verticals; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."sport_verticals" ("sport_id", "slug", "display_name", "is_active", "created_at", "assessment_label", "banner_image_url", "status_badge_text", "is_launched", "cta_label", "admin_only", "lessons_tab_label", "fitness_tab_label", "lessons_headline", "fitness_headline", "lessons_preview_title", "fitness_preview_title", "lessons_preview_subtitle", "fitness_preview_subtitle") VALUES
	('bbf203db-2c10-4e7d-86bd-8b9ad4977e37', 'golf', 'Golf', true, '2026-08-30 12:11:04.399215+00', 'SwingType', 'https://r2-video-server.matrixoffice25.workers.dev/pro-voice/c2244e9d-689e-44d4-8767-005ce8764b56/285f5d9e-3b2b-4205-915d-1d841fa72c8e.jpg', 'Active Hub', true, NULL, false, 'Golf Lessons', 'Golf Fitness', '15-Min Swing Diagnostic', '15-Min Physical Fitness Screen', '', '', NULL, NULL),
	('78b718e1-689b-4eb2-8629-f330090db34c', 'pickleball', 'Pickleball', true, '2026-09-08 22:52:09.500568+00', 'Assessment', 'https://r2-video-server.matrixoffice25.workers.dev/pro-voice/c2244e9d-689e-44d4-8767-005ce8764b56/164a3c36-7c70-43f4-8637-f197a325efc2.jpg', 'Launching Q4 2026', false, 'Access Soon', true, 'Pickleball Lessons', 'Pickleball Fitness', 'Skills Diagnostic', 'Physical Fitness Screen', '', '', NULL, NULL);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."users" ("user_id", "display_name", "role", "active_sport_id", "photo_url", "created_at", "title", "inner_circle_access", "wallet_points", "last_point_awarded_at") VALUES
	('c0f0f4a2-8855-42ec-a887-c9deed1cfc95', 'test', 'inner_circle', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37', 'https://ommgauajjxsswemokuhc.supabase.co/storage/v1/object/public/avatars/c0f0f4a2-8855-42ec-a887-c9deed1cfc95/avatar.jpg?t=1788369798260', '2026-09-02 17:20:41.879343+00', 'Industry Expert', true, 1, '2026-09-02 17:20:42.633442+00'),
	('afaa1119-7ccd-40ad-855b-8a711c864e42', 'Terry Rowles', 'admin', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37', NULL, '2026-09-03 17:21:07.981806+00', 'Industry Expert', true, 2, '2026-09-03 17:21:09.195694+00'),
	('06ab125b-7a8c-478b-9eb5-ed50dd842d50', 'Vignesh K Murthy', 'inner_circle', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37', NULL, '2026-09-11 17:23:51.424477+00', NULL, false, 0, NULL),
	('c2244e9d-689e-44d4-8767-005ce8764b56', 'Samantha C', 'admin', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37', 'https://ommgauajjxsswemokuhc.supabase.co/storage/v1/object/public/avatars/c2244e9d-689e-44d4-8767-005ce8764b56/avatar.png?t=1788280118772', '2026-09-01 16:28:36.676282+00', 'Industry Expert', true, 4, '2026-09-03 17:35:03.717472+00'),
	('9f5a5fc7-3f06-4726-8f6e-1ddd43a74714', 'Pink Test Athlete', 'fan', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37', NULL, '2026-10-11 09:56:24.91068+00', NULL, false, 0, NULL);


--
-- Data for Name: articles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."articles" ("article_id", "sport_id", "category_slug", "title", "dek", "body_markdown", "cover_image_url", "author_name", "author_photo_url", "source_url", "read_minutes", "status", "is_cover_story", "is_featured", "published_at", "created_by", "created_at", "updated_at") VALUES
	('05a37128-c148-4372-a0a1-5d3f586e9780', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37', 'news', 'A Masterclass in Architecture: Mapping Out the Walker Cup''s Spectacular Future Venues .', NULL, 'As the dust settles on the Irish coast at Lahinch, amateur golf enthusiasts are already looking ahead to the next chapter of the Walker Cup. With the tournament returning to its traditional even-year rhythm, the biennial showcase of premier amateur talent is gearing up for a historic run of venues. For golf architecture purists, the upcoming schedule represents an absolute dream lineup.

The governing bodies have taken vastly different paths in mapping out the future. While the R&A has only confirmed its next overseas venue, the USGA has locked in its home sites all the way through 2052. This forward-looking slate of American hosts reads like a roll call of the greatest courses ever built.

The journey begins in 2028 on the rugged Oregon coast at Bandon Dunes. The resort''s original David McLay-Kidd design will host the matches, marking the tenth time the resort has welcomed a USGA championship. Two years later, the event crosses back over the Atlantic to England’s Prince’s Golf Club in Kent. Though it will be Prince’s first time hosting the Walker Cup, the historic links has a rich legacy, having previously hosted the 1932 Open Championship won by Gene Sarazen.

In 2032, the spotlight shifts to Oakmont Country Club in Pennsylvania. Fresh off hosting its tenth U.S. Open, Oakmont will welcome the Walker Cup for the first time, adding to a club legacy that includes Bobby Jones’s 1925 U.S. Amateur victory and legendary professional major triumphs.

By 2036, the matches head to Chicago Golf Club, a founding USGA member designed by C.B. Macdonald and refined by Seth Raynor. It was here in 2005 that Jeff Overton secured a dramatic American victory. Macdonald''s architectural genius will be on display again in 2040 at the National Golf Links of America in New York, which hosted the first Walker Cup in 1922 and saw a Justin Thomas-led American squad dominate in 2013.

The final stretch of the announced schedule features legendary layouts. In 2044, the Walker Cup returns to Pine Valley in New Jersey, widely regarded as the world''s finest course. It will be Pine Valley''s second time hosting, following the 1985 matches that featured future stars like Davis Love III.

In 2048, California''s Cypress Point Club will host for the third time, showcasing Alister Mackenzie’s breathtaking coastal design, including the famous back-to-back par-3s at the 15th and 16th. Finally, the confirmed schedule concludes in 2052 at Seminole Golf Club in Florida, where players will test their skills against Donald Ross''s legendary, complex greens.', 'https://r2-video-server.matrixoffice25.workers.dev/pro-voice/c2244e9d-689e-44d4-8767-005ce8764b56/b5f97887-08e9-44ea-bdd9-cb142c18ccaa.jpg', NULL, NULL, 'https://golf.com/travel/walker-cup-future-sites-beginning-2028/', 2, 'published', true, false, '2026-09-07 18:40:08.697+00', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-07 18:36:47.813889+00', '2026-09-07 18:36:47.813889+00'),
	('610ce7b9-3dd7-4a8f-90ac-de464ce6b395', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37', 'featured', 'Beyond the Bucket List: Embracing the Slow Road in Golf''s Newest World Rankings', NULL, 'For decades, the standard blueprint for an overseas golf trip has been a relentless sprint through target-rich environments. Eager players cross oceans to pack their itineraries with as many legendary names as possible, rushing from one marquee venue to the next. But as the newly released 2026-2027 edition of the World''s 100 Greatest Courses demonstrates, the true magic of golf travel often reveals itself when we finally decide to slow down.

Unsurprisingly, Northern Ireland’s iconic Royal County Down continues its reign at the absolute pinnacle, securing the No. 1 spot for the sixth consecutive ranking. Close behind are the historic layouts of the Old Course at St. Andrews at No. 2 and Muirfield at No. 3. While these legendary tracks deserve every bit of their global acclaim, focusing solely on the heavy hitters means missing out on the rich tapestry of the regions that surround them.

Consider the golfer who speeds through Scotland to play Muirfield and Royal Dornoch (No. 4) in a single week. By treating the journey as a race, they bypass incredible designs like Cruden Bay (No. 26) or the newly ranked Panmure Golf Club (No. 99). Panmure holds a special place in golf lore as the quiet links where Ben Hogan spent two weeks practicing before his historic 1953 Open Championship victory at Carnoustie. It is precisely these kinds of storied, character-rich courses that provide the most unforgettable memories.

This year''s ranking features 16 newcomers, many of which highlight the immense rewards of exploring off the beaten path. In the Caribbean, the breathtaking Point Hardy at Cabot Saint Lucia makes a spectacular debut at No. 23. In Ireland, the rugged and remote Carne enters the list at No. 63, proving that a long journey to the edge of the coast is well worth the effort. 

Even in highly concentrated golf destinations, there are hidden treasures waiting for those willing to linger. Travelers visiting Australia''s King Island to play the world-renowned Cape Wickham (No. 13) can now make the short trek south to experience Ocean Dunes, which debuts at No. 100 with its dramatic oceanfront opening stretch. Meanwhile, the London heathlands boast fresh representation with St. George''s Hill (No. 53) and West Sussex (No. 97) joining established giants like Sunningdale.

Ultimately, while securing a tee time at a top-ten venue is a worthy pursuit, the heart of the game is found in the unexpected. By stepping away from the tour buses and embracing a slower pace, golfers will find that the courses played with the fewest expectations often leave the deepest impressions.', 'https://r2-video-server.matrixoffice25.workers.dev/pro-voice/c2244e9d-689e-44d4-8767-005ce8764b56/3e3aed20-5215-4ebf-a2a9-71d6226fb191.jpg', NULL, NULL, 'https://www.golfdigest.com/story/worlds-100-greatest-golf-courses', 2, 'published', false, true, '2026-09-07 22:10:26.236+00', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-07 22:10:25.76247+00', '2026-09-07 22:10:25.76247+00'),
	('e9bbf15f-7774-44c0-9a20-ecb04c706f33', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37', 'news', 'Holding the Line: American Juniors Survive European Onslaught to Claim Solheim Cup Prelude', NULL, 'The stage at Bernardus Golf was set for a historic week of match play, and the rising stars of the junior game did not disappoint. In a thrilling preview of the upcoming Solheim Cup in the Netherlands, the American junior squad narrowly escaped a monumental European comeback to secure the 2026 Ping Junior Solheim Cup with a gritty 13-11 victory.

Entering Tuesday''s singles matches, the red, white, and blue seemed to have the trophy all but wrapped up. A masterful opening day on Monday saw the Americans build a commanding cushion, racking up 9.5 of the available 12 points across the foursomes and four-ball sessions. With only 2.5 points required from the 12 singles matches to retain their title, the final day appeared to be a mere formality.

However, match play is famously unpredictable, and the European contingent refused to go quietly on their home soil. The spark for the European resurgence came in the very first match of the day. Annabel Peaford delivered a massive statement by defeating Asterisk Talley, the reigning U.S. Women’s Amateur champion. That marquee victory injected belief into the European side, triggering a wave of blue and yellow across the leaderboard.

Europe fought tooth and nail, capturing a staggering 8.5 points during the singles matches to push the visitors to the absolute limit. Yet, despite the immense pressure of the European charge, the Americans found the critical points they needed to cross the finish line and preserve their lead.

With this hard-fought victory, the United States extends its historic dominance in the event, pushing its all-time series record to 9-4-1. Beyond the immediate drama, this year''s tournament marked a monumental milestone for junior golf. For the first time, the junior matches were contested on the exact same layout as the main Solheim Cup, giving these elite teenagers a taste of the grand stage just days before the professionals take over Bernardus Golf.

If history is any indication, many of the players who battled through Tuesday''s tense finish will soon be household names. The Junior Solheim Cup has long served as a breeding ground for future superstars, with alumni rosters boasting elite champions like Rose Zhang, Lexi Thompson, Linn Grant, Carlota Ciganda, and the Korda sisters. For the victorious Americans, surviving this European storm might just be the first of many triumphs on the global stage.', 'https://r2-video-server.matrixoffice25.workers.dev/pro-voice/c2244e9d-689e-44d4-8767-005ce8764b56/10cb605c-9b99-493e-916b-f7e582fb2a2d.jpg', NULL, NULL, 'https://sports.yahoo.com/articles/team-usa-withstands-europe-charge-130952393.html', 2, 'published', false, true, '2026-09-08 14:12:50.693+00', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-08 14:12:50.128904+00', '2026-09-08 14:12:50.128904+00'),
	('26d5c393-22e0-45a4-97d8-04f496a53622', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37', 'news', 'The Price of a Viral Misstep: Inside the Executive Exodus at Good Good Golf', NULL, 'The meteoric rise of Good Good Golf, the digital-first brand that spent the last six years redefining how younger generations engage with the sport, has hit a devastating wall. In the latest and most severe blow to the franchise, chief executive officer Matt Kendrick and president Joe Flannery have departed the organization, leaving a leadership vacuum at a company that was, until recently, one of the most lucrative success stories in modern golf media.

According to an internal staff memo from executive Alex Puchala, co-founder Nahid Giga will take over the reins as interim CEO. The executive shakeup is the direct result of a disastrous marketing campaign that has systematically dismantled the brand''s corporate relationships over the past month.

The catalyst for the collapse was a controversial promotional video featuring two of the brand''s prominent influencers, Garrett Clark and Alexis Miestowski. In the clip, Clark is seen physically shoving Miestowski to the ground as she attempts to reach for a new Callaway driver. The backlash was immediate and severe, with viewers condemning the video for depicting violence against women. Though both Good Good and Callaway quickly scrubbed the footage from their channels and issued apologies, the damage was already done.

Kendrick, who had guided the company since its 2020 inception as a YouTube channel, publicly accepted responsibility for the oversight but later claimed he had not approved or seen the video before its release. He also publicly criticized Callaway''s handling of the situation—a move that did little to mend fences.

The fallout has been a masterclass in swift corporate distancing. Callaway, which partnered with the group in 2023, severed its relationship entirely. Major national retailers, including Dick''s Sporting Goods and Golf Galaxy, quietly stripped Good Good merchandise from their shelves. 

Perhaps most damaging to the brand''s mainstream aspirations, the group was forced to withdraw from its title sponsorship of an upcoming PGA Tour event scheduled for November. Furthermore, Golf Channel scrapped its highly anticipated revival of the "Big Break" reality series, which had been produced in collaboration with the internet golf collective.

What began as a group of friends filming entertaining golf videos has transitioned into a stark lesson on the volatile nature of modern sports marketing. As Giga steps into the interim leadership role, the path forward for Good Good is no longer about generating clicks, but salvaging what remains of its corporate credibility.', NULL, NULL, NULL, 'https://www.espn.com/golf/story/_/id/49809270/report-good-good-golf-ceo-president-exit-ad-fallout', 2, 'published', false, false, '2026-09-08 22:43:09.217+00', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-08 22:43:09.100102+00', '2026-09-08 22:43:09.100102+00'),
	('bdd403f8-2ce5-428f-bb15-3792c01cdef6', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37', 'technology', 'KBS Expands V-X Lineup with Premium, High-Stability Tour V-X Steel Iron Shafts', NULL, 'KBS Golf Shafts has officially expanded its product catalog with the introduction of the Tour V-X, a brand-new steel iron shaft engineered specifically for players demanding high-level stability and pinpoint control. Designed to build on the brand''s reputation for classic performance, this latest offering targets golfers who want a robust profile without sacrificing responsiveness.

The construction of the Tour V-X features a carefully engineered profile: a firm butt section, a responsive midsection, and a highly stable tip. This specific combination is designed to optimize control through the hitting zone, delivering a consistent launch angle, a predictable trajectory, and tighter dispersion patterns on the course.

The Tour V-X joins the existing V-X family, sitting alongside the lighter Tour V-X Lite. However, players looking at the new Tour V-X can expect a lower-launching and lower-spinning profile than its Lite counterpart. KBS highlighted this transition in an introductory YouTube video, noting, "This is going to be a little bit firmer, because it’s a little bit heavier. If you like traditional feel in your golf shafts, you’ve tested that V-X Lite, you think it’s for you, but you want something a touch heavier, well, the V-X golf shaft is going to be your ticket."

Technologically, the shaft boasts impressive structural specifications. According to KBS, the "Weight-to-strength ratio is nearly 20% higher than any iron shaft ever designed…" This design philosophy focuses heavily on structural rigidity to improve accuracy. The manufacturer explains that "The shaft''s stiffness reduces the amplitude making the shaft straighter through out, but mainly at impact there is less distortion, less movement, allowing a truer flight, ‘not as effected by shaft bending.’"

To accommodate a wide array of player profiles and swing speeds, KBS is offering the Tour V-X in six different weight classifications: 105g, 110g, 115g, 120g, 125g, and 130g. Golfers can also choose from a variety of flex options, including R, R+, S, S+, X, and TX.

Priced at $69.95 per shaft, the Tour V-X represents a premium yet accessible upgrade for competitive players and equipment enthusiasts seeking to optimize their iron play.', 'https://r2-video-server.matrixoffice25.workers.dev/pro-voice/c2244e9d-689e-44d4-8767-005ce8764b56/dbe17e48-4159-473c-9410-db2f364b1118.jpg', NULL, NULL, 'https://golfwrx.com/785695/kbs-unveils-new-tour-v-x-shafts/', 2, 'published', false, true, '2026-09-08 22:47:07.958+00', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-08 22:47:07.639831+00', '2026-09-08 22:47:07.639831+00');


--
-- Data for Name: assessment_access_codes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: pro_posts; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: content_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: education_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."education_events" ("event_id", "sport_id", "title", "description", "participant_info", "host_name", "event_type", "price_cents", "cover_image_url", "is_locked", "status", "sort_order", "created_at", "updated_at", "payment_url", "payment_provider", "access_code", "event_datetime") VALUES
	('edef1ff3-4343-492e-9292-56791ae37cf0', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37', 'AimPoint Express', 'Feel the Slope - Trust the Line', 'Junior Golfers in New York', 'Alvin and the chipmunks', 'clinic', 20000, 'https://r2-video-server.matrixoffice25.workers.dev/pro-voice/c2244e9d-689e-44d4-8767-005ce8764b56/ab522e07-9ee1-4e01-9e05-72ba3c3acf20.jpg', true, 'published', 100, '2026-09-08 17:27:44.948293+00', '2026-09-09 00:13:28.695+00', NULL, 'stripe', '1234', '2026-09-14 20:00:00+00');


--
-- Data for Name: education_event_access; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: education_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."education_registrations" ("registration_id", "event_id", "user_id", "status", "registered_at", "full_name", "email", "phone") VALUES
	('a33f9b39-0b44-43a5-b415-3e35523d609b', 'edef1ff3-4343-492e-9292-56791ae37cf0', 'c0f0f4a2-8855-42ec-a887-c9deed1cfc95', 'cancelled', '2026-09-08 18:44:02.406098+00', NULL, NULL, NULL);


--
-- Data for Name: podcast_episodes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."podcast_episodes" ("episode_id", "youtube_video_id", "title", "created_at", "media_type", "is_active", "sport_id", "summary", "thumbnail_url") VALUES
	('9b2d644e-1d8f-48d4-9d32-94846bda7887', 'G9M6GTs_9mI', 'One of the ways to not stick your wedge into the ground', '2026-09-21 02:11:26.877694+00', 'podcast', true, 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37', 'A golfer demonstrates how body and club positioning affect a golf swing. He explains how pulling the chest up through the shot helps prevent the club from digging into the ground before hitting a ball across the green.', NULL);


--
-- Data for Name: episode_chapters; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: featured_items; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: news_briefs; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."news_briefs" ("brief_id", "title", "body", "source_url", "status", "created_at", "sport_id") VALUES
	('977b3777-5b94-4d33-8893-febd3943588a', 'Lawrence wins European Masters in playoff', 'Lawrence staged a successful rally to win the European Masters golf tournament following a playoff.', 'https://www.espn.com/golf/story/_/id/49850007/lawrence-rallies-beat-casey-european-masters-playoff', 'published', '2026-09-08 14:07:36.441888+00', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37'),
	('451551ab-7518-43df-9744-79c6cbd0f835', 'Tour Edge Releases Exotics Milled Wedges', 'Tour Edge has launched its new Exotics Milled wedges, designed for versatility and priced starting at $120. Featuring a 304 stainless steel construction, a milled face for high spin, and multiple sole options, the wedges offer strong performance in various turf conditions, according to a recent review.', 'https://golfwrx.com/785635/from-the-golfwrx-classifieds-scotty-cameron-studio-xperimental-limited-squareback-2/?utm_source=Front&utm_medium=Featured_Latest&utm_campaign=GolfWRX_OnSite&utm_content=unused', 'published', '2026-09-08 22:43:56.550211+00', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37');


--
-- Data for Name: polls; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."polls" ("poll_id", "sport_id", "question", "is_active", "created_by", "created_at", "priority") VALUES
	('fd2ec9cc-30b3-4843-9108-ce5337605299', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37', 'what is better?', true, 'afaa1119-7ccd-40ad-855b-8a711c864e42', '2026-09-03 17:29:07.310559+00', 2),
	('ffa0ba56-8e94-412a-a215-29b9ebf19ab5', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37', 'what is nice? 😊', true, 'afaa1119-7ccd-40ad-855b-8a711c864e42', '2026-09-03 22:20:57.175635+00', 1),
	('6834b4b4-b9a0-4dbf-92dd-66025f3f95c4', '78b718e1-689b-4eb2-8629-f330090db34c', 'next holiday', true, 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-08 23:57:52.063665+00', 1);


--
-- Data for Name: poll_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."poll_options" ("option_id", "poll_id", "label", "sort_order") VALUES
	('801fa256-b78d-4eee-9751-f1bdc322228c', 'fd2ec9cc-30b3-4843-9108-ce5337605299', 'red', 0),
	('1e24488a-17f4-42e7-bed6-b21f1f49a8da', 'fd2ec9cc-30b3-4843-9108-ce5337605299', 'blue', 1),
	('512195cd-4d00-4e9d-b0a5-1b8d1dfee7ba', 'ffa0ba56-8e94-412a-a215-29b9ebf19ab5', 'black', 0),
	('366482ad-45f2-4038-8a80-bbf258026d5b', 'ffa0ba56-8e94-412a-a215-29b9ebf19ab5', 'white', 1),
	('25624e59-fb65-4533-8d0c-b83a64743cca', '6834b4b4-b9a0-4dbf-92dd-66025f3f95c4', 'americas', 0),
	('741b7db0-1099-4679-a55e-c3142c8fcace', '6834b4b4-b9a0-4dbf-92dd-66025f3f95c4', 'europe', 1),
	('732dd676-9bf4-431c-bb23-8edd60805561', '6834b4b4-b9a0-4dbf-92dd-66025f3f95c4', 'africa', 2);


--
-- Data for Name: poll_votes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."poll_votes" ("poll_id", "user_id", "option_id", "voted_at") VALUES
	('fd2ec9cc-30b3-4843-9108-ce5337605299', 'afaa1119-7ccd-40ad-855b-8a711c864e42', '801fa256-b78d-4eee-9751-f1bdc322228c', '2026-09-03 17:29:23.610728+00'),
	('fd2ec9cc-30b3-4843-9108-ce5337605299', 'c2244e9d-689e-44d4-8767-005ce8764b56', '801fa256-b78d-4eee-9751-f1bdc322228c', '2026-09-03 17:35:22.653614+00'),
	('ffa0ba56-8e94-412a-a215-29b9ebf19ab5', 'afaa1119-7ccd-40ad-855b-8a711c864e42', '512195cd-4d00-4e9d-b0a5-1b8d1dfee7ba', '2026-09-03 22:22:09.679062+00'),
	('ffa0ba56-8e94-412a-a215-29b9ebf19ab5', 'c2244e9d-689e-44d4-8767-005ce8764b56', '366482ad-45f2-4038-8a80-bbf258026d5b', '2026-09-04 02:32:46.392424+00'),
	('ffa0ba56-8e94-412a-a215-29b9ebf19ab5', 'c0f0f4a2-8855-42ec-a887-c9deed1cfc95', '366482ad-45f2-4038-8a80-bbf258026d5b', '2026-09-07 19:49:19.228534+00'),
	('ffa0ba56-8e94-412a-a215-29b9ebf19ab5', '9f5a5fc7-3f06-4726-8f6e-1ddd43a74714', '512195cd-4d00-4e9d-b0a5-1b8d1dfee7ba', '2026-10-11 09:56:48.688656+00'),
	('fd2ec9cc-30b3-4843-9108-ce5337605299', '9f5a5fc7-3f06-4726-8f6e-1ddd43a74714', '801fa256-b78d-4eee-9751-f1bdc322228c', '2026-10-11 10:07:18.22983+00');


--
-- Data for Name: pro_post_reactions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: sponsor_placements; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."sponsor_placements" ("placement_id", "placement_key", "sport_id", "kind", "is_active", "sponsor_name", "logo_text", "logo_color", "eyebrow_label", "headline", "cta_label", "cta_url", "updated_at", "logo_image_url", "banner_image_url", "banner_max_height_px", "badge_width_px", "badge_height_px", "banner_max_width_px") VALUES
	('dfd27b27-436b-4fd4-941d-f2b54242acf6', 'stream_header_badge', NULL, 'badge', true, 'PULSE', 'PULSE', '#F40009', 'Supporter', NULL, NULL, NULL, '2026-09-07 04:10:58.040796+00', NULL, NULL, NULL, NULL, NULL, NULL),
	('29ef7901-8a7f-4d85-961f-b6f038d8094f', 'polls_header_badge', NULL, 'badge', true, 'PULSE', 'PULSE', '#F40009', 'Supporter', NULL, NULL, NULL, '2026-09-07 04:10:58.040796+00', NULL, NULL, NULL, NULL, NULL, NULL),
	('19dcb565-292d-4db9-905c-6099d49f6d29', 'podcast_header_badge', NULL, 'badge', true, 'PULSE', 'PULSE', '#F40009', 'Official Show Partner', NULL, NULL, NULL, '2026-09-07 04:10:58.040796+00', NULL, NULL, NULL, NULL, NULL, NULL),
	('7205940e-7bf7-4d9d-9dd5-df4040f76426', 'news_header_badge', NULL, 'badge', true, 'PULSE', 'PULSE', '#f40009', 'POWERED BY', NULL, NULL, NULL, '2026-09-07 04:10:58.040796+00', NULL, NULL, NULL, NULL, NULL, NULL),
	('6950e33a-dc0a-45f1-8c4e-6bb3a233f9ba', 'multisport_badge', NULL, 'badge', true, 'PULSE', 'PULSE', '#f40009', 'Multi-Sport Championship Series', NULL, NULL, NULL, '2026-09-07 14:00:45.28713+00', NULL, NULL, NULL, NULL, NULL, NULL),
	('0a20f061-e992-489b-a22a-663b55356ffb', 'podcast_banner', NULL, 'banner', true, 'PULSE', 'PULSE', '#F40009', 'Official Show Partner', NULL, NULL, NULL, '2026-09-07 04:10:58.040796+00', NULL, NULL, NULL, NULL, NULL, NULL),
	('e855018d-7a50-41db-99ae-99d7431796fe', 'equipment_banner', NULL, 'banner', true, 'PULSE', 'PULSE', '#F40009', 'Official Gear Partner', NULL, NULL, NULL, '2026-09-07 04:10:58.040796+00', NULL, NULL, NULL, NULL, NULL, NULL),
	('895b2375-7485-471f-b60b-6df9b9269aee', 'global_banner', NULL, 'banner', true, 'PULSE', 'PULSE', '#F40009', 'Official Global Partner', NULL, NULL, NULL, '2026-09-07 14:00:45.28713+00', NULL, NULL, NULL, NULL, NULL, NULL),
	('90e77fb0-a29d-457f-8798-81156a69151e', 'home_footer_banner', NULL, 'banner', true, 'PULSE', 'PULSE', '#F40009', 'Pulse Presenting Sponsor', NULL, NULL, NULL, '2026-09-08 18:33:46.710458+00', NULL, NULL, NULL, NULL, NULL, NULL),
	('1455454c-542b-4357-92c8-e4056957d4a9', 'lessons_tab_header_banner', NULL, 'banner', true, 'PULSE', 'PULSE', '#F40009', 'Pulse Presenting Sponsor', NULL, NULL, NULL, '2026-09-08 18:33:46.710458+00', NULL, NULL, NULL, NULL, NULL, NULL),
	('133fe845-70f9-4578-b807-626b7131c32a', 'fitness_tab_header_banner', NULL, 'banner', true, 'PULSE', 'PULSE', '#F40009', 'Partner Sponsor', NULL, NULL, NULL, '2026-09-08 18:33:46.710458+00', NULL, NULL, NULL, NULL, NULL, NULL),
	('d296df04-24e8-40e6-abf5-d9ec1f7657a2', 'sport_card_banner', '78b718e1-689b-4eb2-8629-f330090db34c', 'banner', true, 'PULSE', 'PULSE', '#f40009', 'Partner Sponsor', NULL, NULL, NULL, '2026-09-09 02:06:13.265716+00', NULL, 'https://r2-video-server.matrixoffice25.workers.dev/pro-voice/c2244e9d-689e-44d4-8767-005ce8764b56/3c617b1e-b0e0-4232-914e-e957af41b5a2.jpg', NULL, NULL, NULL, NULL),
	('8e1a5160-6317-491d-afc2-6290f7fe5455', 'lessons_card_banner', NULL, 'banner', true, 'PULSE', 'PULSE', '#f40009', 'Pulse Presenting Sponsor', NULL, NULL, NULL, '2026-09-08 12:57:06.162911+00', NULL, NULL, NULL, NULL, NULL, NULL),
	('129c70d0-d3fb-4c41-abd2-0f23253eff62', 'fitness_card_banner', '78b718e1-689b-4eb2-8629-f330090db34c', 'banner', true, 'PULSE', 'PULSE', '#f40009', 'Partner Sponsor', NULL, NULL, NULL, '2026-09-08 12:57:06.162911+00', NULL, NULL, NULL, NULL, NULL, NULL),
	('d7e39afa-e533-4ab1-90bc-e75ec6c09ea2', 'lessons_card_banner', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37', 'banner', true, 'PULSE', 'PULSE 1', '#f40009', 'Pulse Presenting Sponsor', NULL, NULL, NULL, '2026-09-08 12:28:44.459553+00', NULL, 'https://r2-video-server.matrixoffice25.workers.dev/pro-voice/c2244e9d-689e-44d4-8767-005ce8764b56/624d0bf2-c2ad-4ca1-bf28-df65e6c0f677.jpg', NULL, NULL, NULL, NULL),
	('cbbbc381-8d3a-4b5f-8362-a2a264105736', 'education_header_banner', NULL, 'banner', true, 'PULSE', 'PULSE', '#F40009', 'Presenting Partner', NULL, NULL, NULL, '2026-09-08 18:33:46.710458+00', NULL, NULL, NULL, NULL, NULL, NULL),
	('a781b159-c4fe-4317-9a73-5c9872e23f99', 'education_secondary_banner', NULL, 'banner', true, 'PULSE', 'PULSE', '#F40009', 'Partner Sponsor', NULL, NULL, NULL, '2026-09-08 18:33:46.710458+00', NULL, NULL, NULL, NULL, NULL, NULL),
	('5923c5a4-519b-45ce-b46e-7d9edd13be22', 'sport_card_banner', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37', 'banner', true, 'PULSE', 'PULSE', '#f40009', 'Partner Sponsor', NULL, NULL, NULL, '2026-09-08 18:33:46.710458+00', 'https://r2-video-server.matrixoffice25.workers.dev/pro-voice/c2244e9d-689e-44d4-8767-005ce8764b56/4fdac97c-f28a-4725-8f78-8a112c91e770.jpg', 'https://r2-video-server.matrixoffice25.workers.dev/pro-voice/c2244e9d-689e-44d4-8767-005ce8764b56/fe428040-99b6-4d75-9981-9cef92402ce7.jpg', NULL, NULL, NULL, NULL),
	('0379969e-2eca-4e76-9465-042cf084fa29', 'lessons_card_logo', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37', 'badge', true, 'PULSE', 'PULSE', '#f40009', NULL, NULL, NULL, NULL, '2026-09-09 21:15:17.767062+00', 'https://r2-video-server.matrixoffice25.workers.dev/pro-voice/c2244e9d-689e-44d4-8767-005ce8764b56/9da8b9d4-c0e5-4583-9920-aecd772d1981.png', NULL, NULL, NULL, NULL, NULL),
	('925544bf-b1b4-4407-8f02-ef6b781ec264', 'lessons_card_logo', '78b718e1-689b-4eb2-8629-f330090db34c', 'badge', true, 'PULSE', 'PULSE', '#f40009', NULL, NULL, NULL, NULL, '2026-09-09 21:13:56.896475+00', 'https://r2-video-server.matrixoffice25.workers.dev/pro-voice/c2244e9d-689e-44d4-8767-005ce8764b56/20d117bc-8bcb-4151-b4c6-58c6b2a3de5d.png', NULL, NULL, NULL, NULL, NULL),
	('4116e42d-a032-4b89-89c2-84d670956654', 'fitness_card_logo', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37', 'badge', true, 'PULSE', 'PULSE', '#f40009', NULL, NULL, NULL, NULL, '2026-09-09 21:52:53.850682+00', 'https://r2-video-server.matrixoffice25.workers.dev/pro-voice/c2244e9d-689e-44d4-8767-005ce8764b56/88763c51-1f0a-40cc-928c-1cb7925853f8.png', NULL, NULL, NULL, NULL, NULL),
	('c7c95b19-7076-425c-b68e-1d49d56b0850', 'equipment_header_badge', NULL, 'badge', true, 'PULSE', 'PULSE', '#f40009', NULL, NULL, NULL, NULL, '2026-09-07 04:10:58.040796+00', NULL, NULL, NULL, NULL, NULL, NULL),
	('9dafde46-57fd-48ff-b6c6-cf873ead6007', 'home_strip_top', NULL, 'banner', true, 'PULSE', 'PULSE', '#F40009', 'Pulse Presenting Sponsor', NULL, NULL, NULL, '2026-09-20 03:44:53.852169+00', NULL, NULL, NULL, NULL, NULL, NULL),
	('0b71ce8b-2b7b-48b0-a128-3c96a15ebc6a', 'lessons_strip', NULL, 'banner', true, 'PULSE', 'PULSE', '#F40009', 'Partner Sponsor', NULL, NULL, NULL, '2026-09-20 03:44:53.852169+00', NULL, NULL, NULL, NULL, NULL, NULL),
	('dab6b906-49e7-4795-801c-3acb0cfa236e', 'home_strip_bottom', NULL, 'banner', true, 'PULSE', 'PULSE', '#F40009', 'Partner Sponsor', NULL, NULL, NULL, '2026-09-20 03:44:53.852169+00', NULL, NULL, NULL, NULL, NULL, NULL),
	('de7bca87-f565-42a0-aa8a-d636a054fd5e', 'fitness_strip', NULL, 'banner', true, 'PULSE', 'PULSE', '#F40009', 'Partner Sponsor', NULL, NULL, NULL, '2026-09-20 03:44:53.852169+00', NULL, NULL, NULL, NULL, NULL, NULL),
	('2367be74-ba16-42c3-8c21-0fa991c107af', 'profile_vip_banner', NULL, 'banner', true, 'PULSE', 'PULSE', '#F40009', 'Official Show Partner', NULL, NULL, NULL, '2026-09-20 03:44:53.852169+00', NULL, NULL, NULL, NULL, NULL, NULL),
	('4048a241-c6d0-4333-8432-125a90586f3f', 'multisport_header_banner', NULL, 'banner', true, 'PULSE', 'PULSE', '#F40009', 'Official Multi-Sport Partner', NULL, NULL, NULL, '2026-09-20 03:44:53.852169+00', NULL, NULL, NULL, NULL, NULL, NULL),
	('d0bfed9a-6ddc-4547-b793-a915ff018748', 'news_footer_banner', NULL, 'banner', true, 'PULSE', 'PULSE', '#f40009', 'Presenting Partner', NULL, NULL, NULL, '2026-09-08 18:33:46.710458+00', NULL, NULL, NULL, NULL, NULL, NULL),
	('0d61cb78-610f-431d-a4d6-187067fb560f', 'news_inline_banner', NULL, 'banner', true, 'PULSE', 'PULSE', '#f40009', 'Official Show Partner', NULL, NULL, NULL, '2026-09-07 19:35:48.668295+00', 'https://r2-video-server.matrixoffice25.workers.dev/pro-voice/c2244e9d-689e-44d4-8767-005ce8764b56/ea962cf1-8f66-43c8-89de-4731660d6d5a.jpg', NULL, NULL, NULL, NULL, NULL),
	('6749b70e-b465-4cbd-a507-dc699273a0e5', 'fitness_card_banner', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37', 'banner', true, 'PULSE', 'PULSE', '#f40009', 'Partner Sponsor', NULL, NULL, NULL, '2026-09-08 12:28:44.459553+00', NULL, 'https://r2-video-server.matrixoffice25.workers.dev/pro-voice/c2244e9d-689e-44d4-8767-005ce8764b56/572cfb96-e05d-4fdf-a890-a6d05976b692.jpg', NULL, NULL, NULL, NULL);


--
-- Data for Name: subscriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: title_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."title_requests" ("request_id", "user_id", "requested_title", "status", "created_at", "reviewed_at", "reviewed_by") VALUES
	('67f18bba-a7d0-4609-9a39-928a2f8d38c5', 'c2244e9d-689e-44d4-8767-005ce8764b56', 'Industry Expert', 'approved', '2026-09-20 06:48:42.164551+00', '2026-09-20 07:03:01.711+00', 'c2244e9d-689e-44d4-8767-005ce8764b56');


--
-- Data for Name: translations_cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."translations_cache" ("source_hash", "lang", "source_text", "translated", "reviewed", "created_at") VALUES
	('5ff9c56b1ba01dad7a088d387b8e8e609b220a3e6f0aebaf96e56456fff9f501', 'es', 'Diagnostic Assessment', 'Evaluación diagnóstica', false, '2026-09-21 04:50:47.298802+00'),
	('70f804a801a1ce7a10f896c90037b440ae038c79e9bd3a7c6a1224a4f02e3160', 'es', 'Step 2 of 8', 'Paso 2 de 8', false, '2026-09-21 04:50:47.298802+00'),
	('d5d711b093c2d05a9a8d2533bd74477f65aef6922ad64d2dd9f7f31e544b6a10', 'es', 'Take your golf posture. With your hands together, move your hands away from the target, allowing your trail arm to fold in a relaxed, natural manner. How does your elbow move relative to the seam of your shirt?', 'Adopta tu postura de golf. Con las manos juntas, aleja las manos del objetivo, permitiendo que tu brazo posterior se flexione de manera relajada y natural. ¿Cómo se mueve tu codo en relación con la costura de tu camisa?', false, '2026-09-21 04:50:47.298802+00'),
	('b49351215af2c14151f686c27f194fdc972f6d7a616381bfe7e55b048a264ad5', 'es', 'Arm fold video guide', 'Guía en video de la flexión del brazo', false, '2026-09-21 04:50:47.298802+00'),
	('a6c33624f1fd04307f8d0e1835b516b0803e991c565aa799a9b0bd2aa30b458a', 'es', 'On Top', 'Por encima', false, '2026-09-21 04:50:47.298802+00'),
	('c1d18e245250ace0704a6f3828fdf10828949a8933a048c2e3ef12ef4aedcacf', 'es', 'The elbow moves behind your shirt seam.', 'El codo se mueve por detrás de la costura de tu camisa.', false, '2026-09-21 04:50:47.298802+00'),
	('a9a7dd0d3f39014e7ac54cc619f226e96d2b251f338924480d924f4c61743ba9', 'es', 'Side On', 'De lado', false, '2026-09-21 04:50:47.298802+00'),
	('0b623ef9894b532a4933d8a0ace975d62f172e5c06209cf28bf8072695066ec9', 'es', 'The elbow moves to your shirt seam.', 'El codo se mueve hacia la costura de tu camisa.', false, '2026-09-21 04:50:47.298802+00'),
	('80e4ad056bd7eb907b42aac6795f2295df87a1bd9a196ea0ff1dd3eb11fabf8b', 'es', 'Under', 'Por debajo', false, '2026-09-21 04:50:47.298802+00'),
	('1c16d93fc12b55bbe74eeabc078c507caed3838646b4dce8644a57dcbb6c25f4', 'es', 'The elbow stays in front of your shirt seam.', 'El codo se mantiene delante de la costura de tu camisa.', false, '2026-09-21 04:50:47.298802+00'),
	('76900f1bfd16c8d4dd3d25e6f46638d7165aee23883ccea6bfe071c514421769', 'es', 'Back', 'Atrás', false, '2026-09-21 04:50:47.298802+00'),
	('598ad7d632e97c595deca72a610e2d8e93cbb48239465b8bcafc4849ce3ff118', 'es', 'Step 4 of 8', 'Paso 4 de 8', false, '2026-09-21 04:50:52.946655+00'),
	('6b9ad0113789b55669645d333280565aca27dd0913a61222edbac1bf418964a4', 'es', 'How does your total wingspan (fingertip to fingertip) compare to your overall height?', '¿Cómo se compara tu envergadura total (de punta a punta de los dedos) con tu altura total?', false, '2026-09-21 04:50:52.946655+00'),
	('fea031c6dd724d3c2c74c95aa6720518343a7198dddd6225d068af402b4c53f0', 'es', 'Wingspan video guide', 'Guía en video de la envergadura', false, '2026-09-21 04:50:52.946655+00'),
	('f6ca7027c1c3cee09c8524acf0eaa65ffddb739c9a44107f6df4c0cc0104d279', 'es', 'Longer Wingspan', 'Envergadura más larga', false, '2026-09-21 04:50:52.946655+00'),
	('1b45d909a441fbc9e496f783a894019684daf67d1a5debb3020849cd070aa8e8', 'es', 'Your wingspan reaches further than your height.', 'Tu envergadura llega más lejos que tu altura.', false, '2026-09-21 04:50:52.946655+00'),
	('2a98b1deb68c7223d1367ad0671045f6835d960785aa24ebf18a69d64900cd42', 'es', 'Same', 'Igual', false, '2026-09-21 04:50:52.946655+00'),
	('0567f479fa4624610039edd9c332e459981235dce4a769086bc6d5b37028da96', 'es', 'Your wingspan is about equal to your height.', 'Tu envergadura es aproximadamente igual a tu altura.', false, '2026-09-21 04:50:52.946655+00'),
	('c73cf0ea2e7d9dcfd6c566e8a64a1f108ef5cc9fbaabfd956c35140f219cb69d', 'es', 'Shorter Wingspan', 'Envergadura más corta', false, '2026-09-21 04:50:52.946655+00'),
	('41ddb82a5917bf20782be92ce92ab7e5fc57dcb2769bde366bf0d01ba1fdba43', 'es', 'Your wingspan is shorter than your height.', 'Tu envergadura es más corta que tu altura.', false, '2026-09-21 04:50:52.946655+00'),
	('5ff9c56b1ba01dad7a088d387b8e8e609b220a3e6f0aebaf96e56456fff9f501', 'de', 'Diagnostic Assessment', 'Diagnostische Bewertung', false, '2026-09-21 04:52:16.269318+00'),
	('70f804a801a1ce7a10f896c90037b440ae038c79e9bd3a7c6a1224a4f02e3160', 'de', 'Step 2 of 8', 'Schritt 2 von 8', false, '2026-09-21 04:52:16.269318+00'),
	('d5d711b093c2d05a9a8d2533bd74477f65aef6922ad64d2dd9f7f31e544b6a10', 'de', 'Take your golf posture. With your hands together, move your hands away from the target, allowing your trail arm to fold in a relaxed, natural manner. How does your elbow move relative to the seam of your shirt?', 'Nehmen Sie Ihre Golfhaltung ein. Bewegen Sie Ihre Hände zusammen vom Ziel weg und lassen Sie Ihren hinteren Arm sich auf entspannte, natürliche Weise beugen. Wie bewegt sich Ihr Ellbogen im Verhältnis zur Naht Ihres Shirts?', false, '2026-09-21 04:52:16.269318+00'),
	('b49351215af2c14151f686c27f194fdc972f6d7a616381bfe7e55b048a264ad5', 'de', 'Arm fold video guide', 'Videoanleitung zur Armbeugung', false, '2026-09-21 04:52:16.269318+00'),
	('a6c33624f1fd04307f8d0e1835b516b0803e991c565aa799a9b0bd2aa30b458a', 'de', 'On Top', 'On Top', false, '2026-09-21 04:52:16.269318+00'),
	('c1d18e245250ace0704a6f3828fdf10828949a8933a048c2e3ef12ef4aedcacf', 'de', 'The elbow moves behind your shirt seam.', 'Der Ellbogen bewegt sich hinter Ihre Shirt-Naht.', false, '2026-09-21 04:52:16.269318+00'),
	('a9a7dd0d3f39014e7ac54cc619f226e96d2b251f338924480d924f4c61743ba9', 'de', 'Side On', 'Side On', false, '2026-09-21 04:52:16.269318+00'),
	('0b623ef9894b532a4933d8a0ace975d62f172e5c06209cf28bf8072695066ec9', 'de', 'The elbow moves to your shirt seam.', 'Der Ellbogen bewegt sich zu Ihrer Shirt-Naht.', false, '2026-09-21 04:52:16.269318+00'),
	('80e4ad056bd7eb907b42aac6795f2295df87a1bd9a196ea0ff1dd3eb11fabf8b', 'de', 'Under', 'Under', false, '2026-09-21 04:52:16.269318+00'),
	('1c16d93fc12b55bbe74eeabc078c507caed3838646b4dce8644a57dcbb6c25f4', 'de', 'The elbow stays in front of your shirt seam.', 'Der Ellbogen bleibt vor Ihrer Shirt-Naht.', false, '2026-09-21 04:52:16.269318+00'),
	('76900f1bfd16c8d4dd3d25e6f46638d7165aee23883ccea6bfe071c514421769', 'de', 'Back', 'Zurück', false, '2026-09-21 04:52:16.269318+00'),
	('5ff9c56b1ba01dad7a088d387b8e8e609b220a3e6f0aebaf96e56456fff9f501', 'fr', 'Diagnostic Assessment', 'Évaluation diagnostique', false, '2026-09-21 04:52:57.001919+00'),
	('70f804a801a1ce7a10f896c90037b440ae038c79e9bd3a7c6a1224a4f02e3160', 'fr', 'Step 2 of 8', 'Étape 2 sur 8', false, '2026-09-21 04:52:57.001919+00'),
	('d5d711b093c2d05a9a8d2533bd74477f65aef6922ad64d2dd9f7f31e544b6a10', 'fr', 'Take your golf posture. With your hands together, move your hands away from the target, allowing your trail arm to fold in a relaxed, natural manner. How does your elbow move relative to the seam of your shirt?', 'Prenez votre posture de golf. Les mains jointes, éloignez vos mains de la cible, en laissant votre bras arrière se plier de manière détendue et naturelle. Comment votre coude se déplace-t-il par rapport à la couture de votre chemise ?', false, '2026-09-21 04:52:57.001919+00'),
	('b49351215af2c14151f686c27f194fdc972f6d7a616381bfe7e55b048a264ad5', 'fr', 'Arm fold video guide', 'Guide vidéo sur le pliage du bras', false, '2026-09-21 04:52:57.001919+00'),
	('a6c33624f1fd04307f8d0e1835b516b0803e991c565aa799a9b0bd2aa30b458a', 'fr', 'On Top', 'Au-dessus', false, '2026-09-21 04:52:57.001919+00'),
	('c1d18e245250ace0704a6f3828fdf10828949a8933a048c2e3ef12ef4aedcacf', 'fr', 'The elbow moves behind your shirt seam.', 'Le coude se déplace derrière la couture de votre chemise.', false, '2026-09-21 04:52:57.001919+00'),
	('a9a7dd0d3f39014e7ac54cc619f226e96d2b251f338924480d924f4c61743ba9', 'fr', 'Side On', 'Sur le côté', false, '2026-09-21 04:52:57.001919+00'),
	('0b623ef9894b532a4933d8a0ace975d62f172e5c06209cf28bf8072695066ec9', 'fr', 'The elbow moves to your shirt seam.', 'Le coude se déplace vers la couture de votre chemise.', false, '2026-09-21 04:52:57.001919+00'),
	('80e4ad056bd7eb907b42aac6795f2295df87a1bd9a196ea0ff1dd3eb11fabf8b', 'fr', 'Under', 'En dessous', false, '2026-09-21 04:52:57.001919+00'),
	('1c16d93fc12b55bbe74eeabc078c507caed3838646b4dce8644a57dcbb6c25f4', 'fr', 'The elbow stays in front of your shirt seam.', 'Le coude reste devant la couture de votre chemise.', false, '2026-09-21 04:52:57.001919+00'),
	('76900f1bfd16c8d4dd3d25e6f46638d7165aee23883ccea6bfe071c514421769', 'fr', 'Back', 'Retour', false, '2026-09-21 04:52:57.001919+00'),
	('31fad3e58ddda66404e9f9d6e50f12452fb4ab29b03495c13dd71fe45465b10b', 'pt', 'Trail Shoulder Mobility Screen', 'Avaliação de Mobilidade do Ombro Posterior', false, '2026-09-23 02:28:06.822873+00'),
	('cbdaaa500624783e2975643a94ec3f4e0133af8720373056a518712623582d85', 'id', 'A golfer demonstrates how body and club positioning affect a golf swing. He explains how pulling the chest up through the shot helps prevent the club from digging into the ground before hitting a ball across the green.', 'Seorang pegolf mendemonstrasikan bagaimana posisi tubuh dan stik golf memengaruhi ayunan golf. Ia menjelaskan bagaimana menarik dada ke atas saat melakukan pukulan membantu mencegah stik golf menancap ke dalam tanah sebelum memukul bola melintasi green.', false, '2026-09-21 05:25:48.774903+00'),
	('cbdaaa500624783e2975643a94ec3f4e0133af8720373056a518712623582d85', 'de', 'A golfer demonstrates how body and club positioning affect a golf swing. He explains how pulling the chest up through the shot helps prevent the club from digging into the ground before hitting a ball across the green.', 'Ein Golfer demonstriert, wie die Körper- und Schlägerpositionierung einen Golfschwung beeinflusst. Er erklärt, wie das Aufrichten der Brust während des Schlags dazu beiträgt, zu verhindern, dass sich der Schläger in den Boden eingräbt, bevor ein Ball über das Grün geschlagen wird.', false, '2026-09-21 05:26:01.885503+00'),
	('cbdaaa500624783e2975643a94ec3f4e0133af8720373056a518712623582d85', 'pt', 'A golfer demonstrates how body and club positioning affect a golf swing. He explains how pulling the chest up through the shot helps prevent the club from digging into the ground before hitting a ball across the green.', 'Um golfista demonstra como o posicionamento do corpo e do taco afeta o swing de golfe. Ele explica como puxar o peito para cima durante a tacada ajuda a evitar que o taco cave o chão antes de bater na bola através do green.', false, '2026-09-21 05:26:20.508055+00'),
	('5ff9c56b1ba01dad7a088d387b8e8e609b220a3e6f0aebaf96e56456fff9f501', 'hi', 'Diagnostic Assessment', 'नैदानिक मूल्यांकन', false, '2026-09-21 05:27:35.476441+00'),
	('e003e9b4fa45c9e17c6a0598ffed7997826aa0c485209298b53305cb799cab71', 'hi', 'Step 1 of 8', '8 में से चरण 1', false, '2026-09-21 05:27:35.476441+00'),
	('6c313f2f8f47ec8c1c5fb2113f6717669a12150d40b34fb63faf8d57407f2b95', 'hi', 'Discover Your Biomechanical SwingType', 'अपने बायोमैकेनिकल SwingType की खोज करें', false, '2026-09-21 05:27:35.476441+00'),
	('bccf291b9b96049583b9cca4ff46658c364aae8a6a7f3e803bbfc754c3ce416e', 'hi', 'Five short questions map your natural movement to one of 9 deterministic profiles, plus a full setup report.', 'पाँच छोटे प्रश्न आपके प्राकृतिक मूवमेंट को 9 नियतात्मक प्रोफाइलों में से एक से मैप करते हैं, साथ ही एक पूर्ण सेटअप रिपोर्ट।', false, '2026-09-21 05:27:35.476441+00'),
	('6e83dd7bdf2942fb74d5e0e565689433fc35d7dd55fa8ebf9fc488904de36c4c', 'hi', 'Intro video guide', 'इंट्रो वीडियो गाइड', false, '2026-09-21 05:27:35.476441+00'),
	('7b18dfb8422821cf2cda73caa4a985764b8481ebdcc9ffc3069b5a7e721b8d14', 'hi', 'Begin Assessment', 'मूल्यांकन शुरू करें', false, '2026-09-21 05:27:35.476441+00'),
	('76900f1bfd16c8d4dd3d25e6f46638d7165aee23883ccea6bfe071c514421769', 'hi', 'Back', 'वापस', false, '2026-09-21 05:27:35.476441+00'),
	('5ff9c56b1ba01dad7a088d387b8e8e609b220a3e6f0aebaf96e56456fff9f501', 'zh-Hans', 'Diagnostic Assessment', '诊断评估', false, '2026-09-21 05:27:44.120023+00'),
	('e003e9b4fa45c9e17c6a0598ffed7997826aa0c485209298b53305cb799cab71', 'zh-Hans', 'Step 1 of 8', '第 1 步，共 8 步', false, '2026-09-21 05:27:44.120023+00'),
	('6c313f2f8f47ec8c1c5fb2113f6717669a12150d40b34fb63faf8d57407f2b95', 'zh-Hans', 'Discover Your Biomechanical SwingType', '探索您的生物力学 SwingType', false, '2026-09-21 05:27:44.120023+00'),
	('bccf291b9b96049583b9cca4ff46658c364aae8a6a7f3e803bbfc754c3ce416e', 'zh-Hans', 'Five short questions map your natural movement to one of 9 deterministic profiles, plus a full setup report.', '五个简短的问题将您的自然动作映射到 9 种确定性配置文件之一，并附带一份完整的设置报告。', false, '2026-09-21 05:27:44.120023+00'),
	('6e83dd7bdf2942fb74d5e0e565689433fc35d7dd55fa8ebf9fc488904de36c4c', 'zh-Hans', 'Intro video guide', '介绍视频指南', false, '2026-09-21 05:27:44.120023+00'),
	('7b18dfb8422821cf2cda73caa4a985764b8481ebdcc9ffc3069b5a7e721b8d14', 'zh-Hans', 'Begin Assessment', '开始评估', false, '2026-09-21 05:27:44.120023+00'),
	('76900f1bfd16c8d4dd3d25e6f46638d7165aee23883ccea6bfe071c514421769', 'zh-Hans', 'Back', '返回', false, '2026-09-21 05:27:44.120023+00'),
	('70f804a801a1ce7a10f896c90037b440ae038c79e9bd3a7c6a1224a4f02e3160', 'hi', 'Step 2 of 8', '8 में से चरण 2', false, '2026-09-21 05:27:49.056522+00'),
	('d5d711b093c2d05a9a8d2533bd74477f65aef6922ad64d2dd9f7f31e544b6a10', 'hi', 'Take your golf posture. With your hands together, move your hands away from the target, allowing your trail arm to fold in a relaxed, natural manner. How does your elbow move relative to the seam of your shirt?', 'अपनी गोल्फ मुद्रा अपनाएं। अपने दोनों हाथों को एक साथ रखते हुए, अपने हाथों को लक्ष्य से दूर ले जाएं, जिससे आपकी ट्रेल आर्म (पीछे वाली बांह) आराम से, स्वाभाविक रूप से मुड़ सके। आपकी शर्ट की सिलाई के संबंध में आपकी कोहनी कैसे चलती है?', false, '2026-09-21 05:27:49.056522+00'),
	('b49351215af2c14151f686c27f194fdc972f6d7a616381bfe7e55b048a264ad5', 'hi', 'Arm fold video guide', 'आर्म फोल्ड वीडियो गाइड', false, '2026-09-21 05:27:49.056522+00'),
	('a6c33624f1fd04307f8d0e1835b516b0803e991c565aa799a9b0bd2aa30b458a', 'hi', 'On Top', 'ऊपर', false, '2026-09-21 05:27:49.056522+00'),
	('c1d18e245250ace0704a6f3828fdf10828949a8933a048c2e3ef12ef4aedcacf', 'hi', 'The elbow moves behind your shirt seam.', 'कोहनी आपकी शर्ट की सिलाई के पीछे चली जाती है।', false, '2026-09-21 05:27:49.056522+00'),
	('a9a7dd0d3f39014e7ac54cc619f226e96d2b251f338924480d924f4c61743ba9', 'hi', 'Side On', 'साइड ऑन', false, '2026-09-21 05:27:49.056522+00'),
	('0b623ef9894b532a4933d8a0ace975d62f172e5c06209cf28bf8072695066ec9', 'hi', 'The elbow moves to your shirt seam.', 'कोहनी आपकी शर्ट की सिलाई तक जाती है।', false, '2026-09-21 05:27:49.056522+00'),
	('80e4ad056bd7eb907b42aac6795f2295df87a1bd9a196ea0ff1dd3eb11fabf8b', 'hi', 'Under', 'नीचे', false, '2026-09-21 05:27:49.056522+00'),
	('1c16d93fc12b55bbe74eeabc078c507caed3838646b4dce8644a57dcbb6c25f4', 'hi', 'The elbow stays in front of your shirt seam.', 'कोहनी आपकी शर्ट की सिलाई के सामने रहती है।', false, '2026-09-21 05:27:49.056522+00'),
	('6a7ac9b6d0bbb8513f9942be174a2a54ba9cddff71da2f9386aa566873ac9c40', 'de', 'Step 3 of 8', 'Schritt 3 von 8', false, '2026-09-21 05:27:59.858374+00'),
	('d4b91aa2d75addcf19d80a2cd610b724528d8cb25f468597d593a42deecf3ea2', 'de', 'If you think of your pelvis like a gate and your hips like gate posts, how does your pelvis turn look?', 'Wenn du dir dein Becken wie ein Tor und deine Hüften wie Torpfosten vorstellst, wie sieht deine Beckendrehung aus?', false, '2026-09-21 05:27:59.858374+00'),
	('ca7d5d7314a29ba7cecab076808c5a1f75222a4044241ae33fadacbf446c0295', 'de', 'Lower body post video guide', 'Video-Anleitung zu den Unterkörper-Pfosten', false, '2026-09-21 05:27:59.858374+00'),
	('0afe78a9d2086135ed16542c94a6d86f3b7b3e15142cc6c61807afeeb201c9b0', 'de', 'Rear Post', 'Hinterer Pfosten', false, '2026-09-21 05:27:59.858374+00'),
	('6f6cf2624ff47e551f1cfbea44c8a81785a622ace289bcf842e74699f51e4cfa', 'de', 'You rotate around your trail hip joint.', 'Du rotierst um dein hinteres Hüftgelenk.', false, '2026-09-21 05:27:59.858374+00'),
	('94e8be41f57e6e00e1373c31e24359fa7aaeec450e2faa32c51bd982bf6112b0', 'de', 'Center Post', 'Mittlerer Pfosten', false, '2026-09-21 05:27:59.858374+00'),
	('65e3c3a258f082b24423550826a5ca28243807fa13cc8f8b28436f5537c8aeab', 'de', 'You have a centered pivot; the pelvis rotates in the center of your stance.', 'Du hast einen zentrierten Drehpunkt; das Becken rotiert in der Mitte deines Stands.', false, '2026-09-21 05:27:59.858374+00'),
	('786c84cb64f7df5f0103abceffa8a32edb4e993b74c2e95bcc1428e1329685d2', 'de', 'Front Post', 'Vorderer Pfosten', false, '2026-09-21 05:27:59.858374+00'),
	('d5e96ce8fd9998dcdb5fde6255d43fd77ae4e9ec93e98692accc2cd2569857e8', 'de', 'Your pelvis rotates around your lead hip.', 'Dein Becken rotiert um deine vordere Hüfte.', false, '2026-09-21 05:27:59.858374+00'),
	('5ff9c56b1ba01dad7a088d387b8e8e609b220a3e6f0aebaf96e56456fff9f501', 'pt', 'Diagnostic Assessment', 'Avaliação Diagnóstica', false, '2026-09-21 05:28:38.350944+00'),
	('6a7ac9b6d0bbb8513f9942be174a2a54ba9cddff71da2f9386aa566873ac9c40', 'pt', 'Step 3 of 8', 'Passo 3 de 8', false, '2026-09-21 05:28:38.350944+00'),
	('d4b91aa2d75addcf19d80a2cd610b724528d8cb25f468597d593a42deecf3ea2', 'pt', 'If you think of your pelvis like a gate and your hips like gate posts, how does your pelvis turn look?', 'Se você pensar na sua pelve como um portão e nos seus quadris como os pilares do portão, como é o giro da sua pelve?', false, '2026-09-21 05:28:38.350944+00'),
	('ca7d5d7314a29ba7cecab076808c5a1f75222a4044241ae33fadacbf446c0295', 'pt', 'Lower body post video guide', 'Guia em vídeo do pilar da parte inferior do corpo', false, '2026-09-21 05:28:38.350944+00'),
	('0afe78a9d2086135ed16542c94a6d86f3b7b3e15142cc6c61807afeeb201c9b0', 'pt', 'Rear Post', 'Pilar Traseiro', false, '2026-09-21 05:28:38.350944+00'),
	('6f6cf2624ff47e551f1cfbea44c8a81785a622ace289bcf842e74699f51e4cfa', 'pt', 'You rotate around your trail hip joint.', 'Você rotaciona em torno da articulação do seu quadril de trás.', false, '2026-09-21 05:28:38.350944+00'),
	('94e8be41f57e6e00e1373c31e24359fa7aaeec450e2faa32c51bd982bf6112b0', 'pt', 'Center Post', 'Pilar Central', false, '2026-09-21 05:28:38.350944+00'),
	('65e3c3a258f082b24423550826a5ca28243807fa13cc8f8b28436f5537c8aeab', 'pt', 'You have a centered pivot; the pelvis rotates in the center of your stance.', 'Você tem um pivô centralizado; a pelve rotaciona no centro da sua postura.', false, '2026-09-21 05:28:38.350944+00'),
	('786c84cb64f7df5f0103abceffa8a32edb4e993b74c2e95bcc1428e1329685d2', 'pt', 'Front Post', 'Pilar Frontal', false, '2026-09-21 05:28:38.350944+00'),
	('d5e96ce8fd9998dcdb5fde6255d43fd77ae4e9ec93e98692accc2cd2569857e8', 'pt', 'Your pelvis rotates around your lead hip.', 'Sua pelve rotaciona em torno do seu quadril da frente.', false, '2026-09-21 05:28:38.350944+00'),
	('76900f1bfd16c8d4dd3d25e6f46638d7165aee23883ccea6bfe071c514421769', 'pt', 'Back', 'Voltar', false, '2026-09-21 05:28:38.350944+00'),
	('cbdaaa500624783e2975643a94ec3f4e0133af8720373056a518712623582d85', 'fr', 'A golfer demonstrates how body and club positioning affect a golf swing. He explains how pulling the chest up through the shot helps prevent the club from digging into the ground before hitting a ball across the green.', 'Un golfeur démontre comment le positionnement du corps et du club affecte le swing de golf. Il explique comment le fait de redresser la poitrine tout au long du coup aide à éviter que le club ne s''enfonce dans le sol avant de frapper une balle à travers le green.', false, '2026-09-21 05:38:37.985496+00'),
	('cbdaaa500624783e2975643a94ec3f4e0133af8720373056a518712623582d85', 'ja', 'A golfer demonstrates how body and club positioning affect a golf swing. He explains how pulling the chest up through the shot helps prevent the club from digging into the ground before hitting a ball across the green.', 'ゴルファーが、体とクラブの位置がゴルフスイングにどのように影響するかを実演します。彼は、ショットを通じて胸を引き上げることが、グリーンを横切ってボールを打つ前にクラブが地面に突き刺さるのを防ぐのにどのように役立つかを説明しています。', false, '2026-09-21 23:53:52.236277+00'),
	('139838508082dde8161930c201700eadb4badac0b891aa46be0f90a4f6eccbcc', 'de', 'Step 1 of 5', 'Schritt 1 von 5', false, '2026-09-23 02:24:29.724226+00'),
	('5539c3259e70b447ffb2449e7efdafb5d11f35a0d2ff6ab1e47cb5b380e428e9', 'pt', 'Golf Lessons', 'Aulas de Golfe', false, '2026-09-23 02:28:06.822873+00'),
	('12207157545d6a2ff3776d879c6486217c42c355d8b1f6a96c9d1d1ffe933610', 'pt', 'Golf Fitness', 'Fitness de Golfe', false, '2026-09-23 02:28:06.822873+00'),
	('64ab2b69dba510be526608f4e67142d34068fb7cfd6771529a7c54b5cd7a0675', 'pt', 'PULSE', 'PULSE', false, '2026-09-23 02:28:06.822873+00'),
	('be86a5ab5b8dcb0d9058fefe5d1693d0f8029877a8d2e520853672b2e69490fe', 'pt', 'Pulse Presenting Sponsor', 'Patrocinador Apresentador do Pulse', false, '2026-09-23 02:28:06.822873+00'),
	('7dfe1c6dad710721252106f09c764022d5ca9fa9d0e7b4b5f0067905221da0a3', 'pt', 'SPONSORED', 'PATROCINADO', false, '2026-09-23 02:28:06.822873+00'),
	('7828443fe393122c422f3d1ef6e1b59dd21f9f02fca1a9d14771bd164860d84c', 'pt', 'Coaching Prerequisite', 'Pré-requisito de Treinamento', false, '2026-09-23 02:28:06.822873+00'),
	('79927b2daaa42970ec1236eae8f5623855641140375de2c31aa98a680098aea1', 'pt', '$19.00 Assessment', 'Avaliação de $19.00', false, '2026-09-23 02:28:06.822873+00'),
	('c5f8ba9bdc7ec0dd6c89d4718cb49729c80242d9cc19e4ba98078b12dabfb990', 'pt', 'SwingType Required Prior to Lessons', 'SwingType Obrigatório Antes das Aulas', false, '2026-09-23 02:28:06.822873+00'),
	('eec2bac6742efe6d9bf375ccc8fe6747f8f1f092d029a6b402ef6ea4c0b61126', 'pt', 'We don''t teach one-size-fits-all golf. Before taking your first lesson or practice track, you must verify your unique SwingType so coaching drills match your natural movement.', 'Nós não ensinamos golfe com uma abordagem única para todos. Antes de fazer sua primeira aula ou trilha de treino, você deve verificar seu SwingType exclusivo para que os exercícios de treinamento correspondam ao seu movimento natural.', false, '2026-09-23 02:28:06.822873+00'),
	('65adcd95eaec4734f949c69ab4cc48cc05bfbeccc95f09b097adf95ad5e8cee4', 'pt', 'Two-Tier Pricing Architecture:', 'Arquitetura de Preços em Dois Níveis:', false, '2026-09-23 02:28:06.822873+00'),
	('02fa7bbcf047710a5c624cf8970d6136c0b10c61ddeaa13c14609dbdc1961992', 'pt', '1. SwingType Test', '1. Teste SwingType', false, '2026-09-23 02:28:06.822873+00'),
	('2c31259c632a069a6b6ed379010b6b722598640b9ee17a0446ce575b6014d5fd', 'pt', 'One-time diagnostic ($19)', 'Diagnóstico único ($19)', false, '2026-09-23 02:28:06.822873+00'),
	('afd783dd861c19d11d666431c752d5a4ee6963bac7e4b3b76f0e994a2b033f1e', 'pt', '2. Tailored Lessons', '2. Aulas Personalizadas', false, '2026-09-23 02:28:06.822873+00'),
	('ce52c077efb301c76d2ebfbd053715d132edd324b25d72b62aa50f78d116f3b5', 'pt', 'Subscription or à la carte', 'Assinatura ou à la carte', false, '2026-09-23 02:28:06.822873+00'),
	('7eb11a1059a1f5d9946f6ad0e44f2e301988e7a6288b54c17a4d138ae623a01d', 'pt', 'Get Your SwingType Assessment', 'Obtenha Sua Avaliação SwingType', false, '2026-09-23 02:28:06.822873+00'),
	('f5f97caa1bba1d063250ab744afc494554ce86a5a0fa6de6fefbc769ff8bb0d6', 'pt', 'Profile Active', 'Perfil Ativo', false, '2026-09-23 02:28:06.822873+00'),
	('f42d23b05ff6e9b7b7861a06280196bf107dde51cd282338d8d83588609384b9', 'pt', 'Retake Screen', 'Refazer Avaliação', false, '2026-09-23 02:28:06.822873+00'),
	('e2d0a54968ead24efc0dffa6ac78fc606dceec34a0f586177a74a54cc2272cf8', 'pt', 'Delete', 'Excluir', false, '2026-09-23 02:28:06.822873+00'),
	('f027f9bc6d83148271c33cb1dd4b09648199c655ae3017892f36a65f04030ff2', 'pt', 'Prescribed Curriculum', 'Currículo Prescrito', false, '2026-09-23 02:28:06.822873+00'),
	('d9af0777ec52188cdae97b9fc338688e583260db681a0bfc791098486a09f141', 'pt', '$49/mo Active', '$49/mês Ativo', false, '2026-09-23 02:28:06.822873+00'),
	('d0db3ce81c17a73dda39fb6cd8dc3d66a1b7da1b1c3ca274bc4a1195a6e9d935', 'pt', 'Partner Sponsor', 'Patrocinador Parceiro', false, '2026-09-23 02:28:06.822873+00'),
	('699c376b2d1b1482116536b3671ba8548296263e03992362b827b76cd1820012', 'pt', '15-Min Physical Fitness Screen', 'Avaliação de Aptidão Física de 15 Min', false, '2026-09-23 02:28:06.822873+00'),
	('4c890b2ae51009e5b81e9c78a824e97f0d172717a5deb7bab3c2e5601287a58f', 'pt', 'Step 2 of 4', 'Etapa 2 de 4', false, '2026-09-23 02:28:06.822873+00'),
	('f53a7ab988e2f4624beb96812afd0bc56a8f1743e97d5ac7b33a85c0be131471', 'pt', 'PLAY', 'REPRODUZIR', false, '2026-09-23 02:28:06.822873+00'),
	('f36d9ff1f03f61c2d109e5c8c60884d9700fab790c77cb2fe462861a272cd870', 'pt', 'Tap to play the movement demonstration', 'Toque para reproduzir a demonstração do movimento', false, '2026-09-23 02:28:06.822873+00'),
	('00ae02d4aacde8b2cda815d70f8053e92cf1ec928408da570b5048d0ea8dae55', 'pt', 'Q: How far can you rotate your trail shoulder without discomfort?', 'P: Até onde você consegue girar o ombro posterior sem desconforto?', false, '2026-09-23 02:28:06.822873+00'),
	('2be157812b962581c4e9de94e4d8d1fd6a19d4d6e065af52ed99bd8a25dcac8d', 'pt', 'Select the option that matches your current range of motion.', 'Selecione a opção que corresponde à sua amplitude de movimento atual.', false, '2026-09-23 02:28:06.822873+00'),
	('d4e2f836cfcaaf8f8ef41a20edd4b304513c509215bc976099880e0b9453b0d9', 'pt', 'A. Full, Comfortable Range', 'A. Amplitude Completa e Confortável', false, '2026-09-23 02:28:06.822873+00'),
	('e8ea88efac96362ac0eedda11352e1551de5c4a8f8405ae59838749894914ad0', 'pt', 'No restriction or discomfort', 'Sem restrição ou desconforto', false, '2026-09-23 02:28:06.822873+00'),
	('139838508082dde8161930c201700eadb4badac0b891aa46be0f90a4f6eccbcc', 'pt', 'Step 1 of 5', 'Passo 1 de 5', false, '2026-09-23 02:28:10.44801+00'),
	('adc2d59d4193f7a77d341816095dffc7c3f551543b2b9d22a7d33bc7caf474a3', 'pt', 'B. Mild Tightness', 'B. Rigidez Leve', false, '2026-09-23 02:28:26.590664+00'),
	('bfbc352044d353df702317bc57764deb02931c253d94127186131325653ac27e', 'pt', 'Slight pull, no pain', 'Leve repuxamento, sem dor', false, '2026-09-23 02:28:26.590664+00'),
	('ccb03d48afd371c8555de1f5bf748ef6b73ae7668356dd4d730787df9d571d2d', 'pt', 'C. Noticeably Limited', 'C. Notavelmente Limitado', false, '2026-09-23 02:28:26.590664+00'),
	('969f2f9ea4c919a6631365c5d5dc1a0322b0515b485c94cc08812ea4b35a803e', 'pt', 'Clear restriction, no pain', 'Restrição clara, sem dor', false, '2026-09-23 02:28:26.590664+00'),
	('e4c539cd720923f3d6dcfe49a482d59cb5abe6f62747ef6fcb13261050ae6902', 'pt', 'D. Pain or Sharp Discomfort', 'D. Dor ou Desconforto Agudo', false, '2026-09-23 02:28:26.590664+00'),
	('4ce7b6965dbe6c133550bb9f724fd2976e46db484d1ed88b41f22cbb2a1498ae', 'pt', 'Stop and consult a professional', 'Pare e consulte um profissional', false, '2026-09-23 02:28:26.590664+00'),
	('5539c3259e70b447ffb2449e7efdafb5d11f35a0d2ff6ab1e47cb5b380e428e9', 'de', 'Golf Lessons', 'Golfunterricht', false, '2026-09-23 02:28:52.444109+00'),
	('12207157545d6a2ff3776d879c6486217c42c355d8b1f6a96c9d1d1ffe933610', 'de', 'Golf Fitness', 'Golf-Fitness', false, '2026-09-23 02:28:52.444109+00'),
	('64ab2b69dba510be526608f4e67142d34068fb7cfd6771529a7c54b5cd7a0675', 'de', 'PULSE', 'PULSE', false, '2026-09-23 02:28:52.444109+00'),
	('be86a5ab5b8dcb0d9058fefe5d1693d0f8029877a8d2e520853672b2e69490fe', 'de', 'Pulse Presenting Sponsor', 'Präsentierender Sponsor von Pulse', false, '2026-09-23 02:28:52.444109+00'),
	('7dfe1c6dad710721252106f09c764022d5ca9fa9d0e7b4b5f0067905221da0a3', 'de', 'SPONSORED', 'GESPONSERT', false, '2026-09-23 02:28:52.444109+00'),
	('7828443fe393122c422f3d1ef6e1b59dd21f9f02fca1a9d14771bd164860d84c', 'de', 'Coaching Prerequisite', 'Coaching-Voraussetzung', false, '2026-09-23 02:28:52.444109+00'),
	('79927b2daaa42970ec1236eae8f5623855641140375de2c31aa98a680098aea1', 'de', '$19.00 Assessment', '$19,00 Assessment', false, '2026-09-23 02:28:52.444109+00'),
	('c5f8ba9bdc7ec0dd6c89d4718cb49729c80242d9cc19e4ba98078b12dabfb990', 'de', 'SwingType Required Prior to Lessons', 'SwingType vor dem Unterricht erforderlich', false, '2026-09-23 02:28:52.444109+00'),
	('eec2bac6742efe6d9bf375ccc8fe6747f8f1f092d029a6b402ef6ea4c0b61126', 'de', 'We don''t teach one-size-fits-all golf. Before taking your first lesson or practice track, you must verify your unique SwingType so coaching drills match your natural movement.', 'Wir unterrichten kein Golf nach dem Einheitsprinzip. Bevor Sie Ihre erste Stunde oder Ihren Übungspfad beginnen, müssen Sie Ihren einzigartigen SwingType verifizieren, damit die Coaching-Übungen zu Ihrer natürlichen Bewegung passen.', false, '2026-09-23 02:28:52.444109+00'),
	('65adcd95eaec4734f949c69ab4cc48cc05bfbeccc95f09b097adf95ad5e8cee4', 'de', 'Two-Tier Pricing Architecture:', 'Zweistufige Preisstruktur:', false, '2026-09-23 02:28:52.444109+00'),
	('02fa7bbcf047710a5c624cf8970d6136c0b10c61ddeaa13c14609dbdc1961992', 'de', '1. SwingType Test', '1. SwingType-Test', false, '2026-09-23 02:28:52.444109+00'),
	('2c31259c632a069a6b6ed379010b6b722598640b9ee17a0446ce575b6014d5fd', 'de', 'One-time diagnostic ($19)', 'Einmalige Diagnose ($19)', false, '2026-09-23 02:28:52.444109+00'),
	('afd783dd861c19d11d666431c752d5a4ee6963bac7e4b3b76f0e994a2b033f1e', 'de', '2. Tailored Lessons', '2. Maßgeschneiderter Unterricht', false, '2026-09-23 02:28:52.444109+00'),
	('ce52c077efb301c76d2ebfbd053715d132edd324b25d72b62aa50f78d116f3b5', 'de', 'Subscription or à la carte', 'Abonnement oder à la carte', false, '2026-09-23 02:28:52.444109+00'),
	('7eb11a1059a1f5d9946f6ad0e44f2e301988e7a6288b54c17a4d138ae623a01d', 'de', 'Get Your SwingType Assessment', 'Holen Sie sich Ihr SwingType-Assessment', false, '2026-09-23 02:28:52.444109+00'),
	('f5f97caa1bba1d063250ab744afc494554ce86a5a0fa6de6fefbc769ff8bb0d6', 'de', 'Profile Active', 'Profil aktiv', false, '2026-09-23 02:28:52.444109+00'),
	('f42d23b05ff6e9b7b7861a06280196bf107dde51cd282338d8d83588609384b9', 'de', 'Retake Screen', 'Screening wiederholen', false, '2026-09-23 02:28:52.444109+00'),
	('e2d0a54968ead24efc0dffa6ac78fc606dceec34a0f586177a74a54cc2272cf8', 'de', 'Delete', 'Löschen', false, '2026-09-23 02:28:52.444109+00'),
	('f027f9bc6d83148271c33cb1dd4b09648199c655ae3017892f36a65f04030ff2', 'de', 'Prescribed Curriculum', 'Vorgegebener Lehrplan', false, '2026-09-23 02:28:52.444109+00'),
	('d9af0777ec52188cdae97b9fc338688e583260db681a0bfc791098486a09f141', 'de', '$49/mo Active', '$49/Monat aktiv', false, '2026-09-23 02:28:52.444109+00'),
	('d0db3ce81c17a73dda39fb6cd8dc3d66a1b7da1b1c3ca274bc4a1195a6e9d935', 'de', 'Partner Sponsor', 'Partner-Sponsor', false, '2026-09-23 02:28:52.444109+00'),
	('699c376b2d1b1482116536b3671ba8548296263e03992362b827b76cd1820012', 'de', '15-Min Physical Fitness Screen', '15-minütiges körperliches Fitness-Screening', false, '2026-09-23 02:28:52.444109+00'),
	('4c890b2ae51009e5b81e9c78a824e97f0d172717a5deb7bab3c2e5601287a58f', 'de', 'Step 2 of 4', 'Schritt 2 von 4', false, '2026-09-23 02:28:52.444109+00'),
	('f53a7ab988e2f4624beb96812afd0bc56a8f1743e97d5ac7b33a85c0be131471', 'de', 'PLAY', 'ABSPIELEN', false, '2026-09-23 02:28:52.444109+00'),
	('31fad3e58ddda66404e9f9d6e50f12452fb4ab29b03495c13dd71fe45465b10b', 'de', 'Trail Shoulder Mobility Screen', 'Mobilitätstest der hinteren Schulter', false, '2026-09-23 02:28:52.444109+00'),
	('f36d9ff1f03f61c2d109e5c8c60884d9700fab790c77cb2fe462861a272cd870', 'de', 'Tap to play the movement demonstration', 'Tippen, um die Bewegungsdemonstration abzuspielen', false, '2026-09-23 02:28:52.444109+00'),
	('00ae02d4aacde8b2cda815d70f8053e92cf1ec928408da570b5048d0ea8dae55', 'de', 'Q: How far can you rotate your trail shoulder without discomfort?', 'F: Wie weit können Sie Ihre hintere Schulter ohne Beschwerden drehen?', false, '2026-09-23 02:28:52.444109+00'),
	('2be157812b962581c4e9de94e4d8d1fd6a19d4d6e065af52ed99bd8a25dcac8d', 'de', 'Select the option that matches your current range of motion.', 'Wählen Sie die Option, die Ihrem aktuellen Bewegungsumfang entspricht.', false, '2026-09-23 02:28:52.444109+00'),
	('d4e2f836cfcaaf8f8ef41a20edd4b304513c509215bc976099880e0b9453b0d9', 'de', 'A. Full, Comfortable Range', 'A. Voller, beschwerdefreier Bewegungsumfang', false, '2026-09-23 02:28:52.444109+00'),
	('e8ea88efac96362ac0eedda11352e1551de5c4a8f8405ae59838749894914ad0', 'de', 'No restriction or discomfort', 'Keine Einschränkung oder Beschwerden', false, '2026-09-23 02:28:52.444109+00'),
	('adc2d59d4193f7a77d341816095dffc7c3f551543b2b9d22a7d33bc7caf474a3', 'de', 'B. Mild Tightness', 'B. Leichte Spannung', false, '2026-09-23 02:29:22.252558+00'),
	('bfbc352044d353df702317bc57764deb02931c253d94127186131325653ac27e', 'de', 'Slight pull, no pain', 'Leichtes Ziehen, kein Schmerz', false, '2026-09-23 02:29:22.252558+00'),
	('ccb03d48afd371c8555de1f5bf748ef6b73ae7668356dd4d730787df9d571d2d', 'de', 'C. Noticeably Limited', 'C. Spürbar eingeschränkt', false, '2026-09-23 02:29:22.252558+00'),
	('969f2f9ea4c919a6631365c5d5dc1a0322b0515b485c94cc08812ea4b35a803e', 'de', 'Clear restriction, no pain', 'Deutliche Einschränkung, kein Schmerz', false, '2026-09-23 02:29:22.252558+00'),
	('e4c539cd720923f3d6dcfe49a482d59cb5abe6f62747ef6fcb13261050ae6902', 'de', 'D. Pain or Sharp Discomfort', 'D. Schmerz oder stechendes Unbehagen', false, '2026-09-23 02:29:22.252558+00'),
	('4ce7b6965dbe6c133550bb9f724fd2976e46db484d1ed88b41f22cbb2a1498ae', 'de', 'Stop and consult a professional', 'Stoppen und einen Experten konsultieren', false, '2026-09-23 02:29:22.252558+00'),
	('139838508082dde8161930c201700eadb4badac0b891aa46be0f90a4f6eccbcc', 'fr', 'Step 1 of 5', 'Étape 1 sur 5', false, '2026-09-23 02:40:52.455635+00'),
	('5539c3259e70b447ffb2449e7efdafb5d11f35a0d2ff6ab1e47cb5b380e428e9', 'fr', 'Golf Lessons', 'Cours de golf', false, '2026-09-23 02:41:02.386916+00'),
	('12207157545d6a2ff3776d879c6486217c42c355d8b1f6a96c9d1d1ffe933610', 'fr', 'Golf Fitness', 'Fitness de golf', false, '2026-09-23 02:41:02.386916+00'),
	('64ab2b69dba510be526608f4e67142d34068fb7cfd6771529a7c54b5cd7a0675', 'fr', 'PULSE', 'PULSE', false, '2026-09-23 02:41:02.386916+00'),
	('be86a5ab5b8dcb0d9058fefe5d1693d0f8029877a8d2e520853672b2e69490fe', 'fr', 'Pulse Presenting Sponsor', 'Sponsor de présentation Pulse', false, '2026-09-23 02:41:02.386916+00'),
	('7dfe1c6dad710721252106f09c764022d5ca9fa9d0e7b4b5f0067905221da0a3', 'fr', 'SPONSORED', 'SPONSORISÉ', false, '2026-09-23 02:41:02.386916+00'),
	('7828443fe393122c422f3d1ef6e1b59dd21f9f02fca1a9d14771bd164860d84c', 'fr', 'Coaching Prerequisite', 'Prérequis pour le coaching', false, '2026-09-23 02:41:02.386916+00'),
	('79927b2daaa42970ec1236eae8f5623855641140375de2c31aa98a680098aea1', 'fr', '$19.00 Assessment', 'Évaluation à 19,00 $', false, '2026-09-23 02:41:02.386916+00'),
	('c5f8ba9bdc7ec0dd6c89d4718cb49729c80242d9cc19e4ba98078b12dabfb990', 'fr', 'SwingType Required Prior to Lessons', 'SwingType requis avant les cours', false, '2026-09-23 02:41:02.386916+00'),
	('eec2bac6742efe6d9bf375ccc8fe6747f8f1f092d029a6b402ef6ea4c0b61126', 'fr', 'We don''t teach one-size-fits-all golf. Before taking your first lesson or practice track, you must verify your unique SwingType so coaching drills match your natural movement.', 'Nous n''enseignons pas un golf universel. Avant de prendre votre premier cours ou de commencer votre entraînement, vous devez vérifier votre SwingType unique afin que les exercices de coaching correspondent à votre mouvement naturel.', false, '2026-09-23 02:41:02.386916+00'),
	('65adcd95eaec4734f949c69ab4cc48cc05bfbeccc95f09b097adf95ad5e8cee4', 'fr', 'Two-Tier Pricing Architecture:', 'Architecture de tarification à deux niveaux :', false, '2026-09-23 02:41:02.386916+00'),
	('02fa7bbcf047710a5c624cf8970d6136c0b10c61ddeaa13c14609dbdc1961992', 'fr', '1. SwingType Test', '1. Test SwingType', false, '2026-09-23 02:41:02.386916+00'),
	('2c31259c632a069a6b6ed379010b6b722598640b9ee17a0446ce575b6014d5fd', 'fr', 'One-time diagnostic ($19)', 'Diagnostic unique (19 $)', false, '2026-09-23 02:41:02.386916+00'),
	('afd783dd861c19d11d666431c752d5a4ee6963bac7e4b3b76f0e994a2b033f1e', 'fr', '2. Tailored Lessons', '2. Cours sur mesure', false, '2026-09-23 02:41:02.386916+00'),
	('ce52c077efb301c76d2ebfbd053715d132edd324b25d72b62aa50f78d116f3b5', 'fr', 'Subscription or à la carte', 'Abonnement ou à la carte', false, '2026-09-23 02:41:02.386916+00'),
	('7eb11a1059a1f5d9946f6ad0e44f2e301988e7a6288b54c17a4d138ae623a01d', 'fr', 'Get Your SwingType Assessment', 'Obtenez votre évaluation SwingType', false, '2026-09-23 02:41:02.386916+00'),
	('f5f97caa1bba1d063250ab744afc494554ce86a5a0fa6de6fefbc769ff8bb0d6', 'fr', 'Profile Active', 'Profil actif', false, '2026-09-23 02:41:02.386916+00'),
	('f42d23b05ff6e9b7b7861a06280196bf107dde51cd282338d8d83588609384b9', 'fr', 'Retake Screen', 'Refaire l''évaluation', false, '2026-09-23 02:41:02.386916+00'),
	('e2d0a54968ead24efc0dffa6ac78fc606dceec34a0f586177a74a54cc2272cf8', 'fr', 'Delete', 'Supprimer', false, '2026-09-23 02:41:02.386916+00'),
	('f027f9bc6d83148271c33cb1dd4b09648199c655ae3017892f36a65f04030ff2', 'fr', 'Prescribed Curriculum', 'Programme prescrit', false, '2026-09-23 02:41:02.386916+00'),
	('d9af0777ec52188cdae97b9fc338688e583260db681a0bfc791098486a09f141', 'fr', '$49/mo Active', '49 $/mois Actif', false, '2026-09-23 02:41:02.386916+00'),
	('d0db3ce81c17a73dda39fb6cd8dc3d66a1b7da1b1c3ca274bc4a1195a6e9d935', 'fr', 'Partner Sponsor', 'Sponsor partenaire', false, '2026-09-23 02:41:02.386916+00'),
	('699c376b2d1b1482116536b3671ba8548296263e03992362b827b76cd1820012', 'fr', '15-Min Physical Fitness Screen', 'Évaluation de la condition physique de 15 min', false, '2026-09-23 02:41:02.386916+00'),
	('4c890b2ae51009e5b81e9c78a824e97f0d172717a5deb7bab3c2e5601287a58f', 'fr', 'Step 2 of 4', 'Étape 2 sur 4', false, '2026-09-23 02:41:02.386916+00'),
	('f53a7ab988e2f4624beb96812afd0bc56a8f1743e97d5ac7b33a85c0be131471', 'fr', 'PLAY', 'LECTURE', false, '2026-09-23 02:41:02.386916+00'),
	('31fad3e58ddda66404e9f9d6e50f12452fb4ab29b03495c13dd71fe45465b10b', 'fr', 'Trail Shoulder Mobility Screen', 'Évaluation de la mobilité de l''épaule arrière', false, '2026-09-23 02:41:02.386916+00'),
	('f36d9ff1f03f61c2d109e5c8c60884d9700fab790c77cb2fe462861a272cd870', 'fr', 'Tap to play the movement demonstration', 'Appuyez pour lancer la démonstration du mouvement', false, '2026-09-23 02:41:02.386916+00'),
	('00ae02d4aacde8b2cda815d70f8053e92cf1ec928408da570b5048d0ea8dae55', 'fr', 'Q: How far can you rotate your trail shoulder without discomfort?', 'Q : Jusqu''où pouvez-vous tourner votre épaule arrière sans inconfort ?', false, '2026-09-23 02:41:02.386916+00'),
	('2be157812b962581c4e9de94e4d8d1fd6a19d4d6e065af52ed99bd8a25dcac8d', 'fr', 'Select the option that matches your current range of motion.', 'Sélectionnez l''option qui correspond à votre amplitude de mouvement actuelle.', false, '2026-09-23 02:41:02.386916+00'),
	('d4e2f836cfcaaf8f8ef41a20edd4b304513c509215bc976099880e0b9453b0d9', 'fr', 'A. Full, Comfortable Range', 'A. Amplitude complète et confortable', false, '2026-09-23 02:41:02.386916+00'),
	('e8ea88efac96362ac0eedda11352e1551de5c4a8f8405ae59838749894914ad0', 'fr', 'No restriction or discomfort', 'Aucune restriction ni inconfort', false, '2026-09-23 02:41:02.386916+00'),
	('adc2d59d4193f7a77d341816095dffc7c3f551543b2b9d22a7d33bc7caf474a3', 'fr', 'B. Mild Tightness', 'B. Légère tension', false, '2026-09-23 02:41:28.436351+00'),
	('bfbc352044d353df702317bc57764deb02931c253d94127186131325653ac27e', 'fr', 'Slight pull, no pain', 'Léger tiraillement, pas de douleur', false, '2026-09-23 02:41:28.436351+00'),
	('ccb03d48afd371c8555de1f5bf748ef6b73ae7668356dd4d730787df9d571d2d', 'fr', 'C. Noticeably Limited', 'C. Nettement limité', false, '2026-09-23 02:41:28.436351+00'),
	('969f2f9ea4c919a6631365c5d5dc1a0322b0515b485c94cc08812ea4b35a803e', 'fr', 'Clear restriction, no pain', 'Restriction claire, pas de douleur', false, '2026-09-23 02:41:28.436351+00'),
	('e4c539cd720923f3d6dcfe49a482d59cb5abe6f62747ef6fcb13261050ae6902', 'fr', 'D. Pain or Sharp Discomfort', 'D. Douleur ou inconfort vif', false, '2026-09-23 02:41:28.436351+00'),
	('4ce7b6965dbe6c133550bb9f724fd2976e46db484d1ed88b41f22cbb2a1498ae', 'fr', 'Stop and consult a professional', 'Arrêtez et consultez un professionnel', false, '2026-09-23 02:41:28.436351+00');


--
-- Data for Name: user_sport_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."user_sport_profiles" ("user_id", "sport_id", "joined_at", "wallet_points", "last_point_awarded_at", "assessment_purchased", "assessment_profile_id", "assessment_completed_at", "assessment_retakes_used", "assessment_free_access", "assessment_access_source", "assessment_a1", "assessment_a2", "assessment_a3", "assessment_a4", "assessment_a5", "assessment_alignment_score") VALUES
	('06ab125b-7a8c-478b-9eb5-ed50dd842d50', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37', '2026-09-11 17:23:54.53579+00', 1, '2026-09-11 17:23:55.625608+00', false, NULL, NULL, 0, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('c0f0f4a2-8855-42ec-a887-c9deed1cfc95', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37', '2026-09-03 00:59:37.128854+00', 8, '2026-09-15 05:11:07.580175+00', true, NULL, NULL, 0, false, 'granted', NULL, NULL, NULL, NULL, NULL, NULL),
	('afaa1119-7ccd-40ad-855b-8a711c864e42', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37', '2026-09-03 17:21:08.917934+00', 6, '2026-09-24 02:41:33.321247+00', true, NULL, NULL, 0, false, 'admin', NULL, NULL, NULL, NULL, NULL, NULL),
	('9f5a5fc7-3f06-4726-8f6e-1ddd43a74714', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37', '2026-10-11 09:56:25.379233+00', 3, '2026-10-11 09:56:25.684948+00', true, 3, '2026-10-11 09:58:40.278+00', 0, false, 'granted', 'TOP', 'REAR', 'W_LONG', 'A_LONGUP', 'ER_HIGH', 4),
	('c2244e9d-689e-44d4-8767-005ce8764b56', 'bbf203db-2c10-4e7d-86bd-8b9ad4977e37', '2026-09-02 20:19:27.622341+00', 22, '2026-10-11 17:46:06.618295+00', true, NULL, NULL, 0, false, 'admin', NULL, NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO "storage"."buckets" ("id", "name", "owner", "created_at", "updated_at", "public", "avif_autodetection", "file_size_limit", "allowed_mime_types", "owner_id", "type", "versioning_status", "lifecycle_configuration", "lifecycle_configuration_generation") VALUES
	('avatars', 'avatars', NULL, '2026-08-31 23:45:36.517338+00', '2026-08-31 23:45:36.517338+00', true, false, NULL, NULL, NULL, 'STANDARD', 'DISABLED', NULL, NULL);


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO "storage"."objects" ("id", "bucket_id", "name", "owner", "created_at", "updated_at", "last_accessed_at", "metadata", "version", "owner_id", "user_metadata", "archived_at", "is_delete_marker", "is_versioned") VALUES
	('6a12f693-e9bb-430c-ba87-aa71b731dcdd', 'avatars', 'afb71738-5106-438f-818c-998c535efdc9/avatar.png', 'afb71738-5106-438f-818c-998c535efdc9', '2026-09-02 18:52:07.84773+00', '2026-09-02 18:52:07.84773+00', '2026-09-02 18:52:07.84773+00', '{"eTag": "\"18718aa5f5337092133dde3c26032b60\"", "size": 1218146, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-09-02T18:52:08.000Z", "contentLength": 1218146, "httpStatusCode": 200}', '65c2aa1e-57a6-4e5b-88cf-09e80a2e376c', 'afb71738-5106-438f-818c-998c535efdc9', '{}', NULL, false, false),
	('a7cc98d0-4f89-4176-800c-b5280b3a210a', 'avatars', '877a3ba3-ff52-4948-8b40-f11fa637876c/avatar.png', '877a3ba3-ff52-4948-8b40-f11fa637876c', '2026-09-02 19:20:06.831931+00', '2026-09-02 19:20:06.831931+00', '2026-09-02 19:20:06.831931+00', '{"eTag": "\"aaa4c61bb72881e1bcab82ac2939de26\"", "size": 665360, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-09-02T19:20:07.000Z", "contentLength": 665360, "httpStatusCode": 200}', '3e1d28f1-1321-4067-9b3e-c54a42724b80', '877a3ba3-ff52-4948-8b40-f11fa637876c', '{}', NULL, false, false),
	('7a402698-ffc2-4732-807b-42b887f393be', 'avatars', 'c2244e9d-689e-44d4-8767-005ce8764b56/avatar.png', 'c2244e9d-689e-44d4-8767-005ce8764b56', '2026-09-01 16:28:37.282634+00', '2026-09-01 16:28:37.282634+00', '2026-09-01 16:28:37.282634+00', '{"eTag": "\"f5703728a53b90dcd874acbfedacce31\"", "size": 2220019, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-09-01T16:28:38.000Z", "contentLength": 2220019, "httpStatusCode": 200}', '8ce0f218-2fe0-4798-a08a-3a18a5572d95', 'c2244e9d-689e-44d4-8767-005ce8764b56', '{}', NULL, false, false),
	('a09e11d8-9519-4714-a6b5-6c0dd7dae889', 'avatars', 'c0f0f4a2-8855-42ec-a887-c9deed1cfc95/avatar.jpg', 'c0f0f4a2-8855-42ec-a887-c9deed1cfc95', '2026-09-02 17:20:42.193644+00', '2026-09-02 17:23:17.028551+00', '2026-09-02 17:20:42.193644+00', '{"eTag": "\"e1287eb4ed35eebcd5ff85221140f3f5\"", "size": 269542, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-09-02T17:23:17.000Z", "contentLength": 269542, "httpStatusCode": 200}', '7060f65e-a9fe-4d61-bed9-a82315c3015a', 'c0f0f4a2-8855-42ec-a887-c9deed1cfc95', '{}', NULL, false, false);


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 398, true);


--
-- PostgreSQL database dump complete
--

-- \unrestrict bBNBiF2hT8EB0hbetsgUtOcnyVQiL99w9pmA0AT2cOs4QEjfdml5DKcFdL2DU0M

RESET ALL;
