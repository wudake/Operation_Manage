--
-- PostgreSQL database dump
--

\restrict vXHYWdZ9IlEMHyD9eZ01h5Hgh15bx7PSHEcmLPQPNwIS8xPWgECDa7f6bfYSFC8

-- Dumped from database version 16.13
-- Dumped by pg_dump version 16.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: AccountStatus; Type: TYPE; Schema: public; Owner: smm
--

CREATE TYPE public."AccountStatus" AS ENUM (
    'ACTIVE',
    'PAUSED',
    'BANNED',
    'APPEALING'
);


ALTER TYPE public."AccountStatus" OWNER TO smm;

--
-- Name: ContentForm; Type: TYPE; Schema: public; Owner: smm
--

CREATE TYPE public."ContentForm" AS ENUM (
    'SHORT_VIDEO',
    'IMAGE_TEXT',
    'REELS',
    'LONG_VIDEO'
);


ALTER TYPE public."ContentForm" OWNER TO smm;

--
-- Name: ContentStatus; Type: TYPE; Schema: public; Owner: smm
--

CREATE TYPE public."ContentStatus" AS ENUM (
    'PENDING',
    'PRODUCING',
    'READY',
    'PUBLISHED',
    'ARCHIVED'
);


ALTER TYPE public."ContentStatus" OWNER TO smm;

--
-- Name: Difficulty; Type: TYPE; Schema: public; Owner: smm
--

CREATE TYPE public."Difficulty" AS ENUM (
    'EASY',
    'MEDIUM',
    'HARD'
);


ALTER TYPE public."Difficulty" OWNER TO smm;

--
-- Name: EffectLevel; Type: TYPE; Schema: public; Owner: smm
--

CREATE TYPE public."EffectLevel" AS ENUM (
    'HIGH',
    'MEDIUM',
    'LOW'
);


ALTER TYPE public."EffectLevel" OWNER TO smm;

--
-- Name: LeadStatus; Type: TYPE; Schema: public; Owner: smm
--

CREATE TYPE public."LeadStatus" AS ENUM (
    'PENDING',
    'FOLLOWING',
    'QUOTED',
    'WON',
    'LOST'
);


ALTER TYPE public."LeadStatus" OWNER TO smm;

--
-- Name: MaterialCategory; Type: TYPE; Schema: public; Owner: smm
--

CREATE TYPE public."MaterialCategory" AS ENUM (
    'PRODUCT',
    'FACTORY',
    'INSTALLATION',
    'FEEDBACK',
    'TEMPLATE'
);


ALTER TYPE public."MaterialCategory" OWNER TO smm;

--
-- Name: NotificationType; Type: TYPE; Schema: public; Owner: smm
--

CREATE TYPE public."NotificationType" AS ENUM (
    'CONTENT_PUBLISH',
    'ACCOUNT_ALERT',
    'REPORT_WEEKLY',
    'REPORT_MONTHLY',
    'SYSTEM'
);


ALTER TYPE public."NotificationType" OWNER TO smm;

--
-- Name: Platform; Type: TYPE; Schema: public; Owner: smm
--

CREATE TYPE public."Platform" AS ENUM (
    'TIKTOK',
    'INSTAGRAM',
    'YOUTUBE',
    'FACEBOOK'
);


ALTER TYPE public."Platform" OWNER TO smm;

--
-- Name: TopicStatus; Type: TYPE; Schema: public; Owner: smm
--

CREATE TYPE public."TopicStatus" AS ENUM (
    'PENDING',
    'IN_USE',
    'USED',
    'DISCARDED'
);


ALTER TYPE public."TopicStatus" OWNER TO smm;

--
-- Name: UserRole; Type: TYPE; Schema: public; Owner: smm
--

CREATE TYPE public."UserRole" AS ENUM (
    'SUPER_ADMIN',
    'MANAGER',
    'OPERATOR'
);


ALTER TYPE public."UserRole" OWNER TO smm;

--
-- Name: UserStatus; Type: TYPE; Schema: public; Owner: smm
--

CREATE TYPE public."UserStatus" AS ENUM (
    'ACTIVE',
    'INACTIVE'
);


ALTER TYPE public."UserStatus" OWNER TO smm;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _AccountToContent; Type: TABLE; Schema: public; Owner: smm
--

CREATE TABLE public."_AccountToContent" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


ALTER TABLE public."_AccountToContent" OWNER TO smm;

--
-- Name: _AccountToUser; Type: TABLE; Schema: public; Owner: smm
--

CREATE TABLE public."_AccountToUser" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


ALTER TABLE public."_AccountToUser" OWNER TO smm;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: smm
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO smm;

--
-- Name: account_groups; Type: TABLE; Schema: public; Owner: smm
--

