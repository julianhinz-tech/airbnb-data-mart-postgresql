-- =============================================
-- Airbnb Data Mart - Final Version
-- DBMS: Postgre SQL

-- Contents:
--		1) Schema (tables, PK/FK, constraints)
--		2) Dummy Data Inserts
--		3) Phase 3 Adjustments
--		4) Validation Queries
--		5) Test Cases
-- =============================================

--
-- PostgreSQL database dump
--

\restrict l3c9eRRmbgxN2dbpmPPKGQVcuXOcKWevQTzAqIOivQhMnqnQ6BNEbqzKMLMfXET

-- Dumped from database version 18.2
-- Dumped by pg_dump version 18.2

-- Started on 2026-02-25 15:38:38

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
-- TOC entry 6 (class 2615 OID 16389)
-- Name: airbnb; Type: SCHEMA; Schema: -; Owner: postgres
--

-- =============================================
-- 1. Schema Definition
-- Creation of schema and relational table structure
-- =============================================

CREATE SCHEMA airbnb;


ALTER SCHEMA airbnb OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 233 (class 1259 OID 16457)
-- Name: address; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.address (
    address_id integer NOT NULL,
    city_id integer NOT NULL,
    street character varying(30) NOT NULL,
    postal_code character varying(20) NOT NULL
);


ALTER TABLE airbnb.address OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16456)
-- Name: address_address_id_seq; Type: SEQUENCE; Schema: airbnb; Owner: postgres
--

ALTER TABLE airbnb.address ALTER COLUMN address_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME airbnb.address_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 242 (class 1259 OID 16562)
-- Name: amenity; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.amenity (
    amenity_id integer NOT NULL,
    amenity_name character varying(250) NOT NULL
);


ALTER TABLE airbnb.amenity OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16561)
-- Name: amenity_amenity_id_seq; Type: SEQUENCE; Schema: airbnb; Owner: postgres
--

ALTER TABLE airbnb.amenity ALTER COLUMN amenity_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME airbnb.amenity_amenity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 235 (class 1259 OID 16475)
-- Name: app_user; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.app_user (
    user_id integer NOT NULL,
    email character varying(250) NOT NULL,
    phone character varying(50),
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    birth_date date,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE airbnb.app_user OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16474)
-- Name: app_user_user_id_seq; Type: SEQUENCE; Schema: airbnb; Owner: postgres
--

ALTER TABLE airbnb.app_user ALTER COLUMN user_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME airbnb.app_user_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 247 (class 1259 OID 16615)
-- Name: availability_day; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.availability_day (
    listing_id integer NOT NULL,
    day_date date NOT NULL,
    availability_status character varying(20) NOT NULL,
    price_override numeric(10,2),
    CONSTRAINT chk_avd_price CHECK (((price_override IS NULL) OR (price_override >= (0)::numeric)))
);


ALTER TABLE airbnb.availability_day OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16519)
-- Name: booking; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.booking (
    booking_id integer NOT NULL,
    listing_id integer NOT NULL,
    status_id integer NOT NULL,
    check_in date NOT NULL,
    check_out date NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_booking_dates CHECK ((check_out > check_in))
);


ALTER TABLE airbnb.booking OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16518)
-- Name: booking_booking_id_seq; Type: SEQUENCE; Schema: airbnb; Owner: postgres
--

ALTER TABLE airbnb.booking ALTER COLUMN booking_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME airbnb.booking_booking_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 248 (class 1259 OID 16993)
-- Name: booking_guest; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.booking_guest (
    booking_id integer NOT NULL,
    guest_user_id integer NOT NULL,
    added_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE airbnb.booking_guest OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16401)
-- Name: booking_status; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.booking_status (
    status_id integer NOT NULL,
    status_name character varying(50) NOT NULL
);


ALTER TABLE airbnb.booking_status OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16400)
-- Name: booking_status_status_id_seq; Type: SEQUENCE; Schema: airbnb; Owner: postgres
--

ALTER TABLE airbnb.booking_status ALTER COLUMN status_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME airbnb.booking_status_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 231 (class 1259 OID 16442)
-- Name: city; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.city (
    city_id integer NOT NULL,
    country_id integer NOT NULL,
    city_name character varying(100) NOT NULL
);


ALTER TABLE airbnb.city OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16441)
-- Name: city_city_id_seq; Type: SEQUENCE; Schema: airbnb; Owner: postgres
--

ALTER TABLE airbnb.city ALTER COLUMN city_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME airbnb.city_city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 227 (class 1259 OID 16421)
-- Name: commission_rule; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.commission_rule (
    commission_rule_id integer NOT NULL,
    guest_fee_pct numeric(5,2) NOT NULL,
    host_fee_pct numeric(5,2) NOT NULL,
    valid_from date NOT NULL,
    valid_to date,
    CONSTRAINT chk_commission_guest_pct CHECK (((guest_fee_pct >= (0)::numeric) AND (guest_fee_pct <= (100)::numeric))),
    CONSTRAINT chk_commission_host_pct CHECK (((host_fee_pct >= (0)::numeric) AND (host_fee_pct <= (100)::numeric)))
);


ALTER TABLE airbnb.commission_rule OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16420)
-- Name: commission_rule_commission_rule_id_seq; Type: SEQUENCE; Schema: airbnb; Owner: postgres
--

ALTER TABLE airbnb.commission_rule ALTER COLUMN commission_rule_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME airbnb.commission_rule_commission_rule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 254 (class 1259 OID 17052)
-- Name: complaint_case; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.complaint_case (
    complaint_id integer NOT NULL,
    booking_id integer NOT NULL,
    complainant_user_id integer NOT NULL,
    category character varying(80) NOT NULL,
    status character varying(30) NOT NULL,
    opened_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE airbnb.complaint_case OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 17051)
-- Name: complaint_case_complaint_id_seq; Type: SEQUENCE; Schema: airbnb; Owner: postgres
--

ALTER TABLE airbnb.complaint_case ALTER COLUMN complaint_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME airbnb.complaint_case_complaint_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 229 (class 1259 OID 16431)
-- Name: country; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.country (
    country_id integer NOT NULL,
    country_name character varying(100) NOT NULL,
    iso_code character varying(3) NOT NULL
);


