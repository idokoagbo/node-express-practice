--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

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
-- Name: transaction_type; Type: TYPE; Schema: public; Owner: me
--

CREATE TYPE public.transaction_type AS ENUM (
    'debit',
    'credit'
);


ALTER TYPE public.transaction_type OWNER TO me;

--
-- Name: trip_status; Type: TYPE; Schema: public; Owner: me
--

CREATE TYPE public.trip_status AS ENUM (
    'accepted',
    'ongoing',
    'completed',
    'cancelled'
);


ALTER TYPE public.trip_status OWNER TO me;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: transactions; Type: TABLE; Schema: public; Owner: me
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    user_id integer,
    amount integer,
    notes text,
    type public.transaction_type
);


ALTER TABLE public.transactions OWNER TO me;

--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: me
--

CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transactions_id_seq OWNER TO me;

--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: me
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: trips; Type: TABLE; Schema: public; Owner: me
--

CREATE TABLE public.trips (
    id integer NOT NULL,
    user_id integer,
    rider_id integer,
    origin jsonb,
    destination jsonb,
    status public.trip_status,
    cost integer,
    meta_data json,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.trips OWNER TO me;

--
-- Name: trips_id_seq; Type: SEQUENCE; Schema: public; Owner: me
--

CREATE SEQUENCE public.trips_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trips_id_seq OWNER TO me;

--
-- Name: trips_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: me
--

ALTER SEQUENCE public.trips_id_seq OWNED BY public.trips.id;


--
-- Name: user_payments; Type: TABLE; Schema: public; Owner: me
--

CREATE TABLE public.user_payments (
    id integer NOT NULL,
    user_id integer,
    last4 character varying(4),
    exp_month character varying(2),
    exp_year character varying(4),
    card_type character varying(30),
    auth_code character varying(30),
    signature character varying(32),
    meta_data json,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.user_payments OWNER TO me;

--
-- Name: user_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: me
--

CREATE SEQUENCE public.user_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_payments_id_seq OWNER TO me;

--
-- Name: user_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: me
--

ALTER SEQUENCE public.user_payments_id_seq OWNED BY public.user_payments.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: me
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(30),
    email character varying(30) DEFAULT NULL::character varying,
    password character varying(64) DEFAULT NULL::character varying,
    meta_data json,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.users OWNER TO me;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: me
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO me;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: me
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: me
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Name: trips id; Type: DEFAULT; Schema: public; Owner: me
--

ALTER TABLE ONLY public.trips ALTER COLUMN id SET DEFAULT nextval('public.trips_id_seq'::regclass);


--
-- Name: user_payments id; Type: DEFAULT; Schema: public; Owner: me
--

ALTER TABLE ONLY public.user_payments ALTER COLUMN id SET DEFAULT nextval('public.user_payments_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: me
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: me
--

COPY public.transactions (id, user_id, amount, notes, type) FROM stdin;
\.


--
-- Data for Name: trips; Type: TABLE DATA; Schema: public; Owner: me
--

COPY public.trips (id, user_id, rider_id, origin, destination, status, cost, meta_data, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: user_payments; Type: TABLE DATA; Schema: public; Owner: me
--

COPY public.user_payments (id, user_id, last4, exp_month, exp_year, card_type, auth_code, signature, meta_data, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: me
--

COPY public.users (id, name, email, password, meta_data, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: me
--

SELECT pg_catalog.setval('public.transactions_id_seq', 1, false);


--
-- Name: trips_id_seq; Type: SEQUENCE SET; Schema: public; Owner: me
--

SELECT pg_catalog.setval('public.trips_id_seq', 1, false);


--
-- Name: user_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: me
--

SELECT pg_catalog.setval('public.user_payments_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: me
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: me
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: trips trips_pkey; Type: CONSTRAINT; Schema: public; Owner: me
--

ALTER TABLE ONLY public.trips
    ADD CONSTRAINT trips_pkey PRIMARY KEY (id);


--
-- Name: user_payments user_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: me
--

ALTER TABLE ONLY public.user_payments
    ADD CONSTRAINT user_payments_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: me
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: me
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: trips trips_rider_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: me
--

ALTER TABLE ONLY public.trips
    ADD CONSTRAINT trips_rider_id_fkey FOREIGN KEY (rider_id) REFERENCES public.users(id);


--
-- Name: trips trips_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: me
--

ALTER TABLE ONLY public.trips
    ADD CONSTRAINT trips_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: user_payments user_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: me
--

ALTER TABLE ONLY public.user_payments
    ADD CONSTRAINT user_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