CREATE TABLE public.account_groups (
    id text NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.account_groups OWNER TO smm;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: smm
--

CREATE TABLE public.accounts (
    id text NOT NULL,
    platform public."Platform" NOT NULL,
    name character varying(100) NOT NULL,
    account_id character varying(100),
    home_url character varying(500),
    market character varying(50),
    target_audience text,
    status public."AccountStatus" DEFAULT 'ACTIVE'::public."AccountStatus" NOT NULL,
    persona text,
    contact_info jsonb,
    group_id text,
    tags text[],
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL,
    account_type character varying(50),
    common_devices text,
    linked_phone character varying(20),
    login_email character varying(100),
    login_password character varying(255),
    login_phone character varying(20),
    registered_at date,
    remark text,
    follower_count integer DEFAULT 0 NOT NULL,
    custom_group character varying(100)
);


ALTER TABLE public.accounts OWNER TO smm;

--
-- Name: content_comments; Type: TABLE; Schema: public; Owner: smm
--

CREATE TABLE public.content_comments (
    id text NOT NULL,
    content_id text NOT NULL,
    user_id text NOT NULL,
    content text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.content_comments OWNER TO smm;

--
-- Name: content_data; Type: TABLE; Schema: public; Owner: smm
--

CREATE TABLE public.content_data (
    id text NOT NULL,
    content_id text NOT NULL,
    account_id text NOT NULL,
    views bigint DEFAULT 0 NOT NULL,
    likes bigint DEFAULT 0 NOT NULL,
    comments bigint DEFAULT 0 NOT NULL,
    shares bigint DEFAULT 0 NOT NULL,
    favorites bigint DEFAULT 0 NOT NULL,
    completion_rate numeric(5,2),
    followers_gained integer DEFAULT 0 NOT NULL,
    total_followers integer DEFAULT 0 NOT NULL,
    dm_leads integer DEFAULT 0 NOT NULL,
    comment_leads integer DEFAULT 0 NOT NULL,
    profile_clicks integer DEFAULT 0 NOT NULL,
    valid_leads integer DEFAULT 0 NOT NULL,
    record_date date NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.content_data OWNER TO smm;

--
-- Name: contents; Type: TABLE; Schema: public; Owner: smm
--

CREATE TABLE public.contents (
    id text NOT NULL,
    title character varying(200) NOT NULL,
    topic_id text,
    operator_id text,
    status public."ContentStatus" DEFAULT 'PENDING'::public."ContentStatus" NOT NULL,
    planned_publish_at timestamp(3) without time zone,
    actual_publish_at timestamp(3) without time zone,
    publish_url character varying(500),
    description text,
    attachments jsonb,
    production_time_hours numeric(4,1),
    rating character varying(10),
    remark text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL,
    content_type character varying(50),
    script text
);


ALTER TABLE public.contents OWNER TO smm;

--
-- Name: dictionaries; Type: TABLE; Schema: public; Owner: smm
--

CREATE TABLE public.dictionaries (
    id text NOT NULL,
    category character varying(50) NOT NULL,
    code character varying(50) NOT NULL,
    name character varying(100) NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.dictionaries OWNER TO smm;

--
-- Name: leads; Type: TABLE; Schema: public; Owner: smm
--

CREATE TABLE public.leads (
    id text NOT NULL,
    source_platform public."Platform" NOT NULL,
    source_content_id text,
    source_account_id text,
    operator_id text,
    lead_time timestamp(3) without time zone NOT NULL,
    customer_name character varying(100),
    customer_contact character varying(200),
    requirement text,
    status public."LeadStatus" DEFAULT 'PENDING'::public."LeadStatus" NOT NULL,
    is_valid boolean,
    valid_confirmed_by text,
    valid_confirmed_at timestamp(3) without time zone,
    deal_amount numeric(12,2),
    remark text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.leads OWNER TO smm;

--
-- Name: materials; Type: TABLE; Schema: public; Owner: smm
--

CREATE TABLE public.materials (
    id text NOT NULL,
    name character varying(200) NOT NULL,
    nas_path character varying(500) NOT NULL,
    thumbnail_path character varying(500),
    category public."MaterialCategory" NOT NULL,
    tags text[],
    description text,
    file_type character varying(50),
    file_size bigint,
    usage_count integer DEFAULT 0 NOT NULL,
    is_sensitive boolean DEFAULT false NOT NULL,
    allowed_roles text[],
    created_by text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.materials OWNER TO smm;

--
-- Name: notifications; Type: TABLE; Schema: public; Owner: smm
--

CREATE TABLE public.notifications (
    id text NOT NULL,
    user_id text NOT NULL,
    type public."NotificationType" NOT NULL,
    title character varying(200) NOT NULL,
    content text NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    link character varying(500),
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.notifications OWNER TO smm;

--
-- Name: operation_logs; Type: TABLE; Schema: public; Owner: smm
--

CREATE TABLE public.operation_logs (
    id text NOT NULL,
    user_id text,
    username character varying(50),
    action character varying(100) NOT NULL,
    resource character varying(100) NOT NULL,
    resource_id text,
    detail jsonb,
    ip_address character varying(50),
    user_agent character varying(500),
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.operation_logs OWNER TO smm;

--
-- Name: topics; Type: TABLE; Schema: public; Owner: smm
--

CREATE TABLE public.topics (
    id text NOT NULL,
    title character varying(200) NOT NULL,
    content_form public."ContentForm" NOT NULL,
    tags text[],
    product_type character varying(50),
    content_type character varying(50),
    source character varying(255),
    status public."TopicStatus" DEFAULT 'PENDING'::public."TopicStatus" NOT NULL,
    usage_count integer DEFAULT 0 NOT NULL,
    remark text,
    created_by text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL,
    completed_at timestamp(3) without time zone,
    is_completed boolean DEFAULT false NOT NULL,
    operator_id text,
    published_accounts text,
    copywriting text,
    script text
);


ALTER TABLE public.topics OWNER TO smm;

--
-- Name: users; Type: TABLE; Schema: public; Owner: smm
--

CREATE TABLE public.users (
    id text NOT NULL,
    username character varying(50) NOT NULL,
    password_hash character varying(255) NOT NULL,
    real_name character varying(50) NOT NULL,
    role public."UserRole" NOT NULL,
    email character varying(100),
    phone character varying(20),
    avatar character varying(255),
    status public."UserStatus" DEFAULT 'ACTIVE'::public."UserStatus" NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO smm;

--
-- Data for Name: _AccountToContent; Type: TABLE DATA; Schema: public; Owner: smm
--

COPY public."_AccountToContent" ("A", "B") FROM stdin;
4201e725-b491-47f1-b49e-0930aa6530cd	142be0ae-d466-4bc6-b5a6-698532ade71a
4201e725-b491-47f1-b49e-0930aa6530cd	0e17e72e-4167-41e9-a08b-cc12085824a5
ed0c6902-fcfc-4162-b45b-401667d7b95a	0e17e72e-4167-41e9-a08b-cc12085824a5
ed0c6902-fcfc-4162-b45b-401667d7b95a	7f9fa9ce-0af2-4c25-917a-63b73faa51f5
ed0c6902-fcfc-4162-b45b-401667d7b95a	39ca1052-7a36-4f33-ad0b-47dd6a8b68c8
ec3b93f1-5ca9-49b4-8e2b-e6b7403d121f	e8e310d9-f932-4927-841d-5c923c08ed4a
ed0c6902-fcfc-4162-b45b-401667d7b95a	0ca080bd-f14e-418d-8391-028b964e5846
ec3b93f1-5ca9-49b4-8e2b-e6b7403d121f	f0513cc3-95b8-4e24-b66d-ee4febd4d28f
ed0c6902-fcfc-4162-b45b-401667d7b95a	c1fea9ef-a046-4319-9f1e-c02be0243a37
ec3b93f1-5ca9-49b4-8e2b-e6b7403d121f	9971059a-3425-476a-8d0c-1b028b7ab21a
b16620f7-2db8-4795-adf7-a38be56e7aae	c563473d-0fc7-45cf-b35e-7d07947231d3
d5cb501d-673d-4fd3-8887-e6b41abe8f9e	aadf08cc-509c-4fa7-9bd7-56010efeb89c
d5cb501d-673d-4fd3-8887-e6b41abe8f9e	0265ba15-07f1-4547-b633-2447c8d11e34
4201e725-b491-47f1-b49e-0930aa6530cd	7f2034b2-80df-4be4-951f-7cd48785fc07
d5cb501d-673d-4fd3-8887-e6b41abe8f9e	4fed6aa2-97a6-425a-b82c-8112e69d232a
b16620f7-2db8-4795-adf7-a38be56e7aae	a8255f7a-ba2a-47b9-8be8-1c40f0f880fb
b16620f7-2db8-4795-adf7-a38be56e7aae	dd6d6cff-284b-42bf-b91f-3b0bef952ab9
b16620f7-2db8-4795-adf7-a38be56e7aae	695d6c93-a44f-4b3b-8dad-cf8389967a4e
b16620f7-2db8-4795-adf7-a38be56e7aae	22bafd5e-eabd-40bb-88bb-90e8141ea2ee
4201e725-b491-47f1-b49e-0930aa6530cd	c6f93285-5462-4c71-8bc2-a8028a67ed44
b16620f7-2db8-4795-adf7-a38be56e7aae	48b20d22-eda3-4402-bf6e-694d6e08980d
d5cb501d-673d-4fd3-8887-e6b41abe8f9e	6eb8a465-035c-4176-86dc-9d637c01980c
b16620f7-2db8-4795-adf7-a38be56e7aae	81a0a235-c0ba-4173-8aea-bbedc6efbb7c
b16620f7-2db8-4795-adf7-a38be56e7aae	3c74d3f1-f2de-4dbc-9ef0-b2da08688b48
4201e725-b491-47f1-b49e-0930aa6530cd	f86d6349-3cec-4368-ad40-bbb7d1b621a2
d5cb501d-673d-4fd3-8887-e6b41abe8f9e	b965c06b-19e0-4eef-9fc8-f5d4ea108937
ec3b93f1-5ca9-49b4-8e2b-e6b7403d121f	413ec705-2b35-48d6-8c58-35b2cef35f69
4201e725-b491-47f1-b49e-0930aa6530cd	7d3a9849-f043-48e9-8555-e174f4a02f97
ed0c6902-fcfc-4162-b45b-401667d7b95a	93a01f43-8443-4caa-8aed-3ab227260ea6
d5cb501d-673d-4fd3-8887-e6b41abe8f9e	04e0f45a-6f8c-468d-b731-031293594823
\.


--
-- Data for Name: _AccountToUser; Type: TABLE DATA; Schema: public; Owner: smm
--

COPY public."_AccountToUser" ("A", "B") FROM stdin;
ec3b93f1-5ca9-49b4-8e2b-e6b7403d121f	8fda33c9-5ef6-473b-8419-d9cd5db3ffe8
ae540c97-8e38-4445-9300-75c8262cba1e	e6cc3a1d-6c69-4077-93a0-4ac003de1060
4cc5c22d-436a-4e3d-8f7f-ef51be999ef4	e6cc3a1d-6c69-4077-93a0-4ac003de1060
2ebd3f93-0620-46e0-b415-f89c2d067e45	e6cc3a1d-6c69-4077-93a0-4ac003de1060
d5ebd5a3-4e8c-47d0-acfc-ef9ece241473	e6cc3a1d-6c69-4077-93a0-4ac003de1060
5bdb9e80-5d3a-4fa2-857b-18b1c526519d	8fda33c9-5ef6-473b-8419-d9cd5db3ffe8
5bdb9e80-5d3a-4fa2-857b-18b1c526519d	e6cc3a1d-6c69-4077-93a0-4ac003de1060
60a9d67a-e653-4c78-a4a3-492f13f43916	8fda33c9-5ef6-473b-8419-d9cd5db3ffe8
60a9d67a-e653-4c78-a4a3-492f13f43916	e6cc3a1d-6c69-4077-93a0-4ac003de1060
0affcbeb-6ab5-4d86-a2ac-5e96dc3fa98f	8fda33c9-5ef6-473b-8419-d9cd5db3ffe8
0affcbeb-6ab5-4d86-a2ac-5e96dc3fa98f	e6cc3a1d-6c69-4077-93a0-4ac003de1060
37475525-9e6b-42cc-8dc8-3de96db08b6f	8fda33c9-5ef6-473b-8419-d9cd5db3ffe8
37475525-9e6b-42cc-8dc8-3de96db08b6f	e6cc3a1d-6c69-4077-93a0-4ac003de1060
8e069317-9f59-42ad-9487-7c69aa85224a	8fda33c9-5ef6-473b-8419-d9cd5db3ffe8
af19136f-b4b1-4d14-882b-45d173270cd1	8fda33c9-5ef6-473b-8419-d9cd5db3ffe8
61d941b9-9f04-40df-aadd-361fcebad34d	8fda33c9-5ef6-473b-8419-d9cd5db3ffe8
96a4ff80-b849-4157-97b2-5011ef50c461	e6cc3a1d-6c69-4077-93a0-4ac003de1060
2ca6a531-7264-4d3c-8509-3b614cc117a4	e6cc3a1d-6c69-4077-93a0-4ac003de1060
8659a69f-9730-49c9-a966-0bd79da063a8	8fda33c9-5ef6-473b-8419-d9cd5db3ffe8
e1fff405-11da-458f-8269-45af816e8637	8fda33c9-5ef6-473b-8419-d9cd5db3ffe8
90d6b3b7-941a-4449-937a-5eeb4a7b43c4	8fda33c9-5ef6-473b-8419-d9cd5db3ffe8
b16620f7-2db8-4795-adf7-a38be56e7aae	8fda33c9-5ef6-473b-8419-d9cd5db3ffe8
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: smm
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
eba6db8d-af24-43bb-bce5-36f1c3a23fbb	ecb91fd724ac12ca61c53c13b8b5622afcea9b2ac622cdcb967ae1de782f0062	2026-04-29 03:29:08.628762+00	20260429032908_init	\N	\N	2026-04-29 03:29:08.489628+00	1
73d45ec9-f924-418d-b4d5-cb27b1beeec8	9dc35d4bc8e683b208b09c8eff0516cc06d3a321c2a59ccdaa44f6ee0f34c1f9	2026-04-29 03:56:34.501693+00	20260429035634_add_comment_user_relation	\N	\N	2026-04-29 03:56:34.489893+00	1
9a940f72-f319-474a-aed0-571660f782e2	9534babcaa3931a75022c693147adbf41d0373200be98613ea6282f33748ee31	2026-04-29 06:25:07.14599+00	20260429062507_add_account_fields	\N	\N	2026-04-29 06:25:07.137723+00	1
4dcce6e4-1d22-4e83-9a87-4df696620d21	4879331396ab58aee3f0d7288e9ce9be236125856045cb04c025e5b66d73d251	2026-04-29 07:48:40.691667+00	20260429074840_add_content_script_and_type	\N	\N	2026-04-29 07:48:40.684334+00	1
e00ace3b-e698-491b-b669-6cda4ddaaebd	8546a0942a939f8b862bd4099350b8d0dcec1e1cf96899ee970ece3d3f33745e	2026-04-29 08:34:12.705481+00	20260429083412_add_account_follower_count	\N	\N	2026-04-29 08:34:12.699935+00	1
53c11c24-04e0-43bb-bb56-8ee9e40e3f97	ec9cf9be5097eb3497bf80445a9411b7fe0bd942aaaed1b65808898a5cdaf7de	2026-04-29 08:50:19.798399+00	20260429085019_add_account_custom_group	\N	\N	2026-04-29 08:50:19.787306+00	1
39f16966-17f4-417d-8e50-adecc598ca10	6ec00e6e4421407b5122c560d21d8735e013e0bdaca9c1153767e23daac21107	2026-04-29 09:08:25.149026+00	20260429090825_refactor_topic_fields	\N	\N	2026-04-29 09:08:25.136535+00	1
dc1484c9-0849-4287-9d61-bed14239b802	51ccf26bfb7390fb7f240639b1d85c5da2ae75c9bf55bd77a27dfb9d07bffec6	2026-04-30 01:53:52.768338+00	20260430015352_add_topic_script_copywriting	\N	\N	2026-04-30 01:53:52.76318+00	1
\.


--
-- Data for Name: account_groups; Type: TABLE DATA; Schema: public; Owner: smm
--

COPY public.account_groups (id, name, description, created_at, updated_at) FROM stdin;
76d171cd-f9e9-469f-9c9d-bd575389fa70	第一组	Danny负责 - Facebook/Instagram/TikTok/YouTube	2026-04-29 06:42:37.845	2026-04-29 06:42:37.845
8fb2b0e7-5965-4c13-a07d-3beb5b410fe3	第二组	Danny负责 - Boswindor Building Material 混剪账号02	2026-04-29 06:53:31.174	2026-04-29 06:53:31.174
3c997727-058f-4233-be9d-ae1dea7b46c9	第三组	Benny负责 - boswindor factory 副账号	2026-04-29 07:01:15.255	2026-04-29 07:01:15.255
36300c9f-2c11-4e06-9ebd-2632a3169f85	第四组	Danny负责 - Boswindor PremiumDoors 副账号	2026-04-29 07:07:07.522	2026-04-29 07:07:07.522
\.


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: smm
--

COPY public.accounts (id, platform, name, account_id, home_url, market, target_audience, status, persona, contact_info, group_id, tags, created_at, updated_at, account_type, common_devices, linked_phone, login_email, login_password, login_phone, registered_at, remark, follower_count, custom_group) FROM stdin;
d5cb501d-673d-4fd3-8887-e6b41abe8f9e	INSTAGRAM	boswindordoorswindowsfactory	\N	\N	\N	\N	ACTIVE	\N	\N	\N	\N	2026-04-29 09:51:38.436	2026-04-29 09:51:38.436	\N	\N	\N	boswindor02@outlook.com	Boswindor123$%	\N	\N	绑定了购买账号广告主页（邮箱登录）	0	\N
4201e725-b491-47f1-b49e-0930aa6530cd	YOUTUBE	boswindor.lulu	\N	\N	\N	\N	ACTIVE	\N	\N	\N	\N	2026-04-29 09:51:38.441	2026-04-29 09:51:38.441	\N	\N	\N	info@boswindor.com	Bos123$%	17329524698	\N	\N	37	\N
ed0c6902-fcfc-4162-b45b-401667d7b95a	TIKTOK	boswindor1	\N	\N	\N	\N	BANNED	\N	\N	\N	\N	2026-04-29 09:51:38.448	2026-04-29 09:51:38.448	\N	\N	\N	boswindor@gmail.com	Bos123456%	\N	\N	\N	0	\N
af19136f-b4b1-4d14-882b-45d173270cd1	TIKTOK	Boswindor Building Material	\N	\N	\N	\N	ACTIVE	\N	\N	\N	\N	2026-04-29 09:51:38.337	2026-04-30 06:47:16.44	混剪账号02	\N	\N	bhe05798@gmail.com	Boswindor250331+	18126652290	\N	\N	259	Danny 2
ec3b93f1-5ca9-49b4-8e2b-e6b7403d121f	FACEBOOK	boswindor Lulu	\N	\N	\N	\N	ACTIVE	\N	\N	\N	\N	2026-04-29 09:51:38.445	2026-04-30 06:27:02.638	\N	\N	\N	shuanglianguo311@gmail.com	gsl123456789	18681475702	\N	手机号：刘总手机号	8	
61d941b9-9f04-40df-aadd-361fcebad34d	YOUTUBE	Boswindor Building Material	\N	\N	\N	\N	ACTIVE	\N	\N	\N	\N	2026-04-29 09:51:38.345	2026-04-30 06:47:22.225	混剪账号02	\N	\N	bhe05798@gmail.com	Boswindor250331+	18126652290	\N	\N	3180	Danny 2
96a4ff80-b849-4157-97b2-5011ef50c461	INSTAGRAM	Boswindor doors and window	\N	\N	\N	\N	ACTIVE	\N	\N	\N	\N	2026-04-29 09:51:38.402	2026-04-30 06:47:55.287	混剪账号01	\N	\N	boswindor01@outlook.com	Boswindor123$%	\N	\N	\N	0	Benny 2
2ca6a531-7264-4d3c-8509-3b614cc117a4	YOUTUBE	Boswindor doors and window	\N	\N	\N	\N	ACTIVE	\N	\N	\N	\N	2026-04-29 09:51:38.396	2026-04-30 06:48:01.229	混剪账号01	\N	\N	boswindor05@gmail.com	Boswindor05$.@	18825938997	\N	邮箱密码	0	Benny 2
8659a69f-9730-49c9-a966-0bd79da063a8	FACEBOOK	Boswindor PremiumDoors	\N	\N	\N	\N	ACTIVE	\N	\N	\N	\N	2026-04-29 09:51:38.422	2026-04-30 06:49:09.462	副公共主页	\N	\N	boswindor06@gmail.com	Boswindor06$.	18126652290	\N	\N	0	Danny 1
ae540c97-8e38-4445-9300-75c8262cba1e	FACEBOOK	boswindor factory	\N	\N	\N	\N	ACTIVE	\N	\N	\N	\N	2026-04-29 09:51:38.362	2026-04-30 06:30:16.433	副公共主页01	\N	\N	zzhu96663@gmail.com	Bos123456	17329524698	\N	已注册公共主页	17	Benny 1
4cc5c22d-436a-4e3d-8f7f-ef51be999ef4	INSTAGRAM	boswindor_factory	\N	\N	\N	\N	ACTIVE	\N	\N	\N	\N	2026-04-29 09:51:38.37	2026-04-30 06:30:25.995	副账号01	\N	\N	zzhu96663@gmail.com	Bos123456	17329524698	\N	ins使用账号名称登陆账号	22	Benny 1
2ebd3f93-0620-46e0-b415-f89c2d067e45	TIKTOK	boswindor_factory	\N	\N	\N	\N	PAUSED	\N	\N	\N	\N	2026-04-29 09:51:38.386	2026-04-30 06:30:31.851	副账号01	\N	\N	Sienna4698@outlook.com	Bos123456	17329524698	\N	忘记密码，建议重新注册一个tk账号	0	Benny 1
d5ebd5a3-4e8c-47d0-acfc-ef9ece241473	YOUTUBE	boswindor_factory	\N	\N	\N	\N	ACTIVE	\N	\N	\N	\N	2026-04-29 09:51:38.379	2026-04-30 06:30:37.282	副账号01	\N	\N	zzhu96663@gmail.com	Bos123456	17329524698	\N	\N	2490	Benny 1
5bdb9e80-5d3a-4fa2-857b-18b1c526519d	FACEBOOK	Foshan Boswindor Window and Door Limited	\N	\N	\N	\N	ACTIVE	\N	\N	\N	\N	2026-04-29 09:51:38.299	2026-04-30 06:33:35.73	主公共主页	\N	\N	wudake264@gmail.com	Bos2025$	18681475702	\N	\N	553	Danny Benny
60a9d67a-e653-4c78-a4a3-492f13f43916	INSTAGRAM	boswindor_limited	\N	\N	\N	\N	ACTIVE	\N	\N	\N	\N	2026-04-29 09:51:38.312	2026-04-30 06:33:51.644	主账户	\N	\N	boswindor@gmail.com	Boswindor888888	\N	\N	\N	570	Danny Benny
0affcbeb-6ab5-4d86-a2ac-5e96dc3fa98f	TIKTOK	china_window_door	\N	\N	\N	\N	ACTIVE	\N	\N	\N	\N	2026-04-29 09:51:38.329	2026-04-30 06:34:01.87	主账户	\N	\N	zzhu96663@gmail.com	Bos123456	17329524698	\N	\N	1258	Danny Benny
37475525-9e6b-42cc-8dc8-3de96db08b6f	YOUTUBE	Foshan Boswindor Window and Door Limited	\N	\N	\N	\N	ACTIVE	\N	\N	\N	\N	2026-04-29 09:51:38.322	2026-04-30 06:34:11.17	主账户	\N	\N	boswindor@gmail.com	Boswindor123$%	\N	\N	\N	74	Danny Benny
8e069317-9f59-42ad-9487-7c69aa85224a	INSTAGRAM	Boswindor Building Material	\N	\N	\N	\N	ACTIVE	\N	\N	\N	\N	2026-04-29 09:51:38.353	2026-04-30 06:34:55.172	混剪账号02	\N	\N	zzhu96663@gmail.com	Bos123456	17329524698	\N	ins账号都要用用户名登录	26	Danny 2
e1fff405-11da-458f-8269-45af816e8637	INSTAGRAM	Boswindor PremiumDoors	\N	\N	\N	\N	ACTIVE	\N	\N	\N	\N	2026-04-29 09:51:38.408	2026-04-30 06:49:26.63	副账号	\N	\N	boswindor06@gmail.com	Boswindor06$.	18126652290	\N	\N	0	Danny 1
90d6b3b7-941a-4449-937a-5eeb4a7b43c4	YOUTUBE	Boswindor PremiumDoors	\N	\N	\N	\N	ACTIVE	\N	\N	\N	\N	2026-04-29 09:51:38.414	2026-04-30 06:49:31.364	副账号	\N	\N	boswindor06@gmail.com	Boswindor06$.	18126652290	\N	\N	7	Danny 1
b16620f7-2db8-4795-adf7-a38be56e7aae	TIKTOK	Boswindor-Premium-Doors	\N	\N	\N	\N	ACTIVE	\N	\N	\N	\N	2026-04-29 09:51:38.429	2026-04-30 06:49:40.867	副账号	\N	\N	boswindor06@gmail.com	Boswindor06$.	18126652290	\N	谷歌登录	0	Danny 1
\.


--
-- Data for Name: content_comments; Type: TABLE DATA; Schema: public; Owner: smm
--

COPY public.content_comments (id, content_id, user_id, content, created_at) FROM stdin;
\.


--
-- Data for Name: content_data; Type: TABLE DATA; Schema: public; Owner: smm
--

COPY public.content_data (id, content_id, account_id, views, likes, comments, shares, favorites, completion_rate, followers_gained, total_followers, dm_leads, comment_leads, profile_clicks, valid_leads, record_date, created_at) FROM stdin;
\.


--
-- Data for Name: contents; Type: TABLE DATA; Schema: public; Owner: smm
--

COPY public.contents (id, title, topic_id, operator_id, status, planned_publish_at, actual_publish_at, publish_url, description, attachments, production_time_hours, rating, remark, created_at, updated_at, content_type, script) FROM stdin;
4fed6aa2-97a6-425a-b82c-8112e69d232a	门窗五金配件介绍-04-29-6	\N	8fda33c9-5ef6-473b-8419-d9cd5db3ffe8	PENDING	2026-04-29 11:50:00	\N	\N	测试数据：2026-04-29 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:45.732	2026-04-30 14:50:45.732	repost	\N
a8255f7a-ba2a-47b9-8be8-1c40f0f880fb	Low-E玻璃节能效果-04-29-7	\N	e6cc3a1d-6c69-4077-93a0-4ac003de1060	PENDING	2026-04-29 13:55:00	\N	\N	测试数据：2026-04-29 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:45.751	2026-04-30 14:50:45.751	original	\N
8d7cbca9-bba2-4a04-adb9-9080409ff0f6	批量内容1	\N	\N	PENDING	\N	\N	\N	\N	\N	\N	\N	\N	2026-04-29 09:43:54.89	2026-04-29 09:43:54.89	product_showcase	\N
54ea072e-a7eb-4309-8b00-1228b77a372f	批量内容2	\N	\N	PENDING	\N	\N	\N	\N	\N	\N	\N	\N	2026-04-29 09:43:54.895	2026-04-29 09:43:54.895	installation_guide	\N
dd6d6cff-284b-42bf-b91f-3b0bef952ab9	门窗质检过程揭秘-04-29-8	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	PENDING	2026-04-29 17:28:00	\N	\N	测试数据：2026-04-29 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:45.766	2026-04-30 14:50:45.766	repost	\N
695d6c93-a44f-4b3b-8dad-cf8389967a4e	合作伙伴案例展示-04-29-9	\N	e6cc3a1d-6c69-4077-93a0-4ac003de1060	PENDING	2026-04-29 12:29:00	\N	\N	测试数据：2026-04-29 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:45.783	2026-04-30 14:50:45.783	repost	\N
22bafd5e-eabd-40bb-88bb-90e8141ea2ee	断桥铝门窗安装教程-04-29-10	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	PENDING	2026-04-29 11:41:00	\N	\N	测试数据：2026-04-29 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:45.798	2026-04-30 14:50:45.798	repost	\N
e531bf21-ac12-4817-8b6f-e86a28b2bc6c	批量内容1	\N	\N	PENDING	\N	\N	\N	\N	\N	\N	\N	\N	2026-04-29 09:45:14.319	2026-04-29 09:45:14.319	product_showcase	\N
a10c3e52-56eb-4159-b7fb-ca8644db03ab	批量内容2	\N	\N	PENDING	\N	\N	\N	\N	\N	\N	\N	\N	2026-04-29 09:45:14.324	2026-04-29 09:45:14.324	installation_guide	\N
c6f93285-5462-4c71-8bc2-a8028a67ed44	合作伙伴案例展示-04-30-1	\N	e6cc3a1d-6c69-4077-93a0-4ac003de1060	PENDING	2026-04-30 13:11:00	\N	\N	测试数据：2026-04-30 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:45.813	2026-04-30 14:50:45.813	repost	\N
48b20d22-eda3-4402-bf6e-694d6e08980d	门窗隔音效果实测-04-30-2	\N	8fda33c9-5ef6-473b-8419-d9cd5db3ffe8	PENDING	2026-04-30 09:41:00	\N	\N	测试数据：2026-04-30 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:45.833	2026-04-30 14:50:45.833	repost	\N
142be0ae-d466-4bc6-b5a6-698532ade71a	谢谢小星星	\N	8fda33c9-5ef6-473b-8419-d9cd5db3ffe8	PENDING	2026-04-30 00:00:00	\N	https://www.instagram.com/reels/DXZM9voGLG3/	\N	\N	\N	\N	\N	2026-04-30 14:45:01.074	2026-04-30 14:45:01.074	\N	\N
6eb8a465-035c-4176-86dc-9d637c01980c	门窗质检过程揭秘-04-30-3	\N	8fda33c9-5ef6-473b-8419-d9cd5db3ffe8	PENDING	2026-04-30 18:45:00	\N	\N	测试数据：2026-04-30 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:45.856	2026-04-30 14:50:45.856	repost	\N
0e17e72e-4167-41e9-a08b-cc12085824a5	464yukyuk	\N	e6cc3a1d-6c69-4077-93a0-4ac003de1060	PENDING	2026-04-29 00:00:00	\N	https://www.youtube.com/shorts/0B04YX94gv8	十大歌手帝国时代根深蒂固	\N	\N	\N	sdfgsdgsd	2026-04-29 08:25:07.266	2026-04-30 14:45:41.252	塑料袋福建省	到底是根深蒂固
7f9fa9ce-0af2-4c25-917a-63b73faa51f5	test	\N	e6cc3a1d-6c69-4077-93a0-4ac003de1060	PENDING	2026-04-28 00:00:00	\N	https://www.tiktok.com/@nataliireynoldss/video/7618407968077335838?is_from_webapp=1&sender_device=pc	\N	\N	\N	\N	\N	2026-04-30 14:46:43.379	2026-04-30 14:46:43.379	\N	\N
39ca1052-7a36-4f33-ad0b-47dd6a8b68c8	测试内容	\N	\N	PENDING	2026-04-29 10:00:00	\N	\N	\N	\N	\N	\N	\N	2026-04-30 14:50:12.289	2026-04-30 14:50:12.289	\N	\N
e8e310d9-f932-4927-841d-5c923c08ed4a	海外市场拓展经验-04-27-1	\N	8fda33c9-5ef6-473b-8419-d9cd5db3ffe8	PENDING	2026-04-27 10:58:00	\N	\N	测试数据：2026-04-27 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:45.578	2026-04-30 14:50:45.578	mixed	\N
0ca080bd-f14e-418d-8391-028b964e5846	定制流程全记录-04-27-2	\N	8fda33c9-5ef6-473b-8419-d9cd5db3ffe8	PENDING	2026-04-27 16:48:00	\N	\N	测试数据：2026-04-27 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:45.593	2026-04-30 14:50:45.593	repost	\N
f0513cc3-95b8-4e24-b66d-ee4febd4d28f	新品发布-智能门窗系统-04-27-3	\N	e6cc3a1d-6c69-4077-93a0-4ac003de1060	PENDING	2026-04-27 18:04:00	\N	\N	测试数据：2026-04-27 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:45.608	2026-04-30 14:50:45.608	original	\N
c1fea9ef-a046-4319-9f1e-c02be0243a37	门窗保养维护指南-04-28-1	\N	8fda33c9-5ef6-473b-8419-d9cd5db3ffe8	PENDING	2026-04-28 14:56:00	\N	\N	测试数据：2026-04-28 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:45.623	2026-04-30 14:50:45.623	mixed	\N
9971059a-3425-476a-8d0c-1b028b7ab21a	售后服务流程介绍-04-29-1	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	PENDING	2026-04-29 17:56:00	\N	\N	测试数据：2026-04-29 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:45.641	2026-04-30 14:50:45.641	original	\N
c563473d-0fc7-45cf-b35e-7d07947231d3	玻璃种类与选购指南-04-29-2	\N	e6cc3a1d-6c69-4077-93a0-4ac003de1060	PENDING	2026-04-29 12:31:00	\N	\N	测试数据：2026-04-29 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:45.654	2026-04-30 14:50:45.654	original	\N
aadf08cc-509c-4fa7-9bd7-56010efeb89c	门窗防水性能展示-04-29-3	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	PENDING	2026-04-29 13:36:00	\N	\N	测试数据：2026-04-29 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:45.672	2026-04-30 14:50:45.672	repost	\N
0265ba15-07f1-4547-b633-2447c8d11e34	定制流程全记录-04-29-4	\N	8fda33c9-5ef6-473b-8419-d9cd5db3ffe8	PENDING	2026-04-29 14:38:00	\N	\N	测试数据：2026-04-29 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:45.692	2026-04-30 14:50:45.692	original	\N
7f2034b2-80df-4be4-951f-7cd48785fc07	Low-E玻璃节能效果-04-29-5	\N	e6cc3a1d-6c69-4077-93a0-4ac003de1060	PENDING	2026-04-29 17:27:00	\N	\N	测试数据：2026-04-29 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:45.712	2026-04-30 14:50:45.712	original	\N
81a0a235-c0ba-4173-8aea-bbedc6efbb7c	阳光房设计案例分享-04-30-4	\N	e6cc3a1d-6c69-4077-93a0-4ac003de1060	PENDING	2026-04-30 17:16:00	\N	\N	测试数据：2026-04-30 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:45.872	2026-04-30 14:50:45.872	repost	\N
3c74d3f1-f2de-4dbc-9ef0-b2da08688b48	玻璃种类与选购指南-05-01-1	\N	e6cc3a1d-6c69-4077-93a0-4ac003de1060	PENDING	2026-05-01 09:17:00	\N	\N	测试数据：2026-05-01 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:45.893	2026-04-30 14:50:45.893	original	\N
f86d6349-3cec-4368-ad40-bbb7d1b621a2	门窗安全性能测试-05-01-2	\N	e6cc3a1d-6c69-4077-93a0-4ac003de1060	PENDING	2026-05-01 11:49:00	\N	\N	测试数据：2026-05-01 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:45.914	2026-04-30 14:50:45.914	original	\N
b965c06b-19e0-4eef-9fc8-f5d4ea108937	海外客户考察记录-05-01-3	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	PENDING	2026-05-01 16:32:00	\N	\N	测试数据：2026-05-01 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:45.934	2026-04-30 14:50:45.934	repost	\N
413ec705-2b35-48d6-8c58-35b2cef35f69	门窗行业趋势分析-05-01-4	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	PENDING	2026-05-01 09:58:00	\N	\N	测试数据：2026-05-01 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:45.952	2026-04-30 14:50:45.952	repost	\N
7d3a9849-f043-48e9-8555-e174f4a02f97	阳光房设计案例分享-05-01-5	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	PENDING	2026-05-01 11:09:00	\N	\N	测试数据：2026-05-01 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:45.969	2026-04-30 14:50:45.969	repost	\N
93a01f43-8443-4caa-8aed-3ab227260ea6	断桥铝vs普通铝合金对比-05-02-1	\N	e6cc3a1d-6c69-4077-93a0-4ac003de1060	PENDING	2026-05-02 11:14:00	\N	\N	测试数据：2026-05-02 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:45.986	2026-04-30 14:50:45.986	original	\N
04e0f45a-6f8c-468d-b731-031293594823	门窗行业趋势分析-05-02-2	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	PENDING	2026-05-02 18:11:00	\N	\N	测试数据：2026-05-02 发布的内容	\N	\N	\N	\N	2026-04-30 14:50:46.004	2026-04-30 14:50:46.004	original	\N
\.


--
-- Data for Name: dictionaries; Type: TABLE DATA; Schema: public; Owner: smm
--

COPY public.dictionaries (id, category, code, name, sort_order, is_active, created_at, updated_at) FROM stdin;
c3c2dfe8-54f7-4cfc-a856-5b4731e4c3f5	product_type	bridge_aluminum	断桥铝	0	t	2026-04-29 03:34:24.811	2026-04-29 03:34:24.811
cc9372e8-7f7e-44c3-a246-c6aa30f69049	product_type	system_window	系统窗	0	t	2026-04-29 03:34:24.811	2026-04-29 03:34:24.811
daad63db-144d-4d8d-b463-40d1e9dd8e8c	product_type	sunroom	阳光房	0	t	2026-04-29 03:34:24.811	2026-04-29 03:34:24.811
d07a1897-2099-416e-9ecf-21b6da1b6753	content_type	factory_tour	工厂实拍	0	t	2026-04-29 03:34:24.811	2026-04-29 03:34:24.811
4eeca42a-6bbb-4361-adad-e341aa8f8752	content_type	installation	安装案例	0	t	2026-04-29 03:34:24.811	2026-04-29 03:34:24.811
ba5a23c7-b5ff-4cde-afe4-6666d1259fc7	content_type	review	产品测评	0	t	2026-04-29 03:34:24.811	2026-04-29 03:34:24.811
b29dc555-474d-4b07-b908-b3a825016818	content_type	knowledge	科普知识	0	t	2026-04-29 03:34:24.811	2026-04-29 03:34:24.811
2a59ae32-7fb4-44b3-a7cc-ecdb3b2bcc42	market	north_america	北美	0	t	2026-04-29 03:34:24.811	2026-04-29 03:34:24.811
7214c964-6d8c-4fe5-8986-329c2041836b	market	europe	欧洲	0	t	2026-04-29 03:34:24.811	2026-04-29 03:34:24.811
eba01588-285f-47ca-9772-5af7d3d77ab1	market	southeast_asia	东南亚	0	t	2026-04-29 03:34:24.811	2026-04-29 03:34:24.811
\.


--
-- Data for Name: leads; Type: TABLE DATA; Schema: public; Owner: smm
--

COPY public.leads (id, source_platform, source_content_id, source_account_id, operator_id, lead_time, customer_name, customer_contact, requirement, status, is_valid, valid_confirmed_by, valid_confirmed_at, deal_amount, remark, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: materials; Type: TABLE DATA; Schema: public; Owner: smm
--

COPY public.materials (id, name, nas_path, thumbnail_path, category, tags, description, file_type, file_size, usage_count, is_sensitive, allowed_roles, created_by, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: smm
--

COPY public.notifications (id, user_id, type, title, content, is_read, link, created_at) FROM stdin;
\.


--
-- Data for Name: operation_logs; Type: TABLE DATA; Schema: public; Owner: smm
--

COPY public.operation_logs (id, user_id, username, action, resource, resource_id, detail, ip_address, user_agent, created_at) FROM stdin;
\.


--
-- Data for Name: topics; Type: TABLE DATA; Schema: public; Owner: smm
--

COPY public.topics (id, title, content_form, tags, product_type, content_type, source, status, usage_count, remark, created_by, created_at, updated_at, completed_at, is_completed, operator_id, published_accounts, copywriting, script) FROM stdin;
633788c7-47ac-4b26-a204-1e764cf03ff5	How we pack aluminum windows and doors for sea shipping	SHORT_VIDEO	{aluminum_window,shipping}	\N	factory_tour	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:24.933	2026-04-29 09:03:24.933	\N	f	\N	\N	\N	\N
7757c039-d488-495d-bee6-2d4bc558e451	What should Australian builders check before ordering windows from China?	SHORT_VIDEO	{china,australia}	\N	review	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:24.944	2026-04-29 09:03:24.944	\N	f	\N	\N	\N	\N
d794e0aa-2b49-40fc-9984-f43631b70870	How Are Aluminum Windows Made in a Factory?	SHORT_VIDEO	{aluminum_window,factory}	\N	factory_tour	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:24.951	2026-04-29 09:03:24.951	\N	f	\N	\N	\N	\N
63cda07a-5df9-49cb-a8bb-4acaefdb1c6f	What Does a Reliable Window Factory Look Like?	SHORT_VIDEO	{factory}	\N	factory_tour	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:24.957	2026-04-29 09:03:24.957	\N	f	\N	\N	\N	\N
ecdcf409-e28e-41df-9e9e-511d07d18885	How Do We Check Aluminum Window Quality Before Shipping?	SHORT_VIDEO	{aluminum_window,shipping,quality}	\N	factory_tour	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:24.963	2026-04-29 09:03:24.963	\N	f	\N	\N	\N	\N
2f2adb04-264e-4fab-845c-7313cc8fa2f2	How Are Windows Packed for Overseas Shipping?	SHORT_VIDEO	{shipping}	\N	factory_tour	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:24.97	2026-04-29 09:03:24.97	\N	f	\N	\N	\N	\N
1b12eab6-8f77-4a5b-887e-0617f289dcc1	What Happens Before Aluminum Windows Are Loaded into Containers?	SHORT_VIDEO	{aluminum_window}	\N	factory_tour	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:24.976	2026-04-29 09:03:24.976	\N	f	\N	\N	\N	\N
b0808214-d4df-4224-97ed-0ef5bc10a327	How Do We Make Sure Custom Windows Match the Drawings?	SHORT_VIDEO	{custom}	\N	review	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:24.98	2026-04-29 09:03:24.98	\N	f	\N	\N	\N	\N
db87da99-508a-4da5-81e8-3758c48a0894	What Makes a High-Quality Aluminum Window?	SHORT_VIDEO	{aluminum_window,quality}	\N	review	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:24.985	2026-04-29 09:03:24.985	\N	f	\N	\N	\N	\N
545c09d2-e063-48e9-901b-03f9c42e0665	Why Does Aluminum Profile Thickness Matter?	SHORT_VIDEO	{}	\N	review	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:24.991	2026-04-29 09:03:24.991	\N	f	\N	\N	\N	\N
cf397fcf-69e1-49d5-b129-739ca4973064	What Is Inside a Thermal Break Aluminum Window?	SHORT_VIDEO	{aluminum_window,thermal_break}	\N	knowledge	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:24.996	2026-04-29 09:03:24.996	\N	f	\N	\N	\N	\N
453a6412-de56-412e-86a0-f39491f92a3c	How Does Low-E Glass Work?	SHORT_VIDEO	{low_e_glass}	\N	knowledge	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25	2026-04-29 09:03:25	\N	f	\N	\N	\N	\N
cb74b14d-532b-49e4-9162-d61802c80f13	Why Are Good Window Seals Important?	SHORT_VIDEO	{}	\N	review	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.006	2026-04-29 09:03:25.006	\N	f	\N	\N	\N	\N
6c0a6d7a-664a-4cd1-ba9d-82b5b916515c	How Do Multi-Point Locks Improve Window Security?	SHORT_VIDEO	{security}	\N	review	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.011	2026-04-29 09:03:25.011	\N	f	\N	\N	\N	\N
1315950f-9c48-4ce2-9ea4-0dba36eae49b	What Hardware Should Good Aluminum Windows Use?	SHORT_VIDEO	{aluminum_window}	\N	review	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.016	2026-04-29 09:03:25.016	\N	f	\N	\N	\N	\N
cfc30b0b-aa41-4225-9bdf-f520f5d74db0	Aluminum Windows or Vinyl Windows: Which Is Better?	SHORT_VIDEO	{aluminum_window,vinyl}	\N	comparison	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.021	2026-04-29 09:03:25.021	\N	f	\N	\N	\N	\N
b63844f1-cbab-400b-82d4-4fc1958b5d8a	Cheap Windows or Quality Windows: What Is the Real Difference?	SHORT_VIDEO	{quality}	\N	review	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.025	2026-04-29 09:03:25.025	\N	f	\N	\N	\N	\N
bec5670b-dbc2-4f56-b79f-671151d8801f	Regular Aluminum Windows or Thermal Break Aluminum Windows?	SHORT_VIDEO	{aluminum_window,thermal_break}	\N	comparison	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.029	2026-04-29 09:03:25.029	\N	f	\N	\N	\N	\N
29532783-cde7-40c0-b9e0-4c7326974262	Single Glass or Double Glazing: Which Should You Choose?	SHORT_VIDEO	{double_glazing}	\N	comparison	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.034	2026-04-29 09:03:25.034	\N	f	\N	\N	\N	\N
8412b151-a7a3-4f61-8304-e56fd702a01a	Regular Windows or Impact Windows: What Is the Difference?	SHORT_VIDEO	{impact_window}	\N	comparison	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.038	2026-04-29 09:03:25.038	\N	f	\N	\N	\N	\N
cef72c84-d496-4475-9aa9-eb56a0c9a840	Local Retail Windows or Factory-Direct Windows?	SHORT_VIDEO	{factory}	\N	factory_tour	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.044	2026-04-29 09:03:25.044	\N	f	\N	\N	\N	\N
3bbd83f8-e055-4b0f-adf2-ee43aef3e208	How Do Aluminum Windows Look After Installation?	SHORT_VIDEO	{aluminum_window,installation}	\N	installation	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.05	2026-04-29 09:03:25.05	\N	f	\N	\N	\N	\N
1abf123a-b484-483e-9ea4-87d175ff74ab	What Windows Did This Villa Project Use?	SHORT_VIDEO	{villa}	\N	installation	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.055	2026-04-29 09:03:25.055	\N	f	\N	\N	\N	\N
ef761251-3865-43d6-9247-fbdd01aa13d0	How Do Aluminum Bifold Doors Look in a Modern Home?	SHORT_VIDEO	{bifold_door}	\N	installation	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.06	2026-04-29 09:03:25.06	\N	f	\N	\N	\N	\N
d8267b73-ccdd-459f-81d7-e845309de7f2	What Window System Was Used in This Commercial Project?	SHORT_VIDEO	{commercial}	\N	installation	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.065	2026-04-29 09:03:25.065	\N	f	\N	\N	\N	\N
79fd9b69-ca6c-4a6c-b69a-684b29e05e58	How Were These Custom Windows Produced for an Overseas Client?	SHORT_VIDEO	{custom}	\N	factory_tour	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.069	2026-04-29 09:03:25.069	\N	f	\N	\N	\N	\N
93d37ddd-3ed7-4c7f-965d-b58044851154	Why Did This Contractor Choose Factory-Direct Aluminum Windows?	SHORT_VIDEO	{aluminum_window,factory}	\N	factory_tour	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.074	2026-04-29 09:03:25.074	\N	f	\N	\N	\N	\N
ae9fce9b-1b41-4a70-bf7d-b79a078f2c5d	How to choose a reliable aluminum window supplier from China?	SHORT_VIDEO	{aluminum_window,china}	\N	buying_guide	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.079	2026-04-29 09:03:25.079	\N	f	\N	\N	\N	\N
6a686f7f-5455-4a9c-82b0-6349b72bc674	Where can I find aluminum window manufacturers?	SHORT_VIDEO	{aluminum_window}	\N	buying_guide	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.084	2026-04-29 09:03:25.084	\N	f	\N	\N	\N	\N
1d0580a4-0fd0-43b3-ba42-172a7fade756	How do I find a reliable window and door manufacturer?	SHORT_VIDEO	{}	\N	comparison	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.09	2026-04-29 09:03:25.09	\N	f	\N	\N	\N	\N
298b1cd2-6794-45e4-b44a-e6041624cb9b	Where can contractors buy wholesale windows and doors?	SHORT_VIDEO	{}	\N	buying_guide	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.094	2026-04-29 09:03:25.094	\N	f	\N	\N	\N	\N
513421a3-60ed-4675-bfd8-dd70818eeebf	Is factory-direct window supply cheaper than local retail?	SHORT_VIDEO	{factory}	\N	factory_tour	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.1	2026-04-29 09:03:25.1	\N	f	\N	\N	\N	\N
17a2a2ad-48b4-41be-a29b-02161daddf69	How can builders import windows and doors from China?	SHORT_VIDEO	{china}	\N	buying_guide	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.105	2026-04-29 09:03:25.105	\N	f	\N	\N	\N	\N
f44f75fb-155a-423e-9ea3-1360fd886462	What should I ask before buying windows from a factory?	SHORT_VIDEO	{factory}	\N	factory_tour	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.112	2026-04-29 09:03:25.112	\N	f	\N	\N	\N	\N
95d53b17-9c33-4505-8e4e-3d7ea3c2435f	How do I verify a Chinese aluminum window supplier?	SHORT_VIDEO	{aluminum_window}	\N	buying_guide	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.117	2026-04-29 09:03:25.117	\N	f	\N	\N	\N	\N
c546ebc8-70aa-42ed-9f91-0c53a8b8d28b	What makes a good aluminum window manufacturer?	SHORT_VIDEO	{aluminum_window}	\N	buying_guide	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.121	2026-04-29 09:03:25.121	\N	f	\N	\N	\N	\N
d4082167-0019-4d5a-bcd8-2eeac0d7ab11	How do I compare window and door suppliers?	SHORT_VIDEO	{}	\N	comparison	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.126	2026-04-29 09:03:25.126	\N	f	\N	\N	\N	\N
b9969f9e-7c27-41cd-9f9b-df98d6bc32c1	What are the best aluminum windows?	SHORT_VIDEO	{aluminum_window}	\N	knowledge	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.131	2026-04-29 09:03:25.131	\N	f	\N	\N	\N	\N
06fd7fde-ca1e-4879-a5f0-9a67233bb7e7	Are aluminum windows better than vinyl windows?	SHORT_VIDEO	{aluminum_window,vinyl}	\N	comparison	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.136	2026-04-29 09:03:25.136	\N	f	\N	\N	\N	\N
b1bafbb1-bc3c-424d-9787-d4a0a8a5930a	What are thermal break aluminum windows?	SHORT_VIDEO	{aluminum_window,thermal_break}	\N	knowledge	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.143	2026-04-29 09:03:25.143	\N	f	\N	\N	\N	\N
77a9739e-1673-4a96-99c3-a9e4e1b59cad	Are thermal break aluminum windows worth it?	SHORT_VIDEO	{aluminum_window,thermal_break}	\N	knowledge	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.149	2026-04-29 09:03:25.149	\N	f	\N	\N	\N	\N
9909b30f-6bda-4060-a8b9-b6d2cf8f370c	What are the best aluminum sliding windows?	SHORT_VIDEO	{sliding_window}	\N	knowledge	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.155	2026-04-29 09:03:25.155	\N	f	\N	\N	\N	\N
ecccc80a-f532-4043-bafa-a09ae60f7947	How do I choose aluminum casement windows?	SHORT_VIDEO	{casement_window}	\N	buying_guide	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.16	2026-04-29 09:03:25.16	\N	f	\N	\N	\N	\N
ebfd03f6-4332-4a26-9c55-4973fa89e9e2	What are the best aluminum bifold doors?	SHORT_VIDEO	{bifold_door}	\N	knowledge	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.165	2026-04-29 09:03:25.165	\N	f	\N	\N	\N	\N
036f7df9-d018-421f-aec0-c689a1401e47	How do I choose aluminum patio doors?	SHORT_VIDEO	{patio_door}	\N	buying_guide	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.169	2026-04-29 09:03:25.169	\N	f	\N	\N	\N	\N
4ae5eaaa-6233-48d4-af11-49692f360100	What aluminum profile thickness is best for windows?	SHORT_VIDEO	{}	\N	review	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.174	2026-04-29 09:03:25.174	\N	f	\N	\N	\N	\N
1761dc3e-518b-4f84-bb5e-34bceb54846e	How much do aluminum windows cost?	SHORT_VIDEO	{aluminum_window,cost}	\N	pricing	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.177	2026-04-29 09:03:25.177	\N	f	\N	\N	\N	\N
5e569e17-e23b-4063-a020-7efe12a7ac69	Why do window prices vary so much?	SHORT_VIDEO	{price}	\N	pricing	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.179	2026-04-29 09:03:25.179	\N	f	\N	\N	\N	\N
dad0e642-ffcf-4f77-b5e8-0d14e434c4dc	What affects the price of aluminum windows and doors?	SHORT_VIDEO	{aluminum_window,price}	\N	pricing	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.183	2026-04-29 09:03:25.183	\N	f	\N	\N	\N	\N
d82b07fd-aab8-4264-85e9-7873c113406d	Are Chinese aluminum windows cost-effective?	SHORT_VIDEO	{aluminum_window,cost}	\N	pricing	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.186	2026-04-29 09:03:25.186	\N	f	\N	\N	\N	\N
9c4177de-4c3e-4abd-819a-43bf4f455446	How can contractors reduce window costs?	SHORT_VIDEO	{cost}	\N	pricing	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.19	2026-04-29 09:03:25.19	\N	f	\N	\N	\N	\N
f60f28af-9e6c-43d6-827c-74d94a3c95cc	Is it cheaper to buy windows directly from a factory?	SHORT_VIDEO	{factory}	\N	factory_tour	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.193	2026-04-29 09:03:25.193	\N	f	\N	\N	\N	\N
c6986ac6-8dd7-46d5-a66f-59b89ee8e295	What are the best replacement windows for the money?	SHORT_VIDEO	{}	\N	comparison	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.197	2026-04-29 09:03:25.197	\N	f	\N	\N	\N	\N
3e10f011-8db8-4e8f-b276-34ca2ae2f614	How much do impact windows cost?	SHORT_VIDEO	{impact_window,cost}	\N	pricing	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.2	2026-04-29 09:03:25.2	\N	f	\N	\N	\N	\N
77303e1d-d121-4b3b-874c-03eb11364734	How does bulk ordering affect window prices?	SHORT_VIDEO	{price,bulk_order}	\N	pricing	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.204	2026-04-29 09:03:25.204	\N	f	\N	\N	\N	\N
4a83b7e1-3dc4-47d6-bdc9-0b2ba767eb85	What are the risks of buying cheap windows?	SHORT_VIDEO	{}	\N	pricing	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.208	2026-04-29 09:03:25.208	\N	f	\N	\N	\N	\N
a0a6c9f3-d78e-4d67-bd48-a74d7068dd76	What are the best energy-efficient windows?	SHORT_VIDEO	{energy_efficient}	\N	knowledge	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.212	2026-04-29 09:03:25.212	\N	f	\N	\N	\N	\N
e086a576-fd8e-481e-ac73-7d80bdc5fa48	How do thermal break aluminum windows improve insulation?	SHORT_VIDEO	{aluminum_window,thermal_break}	\N	knowledge	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.217	2026-04-29 09:03:25.217	\N	f	\N	\N	\N	\N
b2cf4797-d5a4-4783-9296-11744aca4abd	What is the difference between Low-E glass and regular glass?	SHORT_VIDEO	{low_e_glass}	\N	comparison	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.221	2026-04-29 09:03:25.221	\N	f	\N	\N	\N	\N
385ee5fd-0e67-49dc-910a-088e745c910a	What are impact windows?	SHORT_VIDEO	{impact_window}	\N	knowledge	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.225	2026-04-29 09:03:25.225	\N	f	\N	\N	\N	\N
5ae0496a-f9f8-449d-b328-f213e0a70f25	What is the difference between impact windows and regular windows?	SHORT_VIDEO	{impact_window}	\N	comparison	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.229	2026-04-29 09:03:25.229	\N	f	\N	\N	\N	\N
84ee192c-6e52-4b99-ad99-82ec261620ec	Are impact windows worth it in Florida?	SHORT_VIDEO	{impact_window,florida}	\N	knowledge	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.233	2026-04-29 09:03:25.233	\N	f	\N	\N	\N	\N
21a93805-7557-4133-90e2-78c16363dc09	How do I choose windows for a commercial project?	SHORT_VIDEO	{commercial}	\N	comparison	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.237	2026-04-29 09:03:25.237	\N	f	\N	\N	\N	\N
6e410ba9-3128-44a6-bbdf-1ba734ad844e	Where can I find commercial aluminum window manufacturers?	SHORT_VIDEO	{aluminum_window,commercial}	\N	buying_guide	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.242	2026-04-29 09:03:25.242	\N	f	\N	\N	\N	\N
fd67e858-12f6-4d3e-ac01-a14399f3b74d	How can contractors source custom windows for building projects?	SHORT_VIDEO	{custom}	\N	comparison	\N	PENDING	0	\N	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.249	2026-04-29 09:03:25.249	\N	f	\N	\N	\N	\N
9539df2b-e531-44a7-86e1-38d3d81bfe6b	Modern aluminum window designs	SHORT_VIDEO	{aluminum_window,custom}	\N	工厂实拍	\N	PENDING	0	wegweg	22f85b94-9b07-42b6-8e2c-2d5df13694ee	2026-04-29 09:03:25.254	2026-04-30 06:16:26.512	2026-04-30 00:00:00	t	8fda33c9-5ef6-473b-8419-d9cd5db3ffe8	d5cb501d-673d-4fd3-8887-e6b41abe8f9e	wegweg	wegweg
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: smm
--

COPY public.users (id, username, password_hash, real_name, role, email, phone, avatar, status, created_at, updated_at) FROM stdin;
22f85b94-9b07-42b6-8e2c-2d5df13694ee	admin	$2b$10$BIP7lJ/R/A5IgizlTZFn4.0Zz/GE/l0g40W7xi9FuCBql0QvA0.g2	超级管理员	SUPER_ADMIN	admin@factory.com	\N	\N	ACTIVE	2026-04-29 03:34:24.79	2026-04-29 03:34:24.79
8fda33c9-5ef6-473b-8419-d9cd5db3ffe8	danny	$2b$10$BUL9wZlwSWtaQvcbgeAMLuXUkqyciwt0ovgr9mrVCFmUHcnFiKw7W	Danny	OPERATOR	danny@factory.com	\N	\N	ACTIVE	2026-04-29 06:37:17.782	2026-04-29 06:37:17.782
e6cc3a1d-6c69-4077-93a0-4ac003de1060	benny	$2b$10$4ipiFQvosePDw05W.XUWhOreMW7rYhhlWgkp67eriCjcPT/vul.82	Benny	OPERATOR	\N	\N	\N	ACTIVE	2026-04-29 07:01:38.952	2026-04-29 07:01:38.952
\.


--
-- Name: _AccountToContent _AccountToContent_AB_pkey; Type: CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public."_AccountToContent"
    ADD CONSTRAINT "_AccountToContent_AB_pkey" PRIMARY KEY ("A", "B");


--
-- Name: _AccountToUser _AccountToUser_AB_pkey; Type: CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public."_AccountToUser"
    ADD CONSTRAINT "_AccountToUser_AB_pkey" PRIMARY KEY ("A", "B");


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: account_groups account_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.account_groups
    ADD CONSTRAINT account_groups_pkey PRIMARY KEY (id);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: content_comments content_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.content_comments
    ADD CONSTRAINT content_comments_pkey PRIMARY KEY (id);


--
-- Name: content_data content_data_pkey; Type: CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.content_data
    ADD CONSTRAINT content_data_pkey PRIMARY KEY (id);


--
-- Name: contents contents_pkey; Type: CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.contents
    ADD CONSTRAINT contents_pkey PRIMARY KEY (id);


--
-- Name: dictionaries dictionaries_pkey; Type: CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.dictionaries
    ADD CONSTRAINT dictionaries_pkey PRIMARY KEY (id);


--
-- Name: leads leads_pkey; Type: CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.leads
    ADD CONSTRAINT leads_pkey PRIMARY KEY (id);


--
-- Name: materials materials_pkey; Type: CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.materials
    ADD CONSTRAINT materials_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: operation_logs operation_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.operation_logs
    ADD CONSTRAINT operation_logs_pkey PRIMARY KEY (id);


--
-- Name: topics topics_pkey; Type: CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: _AccountToContent_B_index; Type: INDEX; Schema: public; Owner: smm
--

CREATE INDEX "_AccountToContent_B_index" ON public."_AccountToContent" USING btree ("B");


--
-- Name: _AccountToUser_B_index; Type: INDEX; Schema: public; Owner: smm
--

CREATE INDEX "_AccountToUser_B_index" ON public."_AccountToUser" USING btree ("B");


--
-- Name: content_data_content_id_account_id_record_date_key; Type: INDEX; Schema: public; Owner: smm
--

CREATE UNIQUE INDEX content_data_content_id_account_id_record_date_key ON public.content_data USING btree (content_id, account_id, record_date);


--
-- Name: dictionaries_category_code_key; Type: INDEX; Schema: public; Owner: smm
--

CREATE UNIQUE INDEX dictionaries_category_code_key ON public.dictionaries USING btree (category, code);


--
-- Name: users_username_key; Type: INDEX; Schema: public; Owner: smm
--

CREATE UNIQUE INDEX users_username_key ON public.users USING btree (username);


--
-- Name: _AccountToContent _AccountToContent_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public."_AccountToContent"
    ADD CONSTRAINT "_AccountToContent_A_fkey" FOREIGN KEY ("A") REFERENCES public.accounts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _AccountToContent _AccountToContent_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public."_AccountToContent"
    ADD CONSTRAINT "_AccountToContent_B_fkey" FOREIGN KEY ("B") REFERENCES public.contents(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _AccountToUser _AccountToUser_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public."_AccountToUser"
    ADD CONSTRAINT "_AccountToUser_A_fkey" FOREIGN KEY ("A") REFERENCES public.accounts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _AccountToUser _AccountToUser_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public."_AccountToUser"
    ADD CONSTRAINT "_AccountToUser_B_fkey" FOREIGN KEY ("B") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: accounts accounts_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.account_groups(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: content_comments content_comments_content_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.content_comments
    ADD CONSTRAINT content_comments_content_id_fkey FOREIGN KEY (content_id) REFERENCES public.contents(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: content_comments content_comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.content_comments
    ADD CONSTRAINT content_comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: content_data content_data_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.content_data
    ADD CONSTRAINT content_data_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.accounts(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: content_data content_data_content_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.content_data
    ADD CONSTRAINT content_data_content_id_fkey FOREIGN KEY (content_id) REFERENCES public.contents(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: contents contents_operator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.contents
    ADD CONSTRAINT contents_operator_id_fkey FOREIGN KEY (operator_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: contents contents_topic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.contents
    ADD CONSTRAINT contents_topic_id_fkey FOREIGN KEY (topic_id) REFERENCES public.topics(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: leads leads_operator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.leads
    ADD CONSTRAINT leads_operator_id_fkey FOREIGN KEY (operator_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: leads leads_source_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.leads
    ADD CONSTRAINT leads_source_account_id_fkey FOREIGN KEY (source_account_id) REFERENCES public.accounts(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: leads leads_source_content_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.leads
    ADD CONSTRAINT leads_source_content_id_fkey FOREIGN KEY (source_content_id) REFERENCES public.contents(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: materials materials_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.materials
    ADD CONSTRAINT materials_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: topics topics_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smm
--

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

\unrestrict vXHYWdZ9IlEMHyD9eZ01h5Hgh15bx7PSHEcmLPQPNwIS8xPWgECDa7f6bfYSFC8