ALTER TABLE airbnb.country OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16430)
-- Name: country_country_id_seq; Type: SEQUENCE; Schema: airbnb; Owner: postgres
--

ALTER TABLE airbnb.country ALTER COLUMN country_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME airbnb.country_country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 245 (class 1259 OID 16589)
-- Name: house_rule; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.house_rule (
    house_rule_id integer NOT NULL,
    rule_description character varying(500) NOT NULL
);


ALTER TABLE airbnb.house_rule OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 16588)
-- Name: house_rule_house_rule_id_seq; Type: SEQUENCE; Schema: airbnb; Owner: postgres
--

ALTER TABLE airbnb.house_rule ALTER COLUMN house_rule_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME airbnb.house_rule_house_rule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 237 (class 1259 OID 16491)
-- Name: listing; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.listing (
    listing_id integer NOT NULL,
    host_user_id integer NOT NULL,
    address_id integer NOT NULL,
    title character varying(150) NOT NULL,
    description character varying(500),
    base_price numeric(10,2) NOT NULL,
    max_guests integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_listing_base_price CHECK ((base_price >= (0)::numeric)),
    CONSTRAINT chk_listing_max_guests CHECK ((max_guests >= 0))
);


ALTER TABLE airbnb.listing OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16571)
-- Name: listing_amenity; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.listing_amenity (
    listing_id integer NOT NULL,
    amenity_id integer NOT NULL
);


ALTER TABLE airbnb.listing_amenity OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 16598)
-- Name: listing_house_rule; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.listing_house_rule (
    listing_id integer NOT NULL,
    house_rule_id integer NOT NULL
);


ALTER TABLE airbnb.listing_house_rule OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16490)
-- Name: listing_listing_id_seq; Type: SEQUENCE; Schema: airbnb; Owner: postgres
--

ALTER TABLE airbnb.listing ALTER COLUMN listing_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME airbnb.listing_listing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 252 (class 1259 OID 17028)
-- Name: message; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.message (
    message_id integer NOT NULL,
    thread_id integer NOT NULL,
    sender_user_id integer NOT NULL,
    send_at timestamp without time zone DEFAULT now() NOT NULL,
    content character varying(1000) NOT NULL
);


ALTER TABLE airbnb.message OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 17027)
-- Name: message_message_id_seq; Type: SEQUENCE; Schema: airbnb; Owner: postgres
--

ALTER TABLE airbnb.message ALTER COLUMN message_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME airbnb.message_message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 250 (class 1259 OID 17013)
-- Name: message_thread; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.message_thread (
    thread_id integer NOT NULL,
    booking_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE airbnb.message_thread OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 17012)
-- Name: message_thread_thread_id_seq; Type: SEQUENCE; Schema: airbnb; Owner: postgres
--

ALTER TABLE airbnb.message_thread ALTER COLUMN thread_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME airbnb.message_thread_thread_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 258 (class 1259 OID 17106)
-- Name: payment; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.payment (
    payment_id integer NOT NULL,
    booking_id integer NOT NULL,
    payment_method_id integer NOT NULL,
    commission_rule_id integer NOT NULL,
    amount numeric(10,2) NOT NULL,
    paid_at timestamp without time zone DEFAULT now() NOT NULL,
    payment_status character varying(30) NOT NULL,
    CONSTRAINT chk_payment_amount CHECK ((amount >= (0)::numeric))
);


ALTER TABLE airbnb.payment OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16411)
-- Name: payment_method; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.payment_method (
    payment_method_id integer NOT NULL,
    method_name character varying(50) NOT NULL
);


ALTER TABLE airbnb.payment_method OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16410)
-- Name: payment_method_payment_method_id_seq; Type: SEQUENCE; Schema: airbnb; Owner: postgres
--

ALTER TABLE airbnb.payment_method ALTER COLUMN payment_method_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME airbnb.payment_method_payment_method_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 257 (class 1259 OID 17105)
-- Name: payment_payment_id_seq; Type: SEQUENCE; Schema: airbnb; Owner: postgres
--

ALTER TABLE airbnb.payment ALTER COLUMN payment_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME airbnb.payment_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 260 (class 1259 OID 17136)
-- Name: payout; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.payout (
    payout_id integer NOT NULL,
    booking_id integer NOT NULL,
    host_user_id integer NOT NULL,
    amount numeric(10,1) NOT NULL,
    payout_at timestamp without time zone,
    payout_status character varying(30) NOT NULL,
    CONSTRAINT chk_payout_amount CHECK ((amount >= (0)::numeric))
);


ALTER TABLE airbnb.payout OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 17135)
-- Name: payout_payout_id_seq; Type: SEQUENCE; Schema: airbnb; Owner: postgres
--

ALTER TABLE airbnb.payout ALTER COLUMN payout_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME airbnb.payout_payout_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 262 (class 1259 OID 17158)
-- Name: registration_record; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.registration_record (
    registration_id integer NOT NULL,
    booking_id integer NOT NULL,
    guest_user_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    stored_until date NOT NULL
);


ALTER TABLE airbnb.registration_record OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 17157)
-- Name: registration_record_registration_id_seq; Type: SEQUENCE; Schema: airbnb; Owner: postgres
--

ALTER TABLE airbnb.registration_record ALTER COLUMN registration_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME airbnb.registration_record_registration_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 256 (class 1259 OID 17075)
-- Name: review; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.review (
    review_id integer NOT NULL,
    booking_id integer NOT NULL,
    reviewer_user_id integer NOT NULL,
    reviewee_user_id integer NOT NULL,
    rating integer NOT NULL,
    review_text character varying(1000),
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_review_rating CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE airbnb.review OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 17074)
-- Name: review_review_id_seq; Type: SEQUENCE; Schema: airbnb; Owner: postgres
--

ALTER TABLE airbnb.review ALTER COLUMN review_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME airbnb.review_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 221 (class 1259 OID 16391)
-- Name: role; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.role (
    role_id integer NOT NULL,
    role_name character varying(50) NOT NULL
);


ALTER TABLE airbnb.role OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16390)
-- Name: role_role_id_seq; Type: SEQUENCE; Schema: airbnb; Owner: postgres
--

