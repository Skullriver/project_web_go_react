--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3
-- Dumped by pg_dump version 13.3

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bets; Type: TABLE; Schema: public; Owner: ps3r
--

CREATE TABLE public.bets (
    id integer NOT NULL,
    type integer NOT NULL,
    date_bet timestamp without time zone NOT NULL,
    limit_date timestamp without time zone NOT NULL,
    qt_victory numeric NOT NULL,
    qt_loss numeric NOT NULL,
    status character varying NOT NULL,
    user_id integer,
    title character varying,
    created timestamp without time zone
);


ALTER TABLE public.bets OWNER TO ps3r;

--
-- Name: bet_id_seq; Type: SEQUENCE; Schema: public; Owner: ps3r
--

CREATE SEQUENCE public.bet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bet_id_seq OWNER TO ps3r;

--
-- Name: bet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ps3r
--

ALTER SEQUENCE public.bet_id_seq OWNED BY public.bets.id;


--
-- Name: bet_type1; Type: TABLE; Schema: public; Owner: ps3r
--

CREATE TABLE public.bet_type1 (
    id integer NOT NULL,
    m_r text NOT NULL,
    num_type integer NOT NULL,
    value numeric NOT NULL
);


ALTER TABLE public.bet_type1 OWNER TO ps3r;

--
-- Name: COLUMN bet_type1.num_type; Type: COMMENT; Schema: public; Owner: ps3r
--

COMMENT ON COLUMN public.bet_type1.num_type IS '1 - %, 2 - qte';


--
-- Name: bet_type2; Type: TABLE; Schema: public; Owner: ps3r
--

CREATE TABLE public.bet_type2 (
    id integer NOT NULL,
    m_r text NOT NULL,
    line text NOT NULL
);


ALTER TABLE public.bet_type2 OWNER TO ps3r;

--
-- Name: bet_type3; Type: TABLE; Schema: public; Owner: ps3r
--

CREATE TABLE public.bet_type3 (
    id integer NOT NULL,
    m_r text NOT NULL,
    value numeric NOT NULL
);


ALTER TABLE public.bet_type3 OWNER TO ps3r;

--
-- Name: disruptions; Type: TABLE; Schema: public; Owner: ps3r
--

CREATE TABLE public.disruptions (
    id integer NOT NULL,
    disruption_id character varying(255) NOT NULL,
    line_id character varying(255) NOT NULL,
    status character varying(128) NOT NULL,
    type character varying(128) NOT NULL,
    color character varying(128),
    effect character varying(128),
    title text,
    message text,
    updated_at timestamp without time zone,
    application_start timestamp without time zone,
    application_end timestamp without time zone
);


ALTER TABLE public.disruptions OWNER TO ps3r;

--
-- Name: disruptions_id_seq; Type: SEQUENCE; Schema: public; Owner: ps3r
--

CREATE SEQUENCE public.disruptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.disruptions_id_seq OWNER TO ps3r;

--
-- Name: disruptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ps3r
--

ALTER SEQUENCE public.disruptions_id_seq OWNED BY public.disruptions.id;


--
-- Name: lines; Type: TABLE; Schema: public; Owner: ps3r
--

CREATE TABLE public.lines (
    id integer NOT NULL,
    line_id character varying(255) NOT NULL,
    code character varying(128) NOT NULL,
    name character varying(255) NOT NULL,
    color character varying(128),
    text_color character varying(128),
    closing_time timestamp without time zone,
    opening_time timestamp without time zone,
    physical_mode character varying(128)
);


ALTER TABLE public.lines OWNER TO ps3r;

--
-- Name: lines_id_seq; Type: SEQUENCE; Schema: public; Owner: ps3r
--

CREATE SEQUENCE public.lines_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lines_id_seq OWNER TO ps3r;

--
-- Name: lines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ps3r
--

ALTER SEQUENCE public.lines_id_seq OWNED BY public.lines.id;


--
-- Name: log; Type: TABLE; Schema: public; Owner: ps3r
--

CREATE TABLE public.log (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    disruption_id integer NOT NULL
);


ALTER TABLE public.log OWNER TO ps3r;

--
-- Name: log_id_seq; Type: SEQUENCE; Schema: public; Owner: ps3r
--

CREATE SEQUENCE public.log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.log_id_seq OWNER TO ps3r;

--
-- Name: log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ps3r
--

ALTER SEQUENCE public.log_id_seq OWNED BY public.log.id;


--
-- Name: tickets; Type: TABLE; Schema: public; Owner: ps3r
--

CREATE TABLE public.tickets (
    id integer NOT NULL,
    user_id integer NOT NULL,
    bet_id integer NOT NULL,
    bid boolean NOT NULL,
    value double precision NOT NULL,
    status text NOT NULL
);


ALTER TABLE public.tickets OWNER TO ps3r;

--
-- Name: tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: ps3r
--

ALTER TABLE public.tickets ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tickets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: ps3r
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    password character varying(100) NOT NULL,
    account_balance double precision
);


ALTER TABLE public.users OWNER TO ps3r;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: ps3r
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO ps3r;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ps3r
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: bets id; Type: DEFAULT; Schema: public; Owner: ps3r
--

ALTER TABLE ONLY public.bets ALTER COLUMN id SET DEFAULT nextval('public.bet_id_seq'::regclass);


--
-- Name: disruptions id; Type: DEFAULT; Schema: public; Owner: ps3r
--

ALTER TABLE ONLY public.disruptions ALTER COLUMN id SET DEFAULT nextval('public.disruptions_id_seq'::regclass);


--
-- Name: lines id; Type: DEFAULT; Schema: public; Owner: ps3r
--

ALTER TABLE ONLY public.lines ALTER COLUMN id SET DEFAULT nextval('public.lines_id_seq'::regclass);


--
-- Name: log id; Type: DEFAULT; Schema: public; Owner: ps3r
--

