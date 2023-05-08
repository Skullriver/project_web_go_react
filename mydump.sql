--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2 (Ubuntu 15.2-1.pgdg20.04+1)
-- Dumped by pg_dump version 15.2 (Ubuntu 15.2-1.pgdg20.04+1)

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
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: ps3r
--

COPY public.users (id, username, email, password, account_balance) FROM stdin;
\.


--
-- Name: disruptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ps3r
--

SELECT pg_catalog.setval('public.disruptions_id_seq', 178, true);


--
-- Name: lines_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ps3r
--

SELECT pg_catalog.setval('public.lines_id_seq', 21, true);


--
-- Name: log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ps3r
--

SELECT pg_catalog.setval('public.log_id_seq', 178, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ps3r
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


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
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: ps3r
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