ALTER TABLE airbnb.role ALTER COLUMN role_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME airbnb.role_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 263 (class 1259 OID 17179)
-- Name: user_referral; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.user_referral (
    referrer_user_id integer NOT NULL,
    referred_user_id integer NOT NULL,
    referred_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE airbnb.user_referral OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16542)
-- Name: user_role_assignment; Type: TABLE; Schema: airbnb; Owner: postgres
--

CREATE TABLE airbnb.user_role_assignment (
    user_id integer NOT NULL,
    role_id integer NOT NULL,
    assigned_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE airbnb.user_role_assignment OWNER TO postgres;

--
-- TOC entry 5014 (class 2606 OID 16465)
-- Name: address address_pkey; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (address_id);


--
-- TOC entry 5026 (class 2606 OID 16570)
-- Name: amenity amenity_amenity_name_key; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.amenity
    ADD CONSTRAINT amenity_amenity_name_key UNIQUE (amenity_name);


--
-- TOC entry 5028 (class 2606 OID 16568)
-- Name: amenity amenity_pkey; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.amenity
    ADD CONSTRAINT amenity_pkey PRIMARY KEY (amenity_id);


--
-- TOC entry 5016 (class 2606 OID 16489)
-- Name: app_user app_user_email_key; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.app_user
    ADD CONSTRAINT app_user_email_key UNIQUE (email);


--
-- TOC entry 5018 (class 2606 OID 16487)
-- Name: app_user app_user_pkey; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.app_user
    ADD CONSTRAINT app_user_pkey PRIMARY KEY (user_id);


--
-- TOC entry 5022 (class 2606 OID 16531)
-- Name: booking booking_pkey; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.booking
    ADD CONSTRAINT booking_pkey PRIMARY KEY (booking_id);


--
-- TOC entry 4997 (class 2606 OID 16407)
-- Name: booking_status booking_status_pkey; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.booking_status
    ADD CONSTRAINT booking_status_pkey PRIMARY KEY (status_id);


--
-- TOC entry 4999 (class 2606 OID 16409)
-- Name: booking_status booking_status_status_name_key; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.booking_status
    ADD CONSTRAINT booking_status_status_name_key UNIQUE (status_name);


--
-- TOC entry 5011 (class 2606 OID 16449)
-- Name: city city_pkey; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (city_id);


--
-- TOC entry 5005 (class 2606 OID 16429)
-- Name: commission_rule commission_rule_pkey; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.commission_rule
    ADD CONSTRAINT commission_rule_pkey PRIMARY KEY (commission_rule_id);


--
-- TOC entry 5046 (class 2606 OID 17063)
-- Name: complaint_case complaint_case_pkey; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.complaint_case
    ADD CONSTRAINT complaint_case_pkey PRIMARY KEY (complaint_id);


--
-- TOC entry 5007 (class 2606 OID 16440)
-- Name: country country_iso_code_key; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.country
    ADD CONSTRAINT country_iso_code_key UNIQUE (iso_code);


--
-- TOC entry 5009 (class 2606 OID 16438)
-- Name: country country_pkey; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (country_id);


--
-- TOC entry 5032 (class 2606 OID 16595)
-- Name: house_rule house_rule_pkey; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.house_rule
    ADD CONSTRAINT house_rule_pkey PRIMARY KEY (house_rule_id);


--
-- TOC entry 5034 (class 2606 OID 16597)
-- Name: house_rule house_rule_rule_description_key; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.house_rule
    ADD CONSTRAINT house_rule_rule_description_key UNIQUE (rule_description);


--
-- TOC entry 5020 (class 2606 OID 16507)
-- Name: listing listing_pkey; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.listing
    ADD CONSTRAINT listing_pkey PRIMARY KEY (listing_id);


--
-- TOC entry 5044 (class 2606 OID 17040)
-- Name: message message_pkey; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (message_id);


--
-- TOC entry 5042 (class 2606 OID 17021)
-- Name: message_thread message_thread_pkey; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.message_thread
    ADD CONSTRAINT message_thread_pkey PRIMARY KEY (thread_id);


--
-- TOC entry 5001 (class 2606 OID 16419)
-- Name: payment_method payment_method_method_name_key; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.payment_method
    ADD CONSTRAINT payment_method_method_name_key UNIQUE (method_name);


--
-- TOC entry 5003 (class 2606 OID 16417)
-- Name: payment_method payment_method_pkey; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.payment_method
    ADD CONSTRAINT payment_method_pkey PRIMARY KEY (payment_method_id);


--
-- TOC entry 5050 (class 2606 OID 17119)
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (payment_id);


--
-- TOC entry 5052 (class 2606 OID 17146)
-- Name: payout payout_pkey; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.payout
    ADD CONSTRAINT payout_pkey PRIMARY KEY (payout_id);


--
-- TOC entry 5038 (class 2606 OID 16623)
-- Name: availability_day pk_availability_day; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.availability_day
    ADD CONSTRAINT pk_availability_day PRIMARY KEY (listing_id, day_date);


--
-- TOC entry 5040 (class 2606 OID 17001)
-- Name: booking_guest pk_booking_guest; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.booking_guest
    ADD CONSTRAINT pk_booking_guest PRIMARY KEY (booking_id, guest_user_id);


--
-- TOC entry 5030 (class 2606 OID 16577)
-- Name: listing_amenity pk_listing_amenity; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.listing_amenity
    ADD CONSTRAINT pk_listing_amenity PRIMARY KEY (listing_id, amenity_id);


--
-- TOC entry 5036 (class 2606 OID 16604)
-- Name: listing_house_rule pk_listing_house_rule; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.listing_house_rule
    ADD CONSTRAINT pk_listing_house_rule PRIMARY KEY (listing_id, house_rule_id);


--
-- TOC entry 5056 (class 2606 OID 17187)
-- Name: user_referral pk_user_referral; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.user_referral
    ADD CONSTRAINT pk_user_referral PRIMARY KEY (referrer_user_id, referred_user_id);


--
-- TOC entry 5024 (class 2606 OID 16550)
-- Name: user_role_assignment pk_user_role_assignment; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.user_role_assignment
    ADD CONSTRAINT pk_user_role_assignment PRIMARY KEY (user_id, role_id);


--
-- TOC entry 5054 (class 2606 OID 17168)
-- Name: registration_record registration_record_pkey; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.registration_record
    ADD CONSTRAINT registration_record_pkey PRIMARY KEY (registration_id);


--
-- TOC entry 5048 (class 2606 OID 17089)
-- Name: review review_pkey; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.review
    ADD CONSTRAINT review_pkey PRIMARY KEY (review_id);


--
-- TOC entry 4993 (class 2606 OID 16397)
-- Name: role role_pkey; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);