ALTER TABLE ONLY public.log ALTER COLUMN id SET DEFAULT nextval('public.log_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: ps3r
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: bet_type1; Type: TABLE DATA; Schema: public; Owner: ps3r
--

COPY public.bet_type1 (id, m_r, num_type, value) FROM stdin;
1	RER	1	50
8	Metro	1	50
11	RER	2	5
\.


--
-- Data for Name: bet_type2; Type: TABLE DATA; Schema: public; Owner: ps3r
--

COPY public.bet_type2 (id, m_r, line) FROM stdin;
2	Metro	line:IDFM:C01374
3	Metro	line:IDFM:C01374
6	RER	line:IDFM:C01727
10	Metro	line:IDFM:C01382
12	RER	line:IDFM:C01743
15	Metro	line:IDFM:C01372
\.


--
-- Data for Name: bet_type3; Type: TABLE DATA; Schema: public; Owner: ps3r
--

COPY public.bet_type3 (id, m_r, value) FROM stdin;
4	Metro	10
7	Metro	3
9	Metro	1000000000000000000000000000
13	RER	50
14	Metro	14
\.


--
-- Data for Name: bets; Type: TABLE DATA; Schema: public; Owner: ps3r
--

COPY public.bets (id, type, date_bet, limit_date, qt_victory, qt_loss, status, user_id, title, created) FROM stdin;
4	3	2023-05-21 14:14:17.873	2023-05-20 21:00:00.873	1.5	2	created	2	La chance	2023-05-20 12:17:11.605345
6	2	2023-05-21 14:18:29.435	2023-05-20 18:00:00.435	1.5	1.2	created	2	Rer C toujours en retard 	2023-05-20 12:19:16.497077
1	1	2023-05-21 13:15:52.901	2023-05-20 21:00:00.901	1.5	2.5	opened	1	50% de lignes ou il y'aura un pb	2023-05-20 11:17:49.755675
7	3	2023-05-21 14:47:53	2023-05-20 16:00:00.119	1.2	1.6	created	5	♥♥РАССИЯ♥♥	2023-05-20 12:49:51.282679
2	2	2023-05-21 14:09:05.434	2023-05-20 21:00:00.434	2	1.2	opened	2	Metro 4 toujours les problems…	2023-05-20 12:10:07.973983
9	3	2030-06-20 14:54:44	2023-05-20 15:54:44.587	3	2	created	5	paris	2023-05-20 12:56:54.46537
3	2	2023-05-21 14:09:15.333	2023-05-20 15:09:15.333	1.1	3	opened	1	toujours un problème sur la ligne 4...	2023-05-20 12:10:16.801928
8	1	2023-05-26 14:50:19	2023-05-20 15:50:19.312	1.6	2	opened	5	 	2023-05-20 12:51:15.195134
11	1	2023-05-21 18:03:02.305	2023-05-20 19:03:02.305	1	2	created	8	Paris 1	2023-05-20 16:04:01.857023
10	2	2023-05-21 15:15:01	2023-05-20 21:00:00.157	1.1	3	opened	6	La 12 va-t-elle fonctionner correctement le temps d'une journée ?	2023-05-20 13:16:08.20922
12	2	2023-05-22 19:58:12	2023-05-21 21:00:00	1.5	2	opened	9	RER B forever	2023-05-20 18:06:21.909781
13	3	2023-05-21 22:41:24.663	2023-05-20 22:41:24.663	3	1.2	opened	1	50 lignes ou il y'aura un problème	2023-05-20 20:42:50.645799
14	3	2023-05-22 00:02:51.345	2023-05-21 21:00:00.345	2	1.5	created	10	test	2023-05-20 22:03:18.54846
15	2	2023-05-23 13:44:21.833	2023-05-22 14:44:21.833	1	1	created	1	TEST	2023-05-22 11:44:46.570188
\.


--
-- Data for Name: disruptions; Type: TABLE DATA; Schema: public; Owner: ps3r
--

COPY public.disruptions (id, disruption_id, line_id, status, type, color, effect, title, message, updated_at, application_start, application_end) FROM stdin;
1	386cff2e-d004-11ed-91b9-0a58a9feac02	line:IDFM:C01379	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 9 : Personnes sur les voies - Reprise progressive / trafic reste perturbé	<p>Le trafic reprend mais reste perturbé sur l'ensemble de la ligne en raison de personnes sur les voies<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-03-31 22:40:06	2023-03-31 22:32:30	2023-03-31 22:33:30
3	26c0c2d0-cf7b-11ed-927a-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D : mouvement social national le 31 mars	<p>Vendredi 31 mars :<br><br>Trafic perturb&#233;.<br><br>Pr&#233;voir 2 trains sur 3 en moyenne toute la journ&#233;e sur les axes :<br>- Creil / Orry la Ville / Villiers le Bel - Corbeil Essonnes<br>- Goussainville - Melun<br><br>Trafic normal sur les axes :<br>- Juvisy - Corbeil via Ris Orangis<br>- Corbeil Essonnes - Malesherbes<br>- Corbeil Essonnes - Melun<br><br>Pour pr&#233;parer votre trajet, rendez-vous sur le calculateur d'itin&#233;raires de l&#8217;appli Ile-de-France Mobilit&#233;s, le site Transilien.com et l&#8217;appli SNCF.<br><br>Avant de vous rendre en gare, nous vous conseillons de v&#233;rifier les horaires de vos trains.<br><br>Motif : mouvement social national interprofessionnel.<br></p>	2023-03-31 06:18:55	2023-03-30 02:00:00	2023-04-01 02:00:00
7	641ddca6-d09a-11ed-927a-0a58a9feac02	line:IDFM:C01374	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 4 : Bagage oublié - Reprise progressive / trafic reste perturbé	<p>Le trafic reprend mais reste perturbé sur l'ensemble de la ligne en raison d'un bagage oublié<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-01 16:35:04	2023-04-01 16:33:00	2023-04-02 03:45:00
9	d9c5eb40-d0ab-11ed-91b9-0a58a9feac02	line:IDFM:C01386	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 3B : Indisponibilité de trains - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de l'indisponibilité de trains<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-01 18:40:03	2023-04-01 18:32:37	2023-04-01 18:33:37
10	61d555f8-d0ab-11ed-927a-0a58a9feac02	line:IDFM:C01743	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne B : perturbé	<p>Le trafic est perturb&#233; sur l'ensemble de la ligne.<br><br>Motif :Incident affectant la signalisation &#224; Bourg-la-Reine.<br><br></p>	2023-04-01 18:36:41	2023-04-01 18:30:34	2023-04-01 21:30:35
11	55ce76e4-d0b6-11ed-927a-0a58a9feac02	line:IDFM:C01378	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 8 : Incident (intervention agents) - Reprise progressive / trafic reste perturbé	<p>Le trafic reprend mais reste perturbé sur l'ensemble de la ligne en raison d'un incident nécessitant l’intervention de nos agents<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-01 19:55:06	2023-04-01 19:51:18	2023-04-01 19:52:18
13	6c616040-d0b8-11ed-91b9-0a58a9feac02	line:IDFM:C01379	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 9 : Malaise voyageur - Reprise progressive / trafic reste perturbé	<p>Le trafic reprend mais reste perturbé sur l'ensemble de la ligne en raison d'un malaise voyageur   à Mairie de Montreuil<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-01 20:10:03	2023-04-01 20:02:28	2023-04-01 20:03:28
14	e71a97a6-d154-11ed-89f6-0a58a9feac02	line:IDFM:C01372	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 2 : Malaise voyageur - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'un malaise voyageur<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-02 14:50:10	2023-04-02 14:45:36	2023-04-02 15:31:36
15	74b260e2-d161-11ed-91b9-0a58a9feac02	line:IDFM:C01376	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 6 : Train en panne - Train stationne	<p>Le train stationne sur l'ensemble de la ligne en raison d'un train en panne<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-02 16:20:02	2023-04-02 16:16:00	2023-04-03 03:45:00
19	46303d70-d189-11ed-8e97-0a58a9feac02	line:IDFM:C01378	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 8 : Malaise voyageur - Reprise progressive / trafic reste perturbé	<p>Le trafic reprend mais reste perturbé sur l'ensemble de la ligne en raison d'un malaise voyageur   à Porte de Charenton<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-02 21:05:03	2023-04-02 21:01:48	2023-04-02 21:02:48
21	a7058832-d191-11ed-8e97-0a58a9feac02	line:IDFM:C01371	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 1 : Incident au niveau des portes de quai - Reprise progressive / trafic reste perturbé	<p>Le trafic reprend mais reste perturbé sur l'ensemble de la ligne en raison d'un incident au niveau des portes de quai   à Bastille<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-02 22:05:02	2023-04-02 21:56:57	2023-04-02 21:57:57
23	f301eafe-d197-11ed-91b9-0a58a9feac02	line:IDFM:C01377	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 7 : Bagage oublié - Reprise progressive / trafic reste perturbé	<p>Le trafic reprend mais reste perturbé sur l'ensemble de la ligne en raison d'un bagage oublié   à Stalingrad<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-02 22:50:06	2023-04-02 22:45:57	2023-04-02 22:46:57
24	39e3c5b8-d19e-11ed-89f6-0a58a9feac02	line:IDFM:C01379	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 9 : Personnes sur les voies - Reprise progressive / trafic reste perturbé	<p>Le trafic reprend mais reste perturbé sur l'ensemble de la ligne en raison de personnes sur les voies   à Porte de Montreuil<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-02 23:35:02	2023-04-02 23:29:00	2023-04-03 03:45:00
30	50075d40-d230-11ed-89f6-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D : ralentissements	<p>Le trafic est ralenti entre Corbeil Essonnes et Villeneuve Saint Georges via Evry Courcouronnes. <br></p><p><br></p><p>Pr&#233;voir des temps d'allongement de parcours de 15 min ainsi que des modifications de dessertes et suppressions jusqu'&#224; 18h00.</p><p><br></p><p>Motif : panne d'un train au Bras de Fer (incident termin&#233;).<br></p>	2023-04-03 17:00:46	2023-04-03 16:41:44	2023-04-03 18:30:58
31	6951f18a-d234-11ed-91b9-0a58a9feac02	line:IDFM:C01374	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 4 : Incident d'exploitation - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'un incident d'exploitation<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-03 17:30:06	2023-04-03 17:26:37	2023-04-03 17:27:37
32	0a9fdfac-d235-11ed-89f6-0a58a9feac02	line:IDFM:C01728	active	perturbation	#FF0000	NO_SERVICE	Ligne D : Melun - Combs la Ville interrompu	<p>Le trafic est interrompu entre Melun et Combs-la-Ville - Quincy jusqu'&#224; 17h45.<br><br><a href="https://www.transilien.com/sites/transilien/files/itibis-combs-melun-rer-d-20220809.pdf " target="">Pour conna&#238;tre les itin&#233;raires alternatifs des gares situ&#233;es entre Combs la Ville et Melun, cliquez sur ce lien pour t&#233;l&#233;charger l'affiche PDF.</a><br><br><br>Motif : individus sur les voies dans le secteur du M&#233;e.<br><br><br></p>	2023-04-03 17:34:37	2023-04-03 17:31:49	2023-04-03 17:45:33
70	63236698-d23b-11ed-91b9-0a58a9feac02	line:IDFM:C01386	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 3B : Difficultés d'exploitation - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de difficultés d'exploitation<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-03 18:20:02	2023-04-03 18:12:52	2023-04-03 18:13:52
76	2bdf70fa-d245-11ed-89f6-0a58a9feac02	line:IDFM:C01376	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 6 : Personnes sur les voies - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de personnes sur les voies<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-03 19:30:05	2023-04-03 19:23:00	2023-04-04 03:45:00
77	af307838-d23a-11ed-8485-0a58a9feac02	line:IDFM:C01377	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 7 : Personnes sur les voies - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de personnes sur les voies<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-03 18:40:04	2023-04-03 18:32:21	2023-04-03 18:33:21
78	b71924a6-d239-11ed-8485-0a58a9feac02	line:IDFM:C01743	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne B : perturbé	<p>Le trafic est perturb&#233; sur l'ensemble de la ligne.<br><br>Motif :&#160;incident de signalisation &#224; Paris-Nord<br><br></p>	2023-04-03 19:16:44	2023-04-03 18:04:59	2023-04-03 21:30:00
79	04acc4d6-d22e-11ed-8e97-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D : ralentissements	<p>Le trafic est fortement ralenti entre Corbeil Essonnes et Orry la Ville dans les 2 sens et de Villeneuve SG vers Melun.</p><p><br></p><p>Pr&#233;voir des allongements de temps de parcours jusqu'&#224; 30 minutes ainsi ; des modifications de dessertes et des suppressions jusqu'&#224; 21h00.</p><p>Motif : panne d'un train &#224; Paris Gare de Lyon (incident temrin&#233;).<br></p>	2023-04-03 19:37:59	2023-04-03 19:27:22	2023-04-03 21:00:00
80	78f332ac-d248-11ed-89f6-0a58a9feac02	line:IDFM:C01742	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne A : ralentissements	<p>Le trafic est ralenti entre La D&#233;fense et Boissy-Saint-L&#233;ger et entre La D&#233;fense et Marne-la-Vall&#233;e Chessy dans les 2 sens. <br><br>Motif : d&#233;faut d'alimentation &#233;lectrique &#224; hauteur de Parc de St-Maur.</p>	2023-04-03 19:53:42	2023-04-03 19:46:11	2023-04-03 19:50:18
81	b9f6dfaa-d258-11ed-91b9-0a58a9feac02	line:IDFM:C01373	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 3 : Personnes sur les voies - Reprise progressive / trafic reste perturbé	<p>Le trafic reprend mais reste perturbé sur l'ensemble de la ligne en raison de personnes sur les voies<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-03 21:55:05	2023-04-03 21:51:00	2023-04-04 03:45:00
82	9cda6c80-d2e8-11ed-94b4-0a58a9feac02	line:IDFM:C01386	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 3B : Indisponibilité de trains - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de l'indisponibilité de trains<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-04 15:00:02	2023-04-04 14:56:00	2023-04-05 03:45:00
83	9a249ac2-d2ef-11ed-9517-0a58a9feac02	line:IDFM:C01379	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 9 : Personnes sur les voies - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de personnes sur les voies   à Grands Boulevards<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-04 15:50:04	2023-04-04 15:46:24	2023-04-04 16:32:24
84	e43649a2-d2f5-11ed-8dcd-0a58a9feac02	line:IDFM:C01379	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 9 : Divers incidents - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de divers incidents<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-04 16:35:05	2023-04-04 16:29:55	2023-04-04 17:15:55
88	13cda316-d2f8-11ed-8dcd-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D Corbeil-Ess. - Melun : suppression	<p>Train supprim&#233; :</p><p>- ZOSO, d&#233;part Corbeil-Essonnes &#224; 18h32 - arriv&#233;e Melun &#224; 19h02.<br><br>Prochain train &#224; circuler :</p><p>- ZOSO, d&#233;part Corbeil-Essonnes &#224; 18h47 - arriv&#233;e Melun &#224; 19h17.<br><br><br>Motif : conditions de d&#233;part non r&#233;unies (train immobilis&#233; en atelier de maintenance).<br></p><p><br></p><p><br></p>	2023-04-04 16:50:44	2023-04-04 16:47:00	2023-04-04 19:05:18
91	dfd6fc6e-d2f8-11ed-8dcd-0a58a9feac02	line:IDFM:C01742	future	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne A : mouvement social national 6 avril	<p>Jeudi 6 avril, le trafic de la ligne A sera l&#233;g&#232;rement perturb&#233;.<br><br>Dans la mesure du possible, nous vous recommandons de limiter vos d&#233;placements.<br><br>Pour pr&#233;parer votre trajet, rendez-vous la veille d&#232;s 17h sur le calculateur d'itin&#233;raires de l&#8217;appli &#206;le-de-France Mobilit&#233;s, le site Transilien.com et l&#8217;appli SNCF.<br><br>Avant de vous rendre en gare, nous vous conseillons de v&#233;rifier les horaires de vos trains.<br><br>Motif : mouvement social national interprofessionnel.<br><br></p>	2023-04-04 16:56:26	2023-04-06 03:00:00	2023-04-07 02:30:00
92	0e273854-d2f9-11ed-8dcd-0a58a9feac02	line:IDFM:C01743	future	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne B : mouvement social national 6 avril	<p>Jeudi 6 avril, le trafic de la ligne B sera quasi normal.<br><br>Dans la mesure du possible, nous vous recommandons de limiter vos d&#233;placements.<br><br>Pour pr&#233;parer votre trajet, rendez-vous la veille d&#232;s 17h00 sur le calculateur d'itin&#233;raires de l&#8217;appli &#206;le-de-France Mobilit&#233;s, le site Transilien.com et l&#8217;appli SNCF.<br><br>Avant de vous rendre en gare, nous vous conseillons de v&#233;rifier les horaires de vos trains.<br><br>Motif : mouvement social national interprofessionnel.<br></p>	2023-04-04 16:57:44	2023-04-06 03:00:00	2023-04-07 02:30:00
93	af32b1b8-d2f6-11ed-8dcd-0a58a9feac02	line:IDFM:C01727	future	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C : mouvement social national 6 avril	<p>Jeudi 6 avril, le trafic de la ligne C sera perturb&#233;.<br><br>Dans la mesure du possible, nous vous recommandons de limiter vos d&#233;placements.<br><br>Pour pr&#233;parer votre trajet, rendez-vous la veille d&#232;s 17h sur le calculateur d'itin&#233;raires de l&#8217;appli Ile-de-France Mobilit&#233;s, le site Transilien.com et l&#8217;appli SNCF.<br><br>Avant de vous rendre en gare, nous vous conseillons de v&#233;rifier les horaires de vos trains.<br><br>Motif : mouvement social national interprofessionnel.<br></p>	2023-04-04 16:40:46	2023-04-06 03:00:00	2023-04-07 02:30:00
94	a683ef00-d2f6-11ed-94b4-0a58a9feac02	line:IDFM:C01728	future	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D : mouvement social national 6 avril	<p>Jeudi 6 avril, le trafic de la ligne D sera fortement perturb&#233;.<br><br>Dans la mesure du possible, nous vous recommandons de limiter vos d&#233;placements.<br><br>Pour pr&#233;parer votre trajet, rendez-vous la veille d&#232;s 17h00 sur le calculateur d'itin&#233;raires de l&#8217;appli Ile-de-France Mobilit&#233;s, le site Transilien.com et l&#8217;appli SNCF.<br><br>Avant de vous rendre en gare, nous vous conseillons de v&#233;rifier les horaires de vos trains.<br><br>Motif : mouvement social national interprofessionnel.<br><br></p>	2023-04-04 16:40:31	2023-04-06 03:00:00	2023-04-07 02:30:00
95	7c30a66c-d2f6-11ed-8dcd-0a58a9feac02	line:IDFM:C01729	future	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne E : mouvement social national 6 avril	<p>Jeudi 6 avril :<br><br>Le trafic de la ligne E sera perturb&#233;.<br><br>Dans la mesure du possible, nous vous recommandons de limiter vos d&#233;placements.<br><br>Pour pr&#233;parer votre trajet, rendez-vous la veille d&#232;s 17h sur le calculateur d'itin&#233;raires de l&#8217;appli Ile-de-France Mobilit&#233;s, le site Transilien.com et l&#8217;appli SNCF.<br><br>Avant de vous rendre en gare, nous vous conseillons de v&#233;rifier les horaires de vos trains.<br><br>Motif : mouvement social national interprofessionnel.<br></p>	2023-04-04 16:39:20	2023-04-06 03:00:00	2023-04-07 02:30:00
96	aa696f78-d2fb-11ed-b1ba-0a58a9feac02	line:IDFM:C01728	future	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D Melun - Corbeil-Ess. : suppression	<p>Train supprim&#233; :<br>- ROSA d&#233;part Melun 19h11 - arriv&#233;e Corbeil-Essonnes 19h41.<br><br>Prochain train &#224; circuler :<br>- ROSA d&#233;part Melun 19h26 - arriv&#233;e Corbeil-Essonnes 19h56.<br><br>Motif : conditions de d&#233;part non r&#233;unies (Train immobilis&#233; en atelier de maintenance).<br></p><p><br></p><p><br></p>	2023-04-04 17:16:25	2023-04-04 18:00:00	2023-04-04 19:40:51
97	ab976148-d2fb-11ed-94b4-0a58a9feac02	line:IDFM:C01728	future	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D Melun - Corbeil-Ess. : suppression	<p>Train supprim&#233; :<br>- ROSA d&#233;part Melun 19h11 - arriv&#233;e Corbeil-Essonnes 19h41.<br><br>Prochain train &#224; circuler :<br>- ROSA d&#233;part Melun 19h26 - arriv&#233;e Corbeil-Essonnes 19h56.<br><br>Motif : conditions de d&#233;part non r&#233;unies (Train immobilis&#233; en atelier de maintenance).<br></p><p><br></p><p><br></p>	2023-04-04 17:16:27	2023-04-04 18:00:00	2023-04-04 19:40:51
98	449fa8ee-d2fe-11ed-94b4-0a58a9feac02	line:IDFM:C01373	future	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 10 / 8 / 3 : Mouvement social - Trafic perturbé	<p>Le 06/04, Le trafic est perturbé sur l'ensemble de la ligne en raison d'un mouvement social<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-04 17:35:03	2023-04-06 05:00:00	2023-04-07 03:45:00
99	45ecaec2-d2fe-11ed-b1ba-0a58a9feac02	line:IDFM:C01375	future	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 7B / 5 : Mouvement social - Trafic très perturbé	<p>Le 06/04, Le trafic est très perturbé sur l'ensemble de la ligne en raison d'un mouvement social<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-04 17:35:05	2023-04-06 05:00:00	2023-04-07 03:45:00
100	454e4fca-d2fe-11ed-b1ba-0a58a9feac02	line:IDFM:C01383	future	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 13 : Mouvement social - Trafic perturbé	<p>Le 06/04 jusqu'à 20h, Le trafic est perturbé sur l'ensemble de la ligne en raison d'un mouvement social<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-04 17:35:04	2023-04-06 06:00:00	2023-04-06 20:45:00
101	46d8c366-d2fe-11ed-9517-0a58a9feac02	line:IDFM:C01383	future	perturbation	#FF0000	NO_SERVICE	Métro 13 : Mouvement social - Trafic interrompu	<p>Le 06/04 jusqu'à 6h, Le trafic est interrompu sur l'ensemble de la ligne en raison d'un mouvement social<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-04 17:35:07	2023-04-06 05:00:00	2023-04-06 06:45:00
102	4774fefc-d2fe-11ed-9517-0a58a9feac02	line:IDFM:C01383	future	perturbation	#FF0000	NO_SERVICE	Métro 13 : Mouvement social - Trafic interrompu	<p>Le 06/04, Le trafic est interrompu sur l'ensemble de la ligne en raison d'un mouvement social<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-04 17:35:08	2023-04-06 20:00:00	2023-04-07 03:45:00
103	ee63e616-d370-11ed-b685-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D : Créteil-Pompadour non desservi	<p>Les trains en direction de Corbeil-Essonnes et Melun ne marquent pas l'arr&#234;t Cr&#233;teil-Pompadour de 10h10 &#224; 12h55.<br><br>Pour les voyageurs d&#233;sirant descendre &#224; Cr&#233;teil-Pompadour, vous &#234;tes invit&#233;s &#224; prendre une correspondance &#224; Villeneuve-St-Georges avec un train en direction Paris Gare de Lyon.<br><br>Pour les voyageurs au d&#233;part de Cr&#233;teil-Pompadour en direction de Melun ou Corbeil-Essonnes, vous &#234;tes invit&#233;s &#224; prendre un train en direction de Paris Gare de Lyon et effectuer une correspondance &#224; Maisons-Alfort avec un train en direction de Corbeil-Essonnes ou Melun<br><br>Motif : travaux effectu&#233;s par le gestionnaire de r&#233;seau</p>	2023-04-05 07:16:10	2023-04-05 07:08:41	2023-04-05 12:55:57
104	c03037f4-d393-11ed-94b4-0a58a9feac02	line:IDFM:C01371	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 1 : Malaise voyageur - Reprise progressive / trafic reste perturbé	<p>Le trafic reprend mais reste perturbé sur l'ensemble de la ligne en raison d'un malaise voyageur   à Pont de Neuilly<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-05 11:45:03	2023-04-05 11:40:00	2023-04-06 03:45:00
105	960db1b4-d397-11ed-b685-0a58a9feac02	line:IDFM:C01742	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne A : ralentissements	<p>Le trafic est ralenti de Saint-Germain-en-Laye vers Boissy-Saint-L&#233;ger et de Saint-Germain-en-Laye vers Marne-la-Vall&#233;e Chessy. <br><br>Motif : Incident technique &#224; Nanterre-Pr&#233;fecture. <br></p>	2023-04-05 11:52:33	2023-04-05 11:49:05	2023-04-05 13:00:00
106	ebe9447a-d39e-11ed-94b4-0a58a9feac02	line:IDFM:C01386	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 3B : Difficultés d'exploitation - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de difficultés d'exploitation<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-05 12:45:03	2023-04-05 12:42:00	2023-04-06 03:45:00
107	35b11c1c-d3a5-11ed-8dcd-0a58a9feac02	line:IDFM:C01381	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 11 : Incident d'exploitation - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'un incident d'exploitation   à Châtelet<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-05 13:40:06	2023-04-05 13:33:54	2023-04-05 13:34:54
108	7fe7bb5a-d3a6-11ed-94b4-0a58a9feac02	line:IDFM:C01742	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne A : interruptions et ralentissements	<p></p><p>Le trafic est interrompu entre Nation et Val de Fontenay et entre Nation et Fontenay-sous-Bois dans les 2 sens jusqu'&#224; 15h30 et perturb&#233; sur le reste de la ligne.</p><p><br></p><p><br></p><p>Les clients &#224; destination de Marne-la-Vall&#233;e Chessy ont la possibilit&#233; d&#8217;emprunter un RER E &#224; Haussemann St-Lazare, gare en correspondance d&#8217;Auber et de descendre &#224; Val de Fontenay, pour prendre le RER A.</p><p><br></p><p><br></p><p>Pour vous rendre &#224; Nation :</p><p><br></p><p>Les clients en provenance de Poissy ou Cergy le Haut sont invit&#233;s &#224; descendre &#224; La D&#233;fense, puis &#224; emprunter un RER en Provenance de Saint-Gemain-en-Laye.</p><p><br></p><p><br></p><p>Pour vous rendre &#224; Paris nous vous invitons &#224; emprunter le ligne 1 du m&#233;tro &#224; la station B&#233;rault ou Ch&#226;teau de Vincennes.</p><p><br></p><p><br></p><p><br></p><p>Motif : accident de personne &#224; Vincennes.</p><p><br></p>	2023-04-05 14:00:41	2023-04-05 13:37:16	2023-04-05 15:30:00
109	75d018ba-d3c4-11ed-b1ba-0a58a9feac02	line:IDFM:C01372	active	perturbation	#43B77A	OTHER_EFFECT	Métro 2 : Mouvement social 6 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 6 avril, sur le métro 2 :</u></p><p>Prévoir un trafic normal.</p><p> </p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank">Plus d’informations sur le site ratp.fr</a></p>	2023-04-06 09:04:38	2023-04-06 04:30:00	2023-04-07 03:45:00
110	6bf80b78-d3c8-11ed-94b4-0a58a9feac02	line:IDFM:C01373	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 3 : Mouvement social 6 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 6 avril, sur le métro 3 :</u></p><p>Prévoir 1 train sur 2.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank" style="background-color: rgb(255, 255, 255);">Plus d’informations sur le site ratp.fr</a><br></p>	2023-04-06 09:12:48	2023-04-06 04:30:00	2023-04-07 03:45:00
111	e6f95236-d3c4-11ed-8dcd-0a58a9feac02	line:IDFM:C01386	active	perturbation	#43B77A	OTHER_EFFECT	Métro 3b : Mouvement social 6 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 6 avril, sur le métro 3b :</u></p><p>Prévoir un trafic normal.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank" style="background-color: rgb(255, 255, 255);">Plus d’informations sur le site ratp.fr</a><br></p>	2023-04-06 09:17:33	2023-04-06 04:30:00	2023-04-07 03:45:00
112	dc7348e2-d3c6-11ed-94b4-0a58a9feac02	line:IDFM:C01374	active	perturbation	#43B77A	OTHER_EFFECT	Métro 4 : Mouvement social 6 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 6 avril, sur le métro 4 :</u></p><p>Prévoir un trafic normal.</p><p>En raison des travaux d'automatisation, la ligne ferme à 22h15.<br></p><p> </p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank">Plus d’informations sur le site ratp.fr</a></p>	2023-04-06 09:29:52	2023-04-06 04:30:00	2023-04-07 03:45:00
113	401d73f2-d3c9-11ed-9517-0a58a9feac02	line:IDFM:C01375	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 5 : Mouvement social 6 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 6 avril, sur le métro 5 :</u></p><p>Prévoir 1 train sur 2 le matin et 1 train sur 3 l'après-midi.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank" style="background-color: rgb(255, 255, 255);">Plus d’informations sur le site ratp.fr</a><br></p>	2023-04-06 09:31:17	2023-04-06 04:30:00	2023-04-07 03:45:00
114	34183a50-d3c5-11ed-b1ba-0a58a9feac02	line:IDFM:C01376	active	perturbation	#43B77A	OTHER_EFFECT	Métro 6 : Mouvement social 6 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 6 avril, sur le métro 6 :</u></p><p>Prévoir un trafic normal.</p><p>La ligne risque d'être perturbée par le parcours de la manifestation prévue l'après-midi.</p><p> <br><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank" style="background-color: rgb(255, 255, 255);">Plus d’informations sur le site ratp.fr</a><br></p>	2023-04-06 09:28:13	2023-04-06 04:30:00	2023-04-07 03:45:00
115	6718d81a-d3c5-11ed-b685-0a58a9feac02	line:IDFM:C01377	active	perturbation	#43B77A	OTHER_EFFECT	Métro 7 : Mouvement social 6 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 6 avril, sur le métro 7 :</u></p><p>Prévoir un trafic normal.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank" style="background-color: rgb(255, 255, 255);">Plus d’informations sur le site ratp.fr</a><br></p>	2023-04-06 09:19:56	2023-04-06 04:30:00	2023-04-07 03:45:00
116	18c59412-d3c7-11ed-8dcd-0a58a9feac02	line:IDFM:C01378	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 8 : Mouvement social 6 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 8 avril, sur le métro 1 :</u></p><p>Circulation uniquement entre 5h30 et 23h00.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank" style="background-color: rgb(255, 255, 255);">Plus d’informations sur le site ratp.fr</a><br></p>	2023-04-06 09:25:27	2023-04-06 04:30:00	2023-04-07 03:45:00
117	96f87d78-d3ad-11ed-9517-0a58a9feac02	line:IDFM:C01378	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 8 : Mouvement social - Trafic perturbé	<p>Le 06/04 jusqu'à 23h, Le trafic est perturbé sur l'ensemble de la ligne en raison d'un mouvement social<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-05 16:57:00	2023-04-06 05:00:00	2023-04-06 23:45:00
118	1f3d859e-d3c6-11ed-9517-0a58a9feac02	line:IDFM:C01379	active	perturbation	#43B77A	OTHER_EFFECT	Métro 9 : Mouvement social 6 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 6 avril, sur le métro 9 :</u></p><p>Prévoir un trafic normal.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank" style="background-color: rgb(255, 255, 255);">Plus d’informations sur le site ratp.fr</a><br></p>	2023-04-06 09:23:23	2023-04-06 04:30:00	2023-04-07 03:45:00
119	41d54f38-d3c6-11ed-8dcd-0a58a9feac02	line:IDFM:C01380	active	perturbation	#43B77A	OTHER_EFFECT	Métro 10 : Mouvement social 6 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 6 avril, sur le métro 10 :</u></p><p>Prévoir un trafic normal.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank" style="background-color: rgb(255, 255, 255);">Plus d’informations sur le site ratp.fr</a><br></p>	2023-04-06 09:21:48	2023-04-06 04:30:00	2023-04-07 03:45:00
120	429ef58a-d3c7-11ed-8dcd-0a58a9feac02	line:IDFM:C01381	active	perturbation	#43B77A	OTHER_EFFECT	Métro 11 : Mouvement social 6 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 6 avril, sur le métro 11 :</u></p><p>Prévoir un trafic normal.</p><p>En raison de travaux, la ligne ferme à 22h00.<br></p><p> </p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank">Plus d’informations sur le site ratp.fr</a></p>	2023-04-06 09:15:26	2023-04-06 04:30:00	2023-04-07 03:45:00
121	7e3f1aa8-d3c6-11ed-94b4-0a58a9feac02	line:IDFM:C01382	active	perturbation	#43B77A	OTHER_EFFECT	Métro 12 : Mouvement social 6 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 6 avril, sur le métro 12 :</u></p><p>Prévoir un trafic normal.</p><p>Les stations suivantes&nbsp;Assemblée Nationale, Solférino sont fermées au public à partir de 11h00</p><p> </p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank">Plus d’informations sur le site ratp.fr</a></p>	2023-04-06 09:10:39	2023-04-06 04:30:00	2023-04-07 03:45:00
122	8642c504-d3c3-11ed-9517-0a58a9feac02	line:IDFM:C01383	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 13 : Mouvement social 6 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 6 avril, sur le métro 13 :</u></p><p>Prévoir 2 trains sur 3 le matin et 1 train sur 2 l'après-midi. Circulation uniquement entre 6h00 et 20h00. La ligne est fermée avant 6h00 et après 20h00. Les stations suivantes Varenne, Saint-François Xavier, Champs-Elysées Clémenceau sont fermées au public à partir de 11h00.</p><p> </p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank">Plus d’informations sur le site ratp.fr</a></p>	2023-04-06 09:35:14	2023-04-06 04:30:00	2023-04-07 03:45:00
123	1359c4d4-d3c8-11ed-94b4-0a58a9feac02	line:IDFM:C01384	active	perturbation	#43B77A	OTHER_EFFECT	Métro 14 : Mouvement social 6 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 6 avril, sur le métro 14 :</u></p><p>Prévoir un trafic normal.</p><p>En raison des travaux, la ligne est fermée à 22h.</p><p> </p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank">Plus d’informations sur le site ratp.fr</a></p>	2023-04-05 17:39:39	2023-04-06 04:30:00	2023-04-07 03:45:00
124	3f2a5ee0-d47a-11ed-94b4-0a58a9feac02	line:IDFM:C01379	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 9 : Malaise voyageur - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'un malaise voyageur   à Ranelagh<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-06 14:55:03	2023-04-06 14:49:00	2023-04-07 03:45:00
125	5898dfd0-d47c-11ed-b685-0a58a9feac02	line:IDFM:C01382	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 12 : Malaise voyageur - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'un malaise voyageur   à Lamarck - Caulaincourt<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-06 15:15:06	2023-04-06 15:09:00	2023-04-07 03:45:00
126	3ba69ff2-d481-11ed-94b4-0a58a9feac02	line:IDFM:C01383	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 13 : Bagage oublié - Reprise progressive / trafic reste perturbé	<p>Le trafic reprend mais reste perturbé sur l'ensemble de la ligne en raison d'un bagage oublié   à Saint-Denis – Université<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-06 16:05:02	2023-04-06 16:01:00	2023-04-07 03:45:00
127	add969b8-d488-11ed-b685-0a58a9feac02	line:IDFM:C01371	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 1 : Mouvement social 7 février - Stations fermées	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le mardi 7 mars : sur le métro 1 :</u></p><p>Trafic normal.<br></p><p>Les accès aux stations Assemblée Nationale, Champs-Élysées - Clemenceau, Saint-François-Xavier, Solférino et Varenne sont fermés.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank">Plus d’informations sur le site ratp.fr</a></p>	2023-04-06 16:38:21	2023-04-06 16:20:00	2023-04-07 03:45:00
128	60e8243c-d488-11ed-94b4-0a58a9feac02	line:IDFM:C01387	active	information	#43B77A	OTHER_EFFECT	Métro 7b : Mouvement social 6 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 6 avril : sur le métro 7b :</u></p><p>Prévoir un trafic normal.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank">Plus d’informations sur le site ratp.fr</a></p>	2023-04-06 16:36:12	2023-04-06 16:20:00	2023-04-07 02:00:00
129	ce604332-d48d-11ed-94b4-0a58a9feac02	line:IDFM:C01374	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 4 : Difficultés d'exploitation - Train stationne	<p>Le train stationne à Bagneux–Lucie Aubrac en direction de Porte de Clignancourt en raison de difficultés d'exploitation<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-06 17:15:03	2023-04-06 17:11:00	2023-04-07 03:45:00
130	5158324a-d48e-11ed-b685-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D : Melun <-> Corbeil-Ess. trafic ralenti	<p>Le trafic est ralenti entre Melun et Corbeil Essonnes dans les 2 sens. <br><br>Motif : panne sur les installations du gestionnaire de r&#233;seau &#224; Ponthierry<br></p>	2023-04-06 17:18:43	2023-04-06 17:14:25	2023-04-06 18:30:46
131	b6339908-d48d-11ed-b1ba-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D : ralentissements	<p>Le trafic est ralenti de Paris Gare de Lyon vers Melun et de Paris Gare de Lyon vers Corbeil Essonnes via Evry Courcouronnes. <br></p><p><br></p><p>Des temps d'allongement de temps de parcours jusqu'&#224; 20 minutes sont &#224; pr&#233;voir.</p><p>Motif : acte de vandalisme &#224; Maisons-Alfort (la Police est sur place avec les agents).<br></p>	2023-04-06 17:18:59	2023-04-06 17:09:05	2023-04-06 18:30:59
132	b7d2fdb6-d493-11ed-94b4-0a58a9feac02	line:IDFM:C01743	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne B : Denfert Rochereau non desservie	<p>La gare de Denfert Rochereau n'est pas desservie jusqu'&#224; 19h. <br><br>Motif : mesures de s&#233;curit&#233; (&#224; la demande des forces de l'ordre).</p>	2023-04-06 17:59:13	2023-04-06 17:54:52	2023-04-06 19:00:58
133	eb1c81f2-d488-11ed-8dcd-0a58a9feac02	line:IDFM:C01379	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 9 : Incident technique - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'un incident technique   à Alma - Marceau<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-06 18:30:03	2023-04-06 18:25:00	2023-04-07 03:45:00
134	28e5821e-d49c-11ed-b685-0a58a9feac02	line:IDFM:C01742	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne A : ralentissements	<p>Le trafic est ralenti entre La D&#233;fense et Saint-Germain-en-Laye dans les 2 sens. <br><br>Motif : affaires oubli&#233;es en gare de Rueil-Malmaison.</p>	2023-04-06 19:10:45	2023-04-06 18:55:06	2023-04-06 20:00:00
135	e2746d06-d49e-11ed-94b4-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C Péreire L. - Pontoise : suppression	<p>Train supprim&#233; :</p><p>- Le train NORA au d&#233;part de la gare Massy Palaiseau &#224; 20h10, est terminus en gare de P&#233;reire Levallois.<br><br>Prochain train &#224; circuler :</p><p>- Le train NORA&#160; au d&#233;part de la gare de Massy Palaiseau &#224; 20h40, au passage en gare de P&#233;reire Levallois &#224; 21h48, et pr&#233;vu au terminus de la gare de Pontoise &#224; 22h33.<br><br>Motif : conditions de d&#233;part non r&#233;unies.<br></p><p><br></p><p><br></p>	2023-04-06 19:17:18	2023-04-06 19:11:40	2023-04-06 22:00:50
136	f04cdfe4-d4ad-11ed-b685-0a58a9feac02	line:IDFM:C01379	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 9 : Difficultés d'exploitation - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de difficultés d'exploitation<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-06 21:05:04	2023-04-06 20:59:00	2023-04-07 03:45:00
137	ec5a1058-d4b4-11ed-b685-0a58a9feac02	line:IDFM:C01379	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 9 : Personnes sur les voies - Reprise progressive / trafic reste perturbé	<p>Le trafic reprend mais reste perturbé sur l'ensemble de la ligne en raison de personnes sur les voies   à Porte de Montreuil<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-06 21:55:04	2023-04-06 21:52:00	2023-04-07 03:45:00
138	9663842a-d3ad-11ed-8dcd-0a58a9feac02	line:IDFM:C01378	active	perturbation	#FF0000	NO_SERVICE	Métro 8 : Mouvement social - Trafic interrompu	<p>Le 06/04, Le trafic est interrompu sur l'ensemble de la ligne à partir de 23h00 en raison d'un mouvement social<br><a href="http://www.ratp.fr">Plus d'informations sur le site ratp.fr</a></p>	2023-04-05 17:53:57	2023-04-06 23:00:00	2023-04-07 03:45:00
139	84bc28f4-d4bf-11ed-b1ba-0a58a9feac02	line:IDFM:C01742	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne A : ralentissements	<p>Le trafic est ralenti entre Saint-Germain-en-Laye et La D&#233;fense dans les 2 sens. <br><br>Motif : individus sur les voies &#224; Nanterre-Ville</p>	2023-04-06 23:10:55	2023-04-06 23:08:17	2023-04-07 00:50:00
140	ec35a39a-d53f-11ed-b685-0a58a9feac02	line:IDFM:C01381	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 11 : Indisponibilité de trains - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de l'indisponibilité de trains<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-07 14:30:04	2023-04-07 14:26:00	2023-04-08 03:45:00
175	2ddc9066-d9c7-11ed-9517-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C : ralentissements	<p>Le trafic est ralenti de Dourdan La For&#234;t vers Invalides. <br><br>Motif : panne sur les installations du gestionnaire de r&#233;seau (Panne d'un passage &#224; niveau &#224; la Norville)<br></p>	2023-04-13 08:48:21	2023-04-13 08:44:50	2023-04-13 10:00:06
141	104c687e-d48a-11ed-9517-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C : mouvement social national le 7 avril	<p>Vendredi 7 avril :<br><br>Le trafic de la ligne Cest l&#233;g&#232;rement perturb&#233;.<br><br>Pr&#233;voir en moyenne 3 trains sur 4.<br><br>Pour pr&#233;parer votre trajet, rendez-vous sur le calculateur d'itin&#233;raires de l&#8217;appli Ile-de-France Mobilit&#233;s, le site Transilien.com et l&#8217;appli SNCF.<br><br>Avant de vous rendre en gare, nous vous conseillons de v&#233;rifier les horaires de vos trains.<br><br>Motif : mouvement social national interprofessionnel.<br></p>	2023-04-07 06:06:01	2023-04-07 03:00:00	2023-04-08 02:30:00
142	3fc5f21e-d48a-11ed-9517-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D : mouvement social national le 7 avril	<p>Vendredi 7 avril :<br><br>Le trafic de la ligne D est l&#233;g&#232;rement perturb&#233;. <br><br>Pr&#233;voir quelques suppressions.<br><br>Pour pr&#233;parer votre trajet, rendez-vous sur le calculateur d'itin&#233;raires de l&#8217;appli Ile-de-France Mobilit&#233;s, le site Transilien.com et l&#8217;appli SNCF.<br><br>Avant de vous rendre en gare, nous vous conseillons de v&#233;rifier les horaires de vos trains.<br><br>Motif : mouvement social national interprofessionnel.<br></p>	2023-04-07 06:05:07	2023-04-07 03:00:00	2023-04-08 02:30:00
143	2ef068e4-d53d-11ed-8dcd-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D Juvisy - Corbeil-Ess. : suppression	<p>Train supprim&#233; pour les gares de : Juvisy, Viry-Chatillon, Ris-Orangis, Grand-Bourg et Evry-Val-de-Seine <br></p><p>- Train <b>ZOVO </b>d&#233;part Juvisy <b>14h35 </b>arriv&#233;e Melun 15h24 circule au d&#233;part de Corbeil-Essonnes &#224; 14h53</p><ul><li>Pour les voyageurs au d&#233;part des gares de Juvisy, Viry-Chatillon, Ris-Orangis, Grand-Bourg et Evry-Val-de-Seine en direction de Corbeil-Essonnes :</li></ul><p>- Train <b>BOVO</b> d&#233;part de Juvisy &#224; <b>15h05</b> passage Corbeil-Essonnes 14h22 arriv&#233;e Malesherbes 16h06.</p><ul><li>Pour les voyageurs au d&#233;part des gares de Juvisy, Viry-Chatillon, Ris-Orangis, Grand-Bourg et Evry-Val-de-Seine en direction de Melun :&#8203;</li></ul><p>- Train <b>ZOVO</b> d&#233;part de Juvisy &#224; <b>16h19</b> passage Corbeil-Essonnes 16h37 arriv&#233;e Melun 17h09.<br></p><p>Motif : conditions de d&#233;part non r&#233;unies</p>	2023-04-07 14:47:26	2023-04-07 13:57:51	2023-04-07 15:25:19
144	e9465b3c-d546-11ed-b685-0a58a9feac02	line:IDFM:C01373	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 3B / 3 : Personnes sur les voies - Trafic perturbé	<p>Les trains stationnent sur l'ensemble de la ligne en raison de personnes sur les voies<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-07 15:20:05	2023-04-07 15:16:05	2023-04-07 16:02:05
145	4c9063a8-d548-11ed-94b4-0a58a9feac02	line:IDFM:C01386	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 3B : Personnes sur les voies - Trafic très perturbé	<p>Le trafic est très perturbé sur l'ensemble de la ligne en raison de personnes sur les voies<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-07 15:30:01	2023-04-07 15:27:00	2023-04-08 03:45:00
146	b2f04b4e-d549-11ed-9517-0a58a9feac02	line:IDFM:C01378	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 8 : Divers incidents - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de divers incidents<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-07 15:40:03	2023-04-07 15:37:00	2023-04-08 03:45:00
147	e68041d0-d549-11ed-94b4-0a58a9feac02	line:IDFM:C01727	active	perturbation	#FF0000	NO_SERVICE	Ligne C : Massy-P. - Vers.Chantiers interrompu	<p>Le trafic est interrompu entre Massy-Palaiseau et Versailles Chantiers jusqu'&#224; 16h30.<br><br>* La ligne de bus 91.10 dessert Massy-Palaiseau et Saint-Quentin-en-Yvelines 7/7j, de 6h30 &#224; 23h30.<br>* La ligne de bus 91.11 dessert Massy-Palaiseau et Saint-Quentin-en-Yvelines, du lundi au vendredi<br>entre 5h30 et 22h00, et le samedi de 7h00 &#224; 20h00.<br>* La ligne de bus 15 dessert Bi&#232;vres, Igny, Massy-Palaiseau, et le Centre Commercial V&#233;lizy 2<br>(Tramway T6 vers Viroflay-Rive-Gauche), en semaine de 6h00 &#224; 21h00 et le samedi de 6h30 &#224; 21h00.<br>* La ligne de bus 33 dessert Bi&#232;vres et Chaville-V&#233;lizy (Rive-Gauche et Rive-Droite) en semaine, de<br>5h30 &#224; 21h00.<br>* La ligne de bus 11 dessert Vauboyen et Jouy-en-Josas en semaine de 7h00 &#224; 19h45.<br>* La ligne de bus 32 dessert Jouy-en-Josas et Versailles-Chantiers, en semaine de 6h00 &#224; 22h00, le<br>samedi de 7h00 &#224; 22h45 et le dimanche de 7h45 &#224; 22h45.<br>* La ligne de bus 264 dessert Jouy-en-Josas, Petit-Jouy et Versailles-Chantiers en semaine de 6h50 &#224;<br>19h50.<br><br>Motif : accident routier &#224; Jouy en Josas.<br><br><br></p>	2023-04-07 15:41:29	2023-04-07 15:32:49	2023-04-07 16:30:48
148	7f9b8f4e-d54c-11ed-b685-0a58a9feac02	line:IDFM:C01387	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 7B : Personnes sur les voies - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de personnes sur les voies   à Place des Fêtes<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-07 16:00:05	2023-04-07 15:56:00	2023-04-08 03:45:00
149	af1813e2-d550-11ed-b1ba-0a58a9feac02	line:IDFM:C01381	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 11 : Indisponibilité de trains - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de l'indisponibilité de trains<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-07 16:30:03	2023-04-07 16:28:00	2023-04-08 03:45:00
150	d9db8740-d554-11ed-b1ba-0a58a9feac02	line:IDFM:C01742	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne A : ralentissements	<p>Le trafic est ralenti entre Saint-Germain-en-Laye et La D&#233;fense dans les 2 sens. <br><br>Motif : &#160;panne de signalisation en gare de St-Germain en Laye.</p>	2023-04-07 16:59:53	2023-04-07 16:57:42	2023-04-07 18:00:00
151	7621193a-d55a-11ed-94b4-0a58a9feac02	line:IDFM:C01378	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 8 : Incident technique - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'un incident technique   à Pointe du Lac<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-07 17:40:02	2023-04-07 17:35:00	2023-04-08 03:45:00
163	7112836a-d93e-11ed-94b4-0a58a9feac02	line:IDFM:C01387	active	perturbation	#43B77A	OTHER_EFFECT	Métro 7b : Mouvement social 13 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 13 avril, sur le métro 7b :</u></p><p>Prévoir un trafic normal.</p><p>Certaines stations pourraient être fermées.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank">Plus d’informations sur le site ratp.fr</a></p>	2023-04-12 16:29:32	2023-04-13 04:30:00	2023-04-14 03:45:00
164	dac78918-d871-11ed-9517-0a58a9feac02	line:IDFM:C01378	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 13 / 8 : Mouvement social - Trafic perturbé	<p>Le 13/04, Le trafic est perturbé sur l'ensemble de la ligne avec 2 trains sur 3 en raison d'un mouvement social<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-12 15:28:04	2023-04-13 05:00:00	2023-04-14 03:45:00
191	afe98334-eb60-11ed-a257-0a58a9feac02	line:IDFM:C01383	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 13 : Personnes sur les voies - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de personnes sur les voies<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-05 18:20:02	2023-05-05 18:18:00	2023-05-06 03:45:00
152	71a960b0-d55a-11ed-8dcd-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C : interruption et ralentissements	<p>Le trafic est interrompu entre Massy-Palaiseau et Versailles Chantiers de 18h30 jusqu'&#224; 19h45 et ralenti entre Massy-Palaiseau et Juvisy.</p><p>des travaux de r&#233;paration d'un passage &#224; niveau sont effectu&#233;s &#224; ces horaires.</p><p><br></p><p>* La ligne de bus 91.10 dessert Massy-Palaiseau et Saint-Quentin-en-Yvelines 7/7j, de 6h30 &#224; 23h30.<br>* La ligne de bus 91.11 dessert Massy-Palaiseau et Saint-Quentin-en-Yvelines, du lundi au vendredi<br>entre 5h30 et 22h00, et le samedi de 7h00 &#224; 20h00.<br>* La ligne de bus 15 dessert Bi&#232;vres, Igny, Massy-Palaiseau, et le Centre Commercial V&#233;lizy 2<br>(Tramway T6 vers Viroflay-Rive-Gauche), en semaine de 6h00 &#224; 21h00 et le samedi de 6h30 &#224; 21h00.<br>* La ligne de bus 33 dessert Bi&#232;vres et Chaville-V&#233;lizy (Rive-Gauche et Rive-Droite) en semaine, de<br>5h30 &#224; 21h00.<br>* La ligne de bus 11 dessert Vauboyen et Jouy-en-Josas en semaine de 7h00 &#224; 19h45.<br>* La ligne de bus 32 dessert Jouy-en-Josas et Versailles-Chantiers, en semaine de 6h00 &#224; 22h00, le<br>samedi de 7h00 &#224; 22h45 et le dimanche de 7h45 &#224; 22h45.<br>* La ligne de bus 264 dessert Jouy-en-Josas, Petit-Jouy et Versailles-Chantiers en semaine de 6h50 &#224;<br>19h50.<br></p><p>Motif : panne sur les installations du gestionnaire de r&#233;seau &#224; Jouy en Josas.<br></p>	2023-04-07 17:39:55	2023-04-07 17:35:55	2023-04-07 19:45:17
153	8eadd74a-d55a-11ed-b685-0a58a9feac02	line:IDFM:C01728	active	perturbation	#FF0000	NO_SERVICE	Ligne D : Paris Lyon - Paris Nord interrompu	<p>Le trafic est interrompu de Paris Gare de Lyon vers Paris Gare du Nord jusqu'&#224; 18h30.<br><br>Pour se d&#233;placer entre Paris Gare du Nord et Paris Gare de Lyon, emprunter le RER B et le RER A avec changement &#224; Ch&#226;telet Les Halles.<br><br><a href="https://www.transilien.com/sites/transilien/files/ibis-parisnord-parislyon-ligne-d-20220809.pdf " target="">Pour conna&#238;tre les itin&#233;raires alternatifs entre Paris Gare du Nord, Ch&#226;telet les Halles et Paris Gare de Lyon, cliquez sur ce lien pour t&#233;l&#233;charger l'affiche PDF.</a><br><br>La circulation des trains est normale entre Juvisy et Malesherbes via Ris Orangis et entre Corbeil et Melun.  <b>[Heures pointe]</b><br><br>Motif : panne d'un train dans le secteur de Paris Gare de Lyon.<br><br><br></p>	2023-04-07 17:40:43	2023-04-07 17:37:15	2023-04-07 18:30:47
154	dc798a40-d55b-11ed-8dcd-0a58a9feac02	line:IDFM:C01381	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 11 : Indisponibilité de trains - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de l'indisponibilité de trains<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-07 17:50:03	2023-04-07 17:45:00	2023-04-08 03:45:00
155	b8f3a02a-d92e-11ed-b1ba-0a58a9feac02	line:IDFM:C01371	active	perturbation	#43B77A	OTHER_EFFECT	Métro 1 : Mouvement social 13 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 13 avril : sur le métro 1 :</u></p><p>Prévoir un trafic normal.<br></p><p>La station Palais Royal-Musée du Louvre est fermée à partir de 11h.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank">Plus d’informations sur le site ratp.fr</a></p>	2023-04-12 17:23:48	2023-04-13 04:30:00	2023-04-14 03:45:00
156	f6a8a244-d92e-11ed-b1ba-0a58a9feac02	line:IDFM:C01372	active	perturbation	#43B77A	OTHER_EFFECT	Métro 2 : Mouvement social 13 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 13 avril, sur le métro 2 :</u></p><p>Prévoir un trafic normal.</p><p>Certaines stations pourraient être fermées.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank">Plus d’informations sur le site ratp.fr</a></p>	2023-04-12 14:40:08	2023-04-13 04:30:00	2023-04-14 03:45:00
157	517feb96-d92f-11ed-94b4-0a58a9feac02	line:IDFM:C01373	active	perturbation	#43B77A	OTHER_EFFECT	Métro 3 : Mouvement social 13 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 13 avril, sur le métro 3 :</u></p><p>Prévoir un trafic normal.</p><p>Certaines stations pourraient être fermées.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank">Plus d’informations sur le site ratp.fr</a></p>	2023-04-12 14:41:17	2023-04-13 04:30:00	2023-04-14 03:45:00
158	6e9d9336-d92f-11ed-9517-0a58a9feac02	line:IDFM:C01386	active	perturbation	#43B77A	OTHER_EFFECT	Métro 3b : Mouvement social 13 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 13 avril, sur le métro 3b :</u></p><p>Prévoir un trafic normal.</p><p>Certaines stations pourraient être fermées.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank">Plus d’informations sur le site ratp.fr</a></p>	2023-04-12 14:42:09	2023-04-13 04:30:00	2023-04-14 03:45:00
159	47f2f568-d930-11ed-94b4-0a58a9feac02	line:IDFM:C01374	active	perturbation	#43B77A	OTHER_EFFECT	Métro 4 : Mouvement social 13 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 13 avril, sur le métro 4 :</u></p><p>Prévoir un trafic normal.</p><p>Certaines stations pourraient être fermées.</p><p>En raison des travaux d'automatisation, la ligne sera fermée à 22h15.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank">Plus d’informations sur le site ratp.fr</a></p>	2023-04-12 17:32:43	2023-04-13 04:30:00	2023-04-14 03:45:00
160	c5d01d76-d930-11ed-8dcd-0a58a9feac02	line:IDFM:C01375	active	perturbation	#43B77A	OTHER_EFFECT	Métro 5 : Mouvement social 13 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 13 avril, sur le métro 5 :</u></p><p>Prévoir un trafic normal.</p><p>Certaines stations pourraient être fermées.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank">Plus d’informations sur le site ratp.fr</a></p>	2023-04-12 14:53:45	2023-04-13 04:30:00	2023-04-14 03:45:00
161	e2146a04-d931-11ed-b685-0a58a9feac02	line:IDFM:C01376	active	perturbation	#43B77A	OTHER_EFFECT	Métro 6 : Mouvement social 13 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 13 avril, sur le métro 6 :</u></p><p>Prévoir un trafic normal.</p><p>Certaines stations pourraient être fermées.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank">Plus d’informations sur le site ratp.fr</a></p>	2023-04-12 14:59:38	2023-04-13 03:45:00	2023-04-14 04:30:00
162	2c2f2c5a-d932-11ed-8dcd-0a58a9feac02	line:IDFM:C01377	active	perturbation	#43B77A	OTHER_EFFECT	Métro 7 : Mouvement social 13 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 13 avril, sur le métro 7 :</u></p><p>Prévoir un trafic normal.</p><p>Les stations Pyramides et Palais Royal-Musée du Louvre sont fermées à partir de 11h.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank">Plus d’informations sur le site ratp.fr</a></p>	2023-04-12 17:24:05	2023-04-13 04:30:00	2023-04-14 03:45:00
165	fb64cb9a-d939-11ed-94b4-0a58a9feac02	line:IDFM:C01378	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 8 : Mouvement social 13 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 13 avril, sur le métro 8 :</u></p><p>Prévoir 2 trains sur 3.</p><p>Certaines stations pourraient être fermées.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank">Plus d’informations sur le site ratp.fr</a></p>	2023-04-12 15:57:37	2023-04-13 04:30:00	2023-04-14 03:45:00
166	931f4bca-d932-11ed-9517-0a58a9feac02	line:IDFM:C01379	active	perturbation	#43B77A	OTHER_EFFECT	Métro 9 : Mouvement social 13 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 13 avril, sur le métro 9 :</u></p><p>Prévoir un trafic normal.</p><p>Certaines stations pourraient être fermées.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank">Plus d’informations sur le site ratp.fr</a></p>	2023-04-12 15:04:35	2023-04-13 04:30:00	2023-04-14 03:45:00
167	aa524766-d937-11ed-9517-0a58a9feac02	line:IDFM:C01380	active	perturbation	#43B77A	OTHER_EFFECT	Métro 10 : Mouvement social 13 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 13 avril, sur le métro 10 :</u></p><p>Prévoir un trafic normal.</p><p>Certaines stations pourraient être fermées.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank">Plus d’informations sur le site ratp.fr</a></p>	2023-04-12 15:41:02	2023-04-13 04:30:00	2023-04-14 03:45:00
168	c9138728-d937-11ed-b1ba-0a58a9feac02	line:IDFM:C01381	active	perturbation	#43B77A	OTHER_EFFECT	Métro 11 : Mouvement social 13 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 13 avril, sur le métro 11 :</u></p><p>Prévoir un trafic normal.</p><p>Certaines stations pourraient être fermées.</p><p>En raison des travaux, la ligne sera fermée à 22h00.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank">Plus d’informations sur le site ratp.fr</a></p>	2023-04-12 17:31:22	2023-04-13 04:30:00	2023-04-14 03:45:00
169	21b4b4ce-d938-11ed-9517-0a58a9feac02	line:IDFM:C01382	active	perturbation	#43B77A	OTHER_EFFECT	Métro 12 : Mouvement social 13 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 13 avril, sur le métro 12 :</u></p><p>Prévoir un trafic normal.</p><p>Certaines stations pourraient être fermées.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank">Plus d’informations sur le site ratp.fr</a></p>	2023-04-12 15:44:22	2023-04-13 04:30:00	2023-04-14 03:45:00
170	330d99e4-d941-11ed-94b4-0a58a9feac02	line:IDFM:C01383	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 13 : Mouvement social 13 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 13 avril, sur le métro 13 :</u></p><p>Prévoir 2 trains sur 3.</p><p>Certaines stations pourraient être fermées.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank">Plus d’informations sur le site ratp.fr</a></p>	2023-04-12 16:49:17	2023-04-13 04:30:00	2023-04-14 03:45:00
171	98fb2ff8-d939-11ed-b685-0a58a9feac02	line:IDFM:C01384	active	perturbation	#43B77A	OTHER_EFFECT	Métro 14 : Mouvement social 13 avril	<p><span style="background-color: rgb(206, 231, 247);">Information Ile de France Mobilités :</span></p><p><u>Mouvement social le jeudi 13 avril, sur le métro 14 :</u></p><p>Prévoir un trafic normal.</p><p>La station Pyramides est fermée à partir de 11h.</p><p>En raison des travaux liés au prolongement, la ligne sera fermée à 22h00.</p><p><a href="https://www.ratp.fr/infos-trafic#infos-trafic__item_1" target="_blank" style="background-color: rgb(255, 255, 255);">Plus d’informations sur le site ratp.fr</a><br></p>	2023-04-12 17:30:50	2023-04-13 04:30:00	2023-04-14 03:45:00
172	d0448c1e-d878-11ed-94b4-0a58a9feac02	line:IDFM:C01742	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne  A : mouvement social national le 13 avril	<p>Jeudi 13 avril :<br><br>Le trafic de la ligne A est perturb&#233;.<br><br>Pr&#233;voir en moyenne 3 trains sur 4.<br><br><a href="https://www.transilien.com/sites/transilien/files/sentinelle-20230413-estouest-grevedu13avril.pdf" target="">Pour conna&#238;tre les horaires des trains en direction Cergy le Haut /Poissy et St-Germain en Laye, cliquez sur ce lien pour t&#233;l&#233;charger l'affiche pdf.</a><br><br><a href="https://www.transilien.com/sites/transilien/files/sentinelle-20230413-ouestest-grevedu13avril.pdf" target="">Pour conna&#238;tre les horaires des trains en direction de de Boissy St-L&#233;ger et Marne la Vall&#233;e, cliquez sur ce lien pour t&#233;l&#233;charger l'affiche pdf.</a><br><br>Pour pr&#233;parer votre trajet, rendez-vous sur le calculateur d'itin&#233;raires de l&#8217;appli Ile-de-France Mobilit&#233;s, le site Transilien.com et l&#8217;appli SNCF.<br><br>Avant de vous rendre en gare, nous vous conseillons de v&#233;rifier les horaires de vos trains.<br><br>Motif : mouvement social national interprofessionnel.<br></p>	2023-04-13 05:51:45	2023-04-13 03:00:00	2023-04-14 02:30:00
173	218b39a6-d879-11ed-b1ba-0a58a9feac02	line:IDFM:C01743	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne  B : mouvement social national le 13 avril	<p>Jeudi 13 avril :<br><br>Le trafic est quasi normal sur l&#8217;ensemble de la ligne B. Pr&#233;voir en moyenne 4 trains sur 5 en pointe et 3 trains sur 4 en heures creuses.<br><br>Trafic interrompu &#224; partir de 22h45 entre Ch&#226;telet les Halles et A&#233;roport CDG2/Mitry-Claye pour travaux.<br><br>L'interconnexion est maintenue &#224; Gare du Nord.<br><br><a href="https://www.transilien.com/sites/transilien/files/sentinelle-affichegrevedu13avrildirectionsaintremy.pdf" target="">Pour conna&#238;tre les horaires des trains en direction de robinson/st-r&#233;my l&#232;s chevreuse, cliquez sur ce lien pour t&#233;l&#233;charger l'affiche pdf.</a><br><br><a href="https://www.transilien.com/sites/transilien/files/sentinelle-affichegrevedu13avril-directioncdg.pdf" target="">Pour conna&#238;tre les horaires des trains en direction de A&#233;roport Charles de Gaulle 2/ Mitry Claye, cliquez sur ce lien pour t&#233;l&#233;charger l'affiche pdf.</a><br><br>Pour pr&#233;parer votre trajet, rendez-vous sur le calculateur d'itin&#233;raires de l&#8217;appli Ile-de-France Mobilit&#233;s, le site Transilien.com et l&#8217;appli SNCF.<br><br>Avant de vous rendre en gare, nous vous conseillons de v&#233;rifier les horaires de vos trains.<br><br>Motif : mouvement social national interprofessionnel.<br></p>	2023-04-13 05:55:41	2023-04-13 03:00:00	2023-04-14 02:30:00
174	b5585ec6-d878-11ed-94b4-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne  C : mouvement social national le 13 avril	<p>Jeudi 13 avril :<br><br>Le trafic de la ligne C est perturb&#233;.<br><br>Pr&#233;voir en moyenne 2 trains sur 3.<br><br>Le trafic devrait rester l&#233;g&#232;rement perturb&#233; vendredi 14 avril.<br><br>Pour pr&#233;parer votre trajet, rendez-vous sur le calculateur d'itin&#233;raires de l&#8217;appli Ile-de-France Mobilit&#233;s, le site Transilien.com et l&#8217;appli SNCF.<br><br>Avant de vous rendre en gare, nous vous conseillons de v&#233;rifier les horaires de vos trains.<br><br>Motif : mouvement social national interprofessionnel.<br><br></p>	2023-04-13 06:00:04	2023-04-13 03:00:00	2023-04-14 02:30:00
176	76ffc704-d878-11ed-b1ba-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne  D : mouvement social national le 13 avril	<p>Jeudi 13 avril, le trafic de la ligne D est fortement perturb&#233;.</p><p>Pr&#233;voir en moyenne 1 train sur 2.</p><p>L'interconnexion est maintenue entre Gare de Lyon et Ch&#226;telet les Halles.<br><br>Dans la mesure du possible, nous vous recommandons de limiter vos d&#233;placements.<br><br>Pour pr&#233;parer votre trajet, rendez-vous sur le calculateur d'itin&#233;raires de l&#8217;appli Ile-de-France Mobilit&#233;s, le site Transilien.com et l&#8217;appli SNCF.<br><br>Avant de vous rendre en gare, nous vous conseillons de v&#233;rifier les horaires de vos trains.<br><br><br>Motif : mouvement social national interprofessionnel<br></p>	2023-04-13 06:01:18	2023-04-13 03:00:00	2023-04-14 02:30:00
177	2ed1df16-d879-11ed-94b4-0a58a9feac02	line:IDFM:C01729	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne  E : mouvement social national le 13 avril	<p>Jeudi 13 avril, le trafic de la ligne E est perturb&#233;. Pr&#233;voir en moyenne 2 trains sur 3.<br><br>Pour pr&#233;parer votre trajet, rendez-vous sur le calculateur d'itin&#233;raires de l&#8217;appli Ile-de-France Mobilit&#233;s, le site Transilien.com et l&#8217;appli SNCF.<br><br>Avant de vous rendre en gare, nous vous conseillons de v&#233;rifier les horaires de vos trains.<br><br>Motif : mouvement social national interprofessionnel<br><br></p>	2023-04-13 08:44:48	2023-04-13 03:00:00	2023-04-14 02:30:00
178	97c11f3c-d9d2-11ed-8dcd-0a58a9feac02	line:IDFM:C01371	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 1 : Incident au niveau des portes de quai - Trafic très perturbé	<p>Le trafic est très perturbé sur l'ensemble de la ligne en raison d'un incident au niveau des portes de quai   à Bastille<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-13 10:10:03	2023-04-13 10:06:00	2023-04-14 03:45:00
179	5d5e1b0a-dd25-11ed-8dcd-0a58a9feac02	line:IDFM:C01371	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 1 : Incident d'exploitation - Reprise progressive / trafic reste perturbé	<p>Le trafic reprend mais reste perturbé sur l'ensemble de la ligne en raison d'un incident d'exploitation   à Charles de Gaulle - Etoile<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-17 17:05:02	2023-04-17 16:57:03	2023-04-17 16:58:03
180	27648dba-dd28-11ed-9517-0a58a9feac02	line:IDFM:C01372	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 2 : Incident technique - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'un incident technique   à Nation<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-17 17:10:03	2023-04-17 17:02:58	2023-04-17 17:03:58
181	ba3d3270-dd34-11ed-b685-0a58a9feac02	line:IDFM:C01372	active	perturbation	#FF0000	NO_SERVICE	Métro 2 : Bagage oublié - Trafic interrompu	<p>Le trafic est interrompu entre Porte Dauphine et Charles de Gaulle - Etoile en raison d'un bagage oublié   à Porte Dauphine<br>Heure de reprise estimée : 18h30.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-17 17:30:05	2023-04-17 17:25:00	2023-04-18 03:45:00
182	eed70cde-dd31-11ed-9517-0a58a9feac02	line:IDFM:C01378	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 8 : Incident technique - Trafic perturbé	<p>Le trafic est perturbé entre La Motte-Picquet - Grenelle et Balard en direction de Balard en raison d'un incident technique   à Balard<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-04-17 17:35:09	2023-04-17 17:31:43	2023-04-17 17:32:43
183	9d3f267c-e9a2-11ed-b685-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C : suppressions les 04 et 05/05	<p>Jeudi 4 et vendredi 5 mai :<br><br>Le trafic de la ligne C est r&#233;duit et quelques suppressions sont &#224; pr&#233;voir.<br><br>V&#233;rifiez si votre train circule sur : <br>-&#160;&#160;&#160;&#160;L&#8217;appli Ile-de-France Mobilit&#233;s,<br>-&#160;&#160;&#160;&#160;Le site Transilien.com,<br>-&#160;&#160;&#160;&#160;SNCF Connect ou votre appli de mobilit&#233;.<br><br>Motif : difficult&#233;s li&#233;es &#224; un manque de personnel.<br><br><br></p>	2023-05-03 13:06:55	2023-05-04 03:00:00	2023-05-06 02:00:00
184	c378aff0-decd-11ed-9517-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D : trafic réduit du 24 avril au 5 mai	<p>Du lundi 24 avril au vendredi 05 mai 2023 sauf samedi 29, dimanche 30 avril et lundi 1er mai :<br>&#160;<br>L&#8217;offre de transport du RER D est modifi&#233;e pendant la p&#233;riode des vacances scolaires.<br><br>Pour pr&#233;parer votre trajet, rendez-vous sur le calculateur d'itin&#233;raires de l&#8217;appli Ile-de-France Mobilit&#233;s, le site Transilien.com et l&#8217;appli SNCF.<br><br>Avant de vous rendre en gare, nous vous conseillons de v&#233;rifier les horaires de vos trains.<br><br>Motif : difficult&#233;s li&#233;es &#224; un manque de personnel.<br></p>	2023-04-19 18:18:04	2023-05-02 03:00:00	2023-05-06 03:00:00
185	5ba669de-eb4e-11ed-8b34-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D : Juvisy - Corbeil-Essonnes : suppression	<p>Train supprim&#233; pour les gares de : Juvisy, Viry-Chatillon, Ris-Orangis, Grand-Bourg et Evry-Val-de-Seine : <br><br>&#160;<br>- Train BOVO d&#233;part de Juvisy &#224; 16h05 - arriv&#233;e Malesherbes 17h06 circule au d&#233;part de Corbeil-Essonnes &#224; 16h23.</p><p><br></p><p>Pour les voyageurs au d&#233;part des gares de Juvisy, Viry-Chatillon, Ris-Orangis, Grand-Bourg et Evry-Val-de-Seine prochain train :<br><br>- Train ZOVO d&#233;part de Juvisy &#224; 16h19 - arriv&#233;e Melun &#224; 17h09.<br>&#160;<br><br>Motif : conditions de d&#233;part non r&#233;unies.<br></p>	2023-05-05 16:10:47	2023-05-05 16:05:04	2023-05-05 16:25:14
186	9ec7adac-eb50-11ed-8b34-0a58a9feac02	line:IDFM:C01379	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 9 : Incident d'exploitation - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'un incident d'exploitation à Porte de Montreuil<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-05 16:25:01	2023-05-05 16:23:00	2023-05-06 03:45:00
187	d1d64a74-eb54-11ed-a257-0a58a9feac02	line:IDFM:C01379	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 9 : Personnes sur les voies - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de personnes sur les voies à Robespierre<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-05 17:00:10	2023-05-05 16:53:47	2023-05-05 16:54:47
188	d081f036-eb5b-11ed-8b34-0a58a9feac02	line:IDFM:C01379	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 9 : Personnes sur les voies - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de personnes sur les voies à Trocadéro<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-05 17:45:09	2023-05-05 17:43:00	2023-05-06 03:45:00
189	e7715b40-eb5d-11ed-b125-0a58a9feac02	line:IDFM:C01379	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 9 : Incident d'exploitation - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'un incident d'exploitation à Porte de Saint-Cloud<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-05 18:00:06	2023-05-05 17:58:00	2023-05-06 03:45:00
190	884f0d8a-eb60-11ed-930a-0a58a9feac02	line:IDFM:C01743	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne B : perturbé	<p>Le trafic est perturb&#233; sur l'ensemble de la ligne.<br><br>Motif :&#160;D&#233;faut d'alimentation &#233;lectrique &#224; Aulnay-Sous-Bois.<br><br></p>	2023-05-05 18:18:55	2023-05-05 18:14:34	2023-05-05 21:14:35
192	7cc8bf62-eb63-11ed-930a-0a58a9feac02	line:IDFM:C01377	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 7 : Incident (intervention conducteur) - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'un incident nécessitant l’intervention du conducteur à Gare de l'Est<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-05 18:40:04	2023-05-05 18:34:00	2023-05-06 03:45:00
193	36948868-eb64-11ed-b125-0a58a9feac02	line:IDFM:C01742	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne A : Vincennes - Marne-la-Vallée C perturbé	<p>Le trafic est perturb&#233; de Vincennes vers Marne-la-Vall&#233;e Chessy.<br><br>Motif : malaise voyageur &#224; bord d'un train en gare de Noisy-Champs.<br><br><br></p>	2023-05-05 18:45:16	2023-05-05 18:42:38	2023-05-05 20:00:00
194	46c38b24-eb66-11ed-8b34-0a58a9feac02	line:IDFM:C01384	active	perturbation	#FF0000	NO_SERVICE	Métro 14 : Train en panne - Trafic interrompu	<p>Le trafic est interrompu entre Châtelet et Saint-Lazare en raison d'un train en panne à Pyramides<br>Heure de reprise estimée : 20h00.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-05 19:00:02	2023-05-05 18:56:00	2023-05-06 03:45:00
195	f9ad17f0-eb66-11ed-b125-0a58a9feac02	line:IDFM:C01372	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 2 : Personnes sur les voies - Trafic très perturbé	<p>Le trafic est très perturbé sur l'ensemble de la ligne en raison de personnes sur les voies à Blanche<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-05 19:10:04	2023-05-05 19:05:00	2023-05-06 03:45:00
196	0e3e8b64-eb70-11ed-a257-0a58a9feac02	line:IDFM:C01376	active	perturbation	#FF0000	NO_SERVICE	Métro 6 : Bagage oublié - Trafic interrompu	<p>Le trafic est interrompu entre Trocadéro et Charles de Gaulle - Etoile en raison d'un bagage oublié à Kléber<br>Heure de reprise estimée : 20h40.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-05 20:10:02	2023-05-05 20:05:00	2023-05-06 03:45:00
197	716c661c-eb6f-11ed-8b34-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C : ralentissements	<p>Le trafic est fortement ralenti sur l'ensemble de la ligne. <br></p><p>Le RER D dessert Juvisy, Villeneuve-St-G. (bus 480 Ablon), Villeneuve-Triage (bus 483 Villeneuve-le-Roi), Cr&#233;teil-P. (TVM Choisy), Maisons-A. (bus 217 Vitry), Gare-de-Lyon.</p><p>le RER B qui relie Massy-Palaiseau, Massy-Verri&#232;res, et Antony OrlyVal, &#224; Saint-Michel Notre-Dame et &#224; Gare-du-Nord.<br></p><p><br>Motif : accident de personne en gare de Vitry sur Seine<br></p>	2023-05-05 20:13:29	2023-05-05 20:01:54	2023-05-05 23:30:58
198	1c0e1a04-eb87-11ed-b125-0a58a9feac02	line:IDFM:C01377	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 7 : Personnes sur les voies - Trafic perturbé	<p>Le train stationne à Place d'Italie en raison de personnes sur les voies<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-05 22:55:04	2023-05-05 22:50:31	2023-05-05 23:36:31
199	1ca3b0c8-eb87-11ed-a257-0a58a9feac02	line:IDFM:C01381	active	perturbation	#FF0000	NO_SERVICE	Métro 11 : Incident affectant la voie - Trafic interrompu	<p>Le trafic est interrompu entre Mairie des Lilas et Belleville en raison d'un incident affectant la voie à Pyrénées<br>Heure de reprise estimée : 23h10.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-05 22:55:05	2023-05-05 22:53:00	2023-05-06 03:45:00
200	e81c215c-eb89-11ed-b1d4-0a58a9feac02	line:IDFM:C01381	active	perturbation	#FF0000	NO_SERVICE	Métro 11 : Bagage oublié - Trafic interrompu	<p>Le trafic est interrompu entre Arts et Métiers et Châtelet en raison d'un bagage oublié à Châtelet<br>Heure de reprise estimée : 00h00.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-05 23:15:05	2023-05-05 23:12:00	2023-05-06 03:45:00
201	fcd3c286-eb92-11ed-b1d4-0a58a9feac02	line:IDFM:C01383	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 13 : Mesures de régulation - Trafic perturbé	<p>Le trafic est perturbé entre Carrefour Pleyel et Saint-Denis – Université en direction de Saint-Denis – Université en raison de mesures de régulation à Carrefour Pleyel<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-06 00:20:05	2023-05-06 00:17:00	2023-05-07 03:45:00
202	5c504324-eb93-11ed-b1d4-0a58a9feac02	line:IDFM:C01742	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne A : ralentissements	<p>Le trafic est ralenti de La D&#233;fense vers Boissy-Saint-L&#233;ger et de La D&#233;fense vers Marne-la-Vall&#233;e Chessy.</p><p>Acte de malveillance &#224; Vincennes&#160;&#160;<br><br></p>	2023-05-06 00:22:46	2023-05-06 00:18:44	2023-05-06 01:45:16
203	be644c6c-eba3-11ed-930a-0a58a9feac02	line:IDFM:C01371	active	perturbation	#FF0000	NO_SERVICE	Métro 1 : Personnes sur les voies - Trafic interrompu	<p>Le trafic est interrompu entre Bastille et Château de Vincennes en direction de Château de Vincennes en raison de personnes sur les voies<br>Heure de reprise estimée : 02h15.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-06 02:20:02	2023-05-06 02:18:00	2023-05-07 03:45:00
204	92514258-eafc-11ed-b1d4-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C : suppressions le 6 mai	<p>Samedi 6 mai :<br><br>Le trafic de la ligne C est r&#233;duit et quelques suppressions sont &#224; pr&#233;voir.<br><br>V&#233;rifiez si votre train circule sur :<br>-    L&#8217;appli Ile-de-France Mobilit&#233;s,<br>-    Le site Transilien.com,<br>-    SNCF Connect ou votre appli de mobilit&#233;.<br><br>Motif : difficult&#233;s li&#233;es &#224; un manque de personnel.<br></p>	2023-05-05 06:23:29	2023-05-06 03:00:00	2023-05-07 02:00:00
205	a6fc28ec-ed06-11ed-b1d4-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C : Invalides -> Juvisy trafic ralenti	Le trafic est ralenti de Invalides vers Juvisy. <br><br>Motif : panne d'un train	2023-05-07 20:40:34	2023-05-07 20:39:17	2023-05-07 21:30:28
206	f602f3ea-ed0f-11ed-b1d4-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C Montigny-B. - Invalides : suppression	<p>Train supprim&#233; :<br>- LOLA au d&#233;part de Montigny Beauchamp &#224; 22h25, et &#224; l'arriv&#233;e &#224; Invalides &#224; 23h16.<br><br>Prochain train &#224; circuler :<br>- LOLA au d&#233;part de Montigny Beauchamp &#224; 22h55, et &#224; l'arriv&#233;e &#224; Invalides &#224; 23h46.<br><br>Motif : panne d'un train (train immobilis&#233; en atelier de maintenance pour r&#233;paration).<br></p><p><br></p><p><br></p>	2023-05-07 21:47:12	2023-05-07 21:43:50	2023-05-07 23:15:07
207	5e7fddbc-ed5a-11ed-b125-0a58a9feac02	line:IDFM:C01742	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne A : Ch. de G. Etoile non desservi le 08/05	<p>Lundi 08 mai : </p><p><br></p><p><br></p><p>L'arr&#234;t Charles de Gaulle Etoile n'est pas desservi jusqu'&#224; nouvel avis. </p><p><br></p><p>Les trains ne marquent pas l'arr&#234;t et les correspondances &#233;ventuelles ne sont pas assur&#233;es. La r&#233;ouverture se fera sur autorisation de la Pr&#233;fecture de Police.</p><p><br></p><p><br></p><p>Motif : c&#233;r&#233;monie du 8 mai 1945 et &#224; la demande de la Pr&#233;fecture de Police.</p><p><br></p><p><br></p>	2023-05-08 06:39:50	2023-05-08 06:35:00	2023-05-08 20:00:00
208	85a54a78-ed8a-11ed-b125-0a58a9feac02	line:IDFM:C01742	active	perturbation	#FF0000	NO_SERVICE	Ligne A : interruption	<p>Le trafic est interrompu entre Bry-sur-Marne et Torcy dans les 2 sens jusqu'&#224; 14h30. <br><br>Motif : Motif : accident de personne en gare de Noisy-le-Grand<br></p>	2023-05-08 12:24:32	2023-05-08 12:21:06	2023-05-08 15:00:00
209	13eab21c-ed88-11ed-a257-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C : ralentissements et 1 gare non desservie	<p>La gare de Mus&#233;e d'Orsay n'est pas desservie jusqu'&#224; 13h et le trafic est fortement ralenti entre Saint-Michel Notre-Dame et Biblioth&#232;que Fran&#231;ois Mitterrand.<br><br>Mus&#233;e-d'Orsay est desservie &#224; proximit&#233; par les lignes de m&#233;tro 12 et de bus 63 (Solf&#233;rino).<br><br>Motif : affaires oubli&#233;es dans un train en gare de Mus&#233;e d'Orsay<br></p><p><br></p>	2023-05-08 12:23:26	2023-05-08 12:01:24	2023-05-08 13:00:52
210	84c5290c-ed8a-11ed-a257-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D : Malesherbes -> Juvisy trafic ralenti	<p>Le trafic est ralenti de Malesherbes vers Juvisy. <br></p><p><br></p><p>- JOVA d&#233;part Malesherbes 11h23 arriv&#233;e Juvisy 12h24 terminus Corbeil-Essonnes 12h05.</p><p><br></p><p>Prochain train au d&#233;part de Corbeil-Essonnes :<br></p><p>- LOVA d&#233;part 12h18 Corbeil-Essonnes arriv&#233;e Juvisy 12h38.</p><p><br></p><p>Motif : affaires oubli&#233;es &#224; bord du train JOVA &#224; Corbeil-Essonnes.<br></p>	2023-05-08 12:24:31	2023-05-08 12:14:02	2023-05-08 13:00:00
211	d6a474ce-eda5-11ed-b1d4-0a58a9feac02	line:IDFM:C01374	active	perturbation	#FF0000	NO_SERVICE	Métro 4 : Malaise voyageur - Trafic interrompu	<p>Le trafic est interrompu entre Odéon et Montparnasse Bienvenue en raison d'un malaise voyageur à Saint-Sulpice<br>Heure de reprise estimée : 17h30.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-08 16:35:02	2023-05-08 16:29:00	2023-05-09 03:45:00
212	a7a45de6-eda1-11ed-b125-0a58a9feac02	line:IDFM:C01381	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 11 : Incident affectant la voie - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'un incident affectant la voie<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-08 16:10:04	2023-05-08 16:05:15	2023-05-08 16:06:15
213	9c9ddcb4-eda7-11ed-b125-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D : ralentissements	<p>Le trafic est ralenti de Goussainville vers Paris Gare de Lyon. <br><br>Motif : alerte de s&#233;curit&#233; &#233;mise par le conducteur (personne dans les voies, incident termin&#233;)<br></p>	2023-05-08 16:21:29	2023-05-08 15:49:47	2023-05-08 17:00:00
214	b00ee152-edb7-11ed-b1d4-0a58a9feac02	line:IDFM:C01729	active	perturbation	#FF0000	NO_SERVICE	Ligne E : Haussmann - Tournan en Brie interrompu	<p>Le 09/05&#160; Le trafic est interrompu entre Haussmann Saint-Lazare et Tournan jusqu'&#224; 12h00.<br><br></p><p>Pour rejoindre ou quitter les gares suivantes, cliquer sur le lien concern&#233; pour t&#233;l&#233;charger l'affiche PDF :</p><p>* <a href="https://www.transilien.com/fr/sites/transilien/files/itibis-haussmann-saint-lazare.pdf" target="">Haussmann Saint-Lazare</a>,<br>* <a href="https://www.transilien.com/sites/transilien/files/itibis-magenta.pdf" target="">Magenta,</a><br>* <a href="https://www.transilien.com/sites/transilien/files/itibis-rosa-parks.pdf" target="">Rosa Parks,</a><br>* <a href="https://www.transilien.com/sites/transilien/files/itibis-pantin.pdf" target="">Pantin,</a><br>* <a href="https://www.transilien.com/fr/sites/transilien/files/itibis-noisy-le-sec.pdf" target="">Noisy le Sec,</a><br>* <a href="https://www.transilien.com/sites/transilien/files/itibis-val-de-fontenay.pdf" target="">Val de Fontenay,</a><br>* <a href="https://www.transilien.com/fr/sites/transilien/files/itibis-rosny-bois-perrier.pdf" target="">Rosny Bois Perrier,</a><br>* <a href="https://www.transilien.com/fr/sites/transilien/files/itibis-rosny-sous-bois.pdf" target="">Rosny sous Bois,</a><br>* <a href="https://www.transilien.com/sites/transilien/files/itibis-nogent-le-perreux.pdf" target="">Nogent le Perreux,</a><br>* <a href="https://www.transilien.com/sites/transilien/files/itibis-les-boullereaux.pdf" target="">Les Boullereaux Champigny,</a><br>* <a href="https://www.transilien.com/sites/transilien/files/itibis-villiers-sur-marne.pdf" target="">Villiers sur Marne</a>, <br>* <a href="https://www.transilien.com/sites/transilien/files/itibis-les-yvris-noisy-le-grand.pdf" target="">Les Yvris Noisy le Grand</a>, <br>* <a href="https://www.transilien.com/sites/transilien/files/itibis-emerainville.pdf" target="">Emerainville Pontault Combault</a>, <br>* <a href="https://www.transilien.com/sites/transilien/files/itibis-roissy-en-brie.pdf" target="">Roissy en Brie</a>, <br>* <a href="https://www.transilien.com/sites/transilien/files/itibis-ozoir.pdf" target="">Ozoir la Ferri&#232;re</a>, <br>* <a href="https://www.transilien.com/sites/transilien/files/gretz.pdf" target="">Gretz Armainvilliers</a>, <br>* <a href="https://www.transilien.com/sites/transilien/files/itibis-tournan.pdf" target="">Tournan</a>.<br><br><br><br>Motif : conditions m&#233;t&#233;orologiques ayant entrain&#233; le retard des travaux.</p><p>Nous vous invitons &#224; reporter votre voyage.<br></p>	2023-05-08 17:47:51	2023-05-08 17:36:07	2023-05-09 12:00:49
215	16febca6-edb9-11ed-930a-0a58a9feac02	line:IDFM:C01743	active	perturbation	#FF0000	NO_SERVICE	Ligne B : interruption	<p>Le trafic est interrompu entre Courcelle sur Yvette et St-R&#233;my-l&#232;s-Chevreuse dans les 2 sens jusqu'&#224; 18h30. affaires oubli&#233;es &#224; Saint-R&#233;my.<br><br></p>	2023-05-08 17:57:53	2023-05-08 17:55:05	2023-05-08 18:30:00
216	e032f23c-ee08-11ed-8b34-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C Pontoise - Bibliothèque : suppression	<p>Train supprim&#233; :<br>- FOOT au d&#233;part de Pontoise &#224; 06h16 et &#224; l'arriv&#233;e &#224; Biblioth&#232;que Fran&#231;ois Mitterrand &#224; 07h36.<br><br>Prochain train &#224; circuler :<br>- MONA au d&#233;part de Montigny Beauchamp &#224; 06h40 et &#224; l'arriv&#233;e &#224; Massy Palaiseau &#224; 08h20.</p><p>- FOOT au d&#233;part de Pontoise &#224; 06h31 et &#224; l'arriv&#233;e &#224; Biblioth&#232;que Fran&#231;ois Mitterrand &#224;07h51.</p><p>Risque d'affluence &#224; bord du train suivant.<br><br>Motif : conditions de d&#233;part non r&#233;unies (train immobilis&#233; en atelier de maintenance).<br></p><p><br></p><p><br></p>	2023-05-09 03:29:00	2023-05-09 03:24:07	2023-05-09 07:35:24
217	a2883b9e-ee09-11ed-b1d4-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C Versail.Château - Juvisy : suppression	<p>Gare de d&#233;part modifi&#233;e :<br>- le train CIME initialement pr&#233;vu &#224; Versailles Ch&#226;teau &#224; 05h55 a son d&#233;part report&#233; en gare de Juvisy &#224; 07h00, et arrive &#224; Versailles Chantiers &#224; 07h46.<br><br>Prochain train &#224; circuler :<br>- CIME au d&#233;part de Versailles Ch&#226;teau &#224; 06h10 et &#224; l'arriv&#233;e &#224; Versailles Chantiers &#224; 08h01.<br><br>Motif : conditions de d&#233;part non r&#233;unies (train immobilis&#233; en atelier de maintenance).<br></p><p><br></p><p><br></p>	2023-05-09 03:34:26	2023-05-09 03:29:15	2023-05-09 07:00:27
218	f8c8b3fc-ee50-11ed-b125-0a58a9feac02	line:IDFM:C01379	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 9 : Difficultés d'exploitation - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de difficultés d'exploitation<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-09 12:45:06	2023-05-09 12:38:42	2023-05-09 12:39:42
219	001b3b78-ee5d-11ed-8b34-0a58a9feac02	line:IDFM:C01742	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne A : ralentissements	Le trafic est ralenti de Nanterre-Préfecture vers Poissy. <br><br>Motif : conditions de départ non réunies	2023-05-09 13:31:12	2023-05-09 12:56:29	2023-05-09 13:29:33
220	3846b0ce-ee56-11ed-a257-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C St-Martin d'É. - St-Quentin : suppression	<p>Train supprim&#233; :</p><p>- Le train SARA au d&#233;part de la gare de Saint Martin d'Etampes &#224; 13h26, et pr&#233;vu &#224; l'arriv&#233;e en gare de Saint Quentin en Yvelines &#224; 15h21.<br><br>Prochain train &#224; circuler :</p><p>- Le train SARA au d&#233;part de la gare de Saint Martin d'Etampes et pr&#233;vu &#224; l'arriv&#233;e en gare de Saint Quentin en Yvelines &#224; 15h51.<br><br>Risque d'affluence &#224; bord du train suivant.<br><br>Motif : panne d'un train.<br></p><p><br></p><p><br></p>	2023-05-09 12:42:39	2023-05-09 12:37:42	2023-05-09 15:50:12
221	88847646-ee5d-11ed-b125-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C : ralentissements	<p>Le trafic est fortement ralenti de Pontoise vers Champ de Mars. <br></p><p>Le bus 138 dessert Ermont-Eaubonne, St-Gratien, Epinay-sur-Seine (Joffre Cin&#233;ma), Gennevilliers (Rond-Point Pierre Timbaud), Gr&#233;sillons Laurent-C&#233;ly et Saint-Ouen M&#233;tro 14.<br></p><p><br>Motif : panne sur les installations du gestionnaire de r&#233;seau (panne de signalisation dans le secteur de Montigny Beauchamp).</p>	2023-05-09 13:45:27	2023-05-09 13:30:06	2023-05-09 14:30:18
222	d01a93e4-ee69-11ed-b1d4-0a58a9feac02	line:IDFM:C01742	active	perturbation	#FF0000	NO_SERVICE	Ligne A : interruptions	Le trafic est interrompu entre Nanterre-Préfecture et Sartrouville et entre Nanterre-Préfecture et Poissy dans les 2 sens jusqu'à 16h. <br><br>Motif : arrêt de travail spontané d'une partie du personnel	2023-05-09 15:02:55	2023-05-09 14:57:59	2023-05-09 16:00:00
223	81a52b64-ee6b-11ed-8b34-0a58a9feac02	line:IDFM:C01379	active	perturbation	#FF0000	NO_SERVICE	Métro 9 : Personnes sur les voies - Trafic interrompu	<p>Le trafic est interrompu entre Porte de Montreuil et Mairie de Montreuil en raison de personnes sur les voies à Mairie de Montreuil<br>Heure de reprise estimée : 15h35.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-09 15:15:02	2023-05-09 15:10:00	2023-05-10 03:45:00
224	623c17fe-ee77-11ed-930a-0a58a9feac02	line:IDFM:C01374	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 4 : Train en panne - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'un train en panne à Vavin<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-09 16:40:03	2023-05-09 16:38:00	2023-05-10 03:45:00
225	f61926a6-ee77-11ed-930a-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D Juvisy - Corbeil-Ess. : suppression	<p>Train supprim&#233; pour les gares de : Juvisy, Viry-Chatillon, Ris-Orangis, Grand-Bourg et Evry-Val-de-Seine :<br><br>-Train BOVO d&#233;part de Juvisy &#224; 16h34 arriv&#233;e Malesherbes 17h36 circule au d&#233;part de Corbeil-Essonnes &#224; 16h53.<br><br>Prochains trains :<br><br>Pour les voyageurs au d&#233;part des gares de Juvisy, Viry-Chatillon, Ris-Orangis, Grand-Bourg et Evry-Val-de-Seine en direction de Corbeil-Essonnes :<br>- Train ZOVO d&#233;part de Juvisy 16h55 arriv&#233;e Corbeil-Essonnes 17h17.<br><br>Pour les voyageurs au d&#233;part des gares de Juvisy, Viry-Chatillon, Ris-Orangis, Grand-Bourg, Evry-Val-de-Seine et Corbeil-Essonnes en direction de Malesherbes :<br><br>-Train BOVO d&#233;part Juvisy 17h10 arriv&#233;e Malesherbes 18h11.<br><br>Motif : attente d'autorisation d'acc&#232;s au r&#233;seau &#224; Juvisy (sortie tardive des ateliers de maintenance)<br></p>	2023-05-09 16:44:11	2023-05-09 16:37:29	2023-05-09 16:50:26
226	c081c798-ee7a-11ed-a257-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D Juvisy - Corbeil-Ess. : suppression	<p>Train supprim&#233; pour les gares de : Juvisy, Viry-Chatillon, Ris-Orangis, Grand-Bourg et Evry-Val-de-Seine :<br><br>-Train BOVO d&#233;part de Juvisy &#224; 16h34 arriv&#233;e Malesherbes 17h36 circule au d&#233;part de Corbeil-Essonnes &#224; 17h09.<br><br>Prochains trains :<br><br>Pour les voyageurs au d&#233;part des gares de Juvisy, Viry-Chatillon, Ris-Orangis, Grand-Bourg et Evry-Val-de-Seine en direction de Corbeil-Essonnes :<br>- Train ZOVO d&#233;part de Juvisy 16h55 arriv&#233;e Corbeil-Essonnes 17h17.<br><br>Pour les voyageurs au d&#233;part des gares de Juvisy, Viry-Chatillon, Ris-Orangis, Grand-Bourg, Evry-Val-de-Seine et Corbeil-Essonnes en direction de Malesherbes :<br><br>-Train BOVO d&#233;part Juvisy 17h10 arriv&#233;e Malesherbes 18h11.<br><br>Motif : attente d'autorisation d'acc&#232;s au r&#233;seau &#224; Juvisy (sortie tardive des ateliers de maintenance)</p>	2023-05-09 17:04:10	2023-05-09 16:37:29	2023-05-09 17:15:26
227	47570318-ee7c-11ed-b1d4-0a58a9feac02	line:IDFM:C01373	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 3 : Actionnement d'un signal d'alarme - Train stationne	<p>Le train stationne entre Louise Michel et Porte de Champerret en direction de Gallieni en raison de l'actionnement d'un signal d'alarme à Louise Michel<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-09 17:20:05	2023-05-09 17:15:29	2023-05-09 17:16:29
228	bd150ad2-ee7c-11ed-8b34-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D : ralentissements	<p>Le trafic est ralenti de Goussainville vers Villeneuve S Georges. <br></p><p><br>Motif : affaires oubli&#233;es &#224; Paris-Gare-du-Nord (incident termin&#233;).<br></p>	2023-05-09 17:18:23	2023-05-09 17:16:06	2023-05-09 19:00:00
229	ac94b738-ee7d-11ed-8b34-0a58a9feac02	line:IDFM:C01379	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 9 : Personnes sur les voies - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de personnes sur les voies à Trocadéro<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-09 17:25:05	2023-05-09 17:19:50	2023-05-09 18:05:50
230	fc8bfe78-ee7c-11ed-8b34-0a58a9feac02	line:IDFM:C01373	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 3 : Personnes sur les voies - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de personnes sur les voies<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-09 17:20:09	2023-05-09 17:19:00	2023-05-10 03:45:00
231	fa98454a-ee7c-11ed-930a-0a58a9feac02	line:IDFM:C01377	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 7 : Train en panne - Train stationne	<p>Le train stationne entre Tolbiac et Place d'Italie en direction de La Courneuve - 8 Mai 1945 en raison d'un train en panne<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-09 17:25:07	2023-05-09 17:20:00	2023-05-10 03:45:00
232	61b1f644-ee7e-11ed-b1d4-0a58a9feac02	line:IDFM:C01382	active	perturbation	#FF0000	NO_SERVICE	Métro 12 : Bagage oublié - Trafic interrompu	<p>Le trafic est interrompu entre Mairie d'Issy et Porte de Versailles en raison d'un bagage oublié à Mairie d'Issy<br>Heure de reprise estimée : 18h00.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-09 17:30:09	2023-05-09 17:28:00	2023-05-10 03:45:00
233	6132fc04-ee83-11ed-a257-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D : Malesherbes - Juvisy différé	<p>Le train suivant voit son d&#233;part diff&#233;r&#233; de 15 minutes environ :<br><br>- JOVA d&#233;part de Malesherbes 17h48, arriv&#233;e &#224; Juvisy 18h48.<br><br>Motif : attente d'autorisation d'acc&#232;s au r&#233;seau sur sa mission pr&#233;c&#233;dente.<br></p>	2023-05-09 18:05:55	2023-05-09 18:01:08	2023-05-09 19:05:19
234	da8c8be2-ee88-11ed-b125-0a58a9feac02	line:IDFM:C01376	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 6 : Divers incidents - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de divers incidents<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-09 18:45:06	2023-05-09 18:42:00	2023-05-10 03:45:00
235	89fa5280-ee89-11ed-b1d4-0a58a9feac02	line:IDFM:C01373	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 3 : Incident d'exploitation - Trafic très perturbé	<p>Le trafic est très perturbé sur l'ensemble de la ligne en raison d'un incident d'exploitation à Porte de Champerret<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-09 18:55:05	2023-05-09 18:52:00	2023-05-10 03:45:00
236	fc814cb6-ef2c-11ed-b1d4-0a58a9feac02	line:IDFM:C01373	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 3 : Incident d'exploitation - Trafic très perturbé	<p>Le trafic est très perturbé sur l'ensemble de la ligne en raison d'un incident d'exploitation<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-10 14:25:03	2023-05-10 14:20:00	2023-05-10 14:21:00
237	53f28262-ef1e-11ed-b125-0a58a9feac02	line:IDFM:C01386	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 3B : Indisponibilité de trains - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de l'indisponibilité de trains<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-10 14:10:07	2023-05-10 14:07:06	2023-05-10 14:08:06
238	5f9436f4-ef20-11ed-b125-0a58a9feac02	line:IDFM:C01743	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne B : Luxembourg non desservi	<p>Les trains ne marquent pas l'arr&#234;t &#224; Luxembourg dans les deux sens jusqu'&#224; 16h00.<br><br>Motif : Application des mesures de s&#233;curit&#233; ( &#224; la demande de la pr&#233;fecture de police.)<br><br></p>	2023-05-10 13:06:40	2023-05-10 12:42:42	2023-05-10 16:00:00
239	acbd0c42-ef31-11ed-930a-0a58a9feac02	line:IDFM:C01729	active	perturbation	#FF0000	NO_SERVICE	Ligne E : Gretz-Armainv. - Tournan  interrompu	<p>Le trafic est interrompu entre Gretz-Armainvilliers et Tournan jusqu'&#224; 15h15.<br><br>Pour rejoindre ou quitter les gares suivantes, cliquer sur le lien concern&#233; pour t&#233;l&#233;charger l'affiche PDF :<br>* <a href="https://www.transilien.com/sites/transilien/files/gretz.pdf" target="">Gretz Armainvilliers</a>, <br>* <a href="https://www.transilien.com/sites/transilien/files/itibis-tournan.pdf" target="">Tournan</a>.<br><br>Sur la ligne P, le trafic est &#233;galement interrompu sur l'axe Paris Coulommiers.<br><br>Motif : obstacle sur la voie.<br></p>	2023-05-10 14:53:35	2023-05-10 14:48:55	2023-05-10 15:15:00
240	56b54496-ef35-11ed-8b34-0a58a9feac02	line:IDFM:C01729	past	perturbation	#FF0000	NO_SERVICE	Ligne P : Paris Est <-> Coulommiers trafic ralenti	<p>Le trafic est ralenti entre Paris Est et Coulommiers dans les 2 sens. <br><br>Motif : obstacle sur la voie (arbre entre Gretz et Tournan).<br></p>	2023-05-10 15:19:48	2023-05-10 14:43:54	2023-05-10 14:48:21
241	8fff7cf4-ef39-11ed-930a-0a58a9feac02	line:IDFM:C01374	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 4 : Incident voyageur - Trafic très perturbé	<p>Le trafic est très perturbé sur l'ensemble de la ligne en raison d'un incident voyageur à Simplon<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-10 15:50:02	2023-05-10 15:45:00	2023-05-11 03:45:00
242	70e3a802-ef45-11ed-930a-0a58a9feac02	line:IDFM:C01383	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 13 : Incident (intervention conducteur) - Stationnement prolongé	<p>Le stationnement est prolongé entre Porte de Vanves et Malakoff - Rue Etienne Dolet en direction de Saint-Denis – Université et Asnières - Gennevilliers Les Courtilles en raison d'un incident nécessitant l’intervention du conducteur à Porte de Vanves<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-10 17:15:04	2023-05-10 17:13:00	2023-05-11 03:45:00
243	2400ec1a-ef46-11ed-a257-0a58a9feac02	line:IDFM:C01374	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 4 : Incident voyageur - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'un incident voyageur à Odéon<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-10 17:25:06	2023-05-10 17:21:00	2023-05-11 03:45:00
244	71c5e8ce-ef46-11ed-930a-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C : St-Michel ND non desservie	<p>La gare de St-Michel Notre-Dame n'est pas desservie jusqu'&#224; 17h50. <br><br>Motif : affaires oubli&#233;es (en gare de Saint Michel Notre Dame)</p>	2023-05-10 17:22:15	2023-05-10 17:19:56	2023-05-10 17:50:00
245	a518b230-ef49-11ed-8b34-0a58a9feac02	line:IDFM:C01373	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 3 : Difficultés d'exploitation - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de difficultés d'exploitation<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-10 17:50:05	2023-05-10 17:42:40	2023-05-10 17:43:40
246	9e072ea2-ef50-11ed-b1d4-0a58a9feac02	line:IDFM:C01373	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 3 : Difficultés d'exploitation - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de difficultés d'exploitation<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-10 18:35:04	2023-05-10 18:34:00	2023-05-11 03:45:00
247	326ea6ac-ef50-11ed-b1d4-0a58a9feac02	line:IDFM:C01743	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne B : perturbé	<p>Le trafic est perturb&#233; sur l'ensemble de la ligne.<br><br>Motif : individus sur les voies &#224; Mitry-Claye.<br><br><br></p>	2023-05-10 18:41:24	2023-05-10 18:34:10	2023-05-10 20:00:12
248	4aef27c0-ef4f-11ed-b1d4-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D : Corbeil-Ess. - Malesherbes ralenti	<p>Pr&#233;voir un allongement de temps de trajet de 10 minutes environ pour le train suivant :</p><p>- BOVO, d&#233;part Juvisy 17h55, arriv&#233;e Malesherbes 18h56.</p><p><br>Motif : animaux sur la voie dans le secteur de la Fert&#233; Alais (incident termin&#233;).<br></p>	2023-05-10 18:25:35	2023-05-10 18:19:39	2023-05-10 19:15:01
249	9bfc584e-ef50-11ed-a257-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D : ralentissements	<p>Le trafic est ralenti entre Juvisy et Malesherbes dans les 2 sens via Ris Orangis. <br></p><p><br></p><p>La pr&#233;sence d'un animal aux abords des voies dans le secteur de la Fert&#233; Alais nous a contraint &#224; ralentir le trafic.</p><p>Les trains se voient remettre des autorisations de circulation, pr&#233;voir des allongements de temps de trajet de 10 &#224; 15 minutes environ.<br></p><p><br>Motif : animaux sur la voie dans le secteur de la Fert&#233; Alais (incident termin&#233;).<br></p>	2023-05-10 18:35:01	2023-05-10 18:27:38	2023-05-10 20:00:00
250	0e3303c6-ef57-11ed-8b34-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D : Villeneuve St-G - Corbeil-Ess. ralenti	<p>Le trafic est ralenti entre Villeneuve-Saint-Georges et Corbeil-Essonnes via &#201;vry - Courcouronnes.<br><br>Motif : panne sur les installations du gestionnaire de r&#233;seau &#224; Corbeil-Essonnes (fin d'incident).<br></p>	2023-05-10 19:21:09	2023-05-10 19:15:26	2023-05-10 21:00:49
251	079a7fc6-ef57-11ed-b125-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D : ralentissements	<p>Le trafic est fortement ralenti entre Malesherbes et Juvisy dans les 2 sens via Ris Orangis. <br></p><p><br></p><p>Un train a &#233;mis une alerte de s&#233;curit&#233; dans le secteur de Moulin Galant, un obstacle se trouve sur la voie.<br></p><p><br></p><p><br>Motif : obstacle sur la voie dans le secteur de Moulin Galant.<br></p>	2023-05-10 19:20:58	2023-05-10 19:17:24	2023-05-10 21:00:00
252	b19a1b92-ef59-11ed-b1d4-0a58a9feac02	line:IDFM:C01378	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 8 : Train en panne - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'un train en panne à Concorde<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-10 19:40:03	2023-05-10 19:33:24	2023-05-10 20:19:24
253	921c5f62-ef65-11ed-8b34-0a58a9feac02	line:IDFM:C01374	active	perturbation	#FF0000	NO_SERVICE	Métro 4 : Incident technique - Trafic interrompu	<p>Le trafic est interrompu entre Barbès - Rochechouart et Réaumur - Sébastopol en raison d'un incident technique<br>Heure de reprise estimée : 21h30.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-10 21:05:04	2023-05-10 21:02:00	2023-05-11 03:45:00
254	ac91aeb8-ef67-11ed-b125-0a58a9feac02	line:IDFM:C01383	active	perturbation	#FF0000	NO_SERVICE	Métro 13 : Incident affectant la voie - Trafic interrompu	<p>Le trafic est interrompu entre Porte de Saint-Ouen et Saint-Denis - Porte de Paris en direction de Saint-Denis – Université et Châtillon-Montrouge en raison d'un incident affectant la voie à Porte de Saint-Ouen<br>Heure de reprise estimée : 21h30.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-10 21:20:07	2023-05-10 21:18:00	2023-05-11 03:45:00
255	13bea71c-ef68-11ed-8b34-0a58a9feac02	line:IDFM:C01742	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne A : ralentissements	<p>Le trafic est ralenti de Vincennes vers Saint-Germain-en-Laye, de Vincennes vers Poissy et de Vincennes vers Cergy le Haut. <br><br>Motif : individus sur les voies en gare de Ch&#226;telet les Halles.</p>	2023-05-10 21:23:06	2023-05-10 21:14:41	2023-05-10 21:19:15
256	1cebf74c-ef70-11ed-b1d4-0a58a9feac02	line:IDFM:C01377	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 7 : Incident voyageur - Trafic perturbé	<p>Le trafic est très perturbé à Louis Blanc et Porte de la Villette en raison d'un incident voyageur<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-10 22:20:32	2023-05-10 22:16:14	2023-05-10 23:02:14
257	24bd2fd4-ef72-11ed-b125-0a58a9feac02	line:IDFM:C01382	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 12 : Malaise voyageur - Train stationne	<p>Le train stationne entre Concorde et Jules Joffrin en raison d'un malaise voyageur à Notre-Dame-de-Lorette<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-10 22:35:04	2023-05-10 22:32:00	2023-05-11 03:45:00
258	2597a01a-ef72-11ed-b1d4-0a58a9feac02	line:IDFM:C01382	active	perturbation	#FF0000	NO_SERVICE	Métro 12 : Malaise voyageur - Trafic interrompu	<p>Le trafic est interrompu en direction de Mairie d'Issy en raison d'un malaise voyageur à Notre-Dame-de-Lorette<br>Heure de reprise estimée : 23h00.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-10 22:35:05	2023-05-10 22:34:00	2023-05-11 03:45:00
259	c7d7b89e-ef75-11ed-b125-0a58a9feac02	line:IDFM:C01382	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 12 : Malaise voyageur - Reprise progressive / trafic reste perturbé	<p>Le trafic reprend mais reste perturbé entre Concorde et Jules Joffrin en raison d'un malaise voyageur à Notre-Dame-de-Lorette<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-10 23:01:06	2023-05-10 22:54:09	2023-05-10 23:40:09
260	5532690a-ef76-11ed-a257-0a58a9feac02	line:IDFM:C01383	active	perturbation	#FF0000	NO_SERVICE	Métro 13 : Incident affectant la voie - Trafic interrompu	<p>Le trafic est interrompu entre Porte de Saint-Ouen et Saint-Denis – Université en raison d'un incident affectant la voie à Porte de Saint-Ouen<br>Heure de reprise estimée : 23h30.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-10 23:05:03	2023-05-10 22:59:00	2023-05-11 03:45:00
261	60dd8732-efec-11ed-8b34-0a58a9feac02	line:IDFM:C01373	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 3 : Bagage oublié - Reprise progressive / trafic reste perturbé	<p>Le trafic reprend mais reste perturbé sur l'ensemble de la ligne en raison d'un bagage oublié à République<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-11 13:20:06	2023-05-11 13:16:26	2023-05-11 13:17:26
262	ed133ee6-efe1-11ed-a257-0a58a9feac02	line:IDFM:C01376	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 6 : Train en panne - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'un train en panne<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-11 12:50:02	2023-05-11 12:43:19	2023-05-11 12:44:19
263	b85c5f42-efdd-11ed-8b34-0a58a9feac02	line:IDFM:C01378	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 8 : Difficultés d'exploitation - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de difficultés d'exploitation<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-11 12:50:05	2023-05-11 12:43:26	2023-05-11 12:44:26
264	a293b926-f56e-11ed-a257-0a58a9feac02	line:IDFM:C01386	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 3B : Difficultés d'exploitation - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de difficultés d'exploitation<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-18 13:25:04	2023-05-18 13:20:00	2023-05-19 03:45:00
265	8d667448-f565-11ed-930a-0a58a9feac02	line:IDFM:C01374	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 4 : Gêne à la fermeture des portes - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'une gêne à la fermeture des portes à Saint-Michel<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-18 12:30:04	2023-05-18 12:24:03	2023-05-18 12:25:03
266	f02bb73e-f56d-11ed-a257-0a58a9feac02	line:IDFM:C01375	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 5 : Malaise voyageur - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'un malaise voyageur à Ourcq<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-18 13:30:05	2023-05-18 13:25:00	2023-05-19 03:45:00
267	173305c8-f580-11ed-b125-0a58a9feac02	line:IDFM:C01371	active	perturbation	#FF0000	NO_SERVICE	Métro 1 : Incident d'exploitation - Trafic interrompu	<p>Le trafic est interrompu entre Châtelet et Château de Vincennes en raison d'un incident d'exploitation à Nation<br>Heure de reprise estimée : 16h00.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-18 15:30:01	2023-05-18 15:25:00	2023-05-19 03:45:00
268	f43fdb08-f580-11ed-930a-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C Juvisy - Musée d'Orsay : suppression	<p>Train supprim&#233; :<br>- Le train ORET au d&#233;part de la gare de Juvisy &#224; 15h58 pour une arriv&#233;e en gare de Mus&#233;e d'Orsay &#224; 16h21<br><br>Prochain train &#224; circuler :<br>- Le train VICK au d&#233;part de la gare de Juvisy &#224; 16h02 pour un passage en gare de Mus&#233;e d'Orsay &#224; 16h31<br><br><br>Motif : panne d'un train.<br></p><p><br></p><p><br></p>	2023-05-18 15:36:12	2023-05-18 15:33:45	2023-05-18 16:20:55
269	af9636aa-f585-11ed-b125-0a58a9feac02	line:IDFM:C01376	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 6 : Personnes sur les voies - Trains stationnent	<p>Les trains stationnent entre Trocadéro et Charles de Gaulle - Etoile en raison de personnes sur les voies à Kléber<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-18 16:10:04	2023-05-18 16:07:00	2023-05-19 03:45:00
270	63d3ade6-f586-11ed-a257-0a58a9feac02	line:IDFM:C01371	active	perturbation	#FF0000	NO_SERVICE	Métro 1 : Incident d'exploitation - Trafic interrompu	<p>Le trafic est interrompu entre Châtelet et Château de Vincennes en raison d'un incident d'exploitation à Nation<br>Heure de reprise estimée : 16h30.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-18 16:15:06	2023-05-18 16:08:00	2023-05-19 03:45:00
271	df42df6c-f589-11ed-a257-0a58a9feac02	line:IDFM:C01379	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 9 : Incident d'exploitation - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'un incident d'exploitation à Porte de Saint-Cloud<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-18 16:45:14	2023-05-18 16:39:00	2023-05-19 03:45:00
272	a324b5b0-f597-11ed-a257-0a58a9feac02	line:IDFM:C01729	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne E : ralenti	<p>Le trafic est ralenti sur l'ensemble de la ligne.<br><br>Motif : Individus dans les voies en gare de Noisy le Sec.<br><br><br></p>	2023-05-18 18:18:34	2023-05-18 18:15:49	2023-05-18 19:30:00
273	70240caa-f59d-11ed-b125-0a58a9feac02	line:IDFM:C01371	active	perturbation	#FF0000	NO_SERVICE	Métro 1 : Incident d'exploitation - Trafic interrompu	<p>Le trafic est interrompu entre Château de Vincennes et Châtelet en raison d'un incident d'exploitation à Nation<br>Heure de reprise estimée : 19h20.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-18 19:00:05	2023-05-18 18:57:00	2023-05-19 03:45:00
274	70f90db0-f59d-11ed-a257-0a58a9feac02	line:IDFM:C01376	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 6 : Incident (intervention conducteur) - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'un incident nécessitant l’intervention du conducteur à Bir-Hakeim<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-18 19:00:07	2023-05-18 18:58:00	2023-05-19 03:45:00
275	9127806c-f5a2-11ed-b125-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C Invalides - St-Quentin : suppression	<p>Train supprim&#233; :<br>- Le train SARA au d&#233;part de la gare d'Invalides &#224; 20h08 pour une arriv&#233;e en gare de St-Quentin en Yvelines &#224; 20h51</p><p>Prochain train &#224; circuler :<br>- Le train SARA au d&#233;part de la gare d'Invalides &#224; 20h38 pour une arriv&#233;e en gare de St-Quentin en Yvelines &#224; 21h21<br><br><br>Motif : affaires oubli&#233;es.<br></p><p><br></p><p><br></p>	2023-05-18 19:36:48	2023-05-18 19:33:33	2023-05-18 20:50:56
276	e8d9458e-f5a7-11ed-a257-0a58a9feac02	line:IDFM:C01373	active	perturbation	#FF0000	NO_SERVICE	Métro 3 : Bagage oublié - Trafic interrompu	<p>Le trafic est interrompu entre Gallieni et Père-Lachaise en raison d'un bagage oublié à Gambetta<br>Heure de reprise estimée : 21h00.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-18 20:15:03	2023-05-18 20:13:00	2023-05-19 03:45:00
277	e127cdb6-f5b5-11ed-930a-0a58a9feac02	line:IDFM:C01372	active	perturbation	#FF0000	NO_SERVICE	Métro 2 : Personnes sur les voies - Trafic interrompu	<p>Le trafic est interrompu entre Père-Lachaise et Charles de Gaulle - Etoile en raison de personnes sur les voies<br>Heure de reprise estimée : 23h00.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-18 21:55:03	2023-05-18 21:53:00	2023-05-18 23:45:00
278	a9fc1eb4-f5bf-11ed-930a-0a58a9feac02	line:IDFM:C01382	active	perturbation	#FF0000	NO_SERVICE	Métro 12 : Personnes sur les voies - Trafic interrompu	<p>Le trafic est interrompu entre Montparnasse Bienvenue et Mairie d'Issy en raison de personnes sur les voies à Porte de Versailles<br>Heure de reprise estimée : 23h30.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-18 23:05:06	2023-05-18 23:03:00	2023-05-19 03:45:00
279	a1022f0a-f31d-11ed-930a-0a58a9feac02	line:IDFM:C01382	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 13 / 12 : Manifestation culturelle - Autre	<p>Concert Metallica 19 mai : pour aller au Stade de France, portes A, B, C, D, E, H : prendre RER B ou M12. Portes J, K, L, N, R, S : prendre M13. Portes T, U, X, Y, Z : prendre RER D. Détails sur sites et applis IDFM / RATP<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-15 14:40:10	2023-05-19 05:00:00	2023-05-20 03:45:00
280	10f7de48-f5f5-11ed-930a-0a58a9feac02	line:IDFM:C01742	active	perturbation	#FF0000	NO_SERVICE	Ligne A : Vincennes - Auber interrompu	<p>Le trafic est interrompu entre Vincennes et Auber jusqu'&#224; 06h30.<br><br>En cons&#233;quence, le trafic est perturb&#233; sur le reste de la ligne.<br><br>Les RER en provenance de Poissy ou Cergy le Haut circulent jusqu'&#224; La D&#233;fense Grande Arche.<br><br>Pour aller jusqu'&#224; Auber :<br>* les voyageurs en provenance de Poissy ou Cergy le Haut sont invit&#233;s &#224; descendre &#224; La D&#233;fense Grande Arche, puis &#224; emprunter un RER en provenance de Saint-Germain en Laye.<br><br>Pour se d&#233;placer entre :<br>* Auber, Ch&#226;telet les Halles, Paris Gare de Lyon et Nation, il est conseill&#233; d'emprunter la Ligne 14 du m&#233;tro au d&#233;part de Paris Saint-Lazare, proche d'Auber, puis la Ligne 1 du m&#233;tro (stations Nation et Porte de Vincennes).<br><br>Motif : incident voyageur en gare de Nation.<br></p>	2023-05-19 05:27:22	2023-05-19 05:14:09	2023-05-19 06:30:00
281	2575dae0-f5f6-11ed-b1d4-0a58a9feac02	line:IDFM:C01374	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 4 : Incident d'exploitation - Reprise progressive / trafic reste perturbé	<p>Le trafic reprend mais reste perturbé sur l'ensemble de la ligne en raison d'un incident d'exploitation à Porte de Clignancourt<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-19 05:40:06	2023-05-19 05:38:00	2023-05-20 03:45:00
282	12d72958-f645-11ed-a257-0a58a9feac02	line:IDFM:C01371	active	perturbation	#FF0000	NO_SERVICE	Métro 1 : Incident d'exploitation - Trafic interrompu	<p>Le trafic est interrompu entre Château de Vincennes et Nation en raison d'un incident d'exploitation<br>Heure de reprise estimée : 15h30.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-19 15:00:04	2023-05-19 14:57:00	2023-05-20 03:45:00
283	7860a974-f646-11ed-b125-0a58a9feac02	line:IDFM:C01386	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 3B : Difficultés d'exploitation - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de difficultés d'exploitation<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-19 15:10:04	2023-05-19 15:08:00	2023-05-20 03:45:00
284	c9ca48e0-f63e-11ed-a257-0a58a9feac02	line:IDFM:C01378	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 8 : Panne de signalisation - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'une panne de signalisation à Concorde<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-19 14:15:05	2023-05-19 14:12:00	2023-05-20 03:45:00
285	65867c62-f636-11ed-b1d4-0a58a9feac02	line:IDFM:C01383	past	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 13 : Intervention des équipes techniques - Reprise progressive / trafic reste perturbé	<p>Le trafic reprend mais reste perturbé sur l'ensemble de la ligne en raison d'une intervention des équipes techniques<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-19 14:15:04	2023-05-19 14:10:57	2023-05-19 14:11:57
286	2f47fbe6-f63e-11ed-b125-0a58a9feac02	line:IDFM:C01742	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne A : ralentissements	<p>Le trafic est ralenti entre La D&#233;fense et Cergy le Haut et entre La D&#233;fense et Poissy dans les 2 sens. <br><br>Motif : &#160;incendie aux abords des voies &#224; Maisons Laffitte.</p>	2023-05-19 14:29:28	2023-05-19 14:06:24	2023-05-19 15:30:36
287	f631caba-f649-11ed-8b34-0a58a9feac02	line:IDFM:C01375	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 5 : Gêne à la fermeture des portes - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'une gêne à la fermeture des portes à Gare d’Austerlitz<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-19 15:35:04	2023-05-19 15:33:00	2023-05-20 03:45:00
288	9d797a66-f64a-11ed-b1d4-0a58a9feac02	line:IDFM:C01729	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne E : 1 gare non desservie	<p>La gare de Rosa Parks en direction de Haussmann St-Lazare n'est pas desservie jusqu'&#224; 16h. <br><br>Motif : panne d'un train &#224; Rosa-Parks.<br></p>	2023-05-19 15:39:45	2023-05-19 15:34:32	2023-05-19 16:00:00
289	8e565f5e-f64f-11ed-b125-0a58a9feac02	line:IDFM:C01373	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 3 : Difficultés d'exploitation - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de difficultés d'exploitation<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-19 16:15:07	2023-05-19 16:13:00	2023-05-20 03:45:00
290	8ee847b6-f64f-11ed-a257-0a58a9feac02	line:IDFM:C01383	active	perturbation	#FF0000	NO_SERVICE	Métro 13 : Intervention des équipes techniques - Trafic interrompu	<p>Le trafic est interrompu entre Asnières - Gennevilliers Les Courtilles et La Fourche en raison d'une intervention des équipes techniques<br>Heure de reprise estimée : 16h30.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-19 16:15:08	2023-05-19 16:12:00	2023-05-20 03:45:00
291	51b53bbe-f68c-11ed-8b34-0a58a9feac02	line:IDFM:C01382	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 12 : Bagage oublié - Reprise progressive / trafic reste perturbé	<p>Le trafic reprend mais reste perturbé sur l'ensemble de la ligne en raison d'un bagage oublié à Mairie d'Issy<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-20 00:20:06	2023-05-20 00:17:00	2023-05-21 03:45:00
292	31bd334a-f662-11ed-a257-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D Stade de France: 19/05 aucun train dès 23h	<p>Vendredi 19 mai</p><p>A partir de 23h en gare du Stade de France, aucun train pour le nord de la Ligne.<br>Des bus de remplacement circulent,</p><p>( ceux au d&#233;part de la station de m&#233;tro Saint Denis Universit&#233; sur la Ligne 13<b></b> ne desservent pas par la gare de Stade de France ).<br><br>Les horaires du calculateur d'itin&#233;raire tiennent compte de ces travaux</p><p><br></p><p>Motif : travaux.<br></p><p><br></p>	2023-05-19 22:43:28	2023-05-19 23:00:00	2023-05-20 02:30:00
293	f0965800-f69e-11ed-b1d4-0a58a9feac02	line:IDFM:C01742	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne A : ralentissements	<p>Le trafic est ralenti de La D&#233;fense vers Rueil-Malmaison. <br><br>Motif : d&#233;clenchement du signal d'alarme en gare de Charles de Gaulle - Etoile</p>	2023-05-20 01:43:22	2023-05-20 01:40:57	2023-05-20 02:00:00
294	c61eb64a-f6fc-11ed-b125-0a58a9feac02	line:IDFM:C01371	active	perturbation	#FF0000	NO_SERVICE	Métro 1 : Intervention des équipes techniques - Trafic interrompu	<p>Le trafic est interrompu entre Château de Vincennes et Châtelet en raison d'une intervention des équipes techniques<br>Heure de reprise estimée : 13h25.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-20 13:00:04	2023-05-20 12:53:00	2023-05-21 03:45:00
295	3940fc80-f6f5-11ed-a257-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C Versail.Château - Juvisy : suppressions	<p>Trains supprim&#233;s :</p><p><br></p><p>- Le train JILL au d&#233;part de la gare de Versailles Rive Gauche &#224; 12h25, et pr&#233;vu &#224; l'arriv&#233;e en gare de Juvisy &#224; 13h29.</p><p>- Le train VICK au d&#233;part de la gare de Juvisy &#224; 13h46, et pr&#233;vu &#224; l'arriv&#233;e en gare de Versailles Rive Gauche &#224; 14h49.<br></p><p>Prochain train &#224; circuler :<br><br>- Le train JILL au d&#233;part de la gare de Versailles Rive Gauche &#224; 12h40, et pr&#233;vu &#224; l'arriv&#233;e en gare de Juvisy &#224; 13h49.</p><p>- Le train VICK au d&#233;part de la gare de Juvisy &#224; 14h02, et pr&#233;vu &#224; l'arriv&#233;e en gare de Versailles Rive Gauche &#224; 15h04.</p><p>Risque d'affluence &#224; bord des trains suivants.<br><br>Motif : panne d'un train.<br><br><br></p>	2023-05-20 12:10:20	2023-05-20 11:58:09	2023-05-20 14:50:22
296	74cb97f6-f704-11ed-930a-0a58a9feac02	line:IDFM:C01371	active	perturbation	#FF0000	NO_SERVICE	Métro 1 : Incident affectant la voie - Trafic interrompu	<p>Le trafic est interrompu entre Château de Vincennes et Châtelet en raison d'un incident affectant la voie à Nation<br>Heure de reprise estimée : 14h30.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-20 13:50:03	2023-05-20 13:47:00	2023-05-21 03:45:00
297	0a52a9cc-f70a-11ed-b125-0a58a9feac02	line:IDFM:C01373	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 3 : Personnes sur les voies - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de personnes sur les voies<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-20 14:30:01	2023-05-20 14:25:00	2023-05-21 03:45:00
298	250a0344-f70c-11ed-b1d4-0a58a9feac02	line:IDFM:C01373	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 3 : Divers incidents - Trafic perturbé	<p>Le train stationne entre Anatole-France et Louise Michel en direction de Gallieni en raison d'un incident nécessitant l’intervention du conducteur<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-20 14:45:05	2023-05-20 14:40:34	2023-05-20 15:26:34
299	4348e01a-f710-11ed-b125-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C Invalides - Pontoise : suppressions	<p>Trains supprim&#233;s :<br>- Le train NORA au d&#233;part de la gare d&#8217;Invalides &#224; 16h58 pour une arriv&#233;e en gare de Pontoise &#224; 18h02<br>- Le train LOLA au d&#233;part de la gare de Pontoise &#224; 18h28 pour une arriv&#233;e en gare d&#8217;Invalides &#224; 19h31</p><p>-Le train LOLA au d&#233;part de la gare de Pontoise &#224; 18h58 pour une arriv&#233;e en gare d&#8217;Invalides &#224; 20h01</p><p>-Le train GOTA au d&#233;part de la gare d&#8217;Invalides &#224; 20h13 pour une arriv&#233;e en gare de Montigny Beauchamp &#224; 21h04</p><p>Prochains trains &#224; circuler :<br>- Le train NORA au d&#233;part de la gare d&#8217;Invalides &#224; 17h58 pour une arriv&#233;e en gare de Pontoise &#224; 19h02<br>- Le train LOLA au d&#233;part de la gare de Montigny Beauchamp &#224; 18h55 pour une arriv&#233;e en gare d&#8217;Invalides &#224; 19h46</p><p>-Le train LOLA au d&#233;part de la gare de Montigny Beauchamp &#224; 19h25 pour une arriv&#233;e en gare d&#8217;Invalides &#224; 20h16<br>Risque d'affluence &#224; bord des trains suivants.</p><p>-Le train LOLA au d&#233;part de la gare de Pontoise &#224; 19h28 pour une arriv&#233;e en gare d&#8217;Invalides &#224; 20h31</p><p>-Le train NORA au d&#233;part de la gare d&#8217;Invalides &#224; 20h28 pour un passage en gare de Montigny Beauchamp &#224; 21h18<br><br>Motif : difficult&#233;s li&#233;es &#224; un manque de personnel.<br><br><br></p>	2023-05-20 15:14:34	2023-05-20 15:09:47	2023-05-20 21:00:02
300	2d99828e-f714-11ed-930a-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C St-Quentin - Invalides : suppressions	<p>Trains supprim&#233;s :<br>- Le train LOLA au d&#233;part de la gare de Saint Quentin-en-Yvelines &#224; 17h10 pour une arriv&#233;e en gare d&#8217;Invalides &#224; 17h51<br>- Le train SARA au d&#233;part de la gare d&#8217;Invalides &#224; 18h08 pour une arriv&#233;e en gare de Saint Quentin-en-Yvelines &#224; 18h51</p><p>-Le train LOLA au d&#233;part de la gare de Saint Quentin-en-Yvelines &#224; 19h10 pour une arriv&#233;e en gare d&#8217;Invalides &#224; 19h51</p><p>-Le train SARA au d&#233;part de la gare d&#8217;Invalides &#224; 20h08 pour une arriv&#233;e en gare de Saint Quentin-en-Yvelines &#224; 20h51</p><p>-Le train LOLA au d&#233;part de la gare de Saint Quentin-en-Yvelines &#224; 21h10 pour une arriv&#233;e en gare d&#8217;Invalides &#224; 21h51<br></p><p><br></p><p>Prochains trains &#224; circuler :<br>- Le train LOLA au d&#233;part de la gare de Saint Quentin-en-Yvelines &#224; 17h40 pour une arriv&#233;e en gare d&#8217;Invalides &#224; 18h21<br>- Le train SARA au d&#233;part de la gare d&#8217;Invalides &#224; 18h38 pour une arriv&#233;e en gare de Saint Quentin-en-Yvelines &#224; 19h21</p><p>-Le train LOLA au d&#233;part de la gare de Saint Quentin-en-Yvelines &#224; 19h40 pour une arriv&#233;e en gare d&#8217;Invalides &#224; 20h21<br></p><p>-Le train SARA au d&#233;part de la gare d&#8217;Invalides &#224; 20h38 pour une arriv&#233;e en gare de Saint Quentin-en-Yvelines &#224; 21h21</p><p>-Le train LOLA au d&#233;part de la gare de Saint Quentin-en-Yvelines &#224; 21h40 pour une arriv&#233;e en gare d&#8217;Invalides &#224; 22h21<br><br>Motif : difficult&#233;s li&#233;es &#224; un manque de personnel.<br><br><br></p>	2023-05-20 15:42:35	2023-05-20 15:39:29	2023-05-20 21:50:41
301	88f5e8f2-f714-11ed-b1d4-0a58a9feac02	line:IDFM:C01376	active	perturbation	#FF0000	NO_SERVICE	Métro 6 : Train en panne - Trafic interrompu	<p>Le trafic est interrompu entre Charles de Gaulle - Etoile et Trocadéro en raison d'un train en panne à Charles de Gaulle - Etoile<br>Heure de reprise estimée : 16h00.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-20 15:45:08	2023-05-20 15:42:00	2023-05-21 03:45:00
302	d2df1d86-f713-11ed-930a-0a58a9feac02	line:IDFM:C01376	active	perturbation	#FF0000	NO_SERVICE	Métro 6 : Train en panne - Trafic interrompu	<p>Le trafic est interrompu entre Trocadéro et Charles de Gaulle - Etoile en raison d'un train en panne à Charles de Gaulle - Etoile<br>Heure de reprise estimée : 16h15.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-20 15:45:07	2023-05-20 15:42:00	2023-05-21 03:45:00
303	f813daf0-f714-11ed-930a-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C Vers.Chantiers- Paris Aust. : suppressions	<p>Trains supprim&#233;s :<br>- Le train ZORA au d&#233;part de la gare de Versailles Chantiers &#224; 18h15 pour une arriv&#233;e en gare de Paris Austerlitz Banlieue &#224; 19h19<br>- Le train CIMO au d&#233;part de la gare de Paris Austerlitz Banlieue &#224; 19h40 pour une arriv&#233;e en gare de Versailles Chantiers &#224; 20h49<br><br>Prochains trains &#224; circuler :<br>-&#160;Le train ZORA au d&#233;part de la gare de Versailles Chantiers &#224; 18h45 pour une arriv&#233;e en gare de Paris Austerlitz Banlieue &#224; 19h49<br>- Le train CIMO au d&#233;part de la gare de Paris Austerlitz Banlieue &#224; 20h10 pour une arriv&#233;e en gare de Versailles Chantiers &#224; 21h19<br><br><br>Motif : difficult&#233;s li&#233;es &#224; un manque de personnel.<br><br><br></p>	2023-05-20 15:48:15	2023-05-20 15:44:22	2023-05-20 20:50:58
304	5ff08984-f715-11ed-a257-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C Versail.Château - Juvisy : suppression	<p>Train supprim&#233; :<br>- Le train JILL au d&#233;part de la gare de Versailles Ch&#226;teau Rive Gauche &#224; 19h25 pour une arriv&#233;e en gare de Juvisy &#224; 20h32<br><br>Prochain train &#224; circuler :<br>- &#160;Le train JILL au d&#233;part de la gare de Versailles Ch&#226;teau Rive Gauche &#224; 19h40 pour une arriv&#233;e en gare de Juvisy &#224; 20h44<br><br><br>Motif : difficult&#233;s li&#233;es &#224; un manque de personnel.<br></p><p><br></p><p><br></p>	2023-05-20 15:51:09	2023-05-20 15:48:30	2023-05-20 20:30:45
305	9f429892-f716-11ed-a257-0a58a9feac02	line:IDFM:C01376	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 6 : Train en panne - Reprise progressive / trafic reste perturbé	<p>Le trafic reprend mais reste perturbé sur l'ensemble de la ligne en raison d'un train en panne à Charles de Gaulle - Etoile<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-20 16:00:05	2023-05-20 15:55:59	2023-05-20 16:41:59
306	0d5e8b36-f719-11ed-b1d4-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C : ralentissements	<p>Le trafic est ralenti entre Invalides et Gennevilliers dans les 2 sens. <br><br>Motif : incident voyageur (chute d'un voyageur dans un train en gare de Boulainvilliers)</p>	2023-05-20 16:17:29	2023-05-20 16:15:09	2023-05-20 16:45:21
307	3896aefa-f719-11ed-b125-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D : Melun <-> Corbeil-Ess. trafic ralenti	<p>Le trafic est ralenti entre Melun et Corbeil Essonnes dans les 2 sens. <br><br>Motif : panne sur les installations du gestionnaire de r&#233;seau (dysfonctionnement d&#8217;un passage &#224; niveau dans le secteur de Villab&#233;.</p>	2023-05-20 16:18:41	2023-05-20 16:16:10	2023-05-20 17:30:24
308	78040cd4-f725-11ed-b1d4-0a58a9feac02	line:IDFM:C01727	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne C Pont de Rungis-Paris Austerl : suppression	<p>Train supprim&#233; :<br>- Le train ZORA au d&#233;part de la gare de Pont-de-Rungis &#224; 18h08 pour une arriv&#233;e en gare de Paris Austerlitz Banlieue &#224; 18h34<br>Prochain train &#224; circuler :<br>- Le train ZORA au passage en gare de Pont-de-Rungis &#224; 18h22 pour une arriv&#233;e en gare de Paris Austerlitz Banlieue &#224; 18h49<br><br><br>Motif : acte de vandalisme (d&#233;gradation du train).<br></p><p><br></p><p><br></p>	2023-05-20 17:46:21	2023-05-20 17:43:09	2023-05-20 18:30:21
314	772e3b3c-f733-11ed-930a-0a58a9feac02	line:IDFM:C01743	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne B : Paris Nord - St-Rémy / Robinson perturbé	<p>Le trafic est perturb&#233; entre Paris Gare du Nord et Saint-R&#233;my-l&#232;s-Chevreuse et entre Paris Gare du Nord et Robinson.<br><br>Motif : individus sur les voies &#224; Paris Nord.<br><br><br></p>	2023-05-20 19:26:33	2023-05-20 19:23:50	2023-05-20 22:24:16
309	44eec14a-f72a-11ed-930a-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D : Corbeil-Ess. - Melun ralenti	<p>Pr&#233;voir un allongement de temps de trajet de 25 minutes environ pour le train suivant :</p><p>- ZOVO, d&#233;part Juvisy 17h35, arriv&#233;e Melun 18h24.<br></p><p>Un signal est en d&#233;rangement en sortie de la gare de Corbeil-Essonnes. <br></p><p>Motif : panne sur les installations du gestionnaire de r&#233;seau en gare de Corbeil-Essonnes.<br></p>	2023-05-20 18:20:43	2023-05-20 18:14:50	2023-05-20 19:15:09
310	463df500-f72c-11ed-b1d4-0a58a9feac02	line:IDFM:C01375	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 5 : Gêne à la fermeture des portes - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'une gêne à la fermeture des portes à Porte de Pantin<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-20 18:35:04	2023-05-20 18:31:00	2023-05-21 03:45:00
311	f9577652-f72c-11ed-8b34-0a58a9feac02	line:IDFM:C01383	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 13 : Gêne à la fermeture des portes - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'une gêne à la fermeture des portes<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-20 18:40:05	2023-05-20 18:36:00	2023-05-21 03:45:00
312	d9128256-f72c-11ed-8b34-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D : ralentissements	<p>Le trafic est ralenti entre Paris Gare du Nord et Orry la Ville dans les 2 sens. <br></p><p>Une &#233;quipe de la s&#251;ret&#233; ferroviaire est en cours d&#8217;intervention pour interpeller les personnes sur les voies.</p><p><br></p><p>Motif : individus sur les voies dans le secteur de Paris Gare du Nord.<br></p>	2023-05-20 18:39:11	2023-05-20 18:34:37	2023-05-20 20:00:00
313	4685db90-f731-11ed-8b34-0a58a9feac02	line:IDFM:C01742	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne A : ralentissements	<p>Le trafic est ralenti entre Marne-la-Vall&#233;e Chessy et Vincennes dans les 2 sens. <br></p><p><br></p><p>Motif : animal sur les voies dans le secteur de Neuilly-Plaisance.<br></p>	2023-05-20 19:10:52	2023-05-20 18:59:41	2023-05-20 20:00:00
315	5203696c-f743-11ed-930a-0a58a9feac02	line:IDFM:C01382	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 12 : Incident (intervention agents) - Train stationne	<p>Le train stationne sur l'ensemble de la ligne en raison d'un incident nécessitant l’intervention de nos agents<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-20 21:20:03	2023-05-20 21:14:27	2023-05-20 22:00:27
316	00940b56-f74b-11ed-8b34-0a58a9feac02	line:IDFM:C01371	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 1 : Incident affectant la voie - Reprise progressive / trafic reste perturbé	<p>Le trafic reprend mais reste perturbé sur l'ensemble de la ligne en raison d'un incident affectant la voie à Nation<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-20 22:15:02	2023-05-20 22:13:00	2023-05-21 03:45:00
317	9d04e202-f74c-11ed-930a-0a58a9feac02	line:IDFM:C01742	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne A : ralentissements	<p>Le trafic est ralenti de Saint-Germain-en-Laye vers Boissy-Saint-L&#233;ger. <br><br>Motif : malaise voyageur (en gare de St Germain en Laye)</p>	2023-05-20 22:26:34	2023-05-20 22:24:39	2023-05-20 23:30:00
318	4fb1bfa2-f88c-11ed-b1d4-0a58a9feac02	line:IDFM:C01376	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 6 : Panne de signalisation - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison d'une panne de signalisation à Place d'Italie<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-22 12:50:03	2023-05-22 12:44:00	2023-05-23 03:45:00
319	d1618310-f888-11ed-930a-0a58a9feac02	line:IDFM:C01376	past	perturbation	#FF0000	NO_SERVICE	Métro 6 : Intervention des équipes techniques - Trafic interrompu	<p>Le trafic est interrompu entre Place d'Italie et Raspail en raison d'une intervention des équipes techniques à Place d'Italie<br>Heure de reprise estimée : 12h30.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-22 12:35:02	2023-05-22 12:27:44	2023-05-22 12:28:44
320	64dc5bcc-f895-11ed-b125-0a58a9feac02	line:IDFM:C01384	active	perturbation	#FF0000	NO_SERVICE	Métro 14 : Malaise voyageur - Trafic interrompu	<p>Le trafic est interrompu entre Saint-Lazare et Châtelet en raison d'un malaise voyageur à Madeleine<br>Heure de reprise estimée : 14h00.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-22 13:40:04	2023-05-22 13:35:00	2023-05-23 03:45:00
321	e3a15fd6-f898-11ed-8b34-0a58a9feac02	line:IDFM:C01373	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Métro 3 : Difficultés d'exploitation - Trafic perturbé	<p>Le trafic est perturbé sur l'ensemble de la ligne en raison de difficultés d'exploitation<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-22 14:05:05	2023-05-22 14:03:00	2023-05-23 03:45:00
322	fbc00c28-f89a-11ed-b1d4-0a58a9feac02	line:IDFM:C01373	active	perturbation	#FF0000	NO_SERVICE	Métro 3 : Bagage oublié - Trafic interrompu	<p>Le trafic est interrompu entre Gambetta et Gallieni en raison d'un bagage oublié<br>Heure de reprise estimée : 15h30.<br><a href='http://www.ratp.fr'>Plus d'informations sur le site ratp.fr</a></p>	2023-05-22 14:20:05	2023-05-22 14:18:00	2023-05-22 16:15:00
323	eac9af12-f89c-11ed-b1d4-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D Melun - Corbeil-Ess. : suppressions	<p>Train supprim&#233; :<br>- ROSA, d&#233;part Melun 17h26, arriv&#233;e Corbeil-Essonnes 17h56.<br><br>Prochain train &#224; circuler :<br>- ROSA, d&#233;part Melun 17h41, arriv&#233;e Corbeil-Essonnes 18h11.<br></p><p><br></p><p>Train supprim&#233; : <br>- ZOSO, d&#233;part de Corbeil-Essonnes 18h17,&#160; arriv&#233;e Melun &#224; 18h47<br><br>Prochain train &#224; circuler : <br>- ZOSO, d&#233;part de Corbeil-Essonnes &#224; 18h32, arriv&#233;e Melun 19h02<br><br></p><p><br></p><p>Risque d'affluence &#224; bord des trains suivants.<br><br><br>Motif : conditions de d&#233;part non r&#233;unies (train immobilis&#233; en atelier de maintenance).<br><br><br></p>	2023-05-22 14:33:55	2023-05-22 14:25:34	2023-05-22 19:10:52
324	c844b0ac-f89e-11ed-930a-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D : Melun <-> Corbeil-Ess. suppressions	<p>Train supprim&#233; :<br>- ROSA, d&#233;part Melun 18h56, arriv&#233;e Corbeil-Essonnes 19h26.<br><br>Prochain train &#224; circuler :<br>- ROSA, d&#233;part&#160; Melun 19h11, arriv&#233;e Corbeil-Essonnes 19h41. <br></p><p>Train supprim&#233; : <br>- ZOSO, d&#233;part&#160; Corbeil-Essonnes&#160; 19h47, arriv&#233;e&#160; Melun 20h17. <br><br>Prochain train &#224; circuler : <br>- ZOSO, d&#233;part Corbeil-Essonnes 20h02, arriv&#233;e &#224; Melun 20h32. <br><br></p><p><br>Motif : conditions de d&#233;part non r&#233;unies (train immobilis&#233; en atelier de maintenance)</p>	2023-05-22 14:47:16	2023-05-22 14:37:58	2023-05-22 20:20:30
325	8ca1b5f8-f89f-11ed-930a-0a58a9feac02	line:IDFM:C01728	active	perturbation	#EF662F	SIGNIFICANT_DELAYS	Ligne D Melun - Corbeil-Ess. : suppression	<p>Train supprim&#233; :<br>- ROSA d&#233;part Melun 19h56, arriv&#233;e Corbeil-Essonnes 20h26. <br><br>Prochain train &#224; circuler :<br>- ROSA d&#233;part Melun 20h26, arriv&#233;e Corbeil-Essonnes 20h56.<br><br>Risque d'affluence &#224; bord du train suivant.<br><br>Motif : conditions de d&#233;part non r&#233;unies (train immobilis&#233; en atelier de maintenance).<br></p><p><br></p><p><br></p>	2023-05-22 14:52:46	2023-05-22 14:48:59	2023-05-22 20:49:13
\.


--
-- Data for Name: lines; Type: TABLE DATA; Schema: public; Owner: ps3r
--

COPY public.lines (id, line_id, code, name, color, text_color, closing_time, opening_time, physical_mode) FROM stdin;
1	line:IDFM:C01371	1	Château de Vincennes - La Défense (Grande Arche)	FFCD00	000000	0001-01-01 02:15:00 BC	0001-01-01 05:30:00 BC	physical_mode:Metro
2	line:IDFM:C01372	2	Porte Dauphine - Nation	003CA6	FFFFFF	0001-01-01 02:15:00 BC	0001-01-01 05:29:00 BC	physical_mode:Metro
3	line:IDFM:C01386	3B	Gambetta - Porte des Lilas	6EC4E8	000000	0001-01-01 02:15:00 BC	0001-01-01 05:27:00 BC	physical_mode:Metro
4	line:IDFM:C01374	4	Porte de Clignancourt - Bagneaux Lucie Aubrac	CF009E	FFFFFF	0001-01-01 02:15:00 BC	0001-01-01 05:30:00 BC	physical_mode:Metro
5	line:IDFM:C01375	5	Place d'Italie - Bobigny Pablo Picasso	FF7E2E	000000	0001-01-01 02:15:00 BC	0001-01-01 05:30:00 BC	physical_mode:Metro
6	line:IDFM:C01376	6	Gare Montparnasse - Nation	6ECA97	000000	0001-01-01 02:15:00 BC	0001-01-01 05:29:00 BC	physical_mode:Metro
7	line:IDFM:C01387	7B	Pré-Saint-Gervais - Louis Blanc	6ECA97	000000	0001-01-01 02:16:00 BC	0001-01-01 05:31:00 BC	physical_mode:Metro
8	line:IDFM:C01378	8	Pointe du Lac - Balard	E19BDF	000000	0001-01-01 02:15:00 BC	0001-01-01 05:21:00 BC	physical_mode:Metro
9	line:IDFM:C01379	9	Pont de Sèvres - Mairie de Montreuil	B6BD00	000000	0001-01-01 02:15:00 BC	0001-01-01 05:30:00 BC	physical_mode:Metro
10	line:IDFM:C01381	11	Châtelet - Mairie des Lilas	704B1C	FFFFFF	0001-01-01 02:15:00 BC	0001-01-01 05:30:00 BC	physical_mode:Metro
11	line:IDFM:C01382	12	Front Populaire - Proudhon / Gardinoux - Mairie d'Issy	007852	FFFFFF	0001-01-01 02:15:00 BC	0001-01-01 05:30:00 BC	physical_mode:Metro
12	line:IDFM:C01383	13	Châtillon-Montrouge - Saint-Denis - Université	6EC4E8	000000	0001-01-01 02:15:00 BC	0001-01-01 05:30:00 BC	physical_mode:Metro
13	line:IDFM:C01384	14	Olympiades - Mairie de Saint-Ouen	62259D	FFFFFF	0001-01-01 02:15:00 BC	0001-01-01 05:18:00 BC	physical_mode:Metro
14	line:IDFM:C01742	A	A	EB2132	FFFFFF	0001-01-01 01:52:40 BC	0001-01-01 04:41:40 BC	physical_mode:RapidTransit
15	line:IDFM:C01743	B	B	5091CB	FFFFFF	0001-01-01 01:24:00 BC	0001-01-01 04:41:30 BC	physical_mode:RapidTransit
16	line:IDFM:C01727	C	C	FFCC30	000000	0001-01-01 01:32:30 BC	0001-01-01 03:38:40 BC	physical_mode:RapidTransit
17	line:IDFM:C01728	D	D	008B5B	FFFFFF	0001-01-01 01:51:10 BC	0001-01-01 04:03:10 BC	physical_mode:RapidTransit
18	line:IDFM:C01729	E	E	B94E9A	FFFFFF	0001-01-01 01:34:20 BC	0001-01-01 04:52:00 BC	physical_mode:RapidTransit
19	line:IDFM:C01373	3	Pont de Levallois - Bécon - Gallieni	837902	FFFFFF	0001-01-01 02:15:00 BC	0001-01-01 05:30:00 BC	physical_mode:Metro
20	line:IDFM:C01377	7	La Courneuve - 8 Mai 1945 - Mairie d'Ivry	FA9ABA	000000	0001-01-01 02:17:00 BC	0001-01-01 05:28:00 BC	physical_mode:Metro
21	line:IDFM:C01380	10	Boulogne Pont de Saint-Cloud - Gare d'Austerlitz	C9910D	000000	0001-01-01 02:15:00 BC	0001-01-01 05:30:00 BC	physical_mode:Metro
\.


--
-- Data for Name: log; Type: TABLE DATA; Schema: public; Owner: ps3r
--

COPY public.log (id, created_at, disruption_id) FROM stdin;
1	2023-03-31 22:48:38.396777	1
3	2023-03-31 22:49:02.546328	3
5	2023-04-01 14:27:36.824508	5
6	2023-04-01 16:00:49.591865	6
7	2023-04-01 16:40:58.745212	7
8	2023-04-01 17:06:04.262844	8
9	2023-04-01 18:41:28.30725	9
10	2023-04-01 18:41:29.206132	10
11	2023-04-01 19:56:42.405388	11
12	2023-04-01 20:07:29.915787	12
13	2023-04-01 20:12:31.085969	13
14	2023-04-02 14:57:09.652677	14
15	2023-04-02 16:22:26.682971	15
16	2023-04-02 16:22:26.691425	16
17	2023-04-02 17:07:35.895046	17
18	2023-04-02 17:07:35.908062	18
19	2023-04-02 21:08:31.991787	19
20	2023-04-02 22:03:44.182761	20
21	2023-04-02 22:08:45.303574	21
22	2023-04-02 22:43:53.499829	22
23	2023-04-02 22:53:55.75109	23
24	2023-04-02 23:39:05.913973	24
25	2023-04-02 23:49:08.09986	25
26	2023-04-03 14:40:26.12885	26
27	2023-04-03 16:05:54.867732	27
28	2023-04-03 16:50:26.346928	28
29	2023-04-03 16:50:27.218003	29
30	2023-04-03 17:05:32.742364	30
31	2023-04-03 17:35:39.418675	31
32	2023-04-03 17:40:41.912835	32
33	2023-04-03 17:50:43.860809	33
34	2023-04-03 17:50:43.866121	34
35	2023-04-03 17:55:45.070283	35
36	2023-04-03 17:55:45.075249	36
37	2023-04-03 18:00:46.148051	37
70	2023-04-03 19:25:43.734217	70
71	2023-04-03 19:25:43.741742	71
72	2023-04-03 19:25:44.610402	72
73	2023-04-03 19:25:44.61478	73
74	2023-04-03 19:25:44.618437	74
75	2023-04-03 19:35:46.407742	75
76	2023-04-03 19:39:44.892185	76
77	2023-04-03 19:39:44.898396	77
78	2023-04-03 19:39:45.729337	78
79	2023-04-03 19:39:45.737104	79
80	2023-04-03 20:00:20.639938	80
81	2023-04-03 22:00:48.860338	81
82	2023-04-04 15:03:46.840056	82
83	2023-04-04 15:54:01.260545	83
84	2023-04-04 16:39:22.698157	84
85	2023-04-04 16:44:25.25103	85
86	2023-04-04 16:44:25.256496	86
87	2023-04-04 16:44:25.26189	87
88	2023-04-04 16:54:28.372399	88
89	2023-04-04 16:59:29.811899	89
90	2023-04-04 17:04:31.177033	90
91	2023-04-04 17:09:32.437587	91
92	2023-04-04 17:09:32.445604	92
93	2023-04-04 17:09:32.451347	93
94	2023-04-04 17:09:32.457103	94
95	2023-04-04 17:09:32.465417	95
96	2023-04-04 17:19:35.18207	96
97	2023-04-04 17:19:35.189743	97
98	2023-04-04 17:39:38.993289	98
99	2023-04-04 17:39:39.00307	99
100	2023-04-04 17:39:39.015502	100
101	2023-04-04 17:39:39.020499	101
102	2023-04-04 17:39:39.026044	102
103	2023-04-05 11:02:25.627695	103
104	2023-04-05 11:47:48.747993	104
105	2023-04-05 11:57:56.612499	105
106	2023-04-05 12:48:19.094706	106
107	2023-04-05 14:15:15.148708	107
108	2023-04-05 14:15:17.342751	108
109	2023-04-06 11:12:25.801044	109
110	2023-04-06 11:12:25.810064	110
111	2023-04-06 11:12:25.821425	111
112	2023-04-06 11:12:25.826929	112
113	2023-04-06 11:12:25.832527	113
114	2023-04-06 11:12:25.838643	114
115	2023-04-06 11:12:25.846802	115
116	2023-04-06 11:12:25.854276	116
117	2023-04-06 11:12:25.860174	117
118	2023-04-06 11:12:25.865078	118
119	2023-04-06 11:12:25.869698	119
120	2023-04-06 11:12:25.875248	120
121	2023-04-06 11:12:25.880043	121
122	2023-04-06 11:12:25.886837	122
123	2023-04-06 11:12:25.892582	123
124	2023-04-06 14:59:24.234595	124
125	2023-04-06 15:19:35.597393	125
126	2023-04-06 16:10:03.463537	126
127	2023-04-06 16:40:23.455221	127
128	2023-04-06 16:40:23.481046	128
129	2023-04-06 17:20:48.334638	129
130	2023-04-06 17:20:50.613139	130
131	2023-04-06 17:25:53.099799	131
132	2023-04-06 18:01:11.663117	132
133	2023-04-06 18:36:29.229712	133
134	2023-04-06 19:16:54.243803	134
135	2023-04-06 19:21:56.986845	135
136	2023-04-06 21:08:03.538282	136
137	2023-04-06 21:58:29.340222	137
138	2023-04-06 23:04:02.46889	138
139	2023-04-06 23:14:11.250806	139
140	2023-04-07 15:07:13.047561	140
141	2023-04-07 15:07:15.716886	141
142	2023-04-07 15:07:15.722292	142
143	2023-04-07 15:07:15.727755	143
144	2023-04-07 15:22:21.527576	144
145	2023-04-07 15:37:29.40893	145
146	2023-04-07 15:42:31.967872	146
147	2023-04-07 15:47:37.295254	147
148	2023-04-07 16:02:44.150332	148
149	2023-04-07 16:33:06.178566	149
150	2023-04-07 17:03:24.817401	150
151	2023-04-07 17:43:45.077835	151
152	2023-04-07 17:43:47.830113	152
153	2023-04-07 17:43:47.848296	153
154	2023-04-07 17:53:51.287179	154
155	2023-04-13 08:53:02.622276	155
156	2023-04-13 08:53:02.628577	156
157	2023-04-13 08:53:02.632576	157
158	2023-04-13 08:53:02.637272	158
159	2023-04-13 08:53:02.641423	159
160	2023-04-13 08:53:02.645511	160
161	2023-04-13 08:53:02.649644	161
162	2023-04-13 08:53:02.653921	162
163	2023-04-13 08:53:02.659517	163
164	2023-04-13 08:53:02.664026	164
165	2023-04-13 08:53:02.66813	165
166	2023-04-13 08:53:02.672238	166
167	2023-04-13 08:53:02.677127	167
168	2023-04-13 08:53:02.683834	168
169	2023-04-13 08:53:02.689201	169
170	2023-04-13 08:53:02.694082	170
171	2023-04-13 08:53:02.699897	171
172	2023-04-13 08:53:04.856557	172
173	2023-04-13 08:53:04.862356	173
174	2023-04-13 08:53:04.867244	174
175	2023-04-13 08:53:04.871122	175
176	2023-04-13 08:53:04.876117	176
177	2023-04-13 08:53:04.880431	177
178	2023-04-13 10:13:43.926882	178
179	2023-04-17 17:53:28.669638	179
180	2023-04-17 17:53:28.675823	180
181	2023-04-17 17:53:28.679626	181
182	2023-04-17 17:53:28.68494	182
183	2023-05-05 02:46:15.47635	183
184	2023-05-05 02:46:15.483297	184
185	2023-05-05 16:15:25.454394	185
186	2023-05-05 16:30:30.329755	186
187	2023-05-05 17:05:47.41745	187
188	2023-05-05 17:51:06.291119	188
189	2023-05-05 18:06:15.31978	189
190	2023-05-05 18:21:24.483737	190
191	2023-05-05 18:26:24.731343	191
192	2023-05-05 18:46:34.193674	192
193	2023-05-05 18:51:38.614911	193
194	2023-05-05 19:06:44.59761	194
195	2023-05-05 19:11:46.959178	195
196	2023-05-05 20:12:14.250934	196
197	2023-05-05 20:17:17.954571	197
198	2023-05-05 22:58:24.240353	198
199	2023-05-05 22:58:24.245712	199
200	2023-05-05 23:18:32.41738	200
201	2023-05-06 00:24:00.285521	201
202	2023-05-06 00:24:02.274107	202
203	2023-05-06 02:24:53.394379	203
204	2023-05-06 03:00:11.395133	204
205	2023-05-07 20:58:01.141361	205
206	2023-05-07 21:53:27.027567	206
207	2023-05-08 12:43:12.89303	207
208	2023-05-08 12:43:12.904176	208
209	2023-05-08 12:43:12.916735	209
210	2023-05-08 12:43:12.924452	210
211	2023-05-08 16:37:16.337118	211
212	2023-05-08 16:37:16.349728	212
213	2023-05-08 16:37:18.25553	213
214	2023-05-08 17:53:11.208429	214
215	2023-05-08 18:03:15.543708	215
216	2023-05-09 03:32:52.718548	216
217	2023-05-09 03:37:54.602418	217
218	2023-05-09 13:49:11.412407	218
219	2023-05-09 13:49:13.756545	219
220	2023-05-09 13:49:13.76489	220
221	2023-05-09 13:49:13.769991	221
222	2023-05-09 15:04:49.931963	222
223	2023-05-09 15:16:48.831369	223
224	2023-05-09 16:46:23.502065	224
225	2023-05-09 16:46:26.96363	225
226	2023-05-09 17:07:02.733351	226
227	2023-05-09 17:22:09.726299	227
228	2023-05-09 17:22:11.26224	228
229	2023-05-09 17:27:11.589357	229
230	2023-05-09 17:32:16.267472	230
231	2023-05-09 17:32:16.284176	231
232	2023-05-09 17:37:18.733197	232
233	2023-05-09 18:10:59.992661	233
234	2023-05-09 18:51:16.776983	234
235	2023-05-09 19:01:21.287367	235
236	2023-05-10 14:57:41.012852	236
237	2023-05-10 14:57:41.019746	237
238	2023-05-10 14:57:42.50821	238
239	2023-05-10 14:57:42.515865	239
240	2023-05-10 15:22:53.996938	240
241	2023-05-10 15:53:05.517366	241
242	2023-05-10 17:18:47.189946	242
243	2023-05-10 17:28:52.469328	243
244	2023-05-10 17:28:54.861509	244
245	2023-05-10 18:48:53.887963	245
246	2023-05-10 18:48:53.897913	246
247	2023-05-10 18:48:55.726606	247
248	2023-05-10 18:48:55.743145	248
249	2023-05-10 18:48:55.754251	249
250	2023-05-10 19:24:19.175229	250
251	2023-05-10 19:24:19.190633	251
252	2023-05-10 19:44:51.740664	252
253	2023-05-10 21:10:26.442769	253
254	2023-05-10 21:25:32.373933	254
255	2023-05-10 21:25:34.092066	255
256	2023-05-10 22:25:58.279606	256
257	2023-05-10 22:41:04.294994	257
258	2023-05-10 22:41:04.301523	258
259	2023-05-10 23:06:19.608347	259
260	2023-05-10 23:11:21.568907	260
261	2023-05-11 13:51:13.360382	261
262	2023-05-11 13:51:13.367023	262
263	2023-05-11 13:51:13.371372	263
264	2023-05-18 13:32:08.930844	264
265	2023-05-18 13:32:08.939023	265
266	2023-05-18 13:32:08.944241	266
267	2023-05-18 15:33:51.874253	267
268	2023-05-18 15:38:55.649406	268
269	2023-05-18 16:14:09.051573	269
270	2023-05-18 16:19:10.721452	270
271	2023-05-18 16:49:21.817471	271
272	2023-05-18 18:19:55.291721	272
273	2023-05-18 19:05:12.224133	273
274	2023-05-18 19:05:12.232438	274
275	2023-05-18 19:40:29.312558	275
276	2023-05-18 20:20:42.556448	276
277	2023-05-18 21:59:35.285714	277
278	2023-05-18 23:10:02.754558	278
279	2023-05-19 05:01:19.66355	279
280	2023-05-19 05:30:25.808094	280
281	2023-05-19 05:43:51.06353	281
282	2023-05-19 15:16:10.622813	282
283	2023-05-19 15:16:10.629993	283
284	2023-05-19 15:16:10.636415	284
285	2023-05-19 15:16:10.643339	285
286	2023-05-19 15:16:16.872966	286
287	2023-05-19 15:41:27.49194	287
288	2023-05-19 15:41:29.318664	288
289	2023-05-19 16:20:04.445653	289
290	2023-05-19 16:20:04.464967	290
291	2023-05-20 00:31:22.181915	291
292	2023-05-20 00:31:24.684992	292
293	2023-05-20 01:44:56.47136	293
294	2023-05-20 11:14:26.918809	294
295	2023-05-20 11:14:28.721892	295
296	2023-05-20 11:55:29.84773	296
297	2023-05-20 12:35:47.296224	297
298	2023-05-20 12:50:52.80042	298
299	2023-05-20 13:16:04.022125	299
300	2023-05-20 13:46:16.375074	300
301	2023-05-20 13:51:16.597427	301
302	2023-05-20 13:51:16.600227	302
303	2023-05-20 13:51:18.646845	303
304	2023-05-20 13:56:20.703073	304
305	2023-05-20 14:01:20.905072	305
306	2023-05-20 14:21:30.783017	306
307	2023-05-20 14:21:30.787108	307
308	2023-05-20 15:57:11.702258	308
309	2023-05-20 16:22:20.948148	309
310	2023-05-20 16:37:24.521053	310
311	2023-05-20 16:42:26.362232	311
312	2023-05-20 16:42:27.952318	312
313	2023-05-20 17:12:39.044939	313
314	2023-05-20 17:32:47.086727	314
315	2023-05-20 19:23:27.543543	315
316	2023-05-20 20:18:48.716789	316
317	2023-05-20 20:28:53.789259	317
318	2023-05-22 11:40:56.406525	318
319	2023-05-22 11:40:56.412851	319
320	2023-05-22 11:45:58.341727	320
321	2023-05-22 12:11:07.216931	321
322	2023-05-22 12:26:12.369059	322
323	2023-05-22 12:36:17.861145	323
324	2023-05-22 12:51:24.180475	324
325	2023-05-22 12:56:25.880953	325
\.


--
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: ps3r
--

COPY public.tickets (id, user_id, bet_id, bid, value, status) FROM stdin;
1	1	1	t	300	opened
2	2	1	f	200	opened
3	1	2	t	3100	opened
4	2	3	f	200	opened
5	2	2	t	300	opened
6	2	6	t	300	opened
7	2	4	t	300	opened
8	3	1	t	204	opened
9	4	2	t	2000	opened
10	5	2	t	500	opened
11	6	3	t	1000	opened
12	2	8	f	200	opened
13	2	10	t	500	opened
14	9	12	t	300	opened
15	9	10	f	200	opened
16	1	12	t	200	opened
17	2	12	t	200	opened
18	2	13	f	200	opened
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: ps3r
--

COPY public.users (id, username, email, password, account_balance) FROM stdin;
3	Alexandre	test@test.fr	$2a$10$ll5WsoBowsSuIvCxNT5d2OlWgD0BK2Z4JMGpUJpgxCR7FvnB17Et.	2796
4	DanielBG	simadaniel@hotmail.com	$2a$10$EzV4.8i2y3IcO4h67sfzeu8H0LE6wp36AE04vZdwcLJGYqtvRZRu2	1000
5	NOS	imp63871@nezid.com	$2a$10$KGXzBa3TotLuOXuM8OaT2eah5HUUqT1647VCSq04e9D6UlnOio19m	3100
7	жопа	cji01836@iencm.com	$2a$10$1g3z.pQniwgNOaGO9LGCgORey3vMqfeJ9uKiPfyHSIZiujziK1Hdu	3000
6	Georgette_Stroman69	your.email+fakedata16953@gmail.com	$2a$10$tm6qgATXa8zEqA07/Ny5LeL1f1cULyU5JZipOfaWrKK8PfnMx8kwS	2200
8	Wacombot	wacimbot@gmail.com	$2a$10$cpPHdm4GyQeK/NfeHxFxbeI2Dei3qoM1ekPfp.gyct716yLaTFVuq	3200
9	Arthuroo1	apendelliou@hotmail.fr	$2a$10$/4UIkdRf..LDdq/yiH9TKeCFZ2A6G13b.CxwbQ9mO9Oe4eG0asENi	2700
2	Skullriver	test@test.ru	$2a$10$rPL7w/5EbIUCr3ibqhptGuTogueMwsxSMLJzS0UgiCBTV.2nFN8fa	1400
10	Alina	test2@test.ru	$2a$10$olKqyTw.qTXQk/d7CYDkBuu3CH8hUDXv6EycMXfauRmrcCaqIiigq	3200
1	LeDiable	amori.c2302@yahoo.fr	$2a$10$6vaWVQpqrf014jB.ubvYfubjuSViAvftq16qMUnzXORpil98Bw8Ym	200
\.


--
-- Name: bet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ps3r
--

SELECT pg_catalog.setval('public.bet_id_seq', 15, true);


--
-- Name: disruptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ps3r
--

SELECT pg_catalog.setval('public.disruptions_id_seq', 325, true);


--
-- Name: lines_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ps3r
--

SELECT pg_catalog.setval('public.lines_id_seq', 21, true);


--
-- Name: log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ps3r
--

SELECT pg_catalog.setval('public.log_id_seq', 325, true);


--
-- Name: tickets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ps3r
--

SELECT pg_catalog.setval('public.tickets_id_seq', 18, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ps3r
--

SELECT pg_catalog.setval('public.users_id_seq', 10, true);


--
-- Name: bets bet_pkey; Type: CONSTRAINT; Schema: public; Owner: ps3r
--

ALTER TABLE ONLY public.bets
    ADD CONSTRAINT bet_pkey PRIMARY KEY (id);


--
-- Name: bet_type1 bet_type1_pkey; Type: CONSTRAINT; Schema: public; Owner: ps3r
--

ALTER TABLE ONLY public.bet_type1
    ADD CONSTRAINT bet_type1_pkey PRIMARY KEY (id);


--
-- Name: bet_type2 bet_type2_pkey; Type: CONSTRAINT; Schema: public; Owner: ps3r
--

ALTER TABLE ONLY public.bet_type2
    ADD CONSTRAINT bet_type2_pkey PRIMARY KEY (id);


--
-- Name: bet_type3 bet_type3_pkey; Type: CONSTRAINT; Schema: public; Owner: ps3r
--

ALTER TABLE ONLY public.bet_type3
    ADD CONSTRAINT bet_type3_pkey PRIMARY KEY (id);


--
-- Name: disruptions disruptions_pkey; Type: CONSTRAINT; Schema: public; Owner: ps3r
--

ALTER TABLE ONLY public.disruptions
    ADD CONSTRAINT disruptions_pkey PRIMARY KEY (id);


--
-- Name: lines lines_pkey; Type: CONSTRAINT; Schema: public; Owner: ps3r
--

ALTER TABLE ONLY public.lines
    ADD CONSTRAINT lines_pkey PRIMARY KEY (id);


--
-- Name: log log_pkey; Type: CONSTRAINT; Schema: public; Owner: ps3r
--

ALTER TABLE ONLY public.log
    ADD CONSTRAINT log_pkey PRIMARY KEY (id);


--
-- Name: tickets tickets_pk; Type: CONSTRAINT; Schema: public; Owner: ps3r
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pk PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: ps3r
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: bets bet_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: ps3r
--

ALTER TABLE ONLY public.bets
    ADD CONSTRAINT bet_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: bet_type1 fk_bet_type1_id; Type: FK CONSTRAINT; Schema: public; Owner: ps3r
--

ALTER TABLE ONLY public.bet_type1
    ADD CONSTRAINT fk_bet_type1_id FOREIGN KEY (id) REFERENCES public.bets(id) ON DELETE CASCADE;


--
-- Name: bet_type2 fk_bet_type2_id; Type: FK CONSTRAINT; Schema: public; Owner: ps3r
--

ALTER TABLE ONLY public.bet_type2
    ADD CONSTRAINT fk_bet_type2_id FOREIGN KEY (id) REFERENCES public.bets(id) ON DELETE CASCADE;


--
-- Name: bet_type3 fk_bet_type3_id; Type: FK CONSTRAINT; Schema: public; Owner: ps3r
--

ALTER TABLE ONLY public.bet_type3
    ADD CONSTRAINT fk_bet_type3_id FOREIGN KEY (id) REFERENCES public.bets(id) ON DELETE CASCADE;


--
-- Name: tickets tickets__bet_fk; Type: FK CONSTRAINT; Schema: public; Owner: ps3r
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets__bet_fk FOREIGN KEY (bet_id) REFERENCES public.bets(id) ON DELETE CASCADE;


--
-- Name: tickets tickets__user_fk; Type: FK CONSTRAINT; Schema: public; Owner: ps3r
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets__user_fk FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