--
-- TOC entry 4995 (class 2606 OID 16399)
-- Name: role role_role_name_key; Type: CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.role
    ADD CONSTRAINT role_role_name_key UNIQUE (role_name);


--
-- TOC entry 5012 (class 1259 OID 16455)
-- Name: ux_city_country_name; Type: INDEX; Schema: airbnb; Owner: postgres
--

CREATE UNIQUE INDEX ux_city_country_name ON airbnb.city USING btree (country_id, city_name);


--
-- TOC entry 5058 (class 2606 OID 16466)
-- Name: address fk_address_city; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.address
    ADD CONSTRAINT fk_address_city FOREIGN KEY (city_id) REFERENCES airbnb.city(city_id);


--
-- TOC entry 5069 (class 2606 OID 16624)
-- Name: availability_day fk_avd_listing; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.availability_day
    ADD CONSTRAINT fk_avd_listing FOREIGN KEY (listing_id) REFERENCES airbnb.listing(listing_id);


--
-- TOC entry 5070 (class 2606 OID 17002)
-- Name: booking_guest fk_bg_booking; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.booking_guest
    ADD CONSTRAINT fk_bg_booking FOREIGN KEY (booking_id) REFERENCES airbnb.booking(booking_id);


--
-- TOC entry 5071 (class 2606 OID 17007)
-- Name: booking_guest fk_bg_user; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.booking_guest
    ADD CONSTRAINT fk_bg_user FOREIGN KEY (guest_user_id) REFERENCES airbnb.app_user(user_id);


--
-- TOC entry 5061 (class 2606 OID 16532)
-- Name: booking fk_booking_listing; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.booking
    ADD CONSTRAINT fk_booking_listing FOREIGN KEY (listing_id) REFERENCES airbnb.listing(listing_id);


--
-- TOC entry 5062 (class 2606 OID 16537)
-- Name: booking fk_booking_status; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.booking
    ADD CONSTRAINT fk_booking_status FOREIGN KEY (status_id) REFERENCES airbnb.booking_status(status_id);


--
-- TOC entry 5075 (class 2606 OID 17064)
-- Name: complaint_case fk_cc_booking; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.complaint_case
    ADD CONSTRAINT fk_cc_booking FOREIGN KEY (booking_id) REFERENCES airbnb.booking(booking_id);


--
-- TOC entry 5076 (class 2606 OID 17069)
-- Name: complaint_case fk_cc_user; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.complaint_case
    ADD CONSTRAINT fk_cc_user FOREIGN KEY (complainant_user_id) REFERENCES airbnb.app_user(user_id);


--
-- TOC entry 5057 (class 2606 OID 16450)
-- Name: city fk_city_country; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.city
    ADD CONSTRAINT fk_city_country FOREIGN KEY (country_id) REFERENCES airbnb.country(country_id);


--
-- TOC entry 5065 (class 2606 OID 16583)
-- Name: listing_amenity fk_la_amenity; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.listing_amenity
    ADD CONSTRAINT fk_la_amenity FOREIGN KEY (amenity_id) REFERENCES airbnb.amenity(amenity_id);


--
-- TOC entry 5066 (class 2606 OID 16578)
-- Name: listing_amenity fk_la_listing; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.listing_amenity
    ADD CONSTRAINT fk_la_listing FOREIGN KEY (listing_id) REFERENCES airbnb.listing(listing_id);


--
-- TOC entry 5067 (class 2606 OID 16610)
-- Name: listing_house_rule fk_lhr_house_rule; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.listing_house_rule
    ADD CONSTRAINT fk_lhr_house_rule FOREIGN KEY (house_rule_id) REFERENCES airbnb.house_rule(house_rule_id);


--
-- TOC entry 5068 (class 2606 OID 16605)
-- Name: listing_house_rule fk_lhr_listing; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.listing_house_rule
    ADD CONSTRAINT fk_lhr_listing FOREIGN KEY (listing_id) REFERENCES airbnb.listing(listing_id);


--
-- TOC entry 5059 (class 2606 OID 16513)
-- Name: listing fk_listing_address; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.listing
    ADD CONSTRAINT fk_listing_address FOREIGN KEY (address_id) REFERENCES airbnb.address(address_id);


--
-- TOC entry 5060 (class 2606 OID 16508)
-- Name: listing fk_listing_host; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.listing
    ADD CONSTRAINT fk_listing_host FOREIGN KEY (host_user_id) REFERENCES airbnb.app_user(user_id);


--
-- TOC entry 5073 (class 2606 OID 17041)
-- Name: message fk_msg_thread; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.message
    ADD CONSTRAINT fk_msg_thread FOREIGN KEY (thread_id) REFERENCES airbnb.message_thread(thread_id);


--
-- TOC entry 5074 (class 2606 OID 17046)
-- Name: message fk_msg_user; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.message
    ADD CONSTRAINT fk_msg_user FOREIGN KEY (sender_user_id) REFERENCES airbnb.app_user(user_id);


--
-- TOC entry 5072 (class 2606 OID 17022)
-- Name: message_thread fk_mt_booking; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.message_thread
    ADD CONSTRAINT fk_mt_booking FOREIGN KEY (booking_id) REFERENCES airbnb.booking(booking_id);


--
-- TOC entry 5080 (class 2606 OID 17120)
-- Name: payment fk_payment_booking; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.payment
    ADD CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id) REFERENCES airbnb.booking(booking_id);


--
-- TOC entry 5081 (class 2606 OID 17130)
-- Name: payment fk_payment_comission; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.payment
    ADD CONSTRAINT fk_payment_comission FOREIGN KEY (commission_rule_id) REFERENCES airbnb.commission_rule(commission_rule_id);


--
-- TOC entry 5082 (class 2606 OID 17125)
-- Name: payment fk_payment_method; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.payment
    ADD CONSTRAINT fk_payment_method FOREIGN KEY (payment_method_id) REFERENCES airbnb.payment_method(payment_method_id);


--
-- TOC entry 5083 (class 2606 OID 17147)
-- Name: payout fk_payout_booking; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.payout
    ADD CONSTRAINT fk_payout_booking FOREIGN KEY (booking_id) REFERENCES airbnb.booking(booking_id);


--
-- TOC entry 5084 (class 2606 OID 17152)
-- Name: payout fk_payout_user; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.payout
    ADD CONSTRAINT fk_payout_user FOREIGN KEY (host_user_id) REFERENCES airbnb.app_user(user_id);


--
-- TOC entry 5087 (class 2606 OID 17193)
-- Name: user_referral fk_referred; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.user_referral
    ADD CONSTRAINT fk_referred FOREIGN KEY (referred_user_id) REFERENCES airbnb.app_user(user_id);


--
-- TOC entry 5088 (class 2606 OID 17188)
-- Name: user_referral fk_referrer; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.user_referral
    ADD CONSTRAINT fk_referrer FOREIGN KEY (referrer_user_id) REFERENCES airbnb.app_user(user_id);


--
-- TOC entry 5085 (class 2606 OID 17169)
-- Name: registration_record fk_reg_booking; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.registration_record
    ADD CONSTRAINT fk_reg_booking FOREIGN KEY (booking_id) REFERENCES airbnb.booking(booking_id);


--
-- TOC entry 5086 (class 2606 OID 17174)
-- Name: registration_record fk_reg_user; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.registration_record
    ADD CONSTRAINT fk_reg_user FOREIGN KEY (guest_user_id) REFERENCES airbnb.app_user(user_id);


--
-- TOC entry 5077 (class 2606 OID 17090)
-- Name: review fk_review_booking; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.review
    ADD CONSTRAINT fk_review_booking FOREIGN KEY (booking_id) REFERENCES airbnb.booking(booking_id);


--
-- TOC entry 5078 (class 2606 OID 17100)
-- Name: review fk_review_reviewee; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.review
    ADD CONSTRAINT fk_review_reviewee FOREIGN KEY (reviewee_user_id) REFERENCES airbnb.app_user(user_id);


--
-- TOC entry 5079 (class 2606 OID 17095)
-- Name: review fk_review_reviewer; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.review
    ADD CONSTRAINT fk_review_reviewer FOREIGN KEY (reviewer_user_id) REFERENCES airbnb.app_user(user_id);


--
-- TOC entry 5063 (class 2606 OID 16556)
-- Name: user_role_assignment fk_ura_role; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.user_role_assignment
    ADD CONSTRAINT fk_ura_role FOREIGN KEY (role_id) REFERENCES airbnb.role(role_id);


--
-- TOC entry 5064 (class 2606 OID 16551)
-- Name: user_role_assignment fk_ura_user; Type: FK CONSTRAINT; Schema: airbnb; Owner: postgres
--

ALTER TABLE ONLY airbnb.user_role_assignment
    ADD CONSTRAINT fk_ura_user FOREIGN KEY (user_id) REFERENCES airbnb.app_user(user_id);


-- Completed on 2026-02-25 15:38:38

--
-- PostgreSQL database dump complete
--

\unrestrict l3c9eRRmbgxN2dbpmPPKGQVcuXOcKWevQTzAqIOivQhMnqnQ6BNEbqzKMLMfXET




SET search_path TO airbnb

-- =============================================
-- 2. Dummy Data Inserts
-- Population of all tables with representative  sample data
-- =============================================

-- ================
-- DUMMY DATA: LOOKUPS
-- ================

-- role
INSERT INTO role (role_name) VALUES
('Guest'), ('Host'), ('Admin'), ('Support'), ('Finance'), ('Moderator'),
('Compliance'), ('TrustSafety'), ('DataAnalyst'), ('DataEngineer'),
('QA'), ('Marketing'), ('Sales'), ('Operations'), ('Legal'),
('CustomerSuccess'), ('Product'),('Security'), ('Training');

-- booking_status
INSERT INTO booking_status (status_name) VALUES
('requested'), ('confirmed'), ('cancelled'), ('checked_in'), ('completed'),
('disputed'), ('refunded'), ('expired'), ('no_show'), ('pending_payment');

-- payment_method
INSERT INTO payment_method (method_name) VALUES
('credit_card'), ('debit_card'), ('paypal'), ('apple_pay'), ('google_pay'),
('bank_transfer'), ('klarna'), ('sofort'), ('ideal'), ('giropay'),
('eps'), ('sepa'), ('alipay'), ('wechat_pay'), ('amazon_pay'),
('crypto'), ('cash_voucher'), ('prepaid_card'), ('invoice'), ('other');

-- commission_rule
INSERT INTO commission_rule (guest_fee_pct, host_fee_pct, valid_from, valid_to)
SELECT
	(5 + (n & 6))::DECIMAL(5,2) AS guest_fee_pct,
	(2 + (n & 4))::DECIMAL(5,2) AS host_fee_pct,
	DATE '2026-01-01' + (n * 7) AS valid_from,
	NULL AS valid_to
FROM generate_series(1,20) AS n;


SELECT 'role' AS table, COUNT(*) FROM role
UNION ALL SELECT 'booking_status', COUNT(*) FROM booking_status
UNION ALL SELECT 'payment_method', COUNT(*) FROM payment_method
UNION ALL SELECT 'commission_rule', COUNT(*) FROM commission_rule;

-- adding 1 more role
INSERT INTO role (role_name)
VALUES ('HR');

SELECT 'role' AS table, COUNT(*) FROM role
UNION ALL SELECT 'booking_status', COUNT(*) FROM booking_status
UNION ALL SELECT 'payment_method', COUNT(*) FROM payment_method
UNION ALL SELECT 'commission_rule', COUNT(*) FROM commission_rule;

-- ================
-- DUMMY DATA: LOCATION
-- ================

INSERT INTO country (country_name, iso_code) VALUES
('Austria', 'AUT'), ('Germany', 'DEU'), ('Switzerland', 'CHE'), ('Italy', 'ITA'),
('France', 'FRA'), ('Spain', 'ESP'), ('Netherlands', 'NLD'), ('Belgium', 'BEL'),
('Czech Republic', 'CZE'), ('Poland', 'POL'), ('United Kingdom', 'GBR'), ('Ireland', 'IRL'),
('United States', 'USA'), ('Canada', 'CAN'), ('Mexiko', 'MEX'), ('Portugal', 'PRT'),
('Sweden', 'SWE'), ('Norway', 'NOR'), ('Denmark', 'DNK'), ('Finland', 'FIN');

INSERT INTO city (country_id, city_name)
SELECT c.country_id, v.city_name
FROM country c
JOIN (VALUES
	('Austria', 'Vienna'),
	('Austria', 'Graz'),
	('Austria', 'Salzburg'),
	('Germany', 'Berlin'),
	('Germany', 'Munich'),
	('Germany', 'Hamburg'),
	('Switzerland', 'Zurich'),
	('Switzerland', 'Geneva'),
	('Italy', 'Rome'),
	('Italy', 'Milan'),
	('France', 'Paris'),
	('Spain', 'Barcelona'),
	('Netherlands', 'Amsterdam'),
	('Belglium', 'Brussels'),
	('Czech Republic', 'Prague'),
	('Poland', 'Warsaw'),
	('United Kingdom', 'London'),
	('Ireland', 'Dublin'),
	('United States', 'Charlotte'),
	('Canada', 'Toronta'),
	('Mexico', 'Mexico City'),
	('Portugal', 'Lisbon'),
	('Sweden', 'Stockholm'),
	('Norway', 'Oslo')
) AS v(country_name, city_name)
	ON v.country_name = c.country_name;

INSERT INTO address (city_id, street, postal_code)
SELECT
	ci.city_id,
	'Main Street ' || n AS street,
	LPAD((10000 + (ci.city_id * 7 + n) % 89999)::TEXT, 5, '0') AS postal_code
	FROM city ci
	CROSS JOIN generate_series(1,3) AS n
	ORDER BY ci.city_id, N;

SELECT 'country' AS table, COUNT(*) FROM country
UNION ALL SELECT 'city', COUNT(*) FROM city
UNION ALL SELECT 'address', COUNT(*) FROM address;

INSERT INTO app_user (email, phone, first_name, last_name, birth_date)
SELECT
	'user' || n || '@example.com' AS email,
	'+43' || LPAD((600000000 + n)::TEXT, 9, '0') AS phone,
	'First' || n AS first_name,
	'Last' || n AS last_name,
	DATE '1985-01-01' + (n * 30) AS birth_date
FROM generate_series(1,20) AS n;

INSERT INTO listing (host_user_id, address_id, title, description, base_price, max_guests)
SELECT
	((n - 1) % 10) + 1 AS host_user_id,
	((n - 1) % 66) + 1 AS address_id,
	'Listing' || n AS title,
	'Description for listing' || n AS description,
	(50 + (n * 7) % 200)::DECIMAL(10,2) AS base_price,
	((n - 1) % 6)+ 1 AS max_guests
FROM generate_series(1,20) AS n;

INSERT INTO booking (listing_id, status_id, check_in, check_out)
SELECT
	((n - 1) % 20) + 1 AS listing_id,
	(SELECT status_id FROM booking_status WHERE status_name = 'confirmed' LIMIT 1) AS status_id,
	DATE '2026-03-01' + (n * 2) AS check_in,
	DATE '2026-03-01' + (n * 2) + 3 AS check_out
FROM generate_series(1,20) AS n;

SELECT 'app_user' AS table, COUNT(*) FROM app_user
UNION ALL SELECT 'listing', COUNT(*) FROM listing
UNION ALL SELECT 'booking', COUNT(*) FROM booking;

-- ================
-- DUMMY DATA: ROLES + GUESTS + AVAILABILITY
-- ================

-- UserRoleAssignment
-- Users 1..20 are Guests
INSERT INTO user_role_assignment (user_id, role_id)
SELECT u.user_id, r.role_id
FROM app_user u
JOIN role r ON r.role_name = 'Guest'
WHERE u.user_id BETWEEN 1 AND 20;

-- Users 1..10 are Hosts
INSERT INTO user_role_assignment (user_id, role_id)
SELECT u.user_id, r.role_id
FROM app_user u
JOIN role r ON r.role_name = 'Host'
WHERE u.user_id BETWEEN 1 AND 10;

-- User 1 is Admin
INSERT INTO user_role_assignment (user_id, role_id)
SELECT 1, r.role_id
FROM role r
WHERE r.role_name = 'Admin'
ON CONFLICT DO NOTHING;

-- BookingGuest
-- Each booking gets exactly one guest (users 11..20)
INSERT INTO booking_guest (booking_id, guest_user_id)
SELECT b.booking_id,
	10 + ((b.booking_id - 1) % 10) + 1 --maps to..20
FROM booking b
WHERE b.booking_id BETWEEN 1 AND 20;

-- AvailabilityDay
-- Generate 30 days of availability per listing
INSERT INTO availability_day (listing_id, day_date, availability_status, price_override)
SELECT
	l.listing_id,
	DATE '2026-03-01' + (d- 1) AS day_date,
	CASE
		WHEN d IN (7, 14, 21, 28) THEN 'blocked'
		ELSE 'available'
	END AS availability_status,
	CASE
		WHEN d IN (5, 6, 12, 13, 19, 20, 26, 27) THEN (l.base_price + 25)
		ELSE NULL
	END AS price_override
FROM listing l
CROSS JOIN generate_series(1,30) AS d;

SELECT 'user_role_assignment' AS table, COUNT(*) FROM user_role_assignment
UNION ALL SELECT 'booking_guest', COUNT(*) FROM booking_guest
UNION ALL SELECT 'availability_day', COUNT(*) FROM availability_day;

SET search_path TO airbnb

-- ================
-- DUMMY DATA: COMMUNICATION + REVIEWS + COMPLAINTS
-- ================

-- MessageThread: one thread per booking
INSERT INTO message_thread (booking_id)
SELECT booking_id
FROM booking
WHERE booking_id BETWEEN 1 AND 20;

-- Message: 3 messages per thread(alternating sender)
-- Sender alternates between guest and host (via booking -> listing -> host)
INSERT INTO message (thread_id, sender_user_id, content)
SELECT
	mt.thread_id,
	CASE
		WHEN m.n % 2 = 1 THEN bg.guest_user_id
		ELSE l.host_user_id
	END AS sender_user_id,
	CASE
		WHEN m.n = 1 THEN 'Hello, I have a question about check-in.'
		WHEN m.n = 2 THEN 'Sure, check-in is possible from 15:00 onwards.'
		ELSE 'Perfect, thanks! See you then.'
	END AS content
FROM message_thread mt
JOIN booking b ON b.booking_id = mt.booking_id
JOIN booking_guest bg ON bg.booking_id = b.booking_id
JOIN listing l ON l.listing_id = b.listing_id
CROSS JOIN generate_series(1,3) AS m(n)
WHERE mt.booking_id BETWEEN 1 AND 20;

-- Review: 2 reviews per booking (guest->host and host->guest) for bookings 1..20
-- Guest review Host
INSERT INTO review (booking_id, reviewer_user_id, reviewee_user_id, rating, review_text)
SELECT
	b.booking_id,
	bg.guest_user_id AS reviewer_user_id,
	l.host_user_id AS reviewee_user_id,
	4 + (b.booking_id % 2) AS rating, --4 or 5
	'Great stay, everything was as described.'
FROM booking b
JOIN booking_guest bg ON bg.booking_id = b.booking_id
JOIN listing l ON l.listing_id = b.listing_id
WHERE b.booking_id BETWEEN 1 AND 20;

-- Host reviews Guest
INSERT INTO review (booking_id, reviewer_user_id, reviewee_user_id, rating, review_text)
SELECT
	b.booking_id,
	l.host_user_id AS reviewer_user_id,
	bg.guest_user_id AS reviewee_user_id,
	3 + (b.booking_id % 3) AS rating, --3..5
	'Good communication and smooth check-in/out.'
FROM booking b
JOIN booking_guest bg ON bg.booking_id = b.booking_id
JOIN listing l ON l.listing_id = b.listing_id
WHERE b.booking_id BETWEEN 1 AND 20;

-- ComplaintCase: one complaint is generated per booking
INSERT INTO complaint_case (booking_id, complainant_user_id, category, status)
SELECT
	b.booking_id,
	bg.guest_user_id AS complainant_user_id,
	CASE (b.booking_id % 4)
		WHEN 0 THEN 'cleanliness'
		WHEN 1 THEN 'noise'
		WHEN 2 THEN 'missing_amenities'
		ELSE 'billing_issue'
	END AS category,
	CASE (b.booking_id % 3)
		WHEN 1 THEN 'open'
		WHEN 2 THEN 'in_review'
		ELSE 'closed'
	END AS status
FROM booking b
JOIN booking_guest bg ON bg.booking_id = b.booking_id
WHERE b.booking_id BETWEEN 1 AND 20;

SELECT 'message_thread' AS table, COUNT(*) FROM message_thread
UNION ALL SELECT 'message', COUNT(*) FROM message
UNION ALL SELECT 'review', COUNT(*) FROM review
UNION ALL SELECT 'complaint_case', COUNT(*) FROM complaint_case;

-- ================
-- DUMMY DATA: PAYMENTS + PAYOUTS + REGISTRATION + REFERRAL
-- ================

-- Payment: one payment per booking
INSERT INTO payment (booking_id, payment_method_id, commission_rule_id, amount, payment_status)
SELECT
	b.booking_id,
	((b.booking_id - 1) % 20) + 1 AS payment_method_id,
	((b.booking_id - 1) % 20) + 1 AS commission_rule_id,
	(l.base_price * 3) AS amount, --3 nights approx.
	CASE (b.booking_id % 3)
		WHEN 0 THEN 'paid'
		WHEN 1 THEN 'refunded'
		ELSE 'pending'
	END AS payment_status
FROM booking b
JOIN listing l ON l.listing_id = b.listing_id
WHERE b.booking_id BETWEEN 1 AND 20;

-- Payout: host receives payout (if not refunded)
INSERT INTO payout (booking_id, host_user_id, amount, payout_at, payout_status)
SELECT
	b.booking_id,
	l.host_user_id,
	(l.base_price * 3) * 0.9 AS amount, --approx. after commission
	NOW(),
	CASE (b.booking_id % 3)
		WHEN 1 THEN 'cancelled'
		ELSE 'processed'
	END
FROM booking b
JOIN listing l ON l.listing_id = b.listing_id
WHERE b.booking_id BETWEEN 1 AND 20;

-- RegistrationRecord (legal retention)
INSERT INTO registration_record (booking_id, guest_user_id, stored_until)
SELECT
	b.booking_id,
	bg.guest_user_id,
	CURRENT_DATE + INTERVAL '7 years'
FROM booking b
JOIN booking_guest bg ON bg.booking_id = b.booking_id
WHERE b.booking_id BETWEEN 1 AND 20;

-- UserReferral (10 referral pairs)
INSERT INTO user_referral (referrer_user_id, referred_user_id)
SELECT
	n,
	n + 10
FROM generate_series(1,10) AS n;

SELECT 'payment' AS table, COUNT(*) FROM payment
UNION ALL SELECT 'payout', COUNT(*) FROM payout
UNION ALL SELECT 'registration_record', COUNT (*) FROM registration_record
UNION ALL SELECT 'user_referral', COUNT(*) FROM user_referral;


-- ================
-- DUMMY DATA: AMMENITIES + HOUSE RULES + M:N LINKS
-- ================

-- Amenity
INSERT INTO amenity (amenity_name)
SELECT 'Amenity' || n
FROM generate_series(1,20) AS n
ON CONFLICT DO NOTHING;

-- HouseRule
INSERT INTO house_rule (rule_description)
SELECT 'House rule' || n
FROM generate_series(1,20) AS n
ON CONFLICT DO NOTHING;

--ListingAmenity: creates 3 amenities per listing
INSERT INTO listing_amenity (listing_id, amenity_id)
SELECT
	l.listing_id,
	a.amenity_id
FROM listing l
JOIN LATERAL (
	SELECT amenity_id
	FROM amenity
	ORDER BY amenity_id
	OFFSET ((l.listing_id - 1) % 18)
	LIMIT 3
) a ON TRUE
ON CONFLICT DO NOTHING;

--ListingHouseRule: creates 2 house rules per listing
INSERT INTO listing_house_rule (listing_id, house_rule_id)
SELECT
	l.listing_id,
	h.house_rule_id
FROM listing l
JOIN LATERAL (
	SELECT house_rule_id
	FROM house_rule
	ORDER BY house_rule_id
	OFFSET ((l.listing_id - 1) % 19)
	LIMIT 2
) h ON TRUE
ON CONFLICT DO NOTHING;

SELECT 'amenity' AS t, COUNT(*) FROM amenity
UNION ALL SELECT 'house_rule', COUNT(*) FROM house_rule
UNION ALL SELECT 'listing_amenity', COUNT(*) FROM listing_amenity
UNION ALL SELECT 'listing_house_rule', COUNT(*) FROM listing_house_rule;

-- =============================================
-- 3. Phase 3 Adjustments
-- Increase lookup tables to 20 rows
-- =============================================

SET search_path TO airbnb;

-- Add additional booking status until ~20 rows are reached
INSERT INTO booking_status (status_name)
SELECT s.status_name
FROM (VALUES
	('Pending Verification'),
	('Payment Pending'),
	('Payment Failed'),
	('Refund Requested'),
	('Refunded'),
	('No-Show'),
	('Host Cancelled'),
	('Guest Cancelled'),
	('Dispute Open'),
	('Dispute Resolved')
) AS s(status_name)
WHERE NOT EXISTS (
	SELECT 1 FROM booking_status bs WHERE bs.status_name = s.status_name
);

SELECT COUNT(*) FROM booking_status;

-- Create additional referral relationships to reach 20 rows.
-- This generates pairs (referrer -> referred) without self-referrals.
INSERT INTO user_referral (referrer_user_id, referred_user_id, referred_at)
SELECT
	u1.user_id,
	u2.user_id,
	NOW()
FROM app_user u1
JOIN app_user u2
	ON u1.user_id <> u2.user_id
WHERE NOT EXISTS (
	SELECT 1
	FROM user_referral ur
	WHERE ur.referrer_user_id = u1.user_id
		AND ur.referred_user_id = u2.user_id
)
LIMIT 10; -- adds 10 more, turning 10 into 20

SELECT COUNT(*) FROM user_referral;


-- ================
-- 4. Validation Queries (Row count checks)
-- ================

SELECT COUNT(*) FROM airbnb.role;

SELECT COUNT(*) FROM airbnb.booking_status;

SELECT COUNT(*) FROM airbnb.payment_method;

SELECT COUNT(*) FROM airbnb.commission_rule;

SELECT COUNT(*) FROM airbnb.country;

SELECT COUNT(*) FROM airbnb.city;

SELECT COUNT(*) FROM airbnb.address;

SELECT COUNT(*) FROM airbnb.app_user;

SELECT COUNT(*) FROM airbnb.listing;

SELECT COUNT(*) FROM airbnb.booking;

SELECT COUNT(*) FROM airbnb.user_role_assignment;

SELECT COUNT(*) FROM airbnb.booking_guest;

SELECT COUNT(*) FROM airbnb.amenity;

SELECT COUNT(*) FROM airbnb.listing_amenity;

SELECT COUNT(*) FROM airbnb.house_rule;

SELECT COUNT(*) FROM airbnb.listing_house_rule;

SELECT COUNT(*) FROM airbnb.availability_day;

SELECT COUNT(*) FROM airbnb.message_thread;

SELECT COUNT(*) FROM airbnb.message;

SELECT COUNT(*) FROM airbnb.review;

SELECT COUNT(*) FROM airbnb.complaint_case;

SELECT COUNT(*) FROM airbnb.payment;

SELECT COUNT(*) FROM airbnb.payout;

SELECT COUNT(*) FROM airbnb.registration_record;

SELECT COUNT(*) FROM airbnb.user_referral;

-- ================
-- 5. TEST CASES
-- ================

-- Test Case 1: booking overview
SELECT
	b.booking_id,
	gu.first_name || ' ' || gu.last_name AS guest,
	hu.first_name || ' ' || hu.last_name AS host,
	l.title AS listing,
	bs.status_name,
	p.amount,
	p.payment_status
FROM booking b
JOIN booking_guest bg ON bg.booking_id = b.booking_id
JOIN app_user gu ON gu.user_id = bg.guest_user_id
JOIN listing l ON l.listing_id = b.listing_id
JOIN app_user hu ON hu.user_id = l.host_user_id
JOIN booking_status bs ON bs.status_id = b.status_id
JOIN payment p ON p.payment_id = b.booking_id
ORDER BY b.booking_id;

-- Test Case 2: average rating per host
SELECT
	hu.user_id,
	hu.first_name || ' ' || hu.last_name AS host,
	ROUND(AVG(r.rating),2) AS avg_rating,
	COUNT(r.review_id) AS total_reviews
FROM review r
JOIN app_user hu ON hu.user_id = r.reviewee_user_id
JOIN listing l ON l.host_user_id = hu.user_id
GROUP BY hu.user_id, hu.first_name, hu.last_name
ORDER BY avg_rating DESC;

-- Test Case 3: revenue per listing
SELECT
	l.listing_id,
	l.title,
	SUM(p.amount) AS total_revenue
FROM listing l
JOIN booking b ON b.listing_id = l.listing_id
JOIN payment p ON p.booking_id = b.booking_id
GROUP BY l.listing_id, l.title
ORDER BY total_revenue DESC;

SET search_path TO airbnb

SELECT 'amenity' AS t, COUNT(*) FROM amenity
UNION ALL SELECT 'house_rule', COUNT(*) FROM house_rule
UNION ALL SELECT 'listing_amenity', COUNT(*) FROM listing_amenity
UNION ALL SELECT 'listing_house_rule', COUNT(*) FROM listing_house_rule;
