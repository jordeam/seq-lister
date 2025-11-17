--
-- PostgreSQL database dump
--

-- Dumped from database version 11.14 (Debian 11.14-0+deb10u1)
-- Dumped by pg_dump version 11.14 (Debian 11.14-0+deb10u1)

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
-- Name: lister; Type: DATABASE; Schema: -; Owner: jrm
--

CREATE DATABASE lister WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE lister OWNER TO jrm;

\connect lister

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

SET default_with_oids = false;

--
-- Name: assemblies; Type: TABLE; Schema: public; Owner: jrm
--

CREATE TABLE public.assemblies (
    name text DEFAULT ''::text,
    note text DEFAULT ''::text,
    id integer DEFAULT nextval(('"assemblies_id_seq"'::text)::regclass) NOT NULL,
    location_id integer DEFAULT 0,
    group_id integer DEFAULT 0,
    proceedings text DEFAULT ''::text
);


ALTER TABLE public.assemblies OWNER TO jrm;

--
-- Name: assemblies_id_seq; Type: SEQUENCE; Schema: public; Owner: jrm
--

CREATE SEQUENCE public.assemblies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assemblies_id_seq OWNER TO jrm;

--
-- Name: cases; Type: TABLE; Schema: public; Owner: jrm
--

CREATE TABLE public.cases (
    id integer NOT NULL,
    name text DEFAULT ''::text,
    descr text DEFAULT ''::text
);


ALTER TABLE public.cases OWNER TO jrm;

--
-- Name: cases_id_seq; Type: SEQUENCE; Schema: public; Owner: jrm
--

CREATE SEQUENCE public.cases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cases_id_seq OWNER TO jrm;

--
-- Name: cases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jrm
--

ALTER SEQUENCE public.cases_id_seq OWNED BY public.cases.id;


--
-- Name: components; Type: TABLE; Schema: public; Owner: jrm
--

CREATE TABLE public.components (
    name text DEFAULT ''::text,
    group_id integer DEFAULT 0,
    id integer DEFAULT nextval(('"components_id_seq"'::text)::regclass) NOT NULL,
    case_id integer DEFAULT 0
);


ALTER TABLE public.components OWNER TO jrm;

--
-- Name: components_id_seq; Type: SEQUENCE; Schema: public; Owner: jrm
--

CREATE SEQUENCE public.components_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.components_id_seq OWNER TO jrm;

--
-- Name: currencies; Type: TABLE; Schema: public; Owner: jrm
--

CREATE TABLE public.currencies (
    id integer DEFAULT nextval(('"currencies_id_seq"'::text)::regclass) NOT NULL,
    name text DEFAULT ''::text,
    symbol text DEFAULT ''::text,
    rate double precision DEFAULT 0
);


ALTER TABLE public.currencies OWNER TO jrm;

--
-- Name: currencies_id_seq; Type: SEQUENCE; Schema: public; Owner: jrm
--

CREATE SEQUENCE public.currencies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.currencies_id_seq OWNER TO jrm;

--
-- Name: groups; Type: TABLE; Schema: public; Owner: jrm
--

CREATE TABLE public.groups (
    name text DEFAULT ''::text,
    id integer DEFAULT nextval(('"groups_id_seq"'::text)::regclass) NOT NULL,
    supergroup_id integer DEFAULT 0
);


ALTER TABLE public.groups OWNER TO jrm;

--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: jrm
--

CREATE SEQUENCE public.groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.groups_id_seq OWNER TO jrm;

--
-- Name: labels; Type: TABLE; Schema: public; Owner: jrm
--

CREATE TABLE public.labels (
    id integer NOT NULL,
    location_entry_id integer DEFAULT 0,
    box integer DEFAULT 0,
    user_id integer DEFAULT 0
);


ALTER TABLE public.labels OWNER TO jrm;

--
-- Name: labels_id_seq; Type: SEQUENCE; Schema: public; Owner: jrm
--

CREATE SEQUENCE public.labels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.labels_id_seq OWNER TO jrm;

--
-- Name: labels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jrm
--

ALTER SEQUENCE public.labels_id_seq OWNED BY public.labels.id;


--
-- Name: listing; Type: TABLE; Schema: public; Owner: jrm
--

CREATE TABLE public.listing (
    id integer NOT NULL,
    component_id integer DEFAULT 0,
    quant integer DEFAULT 0
);


ALTER TABLE public.listing OWNER TO jrm;

--
-- Name: listing_id_seq; Type: SEQUENCE; Schema: public; Owner: jrm
--

CREATE SEQUENCE public.listing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.listing_id_seq OWNER TO jrm;

--
-- Name: listing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jrm
--

ALTER SEQUENCE public.listing_id_seq OWNED BY public.listing.id;


--
-- Name: location_entry; Type: TABLE; Schema: public; Owner: jrm
--

CREATE TABLE public.location_entry (
    id integer NOT NULL,
    location_id integer DEFAULT 0,
    component_id integer DEFAULT 0,
    quant_unit integer DEFAULT 0,
    quant_min integer DEFAULT 0,
    quant integer DEFAULT 0,
    labels text DEFAULT ''::text,
    box integer DEFAULT 1,
    supcode_id integer DEFAULT '-1'::integer NOT NULL
);


ALTER TABLE public.location_entry OWNER TO jrm;

--
-- Name: location_entry_id_seq; Type: SEQUENCE; Schema: public; Owner: jrm
--

CREATE SEQUENCE public.location_entry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.location_entry_id_seq OWNER TO jrm;

--
-- Name: location_entry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jrm
--

ALTER SEQUENCE public.location_entry_id_seq OWNED BY public.location_entry.id;


--
-- Name: location_id_seq; Type: SEQUENCE; Schema: public; Owner: jrm
--

CREATE SEQUENCE public.location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.location_id_seq OWNER TO jrm;

--
-- Name: locations; Type: TABLE; Schema: public; Owner: jrm
--

CREATE TABLE public.locations (
    id integer DEFAULT nextval(('"location_id_seq"'::text)::regclass) NOT NULL,
    name text DEFAULT ''::text,
    note text DEFAULT ''::text,
    nbox integer DEFAULT 1,
    quant integer DEFAULT 0 NOT NULL,
    bom text DEFAULT ''::text NOT NULL,
    active boolean DEFAULT false NOT NULL
);


ALTER TABLE public.locations OWNER TO jrm;

--
-- Name: manufacturers; Type: TABLE; Schema: public; Owner: jrm
--

CREATE TABLE public.manufacturers (
    id integer NOT NULL,
    name text DEFAULT ''::text,
    descr text DEFAULT ''::text,
    web text DEFAULT ''::text
);


ALTER TABLE public.manufacturers OWNER TO jrm;

--
-- Name: manufacturers_id_seq; Type: SEQUENCE; Schema: public; Owner: jrm
--

CREATE SEQUENCE public.manufacturers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.manufacturers_id_seq OWNER TO jrm;

--
-- Name: manufacturers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jrm
--

ALTER SEQUENCE public.manufacturers_id_seq OWNED BY public.manufacturers.id;


--
-- Name: quotes; Type: TABLE; Schema: public; Owner: jrm
--

CREATE TABLE public.quotes (
    id integer DEFAULT nextval(('"quotes_id_seq"'::text)::regclass) NOT NULL,
    shop_id integer DEFAULT 0,
    component_id integer DEFAULT 0,
    deprecated integer DEFAULT 0,
    quantity double precision DEFAULT 0,
    price double precision DEFAULT 0,
    currency_id integer DEFAULT 0,
    tax double precision DEFAULT 0
);


ALTER TABLE public.quotes OWNER TO jrm;

--
-- Name: quotes_id_seq; Type: SEQUENCE; Schema: public; Owner: jrm
--

CREATE SEQUENCE public.quotes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quotes_id_seq OWNER TO jrm;

--
-- Name: relassemblies; Type: TABLE; Schema: public; Owner: jrm
--

CREATE TABLE public.relassemblies (
    id integer DEFAULT nextval(('"relassemblies_id_seq"'::text)::regclass) NOT NULL,
    assembly_id integer DEFAULT 0,
    inner_assembly_id integer DEFAULT 0,
    component_id integer DEFAULT 0,
    quant double precision DEFAULT 0
);


ALTER TABLE public.relassemblies OWNER TO jrm;

--
-- Name: relassemblies_id_seq; Type: SEQUENCE; Schema: public; Owner: jrm
--

CREATE SEQUENCE public.relassemblies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.relassemblies_id_seq OWNER TO jrm;

--
-- Name: shops; Type: TABLE; Schema: public; Owner: jrm
--

CREATE TABLE public.shops (
    id integer DEFAULT nextval(('"shops_id_seq"'::text)::regclass) NOT NULL,
    supplier_id integer DEFAULT 0,
    shoptype integer DEFAULT 0,
    theday date DEFAULT '2005-03-16'::date,
    extra_cost double precision DEFAULT 0,
    components_cost double precision DEFAULT 0,
    delivery_cost double precision DEFAULT 0
);


ALTER TABLE public.shops OWNER TO jrm;

--
-- Name: shops_id_seq; Type: SEQUENCE; Schema: public; Owner: jrm
--

CREATE SEQUENCE public.shops_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shops_id_seq OWNER TO jrm;

--
-- Name: supergroups; Type: TABLE; Schema: public; Owner: jrm
--

CREATE TABLE public.supergroups (
    name text DEFAULT ''::text,
    id integer DEFAULT nextval(('"supergroups_id_seq"'::text)::regclass) NOT NULL
);


ALTER TABLE public.supergroups OWNER TO jrm;

--
-- Name: supergroups_id_seq; Type: SEQUENCE; Schema: public; Owner: jrm
--

CREATE SEQUENCE public.supergroups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.supergroups_id_seq OWNER TO jrm;

--
-- Name: suppliercodes; Type: TABLE; Schema: public; Owner: jrm
--

CREATE TABLE public.suppliercodes (
    supplier_id integer DEFAULT 1,
    component_id integer DEFAULT 0,
    ordercode text DEFAULT ''::text,
    rounding integer DEFAULT 1,
    id integer NOT NULL,
    partnumber text DEFAULT ''::text,
    manufact_id integer DEFAULT 1,
    price double precision DEFAULT 0,
    tax double precision DEFAULT 0,
    descr text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.suppliercodes OWNER TO jrm;

--
-- Name: suppliercodes_id_seq; Type: SEQUENCE; Schema: public; Owner: jrm
--

CREATE SEQUENCE public.suppliercodes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.suppliercodes_id_seq OWNER TO jrm;

--
-- Name: suppliercodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jrm
--

ALTER SEQUENCE public.suppliercodes_id_seq OWNED BY public.suppliercodes.id;


--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: jrm
--

CREATE TABLE public.suppliers (
    id integer DEFAULT nextval(('"suppliers_id_seq"'::text)::regclass) NOT NULL,
    name text DEFAULT ''::text,
    legalname text DEFAULT ''::text,
    federal_code text DEFAULT ''::text,
    state_code text DEFAULT ''::text,
    city_code text DEFAULT ''::text,
    phone text DEFAULT ''::text,
    fax text DEFAULT ''::text
);


ALTER TABLE public.suppliers OWNER TO jrm;

--
-- Name: suppliers_id_seq; Type: SEQUENCE; Schema: public; Owner: jrm
--

CREATE SEQUENCE public.suppliers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.suppliers_id_seq OWNER TO jrm;

--
-- Name: usernavs; Type: TABLE; Schema: public; Owner: jrm
--

CREATE TABLE public.usernavs (
    id integer NOT NULL,
    group_id integer DEFAULT 0,
    location_id integer DEFAULT 0
);


ALTER TABLE public.usernavs OWNER TO jrm;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: jrm
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO jrm;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jrm
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.usernavs.id;


--
-- Name: cases id; Type: DEFAULT; Schema: public; Owner: jrm
--

ALTER TABLE ONLY public.cases ALTER COLUMN id SET DEFAULT nextval('public.cases_id_seq'::regclass);


--
-- Name: labels id; Type: DEFAULT; Schema: public; Owner: jrm
--

ALTER TABLE ONLY public.labels ALTER COLUMN id SET DEFAULT nextval('public.labels_id_seq'::regclass);


--
-- Name: listing id; Type: DEFAULT; Schema: public; Owner: jrm
--

ALTER TABLE ONLY public.listing ALTER COLUMN id SET DEFAULT nextval('public.listing_id_seq'::regclass);


--
-- Name: location_entry id; Type: DEFAULT; Schema: public; Owner: jrm
--

ALTER TABLE ONLY public.location_entry ALTER COLUMN id SET DEFAULT nextval('public.location_entry_id_seq'::regclass);


--
-- Name: manufacturers id; Type: DEFAULT; Schema: public; Owner: jrm
--

ALTER TABLE ONLY public.manufacturers ALTER COLUMN id SET DEFAULT nextval('public.manufacturers_id_seq'::regclass);


--
-- Name: suppliercodes id; Type: DEFAULT; Schema: public; Owner: jrm
--

ALTER TABLE ONLY public.suppliercodes ALTER COLUMN id SET DEFAULT nextval('public.suppliercodes_id_seq'::regclass);


--
-- Name: usernavs id; Type: DEFAULT; Schema: public; Owner: jrm
--

ALTER TABLE ONLY public.usernavs ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: assemblies; Type: TABLE DATA; Schema: public; Owner: jrm
--

COPY public.assemblies (name, note, id, location_id, group_id, proceedings) FROM stdin;
JTAG-MSP	Programador Padrão Autsens	21	0	113	\N
CDD-1	Coletor de dados para o SIMAD-Logger	65	0	114	Falta conector para CFDISK, da Farnell e CFDISK.
ALDT-2-CH	Chassis p/ Placa detectora de Laços do Tupã	40	0	113	\N
ASH-4F	Sensor de umidade relativa com saída 4 a 20mA	15	0	113	\N
AM-1	Abrigo Meteorológico para Sensores AS	59	0	148	Cortar a barra roscada em pedaços de 180mm
ASHT-6-r1	Placa de CI revisão 1 para montagem do sensor ASHT-6	60	0	113	\N
ASHT-5A	 Sensor de Umidade Relativa e Temperatura com saída RS 232	28	0	113	\N
ASHT-5B	 Sensor de Umidade Relativa e Temperatura com saída RS 485	27	0	113	\N
ASST2	Autsens Serial Switcher Tupa	19	0	113	\N
AST-4F	Sensor de temperatura com saída 4 a 20mA	16	0	113	\N
Brain	Placa padrão com MSP430F149	32	0	113	\N
MOD-A	Placa antiga SIMAD1	1	0	113	\N
RSH-4	 Sensor de umidade relativa com saída 4 a 20mA Disco	37	0	113	\N
RSH-5B	Sensor de humidade com interface RS485 Disco	5	0	113	\N
RSHT-4	 Sensor de umidade relativa e temperatura com saída 4 a 20mA Disco	36	0	113	\N
RSHT-5A	Sensor de umidade relativa com saída RS232	13	0	113	\N
RSHT-5B	Sensor de umidade e temperatura com interface RS485 Disco	11	0	113	\N
WDin	Circuito de Watch Dog para controle de Relé	29	0	113	\N
MDC-1	Conversor RS232/RS485	8	0	114	\N
Arbiter	Placa de sincronismo do sistema de detecção laser	30	0	119	\N
LaserCon2	Driver do laser 1W	20	0	119	\N
LaserCon2-Montagem	Driver do laser 1W - Montagem	31	0	119	\N
LaserCon-Gamb	Correção da lasercon	38	0	119	\N
Receptor	Placa de detecção do laser - Projeto Simulador	14	0	119	\N
CDS-2525	Condicionador de sinais de -25 a 25mV para 4 a 20mA	72	0	146	
ASH-4	Sensor de umidade relativa com compensação e saída 4 a 20mA	51	0	145	\N
ASHT-4	Sensor de umidade relativa e temperatura com compensação e saída 4 a 20mA	50	0	145	\N
AST-4	Sensor de temperatura e Saída 4 a 20mA	52	0	145	\N
ASU-4	Sensor de umidade relativa sem compensação e saída 4 a 20mA	53	0	145	\N
ASUT-4	Sensor de umidade relativa e tempeartura sem compensação e saída 4 a 20mA	54	0	145	\N
CCAT		48	0	147	\N
AST-6	Sensor de temperatutra com saída RS485	58	0	145	\N
AST-5	Sensor de temperatura com saída RS232	56	0	145	\N
ASHT-5	 Sensor de umidade relativa e temperatura com compensação e saída RS232	55	0	145	\N
ASHT-6	 Sensor de umidade relativa e temperatura com compensação e saída RS485	57	0	145	\N
CDS-0010	Condicionador de sinais de 0 a 10mV para 4 a 20mA	71	0	146	
CDS-J	Condicionador de sinais para termopar tipo J	66	0	146	
SMF-1	Sensor de molhamento foliar	67	0	145	
CDS-T	Condicionador de sinais para termopar tipo T	73	0	146	
ACD-1	Adaptador para contadores digitais do SIMAD-Logger	68	0	157	
ALDT-2	Placa detectora de Laços do Tupã	39	0	113	\N
Sensor RS	Involucro sensores série RS	18	0	149	\N
PMM-2	Psicrômetro Ventilado (bulbo seco, bulbo úmido)	70	0	145	
TD-B-r1	Teclado, relês e LEDs do SIMAD2	74	0	113	=> SEP6, SEP7, SEP 8 E SEP9: Todos estes jumpers devem ser soldados;\r\n\r\n=> Verificar: SEP1, SEP2,  SEP3, SEP4 e SEP5.
SIMAD-Logger	Sistema de aquisição de dados com 8 entradas analógicas, duas digitais e 4 saídas de relê	64	0	147	Parafusos:\r\n Tomada: M3x10, arruela, porca\r\n Display: M2x6\r\n Carcaça: M3x5\r\n Placa Teclado: M3x5\r\n Placa Principal: M2x6\r\n Placa Bateria: M3x12, arruela plastica, espaçador(+cola), porca\r\n Lateral fixação: M3x10\r\n Fechar: M3x10
BATT-1-r1	Placa para gerar tensões do SIMAD-Logger, inclusive a tensão negativa	76	0	113	Valor da indutância de 95uH\r\nVerificar se TPS76750QD é compatível com TPS76850QD\r\nFalta um TIP29 em paralelo com o TPS76850 por problemas de potência máxima dissipada pelo TPS76750QD\r\n\r\nBill of Material for C:\\PRO\\Fontes\\batt1.Sch\r\n\r\nUsed Part Type  Designator           Footprint          Description                    \r\n==== ========== ==================== ================== ============================== \r\n14   100nF      C10 C11 C12 C13 C14  0805               CAPACITOR CERAMICO MULTICAMADA \r\n                C2 C21 C3 C4 C5 C6                                                     \r\n                C7 C8 C9                                                               \r\n1    10M        R15                  RES400             RESISTOR                       \r\n1    10nF       C22                  CAP400             CAPACITOR CERAMICO MULTICAMADA \r\n2    10uF/16V   C17 C18              CE100/100          CAPACITOR DE TANTALO           \r\n1    12K        R6                   0805               RESISTOR                       \r\n1    12R        R4                   0805               RESISTOR                       \r\n1    15K        R13                  0805               RESISTOR                       \r\n1    16V/1W     Z1                   D400               DIODO ZENER                    \r\n1    18K        R10                  0805               RESISTOR                       \r\n3    1N4007     D4 D5 D6             D400               DIODO                          \r\n2    1N4148     D2 D3                1206P              DIODO                          \r\n1    1N5818     D1                   D400               DIODO                          \r\n1    1R8/1W     R5                   RES400             RESISTOR                       \r\n1    220K       R14                  0805               RESISTOR                       \r\n1    22uF/6.3V  C19                  CE100/100          CAPACITOR DE TANTALO           \r\n1    270R/0.5W  R12                  RES400             RESISTOR                       \r\n2    27K        R7 R8                0805               RESISTOR                       \r\n1    330pF      C1                   CAP200             CAPACITOR CERAMICO MULTICAMADA \r\n1    40109-B    U6                   DIP16                                             \r\n1    47K        R1                   0805               RESISTOR                       \r\n2    47uF/16V   C15 C16              CE200/100          CAPACITOR DE TANTALO           \r\n1    51K        R11                  0805               RESISTOR                       \r\n1    56K        R9                   0805               RESISTOR                       \r\n2    680R       R2 R3                0805               RESISTOR                       \r\n1    95uH       L1                   TRAFO-CE-20/10/5-1                                \r\n1    BC337-16   Q1                   SOT-54B                                           \r\n1    BC847      Q6                   SOT-23             TRANSISTOR DE USO GERAL SMD    \r\n1    BC857      Q3                   SOT-23             TRANSISTOR DE USO GERAL SMD    \r\n10   FB         FB1 FB10 FB2 FB3 FB4 FB300              FERRITE BEAD                   \r\n                FB5 FB6 FB7 FB8 FB9                                                    \r\n1    FUSE       F1                   FUSE-250V-2        FUSIVEL                        \r\n1    HEADER 2   JP8                  HEADER 2                                          \r\n4    HEADER 3   JP2 JP3 JP4 JP5      HEADER 3                                          \r\n1    HEADER 4   JP6                  HEADER 4                                          \r\n1    LED        LD1                  LED5MM             LED                            \r\n2    MC14049UBD U2 U3                SO-16              CIRCUITO INTEGRADO             \r\n1    MC14093BD  U1                   SO-14              CICUITO INTEGRADO              \r\n1    MOLEX-B-2  JP1                  MOLEX-B-2                                         \r\n1    MOLEX-B-5  JP7                  MOLEX-B-5                                         \r\n1    NC         C20                  0805               CAPACITOR CERAMICO MULTICAMADA \r\n2    NETSEP     SEP1 SEP2            0805               SEPARADOR DE NÓS               \r\n2    RFD8P05    Q2 Q4                TO-251AA           TRANSFISTOR MOSFET             \r\n1    TL061      U4                   DIP8               AMPLIFICADOR OPERACIONAL       \r\n1    TPS76850QD U5                   SO-8               LDO VOLTAGE REGULATOR          \r\n\r\n
MOD-B2-r1	Placa principal do SIMAD-Logger	3	0	113	Verificar o TPS77033DBVR no lugar do TPS76033DBVR.\r\n\r\nBill of Material for C:\\PRO\\tarta\\MOD-B2.Sch\r\n\r\nUsed Part Type                       Designator           Footprint      Description                    \r\n==== =============================== ==================== ============== ============================== \r\n9    0R0                             SEP1 SEP2 SEP3 SEP4  0805           SEPARADOR DE NÓS               \r\n                                     SEP5 SEP6 SEP7 SEP8                                                \r\n                                     SEP9                                                               \r\n2    100K                            R61 R71              0805           RESISTOR                       \r\n23   100nF                           C10 C12 C13 C15 C16  0805           CAPACITOR CERAMICO MULTICAMADA \r\n                                     C17 C3 C32 C33 C34                                                 \r\n                                     C35 C36 C39 C4 C40                                                 \r\n                                     C41 C44 C46 C5 C6 C7                                               \r\n                                     C8 C9                                                              \r\n3    10K                             R50 R72 R8           0805           RESISTOR                       \r\n3    10M                             R93 R94 R95          RES400         RESISTOR                       \r\n3    10nF                            C42 C43 C45          CAP400         CAPACITOR CERAMICO MULTICAMADA \r\n4    10uF                            C24 C25 C26 C27      CE100          CAPACITOR ELETROLITICO         \r\n3    10uF/16V                        C18 C19 C37          CE100          CAPACITOR DE TANTALO           \r\n4    12pF                            C28 C29 C30 C31      0805           CAPACITOR CERAMICO MULTICAMADA \r\n2    12V/1W                          Z10 Z9               D350           DIODO ZENER                    \r\n1    130R                            R91                  1206           RESISTOR                       \r\n8    1K                              R100 R11 R12 R13 R20 0805           RESISTOR                       \r\n                                     R21 R23 R5                                                         \r\n17   1K/0.1%                         R31 R40 R41 R42 R43  1206           RESISTOR                       \r\n                                     R44 R45 R46 R47 R73                                                \r\n                                     R74 R75 R76 R77 R78                                                \r\n                                     R79 R80                                                            \r\n4    1K2                             R101 R102 R59 R60    0805           RESISTOR                       \r\n1    1K5                             R92                  0805           RESISTOR                       \r\n6    1N4148                          D1 D2 D3 D4 D5 D6    D300           DIODO                          \r\n1    1nF                             C38                  CAP200         CAPACITOR CERAMICO MULTICAMADA \r\n2    1uF                             C11 C14              CE100          CAPACITOR DE TANTALO           \r\n4    2.2uF                           C1 C2 C22 C23        CE100/100      CAPACITOR DE TANTALO           \r\n2    2.2uF/16V                       C20 C21              CE200/100      CAPACITOR DE TANTALO           \r\n8    200K                            R103 R104 R105 R106  0805           RESISTOR                       \r\n                                     R107 R108 R109 R110                                                \r\n1    220R                            R10                  0805           RESISTOR                       \r\n8    22K                             R34 R36 R38 R53 R55  0805           RESISTOR                       \r\n                                     R56 R57 R58                                                        \r\n8    27R                             R15 R16 R17 R25 R27  0805           RESISTOR                       \r\n                                     R28 R30 R32                                                        \r\n2    2K2                             R52 R9               0805           RESISTOR                       \r\n1    2N2222                          Q4                   TO-18-B        TRANSISTOR                     \r\n1    32kHz                           XT2                  XTAL-V         CRISTAL OSCILADOR              \r\n1    330K                            R62                  0805           RESISTOR                       \r\n1    330R                            R14                  0805           RESISTOR                       \r\n8    3V9/400mW                       Z1 Z2 Z3 Z4 Z5 Z6 Z7 SOD80C         DIODO ZENER                    \r\n                                     Z8                                                                 \r\n1    47R/1W                          R99                  RES400         RESISTOR                       \r\n5    4K7                             R51 R54 R6 R7 R98    0805           RESISTOR                       \r\n1    4MHz                            XT1                  XTAL-V         CRISTAL OSCILADOR              \r\n2    4N25                            ISO4 ISO5            DIP6           FOTOACOPLADOR                  \r\n15   510R/0.1%                       R24 R26 R29 R33 R35  1206           RESISTOR                       \r\n                                     R37 R39 R63 R64 R65                                                \r\n                                     R66 R67 R68 R69 R70                                                \r\n8    51R/0.1%                        R81 R82 R83 R84 R85  1206           RESISTOR                       \r\n                                     R86 R87 R88                                                        \r\n9    680R                            R1 R18 R19 R2 R22 R3 0805           RESISTOR                       \r\n                                     R4 R48 R49                                                         \r\n3    6N137                           ISO1 ISO2 ISO3       DIP8           OPTO ACOPLADOR                 \r\n2    6N137-AS                        U15 U16              DIP8           OPTO ACOPLADOR                 \r\n2    6V2/1W                          Z11 Z12              D350           DIODO ZENER                    \r\n1    74HC541                         U10                  SOL-20         OCTAL BUF AND LINE DRV 3SO     \r\n1    74HCT541-V                      U23                  SOL-20         OCTAL BUF AND LINE DRV 3SO     \r\n3    74HCT574-V                      U11 U12 U13          SOL-20         OCTAL LATCH D                  \r\n2    750R                            R89 R90              1206           RESISTOR                       \r\n1    AT45DB161B-RI                   U24                  SOIC28         FLASH SERIAL                   \r\n2    BC807-25                        Q12 Q20              SOT-23         TRANSISTOR DE USO GERAL SMD    \r\n1    BC807-25 montar de ponta cabeça Q21                  SOT-23                                        \r\n2    BC847                           Q23 Q5               SOT-23         TRANSISTOR DE USO GERAL SMD    \r\n17   BC857                           Q1 Q10 Q11 Q13 Q14   SOT-23         TRANSISTOR DE USO GERAL SMD    \r\n                                     Q15 Q16 Q17 Q18 Q19                                                \r\n                                     Q2 Q22 Q3 Q6 Q7 Q8                                                 \r\n                                     Q9                                                                 \r\n1    DCP010505                       U9                   DIP14-7        CONVERSOR DC/DC                \r\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ST-01	Sensor de Temperatura com saída de 0 a 2mA -> 0 a 100°C	79	16	145	
ASHT-4-v2	Sensor de Umidade Relativa e Temperatura com Saída 4 a 20 mA	24	0	113	\N
ASUT-4-r1	Sensor de umidade e temp. sem compensação de temperatura	49	0	113	-> Montar resistor de 1M/1W e capacitor de 10nF/400V em paralelo, por fora da placa;\r\n\r\n-> Escolher entre: 2 (diodos 1N4001) e 2 (Fusíveis 125 mA/250V)
ASHT-4-v1	Sensor de umidade relativa e temperatura com saída 4 a 20mA	7	0	113	\N
ASHT-4-r1		77	0	113	Componentes inseridos da placa ASUT-4-r1 -> verificar esta lista!
SMF-1-r1		78	0	113	
CDS-01V	Condicionador de sinais de 0 a 1 V para 4 a 20 mA	80	0	146	
Sensor AS		63	1	149	Materia prima para as peças usinadas (10 sensores)\r\ncopo: tarugo aluminio 1 3/4 polegada x 750mm\r\ncorpo: tarugo aluminio 1 1/2 polegada x 170mm (10 peças)\r\nfiltro: tarugo aluminio 1 1/2 polegada x 400mm\r\napoio: tarugo pvc branco 25mm x 300mm\r\ntrava copo:
\.


--
-- Data for Name: cases; Type: TABLE DATA; Schema: public; Owner: jrm
--

COPY public.cases (id, name, descr) FROM stdin;
1	TO-220	
3	SO-14	
4	SO-16	
5	DIP-14	
6	SOT-323	
7	DIP-20	
8	DIP-16	
9	0805	
10	1206	
11	2312	
13	Porta Fus PCI	
14	SOD-80C	
15	TO-92	
16	DIP-8	
17	DIP-14-7	
18	CE100	
20	SO-8	
23	SOIC16-W	
24	SOIC16	
25	TO-252-3	
26	Radial	Terminais radiais
27	180° PCI	Para conectores com terminais a 180° para soldagem na PCI
19	SOT-23	
0	 	Unknown or unset case
28	TO-263-3	
29	TO-247P	
30	90° PCI	
22	180° PCI F	
21	180° PCI M	
31	90° PCI F	
32	Plug	Para plug de conectores
33	SMD CP Elec 6.3 x 7.7	
34	0603	SMD: 0603 1608 Metric
35	DO-213AB	
37	SOD-323	
38	D_SMA	
39	SOP65P640X120-20N	
40	2512	2512 6232 Metric
36	DO-247	
41	SOT-23-6	SOT-23 w/ 6 pads
42	DIP-4	Dual in line with 4 pads 2.54mm spacing
43	SOIC-14N	
44	TO-247-4-PLUS-NN5.1	TO-247 com terminal Kelvin entre 2 e 3 do TO-247 original
45	SOIC-DVG-10	
46	2220	5750 metric
47	2817	7142 metric
\.


--
-- Data for Name: components; Type: TABLE DATA; Schema: public; Owner: jrm
--

COPY public.components (name, group_id, id, case_id) FROM stdin;
7406	60	510	5
555	3	249	0
7407	60	591	5
50K/5W	67	349	0
74ALS373	60	246	7
470K	1	688	9
560R	1	645	9
47K	1	648	9
390R	1	661	9
68R	1	118	9
270K	1	685	9
270R	1	660	9
3K6	1	461	9
3K9	1	656	9
18K	1	653	9
33K	1	142	9
3K3	1	114	9
220K	1	27	9
1K	1	99	9
390K	1	30	9
120R	1	2	9
22R	1	1127	9
120K	1	1134	9
47R	1	1128	9
15K	1	1121	9
180K	1	160	9
4K7	1	117	9
330K	1	29	9
1K5	1	664	9
22K	1	28	9
27K	1	657	9
680R	1	100	9
1M	1	26	9
330R	1	112	9
56K	1	650	9
100R	1	659	9
27R	1	651	9
12K	1	116	9
220R	1	647	9
1K2	1	644	9
100K	1	95	9
150K	1	728	9
10K	1	24	9
150R	1	1249	9
4M7	1	1250	9
8K2	1	1299	9
6K8	1	1301	9
120K	2	972	10
Isolador de mica para TO-3	104	889	0
15V/400mW	28	1339	14
10K	103	1012	0
Header 10x2 PCI 90 w guide	11	1340	0
RB751V40T1G	160	1341	0
Chave Allen 2.5mm	111	1029	0
74VHC245	60	715	7
CI 14 pinos DIP	39	363	0
74LS244	60	222	7
CI 8 pinos DIP torneado	39	148	0
CI 32 Pinos PLCC	39	410	0
12R	1	1	9
2K7	2	1306	10
56R	2	3	10
47R	2	4	10
180R	2	34	10
270K	2	1313	10
Fusível 250V Preto PCI	39	1310	13
Fusível 250V Laranja	39	392	0
TIP31B	9	464	1
DCP010512BP	3	1309	17
Header 20x2 PCI 180 w guide	11	1315	0
IR2121	3	242	16
Fusível 1/2 3pinos 250V	39	1311	0
74HC138	101	1342	4
Cadeira giratória	4	6	0
2N2646	9	708	0
2N6027	9	696	0
2N6109	9	712	0
IRF540	81	713	0
IRF840A	81	714	0
BTA26-600B	80	716	0
74HC221	60	885	0
2N2369 plástico	9	878	0
200K	8	35	0
Mesa workflex 1.85x0.70cm	4	7	0
DS1307	3	11	0
8MHz	5	16	0
51K	8	36	0
BD135	9	40	0
FB350	10	42	0
LM35DZ	12	45	0
LM385-1.2	3	47	0
1MHz	5	54	0
PG9	42	171	0
ASH-Rev0	13	58	0
ASHXXX	16	60	0
CONV-2B	13	85	0
FB350-2	10	57	0
6B595	3	87	0
D69105D ALCATEL	25	89	0
MOLEX A-2	11	103	0
47R	22	107	0
MOLEX A-4	11	111	0
45V	31	124	0
P22	34	129	0
P22	33	130	0
M3 x 16mm Escariado Fenda	56	194	0
M3 x 26mm Philips Inox	56	195	0
24LC512-I/P	3	121	0
RSH-Rev0	13	138	0
RSHXXX	16	139	0
4.7uF/16V	18	206	0
3M Silicone transparente D=12mm H=3mm	41	152	0
transparente 2:1 3/8"	45	177	0
Tela de silk-screen	43	172	0
4.7uF/50V	18	212	0
127-220V/5V-3A	49	187	0
Tarugo D=38.1mm x 1m	54	192	0
Tarugo D=114.3mm x 1m	54	191	0
Tarugo D=40mm x 1m	55	193	0
90~260Vac/5Vdc-2A	49	196	0
127-220V/8V-5A	49	200	0
127-220Vac 24V-5A	49	201	0
Flat Cable 4X2 Fêmea	11	43	0
RJ-11 Low Profile	11	385	0
FB300	10	436	0
Potenciômetro 3299W	77	443	0
DAC1230	3	445	0
RELE-BR10	25	450	0
74HC244	60	462	0
DAC7571	3	465	0
1uF/16V	7	468	0
36V/1W	29	470	0
 9x2 100mils plástico	38	543	0
DIN 6 Pinos Fêmea Painel	11	362	0
TLV5606CD	100	52	0
TPS77050DBVR	100	53	0
Krone 2 Pinos - Low Profile	11	841	0
Krone 3 Pinos - Low Profile	11	842	0
lasercon	13	880	0
74HC4052	101	438	0
BZX85-C6V2 1.3W	29	119	0
74HC138	60	224	0
74LS161	60	215	0
74LS221	60	230	0
74LS08	60	231	0
74HC166	60	236	0
74LS164	60	237	0
74LS14	60	228	0
UA710CN	3	241	0
33pF	6	198	9
390pF	6	296	9
10pF	6	682	9
4538	61	244	0
TL071CP	3	235	0
IR2112	3	239	0
74HC374	60	225	0
IR2113	3	240	0
74HC374	60	251	0
74OL6010	60	227	0
4046	61	253	0
74HC74	60	216	0
40106	61	258	0
TL431	3	259	0
50mA/250V	71	1312	0
CI 14 pinos DIP torn.	39	149	0
270K	22	1314	0
0.47uF/6.3V	7	1316	0
EURO 2C 48 FEMALE 180	11	1317	0
220uF/35V	18	338	0
74LS08	60	261	0
ADC0808N	3	262	0
4081	61	219	0
4093	61	265	0
74LS323	60	221	0
LMC6062AIN	3	266	0
74HC688	60	238	0
74LS05	60	270	0
470pF	17	351	0
LM35DT	12	277	0
4049	61	279	0
74LS138	60	280	0
LM74CIM	3	281	0
MAX692A	3	283	0
74HC4051	101	284	0
74HC4040	101	122	0
LM6218N	3	287	0
DS1302	3	10	0
10nF/630V	27	289	0
22nF/400V	27	290	0
220nF/400V	27	291	0
100nF/630V	27	292	0
1.5nF/400V	27	293	0
1nF/400V	27	294	0
5.6nF/400V	27	295	0
12nF/400V	27	298	0
470nF/400V	27	299	0
1uF/400V	27	300	0
3.3uF/250V	27	301	0
15nF/400V	27	302	0
220nF/250V	27	303	0
100nF/100V	27	304	0
220nF/630V	27	305	0
680nF/250V	27	306	0
330nF/250V	27	307	0
8.2nF/400V	27	308	0
4.7nF/400V	27	309	0
100nF/250V	27	310	0
22nF/250V	27	311	0
3.3nF/400V	27	312	0
390pF	17	314	0
33pF	17	288	0
DB9 Macho Flat Cable	11	316	0
10nF	17	315	0
Flat Cable17x2 Fêmea	11	318	0
Mini DIN 6 pinos Macho Cabo	11	319	0
Mini DIN 6 pinos Fêmea Cabo	11	320	0
DIN 5 pinos Macho Cabo	11	321	0
Antena 75R Macho Cabo	11	323	0
2200uF/16V	18	325	0
22uF/450V	18	330	0
10uF/50V	18	332	0
220uF/63V	18	333	0
1.5uF/63V	18	334	0
22uF/25V	18	335	0
2.2uF/100V	18	336	0
1uF/630V	27	337	0
3.9nF/1600V	66	342	0
330pF	17	347	0
4.7nF	17	348	0
27pF	17	350	0
15pF	17	352	0
12pF	63	345	0
Chave de Toque 1mm	65	355	0
Chave de Toque 6mm	65	356	0
Chave de Toque 9mm	65	358	0
DB9 Fêmea PCI 20mm	11	360	0
Telefone 4/4 Fêmea 90 graus PCI	11	361	0
Chave de Toque Grande 4mm	65	366	0
Fasting-Faston Macho	68	367	0
Fastin-Faston Fêmea	68	368	0
G1RC2-12V	25	370	0
11.0592MHz	5	372	0
16MHz	5	373	0
12MHz	5	374	0
24MHz	5	375	0
A124	9	380	0
A144	9	381	0
10A/400V	71	382	0
Flat Cable 20x2 Fêmea	11	384	0
Flat Cable 25x2 Fêmea	11	383	0
22uF/250V	18	341	0
Telefone 4/4 Fêmea PCI Low Profile	11	387	0
25A/400V	71	388	0
15A/400V	71	389	0
8A/400V	71	390	0
DB9 Capa	11	394	0
MOLEX B 3 Pinos PCI 180°	11	396	0
100mm (aprox) Branca	69	569	0
MOLEX A 8 Pinos Capa	11	400	0
MOLEX A 10 Pinos Capa	11	401	0
LF411CN	3	557	0
T19	33	407	0
T24	33	408	0
22uF/10V	7	553	0
1uF/100V	27	547	0
Bicolor Vermelho/Verde 3 Pinos 5mm	23	413	0
Infravermelho 5mm	23	414	0
10nF	63	415	0
3.3nF/100V	27	418	0
56pF	63	420	0
NTC 16R	73	422	0
S20K250	19	423	0
4.7nF	63	424	0
27pF	63	425	0
100pF	63	426	0
1nF	63	427	0
2.2nF	63	429	0
3.9nF	63	313	0
74LS122	60	472	0
SN75177BP	79	473	0
74HC368	60	476	0
DG408DJ	3	477	0
SN75154N	79	479	0
SN75150P	79	480	0
7420	60	481	0
74ALS541	60	485	0
DG201DPJ	3	486	0
LM2825N-5.0	3	487	0
LM2578AN	3	490	0
LM2675N-5.0	3	492	0
4071	61	495	0
4070	61	500	0
DG407DJ	3	502	0
OP07CP	3	491	0
MAX1249BCPE	3	507	0
MAX1248BCPE	3	508	0
HP2200	3	509	0
SN75176BP	79	511	0
IRF740	81	513	0
P4 Fêmea 90 graus PCI	11	369	31
MJE13007	9	515	0
1K Vertical	82	516	0
10K Vertical	82	517	0
4015	61	518	0
MC1488P	3	519	0
74HC368	60	530	0
47uF/20V	7	538	0
22uF/16V	7	540	0
1uF/35V	7	542	0
4.7uF/25V	7	544	0
10uF/35V	7	545	0
47uF/35V	7	546	0
15nF/100V	27	548	0
47uF/25V	7	549	0
3.3nF/630V	27	550	0
1uF/25V	7	91	0
74HC02	60	554	0
74LS86	60	478	5
LM385Z-2.5	3	125	15
74LS02	60	559	0
4066	61	560	0
TL16C450N	3	561	0
74HC139	60	562	0
TMP82C54P-2	3	563	0
74LS04	60	564	0
ZREF12Z	3	566	0
Pino Partido Médio	68	567	0
Proteçao Sensores ST-02	83	570	0
1/8" x 1.5" Fenda	56	573	0
Espada Pequeno	68	574	0
Capa de DB9 - Trava	56	575	0
Pino Partido Pequeno	68	354	0
Pino Partido Grande	68	568	0
T15	33	578	0
74HC02	60	580	0
LM3875TF	3	583	0
LM3875T	3	584	0
E2023	84	585	0
AT90S1200-12PC	3	586	0
AT90S2313-4PI	3	587	0
74LS245	60	588	0
74AC00	60	589	0
74HC132	60	590	0
74HC245	60	592	0
74LS06	60	501	0
74LS32	60	521	0
74LS07	60	593	0
SG3524N	3	499	0
4099	61	527	0
LM2585T-5.0	3	595	0
74HC191	60	597	0
74LS164	60	598	0
LM2586T-5.0	3	599	0
LM2586T-ADJ	3	600	0
DS88C20N	3	601	0
DS88C120N	3	602	0
DAC0832LCN	3	603	0
DS8922AN	3	604	0
AT29C020-12JC	3	605	0
DAC0808LCN	3	255	0
AT90S8515-9JI	100	606	0
HT2811	3	608	0
DAC0832LCWM	3	609	0
TLC0831CP	3	610	0
DS36F95J	3	615	0
LM2596T-ADJ	3	617	0
LM2596T-5.0	3	618	0
LM3886T	3	620	0
LM3886TF	3	621	0
LM2599T-5.0	3	623	0
ICM6264LD-09	3	624	0
TL494CN	3	626	0
MAX1246BCPE	3	627	0
MAX1110CPP	3	628	0
MAX1111CPE	3	629	0
MAX1204BCPP	3	630	0
DS34C87TM	3	632	0
74LS592	60	633	0
HP2232	3	634	0
DS26C31TN	3	635	0
MAX149BEAP	3	637	0
LM747CN	3	638	0
LM837N	3	639	0
4024	61	528	0
51K	89	642	0
CI 44 Pinos PLCC	39	409	0
Fusível 400V	39	391	0
RJ-45	11	722	0
BZX84C5V6	26	673	0
TL061CP	3	616	0
74HC541	60	607	0
MAX232	100	614	0
RFD8P05	81	719	0
RFD14N05L	81	693	0
LM35CZ	12	694	0
MRD300	87	697	0
MUR1540	20	720	0
TK19	87	721	0
1nF/100V	27	531	0
2.2nF/100V	27	532	0
TIC226D	80	514	0
TIC246D	80	512	0
P2N80	81	725	0
TMS370	3	729	0
74HCT138	101	184	0
150uF/450V	18	747	0
150uF/400V	18	748	0
1000uF/250V	18	749	0
470uF/400V	18	753	0
Euro 96 Pinos Macho	11	754	0
Euro 96 Pinos Fêmea	11	755	0
Pasta Térmica para Solda	91	756	0
0R22/5%	92	757	0
33R	75	758	0
0R33/5%	92	759	0
0.33R	75	760	0
220R	75	761	0
47R	75	762	0
0.47R	75	763	0
1K	93	764	0
150K	8	159	0
0.10R	75	766	0
180R	94	767	0
1K	94	768	0
180R	75	769	0
56R	75	770	0
4R7	75	771	0
33R	93	772	0
1K	75	773	0
12R	75	774	0
NTC 5R	73	776	0
C30 10A	73	777	0
C40 6A	73	778	0
SK4F1/10	20	780	0
DB3	95	781	0
BYV96E	20	786	0
BYV95B	20	787	0
BYW95C	20	788	0
1N4729AC	20	789	0
1N4728AC	20	790	0
510R	8	670	0
1N5406	20	798	0
1N5408	20	799	0
1N5404	20	800	0
6A8	20	801	0
750R	89	847	0
1N4004	20	805	0
BYV95C	20	797	0
1N5339B	20	812	0
3G08  4K	20	813	0
5.6V/400mW	29	439	0
3.3uF/450V	18	824	0
Azul 5mm	97	825	0
NTC 25R	73	421	0
74VHC574	60	498	7
74VHC541	60	582	7
74VHC32	60	690	5
74VHC14	60	691	5
74VHC138	60	524	8
74VHC08	60	692	5
74ALS244	60	640	7
10R	1	646	9
680R	59	735	9
10K	59	736	9
4K7	59	681	9
3K3	59	686	9
330K	59	733	9
33K	59	734	9
150K	2	684	10
33pF	63	419	0
10MHz	5	826	0
7.2MHz	5	827	0
18.432MHz	5	828	0
Chave de Toque 0.5mm	65	830	0
470pF	63	416	0
Sonalarme - 5 Vdc	98	831	0
MOLEX A 10 Pinos PCI 180°	11	402	0
MOLEX A 8 Pinos PCI 180°	11	832	0
30A/400V	71	833	0
5A/400V	71	834	0
20A/400V	71	835	0
LM2588T-5.0	3	596	0
74ALS574	60	641	0
74HCT574	101	113	0
SG3525A	3	482	0
74LS684	60	843	0
IR2151	3	489	0
SN75176AP	79	844	0
SN75189AN	79	520	0
51R	8	37	0
43K	8	666	0
4040	61	552	0
3K6	8	663	0
4K3	8	658	0
1K8	8	655	0
2K	8	652	0
PCI 100mils 90° plástico	38	849	0
4017	61	551	0
DIN41612	11	851	0
BC547B	9	852	0
40109	61	254	0
100 nF	86	860	0
Parker 2017	44	861	0
Parker 2018	44	862	0
Parker 2022	44	866	0
Parker 2023	44	867	0
Parker 2027	44	868	0
Parker 2025	44	173	0
Parker 2019	44	863	0
3V9	26	848	0
OPA277U-ND	100	871	0
Flat Cable 14 Vias	74	430	0
120pF	17	876	0
7905	3	444	0
Chave Ótica H21LOI	65	877	0
4052	102	837	0
Parker 2026	44	174	0
PCI	99	836	0
 Dissipador para TO-220 (30mm)	78	859	0
100R	22	94	0
0.56R	75	431	0
Dissipador para TO-220 (8mm)	78	446	0
Parker 2044	44	176	0
22nF	17	120	0
AT29C512-70PI	3	203	0
REG103GA-3.3	100	882	0
AT25F1024N10SI2.7	100	884	0
Fita Alumínio Scotch 25mm x 30m	109	922	0
2N2222A plástico	9	700	0
74HC04	60	474	0
100mils Cinza	38	484	0
7808	3	555	0
4001	61	269	0
324	3	247	0
3845	3	558	0
7908	3	256	0
7812	3	727	0
311	3	234	0
393	3	273	0
CI 16 pinos DIP	39	364	0
CI 20 pinos DIP torneado	39	817	0
CI 28 pinos DIP torneado	39	815	0
CI 28 pinos Longos DIP torneado	39	814	0
CI 40 pinos DIP torneado	39	816	0
CI 8 Pinos DIP	39	829	0
68R	75	891	0
7912	3	726	0
MOLEX 3.96 mm	68	403	0
Tomada 3 Pinos Macho p/ Painel com Chanfro	11	821	0
MOLEX 5.08mm 6 Pinos Capa	11	902	0
MOLEX B 5 Pinos Capa	11	395	0
EE0012 40mm nat	78	896	0
EE0013 30mm nat	78	897	0
74HCT04	60	442	0
Fita crepe 19x50mm	109	921	0
2N2369 metal	9	699	0
Patola PB108	139	151	0
Super Bonder 3g	108	920	0
33V/1W	29	947	0
100mils Azul	38	854	0
Parker 2021	44	865	0
Parker 2029	44	923	0
Parker 2043	44	924	0
Toróide EMI 33RI 16x14x10	33	953	0
4.7uF/16V	7	33	0
Graxazul 500g	112	927	0
62K	89	928	0
1K	89	929	0
4K7	89	930	0
100K	89	932	0
330K	89	935	0
MOLEX B 2 Pinos Capa	11	937	0
MOLEX B 6 Pinos Capa	11	938	0
1.6mm aço ráp.	47	915	0
1.5mm aço ráp.	47	916	0
2.2mm aço ráp.	47	914	0
0.8mm aço ráp.	47	910	0
10mm aço ráp.	47	905	0
1.0mm aço ráp.	47	912	0
12mm aço ráp.	47	904	0
1.2mm aço ráp.	47	911	0
1/2 pol aço ráp.	47	182	0
1/4 pol aço ráp.	47	908	0
2.5mm aço ráp.	47	913	0
3.6mm aço ráp.	47	181	0
5.0mm aço ráp.	47	907	0
5.5mm aço ráp.	47	909	0
6.5mm aço ráp.	47	906	0
Mini DIN 6 p Macho - DIN 5 p Fêmea	64	322	0
Header 5x2 PCI c/ Capa 90°	11	723	0
Header 7x2 PCI c/ Capa 90°	11	724	0
Header 7x2 PCI c/ Capa 180°	11	943	0
Header 8x2 PCI c/ Capa 180°	11	944	0
Minimal Due	68	945	0
0R0	89	668	0
330pF	6	672	9
220pF	6	677	9
27pF	6	22	9
47pF/50V	6	199	9
Parker 2028	44	957	0
TPS3823-33DBVR	100	883	0
AT45DB041B	100	881	0
Minimal Due 3 Vias Capa	11	822	0
3.6V/1W	29	792	0
5.6V/1W	29	802	0
6.2V/1W	29	811	0
12V/1W	29	795	0
15V/1W	29	793	0
12V/400mW	29	794	0
18V/400mW	29	784	0
150K	59	25	9
200K	2	654	10
ConVD 5.08mm 2.5mm² plug 6 vias	166	856	0
TLV2731IDBVR	100	840	0
ConVD 5.08mm 2.5mm² 90° PCI 6 vias	166	456	0
4.7V/400mW	29	803	0
5.1V/400mW	29	807	0
13V/1W	29	804	0
4.3V/400mW	29	785	0
2.7V/400mW	29	783	0
BPW34FS	90	178	0
Wire Wrapper	111	954	0
33R	89	955	0
Toróide EMI 33RI 25x12x15	33	952	0
100pF	17	63	0
DS36276M	100	81	0
DB9 Fêmea Cabo	11	154	0
DB9 Macho Cabo	11	155	0
Parker 2024	44	956	0
200mA/30V Rearmável	71	958	0
130R	22	74	0
750R	22	75	0
Manga 4x26AWG	74	919	0
Jacaré Peq. Isol. Verm.	138	961	0
Jacaré Peq. Isol. Preta	138	962	0
Patola PB-211	139	963	0
Tomada 3 Pinos Macho Painel s/ aba	11	964	0
127-220V/5V-1A	49	188	0
5V6/500mW SOT23	28	950	0
3V9/500mW SOD80	28	678	0
100R	75	966	0
10K	94	967	0
74HC14	60	220	0
MOLEX 2.54mm	68	404	0
3.6864MHz Low Profile	5	377	0
390R	21	980	0
1K2	21	1010	0
47R	21	983	0
120K	89	933	0
10K	21	459	0
1M	21	161	0
13K	89	931	0
100mils Preto	38	448	0
LM35CAZ	12	56	0
430R	89	649	0
Centronics Fêmea de 36 Pinos p/ Cabo	11	460	0
3K3	21	1025	0
2N2907A plástico	9	710	0
1000uF/25V	18	331	0
BC548B	9	706	0
D40SM 40x40x20 12V	106	898	0
TIP31C	9	948	0
LMC6061IN	3	49	0
125mA/250V	71	466	0
150R	21	432	0
2K2	21	535	0
750R	103	888	0
130R	103	887	0
47uF/250V	18	327	0
10uF/250V	18	340	0
470uF/50V	18	823	0
470uF/25V	18	344	0
47uF/25V	18	329	0
AS1RC-5V	25	371	0
39R	21	977	0
150K	21	978	0
6K8	21	979	0
330R	21	146	0
1K8	21	982	0
4R7	21	984	0
1K5	103	986	0
332R	103	987	0
75K	103	988	0
4K7	92	989	0
330R	22	990	0
1K	22	991	0
1K8	22	992	0
5R6	22	993	0
680R	22	994	0
10M	103	985	0
130K	89	934	0
820R	21	995	0
220R	21	996	0
22K	21	936	0
3K9	21	997	0
10R	21	998	0
1K5	21	999	0
3R3	21	1000	0
3K9	103	1001	0
20K	103	1002	0
180K	22	1005	0
560R	21	1007	0
4K99	103	1004	0
27R	21	1008	0
270R	21	981	0
CI 16 pinos DIP torneado	39	150	0
1R	22	1014	0
2K	103	1015	0
499R	103	1016	0
4R7	92	1017	0
680R	21	72	0
6R8	21	1018	0
12K	21	1019	0
8K2	21	1020	0
100R	21	1021	0
15R	21	1022	0
22R	21	1023	0
56R	21	1024	0
180K	92	1026	0
100K	21	533	0
68K	21	73	0
1K	103	1003	0
200R	103	1027	0
470K	21	1009	0
100nF	63	417	0
BF245C	9	701	0
74ALS573	60	223	0
74LS373	60	243	0
2N2907A metal	9	698	0
BC327-16	9	711	0
BC337-16	9	704	0
BC337-40	9	705	0
BD135 isolado	9	918	0
BF245A	9	703	0
BF245B	9	709	0
BF494B	9	707	0
2K7	21	458	0
5K6	21	1006	0
47K	21	536	0
1K	21	69	0
4K7	21	71	0
470R	21	70	0
FB200	10	41	0
TPIC6B595DW	100	186	0
3.3V/1W	29	791	0
100mm (aprox) Preta	69	359	0
LT1004CZ25	3	51	0
Dupla 090° PCI 80 Pinos	35	133	0
1N4148	20	779	0
BC337-25	9	102	0
74HC14	101	77	0
BPW34S	90	741	0
15K	21	534	0
6N137	195	13	16
10nF/400V	27	93	0
LM92CIM	100	875	0
Flat Cable 5x2 Fêmea	11	386	0
2K7	1	106	9
100K	59	737	9
100K	2	968	10
1K	2	970	10
330K	2	969	10
4K7	2	971	10
ConVD 5.08mm 2.5mm² 90° PCI  2 vias	166	454	0
10K	8	662	11
ConVD 5.08mm 2.5mm² plug 2 vias	166	853	0
ConVD 5.08mm 2.5mm² plug 3 vias	166	855	0
LM317T	3	594	0
CR2430FP2	30	750	0
74HC244	101	412	0
Flat Cable 7x2 Fêmea	11	428	0
Barra de Pinos PCI 16p simples	11	1031	0
Barra de Pinos PCI 15p simples	11	1032	0
7 segmentos verm.	88	1033	0
SKR 21/08	20	1034	0
130R	89	98	0
HFA15TB60	20	1035	0
FES16GT	20	1036	0
MUR15-100	20	1037	0
MJ10008	9	1038	0
2K (3296)	82	127	0
200K (8714)	82	1039	0
39K	21	1011	0
10K (9441)	82	1040	0
Wire wrap 30AWG	144	1067	0
Jacaré Média Preta	138	960	0
Infravermelho (preto)	90	1042	0
Wire wrap 32AWG	144	1068	0
Amarelo	87	1043	0
Mica TO-218	104	899	0
TDA1520	3	1044	0
Mica TO-220	104	900	0
1K (3386)	82	1045	0
Bucha isolante para Parafuso M3	104	890	0
50K (8423)	82	1046	0
0.22R	75	765	0
TIPL763A	9	1047	0
Jacaré Média Verm.	138	959	0
10A Automotivo	71	1048	0
150nF/400V	27	1049	0
270R	22	1050	0
BC558B	9	879	0
0.05R	141	1051	0
741	3	493	0
Abraçadeira U32	153	1077	0
Banana Plugue	11	1052	0
Araldite 15min 23g	108	1084	0
Banana borne	11	1053	0
7815	3	1054	0
Suporte AM-1	150	1071	0
Prato AM-1 sem furo	151	1072	0
2K2 linear	77	1056	0
Prato AM-1 com furo	151	1073	0
15uH	142	1057	0
Barra Roscada M4 x 1m Inox	153	1074	0
100uH	142	1058	0
200uH	142	1059	0
Carretel E25	34	1061	0
Carretel E30/14	34	1062	0
BD236	9	1064	0
47uF/100V	18	1065	0
10uF/63V	18	1066	0
LTKA01CN	3	1101	0
TPS76033DBVR	100	19	0
Lisa Inox 5/16''	155	1088	0
Sensor AS - Apoio	150	1083	0
TIP3055	9	451	0
SA5.0A	19	66	0
AT45DB161B-RI	100	1120	0
SA12A	19	65	0
MOLEX B 5 Pinos PCI 180°	11	447	0
BAR43 (SOT23)	26	207	0
Tubo 0.75mm	68	577	0
100K	22	467	0
DS36277TM	100	164	0
1,5KE36A	19	1126	0
30K	8	1104	0
Flange BR7 PVC Tigre	153	1085	0
Combinorm CN22AK	139	1090	0
Combinorm CN45AK	139	1091	0
74HC1G08	101	144	0
Centronics Fêmea de 36 Pinos CAPA	11	974	0
MOLEX B 3 Pinos Capa	11	399	0
74HC1G32	101	145	0
MOLEX B 6 Pinos PCI 180°	11	398	0
Mini DIN 6 pinos Fêmea PCI 90°	11	946	0
P2 ou P4 Plug	11	317	0
Telefone 4/4 Macho Cabo	11	365	0
Tampa para pólos vazados para Caixa Combinorm	139	1099	0
TPS3705-33DGNR	100	872	0
XTR112U	100	1103	0
50K (3296)	82	838	0
HIH3610-004	12	44	0
180K	8	1107	0
24K	8	1110	0
4K7	8	1112	0
2K (64X)	82	1113	0
100R (64X)	82	1114	0
MSP430F1232IDW	100	8	0
TPS71533DCKR	100	839	0
910K	89	1131	0
Simad-Logger	139	1137	0
13K	8	1109	0
62K	8	1105	0
220K	8	1108	0
7K5	8	1132	0
CE-20/10/5-1	33	1124	0
330R	8	1106	0
Carretel E20	34	1125	0
5K1	8	1129	0
91K	8	1133	0
1R8	22	1123	0
16V/1W	29	1122	0
DAC5813N	100	1135	0
Panasonic 3.6V (Telefone)	30	775	0
TPS77033DBVR	100	20	0
LT1025ACN	3	1100	0
BC847	9	38	0
M3 x 10mm Cabeça Cônica Allen	56	1144	0
M3 x 8mm Cabeça Cônica Allen	56	571	0
M4 Inox Calota	154	1087	0
Lisa Inox M4	155	1075	0
LMC6061AIM	100	976	0
20K	8	667	0
M4 Inox	154	1076	0
XTR115U	100	873	0
130K	8	1161	0
M3 x 6mm Fenda	56	1150	0
32768Hz	5	14	0
39K	59	1070	9
1K	59	738	9
39K	2	676	10
100K	8	1111	11
120K	8	1160	11
ConVD Fixo Horiz 5mm 2 vias	166	1092	0
ConVD Fixo Horiz 5mm 3 vias	166	1094	0
ConVD Fixo Vert 5mm 4 vias	166	1098	0
ConVD Fixo Horiz 5mm 8 vias	166	1097	0
ConVD Fixo Vert 5mm 2 vias	166	1093	0
ConVD Fixo Vert 5mm 3 vias	166	1095	0
ConVD Fixo Vert 5mm 8 vias	166	1096	0
M3 x 5mm Philips Inox	56	1152	0
1K	8	665	0
M3 x 30mm Inox Fenda Chata	56	917	0
Krone 2 Pinos	11	208	0
Plástico M3 x 3mm	99	1153	0
Krone 3 Pinos	11	165	0
TPS3705-33D	100	886	0
LM385Z-ADJ	3	46	0
LT1004CZ12	3	50	0
100nF/400V	27	297	0
22K	8	671	0
10uF/16V	7	153	0
47uF/16V	7	539	0
10uF/25V	18	339	0
Alongador-teclas-SIMAD	150	1157	0
Lisa M3 Plástico	155	1148	0
Header CFDISK	11	1158	0
MSP430F149IPM	100	869	0
25K	8	1162	0
Parker 2020	44	864	0
74HC541	101	183	0
1nF	17	346	0
1uF/100V	18	326	0
4MHz	5	15	0
4N25	3	128	0
32768Hz Tubo	5	1159	0
BC857	9	39	0
Mini Liga/Desliga 250V/6A	65	324	0
Chave de Toque 17mm	65	357	0
TPS76750QD	100	870	0
4049	102	285	0
4.7uF/100V	18	328	0
MOLEX B 2 Pinos PCI 180°	11	185	0
MOLEX B 5 Pinos PCI 90°	11	397	0
MOLEX 5.08mm	68	901	0
Chave de Toque 14mm	65	1163	0
0.5mm aço ráp.	47	1164	0
3.6mm aço ráp	47	1165	0
LCD 20x4 com backlight	88	1063	0
Pressão Inox M4	155	1089	0
M2	154	1146	0
Verde 3mm	23	84	0
M3	154	1145	0
Amarelo 3mm	23	83	0
Lisa M3	155	1147	0
1N4001	20	433	0
Vermelho 3mm	23	82	0
Verde 5mm	23	110	0
Vermelho 5mm	23	109	0
Amarelo 5mm	23	108	0
ML2RC-5V	25	683	0
1M	22	537	0
1N4007	20	162	0
M2	155	1167	0
AS1RC2-12V	25	818	0
BC327-25	9	702	0
De-15mm  Di-5mm	155	1174	0
DB9 Fêmea PCI 15mm	11	78	0
DB9 Macho PCI 15mm 	11	79	0
LCD 16x2 com Backlight	88	718	0
M3 x 6mm Philips	56	572	0
OP07C	100	680	0
3A/250V	71	393	0
10mm	155	1170	0
De-10mm Di 3mm	155	1171	0
De-13mm  Di- 4.5mm 	155	1172	0
De-18mm  Di-7mm	155	1173	0
De-20mm Di-10mm	155	1175	0
Pressão De-18mm Di-10mm	155	1176	0
De-13mm  Di-6mm	155	1177	0
Pressão M3	155	1178	0
Chave Allen 2mm	111	1028	0
Chave Fenda 1mm	111	1030	0
Desandador para macho M2 até M4	111	925	0
M2x0.4 Aço Rápido	48	179	0
M3x0.5 Aço Liga	48	926	0
M3x0.5 Aço Rápido	48	180	0
M3 x 16mm Cabeça Cônica Allen	56	1151	0
PG7	42	170	0
10M	21	96	0
M3 Plástico h=8mm	155	1179	0
M2 x 10mm Fenda	56	1169	0
M3 x 10mm Cabeça Cônica Philips Inox	56	1212	0
TIP32C	9	1229	0
M2 x 8mm Fenda	56	1180	0
Simples 180° PCI 40 pinos	35	132	0
M2 x 5mm Fenda	56	1181	0
EFD20 'E' 10x22mm	33	1228	0
M2 x 12mm Fenda	56	1182	0
M3 x 25mm Cabeça Cônica Philips	56	1185	0
Flat Cable 8x2 Fêmea	11	1225	0
M3 x 30mm Cabeça Cônica Fenda	56	1184	0
1A 250V	71	1230	0
2mm x 10mm	159	1231	0
1,5mm x 10mm	159	1232	0
M3 x 20mm Cabeça Cônica Fenda	56	1186	0
100R (3006)	82	1242	0
M3 x 25mm Cabeça Cônica Fenda Inox	56	1187	0
2k (3006)	82	1215	0
M3 x 30mm Philips Inox	56	1188	0
2.2uF/16V	7	76	0
M3 x 16mm Cabeça Cônica Fenda	56	1189	0
2K2	1	643	9
0R0	59	23	9
DCP010505BP	3	80	17
ConVD 3.5mm 1.5mm² plug 3 vias	166	1115	0
ConVD 5.08mm 1.5mm²  90° PCI 3 vias	166	1117	0
ConVD 3.81mm 1.5mm² plug 4 vias	166	1116	0
ConVD 5.08mm 1.5mm² plug 3 vias	166	1118	0
ConVD 3.5mm 1.5mm² 90° PCI 3 vias	166	135	0
ConVD 3.81mm 1.5mm² 90° PCI 4 vias	166	136	0
1N4148W	26	92	14
BC807-25	9	115	19
4093	102	282	3
12V/500mW	28	97	14
M3 X 20mm Philips Inox	56	1190	0
RJ-45 low profile	11	1233	0
M3 x 16mm Cabeça Cônica Philips Inox	56	1191	0
Carretel EFD30	34	1246	0
M3 x 8mm Fenda	56	1192	0
EFD30 'E' 12x32mm	33	1245	0
M3 x 6mm  Allen	56	1193	0
Dupla 180° PCI 80 Pinos	35	858	0
M3 x 16mm Allen 	56	1194	0
RJ-11 6pinos	11	1234	0
M5 x 25mm Fenda	56	1195	0
RJ-11 4 pinos	11	1235	0
M3 x 10mm Fenda Inox	56	1196	0
M3 x 30mm Fenda Inox	56	1197	0
M2 x 16mm Fenda	56	1198	0
M5	154	1199	0
M3 Preta	154	1200	0
M2 x 6mm Cabeça Cônica Fenda	56	1149	0
M3 x 20mm Fenda	56	1183	0
M2 x 6mm Fenda	56	1168	0
Dupla 090° PCI 04 Pinos	35	1222	0
1.5mm 	47	1201	0
IRFU9110	81	1214	0
2.0mm aço ráp	47	1202	0
Simples 180° PCI 30 Pinos	35	1223	0
2.5mm aço ráp	47	1203	0
3.0mm aço ráp	47	1166	0
3.5mm aço ráp	47	1204	0
390K	21	205	0
4.0mm aço ráp	47	1205	0
4.5mm aço ráp	47	1206	0
4.8mm aço ráp	47	1207	0
5.0mm aço ráp	47	1208	0
Simples 180° PCI 02 Pinos	35	1216	0
5.5mm aço ráp	47	1209	0
6.0mm aço ráp	47	1210	0
6.5mm aço ráp	47	1211	0
Dupla 180° PCI 14 Pinos	35	1220	0
Dupla 180° PCI  10 Pinos	35	1219	0
Dupla 180° PCI 16 Pinos	35	1221	0
MAX232	3	9	0
OPA340NA	100	1243	0
OPA340UA	100	1244	0
10uF/25V	7	157	0
Sindal 10mm²	11	406	0
Sindal 22mm²	11	576	0
Sindal 6mm²	11	405	0
Header PCI Fêmea 16x1	11	1247	0
3.6864MHz	5	17	0
DM199K s/ Furo	78	892	0
1N5818	96	850	0
1N5822	96	809	0
120R	8	1119	0
CFDisk SMD	11	1227	0
470uF/16V	18	1252	0
2200uF/10V	18	1253	0
BAS16LT1G	26	1257	0
1N5817	96	1258	0
25MHz	5	1259	0
ENC28J60/SO	100	1262	0
XC05XL-4VOG100C	100	1263	0
LM2576T-ADJ	100	1265	0
BC857C	9	1266	0
FDV302P	81	1267	0
FDV301N	81	1268	0
MAX3232CD	100	1269	0
SN65HVD1050D	100	1270	0
NDT2955	81	1272	0
JACK 10/100 BASE T	11	1273	0
74HC4066	101	1275	0
74HC595	101	1276	0
BD3/1/4-4S2	10	1277	0
1uF/50V	18	1279	0
1.2nF/100V	27	1283	0
10nF/50V	27	1285	0
PMEG2010EA	160	1274	0
5V6/500mW SOD-323	28	1287	0
3V9/500mW SOT23	28	949	0
MOLEX A 3 Pinos 180º PCI	11	1288	0
74HCT04	101	1289	0
555 CMOS	100	1291	0
26LS32	100	1290	0
IR2175S	100	1292	0
LM358	100	1293	0
TLC1543	100	1295	0
0R020	75	1298	0
270K	161	1300	0
10M	162	1303	0
18K PR03	76	1055	0
68R PR03	76	435	0
82R PR03	76	903	0
0R010/1%	76	1304	0
74HC04	101	1261	0
74HC21	101	1318	0
74HCT139	101	1319	0
EURO 2C 32 MALE 90	11	1320	0
74HC165	101	1325	0
74HC1G125	101	1326	0
74HC1G04	101	1327	0
LMC6062IM	100	1329	0
TLV2553IDW	100	1330	0
56R	8	1331	0
LT1004 2.5V	100	1332	0
HCPL-0631	100	1333	0
HCPL-0601	100	1260	0
74HC1G00	101	1334	0
LMC6061IM	100	1335	0
LT1004 1.2V	100	1336	0
680K	1	1236	9
39K	1	1238	9
820K	1	1240	9
82K	1	1241	9
68K	1	1237	9
220R	2	1278	10
390R	2	1296	10
2K	2	1297	10
10R	2	1302	10
100R	2	1307	10
220K	2	1308	10
560R	2	1337	10
120R	2	1338	10
LM324	100	1305	3
7805	3	213	1
ConVD 5.08mm 2.5mm² 180º PCI 2 vias	166	1343	0
ConVD 5.08mm 2.5mm² 180° PCI 4 vias	166	1344	0
ConVD 5.08mm 2.5mm² plug 4 vias	166	1345	0
74HCT244	101	1346	0
74HCT86	101	1328	3
4044	102	1324	4
null	169	1494	0
ConVD 3.81mm 1.5mm² 90º PCI 10 vias	166	1321	0
3V3/500mW	28	1286	14
01x04 (04 vias)	35	1218	21
1nF	6	1280	9
LM393	100	1294	20
10nF	6	1251	9
560K 1%	1	1239	9
33nF	6	1254	9
39pF/200V	6	1255	9
47nF	6	1256	9
470pF	6	1281	9
2.2nF	6	1282	9
100pF	6	1284	9
IRAMXUP60A	3	1347	0
330R	2	1348	0
220nF	6	1349	0
ConVD 3.81mm 1.5mm² plug 10 vias	166	1322	0
10uF/16V	18	64	18
330uH	142	1271	0
INA118P	3	1351	16
TLC277	3	1352	16
MCP4922	3	1353	5
220uH/1A	142	1357	0
Header 13x2 Female Board 180o	11	1355	0
LM2576T-5.0	3	1356	0
FDV303N	81	1358	15
IRLML5203	81	1359	15
2.2nF	17	1360	0
1000uF/16V	18	1361	0
ConVD 5.08mm 1.5mm²  90° PCI 2 vias	166	1363	0
ConVD 5.08mm 1.5mm²  Plug 2 vias	166	1364	0
MUR460	20	1366	0
DCP021212	3	1367	0
Simples 90o PCI 8 Pinos	35	1368	0
Plug 3 Pinos p/ Cabo c/ Chanfro	11	820	0
74HC595	60	1369	0
82C55	100	1370	0
74HC165	60	1371	0
Flat Cabe 10x2 Fêmea	11	1372	0
74HC4017	60	1373	0
74HCT138	60	1374	0
74HCT688	60	1375	0
MBRS340T3G	160	1376	0
FDS6900AS	81	1377	0
FDS9435A	81	1378	0
75232	100	1379	0
PC104 20x2 40 pinos	11	1381	0
PC104 32x2 64 pinos	11	1380	0
82C54	100	1382	0
PLCC 44 pinos	39	1383	0
PLCC 28 pinos	39	1384	0
PLCC 44 pinos SMD	39	1385	0
74HCT32	60	1386	0
LM285D-1-2	100	1387	20
74HCT08	60	1388	5
LT1013	3	1389	0
0.015R 1%	75	1390	0
27R	75	1391	0
Simples 28 pinos PCI	39	1392	0
Simples 6 pinos PCI	39	1393	0
null	7	1394	0
10uF/6V3	7	1395	0
22uF/25V	7	1396	0
1.2nF	6	1397	0
130R	2	1398	0
LMC6062AIM	100	1399	0
74HCT245D	101	1400	0
BC807-16	9	1404	0
ILB1206ER601V	10	1405	0
EXCML32A608U	10	1406	0
50K	1	1407	0
1K8 0.25W	2	1408	0
TLC272CD	100	1409	0
LM385M3 - 2.5	3	1410	0
IRF8010	81	1457	0
HCPL2631	100	1411	16
IRFZ34N	81	1412	0
4093	100	1354	20
IRFZ24	81	1458	0
7915	3	1459	0
teste nome 3	66	1413	0
LM285Z-2.5	3	1460	0
BC847 SMD	9	1461	0
BC857 SMD	9	1462	0
S8025L	80	1414	18
LM348N	3	1415	0
MCP4922	100	1416	0
IRG4PC50UD	167	1417	0
0R	1	1418	0
680K	2	1419	0
0R	2	1420	0
47K	2	1421	0
1M	2	1422	0
27R	92	1423	0
1R2	22	1424	0
47R	92	1425	0
0R05	76	1426	0
0.05R	75	1427	0
74LS541	60	1428	0
TLC274AID	100	1429	0
LM348D	100	1431	0
INA333AIDGKR	100	1432	0
LT1004CZ1.2	3	1433	0
MC79L05ACLP	3	1434	0
LM78L05ACZ	3	1435	0
MC7805CTG	3	1436	0
TIP41A	9	1437	0
BTB24	168	1438	0
NTF2955T1G	81	1440	0
FDV304P	81	1441	0
EXCML32A680U	10	1443	0
150uH	142	1444	0
220uH	142	1445	0
10000uF/16V	18	1446	0
2200pF	6	1447	0
4.7uF	63	1448	0
1nF/50V	63	1449	0
4,7nF/50V	63	1450	0
10nF/400V	63	1451	0
100nF/50V	63	1452	0
220nF/400V	63	1453	0
BTA26-600B	168	1454	0
IRF530N	81	1455	0
RFP15N05L	9	1456	0
BC857BLT1 SMD	9	1463	0
3V3	28	1464	0
15V	28	1465	0
MAX485ECSA	100	1466	0
MCP4921	100	1467	0
74HC238	60	1468	0
74HCT541	60	1469	0
4050	61	1470	0
MC14011BCP	3	1471	0
MCP4921	3	1472	0
15V/500mW	29	1474	0
18V/1W	29	1475	0
1N5819	96	1473	0
BYV27-200	20	1476	0
BYV28-200	20	1477	0
MUR420	20	1478	0
LM358	3	1479	0
LM324	3	1481	0
AM26LS31	3	1482	0
LM339	3	1483	0
KA3525A	3	1484	0
220K	21	1485	0
DIP torneado	35	1486	0
10uF 35V CASE C	7	1488	0
Infravermelho (vinho)	90	1041	3
2512067007Y3	10	1490	10
LM393	3	1480	16
2.2uF 20V SMD	7	1491	0
Header Box 8x2 90graus	11	1492	0
Resistor SMD 1206 5%	89	1493	0
Minimal due 5 vias capa	11	1495	0
Minimal due 1 via capa	11	1496	0
HCPL7840	3	1497	0
AM26LS32ACD	100	1402	24
AM26LS31CD	100	1401	24
BC807	9	1442	19
01x05 (05 vias)	35	1365	21
100uF/25V	18	1362	26
DCP010515BP	3	1498	0
40107	61	612	19
2N2219	9	695	0
100mils c/ Aba Preto	38	147	10
TLC277CDR	100	1526	0
TLC279CD	100	1527	0
10uH Murata 82103C	142	1528	0
IRFP2907Z	81	1529	0
BUZ334	9	1530	0
TIC263D	168	1531	0
TIC246D	168	1532	0
FGH60N60	167	1533	0
FAN73912	3	1534	0
IR2110	3	1535	0
HCPL316J	3	1536	0
G4PF50WD	167	1538	0
ACS752	3	1539	0
TL081CP	3	1541	0
LM565CN	3	1546	0
A1120	3	1552	0
HEF4049BT	3	1553	0
ACS708T	3	1556	0
ACS758ECB-200U-PFF-T	3	1559	0
ACS758ECB-200B-PFF-T	3	1537	0
A1104	3	1560	0
74HC04	60	1557	0
74HCT244D	101	1549	0
SN75LBC031D	100	1555	0
SN74HCT00N	101	1550	0
SN74HC541N	60	1547	0
SN74HC540N	60	1543	0
SN74221N	60	1542	0
HCF4049UBE	3	1561	8
M74HC11B1	60	1562	0
CD4050BE	61	1554	0
CD4093BE	61	1540	0
14093B	3	1564	0
232CB	3	1565	0
TLC271CD	3	1566	0
ACS712T	100	1567	0
HC86	101	1568	0
TL071CN	3	1569	0
14504BG	100	1570	0
TC4049BP	61	1571	0
TL082CP	3	1572	0
HCF4035BE	61	1573	0
HCF4082BE	61	1574	0
HCF4030BE	61	1575	0
082D	3	1576	0
INT200	3	1578	0
INT201	3	1579	0
DS26C32ATN	3	1580	0
MAX485	3	1581	0
AM26LS32ACN	3	1582	0
LMC6062	3	1583	0
ESP32-S3-DevKitC	179	1589	0
CD4504BE	61	1577	0
CD4528BCN	61	1563	0
HCF451BE	61	1548	0
ConVD 5.08mm 2.5mm² 180º PCI 3 vias	166	1350	0
ConVD 5.08mm 2.5mm² plug 7 vias	166	1593	0
TIL78	9	1594	0
TIL32	23	1595	0
MEE1S1205C	180	1597	0
P6KE6.8CA	19	1599	0
100nF	17	62	0
Inválido	0	0	0
MUR160	20	1604	0
Bendal 100-302-SN	11	1605	0
MP1584	180	1596	0
MEE1S0505SC	180	1606	0
MEE1S1212SC	180	1607	0
MEE1S1215SC	180	1608	0
10K	2	1611	0
10uF/25V	181	1615	0
PZT2222A	9	1618	0
39K	75	1622	0
Bendal 100-303-SN	11	1624	0
B1205S-2W	180	1625	0
IDC 05x2 HEADER	11	1626	0
470R	1	1640	9
BC817-25	9	965	19
01x03 (03 vias)	35	1217	21
CD4504	102	1551	4
KF7.62-2P (2 vias)	11	1635	0
5569-4A	182	1636	0
40106	102	1614	3
33uF/25V	18	1641	0
02x10 (20 vias)	184	1638	21
LT1013DD	100	1430	20
INA826	100	1623	20
5569-2A	182	1642	27
74HCT541	101	88	23
MAX6675	100	1598	20
LM3940IMP-3.3	100	1264	25
Vermelho	185	1639	9
uA7805	100	1644	28
HCPL-2630	3	1558	16
01x01 via	35	1617	0
200R	1	1620	9
30pF	6	1587	9
20R 1%	1	1619	9
33R	1	1621	9
HCPL-7800	3	717	16
1uF	6	1603	9
02x05 (10 vias)	183	1637	21
FGH60N60SMD	167	1609	29
4R7	1	1610	9
AM26C32	100	1590	24
AM36C31	100	1612	24
IR2113	100	1627	23
HCPL-2631	3	1545	16
HCPL-2601	3	1613	16
100nF	6	21	9
2200uF/25V	18	343	26
CH3.96-2A (02 vias)	182	1634	21
CH3.96-3A (03 vias)	182	1645	21
220uF/25V	18	1591	26
JST XH 2.5mm 04 vias	11	1592	27
STLZ 950 03G 5.08 H	166	1629	30
03 vias 5.08mm 2.5mm² 90° PCI	166	455	0
22pF	6	197	9
AKZ 950 02 5.08	166	1631	32
SI2300	81	1588	19
01x02 (02 vias)	35	1646	0
125R 1%	1	1586	9
AKZ 950 03 5.08	166	1632	32
TJA1050	100	1584	20
AKZ 950 07 5.08	166	1633	32
12pF	6	90	9
STLZ 950 02G 5.08 H	166	1628	30
STLZ 950 07G 5.08 H	166	1630	30
FF600R12KT4HOSA1 	167	1647	0
10uF/25V	17	1648	10
100uF/25V	181	1616	33
3.3uF/305VAC	27	1649	0
120pF	17	1650	34
2.2uF/305VAC	27	1651	0
330pF/630V	17	1652	10
620pF/25V/2%	17	1653	34
2200uF/450V	18	1654	0
100nF/630V	17	1655	10
1uF/305VAC	27	1656	0
47uF/400V	18	1657	0
150nF/25V	17	1658	34
1.5uF/25V	17	1659	34
5.6nF/50V/5%	17	1660	34
470pF/25V	17	1661	34
220nF/25V	17	1662	34
UF4005	26	1663	35
GBJ5010	20	1664	0
LED_GREEN	185	1754	10
STTH3012WL	96	1666	36
PMEG4005AEA	96	1667	37
39V/1W	28	1668	38
MRA4005T3G	26	1669	38
0.1R/850R/1.5A	10	1670	0
1.5mH/40A	186	1671	0
UCC28070APWR	100	1672	39
Molex 5566 08 vias	11	1673	0
Molex 5566 06 vias	11	1674	0
2mH/0.6A/650V	142	1675	0
RAC15-15SK	187	1676	0
IMW65R007M2H	81	1677	29
2K/1%	188	1678	34
15.8K/1%	188	1679	34
10R/0.5W	189	1680	10
100K/0.5%/0.25W	189	1681	10
7.77K/0.1%	188	1682	34
64.9K/1%	188	1683	34
549K/1%	188	1684	34
470K/1W	190	1685	40
24.9K/1%	188	1686	34
93,1K	188	1687	34
100K	188	1688	34
34K/1%	188	1689	34
120K	188	1690	34
3.3R/0.5W	189	1691	10
0R0	189	1692	10
1K	188	1693	34
4.7R/0.5W	189	1694	10
36K/1%	188	1695	34
PMS9494.100NLT	84	1696	0
10K NTC	191	1697	0
LNK306D	100	1698	0
MCP1407-E	100	1699	0
2.2uF/10V	17	1700	9
15p/10V	17	1701	9
1uF	17	1702	10
470uF/16V	181	1703	0
10nF/100V	17	1704	9
22uF/25V	181	1705	0
220nF	17	1706	9
02x04 8 vias	183	1708	0
ESDCAN-03	19	1709	19
60R	10	1710	10
Molex KK 254 06 vias	11	1711	0
15uH	142	1712	0
LED RED	185	1713	10
LED GREEN	185	1714	10
LED YELLOW	185	1715	10
BC807-40	9	1716	19
SI2300	81	1717	19
120R/0.5W	189	1718	10
330R/0.5%	1	1719	9
499K/0.5%	1	1720	9
13K3 0.1%	1	1721	9
100K 0.1%	1	1722	9
49R9/1%	1	1723	9
AM26C31	100	1724	0
STM32F405RGT6	100	1725	0
TPS54202DDC	100	1726	41
ABM3B-8.0-10-1UT	5	1727	0
02x05 10 vias	183	1707	0
UCC5870QEVM-045	192	1728	0
 IXFH90N65	81	1731	29
Carretel ETD59	34	1732	0
ETD59	33	1733	0
220R/5W	196	1755	47
LTV-816S	195	1756	0
Presilha CLM-ETD59	34	1734	0
2.2uF/450VDC	27	1735	0
2.2uF/305VAC	194	1736	0
2.2uF/630VDC	27	1737	0
TILL111	195	523	0
LTV-816	195	1738	42
74HC1G14	100	1757	43
Molex Mini Fit Jr 02x03 Horizontal	182	1740	0
LAUNCHXL-F28069M	179	1741	0
STTH3012W	20	1742	36
IKY120N65	167	1743	44
STTH3006W	20	1744	36
STTH3010W	20	1745	36
TMCS1133C3	100	1747	45
TMCS1133C5	100	1746	45
39-00-0039	68	1748	0
45559-0002	11	1749	0
2EDB8259Y	100	1739	43
2.2uF/630VDC	194	1750	0
470pF/1000V	27	1751	0
SMAJ15	19	1752	38
2K/100Mhz	10	1753	34
IXFH90N65X3	81	1730	29
\.


--
-- Data for Name: currencies; Type: TABLE DATA; Schema: public; Owner: jrm
--

COPY public.currencies (id, name, symbol, rate) FROM stdin;
1	Real	R$	1
3	EURO	EUR	3.29000000000000004
2	Dólar	US$	3.06999999999999984
0	Moeda base	GEN	1
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: jrm
--

COPY public.groups (name, id, supergroup_id) FROM stdin;
Jumper	38	1
0 Non-exist	0	0
Cristal Oscilador	5	1
Capacitor de Tântalo	7	1
Transístor	9	1
Ferrite Bead	10	1
Resistor SMD 0805 2% Barr Níquel	59	1
Placa de Circuito Impresso	13	1
Resistor SMD 1206 2% Barr Níquel	89	1
Capacitor Cerâmico Multicamada	17	1
Capacitor Eletrolítico	18	1
Diodo	20	1
Resistor 1/8W CR25	21	1
Resistor 1W PR01	22	1
Anel Elástico	159	9
Diodo SMD	26	1
Capacitor de Poliéster	27	1
Diodo Zener SMD	28	1
Diodo Zener	29	1
Bateria	30	1
Lâmpada Neon	31	1
Núcleo de Ferrite	33	1
Barra de Pinos	35	1
Resistor 2W PR02	92	1
Circuito Integrado	3	1
Sensores	145	11
Sensor	12	1
Núcleo de Ferrite - Acessório	34	1
Supressor de Transiente	19	1
Fonte de Alimentação	49	1
Pé Autoadesivo	41	7
Circuito Integrado Série 74	60	1
Circuito Integrado Série 40	61	1
Capacitor Cerâmico	63	1
Chave	65	1
Capacitor a Óleo	66	1
Resistor Cerâmico	67	1
Terminal	68	1
Fusível	71	1
Varistor	73	1
Cabo	74	1
Resistor 5W	75	1
Potenciômetro	77	1
Dissipador	78	1
Circuito Integrado Série 75	79	1
Tiristor	80	1
Transístor MOSFET	81	1
Trim-Pot	82	1
Transformador	84	1
Fototransístor	87	1
Display	88	1
Resistor SMD 1206 1%	2	1
Diac	95	1
Fotodiodo	90	1
Resistor 10W	93	1
Resistor 20W	94	1
Diodo Schotcky	96	1
Buzzer	98	1
Circuito Integrado Série 74 SMD	101	1
Circuito Integrado Série 40 SMD	102	1
Circuito Integrado SMD	100	1
Invólucro	149	2
Placas de CI	113	2
Macho	48	6
Cola	108	7
Condicionadores de Sinais	146	11
Espaçador	99	7
Ferramenta	111	6
Filtro de Ar	43	7
Fita Adesiva	109	7
Invólucro	83	9
Isolação Termo Retrátil	45	7
Isolador	104	7
Lubrificante	112	7
Material para Invólucro	16	9
Pasta Térmica	91	7
Prensa Cabo	42	9
Móvel	4	7
Caixa	139	9
PVC	55	9
Ventilador	106	9
Relé	25	1
Anel de Vedação	44	9
Broca	47	6
Fresa	137	6
Garra	138	1
Resistor 25W	141	1
Indutor	142	1
Resistor 1/8W MR25 1%	103	1
Presilha/abraçadeira	69	7
Aquisição	147	11
Alumínio	54	9
Comunicação de Dados	114	11
Abrigo Meteorológico	148	11
Diversos Mecânicos	153	9
Porca	154	9
Arruela	155	9
Parafuso	56	9
Peça Injetada	151	9
Peça Usinada	150	9
Adaptador	157	11
Adaptador	64	1
Simulador	119	0
Capacitor Cerâmico 0805	6	1
Capacitor Cerâmico 0603	86	1
Diodo Schotcky SMD	160	1
Resistor 0.75W 1%	161	1
Resistor HVR37	162	1
Resistor 3W	76	1
Resistor SMD 1206 0.1%	8	1
besta	163	13
Conector Phoenix	166	1
Transistor IGBT	167	1
Triac	168	1
RESISTOR SMD 1206 5%	169	1
BC	170	1
Fio	144	1
flat	173	1
Soquete	39	1
Diodo LED	23	1
Conector	11	1
Placa Módulo	179	1
TIC263D	175	1
Half Bridge	176	1
DCDC	180	1
Capacitor Eletrolítico SMD	181	1
Conector CH	182	1
Conector IDC	183	1
Barra de Pinos Dupla	184	1
Diodo LED SMD	185	1
Resistor SMD 0805	1	1
Filtro EMI	186	1
ACDC	187	1
Resistor SMD 0603	188	1
Resistor SMD 1206	189	1
Resistor	190	1
Termistor	191	1
LED PTH	97	0
Placa de Avaliação	192	2
Capacitores de Segurança	194	1
Fotoacoplador	195	1
Resistor SMD	196	1
\.


--
-- Data for Name: labels; Type: TABLE DATA; Schema: public; Owner: jrm
--

COPY public.labels (id, location_entry_id, box, user_id) FROM stdin;
462	136	1	1
463	136	1	1
\.


--
-- Data for Name: listing; Type: TABLE DATA; Schema: public; Owner: jrm
--

COPY public.listing (id, component_id, quant) FROM stdin;
1	249	10
\.


--
-- Data for Name: location_entry; Type: TABLE DATA; Schema: public; Owner: jrm
--

COPY public.location_entry (id, location_id, component_id, quant_unit, quant_min, quant, labels, box, supcode_id) FROM stdin;
1766	107	586	0	0	0		4	1164
1785	107	599	0	0	0		5	1168
1793	107	606	0	0	0		5	1176
1739	107	373	0	0	0		2	1088
2183	111	71	7	0	0	  	2	1426
792	81	415	0	0	41		5	1111
273	81	345	0	0	19		1	1077
274	81	419	0	0	5		1	1261
275	81	416	0	0	15		1	1266
278	81	346	0	0	25		1	272
266	81	351	0	0	2		1	156
333	81	552	0	0	1		4	93
334	81	269	0	0	3		4	818
331	81	279	0	0	12	 	4	820
327	81	244	0	0	4		4	694
336	81	220	0	0	2		4	587
323	81	236	0	0	2		4	639
329	81	238	0	0	4		4	651
325	81	228	0	0	7		4	584
322	81	231	0	0	0		4	648
321	81	230	0	0	3		4	161
320	81	215	0	0	3		4	661
324	81	237	0	0	1		4	654
319	81	222	0	0	8		4	667
1138	74	1251	0	0	50		1	848
1151	74	1261	0	0	5		1	463
1141	74	197	0	0	20		1	109
1142	74	1254	0	0	10		1	456
1152	74	412	0	0	10		1	673
1153	74	183	0	0	10		1	473
1170	74	1276	0	0	10		1	485
1150	74	1260	0	0	6		1	462
1162	74	1269	0	0	3		1	478
1163	74	1270	0	0	3		1	479
1149	74	1259	0	0	1		2	461
1148	74	15	0	0	3		2	166
1129	74	28	0	0	50		2	519
1145	74	1257	0	0	10		2	459
1171	74	1277	0	0	10		2	486
1164	74	1271	0	0	2		2	480
1136	74	659	0	0	50		2	947
1126	74	1249	0	0	50		2	451
1128	74	99	0	0	20		2	953
1127	74	27	0	0	50		2	52
1130	74	1278	0	0	50		2	534
1135	74	1250	0	0	50		3	452
1174	82	64	4	0	9	 C1 C8 C18 C20 CD1B	1	489
1159	74	38	0	0	9	 	3	475
1161	74	1267	0	0	10		3	476
1165	74	1272	0	0	15		3	481
1175	82	1251	3	0	15	  C17 C21 C28	1	848
1177	82	1280	6	0	10	 C2 C3 C4 C30 C34 C35	1	847
1179	82	1282	2	0	10	 C38 C39	1	494
1178	82	1281	2	0	10	 C36 C37	1	493
1197	82	186	1	0	2	  U4	1	510
1176	82	1279	1	0	10	 C23	1	491
1195	82	1289	1	0	5	  U2	1	508
1205	82	184	1	0	6	  U23	1	17
1196	82	88	2	0	3	   U3 U5	1	960
1198	82	1290	2	0	6	  U6 U16	1	511
1199	82	1291	3	0	6	  U8 U9 U10	1	512
1186	82	1260	2	0	9	  ISO4 ISO7	1	462
1193	82	39	2	0	20	  Q4 Q5	1	506
1212	82	117	1	0	50	 R54	1	950
1221	82	1301	1	0	50	 R57	1	530
1218	82	1299	1	0	50	 R47	1	527
1222	82	1302	2	0	50	 RR53 R64	1	533
1194	82	515	3	0	6	  Q3 Q6 Q7	1	507
1621	23	724	0	0	0		2	1325
1648	23	1056	0	0	0		3	1462
1673	23	774	0	0	0		4	1235
1649	23	738	0	0	0		3	1479
593	23	816	0	0	23		1	1297
83	0	151	0	0	0		1	1301
116	0	1090	0	0	24		1	237
70	0	468	0	0	0		1	150
65	0	445	0	0	0		1	89
14	0	885	0	0	1		1	199
80	0	438	0	0	0		1	669
78	0	842	0	0	0		1	152
71	0	470	0	0	0		1	168
100	0	1077	0	0	2		1	310
106	0	1074	0	0	4		1	311
97	0	41	0	0	76		1	120
63	0	436	0	0	0		1	191
23	0	42	0	0	100		1	121
31	0	57	0	0	74		1	257
94	0	188	0	0	0		1	184
50	0	187	0	0	0		1	23
57	0	200	0	0	0		1	25
58	0	201	0	0	0		1	16
90	0	178	0	0	50		1	20
46	0	177	0	0	1		1	11
45	0	152	0	0	0		1	337
105	0	1073	0	0	148		1	329
104	0	1072	0	0	89		1	330
42	0	138	0	0	10		1	123
64	0	443	0	0	0		1	37
15	0	35	0	0	4		1	358
114	0	1104	0	0	16		1	364
20	0	34	0	0	0		1	77
88	0	932	0	0	0		1	139
86	0	929	0	0	0		1	134
87	0	930	0	0	0		1	136
85	0	928	0	0	0		1	132
113	0	1126	0	0	1		1	385
267	81	315	0	0	47		1	155
806	81	83	0	0	2		5	324
808	81	110	0	0	58		5	326
807	81	82	0	0	23		5	328
809	81	109	0	0	84		5	327
1182	82	1285	1	0	3	 C22	1	735
1144	74	1256	0	0	10		1	458
1154	74	1262	0	0	2		1	464
1155	74	886	0	0	5		2	200
1166	74	1273	0	0	2		2	482
1131	74	643	0	0	50		3	59
1132	74	114	0	0	50		3	66
1133	74	648	0	0	50		3	448
1168	74	1268	0	0	10		3	477
1190	82	594	1	0	5	  IC1	1	503
1180	82	1283	1	0	10	 C40	1	495
1224	82	1278	1	0	50	 R67	1	534
1191	82	1288	2	0	10	 JP12 JP19	1	505
1226	82	660	0	0	50		1	948
1215	82	1297	0	0	50		1	524
1192	82	38	0	0	20		1	475
1375	92	649	3	0	0	R65 R68 R94	1	1357
2564	137	1538	0	0	3		1	1664
1965	25	923	0	0	0		5	1305
631	25	301	0	0	2		1	1045
1943	25	997	0	0	0		3	1388
2279	115	1307	4	0	0	  	1	1571
2242	114	1381	0	0	5	 	1	1591
2617	138	1583	0	0	3		4	1703
2576	138	1549	0	0	40		1	1675
2191	112	984	2	0	0	  R8 R18	1	1374
146	0	1170	0	0	0		1	1495
2996	153	0	30	0	0		1	1775
143	0	1148	0	0	0		1	403
117	0	1091	0	0	2		1	239
134	0	1137	0	0	0		1	271
137	0	1135	0	0	0		1	305
127	0	1103	0	0	0		1	248
144	0	1158	0	0	0		1	405
120	0	1094	0	0	0		1	244
123	0	1097	0	0	0		1	246
119	0	1093	0	0	58		1	242
121	0	1095	0	0	28		1	241
122	0	1096	0	0	0		1	243
155	0	892	0	0	0		1	209
135	0	1124	0	0	0		1	297
136	0	1125	0	0	0		1	299
139	0	1152	0	0	0		1	398
138	0	1150	0	0	0		1	399
128	0	1107	0	0	5		1	354
129	0	1110	0	0	0		1	362
131	0	1112	0	0	0		1	371
132	0	1113	0	0	0		1	276
156	2	119	0	0	20		1	8
175	2	116	0	0	84		1	43
163	2	99	0	0	164		1	953
176	2	644	0	0	102		1	49
174	2	651	0	0	77		1	58
169	2	643	0	0	63		1	59
172	2	112	0	0	5		1	62
160	2	648	0	0	115		1	448
173	2	650	0	0	49		1	72
171	2	100	0	0	86		1	73
166	2	98	0	0	216		1	2
161	2	847	0	0	79		1	189
170	2	115	0	10	18		1	560
167	2	38	0	20	64		1	475
1811	35	246	0	0	0		2	632
1813	35	223	0	0	0		2	634
1809	35	947	0	0	0		2	701
1806	35	695	0	0	0		2	343
1807	35	700	0	0	0		2	675
1810	35	710	0	0	0		2	676
2141	19	97	0	0	0		4	499
2143	19	728	0	0	0		4	45
2142	19	160	0	0	0		4	46
357	11	1163	0	0	10		1	426
356	11	357	0	0	28		1	424
424	11	558	0	0	21		5	695
428	11	128	0	0	55		5	282
426	11	493	0	0	14		5	570
423	11	474	0	0	20		5	202
414	11	554	0	0	10		5	629
419	11	562	0	0	10		5	631
416	11	559	0	0	20		5	666
421	11	564	0	0	10		5	637
354	11	208	0	0	41		1	414
349	11	363	0	0	8		1	776
2034	48	533	0	0	0		2	173
2042	48	205	0	0	0		2	126
2041	48	537	0	0	0		2	97
2040	48	1123	0	0	0		2	294
2023	48	107	0	0	0		2	342
596	23	155	0	0	35		1	1340
1924	35	844	0	0	0		6	1274
1830	35	788	0	0	0		3	1243
1879	35	1038	0	0	0		5	1439
491	19	623	0	0	4		1	1185
2134	19	849	0	0	0		4	1276
2118	19	676	0	0	0		3	1480
2507	119	499	0	0	10		8	1166
2447	119	1457	0	0	20		5	1611
422	11	566	0	0	2		5	1153
399	11	834	0	0	3		3	1270
344	11	368	0	0	45		1	1085
2331	118	1402	3	0	2	   U9, U10, U15, U16	1	1649
2694	139	1609	2	0	0	Q2,Q3	1	1739
2997	153	0	6	0	0		1	1776
599	23	371	0	0	3		1	845
1825	35	88	0	0	0		2	960
1823	35	102	0	0	0		2	794
1824	35	702	0	0	0		2	344
1817	35	704	0	0	0		2	345
1968	25	956	0	0	0		5	224
1967	25	957	0	0	0		5	262
645	25	93	0	0	11		1	111
621	25	289	0	0	3		1	181
1989	25	692	0	0	0		6	622
1984	25	715	0	0	0		6	625
1987	25	690	0	0	0		6	626
1982	25	713	0	0	0		6	790
1986	25	719	0	0	0		6	393
507	19	616	0	0	18		1	280
510	19	482	0	0	24		1	834
509	19	113	0	0	16		1	394
506	19	528	0	0	5		1	612
508	19	641	0	0	10		1	638
499	19	633	0	0	25		1	664
512	19	183	0	0	20		1	473
2144	19	1115	0	0	0		5	434
2145	19	136	0	0	0		5	436
2146	19	1116	0	0	0		5	438
2149	19	1117	0	0	0		5	289
2147	19	1118	0	0	0		5	440
355	11	165	0	0	5		1	430
651	26	79	0	0	39		1	303
1902	35	486	0	0	0		6	1126
2861	149	1623	3	0	0	U6,U9,U10	1	1727
1026	61	1176	0	0	10		1	1500
723	35	249	0	0	74		1	160
740	35	727	0	0	0		1	686
742	35	726	0	0	0		1	691
729	35	242	0	0	1		1	734
731	35	253	0	0	4		1	607
733	35	258	0	0	13		1	614
738	35	551	0	0	3		1	85
737	35	265	0	0	23		1	611
1906	35	495	0	0	0		6	596
736	35	219	0	0	4		1	610
1900	35	481	0	0	0		6	658
1901	35	485	0	0	0		6	633
726	35	225	0	0	17		1	619
728	35	251	0	0	10		1	642
732	35	216	0	0	6		1	645
735	35	261	0	0	9		1	652
1893	35	472	0	0	0		6	660
1997	25	706	0	0	0		6	185
1999	25	1214	0	0	0		6	367
919	50	1144	0	0	333		1	397
922	50	1151	0	0	20		1	400
1016	61	1088	0	0	6		1	264
1019	61	1147	0	0	166		1	402
1018	61	1089	0	0	9		1	266
1051	64	1145	0	0	152		1	401
954	52	8	0	0	9		1	100
1054	65	1063	0	0	4		1	309
900	48	432	0	0	7		1	95
913	48	534	0	0	71		1	175
901	48	535	0	0	107		1	176
910	48	458	0	0	180		1	180
899	48	435	0	0	4		1	98
2066	48	1119	0	0	0		5	351
2069	48	1134	0	0	0		5	304
2068	48	1127	0	0	0		5	383
2084	48	660	0	0	0		6	948
2083	48	661	0	0	180	 	6	65
2081	48	1238	0	0	0		5	431
2067	48	114	0	0	0		5	66
2082	48	1239	0	0	0		5	439
2080	48	1236	0	0	0		5	411
2065	48	1237	0	0	0		5	418
2063	48	1240	0	0	0		5	444
2064	48	1241	0	0	0		5	446
2074	48	1108	0	0	0		5	360
2079	48	1161	0	0	0		5	422
2072	48	1109	0	0	0		5	352
2076	48	1106	0	0	0		5	365
2077	48	1129	0	0	0		5	376
2073	48	1105	0	0	0		5	377
2075	48	1132	0	0	0		5	378
2071	48	1131	0	0	0		5	384
2773	146	1638	4	0	0	PL3, PL4	1	1726
927	50	1184	0	0	5		1	1518
1068	66	1196	0	0	4		1	1537
2030	48	1022	0	0	0		2	1409
2031	48	1023	0	0	0		2	1410
2047	48	979	0	0	0		3	1371
1231	87	426	1	0	0	 C7	1	1118
1230	87	64	4	0	0	C4 C11 C13 C16	1	489
1247	87	93	2	0	10	 C6 C17	1	111
1234	87	213	2	0	0	 U4 U5	1	516
1252	87	80	1	0	2	 U3	1	386
1249	87	96	2	0	10	R1 R19	1	340
1244	87	1299	1	0	0	R9	2	527
1268	87	23	1	0	11	SEP1	2	26
1241	87	1306	2	0	50	 R2 R18	2	731
1260	87	1310	3	0	1	F1 F2 F3	2	537
1236	87	464	1	0	4	 Q1	2	187
1259	74	1310	0	0	9		3	537
1273	88	21	5	0	0	C1 C2 C3 C4 C5	1	846
1275	88	839	1	0	0	U4	1	562
727	35	240	0	0	0	 	1	764
1842	35	794	0	0	0		3	708
1841	35	793	0	0	0		3	707
1843	35	784	0	0	0		3	709
1255	11	0	0	0	0		3	868
1838	35	792	0	0	0		3	703
1845	35	785	0	0	0		3	715
1844	35	803	0	0	0		3	710
1839	35	802	0	0	0		3	704
664	11	91	0	0	57		4	112
652	11	553	0	0	9		4	275
667	11	33	0	0	2		4	141
669	11	539	0	0	4		4	278
403	11	937	0	0	19		3	356
408	11	185	0	0	5		3	369
406	11	399	0	0	6		3	387
1256	11	447	0	0	3		3	419
409	11	397	0	0	5		3	263
404	11	938	0	0	2		3	437
407	11	398	0	0	1		3	443
1220	82	646	3	0	50	  R52 R76 R92	2	529
1258	11	1310	0	0	1		3	537
1203	82	1294	1	0	5	  U15	2	515
1206	82	1295	1	0	3	  U29	2	518
1183	82	92	7	0	40	   D1 D2 D8 D15 D16 D17 D18	2	936
1184	82	97	0	0	10		2	499
1187	82	1286	1	0	5	 D12	2	500
1185	82	1287	1	0	10	 D13	2	501
1189	82	1277	6	0	20	 FB1 FB3 FB4 FB6 FB7 FB8	2	486
1225	82	1304	1	0	3	  R75	2	536
1216	82	1298	2	0	6	   R42 R56	2	525
1223	82	1303	1	0	10	 R65	2	535
1217	82	653	2	0	50	 R45 R60	2	526
1209	82	28	2	0	50	 R82 R84	2	519
1074	67	1166	0	0	1		1	429
2094	48	653	0	0	0		6	526
2102	48	26	0	0	0		6	954
2103	48	647	0	0	0		6	866
2088	48	461	0	0	0		6	102
2093	48	656	0	0	0		6	67
2097	48	662	0	0	0		6	238
2100	48	665	0	0	0		6	355
2092	48	655	0	0	0		6	357
2095	48	652	0	0	0		6	363
2089	48	663	0	0	0		6	366
2087	48	666	0	0	0		6	368
2090	48	658	0	0	0		6	370
2976	150	0	1	0	0		1	1755
3000	153	0	2	0	0	C20,C21	1	1778
1237	87	717	1	0	2	U1	1	1736
1239	87	125	1	0	6	 U6	1	6
1242	87	646	1	0	44	R5	1	529
1251	87	1305	1	0	6	 U2	1	732
1263	87	433	2	0	0	D1 D2	1	169
1269	87	1314	1	0	0	R10	1	867
1245	87	968	8	0	50	 R3 R6 R7 R11 R12 R13 R14 R15 	2	228
1636	23	159	0	0	0		3	353
1381	93	64	2	0	0	C26 C27	1	489
1393	93	80	1	0	0	U16	1	386
1395	93	1326	1	0	0	U5	1	547
1388	93	88	1	0	0	U10	1	960
1386	93	1260	1	0	0	U4	1	462
1387	93	1333	1	0	0	U7	1	557
1392	93	839	1	0	0	U14	1	562
1389	93	1320	1	0	0	JP1	1	541
1390	93	1321	2	0	0	CN1 CN2	1	542
1391	93	1322	2	0	0	EXTERNOS	1	543
1385	93	24	1	0	0	R11	1	949
1383	93	1296	1	0	0	R10	1	522
1396	93	115	1	0	0	Q3	1	560
1397	93	965	1	0	0	Q2	1	561
1424	89	153	1	0	0	C15	1	809
1459	89	64	2	0	0	 C26 C27	1	489
1431	89	1119	8	0	0	R5 R14 R24 R31 R41 R48 R55 R61	1	351
1457	89	80	1	0	0	U16	1	386
1461	89	1326	2	0	0	U2 U5	1	547
1452	89	88	1	0	0	U10	1	960
1450	89	1260	3	0	0	U1 U13 U4	1	462
1451	89	1333	1	0	0	U7	1	557
1435	89	1329	4	0	0	U3 U8 U12 U15	1	550
1437	89	1336	1	0	0	U6	1	564
1438	89	1332	1	0	0	U11	1	555
1433	89	1330	1	0	0	U9	1	551
1456	89	839	1	0	0	U14	1	562
1453	89	1320	1	0	0	JP1	1	541
1454	89	1321	2	0	0	CN1 CN2	1	542
1429	89	659	8	0	0	R8 R17 R27 R34 R40 R47 R54 R59	1	947
1449	89	24	1	0	0	R11	1	949
1425	89	99	5	0	0	R13 R22 R23 R1 R44	1	953
1428	89	643	2	0	0	R18 R37	1	59
1486	89	1308	32	0	0	   R2 R3 R6 R7 R9 R12 R15 R16 R20 R21 R25 R26 R28 R30 R32 R33 R35 R36 R38 R39 R42 R43 R46 R49 R50 R51 R52 R53 R56 R57 R58 R60 	1	566
1464	89	1296	2	0	0	R4 R10	1	522
1378	92	95	3	0	0	R70 R76 R93	1	449
1462	89	115	2	0	0	Q1 Q3	1	560
1463	89	965	1	0	0	Q2	1	561
1374	92	21	10	0	0	C30 C31 C32 C33 C34 C35 C51 C52 C54 C55 	1	846
1366	92	1327	3	0	0	U19 U21 U37	1	548
1370	92	1260	1	0	0	U40	1	462
1380	92	1333	1	0	0	U18	1	557
1368	92	1335	1	0	0	U36	1	563
1369	92	1329	1	0	0	U20	1	550
1377	92	659	3	0	0	R73 R74 R95	1	947
1376	92	99	3	0	0	R66 R67 R97	1	953
1478	90	64	3	0	0	C3 C26 C27	1	489
1411	90	1324	2	0	0	U26 U31	1	545
1476	90	80	1	0	0	U16	1	386
1406	90	186	1	0	0	U17	1	510
1410	90	1325	1	0	0	U29	1	546
1412	90	1334	2	0	0	U30 U33	1	558
1418	90	1327	2	0	0	U25 U28	1	548
1416	90	144	1	0	0	U35	1	30
1417	90	1326	2	0	0	U5 U24	1	547
1414	90	145	2	0	0	U38 U41	1	10
1415	90	1318	1	0	0	U39	1	539
1407	90	1276	1	0	0	U22	1	485
1471	90	88	1	0	0	U10	1	960
1413	90	1328	2	0	0	U27 U34	1	549
1408	90	1260	2	0	0	U4 U32	1	462
1409	90	1333	2	0	0	U7 U23	1	557
1475	90	839	1	0	0	U14	1	562
1472	90	1320	1	0	0	JP1	1	541
1473	90	1321	2	0	0	CN1 CN2	1	542
1474	90	1322	2	0	0	EXTERNOS	1	543
1399	90	24	11	0	0	R11 R64 R82 R84 R85 R86 R89 R90 R91 R92 R96	1	949
1401	90	99	5	0	0	R13 R22 R23 R79 R80	1	953
1400	90	644	1	0	0	R88	1	49
1404	90	23	8	0	0	R62 R63 R69 R71 R72 R75 R77 R78	1	26
1402	90	1296	2	0	0	R10 R87	1	522
1280	88	1319	1	0	0	U3	1	540
1421	90	115	2	0	0	Q3 Q5	1	560
1482	90	965	2	0	0	Q4 Q2	1	561
1278	88	1318	1	0	0	U1	1	539
1279	88	184	1	0	0	U2	1	17
1270	88	28	4	0	0	R1 R2 R3 R4	1	519
1281	88	208	1	0	0	JP4	1	414
1276	88	66	1	0	0	Z1	1	5
1848	35	779	0	0	0		3	170
668	11	153	0	0	0		4	809
1202	82	1293	3	0	10	  U3 U14 U17	2	963
1572	107	576	0	0	0		1	1564
1566	107	578	0	0	0		1	1160
2977	138	0	1	0	1		1	1507
3001	153	0	5	0	0	C24,C25,C26,C28,C29	1	1779
1493	87	1340	0	0	1	 	2	969
1491	87	242	0	0	5	 	2	734
1492	87	1278	0	0	50	 	2	534
1494	87	1341	0	0	4	 	2	737
1490	87	1339	0	0	17	 	2	736
1569	107	403	0	0	0		1	216
1637	23	184	0	0	0		3	17
1618	23	820	0	0	0		2	226
1619	23	821	0	0	0		2	225
1488	89	1338	8	0	0	  R5 R14 R24 R31 R41 R48 R55 R61 	1	766
1928	35	9	0	0	0		6	822
1912	35	510	0	0	0		6	657
1920	35	530	0	0	0		6	650
1922	35	843	0	0	0		6	665
1849	35	1122	0	0	0		3	417
1855	35	902	0	0	0		4	217
1862	35	455	0	0	0		4	220
1860	35	454	0	0	0		4	218
1852	35	456	0	0	0		4	222
1863	35	855	0	0	0		4	221
1851	35	856	0	0	0		4	223
1850	35	850	0	0	0		3	307
1857	35	897	0	0	0		4	211
1868	35	1058	0	0	0		4	802
1854	35	891	0	0	0		4	208
1866	35	890	0	0	0		4	206
1864	35	899	0	0	0		4	214
1865	35	900	0	0	0		4	213
1872	35	1245	0	0	0		4	373
1858	35	953	0	0	0		4	230
1859	35	952	0	0	0		4	229
1926	35	56	0	0	0		6	107
1870	35	901	0	0	0		4	215
1915	35	515	0	0	0		6	507
2106	19	197	0	0	0		3	109
2114	19	848	0	0	0		3	723
2117	19	678	0	0	0		3	412
2123	19	28	0	0	0		3	519
2115	19	949	0	0	0		3	717
2120	19	683	0	0	0		3	339
2121	19	29	0	0	0		3	61
2112	19	25	0	0	0		3	27
2110	19	681	0	0	0		3	76
2119	19	39	0	0	0		3	506
1512	82	2	6	0	0	 R97 R98 R99 R107 R108 R109 	4	42
1497	82	1343	3	0	0	 JP10 JP11  JP15	3	739
1509	82	1350	2	0	0	 JP13 JP14	4	854
1499	82	1344	1	0	0	  JP6	3	740
1498	82	853	3	0	0	 JP10* JP11* JP15*	3	219
1510	82	855	3	0	0	 JP13* JP14*	4	221
1500	82	1345	1	0	0	 JP6* 	3	741
1506	82	82	2	0	0	 DS2 DS3	3	328
1511	82	1339	3	0	0	 D10 D11 D14	4	736
1219	82	1300	8	0	30	 R48(2) R49(2) R50(2) R51(2)	2	528
1514	82	98	1	0	0	 R5	4	2
915	48	96	0	0	195		1	340
1736	107	402	0	0	0		2	1267
2978	138	0	1	0	1		1	1505
3002	153	0	4	0	0	D4,D5,D9,D10	1	1780
1710	23	442	0	0	0		6	82
1680	23	775	0	0	0		4	268
1683	23	430	0	0	0		5	138
1721	23	90	0	0	0		6	157
1685	23	877	0	0	0		5	193
1686	23	203	0	0	0		5	83
1726	23	80	0	0	0		6	386
1701	23	1100	0	0	0		5	245
1707	23	837	0	0	0		6	81
1646	23	77	0	0	0		3	18
1651	23	144	0	0	0		3	30
1652	23	145	0	0	0		3	10
1690	23	875	0	0	0		5	288
1704	23	869	0	0	0		5	290
1691	23	840	0	0	0		5	153
1702	23	873	0	0	0		5	782
1687	23	883	0	0	0		5	196
1694	23	839	0	0	0		5	562
1697	23	19	0	0	0		5	103
1700	23	20	0	0	0		5	165
1653	23	433	0	0	0		3	169
1654	23	162	0	0	0		3	118
1642	23	807	0	0	0		3	712
1706	23	439	0	0	0		6	94
1709	23	446	0	0	0		6	192
1647	23	741	0	0	0		3	232
1677	23	431	0	0	0		4	99
1728	23	95	0	0	0		6	449
1722	23	2	0	0	0		6	42
1711	23	142	0	0	0		6	63
1725	23	1133	0	0	0		6	379
1714	23	968	0	0	0		6	228
1719	23	972	0	0	0		6	231
1716	23	969	0	0	0		6	234
1717	23	971	0	0	0		6	235
1713	23	933	0	0	0		6	140
1720	23	934	0	0	0		6	144
1650	23	65	0	0	0		3	4
1656	23	66	0	0	0		3	5
1681	23	878	0	0	0		5	677
1723	23	451	0	0	0		6	792
1724	23	838	0	0	0		6	195
1939	25	887	0	0	0		3	204
2011	19	555	0	0	0		2	679
2016	19	1054	0	0	0		2	720
2010	19	444	0	0	0		2	91
2003	19	125	0	0	0		2	6
2009	19	10	0	0	0		2	35
2019	19	46	0	0	0		2	31
2020	19	50	0	0	0		2	388
2013	19	51	0	0	0		2	28
2006	19	284	0	0	0		2	33
2018	19	976	0	0	0		2	442
1791	107	605	0	0	0		5	1174
3003	153	0	4	0	0	FB1,FB3,FB7,FB9	1	896
1803	107	594	0	0	0		5	503
1802	107	254	0	0	0		5	301
1776	107	593	0	0	0		4	201
1778	107	527	0	0	0		4	599
1771	107	591	0	0	0		4	649
1761	107	580	0	0	0		4	647
1770	107	590	0	0	0		4	630
1782	107	597	0	0	0		5	644
1772	107	592	0	0	0		4	640
1799	107	607	0	0	0		5	659
1784	107	598	0	0	0		5	621
1768	107	588	0	0	0		4	655
1774	107	521	0	0	0		4	656
1775	107	524	0	0	0		4	623
1783	107	498	0	0	0		5	628
1800	107	614	0	0	0		5	813
1744	107	722	0	0	0		2	409
1750	107	14	0	0	0		2	406
1752	107	1159	0	0	0		2	408
1751	107	15	0	0	0		2	166
1749	107	466	0	0	0		2	186
2169	111	62	16	0	0	 	1	110
2170	111	1360	2	0	0	 	1	751
2172	111	1362	1	0	0	 	1	805
2154	111	1351	4	0	0	 	1	743
2164	111	1356	1	0	0	 	1	748
2173	111	50	1	0	0	 	1	388
2155	111	1352	1	0	0	 	1	744
2156	111	279	1	0	0	 	1	820
2160	111	1354	1	0	0	 	1	746
2159	111	1269	1	0	0	 	1	478
1892	35	170	0	0	0		5	124
1970	19	133	0	0	0		6	267
1972	19	858	0	0	0		6	254
1971	19	132	0	0	0		6	183
2022	19	282	0	0	0		2	762
2129	19	199	0	0	0		4	935
2021	19	285	0	0	0		2	34
2137	19	27	0	0	0		4	52
2133	19	685	0	0	0		4	55
2138	19	30	0	0	0		4	64
2127	19	118	0	0	0		4	74
2128	19	686	0	0	0		4	75
2241	114	1379	0	0	4	 	1	756
2223	113	853	1	0	0	 CN2	1	219
2221	113	363	1	0	0	  U2	1	776
2180	111	1365	4	0	0	 	1	1650
2165	111	1357	1	0	0	 	2	1578
3004	153	0	4	0	0	FB2,FB4,FB6,FB8	1	1781
2177	111	1117	3	0	0	  	1	289
2176	111	1364	2	0	0	 	1	754
2163	111	850	1	0	0	 	2	307
2174	111	896	1	0	0	 	2	210
2162	111	42	3	0	0	 	2	121
2181	111	533	1	0	0	 	2	173
2184	111	536	5	0	0	 	2	177
2295	19	0	0	0	0		1	868
2166	111	1358	1	0	0	 	2	798
2122	19	680	0	0	2	 	3	295
2273	115	64	4	0	0	 	1	489
2289	115	62	1	0	0	 	1	110
2272	115	1361	1	0	0	 	1	752
2288	115	213	1	0	0	 	1	516
2267	115	254	1	0	0	 	1	301
2264	115	1389	2	0	0	 	1	826
2268	115	455	1	0	0	  	1	220
2265	115	109	3	0	0	 	1	327
2280	115	662	2	0	0	 	1	238
2281	115	159	3	0	0	  	1	353
2277	115	968	1	0	0	 	1	228
2276	115	971	3	0	0	 	1	235
2283	115	98	2	0	0	 	1	2
2293	115	363	1	0	0	 	1	776
2259	115	706	3	0	0	 	1	185
2226	114	0	0	0	0		1	868
2262	115	451	2	0	0	 	1	792
2261	115	713	3	0	0	 	1	790
2232	114	224	0	0	2	 	1	618
2236	114	442	0	0	3	 	1	82
2253	114	607	0	0	12	 	1	659
2251	114	238	1	0	8	   	1	651
2252	114	216	0	0	4	 	1	645
2254	114	582	0	0	4	 	1	627
2302	118	1282	2	0	34	  C35, C36	1	494
2326	118	1264	1	0	4	    U7	1	964
2197	112	346	1	0	0	  C2	1	272
2189	112	33	2	0	0	  C1 C25	1	141
2192	112	265	1	0	0	  U1	1	611
2206	112	240	16	0	0	 U4	1	764
2203	112	1350	1	0	0	  JP1	1	854
2204	112	855	1	0	0	 JP1	1	221
2199	112	779	1	0	0	  D2	1	170
2194	112	533	2	0	0	  R4 R5	1	173
2196	112	458	1	0	0	  R1	1	180
2195	112	1314	1	0	0	  R6	1	867
2205	112	363	3	0	0	   U1 U4 U10	1	776
2310	116	157	1	0	19	  C41	1	808
2355	116	88	2	0	6	    U2, U4	1	960
2218	113	64	2	0	0	 C2 C4	1	489
2217	113	21	4	0	0	 C3 C5 C6 C7	1	846
2208	113	213	1	0	0	  U1	1	516
2209	113	594	1	0	0	  U3	1	503
2215	113	2	1	0	0	 R6	1	42
2212	113	219	1	0	0	 U2	1	610
2224	113	454	1	0	0	 CN2	1	218
2255	71	680	0	0	4	 	6	295
2216	113	647	19	0	0	 R7	1	866
2210	113	648	5	0	0	 R1 R2 R3 R4 R5	1	448
2258	71	1388	0	0	5	 	6	758
598	23	150	0	0	53	 	1	1399
2981	153	0	5	0	0		1	1759
3005	153	0	1	0	0	LED1	1	1782
2431	119	153	0	0	20		4	809
2434	119	1448	0	0	10		4	812
2429	119	1395	0	0	20		4	807
2432	119	1396	0	0	20		4	810
2428	119	1446	0	0	5		4	806
2426	119	1361	0	0	10		4	752
2436	119	326	0	0	1		4	274
2392	119	282	0	0	7		2	762
2522	119	1481	0	0	10		8	827
2388	119	1415	0	0	20		2	763
2401	119	1433	0	0	4		2	786
2404	119	1436	0	0	9		2	789
2402	119	1434	0	0	5		2	787
2394	119	1400	0	0	10		2	779
2398	119	1401	0	0	5	 	2	783
2400	119	1432	0	0	12		2	785
2399	119	1431	0	0	10		2	784
2397	119	873	0	0	5		2	782
2377	119	208	0	0	6		1	414
2378	119	165	0	0	1		1	430
2375	119	455	0	0	9		1	220
2376	119	454	0	0	23		1	218
2373	119	855	0	0	19		1	221
2420	119	1443	0	0	41	 	3	800
2421	119	1405	0	0	20		3	801
2422	119	1058	0	0	6		3	802
2424	119	1445	0	0	10	 	3	804
2425	119	1271	0	0	3		3	480
2381	119	1424	0	0	8		1	771
2382	119	1425	0	0	10		1	772
2384	119	1390	0	0	3		1	774
2385	119	1427	0	0	6		1	775
2366	119	1418	0	0	46	 	1	765
2368	119	1420	0	0	50		1	768
2371	119	1422	0	0	300		1	770
2372	119	1308	0	0	50		1	566
2370	119	1421	0	0	50		1	769
2367	119	1419	0	0	50		1	767
2386	119	363	0	0	21	 	2	776
2365	119	1414	0	0	8	   	3	759
2419	119	1442	0	0	100		3	799
2408	119	451	0	0	15		3	792
2413	119	1437	0	0	8		3	793
2325	118	213	1	0	0	  U6	1	516
2417	119	1441	0	0	10		3	797
2407	119	713	0	0	17		3	790
2416	119	1440	0	0	10		3	796
2415	119	1438	0	0	2		3	795
2301	118	1395	6	0	0	    C34, C38, C41, C42, C45, C46. C37?	1	807
2303	118	1396	1	0	9	  C39	1	810
2324	118	1400	1	0	9	   U3	1	779
2332	118	88	1	0	19	   U14	1	960
2330	118	1354	1	0	9	   U11	1	746
2322	118	1329	4	0	6	   U1, U2, U4, U5	1	550
2327	118	1269	1	0	9	   U8	1	478
2316	118	659	8	0	0	 R46-R53	1	947
2317	118	24	1	0	0	  R54	1	949
2319	118	1128	2	0	0	 R56, R57	2	380
2315	118	970	3	0	47	 R43, R44, R45	2	523
2314	118	971	42	0	0	 R1-R42	2	235
2321	118	668	1	0	0	 R58	2	80
1214	82	970	0	0	3		1	523
2309	116	1251	10	0	50	 C8-C12, C16, C18, C20, C21, C22	1	848
2306	116	1280	6	0	23	   C4 C14 C19 C24 C29 C36	1	847
2296	116	1282	1	0	0	 C1	1	494
2311	116	153	1	0	9	  C42	1	809
2359	116	213	1	0	0	   U14	1	516
2304	116	1395	4	0	0	  C2, C28, C39, C45	1	807
2312	116	1396	1	0	0	 C44	1	810
2360	116	727	1	0	0	 U12	1	686
2343	116	664	2	0	46	   R5, R11	2	532
2358	116	1264	1	0	0	 U10	1	964
2338	116	41	1	0	0	 FB	1	120
2345	116	1390	1	0	0	 R8	2	774
2340	116	659	10	0	13	     R1, R10, R15, R18, R22, R24, R27, R29, R45, R47	2	947
2349	116	24	3	0	46	 R16,   R21, R28, R30	2	949
2342	116	99	4	0	44	   R4, R7, R40, R42	2	953
2353	116	142	1	0	0	  R55	1	63
2362	116	656	2	0	0	  R2 R3	2	67
2352	116	117	10	0	0	 R46, R48 - R54, R56, R57	2	950
2346	116	23	1	0	0	 R9	2	26
2350	116	1296	6	0	44	  R26, R31, R34, R36, R41, R44	2	522
2333	73	884	0	0	1		1	198
2539	133	1346	2	0	0	  	1	1573
2529	23	1496	0	0	50		2	1648
2982	153	0	6	0	0		1	1760
3006	153	0	6	0	0	Q1	1	1757
2542	134	1527	1	0	0		1	1654
2544	134	1528	1	0	0		1	1655
2537	132	1526	1	0	0	 	1	1653
2536	132	1249	1	0	0	 	1	451
1160	74	1266	0	0	26	 	3	474
2540	133	1289	1	0	0	 	1	508
2504	119	558	0	0	8		8	695
2430	119	157	0	0	17	 	4	808
2449	119	213	0	0	14	 	5	516
2450	119	727	0	0	15		5	686
2451	119	1054	0	0	15		5	720
2452	119	726	0	0	15		5	691
2506	119	1483	0	0	9		8	829
2523	119	1479	0	0	10		8	824
2501	119	1480	0	0	1		8	825
2502	119	1389	0	0	3		8	826
2489	119	9	0	0	5		7	822
2491	119	1472	0	0	19		7	823
2475	119	474	0	0	1		7	202
2485	119	258	0	0	10		7	614
2486	119	279	0	0	11		7	820
2487	119	1470	0	0	3		7	821
2474	119	589	0	0	6		7	617
2477	119	220	0	0	1		7	587
2479	119	1468	0	0	5		7	816
2482	119	607	0	0	2		7	659
2481	119	1469	0	0	4		7	817
2478	119	524	0	0	2		7	623
2480	119	715	0	0	2		7	625
2483	119	498	0	0	1		7	628
2465	119	183	0	0	10		6	473
2468	119	1260	0	0	4		6	462
2461	119	1294	0	0	2		6	515
2469	119	614	0	0	2		6	813
2470	119	1466	0	0	2		6	814
2467	119	1295	0	0	2		6	518
2514	119	1344	0	0	1		4	740
2513	119	1345	0	0	2		4	741
2492	119	779	0	0	20		8	170
2509	119	84	0	0	6		8	502
2516	119	970	0	0	4		6	523
2517	119	106	0	0	44		6	843
2518	119	1301	0	0	36		6	530
2414	119	102	0	0	75	  	3	794
2457	119	702	0	0	98	 	5	344
2510	119	706	0	0	1		5	185
2584	138	1497	0	0	18	 	2	833
2572	138	1480	0	0	20		1	825
2530	82	112	0	0	6	 	2	62
2525	121	1490	0	0	100	 	1	832
2690	139	1606	1	0	8	PS1	1	1709
3007	153	0	6	0	0	Q2,Q3	1	903
2983	153	0	8	0	0		1	1761
2697	139	114	1	0	19	R7	1	66
2716	141	1284	1	0	0	C4	1	496
2731	141	1592	1	0	0	CN1	1	856
2722	141	1299	1	0	26	R7	1	527
2717	141	970	1	0	88	R2	1	523
2715	141	21	5	0	0	C3,C5,C6,C9,C10	1	846
2650	140	1596	1	0	0	MD1	1	860
2696	139	99	4	0	45	R2,R4,R6,R10	1	953
2627	140	2	1	0	0	R4	1	42
2729	141	1430	1	0	8	U3	1	781
2719	141	646	1	0	41	R4	1	529
2679	139	21	9	0	0	C1,C2,C3,C5,C6,C17,C18,C20,C21	1	846
2689	139	1596	1	0	23	MD1	1	860
2720	141	99	1	0	50	R5	1	953
2674	140	1280	1	0	0	C14	1	847
2685	139	1284	1	0	0	C19	1	496
2651	140	1597	1	0	0	PS1	1	861
2680	139	1280	1	0	0	C4	1	847
2625	140	24	7	0	50	 R13,R14,R20,R29,R33,R34	1	949
2621	140	1442	2	0	0	 Q2,Q7	1	799
2633	140	371	1	0	0	K1	1	845
2726	141	838	1	0	0	RV1	1	195
2684	139	1591	4	0	0	C13,C14,C15,C16	1	853
2632	140	1588	2	0	0	Q3,Q8	1	844
2693	139	1442	1	0	28	Q1	1	799
2702	139	1590	1	0	24	U1	1	959
2704	139	1545	1	0	35	U3	1	870
2707	139	282	1	0	28	U6	1	762
2709	139	1294	1	0	32	U8	1	515
2730	141	1405	1	0	38	FB1	1	801
2630	140	112	2	0	0	 R15,R19	1	62
2675	140	1251	3	0	0	C1,C2,C7	1	848
2701	139	659	1	0	0	R13	1	947
2714	141	1251	1	0	200	C1	1	848
2695	139	1296	3	0	24	R1,R3,R5	1	522
2700	139	24	2	0	32	R11,R12	1	949
2629	140	1587	2	0	0	C3,C4	1	927
2641	140	1362	2	0	0	C9	1	805
2619	140	1558	1	0	1	U1	1	838
2638	140	1590	1	0	0	U5	1	959
2645	140	1592	3	0	0	CN3,CN4,CN6	1	856
2676	140	92	5	0	0	D1,D2,D3,D4,D5	1	936
2648	140	1595	1	0	0	D6	1	859
2637	140	1589	1	0	0	U4	1	850
2622	140	965	4	0	0	Q1,Q4,Q5,Q6	1	561
2657	140	1314	2	0	0	R3,R12	1	867
2628	140	659	6	0	0	 R1,R2,R5,R8,R9,R21	1	947
2626	140	1586	3	0	0	R6,R7,R10	1	840
2631	140	106	3	0	0	 R11,R17,R32	1	843
2655	140	26	1	0	0	R31	1	954
2639	140	117	3	0	0	R18,R22,R23	1	950
2654	140	1599	2	0	0	SV1,SV2	1	864
293	81	324	0	0	3		2	281
2618	140	1294	1	0	0	 U2	1	515
1780	107	13	0	0	6	  	4	154
2589	138	0	0	0	0		2	868
2609	119	240	0	0	10		2	764
2610	119	242	0	0	6		2	734
2571	138	1545	0	0	3	 	1	870
2601	138	1289	0	0	20		3	508
2596	138	1294	0	0	6		3	515
2760	119	1409	0	0	2		2	1609
2741	141	1617	1	0	0	J1	1	1732
2807	146	99	1	0	0	R3	1	953
2740	141	1218	1	0	0	J2	1	1575
2776	140	1623	3	0	0	U6,U9,U10	1	1727
2758	140	1632	3	0	0	c/ CN1,CN15,CN18	1	1749
2754	140	1628	4	0	0	CN5,CN14,CN16,CN17	1	1751
2821	146	1629	1	0	0	J2	1	1747
3008	153	0	2	0	0	Q5,Q6	1	1783
2808	146	659	11	0	0	R5,R6,R7,R8,R37,R38,R39,R40,R69,R70,R71	1	947
2757	140	1631	4	0	0	c/ CN5,CN14,CN16,CN17	1	871
2809	146	1239	44	0	0	R9,R10,R11,R12,R13,R14,R15,R16,R17,R18,R19,R20,R21,R22,R23,R24,R41,R42,R43,R44,R45,R46,R47,R48,R49,R50,R51,R52,R53,R54,R55,R56,R72,R73,R74,R75,R76,R77,R78,R79,R80,R81,R82,R83	1	439
2806	146	117	8	0	0	R1,R2,R4,R93,R95,R96,R97,R98	1	950
2810	146	112	22	0	0	R25,R27,R29,R31,R33,R34,R35,R36,R57,R59,R61,R63,R65,R66,R67,R68,R84,R86,R88,R90,R91,R92	1	62
2795	147	153	1	0	6	C4	1	809
2834	149	1588	1	0	0	Q8	1	844
2850	149	106	2	0	0	 R11,R32	1	843
2841	149	92	1	0	0	D3	1	936
2832	149	1442	1	0	0	 Q2	1	799
2752	141	1616	1	0	0	C7	1	876
2812	146	26	1	0	0	R94	1	954
2767	146	92	1	0	0	D1	1	936
2768	146	1599	2	0	0	D2, D3	1	864
2775	146	1430	6	0	6	U1,U2,U3,U4,U5,U6	1	781
2772	146	371	1	0	0	K1	1	845
2781	146	1264	1	0	3	U13	1	964
2831	149	24	5	0	0	 R20,R29,R33,R34	1	949
2785	147	21	3	0	236	C1, C2, C3	1	846
2777	146	88	1	0	13	U8	1	960
2783	147	1401	2	0	6	U1, U2	1	783
2824	147	1631	1	0	0	c/ J5	1	871
1157	74	1264	0	0	0	 	1	964
2762	118	1588	0	0	12		1	844
2672	140	21	11	0	0	C5,C6,C8,C11,C12,C13C15,C16,C18,C19,C20	1	846
2820	140	1584	1	0	0	U3	1	961
2796	146	1251	11	0	0	C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11	1	848
2798	146	1361	1	0	0	C15	1	752
2797	146	21	13	0	0	C12,C13,C14,C16,C17,C18,C19,C20,C21,C22,C23,C24,C25	1	846
2799	146	1252	1	0	0	C26	1	454
2780	146	1401	2	0	0	U10, U11	1	783
2774	146	965	10	0	0	Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10	1	561
2827	149	1280	1	0	0	C14	1	847
2836	149	1251	3	0	0	C1,C2,C7	1	848
2838	149	1362	2	0	0	C9	1	805
2837	149	1587	2	0	0	C3,C4	1	927
2396	119	1430	0	0	0	 	2	781
2840	149	1592	3	0	0	CN3,CN4,CN6	1	856
2833	149	371	1	0	0	K1	1	845
2848	149	2	1	0	0	R4	1	42
2847	149	659	6	0	0	 R1,R2,R5,R8,R9,R21	1	947
2849	149	1586	3	0	0	R6,R7,R10	1	840
2845	149	965	4	0	0	Q1,Q4,Q5,Q6	1	561
2101	48	657	0	0	50		6	57
2867	149	1630	1	0	0	CN2	1	1752
3009	153	0	3	0	0		1	1784
2870	140	1594	1	0	0	D7	1	858
2914	151	1682	2	0	0	R6,R29	1	908
2916	151	1684	1	0	0	R8	1	910
2876	150	1647	3	0	0		1	873
2877	151	1648	3	0	0	C2, C35, C37	1	874
2917	151	1685	4	0	0	R9,R14,R15,R16	1	911
2880	151	1649	2	0	0	C7,C11	1	875
2881	151	1650	2	0	0	C8,C10	1	878
2882	151	1651	1	0	0	C9	1	877
2883	151	1652	2	0	0	C13,C15	1	879
2884	151	1653	2	0	0	C14,C16	1	880
2885	151	1654	4	0	0	C17,C18,C19,C20	1	881
2886	151	1655	7	0	0	C21,C23,C24,C25,C26,C28,C38	1	882
2887	151	1656	1	0	0	C22	1	883
2888	151	1657	1	0	0	C27	1	884
2889	151	1658	1	0	0	C29	1	885
2890	151	1659	2	0	0	C30,C39	1	886
2892	151	1660	1	0	0	C31	1	887
2893	151	1661	2	0	0	C32,C33	1	888
2894	151	1662	5	0	0	C34,C36,C40,C41,C42	1	889
2895	151	1663	2	0	0	D1,D2	1	890
2896	151	1664	1	0	0	D3	1	891
2897	151	1666	2	0	0	D4,D11	1	892
2919	151	1687	2	0	0	R12,R22	1	913
2899	151	1668	2	0	0	D6,D10	1	894
2900	151	1669	1	0	0	D12	1	895
2878	151	1616	1	0	0	C4	1	876
2901	151	1670	2	0	0	FB3,FB4	1	896
2902	151	1671	2	0	0	FL1,FL2	1	897
2904	151	1672	1	0	0	IC1	1	898
2905	151	1673	1	0	0	J3	1	899
2906	151	1674	2	0	0	J4, J5	1	900
2907	151	1675	1	0	0	L1	1	901
2908	151	1676	1	0	0	PS1	1	902
2909	151	1677	2	0	0	Q5,Q6	1	903
2910	151	1678	1	0	0	R1	1	904
2911	151	1679	1	0	0	R2	1	905
2912	151	1680	2	0	0	R3,R4	1	906
2913	151	1681	2	0	0	R5,R21	1	907
2918	151	1686	1	0	0	R10	1	912
2924	151	1692	3	0	0	R23,R33,R36	1	918
2920	151	1688	1	0	0	R13	1	914
2921	151	1689	2	0	0	R17,R19	1	915
2922	151	1690	1	0	0	R18	1	916
2923	151	1691	2	0	0	R20,R30	1	917
2926	151	1694	2	0	0	R26,R31	1	920
2925	151	1693	4	0	0	R25,R27,R28,R35	1	919
2929	151	1697	2	0	0	TH3,TH4	1	923
2927	151	1695	1	0	0	R34	1	921
2928	151	1696	2	0	0	T1,T2	1	922
2858	149	1590	1	0	0	U5	1	959
2930	151	1699	2	0	0	U2,U3	1	925
2933	152	1587	2	0	0	C2,C6	1	927
2941	152	199	1	0	0	C47	1	935
2938	152	1704	10	0	0	C21,C22,C24,C27,C28,C30,C31,C34,C35,C36	1	932
2935	152	1701	2	0	0	C11,C32	1	929
2936	152	1702	2	0	0	C15,C17	1	930
2940	152	1706	1	0	0	C46	1	934
2934	152	1700	10	0	0	C8,C10,C13,C14,C23,C25,C26,C29,C33,C51	1	928
2939	152	1705	4	0	0	C44,C45,C48,C49	1	933
2937	152	1703	2	0	0	C18,C20	1	931
2969	152	88	1	0	0	U3	1	960
2967	152	1724	3	0	0	U1,U4,U7	1	958
2968	152	1590	3	0	0	U2,U6,U8	1	959
2973	152	1264	1	0	0	U13	1	964
2971	152	1725	1	0	0	U9	1	962
2970	152	1584	1	0	0	U5	1	961
2947	152	1711	1	0	0	J5	1	939
2951	152	1714	1	0	0	LED2	1	942
2952	152	1715	1	0	0	LED3	1	943
2943	152	92	1	0	0	D3	1	936
2946	152	1710	1	0	0	FB1	1	938
2949	152	1712	1	0	0	L1	1	940
2965	152	1722	1	0	0	R91	1	956
2958	152	24	1	0	0	R14	1	949
2964	152	1721	1	0	0	R90	1	955
2962	152	99	2	0	0	R22,R24	1	953
2963	152	26	1	0	0	R61	1	954
2957	152	660	3	0	0	R12,R13,R15	1	948
2961	152	1720	40	0	0	R19,R20,R21,R25,R26,R29,R30,R34,R35,R36,R42,R43,R45,R46,R48,R49,R50,R51,R52,R53,R55,R57,R58,R59,R62,R64,R69,R70,R74,R76,R77,R78,R79,R80,R82,R83,R84,R86,R88,R89	1	952
2966	152	1723	1	0	0	R92	1	957
2959	152	117	11	0	0	R16,R18,R28,R37,R38,R39,R56,R66,R71,R72,R87	1	950
2955	152	1718	1	0	0	R1	1	946
2945	152	1709	1	0	0	D4	1	937
2953	152	1716	2	0	0	Q1,Q2	1	944
2954	152	1717	1	0	0	Q3	1	945
2856	149	1294	1	0	0	 U2	1	515
2860	149	1584	1	0	0	U3	1	961
2862	149	1631	3	0	0	c/ CN5,CN14,CN17	1	871
2857	149	1589	1	0	0	U4	1	850
2851	149	26	1	0	0	R31	1	954
2853	149	117	3	0	0	R18,R22,R23	1	950
2854	149	1599	2	0	0	SV1,SV2	1	864
2932	152	1452	17	0	0	C1,C3,C4,C5,C7,C9,C12,C16,C19,C37,C38,C39,C40,C41,C42,C43,C50	1	926
2972	152	1293	5	0	0	U10,U11,U12,U15,U16	1	963
2986	153	0	2	0	0		1	1764
2974	152	1726	1	0	0	U17	1	965
2975	152	1727	1	0	0	X1	1	966
2950	152	1713	2	0	0	LED1,LED4	1	941
2956	152	659	10	0	0	R2,R3,R4,R5,R6,R7,R8,R9,R10,R11	1	947
2960	152	1719	20	0	0	R17,R23,R27,R31,R32,R33,R40,R41,R44,R47,R54,R60,R63,R65,R67,R68,R73,R75,R81,R85	1	951
2898	151	1667	4	0	0	D5,D7,D8,D9	1	893
2915	151	1683	1	0	0	R7	1	909
54	0	191	0	0	0		1	12
53	0	192	0	0	0		1	13
126	0	1099	0	0	2		1	249
44	0	206	0	0	0		1	114
18	0	11	0	0	0		1	1
112	0	1120	0	0	4		1	292
77	0	841	0	0	0		1	151
118	0	1092	0	0	0		1	240
125	0	1098	0	0	0		1	410
115	0	1085	0	0	10		1	312
81	0	922	0	0	1		1	320
56	0	196	0	0	0		1	15
29	0	60	0	0	50		1	258
148	0	1228	0	0	10		1	404
103	0	1071	0	0	0		1	350
55	0	193	0	0	0		1	14
10	0	1	0	0	10		1	44
130	0	1111	0	0	0		1	259
21	0	36	0	0	5		1	415
89	0	935	0	0	0		1	148
133	0	1114	0	0	0		1	277
804	81	417	0	0	171		5	182
279	81	62	0	0	186		1	110
268	81	347	0	0	19		1	273
295	81	64	0	0	0		3	489
316	81	326	0	0	19		3	274
335	81	273	0	0	13		4	689
318	81	224	0	0	3		4	618
332	81	280	0	0	8		4	653
328	81	221	0	0	10		4	663
805	81	84	0	0	37		5	502
159	2	645	0	0	113		1	71
158	2	642	0	0	43		1	79
1240	87	21	6	0	0	C1 C2 C3 C5 C9 C12 C15 	1	846
1248	87	1285	1	0	10	 C8	1	735
1495	87	1342	0	0	10	 	2	738
1264	87	92	1	0	236	D3	1	936
1243	87	1121	1	0	47	R8	1	382
2543	134	1497	1	0	0		1	833
1137	74	21	0	0	110		1	846
1143	74	1255	0	0	10		1	457
1140	74	1253	0	0	6		1	455
1169	74	1275	0	0	5		1	484
1158	74	1265	0	0	2		1	466
1146	74	1258	0	0	5		2	460
1167	74	1274	0	0	10		2	483
1124	74	95	0	0	50		2	449
1134	74	117	0	0	50		3	950
1779	107	120	0	0	0		4	86
1797	107	612	0	0	0		5	592
1769	107	589	0	0	0		4	617
1773	107	501	0	0	0		4	635
1762	107	582	0	0	0		4	627
1757	107	386	0	0	0		2	349
1756	107	17	0	0	0		2	116
1753	107	393	0	0	0		2	322
1560	107	570	0	0	0		1	323
2171	111	1361	1	0	0	  	1	752
2157	111	1353	1	0	0	 	1	745
2161	111	1355	2	0	0	 	1	747
2178	111	1118	1	0	0	 	1	440
2186	111	459	2	0	0	 	2	174
2167	111	1359	1	0	0	 	2	750
2531	23	0	0	0	0		2	868
1696	23	1101	0	0	0		5	247
1698	23	164	0	0	0		5	162
1703	23	886	0	0	0		5	200
1705	23	870	0	0	0		5	300
602	23	1227	0	0	1		1	381
1632	23	447	0	0	0		2	419
1643	23	804	0	0	0		3	714
1641	23	811	0	0	0		3	711
1727	23	117	0	0	0		6	950
591	23	814	0	0	21		1	1296
1715	23	970	0	0	0		6	523
1718	23	931	0	0	0		6	137
1466	89	21	25	0	0	 C1 C2 C7 C8 C9 C10 C11 C13 C14 C16 C17 C19 C20 C21 C24  C4 C5 C6 C12 C18 C23 C25 C28 C49 C50	1	846
1455	89	1322	2	0	0	EXTERNOS	1	543
1624	23	945	0	0	0		2	1328
1430	89	1108	32	0	0	R2 R3 R6 R7 R9 R12 R15 R16 R20 R21 R25 R26 R28 R30 R32 R33 R35 R36 R38 R39 R42 R43 R46 R49 R50 R51 R52 R53 R56 R57 R58 R60	1	360
1443	90	21	25	0	0	 C4 C5 C6 C12 C18 C23 C25 C28 C49 C50  C29 C36 C37 C38 C39 C40 C41 C42 C43 C44 C45 C46 C47 C48 C53	1	846
1422	90	92	9	0	0	D1 D2 D3 D4 D5 D6 D7 D8 D9	1	936
1277	88	1317	4	0	0	CN1 CN2 CN3 CN4	1	538
2524	120	1488	0	0	50	 	1	831
1969	25	864	0	0	0		5	260
1963	25	176	0	0	0		5	127
646	25	297	0	0	34		1	395
1988	25	691	0	0	0		6	624
1936	25	459	0	0	0		3	174
1937	25	161	0	0	0		3	125
2441	119	1452	0	0	45	 	4	926
2433	119	1447	0	0	10		4	811
2427	119	1362	0	0	9	 	4	805
1729	23	1242	0	0	0		6	1523
1960	25	173	0	0	0		5	1285
2503	119	249	0	0	10		8	160
2505	119	1482	0	0	6	  	8	828
2456	119	125	0	0	4		5	6
2403	119	1435	0	0	5		2	788
626	25	294	0	0	6		1	1040
641	25	311	0	0	1		1	1055
2484	119	269	0	0	10		7	818
639	25	309	0	0	1		1	1053
2488	119	265	0	0	1		7	611
2476	119	442	0	0	5		7	82
2391	119	1428	0	0	6	 	2	778
2466	119	88	0	0	8		6	960
2471	119	1467	0	0	7		6	815
2395	119	1429	0	0	5		2	780
2374	119	853	0	0	26		1	219
2423	119	1444	0	0	6		3	803
2383	119	1426	0	0	6		1	773
1932	25	755	0	0	0		2	1217
2519	119	95	0	0	10		5	449
2369	119	1338	0	0	50		1	766
2387	119	364	0	0	9	 	2	777
2418	119	1358	0	0	20		3	798
1940	25	995	0	0	0		3	1385
1991	25	694	0	0	0		6	1202
1996	25	852	0	0	0		6	1278
1990	25	693	0	0	0		6	1201
2496	119	1476	0	0	19	 	8	1637
2495	119	1475	0	0	6		8	1635
2473	119	829	0	0	4		7	1298
2459	119	1462	0	0	46	 	6	1619
3011	153	0	6	0	0	U3,U4	1	1785
1446	93	21	10	0	0	 C4 C5 C6 C12 C18 C23 C25 C28 C49 C50	1	846
1384	93	99	3	0	0	R13 R22 R23	1	953
2988	153	0	10	0	0		1	1766
2250	114	524	0	0	7	 	1	623
741	35	234	0	0	37		1	693
2230	114	386	0	0	4	 	1	349
739	35	247	0	0	5		1	692
3012	153	0	4	0	0	U5	1	1773
734	35	259	0	0	27		1	690
1918	35	518	0	0	0		6	593
1907	35	500	0	0	0		6	609
1895	35	476	0	0	0		6	643
1814	35	243	0	0	0		2	589
1897	35	478	0	0	0		6	641
1861	35	853	0	0	0		4	219
1840	35	795	0	0	0		3	706
1847	35	791	0	0	0		3	702
1856	35	896	0	0	0		4	210
1853	35	889	0	0	0		4	205
1871	35	1246	0	0	0		4	435
1815	35	698	0	0	0		2	179
2012	19	256	0	0	0		2	683
505	19	640	0	0	5		1	646
2007	19	122	0	0	0		2	7
2148	19	135	0	0	0		5	432
2139	19	207	0	0	0		4	24
2116	19	950	0	0	0		3	718
2124	19	688	0	0	0		4	68
2104	19	735	0	0	0		3	447
2140	19	671	0	0	0		4	361
2111	19	670	0	0	0		3	372
511	19	44	0	0	5		1	106
2274	115	1362	2	0	0	 	1	805
2299	118	21	36	0	243	    C1-C33, C40, C43, C44	1	846
2271	115	9	1	0	0	 	1	822
2270	115	1390	1	0	0	 	1	774
2284	115	1308	1	0	0	 	1	566
2285	115	928	2	0	0	 	1	132
2260	115	704	2	0	0	 	1	345
395	11	831	0	0	13		3	270
671	11	157	0	0	2		4	808
670	11	76	0	0	19		4	143
417	11	560	0	0	10		5	604
425	11	412	0	10	0		5	673
388	11	396	0	0	5		3	413
402	11	395	0	0	19		3	416
351	11	364	0	0	16		1	777
352	11	577	0	0	82		1	227
2336	118	1405	5	0	15	 FB1, FB2, FB3, FB5, FB6	1	801
2586	138	1558	0	0	45		2	838
2248	114	474	0	0	13	 	1	202
1173	82	21	51	0	140	 C5 C6 C7 C9 C10 C12 C15 C27 C29 C31 C33 C42 CD1 CD1A CD2 CD3 CD4 CD5 CD6 CD8 CD9 CD10 CD11 CD12 CD13 CD14 CD15 CD16 CD17 CD23 CD29 CS1A CS1B CS2A CS2B CS3A CS3B CS4A CS4B CS5A CS5B CS6A CS6B CS7A CS7B CS8A CS8B CS10A CS10B CS11A CS11B	3	846
1181	82	1284	1	0	0	  C41	1	496
1496	82	1333	8	0	0	  ISO1 ISO2 ISO3 ISO5 ISO6 ISO8 ISO10 ISO11	3	557
1200	82	1292	2	0	6	  U11 U12	1	513
1207	82	95	6	0	50	 R1 R41 R55 R83 R94 R95	2	449
1188	82	84	3	0	15	 DS1 DS4 DS5	2	502
2725	141	1127	1	0	0	R11	1	383
2187	112	62	4	0	0	  C3 C4 C5 C7	1	110
2201	112	1366	2	0	0	  Sopre IG1 e IG4	1	755
2305	116	21	21	0	0	 C3 C7 C13 C17 C23 C25 C27 C30-C34 C37 C38 C40 C44 C46-C50	1	846
2348	116	1314	5	0	0	 R14, RR19, R20, R35, R43	2	867
2351	116	100	4	0	0	 R32, R33, R37, R39	2	73
2642	140	1591	1	0	0	C17	1	853
2656	140	647	1	0	0	R16	1	866
2865	149	21	10	0	0	C6,C8,C11,C12,C13C15,C16,C18,C19,C20	1	846
928	50	1149	0	0	55		1	396
1017	61	1075	0	10	29		1	265
1048	64	1087	0	0	9		1	336
2211	113	356	5	0	0	 PB1 PB2 PB3 PB4 PB5	1	1079
2989	153	0	2	0	0		1	1768
3013	153	0	1	0	0	U6	1	1786
953	52	186	0	0	98		1	510
647	26	898	0	0	7		1	212
912	48	536	0	0	149		1	177
93	0	963	0	0	1		1	1347
60	0	296	0	0	0		1	1020
2039	48	467	0	0	0		2	178
2062	48	1050	0	0	0		3	341
49	0	212	0	0	0		1	1007
2086	48	664	0	0	0		6	532
2098	48	106	0	0	0		6	843
2070	48	1128	0	0	0		5	380
2078	48	1160	0	0	0		5	420
2099	48	667	0	0	0		6	359
2085	48	37	0	0	0		6	375
2096	48	668	0	0	0		6	80
2257	71	1387	0	0	4	 	6	757
2043	48	980	0	0	0		3	1353
3014	153	0	4	0	0	U7	1	1774
799	81	426	0	0	17		5	1118
800	81	427	0	0	24		5	1119
801	81	429	0	0	13		5	1120
798	81	425	0	0	26		5	1117
794	81	420	0	0	3		5	1113
276	81	63	0	0	11		1	1337
272	81	352	0	0	51		1	1076
271	81	350	0	0	45		1	1075
269	81	348	0	0	7		1	1074
303	81	337	0	0	3		3	1072
793	81	418	0	0	10		5	1112
308	81	331	0	0	0		3	1360
310	81	340	0	0	9		3	1365
315	81	339	0	0	159		3	1483
298	81	332	0	0	0		3	1067
314	81	1066	0	0	1		3	1470
300	81	334	0	0	20		3	1069
296	81	325	0	0	10		3	1065
305	81	343	0	0	0		3	1744
294	81	338	0	0	4		3	1028
299	81	333	0	0	1		3	1068
302	81	336	0	0	0		3	1071
301	81	335	0	0	0		3	1070
297	81	330	0	0	2		3	1066
307	81	824	0	0	1		3	1254
312	81	344	0	0	3		3	1367
311	81	823	0	0	0		3	1366
317	81	328	0	0	33		3	1486
309	81	327	0	0	8		3	1364
313	81	329	0	0	0		3	1368
326	81	241	0	0	2		4	1018
330	81	270	0	0	4		4	1031
285	81	323	0	0	1		2	1064
290	81	460	0	0	4		2	1358
280	81	316	0	0	1		2	1059
284	81	321	0	0	2		2	1063
281	81	318	0	0	9		2	1060
282	81	319	0	0	8		2	1061
292	81	317	0	0	2		2	1473
810	81	108	0	0	22		5	1488
790	81	413	0	0	2		5	1109
791	81	414	0	0	4		5	1110
287	81	854	0	0	0		2	1303
286	81	484	0	0	1		2	1293
289	81	448	0	0	4		2	1356
802	81	825	0	0	4		5	1255
270	81	349	0	0	3		1	967
796	81	423	0	0	20		5	1115
795	81	422	0	0	10		5	1114
803	81	421	0	0	7		5	1256
1139	74	682	0	0	10		1	1021
1156	74	1263	0	0	2		2	1568
1147	74	809	0	0	5		2	1567
41	0	121	0	0	0		1	1004
32	0	87	0	0	0		1	995
69	0	465	0	0	0		1	1012
25	0	47	0	0	0		1	990
67	0	462	0	0	0		1	1011
75	0	52	0	0	0		1	1015
76	0	53	0	0	1		1	1016
101	0	1084	0	0	1		1	1460
98	0	1032	0	0	0		1	1433
74	0	362	0	0	0		1	1014
61	0	43	0	0	0		1	1008
34	0	103	0	0	0		1	997
35	0	111	0	0	0		1	998
62	0	385	0	0	0		1	1009
26	0	54	0	0	10		1	991
48	0	172	0	0	0		1	1006
82	0	921	0	0	1		1	1299
72	0	543	0	0	0		1	1013
36	0	124	0	0	0		1	999
84	0	927	0	0	1		1	1307
43	0	139	0	0	20		1	1005
13	0	6	0	0	0		1	980
16	0	7	0	0	0		1	986
38	0	130	0	0	0		1	1001
37	0	129	0	0	0		1	1000
40	0	195	0	0	0		1	1003
28	0	58	0	0	20		1	993
30	0	85	0	0	20		1	994
79	0	880	0	0	0		1	1017
27	0	171	0	0	1		1	992
33	0	89	0	0	0		1	996
66	0	450	0	0	0		1	1010
91	0	74	0	0	14		1	1342
92	0	75	0	0	30		1	1343
96	0	966	0	0	12		1	1349
102	0	1070	0	0	0		1	1478
12	0	4	0	0	0		1	974
11	0	3	0	0	0		1	973
24	0	45	0	0	0		1	989
22	0	40	0	0	10		1	988
99	0	127	0	0	0		1	1440
898	48	1010	0	0	98		1	1354
601	23	818	0	0	18		1	1490
594	23	817	0	0	7		1	1294
592	23	815	0	0	17		1	1295
600	23	148	0	0	0		1	971
1808	35	699	0	0	0		2	1300
1816	35	711	0	0	0		2	1418
1818	35	705	0	0	0		2	1419
1819	35	918	0	0	0		2	1420
1821	35	709	0	0	0		2	1422
1812	35	701	0	0	0		2	1417
1822	35	707	0	0	0		2	1423
1955	25	861	0	0	0		5	1280
1956	25	862	0	0	0		5	1281
1961	25	863	0	0	0		5	1286
1964	25	865	0	0	0		5	1304
1957	25	866	0	0	0		5	1282
1958	25	867	0	0	0		5	1283
1962	25	174	0	0	0		5	1289
1959	25	868	0	0	0		5	1284
1966	25	924	0	0	0		5	1306
644	25	288	0	0	21		1	1058
643	25	314	0	0	21		1	1057
634	25	304	0	0	47		1	1048
640	25	310	0	0	1		1	1054
624	25	292	0	0	20		1	1038
628	25	298	0	0	4		1	1042
632	25	302	0	0	2		1	1046
625	25	293	0	0	8		1	1039
630	25	300	0	0	1		1	1044
633	25	303	0	0	16		1	1047
623	25	291	0	0	41		1	1037
635	25	305	0	0	4		1	1049
622	25	290	0	0	6		1	1036
637	25	307	0	0	1		1	1051
642	25	312	0	0	1		1	1056
629	25	299	0	0	17		1	1043
627	25	295	0	0	6		1	1041
636	25	306	0	0	1		1	1050
638	25	308	0	0	1		1	1052
1993	25	720	0	0	0		6	1204
1992	25	697	0	0	0		6	1203
1994	25	721	0	0	0		6	1205
1985	25	716	0	0	0		6	985
1981	25	712	0	0	0		6	983
1983	25	714	0	0	0		6	984
1995	25	725	0	0	0		6	1210
501	19	635	0	0	2		1	1194
498	19	632	0	0	2		1	1192
500	19	634	0	0	7		1	1193
492	19	624	0	0	4		1	1186
487	19	617	0	0	2		1	1181
489	19	620	0	0	1		1	1183
490	19	621	0	0	2		1	1184
504	19	639	0	0	3		1	1197
495	19	628	0	0	2		1	1189
496	19	629	0	0	2		1	1190
497	19	630	0	0	2		1	1191
494	19	627	0	0	2		1	1188
493	19	626	0	0	4		1	1187
350	11	830	0	0	2		1	1265
337	11	355	0	0	1		1	1078
338	11	356	0	0	2		1	1079
339	11	358	0	0	10		1	1080
412	11	557	0	0	14		5	1105
413	11	491	0	0	12		5	1131
418	11	561	0	0	4		5	1151
420	11	563	0	0	4		5	1152
340	11	360	0	0	1		1	1081
346	11	384	0	0	1		1	1094
347	11	383	0	0	7		1	1095
345	11	369	0	0	1		1	1137
341	11	361	0	0	4		1	1082
383	11	387	0	0	11		3	1097
353	11	365	0	0	31		1	1474
382	11	382	0	0	1		3	1093
384	11	388	0	0	10		3	1098
386	11	390	0	0	5		3	1100
391	11	407	0	0	10		3	1106
392	11	408	0	0	1		3	1107
394	11	410	0	0	4		3	972
393	11	409	0	0	9		3	1198
348	11	829	0	0	2		1	1298
381	11	392	0	0	4		3	976
343	11	367	0	0	0		1	1084
427	11	1064	0	0	0		5	1468
124	0	974	0	0	4		1	1471
152	0	1235	0	0	4		1	1536
141	0	1153	0	0	0		1	1482
149	0	1230	0	0	5		1	1519
140	0	917	0	0	50		1	1481
142	0	1157	0	0	0		1	1484
145	0	1162	0	0	0		1	1485
147	0	1229	0	0	5		1	1512
650	26	78	0	0	46		1	1492
648	26	1061	0	0	0		1	1466
649	26	1062	0	0	0		1	1467
2029	48	1021	0	0	0		2	1408
2027	48	1019	0	0	0		2	1406
2046	48	978	0	0	0		3	1370
2049	48	982	0	0	0		3	1373
2061	48	981	0	0	0		3	1398
2048	48	146	0	0	0		3	1372
2045	48	977	0	0	0		3	1369
2024	48	1025	0	0	0		2	1359
2038	48	1009	0	0	0		2	1416
2032	48	1024	0	0	0		2	1411
2025	48	72	0	0	0		2	1404
2026	48	1018	0	0	0		2	1405
2028	48	1020	0	0	0		2	1407
2036	48	1003	0	0	0		2	1414
2037	48	1027	0	0	0		2	1415
2033	48	1026	0	0	0		2	1412
1394	93	1217	1	0	0	JP2	1	1720
1262	87	1312	3	0	0	F1 F2 F3	1	1025
1233	87	998	1	0	0	R4	1	1389
1250	87	1307	1	0	0	R16	2	1571
1267	87	1313	1	0	0	R17	2	975
1253	87	149	2	0	0	U3 U7	2	1026
1254	87	148	1	0	10	 U1	2	971
1382	93	1316	1	0	0	C22	1	1027
1439	93	649	2	0	0	R19 R29	1	1357
1458	89	1217	1	0	0	JP2	1	1720
1460	89	1316	1	0	0	C22	1	1027
1426	89	649	3	0	0	R19 R29 R45	1	1357
1477	90	1217	1	0	0	JP2	1	1720
1272	88	1217	2	0	0	JP2 JP3	1	1720
1274	88	1316	1	0	0	C6	1	1027
1896	35	477	0	0	0		6	1123
1904	35	490	0	0	0		6	1128
1905	35	492	0	0	0		6	1129
1903	35	487	0	0	0		6	1127
724	35	235	0	0	10		1	1022
730	35	227	0	0	1		1	1024
1899	35	480	0	0	0		6	1125
1898	35	479	0	0	0		6	1124
1894	35	473	0	0	0		6	1122
1827	35	781	0	0	0		3	1240
1831	35	789	0	0	0		3	1244
1835	35	800	0	0	0		3	1248
1833	35	798	0	0	0		3	1246
1834	35	799	0	0	0		3	1247
1836	35	801	0	0	0		3	1249
1837	35	797	0	0	0		3	1251
1828	35	786	0	0	0		3	1241
1826	35	780	0	0	0		3	1239
1846	35	783	0	0	0		3	1334
1998	25	1055	0	0	0		6	1569
654	11	313	0	0	2		4	1121
665	11	531	0	0	48		4	1206
653	11	547	0	0	5		4	1108
666	11	532	0	0	4		4	1207
663	11	550	0	0	10		4	1149
659	11	545	0	0	3		4	1145
657	11	542	0	0	19		4	1143
656	11	540	0	0	8		4	1142
655	11	538	0	0	1		4	1141
662	11	549	0	0	20		4	1148
658	11	544	0	0	1		4	1144
411	11	405	0	0	10		3	1565
401	11	836	0	0	10		3	1290
1257	11	1311	0	0	6		3	979
923	50	1169	0	0	51		1	1510
925	50	1181	0	0	52		1	1514
930	50	1168	0	0	223		1	1543
924	50	1180	0	0	53		1	1513
929	50	1183	0	0	21		1	1542
926	50	1185	0	0	15		1	1516
921	50	572	0	0	155		1	1494
920	50	571	0	0	207		1	1476
1022	61	1171	0	0	43		1	1496
1023	61	1172	0	0	7		1	1497
1021	61	1174	0	0	11		1	1491
1024	61	1173	0	0	5		1	1498
1025	61	1175	0	0	7		1	1499
1020	61	1167	0	0	92		1	1489
1029	61	1179	0	0	30		1	1509
1050	64	1146	0	0	91		1	1487
1053	64	1200	0	0	15		1	1541
1049	64	1076	0	10	31		1	1477
1052	64	1199	0	0	15		1	1540
1071	67	1201	0	0	1		1	1545
1072	67	1202	0	0	1		1	1546
1073	67	1203	0	0	1		1	1548
1075	67	1204	0	0	1		1	1549
1076	67	1205	0	0	1		1	1550
1078	67	1207	0	0	1		1	1552
1079	67	1208	0	0	1		1	1553
1080	67	1209	0	0	1		1	1555
1081	67	1210	0	0	1		1	1556
1082	67	1211	0	0	1		1	1557
1057	66	1182	0	0	37		1	1515
1056	66	1212	0	0	10		1	1511
1066	66	1194	0	0	40		1	1533
1061	66	1189	0	0	3		1	1527
1063	66	1191	0	0	3		1	1530
1058	66	1186	0	0	20		1	1522
1059	66	1187	0	0	11		1	1524
1069	66	1197	0	0	6		1	1538
1060	66	1188	0	0	20		1	1526
1065	66	1193	0	0	36		1	1532
1067	66	1195	0	0	15		1	1535
955	56	919	0	0	0		1	1344
1055	65	718	0	0	3		1	1493
904	48	1008	0	0	94		1	1397
914	48	1011	0	0	171		1	1442
2044	48	983	0	0	0		3	1355
2050	48	984	0	0	0		3	1374
902	48	1007	0	0	105		1	1395
905	48	1012	0	0	24		1	968
2060	48	985	0	0	0		3	1384
907	48	1015	0	0	122		1	1401
2052	48	987	0	0	0		3	1376
908	48	1016	0	0	333		1	1402
903	48	1004	0	0	192		1	1396
2053	48	988	0	0	0		3	1377
2056	48	991	0	0	0		3	1380
2057	48	992	0	0	0		3	1381
906	48	1014	0	0	50		1	1400
2055	48	990	0	0	0		3	1379
2058	48	993	0	0	0		3	1382
2059	48	994	0	0	0		3	1383
2054	48	989	0	0	0		3	1378
897	48	903	0	0	1		1	1570
2091	48	654	0	0	0		6	1333
1767	107	587	0	0	0		4	1165
1789	107	603	0	0	0		5	1172
1795	107	609	0	0	0		5	1178
1798	107	615	0	0	0		5	1180
1788	107	602	0	0	0		5	1171
1790	107	604	0	0	0		5	1173
1794	107	608	0	0	0		5	1177
1781	107	595	0	0	0		5	1167
1734	107	400	0	0	0		2	1103
1737	107	832	0	0	0		2	1268
1738	107	372	0	0	0		2	1087
1561	107	573	0	0	0		1	1155
1563	107	575	0	0	0		1	1157
1558	107	569	0	0	0		1	1102
1571	107	359	0	0	0		1	1428
1732	107	370	0	0	0		2	1086
1562	107	574	0	0	0		1	1156
1565	107	568	0	0	0		1	1159
1559	107	567	0	0	0		1	1154
1564	107	354	0	0	0		1	1158
1568	107	512	0	0	0		1	1209
1689	23	81	0	0	0		5	1338
1682	23	871	0	0	0		5	1287
1699	23	872	0	0	0		5	1475
1629	23	428	0	0	0		2	1431
1634	23	1225	0	0	0		2	1517
1620	23	723	0	0	0		2	1324
1623	23	944	0	0	0		2	1327
1635	23	1247	0	0	0		2	1566
1633	23	946	0	0	0		2	1472
1625	23	822	0	0	0		2	1332
1628	23	964	0	0	0		2	1348
1638	23	805	0	0	0		3	1250
1640	23	813	0	0	0		3	1253
1655	23	809	0	0	0		3	1567
1708	23	859	0	0	0		6	1291
1688	23	954	0	0	0		5	1335
1692	23	1067	0	0	0		5	1444
1712	23	958	0	0	0		6	1341
1630	23	960	0	0	0		2	1445
1631	23	959	0	0	0		2	1454
1627	23	962	0	0	0		2	1346
1626	23	961	0	0	0		2	1345
1664	23	764	0	0	0		4	1226
1678	23	967	0	0	0		4	1350
1666	23	767	0	0	0		4	1228
1667	23	768	0	0	0		4	1229
1657	23	757	0	0	0		4	1219
1659	23	759	0	0	0		4	1221
1679	23	765	0	0	0		4	1452
1660	23	760	0	0	0		4	1222
1663	23	763	0	0	0		4	1225
1668	23	769	0	0	0		4	1230
1672	23	773	0	0	0		4	1234
1661	23	761	0	0	0		4	1223
1658	23	758	0	0	0		4	1220
1662	23	762	0	0	0		4	1224
1669	23	770	0	0	0		4	1231
1644	23	737	0	0	0		3	1429
1695	23	879	0	0	0		5	1457
1645	23	948	0	0	0		3	1361
1730	23	1215	0	0	0		6	1525
1675	23	777	0	0	0		4	1237
1676	23	778	0	0	0		4	1238
1674	23	776	0	0	0		4	1236
1479	90	1316	1	0	0	C22	1	1027
1484	90	649	4	0	0	R81 R83 R19 R29	1	1357
1271	88	1315	1	0	0	JP1	1	978
1908	35	502	0	0	0		6	1130
1911	35	509	0	0	0		6	1134
1923	35	489	0	0	0		6	1273
1927	35	49	0	0	0		6	1362
1909	35	507	0	0	0		6	1132
1919	35	519	0	0	0		6	1140
1921	35	729	0	0	0		6	1211
1913	35	511	0	0	0		6	1135
1867	35	1057	0	0	0		4	1463
1869	35	1059	0	0	0		4	1464
1914	35	513	0	0	0		6	1136
1916	35	516	0	0	0		6	1138
1935	25	750	0	0	0		2	1430
1929	25	749	0	0	0		2	1214
1930	25	753	0	0	0		2	1215
1934	25	920	0	0	0		2	1302
1931	25	754	0	0	0		2	1216
1933	25	756	0	0	0		2	1218
1944	25	998	0	0	0		3	1389
1950	25	69	0	0	0		3	1425
1945	25	999	0	0	0		3	1390
1941	25	996	0	0	0		3	1386
1942	25	936	0	0	0		3	1387
1946	25	1000	0	0	0		3	1391
1952	25	70	0	0	0		3	1427
1951	25	71	0	0	0		3	1426
1948	25	1002	0	0	0		3	1393
1947	25	1001	0	0	0		3	1392
1938	25	888	0	0	0		3	1363
1949	25	1005	0	0	0		3	1394
2113	19	860	0	0	0		3	1279
2000	19	262	0	0	0		2	1029
2008	19	287	0	0	0		2	1035
2004	19	281	0	0	0		2	1033
2005	19	283	0	0	0		2	1034
2015	19	1053	0	0	0		2	1461
2014	19	1052	0	0	0		2	1459
2108	19	673	0	0	0		3	1200
2105	19	736	0	0	0		3	1257
2002	19	277	0	0	0		2	1032
1508	82	1349	3	0	0	 C16 C19 C26	4	1577
1501	82	1346	1	0	0	  U1	3	1573
1507	82	1348	5	0	0	 R4 R6 R7 R28 R35	3	1576
1786	107	600	0	0	0		5	1169
1764	107	584	0	0	0		4	1162
1763	107	583	0	0	0		4	1161
1777	107	499	0	0	0		4	1166
1796	107	610	0	0	0		5	1179
1759	107	1243	0	0	0		2	1561
1760	107	394	0	0	0		2	1101
1755	107	1234	0	0	0		2	1534
1754	107	1233	0	0	0		2	1529
1758	107	406	0	0	0		2	1563
1745	107	826	0	0	0		2	1262
1747	107	828	0	0	0		2	1264
1741	107	375	0	0	0		2	1090
1748	107	377	0	0	0		2	1352
1746	107	827	0	0	0		2	1263
1765	107	585	0	0	0		4	1163
1742	107	380	0	0	0		2	1091
1743	107	381	0	0	0		2	1092
2158	111	87	1	0	0	 	1	995
2182	111	1021	7	0	0	  	2	1408
2185	111	983	2	0	0	 	2	1355
2168	111	694	1	0	0	 	2	1202
2150	111	149	1	0	0	   	2	1026
2152	111	817	2	0	0	 	2	1294
2151	111	148	4	0	0	  	2	971
597	23	149	0	0	0	 	1	1026
1890	35	1049	0	0	0		5	1456
1885	35	1044	0	0	0		5	1449
1873	35	1031	0	0	0		5	1432
1877	35	1036	0	0	0		5	1437
1876	35	1035	0	0	0		5	1436
1875	35	1034	0	0	0		5	1435
1874	35	1033	0	0	0		5	1434
1883	35	1042	0	0	0		5	1446
1882	35	1041	0	0	0		5	1643
1884	35	1043	0	0	0		5	1448
1891	35	1051	0	0	0		5	1458
1888	35	1047	0	0	0		5	1453
2363	35	1412	0	0	3		1	1613
1886	35	1045	0	0	0		5	1450
1880	35	1039	0	0	0		5	1441
1887	35	1046	0	0	0		5	1451
1954	25	748	0	0	0		4	1213
1953	25	747	0	0	0		4	1212
1977	19	1218	0	0	0		6	1575
1973	19	1222	0	0	0		6	1544
1979	19	1219	0	0	0		6	1559
1978	19	1220	0	0	0		6	1558
1975	19	1216	0	0	0		6	1554
1974	19	1223	0	0	0		6	1547
2214	19	1368	0	1	0	 	6	1580
2130	19	198	0	0	0		4	1019
2135	19	851	0	0	0		4	1277
2131	19	733	0	0	0		4	1258
2132	19	734	0	0	0		4	1259
2126	19	684	0	0	0		4	1260
2136	19	955	0	0	0		4	1336
2438	119	1449	0	0	6		4	1623
2439	119	1450	0	0	15		4	1624
2435	119	339	0	0	29		4	1483
2437	119	329	0	0	1		4	1368
2393	119	1416	0	0	4		2	1620
2380	119	1423	0	0	5		1	1622
2409	119	40	0	0	6		3	988
2405	119	1417	0	0	1	  	3	1621
2266	115	356	3	0	0	 	1	1079
2269	115	78	1	0	0	 	1	1492
2286	115	1014	1	0	0	 	1	1400
2282	115	1391	2	0	0	 	1	1598
2278	115	654	1	0	0	 	1	1333
2275	115	1348	3	0	0	 	1	1576
2287	115	676	3	0	0	 	1	1480
2294	115	150	1	0	0	 	1	1399
2290	115	148	2	0	0	 	1	971
2291	115	1392	2	0	0	 	1	1599
2292	115	1393	1	0	0	 	1	1600
2263	115	40	2	0	0	 	1	988
2231	114	1371	0	0	5	 	1	1583
2234	114	1373	1	0	1	 	1	1585
2235	114	1374	0	0	2	 	1	1586
2249	114	1386	0	0	9	 	1	1597
2244	114	1382	0	0	4	  	1	1593
2229	114	1370	1	0	6	   	1	1582
2233	114	1372	0	0	6	 	1	1584
2228	114	723	0	0	1	 	1	1324
2243	114	1380	0	0	5	 	1	1592
2238	114	1376	0	0	20	 	1	1588
2245	114	1384	0	0	6	 	1	1595
2246	114	1383	0	0	2	 	1	1594
2239	114	1377	0	0	4	 	1	1589
2240	114	1378	0	0	1	 	1	1590
2329	118	1346	2	2	6	  U12, U13	1	1573
2313	118	1340	2	0	0	 CN2, CN3	1	969
2337	118	1406	1	0	9	 FB4	1	1606
2318	118	1398	1	0	0	 R55	2	1603
2335	118	1404	1	0	0	Q1	2	1605
2200	112	291	1	0	0	  C35	1	1037
2190	112	329	1	0	0	  C11	1	1368
2207	112	1367	16	0	0	 U10	1	1579
2188	112	797	2	0	0	  D1 D3	1	1251
2193	112	71	2	0	0	  R2 R3	1	1426
2202	112	149	3	0	0	 U1 U10 U4	1	1026
2198	112	714	2	0	0	  IG1 IG4	1	984
2364	116	1413	2	0	1	U1 U2	1	1616
2307	116	1397	1	0	0	 C5	1	1602
2308	116	291	4	0	4	 C6, C15, C26, C35	1	1037
2222	113	1365	1	0	0	 JP1	1	1650
2220	113	1216	1	0	0	 JP2	1	1554
2213	113	1368	1	0	0	  CN3	1	1580
2219	113	329	1	0	0	 C1	1	1368
2256	71	1244	0	0	2	 	6	1562
2528	23	1495	0	0	100		2	1647
2555	137	1534	0	0	6		1	1661
2562	137	1536	0	0	12		1	1663
2611	137	1578	0	0	3		1	1698
2612	137	1579	0	0	3		1	1699
2560	137	1535	0	0	10	 	1	1662
2554	137	1533	0	0	14		1	1660
2550	137	1529	0	0	13		1	1656
2553	137	1532	0	0	5		1	1659
2552	137	1531	0	0	6		1	1658
2533	120	1498	0	0	5	 	1	1651
2606	35	1575	0	0	1		1	1696
2604	35	1573	0	0	2	HCF4035BE	1	1694
2605	35	1574	0	0	2		1	1695
2109	19	677	0	0	5	 	3	1330
2498	19	797	0	0	3		8	1251
2515	119	1486	0	0	40		3	1642
2440	119	1451	0	0	1		4	1625
2442	119	1453	0	0	1		4	1626
2453	119	1459	0	0	15		5	1615
2508	119	1484	0	0	4		8	1640
2455	119	1460	0	0	10		5	1617
2490	119	1471	0	0	10		7	1633
2462	119	1346	0	0	1		6	1573
2500	119	801	0	0	50		8	1249
2497	119	1477	0	0	20		8	1638
2499	119	1478	0	0	40		8	1639
2493	119	1473	0	0	6		8	1636
2494	119	1474	0	0	64		8	1634
2464	119	1465	0	0	6		6	1632
2463	119	1464	0	0	2		6	1631
2521	119	1312	0	0	12		5	1025
2511	119	764	0	0	8		6	1226
2512	119	1485	0	0	10		6	1641
2454	119	45	0	0	10		5	989
2458	119	1461	0	0	50		6	1618
2460	119	1463	0	0	4		6	1630
2446	119	1456	0	0	10		5	1629
2445	119	1455	0	0	10		5	1628
2448	119	1458	0	0	10		5	1614
2443	119	1454	0	0	38		5	1627
2607	138	1576	0	0	2		4	1697
2593	138	1564	0	0	3		3	1685
2594	138	1565	0	0	3		3	1686
2588	138	1560	0	0	5		2	1673
2579	138	1552	0	0	5		2	1668
2583	138	1556	0	0	7	 	3	1670
2565	138	1539	0	0	2		1	1665
2563	138	1537	0	0	16		1	1672
2587	138	1559	0	0	3		1	1671
2615	138	635	0	0	10		4	1194
2613	138	1580	0	0	10		4	1700
2590	138	1561	0	0	10		2	1681
2580	138	1553	0	0	10	 	3	1669
2573	138	1546	0	0	3		1	1667
2614	138	1581	0	0	3		4	1701
2599	138	1569	0	0	20		2	1690
2567	138	1541	0	0	17		1	1666
2603	138	1572	0	0	8	 	4	1693
2595	138	1566	0	0	10		3	1687
2581	138	1554	0	0	10		2	1683
2566	138	1540	0	0	20		1	1684
2608	138	1577	0	0	11		4	1704
2592	138	1563	0	0	20		2	1705
2575	138	1548	0	0	10	 	1	1706
2602	138	1571	0	0	6		4	1692
2578	138	1551	0	0	10	 	3	1721
2591	138	1562	0	0	5		2	1682
2568	138	1542	0	0	4		1	1680
2569	138	1543	0	0	13		1	1679
2574	138	1547	0	0	11		1	1678
2598	138	1568	0	0	1		3	1689
2577	138	1550	0	0	20	 	3	1677
2600	138	1570	0	0	40		3	1691
2597	138	1567	0	0	6		3	1688
2582	138	1555	0	0	3	 	3	1676
2681	139	1603	4	0	0	C7,C8,C9,C10	1	1737
2682	139	305	1	0	0	C11	1	1049
2683	139	331	1	0	0	C12	1	1360
2705	139	1613	1	0	31	U4	1	1743
2706	139	1614	1	0	28	U5	1	1724
2703	139	1612	1	0	28	U2	1	1741
2688	139	1605	2	0	0	J1,J2	1	1708
2691	139	1607	1	0	18	PS3	1	1710
2692	139	1608	1	0	18	PS2	1	1711
2687	139	1604	1	0	18	D2	1	1707
2698	139	1610	2	0	0	R8,R9	1	1740
2356	116	1410	1	0	10	 U6	1	1610
2357	116	1411	3	0	7	    U7, U9, U11	1	1612
2344	116	1407	2	0	0	 R6, R12	2	1607
2347	116	1408	5	0	0	 R13, R17, R23, R25, R38	2	1608
2361	116	277	1	0	5	 U15	2	1032
2727	141	717	1	0	47	U1	1	1736
2747	141	1623	2	0	25	U2, U4	1	1727
2814	141	1644	1	0	0	U5	1	1731
2748	141	1624	1	0	30	CN2	1	1716
2749	141	1625	1	0	8	DCDC1	1	1717
2673	140	343	1	0	0	C10	1	1744
2640	140	1551	1	0	0	U7	1	1721
2653	140	1598	1	0	0	U8	1	1729
2755	140	1629	3	0	0	CN1,CN15,CN18	1	1747
2756	140	1630	1	0	0	CN2	1	1752
2771	146	1365	1	0	0	J4	1	1650
2800	146	1603	1	0	0	C27	1	1737
2778	146	1598	1	0	0	U7	1	1729
2804	146	1635	1	0	0	CN12,CN13	1	1722
2763	146	1634	11	0	0	CN1,CN2,CN3,CN4,CN5,CN6,CN7,CN8,CN9,CN10,CN11	1	1745
2526	121	1491	0	0	4	 	1	1644
2527	121	1492	0	0	30		1	1645
911	48	1006	0	0	132	 	1	1424
2991	153	0	6	0	0		1	1770
1792	107	255	0	0	0		5	1175
1787	107	601	0	0	0		5	1170
2942	152	1707	6	0	0	CN1,CN2,CN3,CN4,J3,J4	1	1754
2948	152	818	1	0	0	K1	1	1490
288	81	322	0	0	1	 ??	2	1323
304	81	342	0	0	2		3	1073
797	81	424	0	0	10		5	1116
306	81	341	0	0	3		3	1096
277	81	1065	0	0	1		1	1469
283	81	320	0	0	5		2	1062
291	81	147	0	0	54		2	1652
1801	107	596	0	0	0		5	1272
1731	107	1244	0	0	0		2	1562
1735	107	401	0	0	0		2	1104
1740	107	374	0	0	0		2	1089
1733	107	389	0	0	0		2	1099
1570	107	404	0	0	0		1	1351
1567	107	514	0	0	0		1	1208
2179	111	1217	19	0	0	 	1	1720
2153	111	150	1	0	0	 	2	1399
1684	23	876	0	0	0		5	1288
595	23	154	0	0	33		1	1339
1622	23	943	0	0	0		2	1326
1639	23	812	0	0	0		3	1252
1693	23	1068	0	0	0		5	1447
1671	23	772	0	0	0		4	1233
1665	23	766	0	0	0		4	1227
1670	23	771	0	0	0		4	1232
2551	137	1530	0	0	6		1	1657
725	35	239	0	0	6		1	1023
1910	35	508	0	0	0		6	1133
1925	35	520	0	0	0		6	1275
1832	35	790	0	0	0		3	1245
1829	35	787	0	0	0		3	1242
1878	35	1037	0	0	0		5	1438
1889	35	1048	0	0	0		5	1455
1804	35	708	0	0	0		2	981
1805	35	696	0	0	0		2	982
1820	35	703	0	0	0		2	1421
1881	35	1040	0	0	0		5	1443
1917	35	517	0	0	0		6	1139
1976	19	1217	0	0	0		6	1720
1980	19	1221	0	0	0		6	1560
2125	19	22	0	0	0		4	1331
2107	19	672	0	0	0		3	1329
488	19	618	0	0	2		1	1182
503	19	638	0	0	2		1	1196
2001	19	266	0	0	0		2	1030
502	19	637	0	0	1		1	1195
2761	119	1535	0	0	5		2	1662
661	11	548	0	0	4		4	1147
660	11	546	0	0	39		4	1146
342	11	366	0	0	174		1	1083
415	11	523	0	0	5		5	1150
400	11	835	0	0	2		3	1271
398	11	833	0	0	9		3	1269
2227	114	1369	0	0	5	 	1	1581
2247	114	1385	0	0	3	 	1	1596
2585	138	1557	0	0	50		2	1674
1505	82	649	15	0	0	 R17 R18 R19 R20 R21 R22 R23 R24 R34 R73 R74 R77 R78 R87 R106	3	1357
2751	139	1627	1	0	15	U7	1	1742
2793	139	1637	1	0	28	CN1	1	1738
2875	139	148	2	0	0	U4,U3	1	971
2354	116	1409	5	0	2	  U1, U3, U5, U8, U13	1	1609
2753	141	1615	2	0	0	C2,C8	1	1713
2746	141	1622	1	0	30	R1	1	1715
2744	141	1620	1	0	80	R6	1	1733
2743	141	1619	1	0	0	R3	1	1734
2745	141	1621	2	0	0	R9,R10	1	1735
2742	141	1618	1	0	30	Q1	1	1714
2819	140	1646	1	0	0	JP2	1	1748
2649	140	369	1	0	0	Barrel_Jack_Switch	1	1137
2818	140	1637	1	0	0	J2	1	1738
2759	140	1633	1	0	0	c/ CN2	1	1750
2859	149	1646	1	0	0	JP2	1	1748
2828	149	343	1	0	0	C10	1	1744
2829	149	1551	1	0	0	U7	1	1721
2826	149	1598	1	0	0	U8	1	1729
2830	149	369	1	0	0	Barrel_Jack_Switch	1	1137
2869	149	1637	1	0	0	J2	1	1738
2863	149	1632	1	0	0	c/ CN15	1	1749
2864	149	1633	1	0	0	c/ CN2	1	1750
2868	149	1628	3	0	0	CN5,CN14,CN17	1	1751
2866	149	1629	1	0	0	CN15	1	1747
2770	146	1217	1	0	0	J3	1	1720
2801	146	1641	1	0	0	C28	1	1725
2779	146	1402	2	0	0	U9, U12	1	1649
2805	146	1642	1	0	0	CN19	1	1728
2765	146	1636	1	0	0	CN14	1	1723
2817	146	1645	1	0	0	J2	1	1746
2766	146	1637	5	0	0	CN15,CN16,CN17,CN18,J1	1	1738
2822	146	1632	1	0	0	c/ J2	1	1749
2784	147	1402	1	0	6	U3	1	1649
2791	147	1637	3	0	1	J1, J2, J3	1	1738
2823	147	1628	1	0	0	J5	1	1751
2788	147	1639	1	0	0	D1	1	1730
2789	147	1640	1	0	74	R1	1	1719
1027	61	1177	0	0	3		1	1501
1028	61	1178	0	0	4		1	1502
1077	67	1206	0	0	1		1	1551
1070	66	1198	0	0	5		1	1539
1062	66	1190	0	0	3		1	1528
1064	66	1192	0	0	16		1	1531
151	0	1232	0	0	10		1	1521
150	0	1231	0	0	30		1	1520
19	0	16	0	0	0		1	987
39	0	194	0	0	0		1	1002
2035	48	73	0	0	0		2	1413
2051	48	986	0	0	0		3	1375
909	48	1017	0	0	9		1	1403
2992	153	0	6	0	0		1	1771
2944	152	1708	5	0	0	CN10,CN12,CN13,CN14,CN15	1	1753
2616	81	1582	0	0	10		4	1702
162	2	649	0	10	47		1	1357
1238	87	1309	1	0	2	 U7	1	977
2538	132	369	1	0	0		1	1137
2993	153	0	8	0	0		1	1772
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: jrm
--

COPY public.locations (id, name, note, nbox, quant, bom, active) FROM stdin;
48	R		6	0		f
52	P01	Caixa de papelão comprida	1	0		f
56	P02	caixa papelão	1	0		f
26	P03	Antiga C04	1	0		f
61	M02	Arruelas	1	0		f
64	M03	Porcas	1	0		f
50	M01	Parafusos	1	0		f
65	P05	Caixa com LCDs	1	0		f
66	M05	Parafusos	1	0		f
67	M04	Brocas	1	0		f
72	M06	Parafusos, porcas, terminais, espaçadores	1	0		f
73	Satelite	Componentes do Satélite	1	0		f
88	CBUS		1	0		f
92	CADR-DA		1	0		f
90	CADR-IO		1	0		f
89	CADR-AN		1	0		f
93	CADR	Não existe: somente para acrescentar nas outras montagens	1	0		f
87	A420		2	0		f
2	A18		1	0		f
82	INV09	Pedido W35429	4	0		f
104	CADR-MIX	2 DA, 1PWM, 2OUT, 3IN, 4 ANALOG	1	0		f
11	G	Está sem a G2 -- Caixa 1: A06; Caixa 2: A07 e A08 (erro?); 4: A09; 5: A10;	5	0		f
23	C		6	0		f
107	B	Falta Caixa 3	5	0		f
35	D		5	0		f
25	E		1	0		f
112	invleg	Ainda sem caixa	1	0		f
113	OSC-1	Projeto com o Heitor	1	0		f
19	F		6	0		f
114	GDEC	Existem vários componentes que não fazem parte da placa GDEC	1	0		f
71	X	Espaço gde vazio - componentes não catalogados	6	0		f
115	Fuel Cell		1	0		f
116	Invslave1		2	0		f
118	Headcon1	Comprar: C34, quem é C37?	2	0		f
120	CHOPPER		1	0		f
121	Marcelo	Compra Farnell jul 2015	1	0		f
119	FRD		8	0		f
132	A4INPUTS		1	0		f
133	BLESH2		1	0		f
137	Chaves		1	0		f
138	Integrados		3	0		f
81	A	A/1 etc. ok -- Antigas Caixas A01 A02 A03 A04 A05	5	0		f
0	Não existe	Localização inexistente	1	0		f
134	A420C		1	0		f
74	ACBOX	Pedidos: W37530 e W37354	3	0		f
150	ConverterABV		1	0	status,compId,leId,"Reference","Value","Footprint","Qty","PartNumber","Ordercode","Manufacturer","Supplier"\nu,0,0,"C2,C3,C4,C5,C6,C7,C8,C9,C10,C11","10nF","Capacitor_SMD:C_0805_2012Metric","10","C0805C103K1RAC7411 "," 80-C0805C103K1RACLR ","Kemet","Mouser"\nu,0,0,"C12,C13,C14,C16,C17,C18,C19,C20,C21,C22,C23,C24,C25,C50","100nF/50V","Capacitor_SMD:C_0805_2012Metric","14","CL21B104KBCNNNL "," 80-C0805C300J4HACTU ","Samsung","Mouser"\nu,0,0,"C27,C29","1uF","Capacitor_SMD:C_1206_3216Metric","2","C1206C105Z3VAC "," 80-C1206C105Z3VAC ","Kemet","Mouser"\nu,0,0,"C30,C31","470uF/16V","Capacitor_SMD:CP_Elec_10x10.5","2","UWT1E471MNL1GS "," 647-UWT1E471MNL1S ","Nichicon","Mouser"\nu,0,0,"C44,C48,C49","22uF/25V","Capacitor_SMD:CP_Elec_5x5.9","3","EEE-1EA220WR"," 667-EEE-1EA220WR ","Panasonic","Mouser"\nu,0,0,"C46","220nF","Capacitor_SMD:C_0805_2012Metric","1","CL21B224KAFNNNG "," 187-CL21B224KAFNNNG ","Samsung","Mouser"\nu,0,0,"C47","47pF","Capacitor_SMD:C_0805_2012Metric","1","0805N470J500CT "," 791-0805N470J500CT ","Walsin","Mouser"\nu,0,0,"C51","2.2uF","Capacitor_SMD:C_0805_2012Metric","1","CL21B225KPFNNNG "," 187-CL21B225KPFNNNG ","Samsung","Mouser"\nu,0,0,"CN1,CN5,CN20","Conn_02x07_Odd_Even","Connector_IDC:IDC-Header_2x08_P2.54mm_Vertical","3","","","",""\nu,0,0,"CN12","Conn_01x02","Connector_Phoenix_GMSTB:PhoenixContact_GMSTBA_2,5_2-G_1x02_P7.50mm_Horizontal","1","","","",""\nu,0,0,"CN13","Conn_01x03","Connector_Phoenix_MSTB:PhoenixContact_MSTBA_2,5_3-G-5,08_1x03_P5.08mm_Horizontal","1","","","",""\nu,0,0,"CN14,CN19,CN21","Conn_01x02","Connector_Phoenix_MSTB:PhoenixContact_MSTBA_2,5_2-G-5,08_1x02_P5.08mm_Horizontal","3","","","",""\nu,0,0,"CN15,CN16,CN17,CN18,J1","Conn_02x05_Odd_Even","Connector_IDC:IDC-Header_2x05_P2.54mm_Vertical","5","","","",""\nu,0,0,"D1","1N4148W","Diode_SMD:D_SOD-123","1"," 1N4148W "," 637-1N4148W ","Diotec","Mouser"\nu,0,0,"D4","ESDCAN-03","Package_TO_SOT_SMD:SOT-23","1","ESDCAN03-2BWY"," 511-ESDCAN03-2BWY ","ST","Mouser"\nu,0,0,"H1,H2,H3,H4","MountingHole_Pad","MountingHole:MountingHole_3.2mm_M3_DIN965_Pad","4","","","",""\nu,0,0,"J2","Screw_Terminal_01x03","Connector_Phoenix_MSTB:PhoenixContact_MSTBA_2,5_3-G-5,08_1x03_P5.08mm_Horizontal","1","","","",""\nu,0,0,"J3","Conn_01x03","Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical","1","","","",""\nu,0,0,"J4","Conn_01x05","Connector_PinHeader_2.54mm:PinHeader_1x05_P2.54mm_Vertical","1","","","",""\nu,0,0,"JP1,JP2,JP3,JP4,JP5","Jumper_2_Open","Jumper:SolderJumper-2_P1.3mm_Open_Pad1.0x1.5mm","5","","","",""\nu,0,0,"K1","Relê 12V","Relay_THT:Relay_SPDT_Omron-G5LE-1","1","","","",""\nu,0,0,"L1","15uH","Inductor_SMD:L_Wuerth_MAPI-3012","1"," VLS3012CX-150M-1 "," 810-VLS3012CX150M1 ","TDK","Mouser"\nu,0,0,"PL3","LAUNCHXL-F28379D-J1-8","ABV_Footprint:LAUNCHXL-F28379D-J1-8","1","","","",""\nu,0,0,"Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10","BC817-40","Package_TO_SOT_SMD:SOT-23","10"," BC807-40,215 "," 771-BC807-40-T/R ","Nexperia","Mouser"\nu,0,0,"R1,R2,R4,R28,R30,R32,R58,R60,R62,R64,R85,R87,R89,R93,R95,R96,R97,R98","4K7","Resistor_SMD:R_0805_2012Metric","18","CRCW08054K70JNEB "," 71-CRCW08054K70JNEB ","Vishay","Mouser"\nu,0,0,"R3","1K","Resistor_SMD:R_0805_2012Metric","1"," RC0805JR-071KP "," 603-RC0805JR-071KP ","Yageo","Mouser"\nu,0,0,"R6,R7,R8,R37,R38,R39,R40,R69,R70,R71","100R","Resistor_SMD:R_0805_2012Metric","10","CRCW0805100RJNEC "," 71-CRCW0805J-100-E3 ","Vishay","Mouser"\nu,0,0,"R10,R11,R12,R14,R15,R16,R19,R20,R21,R22,R23,R24,R41,R42,R43,R44,R45,R46,R47,R48,R49,R50,R51,R52,R53,R54,R55,R56,R72,R73,R74,R75,R76,R77,R78,R79,R80,R81,R82,R83","499K/1%","Resistor_SMD:R_0805_2012Metric","40"," ERJ-PB6D4993V "," 667-ERJ-PB6D4993V ","Panasonic","Mouser"\nu,0,0,"R27,R29,R31,R34,R35,R36,R57,R59,R61,R63,R65,R66,R67,R68,R84,R86,R88,R90,R91,R92","330R 1%","Resistor_SMD:R_0805_2012Metric","20"," RC0805DR-07330RL "," 603-RC0805DR-07330RL ","Yageo","Mouser"\nu,0,0,"R94","1M","Resistor_SMD:R_0805_2012Metric","1"," RC0805JR-101ML "," 603-RC0805JR-101ML ","Yageo","Mouser"\nu,0,0,"R99","13K3 0.1%","Resistor_SMD:R_0805_2012Metric","1"," ERA-6AEB1332V "," 667-ERA-6AEB1332V ","Panasonic","Mouser"\nu,0,0,"R100","100K 0.1%","Resistor_SMD:R_0805_2012Metric","1"," ERA-6AEB104V "," 667-ERA-6AEB104V ","Panasonic","Mouser"\nu,0,0,"R101","49R9/1%","Resistor_SMD:R_0805_2012Metric","1","0805W8F499JT5E "," 303-0805W8F499JT5E ","Royalohm","Mouser"\nu,0,0,"U1,U2,U3,U4,U5","LM358","Package_SO:SOIC-8_3.9x4.9mm_P1.27mm","5"," LM358DMR2G "," 863-LM358DMR2G ","ONSemi","Mouser"\nu,0,0,"U7","MAX6675","Package_SO:SOIC-8_3.9x4.9mm_P1.27mm","1","","","",""\nu,0,0,"U8","74HCT541","Package_SO:SOIC-20W_7.5x12.8mm_P1.27mm","1"," 74HCT541D,653 "," 771-74HCT541D-T ","Nexperia","Mouser"\nu,0,0,"U9,U12","AM26C32","Package_SO:SOIC-16_3.9x9.9mm_P1.27mm","2","AM26C32IDRG4 "," 595-AM26C32IDRG4 ","TI","Mouser"\nu,0,0,"U10,U11","AM26C31","Package_SO:SOIC-16_3.9x9.9mm_P1.27mm","2"," AM26C31IDR "," 595-AM26C31IDR ","TI","Mouser"\nu,0,0,"U13","LM3940IMP-3.3","Package_TO_SOT_SMD:TO-252-3_TabPin4","1"," LM3940IMP-3.3/NOPB "," 926-LM3940IMP3.3NOPB ","TI","Mouser"\nu,0,0,"U17","TPS54202DDC","Package_TO_SOT_SMD:SOT-23-6","1"," TPS54202DDCR "," 595-TPS54202DDCR ","TI","Mouser"\n	f
152	Launchbed4		2	0	status,compId,leId,"Reference","Value","Datasheet","Footprint","Qty","Description","PartNumber","Mouser"\nu,0,0,"C1,C3,C4,C5,C7,C9,C12,C16,C19,C37,C38,C39,C40,C41,C42,C43,C50","100nF/50V","https://br.mouser.com/datasheet/2/585/MLCC-1837944.pdf","Capacitor_SMD:C_0805_2012Metric","17","Capacitores de cerâmica multicamada MLCC - SMD/SMT 100nF+/-10% 50V X7R 0805","CL21B104KBCNNNL "," 187-CL21B104KBCNNNL "\nu,0,0,"C2,C6","30pF","https://br.mouser.com/datasheet/2/447/KEM_C1007_X8R_ULTRA_150C_SMD-3699693.pdf","Capacitor_SMD:C_0805_2012Metric","2","Capacitores de cerâmica multicamada MLCC - SMD/SMT 16V 30pF X8R 0805 5%","C0805C300J4HACTU "," 80-C0805C300J4HACTU "\nu,0,0,"C8,C10,C13,C14,C23,C25,C26,C29,C33,C51","2.2uF","https://br.mouser.com/datasheet/2/585/MLCC-1837944.pdf","Capacitor_SMD:C_0805_2012Metric","10","Capacitores de cerâmica multicamada MLCC - SMD/SMT 2.2uF+/-10% 10V X7R 0805","CL21B225KPFNNNG "," 187-CL21B225KPFNNNG "\nu,0,0,"C11,C32","15p","https://br.mouser.com/datasheet/2/447/KEM_C1007_X8R_ULTRA_150C_SMD-3699693.pdf","Capacitor_SMD:C_0805_2012Metric","2","Capacitores de cerâmica multicamada MLCC - SMD/SMT 10V 15pF X8R 0805 2%","C0805C150G8HACTU "," 80-C0805C150G8HACTU "\nu,0,0,"C15,C17","1uF","https://br.mouser.com/datasheet/2/447/KEM_C1005_Y5V_SMD-3700105.pdf","Capacitor_SMD:C_1206_3216Metric","2","Capacitores de cerâmica multicamada MLCC - SMD/SMT 25V 1uF Y5V 1206 -20/+80%","C1206C105Z3VAC "," 80-C1206C105Z3VAC "\nu,0,0,"C18,C20","470uF/16V","https://br.mouser.com/datasheet/2/293/e_uwt-1847810.pdf","Capacitor_SMD:CP_Elec_10x10.5","2","Capacitores eletrolíticos de alumínio - SMD 25volts 470uF AEC-Q200","UWT1E471MNL1GS "," 647-UWT1E471MNL1S "\nu,0,0,"C21,C22,C24,C27,C28,C30,C31,C34,C35,C36","10nF","https://br.mouser.com/datasheet/2/447/KEM_C1002_X7R_SMD-3699509.pdf","Capacitor_SMD:C_0805_2012Metric","10","Capacitores de cerâmica multicamada MLCC - SMD/SMT 100V .01uF X7R 0805 10%","C0805C103K1RAC7411 "," 80-C0805C103K1RACLR "\nu,0,0,"C44,C45,C48,C49","22uF/25V","https://industrial.panasonic.com/cdbs/www-data/pdf/RDE0000/ABA0000C1145.pdf","Capacitor_SMD:CP_Elec_5x5.9","4","Capacitores eletrolíticos de alumínio - SMD 22UF 25V VS SMD"," 667-EEE-1EA220WR "," 667-EEE-1EA220WR "\nu,0,0,"C46","220nF","https://br.mouser.com/datasheet/2/585/MLCC-1837944.pdf","Capacitor_SMD:C_0805_2012Metric","1","Capacitores de cerâmica multicamada MLCC - SMD/SMT 220nF+/-10% 25V X7R 0805"," 187-CL21B224KAFNNNG ","CL21B224KAFNNNG "\nu,0,0,"C47","47pF","https://br.mouser.com/datasheet/2/210/WTC_MLCC_General_Purpose-1534899.pdf","Capacitor_SMD:C_0805_2012Metric","1","Capacitores de cerâmica multicamada MLCC - SMD/SMT 47pF +-5% 50V"," 791-0805N470J500CT ","0805N470J500CT "\nu,0,0,"CN1,CN2,CN3,CN4,J3,J4","Conn_02x05_Odd_Even","~","Connector_IDC:IDC-Header_2x05_P2.54mm_Vertical","6","Conector IDC","",""\nu,0,0,"CN5,CN8,CN11","Conn_01x02","~","Connector_Phoenix_MSTB:PhoenixContact_MSTBVA_2,5_2-G-5,08_1x02_P5.08mm_Vertical","3","","",""\nu,0,0,"CN6","WeAct_STM32H7XX","","JRM_Footprint:WeAct_STM32H7XX","1","Barra de pinos fêmea pode não ter que soldar","",""\nu,0,0,"CN7","Conn_01x03","~","Connector_Phoenix_MSTB:PhoenixContact_MSTBVA_2,5_3-G-5,08_1x03_P5.08mm_Vertical","1","Generic connector, single row, 01x03, script generated (kicad-library-utils/schlib/autogen/connector/)","",""\nu,0,0,"CN9","Conn_01x02","~","Connector_Phoenix_GMSTB:PhoenixContact_GMSTBA_2,5_2-G_1x02_P7.50mm_Horizontal","1","Trocar para conector parafuso","",""\nu,0,0,"CN10,CN12,CN13,CN14,CN15","Conn_02x04_Odd_Even","~","Connector_IDC:IDC-Header_2x04_P2.54mm_Vertical","5","Conector IDC","",""\nu,0,0,"D3","1N4148W","https://www.vishay.com/docs/85748/1n4148w.pdf","Diode_SMD:D_SOD-123","1","Diodos de Comutação de Sinais Pequenos Small Signal Diode, SOD-123F, 100V, 0.15A, 150C"," 1N4148W "," 637-1N4148W "\nu,0,0,"D4","ESDCAN-03","https://www.onsemi.com/pub_link/Collateral/NUP2105L-D.PDF","Package_TO_SOT_SMD:SOT-23","1","Dual Line CAN Bus Protector, 24Vrwm","ESDCAN03-2BWY"," 511-ESDCAN03-2BWY "\nu,0,0,"FB1","60R","https://www.vishay.com/doc?34023","Inductor_SMD:L_1206_3216Metric","1","Ferrite bead, small symbol","ILB1206ER600V"," 70-ILB1206ER600V "\nu,0,0,"H1,H2,H3,H4","MountingHole_Pad","~","MountingHole:MountingHole_3.2mm_M3_DIN965_Pad","4","","",""\nu,0,0,"J1","Screw_Terminal_01x03","~","Connector_Phoenix_MSTB:PhoenixContact_MSTBA_2,5_3-G-5,08_1x03_P5.08mm_Horizontal","1","","",""\nu,0,0,"J2","Conn_01x05","~","Connector_Phoenix_MC:PhoenixContact_MC_1,5_5-G-3.5_1x05_P3.50mm_Horizontal","1","Generic connector, single row, 01x05, script generated (kicad-library-utils/schlib/autogen/connector/)","",""\nu,0,0,"J5","Molex KK 254 06 vias","Distribuidores e Alojamento de Fios STRT LOCKING HEADER","Connector_Molex:Molex_KK-254_AE-6410-06A_1x06_P2.54mm_Vertical","1","Distribuidores e Alojamento de Fios STRT LOCKING HEADER","22-27-2061"," 538-22-27-2061 "\nu,0,0,"J6","Conn_01x03","~","Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical","1","Barra de pinos simples macho","",""\nu,0,0,"JP1","Jumper_2_Open","~","Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical","1","Pads na PCB","",""\nu,0,0,"JP2,JP3,JP4,JP5,JP6,JP7","Jumper_2_Open","~","Jumper:SolderJumper-2_P1.3mm_Open_Pad1.0x1.5mm","6","","",""\nu,0,0,"K1","Relê 12V","http://www.omron.com/ecb/products/pdf/en-g5le.pdf","Relay_THT:Relay_SPDT_Omron-G5LE-1","1","","",""\nu,0,0,"L1","15uH","https://product.tdk.com/system/files/dam/doc/product/inductor/inductor/smd/catalog/inductor_commercial_power_vls3012cx-1_en.pdf?ref_disty=mouser","Inductor_SMD:L_Wuerth_MAPI-3012","1","Indutores de potência - SMD 1.06A 15uH 514mOhm 3x3x1.2mm"," VLS3012CX-150M-1 "," 810-VLS3012CX150M1 "\nu,0,0,"LED1,LED4","LED_RED","https://br.mouser.com/datasheet/2/239/lite_on_lites10847_1-1737242.pdf","LED_SMD:LED_1206_3216Metric","2","LEDs de cor única Red Clear 621nm"," LTST-C150EKT "," 859-LTST-C150EKT "\nu,0,0,"LED2","LED_GREEN","https://br.mouser.com/datasheet/2/239/LTST_C150KGKT-1143771.pdf","LED_SMD:LED_1206_3216Metric","1","LEDs de cor única Green Clear 571nm"," LTST-C150KGKT "," 859-LTST-C150KGKT "\nu,0,0,"LED3","LED_YELLOW","https://br.mouser.com/datasheet/2/239/Lite_On_LTST_C150KSKT-1175233.pdf","LED_SMD:LED_1206_3216Metric","1","LEDs de cor única Yellow Clear 587nm"," LTST-C150KSKT "," 859-LTST-C150KSKT "\nu,0,0,"Q1,Q2","BC807-40","https://assets.nexperia.com/documents/data-sheet/BC807_SER.pdf","Package_TO_SOT_SMD:SOT-23","2","Transistores bipolares de junção - BJT SOT23 45V .5A PNP GP TRANS"," BC807-40,215 "," 771-BC807-40-T/R "\nu,0,0,"Q3","SI2300","https://www.vishay.com/doc?65701","Package_TO_SOT_SMD:SOT-23","1","MOSFETs 30V Vds 12V Vgs SOT-23"," SI2300DS-T1-GE3 "," 781-SI2300DS-T1-GE3 "\nu,0,0,"Q4","BC817-40","https://br.mouser.com/datasheet/2/258/BC817_16_7eBC817_40_SOT_23_-3423776.pdf","Package_TO_SOT_SMD:SOT-23","1","Transistores bipolares de junção - BJT 45V, 800mA"," BC817-40,235 "," 771-BC817-40235"\nu,0,0,"R1","120R/0.5W","https://br.mouser.com/datasheet/2/418/3/NG_CS_1309350_PASSIVE_COMPONENT_0807-715500.pdf","Resistor_SMD:R_1206_3216Metric","1","Thick Film Resistors - SMD CRGH1206 5% 120R 0.5W","CRGH1206J120R "," 279-CRGH1206J120R "\nu,0,0,"R2,R3,R4,R5,R6,R7,R8,R9,R10,R11","100R","https://www.vishay.com/doc?20035","Resistor_SMD:R_0805_2012Metric","10","Thick Film Resistors - SMD 1/8watt 100ohms 5% 200ppm","CRCW0805100RJNEC "," 71-CRCW0805J-100-E3 "\nu,0,0,"R12,R13,R15","270R","https://br.mouser.com/datasheet/2/385/SEI_RMCF_RMCP-3077565.pdf","Resistor_SMD:R_0805_2012Metric","3","Thick Film Resistors - SMD 270Ohms 0805 0.125W 5% Std Power AEC-Q200","RMCF0805JT270R "," 708-RMCF0805JT270R "\nu,0,0,"R14","10K","https://www.vishay.com/doc?20035","Resistor_SMD:R_0805_2012Metric","1","Thick Film Resistors - SMD D12/CRCW0805 200 10K 5% ET6 e3","CRCW080510K0JNEC "," 71-CRCW080510K0JNEC "\nu,0,0,"R16,R18,R28,R37,R38,R39,R56,R66,R71,R72,R87","4K7","https://www.vishay.com/doc?20035","Resistor_SMD:R_0805_2012Metric","11","Thick Film Resistors - SMD 1/8watt 4.7Kohms 5%","CRCW08054K70JNEB "," 71-CRCW08054K70JNEB "\nu,0,0,"R17,R23,R27,R31,R32,R33,R40,R41,R44,R47,R54,R60,R63,R65,R67,R68,R73,R75,R81,R85","330R/0.5%","https://br.mouser.com/datasheet/2/447/PYu_RC_Group_51_RoHS_L_12-3368608.pdf","Resistor_SMD:R_0805_2012Metric","20","Thick Film Resistors - SMD General Purpose Chip Resistor 0805, 330Ohms, 0.5%, 1/8W"," RC0805DR-07330RL "," 603-RC0805DR-07330RL "\nu,0,0,"R19,R20,R21,R25,R26,R29,R30,R34,R35,R36,R42,R43,R45,R46,R48,R49,R50,R51,R52,R53,R55,R57,R58,R59,R62,R64,R69,R70,R74,R76,R77,R78,R79,R80,R82,R83,R84,R86,R88,R89","499K/0.5%","https://industrial.panasonic.com/cdbs/www-data/pdf/RDM0000/AOA0000C328.pdf","Resistor_SMD:R_0805_2012Metric","40","Thick Film Resistors - SMD 0805 Anti-Surge Res. 0.5%, 499Kohm"," ERJ-PB6D4993V "," 667-ERJ-PB6D4993V "\nu,0,0,"R22,R24","1K","https://br.mouser.com/datasheet/2/447/pyu_rc_51_rohs_p-3370815.pdf","Resistor_SMD:R_0805_2012Metric","2","Thick Film Resistors - SMD General Purpose Chip Resistor 0805, 1kOhms, 5%, 1/8W"," RC0805JR-071KP "," 603-RC0805JR-071KP "\nu,0,0,"R61","1M","https://br.mouser.com/datasheet/2/447/PYu_RC_Group_51_RoHS_L_11-1984063.pdf","Resistor_SMD:R_0805_2012Metric","1","Thick Film Resistors - SMD General Purpose Chip Resistor 0805, 1MOhms, 5%, 1/8W"," RC0805JR-101ML "," 603-RC0805JR-101ML "\nu,0,0,"R90","13K3 0.1%","https://industrial.panasonic.com/cdbs/www-data/pdf/RDM0000/AOA0000C307.pdf","Resistor_SMD:R_0805_2012Metric","1","Thin Film Resistors - SMD 0805 13.3Kohm 0.1% 25ppm"," ERA-6AEB1332V "," 667-ERA-6AEB1332V "\nu,0,0,"R91","100K 0.1%","https://industrial.panasonic.com/cdbs/www-data/pdf/RDM0000/AOA0000C307.pdf","Resistor_SMD:R_0805_2012Metric","1","Thin Film Resistors - SMD 0805 1/8W 100Kohms"," ERA-6AEB104V "," 667-ERA-6AEB104V "\nu,0,0,"R92","49R9/1%","https://br.mouser.com/datasheet/2/1365/1-3571082.pdf","Resistor_SMD:R_0805_2012Metric","1","Thick Film Resistors - SMD RMC 0805 1/8W 1% T/R-5000","0805W8F499JT5E "," 303-0805W8F499JT5E "\nu,0,0,"SW1,SW2","SW_Push","~","Button_Switch_SMD:SW_SPST_CK_RS282G05A3","2","Push button switch, generic, two pins","",""\nu,0,0,"U1,U4,U7","AM26C31","https://www.ti.com/lit/gpn/am26c31m","Package_SO:SOIC-16_3.9x9.9mm_P1.27mm","3","RS-422 Interface IC Quad Diff Line Drvr A 595-AM26C31ID"," AM26C31IDR "," 595-AM26C31IDR "\nu,0,0,"U2,U6,U8","AM26C32","https://www.ti.com/lit/gpn/am26c32","Package_SO:SOIC-16_3.9x9.9mm_P1.27mm","3","RS-422 Interface IC Quad Diff Line ALT 595-AM26C32IDR","AM26C32IDRG4 "," 595-AM26C32IDRG4 "\nu,0,0,"U3","74HCT541","https://assets.nexperia.com/documents/data-sheet/74HC_HCT541.pdf","Package_SO:SOIC-20W_7.5x12.8mm_P1.27mm","1","Buffers & Line Drivers SOT163-1 OCTAL BUFFER/DRIVER"," 74HCT541D,653 "," 771-74HCT541D-T "\nu,0,0,"U5","TJA1050","https://br.mouser.com/datasheet/2/302/TJA1050-3083416.pdf","Package_SO:SOIC-8_3.9x4.9mm_P1.27mm","1","CAN Interface IC High-speed CAN transceiver"," TJA1050T/CM,118 "," 771-TJA1050T/CM118 "\nu,0,0,"U9","STM32F405RGT6","https://www.st.com/resource/en/datasheet/stm32f405rg.pdf","Package_QFP:LQFP-64_10x10mm_P0.5mm","1","ARM Microcontrollers - MCU ARM M4 1024 FLASH 168 Mhz 192kB SRAM","STM32F405RGT6 "," 511-STM32F405RGT6 "\nu,0,0,"U10,U11,U12,U15,U16","LM358","http://www.ti.com/lit/ds/symlink/lm2904-n.pdf","Package_SO:SOIC-8_3.9x4.9mm_P1.27mm","5","Low-Power, Dual Operational Amplifiers, DIP-8/SOIC-8/TO-99-8"," LM358DMR2G "," 863-LM358DMR2G "\nu,0,0,"U13","LM3940IMP-3.3","https://www.ti.com/lit/gpn/lm3940","Package_TO_SOT_SMD:TO-252-3_TabPin4","1","LDO Voltage Regulators 1A LDO REG A 926-LM3940IMPX33NOPB"," LM3940IMP-3.3/NOPB "," 926-LM3940IMP3.3NOPB "\nu,0,0,"U14","MAX6675","","Package_SO:SOIC-8_3.9x4.9mm_P1.27mm","1","","",""\nu,0,0,"U17","TPS54202DDC","http://www.ti.com/lit/ds/symlink/tps54202.pdf","Package_TO_SOT_SMD:SOT-23-6","1","2A, 4.5 to 28V Input, EMI Friendly integrated switch synchronous step-down regulator, pulse-skipping, SOT-23-6"," TPS54202DDCR "," 595-TPS54202DDCR "\nu,0,0,"X1","ABM3B-8.0-10-1UT","https://br.mouser.com/datasheet/2/3/abm3b-1774998.pdf","Crystal:Crystal_SMD_Abracon_ABM3B-4Pin_5.0x3.2mm","1","Crystals 8.0 MHZ 10PF","ABM3B-8.0-10-1UT"," 815-ABM3B8MHZ101UT "\n	f
151	Vydence PFC		1	0		f
111	BoatArm		2	0		f
153	Compra Extra de Outubro 2025		1	1	status,compId,leId,Qty,Reference,Value,Exclude from BOM,Footprint,Descrição,#,Partnumber,Ordercode,mfr,Supplier\nu,0,0,1,C1,0.33u,,Capacitor_THT:C_Rect_L18.0mm_W8.0mm_P15.00mm_FKS3_FKP3,Unpolarized capacitor,1,B32922C3334M,,,\nu,0,0,11,"C2,C4,C5,C7,C10,C11,C13,C14,C27,C30,C31",100n,,Capacitor_SMD:C_0603_1608Metric,Unpolarized capacitor,2,,,,\nu,0,0,4,"C3,C6,C12,C15",10u,,Capacitor_SMD:C_1206_3216Metric,Unpolarized capacitor,3,,,,\nu,0,0,2,"C8,C22",4u7,,Capacitor_THT:C_Rect_L33.0mm_W20.0mm_P27.50mm_MKS4,Unpolarized capacitor,4,B32924C3475M,,,\nu,0,0,1,C9,2.2uF/630VDC,,Capacitor_THT:C_Rect_L28.0mm_W12.0mm_P22.50mm_MKS4,Unpolarized capacitor,5,ECW-FE2J225KA, 667-ECW-FE2J225KA ,,\nu,0,0,3,"C16,C17,C19",22uF/25V,,Capacitor_SMD:CP_Elec_5x5.9,,6,,,,\nu,0,0,1,C18,100uF,,Capacitor_SMD:CP_Elec_6.3x9.9,,7,,,,\nu,0,0,2,"C20,C21",470pF/1000V,,Capacitor_THT:C_Disc_D6.0mm_W4.4mm_P5.00mm,Unpolarized capacitor,8,S471K25Y5PN63J5R ,,,\nu,0,0,1,C23,100nF,,Capacitor_SMD:C_0603_1608Metric,,9,,,,\nu,0,0,5,"C24,C25,C26,C28,C29",47n,,Capacitor_SMD:C_2220_5750Metric,Unpolarized capacitor,10,GA355ER7GB473KW01L,,,\nu,0,0,7,"C32,C33,C34,C35,C36,C37,C38",100nF/1kV,,Capacitor_SMD:C_1812_4532Metric,Unpolarized capacitor,11,C1812C104KDRACTU,,,\nu,0,0,1,C39,330nF/305VAC,,Capacitor_SMD:C_1812_4532Metric,Unpolarized capacitor,12,B32922C3334M,,,\nu,0,0,4,"D1,D2,D6,D7",STTH3010W,,Package_TO_SOT_THT:TO-247-2_Vertical,Diode,13, STTH3010W , 511-STTH3010W ,,\nu,0,0,2,"D3,D8",ES1J,,Diode_SMD:D_SMA,Ultrafast recovery diode,14,ES1J,,,\nu,0,0,4,"D4,D5,D9,D10",SMAJ15,,Diode_SMD:D_SMA,"400W unidirectional Transient Voltage Suppressor, 15.0Vr, SMA(DO-214AC)",15, SMAJ15A-AT/TR13 , 603-SMAJ15A-AT/TR13 ,Yageo,Mouser\nu,0,0,1,DCDC1,B2415S-2WR3,,JRM_Footprint:BXXXXS-2W_EXT,DC/DC Converters - Through Hole 2W 24Vin 15Vout 133mA Single SIP7,16, RKZE-2415S/P , 919-RKZE-2415S/P ,,\nu,0,0,2,"DCDC2,DCDC3",B2412S-2WR3,,JRM_Footprint:BXXXXS-2W_EXT,DC/DC Converters - Through Hole 2W 24Vin +/-15Vout +/-66mA Dual SIP7,17, RKZE-2412S , 919-RKZE-2412S ,,\nu,0,0,2,"FAN1,FAN2",~,,JRM_Footprint:FAN_50mm_15mm_H8.0,,18,,,,\nu,0,0,1,FAN3,~,,JRM_Footprint:FAN_50mm_20mm_H8.0,,19,,,,\nu,0,0,4,"FB1,FB3,FB7,FB9",0.1R,,JRM_Footprint:WE-CBF-SMT-FB,"Ferrite bead, small symbol",20,74279244,,,\nu,0,0,4,"FB2,FB4,FB6,FB8",2K/100Mhz,,Inductor_SMD:L_0603_1608Metric,"Ferrite bead, small symbol",21,ILBB0603ER202V , 70-ILBB0603ER202V ,Vishay,Mouser\nu,0,0,3,"FB5,FB11,FB13",2K2,,Inductor_SMD:L_CommonMode_Wurth_WE-CNSW-1206,"Common mode choke, 370 mA, 125VDC, USB2.0, 111 nH",22,BWCU00321619222M02 , 673-BWCU321619222M02 ,,Mouser\nu,0,0,2,"FB10,FB12",2K,,Inductor_SMD:L_0603_1608Metric,"Ferrite bead, small symbol",23,ILBB0603ER202V , 70-ILBB0603ER202V ,Vishay,Mouser\nu,0,0,1,FID1,Fiducial,Excluded from BOM,Fiducial:Fiducial_1.5mm_Mask3mm,Fiducial Marker,24,,,,\nu,0,0,1,FL1,26A,,JRM_Footprint:Filter 26A,"EMI 2-inductor filter, pin-connections 1-4 and 2-3",25,B82726E6263A040, 871-B82726E6263A40 ,,\nu,0,0,4,"H1,H2,H3,H4",MountingHole_Pad,Excluded from BOM,MountingHole:MountingHole_3.5mm_Pad,Mounting Hole with connection,26,,,,\nu,0,0,2,"HS1,HS3",Heatsink,,JRM_Footprint:Heatsink_HS6835_40_2H,"Heatsink with electrical connection, 2 pin",27,,,,\nu,0,0,2,"HS2,HS4",Heatsink,,JRM_Footprint:Heatsink_HS6835_40_1H,"Heatsink with electrical connection, 1 pin",28,,,,\nu,0,0,1,J1,Conn_02x13_Odd_Even,,JRM_Footprint:PCA2_Control_02x16_B,"Generic connector, double row, 02x13, odd/even pin numbering scheme (row 1 odd numbers, row 2 even numbers), script generated (kicad-library-utils/schlib/autogen/connector/)",29,,,,\nu,0,0,2,"J2,J3",Conn_02x03_Top_Bottom,,Connector_CH:455580003,"Generic connector, double row, 02x03, top/bottom pin numbering scheme (row 1: 1...pins_per_row, row2: pins_per_row+1 ... num_pins), script generated (kicad-library-utils/schlib/autogen/connector/)",30,45558-0003 , 538-45558-0003 ,,\nu,0,0,1,J4,Conn_02x02_Top_Bottom,,Connector_Molex:Molex_Micro-Fit_3.0_43045-0400_2x02_P3.00mm_Horizontal,"Generic connector, double row, 02x02, top/bottom pin numbering scheme (row 1: 1...pins_per_row, row2: pins_per_row+1 ... num_pins), script generated (kicad-library-utils/schlib/autogen/connector/)",31,39-30-1040, 538-39-30-1040 ,,\nu,0,0,1,J5,Conn_01x02,,Connector_Molex:Molex_Mini-Fit_Jr_5569-02A2_2x01_P4.20mm_Horizontal,"Generic connector, single row, 01x02, script generated (kicad-library-utils/schlib/autogen/connector/)",32,,,,\nu,0,0,1,L1,800uH,,JRM_Footprint:CS400125-2,SENDUST CORE,33,K157-125A,,,\nu,0,0,1,LED1,LED_GREEN,,LED_SMD:LED_1206_3216Metric,,34,,,,\nu,0,0,1,M1,Fan,,Connector_JST:JST_XH_B2B-XH-A_1x02_P2.50mm_Vertical,Fan,35,B2B-XH-A-BK(LF)(SN), 306-B2BXHABKLFSNP,,\nu,0,0,2,"M2,M3",Fan,,Connector_JST:JST_XH_B2B-XH-A_1x02_P2.50mm_Vertical,Fan,36,B2B-XH-A-BK(LF)(SN) , 306-B2BXHABKLFSNP,,Mouser\nu,0,0,1,Q1,IXFH90N65X3,,Package_TO_SOT_THT:TO-247-3_Vertical,Depletion-mode N-channel MOSFET gate/drain/source,37,IXFH90N65X3, 747-IXFH90N65X3 ,,\nu,0,0,2,"Q2,Q3",IMW65R007M2H,,Package_TO_SOT_THT:TO-247-3_Vertical,Depletion-mode N-channel MOSFET gate/drain/source,38,IMW65R007M2H, 726-IMW65R007M2HXKSA ,,\nu,0,0,1,Q4,IXFH90N65X3,,Package_TO_SOT_THT:TO-247-3_Vertical,Depletion-mode N-channel MOSFET gate/drain/source,39,IXFH90N65X3 , 747-IXFH90N65X3 ,,\nu,0,0,2,"Q5,Q6",PZT2222A,,Package_TO_SOT_SMD:SOT-223-3_TabPin2,,40, PZT2222A-TP, 833-PZT2222A-TP ,,\nu,0,0,1,Q7,BC817,,Package_TO_SOT_SMD:SOT-23,"0.8A Ic, 45V Vce, NPN Transistor, SOT-23",41,,,,\nu,0,0,2,"R1,R12",0R0,,Resistor_SMD:R_1206_3216Metric,"Resistor, US symbol",42,3540220RJT , 279-3540220RJT ,TE Connectivity,Mouser\nu,0,0,7,"R2,R7,R8,R16,R18,R41,R43",0R0,,Resistor_SMD:R_0603_1608Metric,"Resistor, US symbol",43,,,,\nu,0,0,4,"R3,R9,R13,R15",0R33,,Resistor_SMD:R_1206_3216Metric,"Resistor, US symbol",44,,,,\nu,0,0,4,"R4,R10,R17,R20",1k,,Resistor_SMD:R_0603_1608Metric,"Resistor, US symbol",45,,,,\nu,0,0,4,"R5,R6,R14,R19",10K,,Resistor_SMD:R_0603_1608Metric,"Resistor, US symbol",46,,,,\nu,0,0,1,R11,270R,,Resistor_SMD:R_0603_1608Metric,"Resistor, US symbol",47,,,,\nu,0,0,2,"R21,R22",470K,,Resistor_SMD:R_0603_1608Metric,"Resistor, US symbol",48,,,,\nu,0,0,2,"R23,R24",390R,,Resistor_SMD:R_0603_1608Metric,"Resistor, US symbol",49,,,,\nu,0,0,7,"R25,R40,R44,R48,R49,R50,R51",2K2,,Resistor_SMD:R_0603_1608Metric,"Resistor, US symbol",50,,,,\nu,0,0,4,"R26,R30,R32,R33",100K 1%,,Resistor_SMD:R_1206_3216Metric,"Resistor, US symbol",51,RT1206FRE07100KL ,,,\nu,0,0,14,"R27,R28,R29,R31,R34,R35,R36,R37,R38,R39,R42,R45,R46,R47",160K 1%,,Resistor_SMD:R_1206_3216Metric,"Resistor, US symbol",52,ERA-8AEB164V,,,\nu,0,0,1,R52,220R/5W,,Resistor_SMD:R_2816_7142Metric,"Resistor, US symbol",53,3540220RJT , 279-3540220RJT ,TE Connectivity,Mouser\nu,0,0,4,"R53,R54,R56,R57",0R5,,Resistor_SMD:R_2512_6332Metric,"Resistor, US symbol",54,MSMA2512R5000FEN ,,,\nu,0,0,1,R55,0R0,,Resistor_SMD:R_2512_6332Metric,"Resistor, US symbol",55,3522ZR, 279-3522ZR ,,\nu,0,0,18,"R58,R59,R60,R61,R62,R63,R64,R65,R66,R67,R68,R69,R70,R71,R72,R73,R74,R75",1M,,Resistor_SMD:R_1206_3216Metric,"Resistor, US symbol",56,,,,\nu,0,0,3,"SYM1,SYM2,SYM3",SYM_Flash_Large,Excluded from BOM,Symbol:Symbol_HighVoltage_Triangle_6x6mm_Copper,"Flash symbol, large",57,,,,\nu,0,0,1,T1,ETD59 Coil Former,,JRM_Footprint:ETD59_6x4_CROSS,ETD59 Core Former,58,B66398W1024T001,,,\nu,0,0,2,"TCC1,TCC2",ETD59 Core Clip,,,EC Core Clip,59,B66398A2000X000,,,\nu,0,0,2,"TEC1,TEC2",ETD59 Core,,,Tranformer E Core (half),60,B66397G0200X187,,,\nu,0,0,2,"TH1,TH2",10K,,JRM_Footprint:NTC_P5.08,"Temperature dependent resistor, negative temperature coefficient, US symbol",61,B57861S0103F040,,,\nu,0,0,2,"TH3,TH4",10K,,,"Temperature dependent resistor, negative temperature coefficient, US symbol",62,B57861S0103F040,,,\nu,0,0,22,"TP1,TP2,TP3,TP4,TP5,TP6,TP7,TP8,TP9,TP10,TP11,TP12,TP13,TP14,TP15,TP16,TP17,TP18,TP19,TP20,TP21,TP22",TestPoint,,Connector_Pin:Pin_D0.7mm_L6.5mm_W1.8mm_FlatFork,test point,63,,,,\nu,0,0,1,TP23,TestPoint,,TestPoint:TestPoint_Pad_1.0x1.0mm,test point,64,,,,\nu,0,0,2,"U1,U2",2EDR8259X,,JRM_Footprint:SOIC127P600X175-16_14N-1-V,Dual-channel isolated gate driver ICs in 300 mil DSO package,65,2EDB8259YXUMA1 , 726-2EDB8259YXUMA1,,\nu,0,0,2,"U3,U4",LTV-816S,,Package_DIP:SMDIP-4_W9.53mm,"DC Optocoupler, Vce 35V, CTR 50%, SMDIP-4",66, LTV-816S-TA1 , 859-LTV-816S-TA1 ,LiteON,\nu,0,0,1,U5,TMCS1133C5,,JRM_Footprint:SOIC10_DVG_TEX,,67,TMCS1133C5AQDVGR , 595-TMCS1133C5AQDVGR ,,\nu,0,0,1,U6,74HC1G14,,Package_TO_SOT_SMD:SOT-23-5,Logic Level Inverter,68,HC1G14GV125, 771-HC1G14GV125 ,,\nu,0,0,1,U7,TMCS1133C3,,JRM_Footprint:SOIC10_DVG_TEX,,69,TMCS1133C3AQDVGR , 595-TMCS1133C3AQDVGR ,,\n	f
140	lacep_control Completa	Placa com todos os componentes, iremos montar com menos componentes.	2	0		f
139	invleg6v2	estoque ok	2	0		f
148	iv4203Hall	Utilzando sensor de corrente da LEM, fazer 3 por placa	1	0		f
141	iv420 Completa	Para correntes mais baixas ou tensão	1	0		f
149	lacep_control menor	Trata-se da versão com menos partes a serem montadas	2	0		f
146	Launchbed3		1	0		f
147	line_driver		1	0		f
\.


--
-- Data for Name: manufacturers; Type: TABLE DATA; Schema: public; Owner: jrm
--

COPY public.manufacturers (id, name, descr, web) FROM stdin;
3	NSC	National Semiconductors	http://www.national.com/catalog
4	NXP	NXP	http://www.nxp.com
5	ST	SGS Thompsom	http://www.st.com
8	HAR	HARTING	http://www.harting.com.br
9	KOA	KOA	http://
11	FCH	FAIRCHILD	http://www.fairchildsemi.com
7	AVG	AVAGO Semiconductors	http://www.avagotech.com
13	PTR	Phoenix Mecano	http://
14	Vishay		
10	ONSemi	ONSEMI	http://www.onsemi.com
15	Panasonic		
16	Walsin		
17	Kemet		
18	Samsung		
19	TDK		
20	Royalohm		
12	Infineon	International Rectifier	http://www.irf.com
21	Yageo		
2	Texas	Texas Instruments	http://www.ti.com
0	0 Não Atribuído		
1	0 Não Determinado		
22	LITE-ON	LITE-ON Technology Corp. / Optoelectronics	
23	Molex		
24	TE Connectivity		
\.


--
-- Data for Name: quotes; Type: TABLE DATA; Schema: public; Owner: jrm
--

COPY public.quotes (id, shop_id, component_id, deprecated, quantity, price, currency_id, tax) FROM stdin;
97	10	144	1	10	0.493499999999999994	1	\N
98	10	145	1	10	0.566999999999999948	1	\N
3	1	5	1	10	7.54999999999999982	2	\N
4	3	10	1	1	15.1199999999999992	1	\N
5	3	11	1	1	16.8399999999999999	1	\N
6	1	13	1	1	3	1	\N
1	1	1	1	10	0.0200000000000000004	1	\N
107	17	59	1	1	25	1	0
99	11	177	1	1	11.7300000000000004	1	\N
100	11	178	1	50	3.2200000000000002	1	\N
101	15	177	1	1	11.3000000000000007	1	\N
102	16	179	6	1	1	1	\N
8	1	0	1	1	2.75	2	\N
9	1	15	1	1	0.699999999999999956	1	\N
10	1	53	1	1	0.900000000000000022	2	\N
13	4	53	1	1	0.900000000000000022	2	\N
14	4	18	1	1	1.72999999999999998	2	\N
15	4	49	1	1	2.10999999999999988	2	\N
17	4	47	1	1	2.75999999999999979	2	\N
18	4	46	1	1	2.75999999999999979	2	\N
19	1	21	1	1	0.100000000000000006	1	\N
20	1	22	1	1	0.270000000000000018	1	\N
22	1	50	1	1	15	1	\N
23	4	8	1	1	5.29999999999999982	2	\N
24	4	52	1	1	3.10999999999999988	2	\N
26	4	45	1	1	1.97999999999999998	2	\N
28	1	33	1	10	2.20000000000000018	1	\N
29	1	41	1	100	0.0500000000000000028	1	\N
30	1	42	1	100	0.0500000000000000028	1	\N
31	1	57	1	100	0.0500000000000000028	1	\N
32	1	23	1	50	0.0200000000000000004	1	\N
33	1	24	1	50	0.0200000000000000004	1	\N
34	1	25	1	50	0.0200000000000000004	1	\N
35	1	26	1	50	0.0200000000000000004	1	\N
37	1	28	1	50	0.0200000000000000004	1	\N
38	1	29	1	50	0.0200000000000000004	1	\N
39	1	30	1	50	0.0200000000000000004	1	\N
41	1	38	1	10	0.800000000000000044	1	\N
42	1	39	1	10	0.800000000000000044	1	\N
43	1	40	1	10	0.800000000000000044	1	\N
44	1	54	1	10	1	1	\N
45	1	58	1	20	39.6700000000000017	1	\N
47	1	60	1	50	30	1	\N
46	1	59	1	1	1	6	\N
49	1	62	1	10	0.149999999999999994	1	\N
50	1	63	1	10	0.149999999999999994	1	\N
51	1	64	1	1	0.200000000000000011	1	\N
52	1	66	1	1	3.4700000000000002	1	\N
53	1	74	1	10	0.149999999999999994	1	\N
54	1	75	1	10	0.149999999999999994	1	\N
55	1	69	1	100	0.00700000000000000015	1	\N
56	1	70	1	100	0.00700000000000000015	1	\N
57	1	71	1	100	0.00700000000000000015	1	\N
58	1	72	1	100	0.00700000000000000015	1	\N
59	1	73	1	100	0.00700000000000000015	1	\N
60	1	76	1	1	1	1	\N
61	1	77	1	2	1.5	1	\N
63	1	79	1	1	6	1	\N
103	16	181	6	1	1	1	\N
65	1	81	1	10	1.85000000000000009	2	\N
66	1	83	1	1	0.5	1	\N
67	1	84	1	1	0.5	1	\N
68	1	82	1	1	0.5	1	\N
70	1	65	1	1	3.5	1	\N
71	1	67	1	5	0.100000000000000006	1	\N
64	1	80	1	10	49.5	1	\N
72	5	85	1	20	20	1	\N
74	8	95	2	50	0.0299999999999999989	1	\N
104	1	189	1	1	1	5	\N
76	8	25	3	50	0.0299999999999999989	1	\N
77	8	106	3	50	0.0299999999999999989	1	\N
78	8	27	3	50	0.0299999999999999989	1	\N
79	8	112	3	50	0.0299999999999999989	1	\N
80	8	118	3	50	0.0299999999999999989	1	\N
81	8	100	2	50	0.0299999999999999989	1	\N
82	8	114	3	50	0.0299999999999999989	1	\N
83	8	99	2	50	0.0299999999999999989	1	\N
84	8	98	2	50	0.0400000000000000008	1	\N
85	8	97	2	15	0.110000000000000001	1	\N
105	17	190	1	1	160	1	\N
87	8	65	4	8	1.01000000000000001	1	\N
86	8	66	4	8	0.989999999999999991	1	\N
92	8	119	2	20	0.160000000000000003	1	\N
93	1	138	1	10	25	1	\N
94	1	139	1	20	30	1	\N
106	17	140	1	1	20	1	\N
48	1	61	1	1	1	4	\N
95	1	140	1	1	1	4	\N
108	17	189	1	1	80	1	\N
109	18	191	1	1	471	1	\N
110	18	192	1	1	52.3999999999999986	1	\N
113	18	173	1	1	0.349999999999999978	1	\N
114	18	174	1	1	0.349999999999999978	1	\N
115	18	175	1	1	1.19999999999999996	1	\N
116	18	176	1	1	1.19999999999999996	1	\N
112	18	193	1	1	41.2999999999999972	1	\N
118	20	196	1	10	25	1	\N
169	34	144	1	10	0.540000000000000036	1	0
123	29	90	1	100	0.100000000000000006	1	\N
124	29	22	1	100	0.149999999999999994	1	\N
125	29	197	1	100	0.149999999999999994	1	\N
126	29	198	1	100	0.149999999999999994	1	\N
127	29	199	1	100	0.149999999999999994	1	\N
128	29	21	1	100	0.149999999999999994	1	\N
133	32	21	1	352	0.179999999999999993	1	0
134	32	90	1	132	0.179999999999999993	1	0
135	32	197	1	100	0.179999999999999993	1	0
136	32	22	1	100	0.179999999999999993	1	0
137	32	198	1	100	0.179999999999999993	1	0
138	32	199	1	100	0.179999999999999993	1	0
139	32	0	1	100	0.179999999999999993	1	0
141	32	76	1	16	0.599999999999999978	1	0
142	32	0	1	16	0.599999999999999978	1	0
143	32	13	1	40	2.29999999999999982	1	0
144	32	0	1	40	2.29999999999999982	1	0
145	32	15	1	8	0.949999999999999956	1	0
146	32	67	1	32	0.0500000000000000028	1	0
150	33	25	1	50	0.0299999999999999989	1	2
151	33	99	1	50	0.0299999999999999989	1	2
152	33	100	1	50	0.0299999999999999989	1	2
153	33	98	1	50	0.0400000000000000008	1	2
154	33	0	1	50	0.0400000000000000008	1	2
155	33	23	1	100	0.0299999999999999989	1	2
156	33	29	1	100	0.0299999999999999989	1	2
157	33	142	1	50	0.0299999999999999989	1	2
158	33	0	1	50	0.0299999999999999989	1	2
159	33	101	1	50	0.0400000000000000008	1	2
160	33	65	1	50	0.949999999999999956	1	10
161	33	66	1	42	0.880000000000000004	1	5
162	33	77	1	50	0.440000000000000002	1	5
164	33	0	1	48	1.26000000000000001	1	5
167	33	95	1	50	0.0299999999999999989	1	2
168	33	184	1	10	0.680000000000000049	1	5
130	30	187	1	20	55	1	0
131	30	200	1	3	85	1	0
91	8	123	2	4	6.66999999999999993	1	0
170	34	145	1	10	0.520000000000000018	1	0
171	34	25	1	50	0.0500000000000000028	1	0
172	34	0	1	10	12	1	0
173	34	51	1	10	12	1	0
174	34	207	1	10	1.34000000000000008	1	0
176	34	159	1	10	2.75	1	0
177	18	209	1	1	0.349999999999999978	1	0
178	36	207	3	10	1.34000000000000008	1	2
180	36	211	5	50	0.0500000000000000028	1	2
179	36	51	5	10	12.0099999999999998	1	5
192	38	222	10	8	0	1	0
195	38	244	10	4	0	1	0
197	38	230	10	3	0	1	0
199	38	236	10	2	0	1	0
200	38	237	10	1	0	1	0
208	38	246	36	4	0	1	0
191	38	243	36	4	0	1	0
209	38	247	35	1	0	1	0
211	38	235	35	7	0	1	0
213	38	249	35	17	0	1	0
215	38	225	35	17	0	1	0
216	38	251	35	10	0	1	0
181	38	239	35	6	0	1	0
182	38	240	35	1	0	1	0
218	38	253	35	1	0	1	0
184	38	242	35	1	0	1	0
183	38	241	10	2	0	1	0
185	38	227	35	1	0	1	0
219	38	254	35	16	0	1	0
186	38	215	10	3	0	1	0
189	38	223	36	6	0	1	0
221	38	216	35	6	0	1	0
223	38	258	35	2	0	1	0
224	38	256	5	10	0	1	0
225	38	259	35	13	0	1	0
227	38	50	5	6	0	1	0
228	38	261	35	9	0	1	0
229	38	262	5	6	0	1	0
230	38	219	35	4	0	1	0
233	38	265	35	6	0	1	0
235	38	234	35	12	0	1	0
198	38	221	10	10	0	1	0
237	38	266	5	4	0	1	0
236	38	238	10	4	0	1	0
239	38	270	10	4	0	1	0
187	38	228	10	6	0	1	0
241	38	224	10	3	0	1	0
243	38	273	10	2	0	1	0
244	38	46	5	5	0	1	0
250	38	277	5	2	0	1	0
252	38	279	10	1	0	1	0
253	38	280	10	8	0	1	0
188	38	220	10	1	0	1	0
256	38	283	5	1	0	1	0
257	38	284	5	10	0	1	0
255	38	282	5	32	0	1	0
258	38	285	5	33	0	1	0
90	8	122	5	8	1	1	0
254	38	281	5	4	0	1	0
262	38	287	5	2	0	1	0
88	8	10	5	1	14.4000000000000004	1	0
265	38	93	25	27	0	1	0
266	38	290	25	6	0	1	0
269	38	293	25	8	0	1	0
270	38	294	25	6	0	1	0
271	38	295	25	6	0	1	0
268	38	292	25	20	0	1	0
267	38	291	25	41	0	1	0
273	38	297	25	13	0	1	0
274	38	298	25	4	0	1	0
275	38	299	25	17	0	1	0
276	38	300	25	1	0	1	0
277	38	301	25	2	0	1	0
278	38	302	25	2	0	1	0
279	38	303	25	16	0	1	0
280	38	304	25	47	0	1	0
281	38	305	25	4	0	1	0
282	38	306	25	1	0	1	0
283	38	307	25	1	0	1	0
264	38	289	25	3	0	1	0
284	38	308	25	1	0	1	0
285	38	309	25	1	0	1	0
286	38	310	25	1	0	1	0
287	38	311	25	1	0	1	0
288	38	312	25	1	0	1	0
272	38	314	25	21	0	1	0
263	38	288	25	21	0	1	0
292	40	154	8	2	0	1	0
296	40	347	7	19	0	1	0
297	40	349	7	3	0	1	0
298	40	350	7	45	0	1	0
293	40	345	7	19	0	1	0
300	40	352	7	51	0	1	0
301	40	351	7	5	0	1	0
302	40	348	7	7	0	1	0
299	40	62	7	227	0	1	0
295	40	346	7	24	0	1	0
291	40	315	7	15	0	1	0
303	40	324	8	3	0	1	0
304	40	313	27	2	0	1	0
111	19	44	19	15	49.5	1	0
149	33	24	21	50	0.0299999999999999989	1	2
75	8	24	21	50	0.0299999999999999989	1	0
89	8	125	5	5	1.68999999999999995	1	0
309	42	733	3	50	0	1	0
310	42	23	21	100	0	1	0
311	42	735	21	50	0	1	0
312	42	738	44	50	0	1	0
313	42	737	44	100	0	1	0
314	42	98	2	50	0	1	0
315	42	631	19	51	0	1	0
317	42	77	44	70	0	1	0
319	42	184	44	10	0	1	0
320	42	144	44	10	0	1	0
321	42	145	44	10	0	1	0
323	42	66	44	50	0	1	0
324	42	741	44	390	0	1	0
325	42	159	44	20	0	1	0
326	38	748	0	1	0	1	0
327	43	747	29	12	0	1	0
328	43	748	29	3	0	1	0
330	43	750	30	3	0	1	0
329	43	749	30	5	0	1	0
333	43	752	1	7	0	1	0
334	43	753	30	6	0	1	0
335	43	754	30	1	0	1	0
336	43	755	30	2	0	1	0
337	43	757	28	2	0	1	0
338	43	758	28	1	0	1	0
339	43	759	28	1	0	1	0
340	43	760	28	1	0	1	0
341	43	761	28	3	0	1	0
342	43	762	28	1	0	1	0
343	43	763	28	4	0	1	0
345	43	765	28	6	0	1	0
346	43	766	28	45	0	1	0
347	43	767	28	1	0	1	0
348	43	768	28	3	0	1	0
349	43	769	28	1	0	1	0
350	43	770	28	1	0	1	0
351	43	771	28	1	0	1	0
352	43	772	28	1	0	1	0
344	43	764	28	3	0	1	0
353	43	773	28	1	0	1	0
354	43	774	28	1	0	1	0
355	43	683	21	10	0	1	0
356	43	775	28	1	0	1	0
357	43	776	28	1	0	1	0
358	43	777	28	2	0	1	0
359	43	778	28	2	0	1	0
361	43	65	44	7	0	1	0
322	42	65	44	57	0	1	0
362	43	780	37	10	0	1	0
363	43	781	37	4	0	1	0
365	43	783	37	2	0	1	0
360	43	779	37	31	0	1	0
367	43	785	37	5	0	1	0
368	43	786	37	5	0	1	0
370	43	788	37	6	0	1	0
369	43	787	37	22	0	1	0
374	43	792	37	1	0	1	0
373	43	791	37	5	0	1	0
376	43	794	37	42	0	1	0
377	43	795	37	21	0	1	0
381	43	800	37	12	0	1	0
380	43	798	37	17	0	1	0
382	43	799	37	5	0	1	0
383	43	801	37	66	0	1	0
384	43	802	37	10	0	1	0
385	43	803	37	7	0	1	0
386	43	162	44	25	0	1	0
375	43	793	37	57	0	1	0
387	43	804	44	7	0	1	0
388	43	66	44	2	0	1	0
389	43	805	0	1	0	1	0
390	43	433	0	1	0	1	0
391	43	807	44	4	0	1	0
379	43	797	37	53	0	1	0
393	43	809	44	20	0	1	0
395	43	811	44	10	0	1	0
396	43	812	44	2	0	1	0
397	43	813	44	6	0	1	0
400	43	814	23	21	0	1	0
401	43	815	23	17	0	1	0
402	43	816	23	23	0	1	0
403	43	149	23	60	0	1	0
405	43	817	23	7	0	1	0
404	43	150	23	61	0	1	0
406	43	148	23	65	0	1	0
407	43	818	23	24	0	1	0
411	43	821	24	4	0	1	0
410	43	820	24	4	0	1	0
412	43	822	24	17	0	1	0
413	43	386	13	1	0	1	0
416	43	63	7	3	0	1	0
417	43	346	7	6	0	1	0
418	43	322	8	1	0	1	0
419	43	323	8	1	0	1	0
399	43	154	23	33	0	1	0
398	43	155	23	37	0	1	0
421	43	316	8	1	0	1	0
423	43	321	8	2	0	1	0
425	43	320	8	5	0	1	0
426	43	319	8	8	0	1	0
427	43	317	8	2	0	1	0
428	43	460	8	1	0	1	0
424	43	318	8	9	0	1	0
429	43	342	9	2	0	1	0
430	43	327	9	9	0	1	0
431	43	326	9	12	0	1	0
433	43	328	9	35	0	1	0
434	43	337	9	3	0	1	0
435	43	330	9	2	0	1	0
437	43	329	9	1	0	1	0
438	43	339	9	103	0	1	0
432	43	325	9	10	0	1	0
439	43	333	9	1	0	1	0
440	43	334	9	20	0	1	0
441	43	338	9	5	0	1	0
442	43	823	9	1	0	1	0
443	43	344	9	4	0	1	0
444	43	340	9	10	0	1	0
436	43	331	9	8	0	1	0
445	43	341	9	4	0	1	0
446	43	824	9	1	0	1	0
447	43	83	39	41	0	1	0
448	43	82	39	8	0	1	0
449	43	84	39	16	0	1	0
450	43	418	39	10	0	1	0
451	43	109	39	86	0	1	0
452	43	108	39	22	0	1	0
453	43	110	39	62	0	1	0
454	43	413	39	2	0	1	0
455	43	825	39	4	0	1	0
456	43	417	39	189	0	1	0
457	43	427	39	24	0	1	0
459	43	426	39	17	0	1	0
460	43	422	39	10	0	1	0
461	43	421	39	7	0	1	0
462	43	424	39	10	0	1	0
463	43	423	39	20	0	1	0
464	43	414	39	4	0	1	0
465	43	425	39	26	0	1	0
458	43	415	39	41	0	1	0
466	43	420	39	3	0	1	0
467	43	429	39	13	0	1	0
468	43	419	7	5	0	1	0
470	43	15	12	11	0	1	0
471	43	373	12	5	0	1	0
472	43	372	12	14	0	1	0
473	43	375	12	4	0	1	0
474	43	826	12	1	0	1	0
475	43	827	12	1	0	1	0
477	43	828	12	1	0	1	0
478	43	374	12	1	0	1	0
479	43	394	12	4	0	1	0
476	43	377	12	8	0	1	0
480	43	14	12	2	0	1	0
481	43	17	12	1	0	1	0
482	43	379	12	25	0	1	0
408	43	371	23	2	0	1	0
483	43	378	12	218	0	1	0
484	43	132	12	854	0	1	0
487	43	131	12	30	0	1	0
488	43	370	12	1	0	1	0
491	43	380	12	2	0	1	0
490	43	381	12	1	0	1	0
493	43	361	11	4	0	1	0
494	43	383	11	7	0	1	0
495	43	384	11	1	0	1	0
496	43	829	11	2	0	1	0
497	43	363	11	8	0	1	0
498	43	364	11	16	0	1	0
499	43	165	11	6	0	1	0
500	43	830	11	2	0	1	0
501	43	355	11	1	0	1	0
503	43	358	11	10	0	1	0
504	43	356	11	2	0	1	0
502	43	357	11	48	0	1	0
469	43	416	39	11	0	1	0
505	45	416	7	4	0	1	0
506	45	577	11	148	0	1	0
507	45	366	11	174	0	1	0
508	45	365	11	31	0	1	0
509	45	368	11	45	0	1	0
510	45	360	11	1	0	1	0
511	45	369	11	1	0	1	0
512	45	105	12	270	0	1	0
513	45	133	12	152	0	1	0
514	45	831	13	13	0	1	0
515	45	386	13	9	0	1	0
516	45	395	13	15	0	1	0
517	45	399	13	3	0	1	0
518	45	401	13	2	0	1	0
519	45	400	13	2	0	1	0
520	45	402	13	2	0	1	0
521	45	185	13	1	0	1	0
522	45	396	13	5	0	1	0
523	45	397	13	1	0	1	0
524	45	398	13	1	0	1	0
525	45	832	13	2	0	1	0
526	45	722	12	4	0	1	0
527	45	406	13	2	0	1	0
528	45	405	13	11	0	1	0
529	45	387	13	11	0	1	0
530	45	388	13	10	0	1	0
531	45	389	13	4	0	1	0
532	45	393	13	11	0	1	0
533	45	390	13	5	0	1	0
534	45	833	13	9	0	1	0
535	45	834	13	3	0	1	0
536	45	382	13	1	0	1	0
537	45	835	13	2	0	1	0
538	45	407	13	10	0	1	0
539	45	408	13	1	0	1	0
540	45	410	13	4	0	1	0
541	45	409	13	9	0	1	0
542	45	392	13	4	0	1	0
543	45	836	13	10	0	1	0
544	45	542	27	19	0	1	0
545	45	553	27	13	0	1	0
546	45	540	27	8	0	1	0
547	45	91	27	57	0	1	0
548	45	157	27	2	0	1	0
549	45	549	27	20	0	1	0
550	45	550	27	10	0	1	0
551	45	546	27	7	0	1	0
552	45	547	27	6	0	1	0
553	45	548	27	4	0	1	0
554	45	539	27	9	0	1	0
555	45	153	27	2	0	1	0
556	45	531	27	48	0	1	0
557	45	532	27	4	0	1	0
558	45	76	27	10	0	1	0
559	45	538	27	1	0	1	0
560	45	545	27	3	0	1	0
561	45	33	27	1	0	1	0
562	45	544	27	1	0	1	0
565	45	566	15	2	0	1	0
566	45	564	15	10	0	1	0
567	45	474	15	20	0	1	0
568	45	563	15	4	0	1	0
569	45	562	15	10	0	1	0
570	45	561	15	4	0	1	0
571	45	560	15	10	0	1	0
572	45	559	15	20	0	1	0
573	45	491	15	17	0	1	0
574	45	558	15	7	0	1	0
575	45	557	15	16	0	1	0
576	45	128	15	65	0	1	0
577	45	523	15	5	0	1	0
578	45	554	15	10	0	1	0
579	45	555	15	9	0	1	0
581	45	493	15	1	0	1	0
582	45	576	16	2	0	1	0
583	45	578	16	1	0	1	0
584	45	570	16	68	0	1	0
585	45	569	16	58	0	1	0
586	45	359	16	81	0	1	0
587	45	568	16	20	0	1	0
588	45	567	16	21	0	1	0
589	45	354	16	18	0	1	0
590	45	514	16	1	0	1	0
591	45	512	16	2	0	1	0
593	45	574	16	52	0	1	0
594	45	593	17	8	0	1	0
595	45	527	17	3	0	1	0
596	45	501	17	5	0	1	0
598	45	591	17	3	0	1	0
599	45	524	17	11	0	1	0
601	45	13	17	51	0	1	0
602	45	590	17	1	0	1	0
603	45	589	17	6	0	1	0
604	45	586	17	9	0	1	0
605	45	587	17	11	0	1	0
2	1	2	1	10	0.0200000000000000004	1	0
316	42	183	44	51	0	1	0
606	45	585	17	18	0	1	0
608	45	582	17	13	0	1	0
609	45	521	17	3	0	1	0
610	45	580	17	10	0	1	0
607	45	584	17	4	0	1	0
611	45	583	17	8	0	1	0
612	45	592	17	4	0	1	0
613	45	588	17	5	0	1	0
614	45	499	17	12	0	1	0
615	45	612	18	30	0	1	0
616	45	614	18	20	0	1	0
617	45	615	18	5	0	1	0
618	45	601	18	5	0	1	0
619	45	607	18	17	0	1	0
621	45	605	18	5	0	1	0
622	45	255	18	7	0	1	0
623	45	608	18	2	0	1	0
624	45	603	18	2	0	1	0
625	45	610	18	2	0	1	0
626	45	606	18	19	0	1	0
627	45	602	18	6	0	1	0
628	45	604	18	2	0	1	0
630	45	598	18	10	0	1	0
631	45	498	18	8	0	1	0
632	45	594	18	5	0	1	0
633	45	254	18	26	0	1	0
634	45	595	18	2	0	1	0
635	45	596	18	2	0	1	0
636	45	600	18	2	0	1	0
629	45	599	18	4	0	1	0
637	45	640	19	5	0	1	0
638	45	641	19	10	0	1	0
639	45	528	19	5	0	1	0
640	45	637	19	1	0	1	0
641	45	638	19	2	0	1	0
642	45	639	19	3	0	1	0
643	45	635	19	2	0	1	0
644	45	633	19	25	0	1	0
645	45	629	19	2	0	1	0
646	45	628	19	2	0	1	0
647	45	630	19	2	0	1	0
648	45	627	19	2	0	1	0
649	45	113	19	6	0	1	0
650	45	632	19	2	0	1	0
652	45	626	19	4	0	1	0
653	45	634	19	7	0	1	0
654	45	624	19	4	0	1	0
655	45	482	19	24	0	1	0
656	45	623	19	4	0	1	0
657	45	621	19	2	0	1	0
658	45	620	19	1	0	1	0
659	45	618	19	2	0	1	0
660	45	617	19	2	0	1	0
661	45	616	19	17	0	1	0
663	45	513	20	9	0	1	0
664	45	515	20	11	0	1	0
665	45	510	20	2	0	1	0
666	45	843	20	4	0	1	0
667	45	516	20	12	0	1	0
668	45	517	20	3	0	1	0
669	45	213	20	11	0	1	0
670	45	508	20	2	0	1	0
671	45	507	20	2	0	1	0
672	45	519	20	1	0	1	0
673	45	509	20	20	0	1	0
674	45	487	20	2	0	1	0
675	45	495	20	1	0	1	0
676	45	500	20	1	0	1	0
677	45	49	20	1	0	1	0
678	45	489	20	1	0	1	0
684	45	485	20	2	0	1	0
685	45	478	20	6	0	1	0
686	45	477	20	1	0	1	0
687	45	476	20	2	0	1	0
688	45	486	20	1	0	1	0
689	45	502	20	1	0	1	0
690	45	481	20	5	0	1	0
691	45	472	20	5	0	1	0
692	45	473	20	4	0	1	0
694	45	844	20	5	0	1	0
693	45	511	20	4	0	1	0
695	45	480	20	4	0	1	0
696	45	479	20	2	0	1	0
697	45	520	20	1	0	1	0
698	45	518	20	3	0	1	0
699	45	651	2	105	0	1	0
700	45	650	2	50	0	1	0
701	45	649	2	47	0	1	0
702	45	38	2	23	0	1	0
703	45	648	2	30	0	1	0
705	45	115	2	36	0	1	0
706	45	647	2	44	0	1	0
707	45	646	2	47	0	1	0
704	45	645	2	113	0	1	0
708	45	100	2	160	0	1	0
709	45	112	2	53	0	1	0
710	45	98	2	132	0	1	0
711	45	117	2	89	0	1	0
712	45	99	2	211	0	1	0
714	45	116	2	146	0	1	0
715	45	642	2	43	0	1	0
716	45	37	4	41	0	1	0
717	45	23	4	32	0	1	0
718	45	669	4	65	0	1	0
720	45	666	4	50	0	1	0
721	45	667	4	44	0	1	0
722	45	662	4	6	0	1	0
724	45	461	4	84	0	1	0
725	45	106	4	84	0	1	0
719	45	665	4	71	0	1	0
726	45	663	4	49	0	1	0
727	45	660	4	100	0	1	0
728	45	30	3	37	0	1	0
729	45	664	4	47	0	1	0
730	45	659	4	83	0	1	0
731	45	658	4	50	0	1	0
732	45	657	4	36	0	1	0
733	45	654	4	93	0	1	0
734	45	655	4	50	0	1	0
735	45	656	4	46	0	1	0
736	45	653	4	49	0	1	0
737	45	26	4	29	0	1	0
738	45	652	4	48	0	1	0
740	45	24	21	76	0	1	0
741	45	681	21	50	0	1	0
742	45	736	21	50	0	1	0
743	45	28	21	64	0	1	0
713	45	101	2	28	0	1	0
744	45	845	2	35	0	1	0
745	45	846	2	35	0	1	0
746	45	847	2	35	0	1	0
747	45	680	21	70	0	1	0
749	45	29	21	8	0	1	0
750	45	25	21	100	0	1	0
751	45	677	21	9	0	1	0
752	45	676	21	197	0	1	0
753	45	197	21	94	0	1	0
754	45	678	21	43	0	1	0
748	45	674	21	43	0	1	0
755	45	848	21	50	0	1	0
756	45	39	21	152	0	1	0
757	45	672	21	8	0	1	0
758	45	673	21	49	0	1	0
759	45	670	21	14	0	1	0
760	45	734	3	50	0	1	0
761	45	686	3	31	0	1	0
762	45	199	3	496	0	1	0
763	45	198	3	511	0	1	0
764	45	688	3	50	0	1	0
765	45	471	3	314	0	1	0
766	45	849	3	400	0	1	0
767	45	685	3	41	0	1	0
768	45	92	3	75	0	1	0
769	45	698	36	9	0	1	0
770	45	706	22	56	0	1	0
771	45	163	37	8	0	1	0
772	45	850	37	8	0	1	0
773	45	22	3	500	0	1	0
774	45	671	3	22	0	1	0
776	45	728	3	42	0	1	0
777	45	684	3	37	0	1	0
778	45	160	3	47	0	1	0
779	45	851	3	1	0	1	0
780	45	719	22	9	0	1	0
783	45	720	22	3	0	1	0
784	45	716	22	2	0	1	0
785	45	725	22	2	0	1	0
786	45	697	22	2	0	1	0
788	45	713	22	13	0	1	0
789	45	714	22	3	0	1	0
790	45	717	22	5	0	1	0
791	45	718	22	2	0	1	0
792	45	712	22	1	0	1	0
793	45	715	22	6	0	1	0
794	45	721	22	2	0	1	0
795	45	692	22	9	0	1	0
796	45	693	22	8	0	1	0
682	45	56	20	60	4.49000000000000021	2	0
797	45	852	22	1	0	1	0
787	45	690	22	8	0	1	0
799	45	691	22	10	0	1	0
800	45	858	12	583	0	1	0
801	45	235	35	3	0	1	0
803	42	669	0	1	0	1	0
804	46	669	4	110	0	1	0
805	45	860	21	65	0	1	0
806	46	860	21	110	0	1	0
807	47	847	2	50	0	1	0
808	49	864	45	3	0	1	0
809	49	861	45	3	0	1	0
810	49	862	45	3	0	1	0
812	49	863	0	1	0	1	0
811	49	865	45	3	0	1	0
813	49	866	45	3	0	1	0
815	49	867	45	3	0	1	0
816	49	173	45	1	0	1	0
817	49	174	45	16	0	1	0
818	49	868	45	3	0	1	0
819	49	176	45	2	0	1	0
820	45	869	46	11	0	1	0
821	45	870	46	5	0	1	0
822	45	871	46	4	0	1	0
823	45	872	46	10	0	1	0
824	45	873	46	14	0	1	0
826	45	277	5	3	0	1	0
827	43	277	5	4	0	1	0
798	45	694	22	3	0	1	0
828	45	164	46	12	0	1	0
829	45	875	46	4	0	1	0
830	50	858	12	3200	0.0237500000000000003	1	0
831	50	430	46	2	2.29999999999999982	1	0
832	50	876	0	1	0	1	0
833	50	21	2	700	0.100000000000000006	1	0
834	50	93	25	5	0.299999999999999989	1	0
835	50	153	27	100	0.599999999999999978	1	0
836	50	76	27	54	0.5	1	0
837	50	546	27	32	0.75	1	0
838	50	339	9	4	0.100000000000000006	1	0
839	50	13	17	25	2.29999999999999982	1	0
840	50	594	18	5	3.5	1	0
841	50	249	35	15	0.5	1	0
843	50	444	5	8	0.599999999999999978	1	0
845	50	551	35	4	0.5	1	0
847	50	208	11	39	0.599999999999999978	1	0
848	50	165	11	9	0.800000000000000044	1	0
849	50	15	12	8	1	1	0
850	50	162	44	16	0.0500000000000000028	1	0
854	51	837	47	3	1.67999999999999994	1	0
855	51	142	0	1	0	1	0
858	51	30	3	50	0.0200000000000000004	1	0
859	51	23	4	100	0.0599999999999999978	1	0
860	51	51	5	2	18.5799999999999983	1	0
861	51	207	3	5	1.62999999999999989	1	0
862	51	88	36	1	1.46999999999999997	1	0
863	51	2	47	50	0.0299999999999999989	1	0
857	51	95	47	50	0.0200000000000000004	1	0
856	51	442	47	4	0.900000000000000022	1	0
864	52	877	46	3	5.99000000000000021	1	0
865	51	142	47	50	0.0299999999999999989	1	0
866	45	878	46	25	0	1	0
867	45	879	46	218	0	1	0
868	50	439	47	8	0.200000000000000011	1	0
870	50	818	0	1	0	1	0
874	50	431	28	6	0.900000000000000022	1	0
875	50	451	47	8	5	1	0
873	50	459	31	10	0.0200000000000000004	1	0
876	50	90	47	100	0	1	0
877	50	533	31	14	0	1	0
851	50	859	47	6	0.5	1	0
878	50	446	47	1	0	1	0
869	50	683	21	5	5.5	1	0
880	53	15	12	8	0	1	0
881	53	197	21	50	0	1	0
882	53	199	3	50	0	1	0
883	53	22	3	50	0	1	0
884	53	153	27	16	0	1	0
885	53	198	3	100	0	1	0
886	53	76	27	19	0	1	0
887	53	13	17	55	0	1	0
888	53	90	47	100	0	1	0
889	53	21	2	341	0	1	0
890	50	458	48	6	0.0100000000000000002	1	0
891	50	536	48	6	0.0100000000000000002	1	0
892	50	534	48	3	0	1	0
893	50	535	48	9	0	1	0
894	50	435	48	3	0	1	0
895	50	432	48	5	0	1	0
896	50	467	48	23	0	1	0
897	50	120	17	4	0	1	0
898	50	537	48	53	0	1	0
842	50	493	15	7	0.5	1	0
600	45	493	15	6	0	1	0
563	45	493	15	2	0	1	0
69	1	9	20	1	3	1	0
844	50	9	20	10	3.5	1	0
683	45	9	20	3	0	1	0
739	45	444	5	3	0	1	0
214	38	249	35	1	0	1	0
212	38	249	35	42	0	1	0
580	45	9	20	3	0	1	0
240	38	228	10	1	0	1	0
251	38	220	10	1	0	1	0
249	38	220	10	1	0	1	0
190	38	243	36	3	0	1	0
825	45	81	46	5	0	2	0
662	45	81	46	1	0	2	0
909	56	186	46	40	0.800000000000000044	2	0
910	56	164	46	12	1.66999999999999993	2	0
911	56	8	32	15	4.54000000000000004	2	0
913	56	886	46	15	1.67999999999999994	2	0
903	56	203	46	4	6.19000000000000039	2	0
901	56	839	46	10	1.02000000000000002	2	0
906	56	840	46	5	1.16999999999999993	2	0
900	56	869	46	10	10.0800000000000001	2	0
908	56	883	46	10	1.37999999999999989	2	0
907	56	884	49	5	2.4700000000000002	2	0
905	56	882	49	10	4.70000000000000018	2	0
904	56	881	49	5	6.66999999999999993	2	0
232	38	265	35	15	0	1	0
217	38	253	35	3	0	1	0
246	38	279	10	3	0	1	0
231	38	265	35	2	0	1	0
222	38	258	35	10	0	1	0
248	38	279	10	9	0	1	0
846	50	552	10	4	0.5	1	0
196	38	552	10	1	0	1	0
852	50	838	47	12	2.79999999999999982	1	0
902	56	20	46	10	0.869999999999999996	2	0
914	38	147	8	70	0	1	0
915	38	448	8	5	0	1	0
916	38	484	8	1	0	1	0
917	38	887	33	20	0	1	0
918	38	888	33	40	0	1	0
919	57	454	37	25	0.790000000000000036	1	0
920	57	853	51	25	1.60000000000000009	1	0
921	57	455	0	50	1.18999999999999995	1	0
922	57	855	51	50	2.39000000000000012	1	0
923	57	456	51	5	2.37999999999999989	1	0
924	57	856	51	5	4.76999999999999957	1	0
926	58	889	51	20	0.141999999999999987	1	0
928	58	891	51	2	1.20999999999999996	1	0
929	58	892	0	2	21.8099999999999987	1	0
927	58	890	51	20	0.00549999999999999968	1	0
247	38	555	5	10	0	1	0
242	38	269	10	3	0	1	0
679	45	258	35	1	0	1	0
564	45	273	10	11	0	1	0
226	38	259	35	14	0	1	0
802	45	247	35	1	0	1	0
210	38	247	35	3	0	1	0
234	38	234	35	25	0	1	0
620	45	558	15	14	0	1	0
96	1	213	20	10	1	1	0
936	60	896	0	1	3.20000000000000018	1	0
937	60	897	0	1	3.20000000000000018	1	0
938	60	898	0	6	8.90000000000000036	1	0
939	61	371	23	1	2.5	1	0
940	61	435	48	3	0.400000000000000022	1	0
941	61	899	51	5	0.200000000000000011	1	0
942	61	900	51	5	0.200000000000000011	1	0
947	62	917	0	50	0.800000000000000044	1	0
945	61	902	0	3	1	1	0
943	61	901	1	30	0.200000000000000011	1	0
944	61	403	16	40	0.200000000000000011	1	0
946	40	903	48	1	0	1	0
949	63	0	0	1	0	1	0
950	63	0	0	1	0	1	0
951	63	0	0	1	0	1	0
952	63	0	0	1	0	1	0
953	63	918	0	5	0.800000000000000044	1	0
954	63	577	0	100	0.0693000000000000005	1	0
955	63	162	0	100	0.0299999999999999989	1	0
956	63	779	0	100	0.0299999999999999989	1	0
957	63	919	0	4	1.90999999999999992	1	0
958	63	920	0	1	3.5	1	0
959	64	922	0	1	20.870000000000001	1	0
960	64	921	0	1	3.89000000000000012	1	0
961	65	923	0	2	0.349999999999999978	1	0
962	65	924	0	6	1.19999999999999996	1	0
964	43	925	0	1	0	1	0
965	66	926	0	1	15	1	0
966	62	179	0	1	60.1000000000000014	1	0
967	65	927	0	1	7	1	0
968	38	701	0	11	0	1	0
969	68	92	0	200	0.149999999999999994	1	0
970	68	371	0	5	3.5	1	0
971	71	186	0	250	0.630000000000000004	2	0
972	71	164	0	35	2.27720000000000011	2	0
973	71	886	0	25	1.37999999999999989	2	0
975	71	883	0	10	1.35000000000000009	2	0
976	71	869	0	35	8.59520000000000017	2	0
977	71	22	0	100	0.0442000000000000032	2	0
979	71	881	0	8	6.83999999999999986	2	0
978	71	80	0	10	9.64000000000000057	2	0
980	71	873	0	25	2.29999999999999982	2	0
974	71	839	0	35	0.75	2	0
981	72	51	0	2	18.5799999999999983	1	5
781	45	723	22	60	0	1	0
782	45	724	22	10	0	1	0
982	38	943	0	1	0	1	0
983	45	944	0	10	0	1	0
984	45	945	0	53	0	1	0
414	43	428	0	17	0	1	0
999	76	412	0	5	1.1100000000000001	1	0
985	45	447	0	12	0	1	0
1000	76	159	0	25	2.75999999999999979	1	0
986	45	946	0	10	0	1	0
987	69	937	0	19	0	1	0
988	69	403	0	200	0	1	0
989	69	399	0	3	0	1	0
990	69	395	0	17	0	1	0
991	69	938	0	2	0	1	0
1001	76	144	0	12	0.660000000000000031	1	0
993	75	33	0	11	1.67999999999999994	1	0
992	75	947	0	4	0.419999999999999984	1	0
994	75	466	0	3	0.530000000000000027	1	0
995	75	948	0	1	2.10999999999999988	1	0
1002	76	145	0	12	0.640000000000000013	1	0
36	1	27	1	50	0.0200000000000000004	1	0
996	45	27	0	200	0	1	0
1003	76	643	0	50	0.0200000000000000004	1	0
366	43	784	37	34	0	1	0
997	45	949	0	50	0	1	0
1004	45	644	0	50	0	1	0
998	45	950	0	50	0	1	0
165	33	178	1	10	2.66999999999999993	1	2
651	45	183	19	19	0	1	0
1005	77	953	0	10	1.83000000000000007	1	13.2699999999999996
1008	78	648	0	100	0.0200000000000000004	1	2.5
1006	78	688	0	100	0.0200000000000000004	1	2.5
1007	78	95	0	100	0.0200000000000000004	1	2.5
1009	79	173	0	6	0.25	1	0
1010	79	862	0	4	0.149999999999999994	1	0
1011	79	863	0	5	0.149999999999999994	1	0
1012	79	956	0	5	0.200000000000000011	1	0
1013	79	957	0	3	0.299999999999999989	1	0
1014	80	948	0	5	0	1	0
1015	80	466	0	5	0	1	0
1016	82	958	0	10	3.5299999999999998	1	15
1017	83	962	0	1	1.26000000000000001	1	0
1018	83	960	0	1	1.26000000000000001	1	0
1019	83	959	0	1	1.26000000000000001	1	0
1020	83	961	0	1	1.26000000000000001	1	0
1021	83	963	0	1	19.2600000000000016	1	0
1022	83	964	0	2	6.58000000000000007	1	0
1023	84	766	0	50	0	1	0
1024	84	773	0	1	0	1	0
1025	84	966	0	12	0	1	0
1026	84	967	0	4	0	1	0
1027	84	9	0	1	0	1	0
1029	86	972	0	50	0.0400000000000000008	1	2
1031	86	931	0	50	0.0599999999999999978	1	2
1032	86	968	0	50	0.0400000000000000008	1	2
1033	86	969	0	50	0.0400000000000000008	1	2
1034	86	970	0	50	0.0299999999999999989	1	2
1035	86	971	0	50	0.0400000000000000008	1	2
1028	86	88	0	20	1.21999999999999997	1	5
1030	86	934	0	50	0.0599999999999999978	1	2
1036	89	460	0	4	4	1	0
1037	89	974	0	4	2	1	0
1039	84	976	0	1	0	1	0
1040	40	535	0	107	0	1	0
1041	40	536	0	149	0	1	0
1042	40	537	0	45	0	1	0
1043	40	467	0	24	0	1	0
1044	40	534	0	72	0	1	0
1045	40	458	0	174	0	1	0
1047	84	977	0	4	0	1	0
1046	84	978	0	95	0	1	0
1049	84	981	0	96	0	1	0
1050	84	146	0	95	0	1	0
1051	84	989	0	5	0	1	0
1052	84	985	0	50	0	1	0
1053	84	990	0	9	0	1	0
1054	84	991	0	9	0	1	0
1055	84	992	0	4	0	1	0
1056	84	979	0	5	0	1	0
1057	84	986	0	17	0	1	0
1058	84	993	0	7	0	1	0
1059	84	987	0	11	0	1	0
1060	84	988	0	100	0	1	0
1061	84	980	0	61	0	1	0
1062	84	983	0	95	0	1	0
1063	84	984	0	51	0	1	0
1064	84	994	0	8	0	1	0
1065	84	246	0	4	0	1	0
1066	84	223	0	7	0	1	0
1067	84	243	0	9	0	1	0
1068	91	700	0	15	0	1	0
1069	91	695	0	2	0	1	0
1070	91	699	0	2	0	1	0
1071	91	708	0	1	0	1	0
1074	91	696	0	1	0	1	0
1075	91	711	0	2	0	1	0
1072	91	698	0	0	0	1	0
1073	91	710	0	0	0	1	0
1076	91	702	0	44	0	1	0
1077	91	704	0	5	0	1	0
1078	91	102	0	204	0	1	0
1079	91	705	0	3	0	1	0
1080	91	918	0	4	0	1	0
1081	91	703	0	1	0	1	0
1082	91	709	0	11	0	1	0
1084	91	707	0	9	0	1	0
1085	92	96	0	213	0	1	0
1086	92	1004	0	173	0	1	0
1087	92	1012	0	24	0	1	0
1088	92	1006	0	133	0	1	0
1089	92	1014	0	50	0	1	0
1090	92	1007	0	105	0	1	0
1091	92	1008	0	94	0	1	0
1092	92	458	0	174	0	1	0
1093	92	534	0	72	0	1	0
1094	92	467	0	24	0	1	0
1095	92	1009	0	18	0	1	0
1096	92	1015	0	122	0	1	0
1097	92	1016	0	273	0	1	0
1098	92	1010	0	107	0	1	0
1099	92	1011	0	172	0	1	0
1100	92	1017	0	9	0	1	0
1101	92	536	0	149	0	1	0
1102	101	72	0	142	0	1	0
1103	101	1026	0	7	0	1	0
1104	101	1018	0	6	0	1	0
1105	101	205	0	90	0	1	0
1106	101	1003	0	279	0	1	0
1107	101	1016	0	60	0	1	0
1109	101	1020	0	12	0	1	0
1110	101	982	0	75	0	1	0
1111	101	1027	0	100	0	1	0
1112	101	979	0	82	0	1	0
1048	84	982	0	100	0	1	0
1113	101	1025	0	176	0	1	0
1114	101	1021	0	170	0	1	0
1115	101	533	0	200	0	1	0
1116	101	1022	0	68	0	1	0
1117	101	73	0	34	0	1	0
1118	101	1023	0	188	0	1	0
1119	101	1024	0	91	0	1	0
1120	93	1001	0	106	0	1	0
1121	93	161	0	84	0	1	0
1122	93	1002	0	98	0	1	0
1123	93	71	0	148	0	1	0
1124	93	70	0	28	0	1	0
1125	93	1003	0	7	0	1	0
1126	93	1004	0	19	0	1	0
1127	93	69	0	679	0	1	0
1128	93	995	0	100	0	1	0
1129	93	459	0	38	0	1	0
1130	93	996	0	173	0	1	0
1131	93	936	0	83	0	1	0
1132	93	997	0	144	0	1	0
1133	93	998	0	97	0	1	0
1134	93	999	0	99	0	1	0
1135	93	1000	0	100	0	1	0
1136	93	1005	0	15	0	1	0
1137	101	1019	0	73	0	1	0
422	43	79	8	43	6	1	0
62	1	78	1	45	5	1	0
1138	93	19	0	5	0	1	0
16	4	875	1	1	4.04999999999999982	2	0
1143	93	955	0	100	0	1	0
1139	1	339	0	1	0	1	0
1147	100	765	0	2	0	1	0
1140	40	1066	0	1	0	1	0
1144	93	1067	0	1	0	1	0
1141	93	1065	0	1	0	1	0
1142	100	1056	0	1	0	1	0
1145	93	1068	0	1	0	1	0
1157	104	1087	0	15	0.969999999999999973	1	0
1146	1	756	0	1	0	1	0
1158	104	1088	0	18	0.100000000000000006	1	0
1148	104	1074	0	3	9.38000000000000078	1	0
1151	104	1077	0	2	2.54000000000000004	1	0
1152	104	1084	0	1	14.5800000000000001	1	0
1153	105	1073	0	148	1.29000000000000004	1	0
1154	105	1072	0	89	1.29000000000000004	1	0
1150	104	1075	0	54	0.0200000000000000004	1	0
1149	104	1076	0	29	0.0599999999999999978	1	0
1155	106	1085	0	10	3.39999999999999991	1	0
1156	35	170	0	1	1.30000000000000004	1	0
1159	93	1120	0	5	6.59999999999999964	2	30
73	6	86	1	40	6	1	0
1160	6	169	0	81	0	1	0
1161	6	1156	0	7	0	1	0
1162	6	1138	0	8	0	1	0
1163	6	1143	0	10	0	1	0
1164	6	1154	0	6	0	1	0
1165	6	1078	0	34	0	1	0
1166	6	1141	0	16	0	1	0
1167	6	1140	0	16	0	1	0
1168	6	1139	0	9	0	1	0
1169	6	1155	0	7	0	1	0
1170	6	1142	0	43	0	1	0
1171	93	1164	0	1	0	1	0
1172	93	910	0	1	0	1	0
1173	93	912	0	1	0	1	0
1174	93	911	0	1	0	1	0
1176	93	915	0	1	0	1	0
1177	93	182	0	1	0	1	0
1178	93	904	0	1	0	1	0
1179	93	908	0	1	0	1	0
1180	93	906	0	1	0	1	0
1181	93	909	0	1	0	1	0
1182	93	907	0	1	0	1	0
1184	93	913	0	2	0	1	0
1183	93	914	0	2	0	1	0
1175	93	916	0	2	0	1	0
1185	93	1165	0	1	0	1	0
1187	93	905	0	1	0	1	0
1188	93	1145	0	135	0	1	0
1189	93	1146	0	91	0	1	0
1201	93	1174	0	11	0	1	0
1190	93	1167	0	92	0	1	0
1191	93	1144	0	333	0	1	0
1192	93	571	0	207	0	1	0
1193	93	572	0	155	0	1	0
1195	93	1168	0	120	0	1	0
1196	93	1169	0	125	0	1	0
1197	93	1147	0	100	0	1	0
1198	93	1171	0	43	0	1	0
1199	93	1172	0	7	0	1	0
1200	93	1173	0	5	0	1	0
1202	93	1175	0	7	0	1	0
1203	93	1176	0	10	0	1	0
1204	93	1177	0	3	0	1	0
1205	93	1178	0	4	0	1	0
1206	93	1030	0	1	0	1	0
1207	93	1029	0	1	0	1	0
1208	93	1028	0	1	0	1	0
1209	104	1089	0	20	0	1	0
1210	104	1151	0	20	0	1	0
1211	93	1179	0	30	0.0800000000000000017	1	0
1212	93	1180	0	53	0	1	0
1213	93	1181	0	52	0	1	0
1214	93	1182	0	37	0	1	0
1215	93	1183	0	21	0	1	0
1216	93	1184	0	5	0	1	0
1217	93	1185	0	10	0	1	0
1218	93	1186	0	20	0	1	0
1219	93	1187	0	11	0	1	0
1220	93	1188	0	20	0	1	0
1221	93	1189	0	3	0	1	0
1222	93	1190	0	3	0	1	0
1223	93	1191	0	3	0	1	0
1224	93	1192	0	16	0	1	0
1225	93	1193	0	36	0	1	0
1226	93	1194	0	40	0	1	0
1227	93	1195	0	15	0	1	0
1228	93	1196	0	4	0	1	0
1229	101	1197	0	6	0	1	0
1230	93	1198	0	5	0	1	0
1231	93	1199	0	15	0	1	0
1232	93	1200	0	15	0	1	0
1194	93	1149	0	55	0	1	0
1233	93	1201	0	1	0	1	0
1234	93	1202	0	1	0	1	0
1235	93	1203	0	1	0	1	0
1186	93	1166	0	1	0	1	0
1244	107	170	0	10	0.930000000000000049	1	0
1236	93	1204	0	1	0	1	0
1250	109	1063	0	2	83.2800000000000011	1	0
1237	93	1205	0	1	0	1	0
1245	93	8	0	8	0	1	0
1238	93	1206	0	1	0	1	0
1304	113	1087	0	15	0	1	0
1239	93	1207	0	1	0	1	0
1246	93	359	0	92	0	1	0
1240	93	1208	0	1	0	1	0
1247	108	775	0	1	13.6500000000000004	1	0
1241	93	1209	0	1	0	1	0
1252	110	339	0	73	0.100000000000000006	1	0
1242	93	1210	0	1	0	1	0
1248	93	1075	0	19	0	1	0
1243	93	1211	0	1	0	1	0
1253	110	326	0	10	0.149999999999999994	1	0
1249	93	1212	0	10	0	1	0
1254	110	297	0	33	0.440000000000000002	1	0
1255	110	93	0	18	0.299999999999999989	1	0
1256	110	153	0	30	0.699999999999999956	1	0
1257	110	539	0	4	3	1	0
1258	110	357	0	17	0.400000000000000022	1	0
1259	110	14	0	5	1.19999999999999996	1	0
1260	110	1213	0	10	0.25	1	0
1261	110	793	0	5	0.200000000000000011	1	0
1262	110	466	0	4	0.149999999999999994	1	0
1263	110	84	0	44	0.149999999999999994	1	0
1264	110	82	0	22	0.149999999999999994	1	0
1265	110	83	0	10	0.149999999999999994	1	0
1266	110	1123	0	11	0.149999999999999994	1	0
1267	110	537	0	50	0.149999999999999994	1	0
1268	110	1050	0	10	0.149999999999999994	1	0
1269	110	107	0	10	0.149999999999999994	1	0
1270	110	695	0	10	1.5	1	0
1271	110	948	0	37	1.19999999999999996	1	0
1272	110	185	0	5	0.299999999999999989	1	0
1273	110	397	0	5	0.900000000000000022	1	0
1274	111	1121	0	50	0.0299999999999999989	1	0
1275	111	820	0	1	17.0199999999999996	1	0
1276	111	28	0	100	0.0400000000000000008	1	0
1277	111	26	0	50	0.0200000000000000004	1	0
1278	111	1134	0	50	0.0200000000000000004	1	0
1279	111	722	0	1	3.89999999999999991	1	0
1280	111	821	0	1	8.02999999999999936	1	0
1281	111	97	0	10	0.130000000000000004	1	0
1282	111	51	0	6	14.5899999999999999	1	0
1283	111	50	0	5	14.6300000000000008	1	0
1284	111	1128	0	50	0.0200000000000000004	1	0
1285	111	1127	0	50	0.0200000000000000004	1	0
1286	111	100	0	50	0.0200000000000000004	1	0
1287	111	29	0	50	0.0200000000000000004	1	0
1288	111	114	0	50	0.0200000000000000004	1	0
1289	111	1108	0	5	2.54999999999999982	1	0
1290	111	23	0	50	0.0599999999999999978	1	0
1291	111	1131	0	50	0.0700000000000000067	1	0
1292	111	1126	0	12	1.58000000000000007	1	0
1293	111	38	0	150	0.0899999999999999967	1	0
1294	111	1214	0	3	5.58000000000000007	1	0
1295	112	1090	0	24	15.6699999999999999	1	0
1296	112	1091	0	2	17.2800000000000011	1	0
1297	112	1099	0	2	5.01999999999999957	1	0
1298	112	1095	0	28	2.08000000000000007	1	0
1299	112	1093	0	58	1.3899999999999999	1	0
1300	112	208	0	10	0.92000000000000004	1	0
1301	112	165	0	10	1.37999999999999989	1	0
1302	112	135	0	22	1.54000000000000004	1	0
1303	112	1115	0	12	3.39999999999999991	1	0
1251	110	315	0	50	0.299999999999999989	1	0
1305	113	1089	0	7	0	1	0
1306	113	1074	0	1	0	1	0
1307	114	297	0	10	0.890000000000000013	1	0
1308	114	1215	0	20	3.68000000000000016	1	0
1309	115	113	0	13	1.02000000000000002	1	0
1310	115	88	0	2	0.979999999999999982	1	0
1311	115	46	0	8	2.06000000000000005	1	0
1317	116	1221	0	9	0	1	0
1316	116	1220	0	9	0	1	0
1319	116	1223	0	7	0	1	0
1312	116	1216	0	35	0	1	0
1314	116	1218	0	29	0	1	0
1313	116	1217	0	40	0	1	0
1315	116	1219	0	24	0	1	0
1318	116	1222	0	19	0	1	0
1325	114	1225	0	1	0	1	0
1320	116	1224	0	8	0	1	0
1328	122	386	0	12	1.92999999999999994	1	0
1322	117	1100	0	8	1.72999999999999998	2	0
1321	117	1101	0	12	1.12999999999999989	2	0
1323	118	885	0	2	1.5	1	0
1324	119	976	0	10	7.13999999999999968	1	0
1329	123	1105	0	15	3.14000000000000012	1	0
1326	121	1225	0	6	0	1	0
1330	123	1133	0	10	3.22999999999999998	1	0
1327	121	386	0	10	0	1	0
1331	123	113	0	8	1.08000000000000007	1	0
1332	123	1104	0	5	2.54999999999999982	1	0
1333	123	1106	0	10	3.18999999999999995	1	0
1334	123	1129	0	10	3.16000000000000014	1	0
1335	123	1132	0	10	2.56999999999999984	1	0
1336	123	1107	0	5	3.16000000000000014	1	0
1337	123	1161	0	15	3.16000000000000014	1	0
1338	123	35	0	10	2.58000000000000007	1	0
1339	123	662	0	15	2.56000000000000005	1	0
1340	123	1119	0	40	3.2200000000000002	1	0
1341	123	1160	0	15	3.16999999999999993	1	0
1342	123	1109	0	5	3.16999999999999993	1	0
1343	123	1122	0	5	0.209999999999999992	1	0
1344	123	1227	0	2	48.8100000000000023	1	0
1345	123	88	0	9	0.979999999999999982	1	0
1346	125	46	0	40	2.06000000000000005	1	0
1347	125	1214	0	2	5.58000000000000007	1	0
1348	125	1228	0	10	4.70999999999999996	1	0
1349	126	792	0	4	0.440000000000000002	1	0
1350	126	1230	0	5	0.530000000000000027	1	0
1351	126	1229	0	5	2.10999999999999988	1	0
1352	127	1232	0	10	0.100000000000000006	1	0
1353	127	1231	0	30	0.100000000000000006	1	0
1354	128	863	0	15	0.149999999999999994	1	0
1355	128	956	0	25	0.200000000000000011	1	0
1359	132	297	0	30	0.890000000000000013	1	0
1356	101	1233	0	2	0	1	0
1360	133	24	0	100	0.0200000000000000004	1	0
1357	101	1234	0	6	0	1	0
1361	133	1236	0	100	0.0299999999999999989	1	0
1358	100	1235	0	4	0	1	0
1362	133	644	0	100	0.0299999999999999989	1	0
1363	133	1126	0	5	1.46999999999999997	1	0
1364	133	1127	0	100	0.0200000000000000004	1	0
1365	132	1126	0	1	0	1	0
1383	136	947	0	4	0.440000000000000002	1	0
1366	134	1237	0	100	0.0200000000000000004	1	5
1384	136	1215	0	8	3.68999999999999995	1	0
1385	137	1245	0	2	6.58000000000000007	1	0
1368	130	1238	0	100	0.0200000000000000004	1	5
1386	137	1246	0	1	5.63999999999999968	1	0
1387	137	976	0	14	6.33000000000000007	1	0
1388	138	1242	0	7	1.94999999999999996	1	0
1369	130	1239	0	100	0.0200000000000000004	1	5
1370	130	1240	0	100	0.0200000000000000004	1	5
1391	140	577	0	100	0.800000000000000044	1	0
1372	130	1237	0	100	0.0200000000000000004	1	5
1373	130	657	0	100	0.0200000000000000004	1	5
1374	130	142	0	100	0.0200000000000000004	1	5
1375	130	688	0	100	0.0200000000000000004	1	5
1376	130	95	0	100	0.0200000000000000004	1	5
1377	130	728	0	100	0.0200000000000000004	1	5
1378	130	26	0	100	0.0200000000000000004	1	5
1371	130	1241	0	100	0.0299999999999999989	1	5
1379	131	1242	0	5	3.68999999999999995	1	5
1380	135	919	0	25	2	1	5
1381	135	947	0	8	0.440000000000000002	1	5
1392	140	722	0	5	0.839999999999999969	1	0
1382	116	661	0	30	0	1	0
1394	93	597	0	10	0	1	0
378	43	850	37	8	0	1	0
\.


--
-- Data for Name: relassemblies; Type: TABLE DATA; Schema: public; Owner: jrm
--

COPY public.relassemblies (id, assembly_id, inner_assembly_id, component_id, quant) FROM stdin;
1	3	0	9	1
2	3	0	5	1
3	3	0	12	1
4	8	0	70	3
6	3	0	15	1
7	3	0	14	1
8	3	0	20	1
9	3	0	18	1
15	7	0	33	2
25	7	0	44	1
30	7	0	57	2
31	7	0	41	3
35	7	0	8	1
36	7	0	52	1
37	7	0	20	1
39	7	0	18	1
41	7	0	58	1
42	7	0	60	1
43	8	0	62	7
44	8	0	63	2
45	8	0	65	2
46	8	0	66	2
47	8	0	74	1
48	8	0	69	2
49	8	0	67	5
50	8	0	76	4
51	8	0	73	2
52	8	0	75	2
53	8	0	13	2
54	8	0	77	2
55	8	0	80	1
56	8	0	81	1
57	8	0	83	2
58	8	0	84	1
59	8	0	9	1
60	8	0	85	1
61	8	0	86	1
64	9	0	18	1
65	9	0	5	1
67	9	0	12	1
87	2	0	12	1
91	2	0	18	1
92	2	0	5	1
98	9	0	101	2
106	10	0	104	1
108	9	0	105	20
129	10	0	12	1
132	10	0	5	1
133	10	0	18	1
142	10	0	67	2
148	10	0	101	2
154	2	0	101	2
160	8	0	146	2
163	8	0	147	9
167	8	0	150	1
175	2	0	123	1
177	8	0	149	3
179	8	0	148	2
183	8	0	71	2
188	8	0	105	1
190	8	0	132	1
191	8	0	151	1
194	8	0	152	4
198	8	0	153	2
199	8	0	155	1
200	8	0	154	1
201	2	0	105	32
203	2	0	134	1
208	13	0	95	1
209	13	0	44	1
210	13	0	56	1
211	13	0	18	1
212	13	0	8	1
213	13	0	138	1
215	13	0	93	2
216	13	0	159	2
217	13	0	17	1
218	13	0	38	1
219	13	0	42	1
220	13	0	51	1
221	13	0	165	1
222	13	0	169	1
223	13	0	170	1
224	14	0	95	7
227	14	0	99	5
228	14	0	100	5
231	14	0	101	6
237	14	0	13	5
238	14	0	77	8
244	14	0	5	1
248	14	0	18	1
256	15	0	21	12
257	15	0	22	2
258	15	0	23	3
259	15	0	24	2
260	15	0	33	2
261	15	0	25	3
262	15	0	26	2
263	15	0	27	2
264	15	0	28	4
265	15	0	29	1
266	15	0	30	1
268	15	0	54	1
269	15	0	56	1
270	15	0	44	1
271	15	0	38	4
272	15	0	39	2
273	15	0	40	2
274	15	0	57	2
275	15	0	41	3
276	15	0	47	1
277	15	0	46	2
278	15	0	8	1
279	15	0	52	1
280	15	0	20	1
281	15	0	53	1
282	15	0	18	1
284	15	0	49	2
285	15	0	58	1
286	15	0	60	1
291	16	0	23	3
292	16	0	24	2
293	16	0	25	3
294	16	0	26	2
295	16	0	27	2
296	16	0	28	4
297	16	0	29	1
298	16	0	30	1
300	16	0	56	1
301	16	0	38	4
302	16	0	39	2
303	16	0	40	2
304	16	0	57	2
305	16	0	41	3
306	16	0	50	1
307	16	0	49	2
308	16	0	58	1
309	16	0	60	1
312	16	0	21	6
313	16	0	33	1
315	7	17	0	1
317	19	0	196	3
318	19	0	9	3
319	19	0	13	2
320	1	3	0	1
321	13	0	76	4
322	13	0	197	2
323	13	0	144	1
324	13	0	145	1
325	13	0	207	1
326	13	0	208	1
327	5	13	0	1
328	11	0	23	2
329	11	0	95	1
330	11	0	44	1
331	11	0	56	1
332	11	0	18	1
333	11	0	8	1
334	11	0	138	1
336	11	0	139	1
337	11	0	24	3
338	11	0	93	2
339	11	0	98	1
340	19	1	0	2
341	19	12	0	3
342	11	0	25	1
343	11	0	159	2
344	1	0	181	1
345	11	0	162	1
346	11	0	17	1
347	11	0	29	1
348	11	0	101	2
349	11	0	38	1
350	11	0	41	2
351	11	0	42	1
352	11	0	51	1
353	11	0	165	1
354	11	0	65	2
355	11	0	66	2
356	11	0	19	1
357	11	0	166	1
358	11	0	168	1
359	11	0	167	1
360	11	0	169	1
361	11	0	170	1
362	11	0	174	3
363	11	0	176	1
364	11	0	105	7
365	11	0	91	2
367	11	0	92	1
368	11	0	197	2
369	11	0	205	3
370	11	0	206	3
371	11	0	144	1
372	11	0	145	1
373	11	0	207	1
374	11	0	164	1
375	11	0	208	1
376	11	0	161	2
377	11	0	62	9
378	11	0	153	1
381	18	0	209	3
382	18	0	176	1
385	12	0	159	20
386	12	0	430	1
387	20	0	95	5
388	20	0	24	1
389	20	0	2	1
390	20	0	99	6
391	20	0	117	4
392	20	0	23	3
393	20	0	94	1
394	20	0	93	2
395	20	0	315	1
396	20	0	432	1
397	20	0	431	2
398	20	0	26	3
399	20	0	163	1
400	20	0	434	1
401	20	0	351	1
402	20	0	100	5
403	20	0	101	2
404	20	0	13	4
405	20	0	67	2
406	20	0	435	1
407	20	0	92	4
408	20	0	439	2
409	20	0	433	2
410	20	0	440	4
411	20	0	442	1
412	20	0	444	1
413	20	0	38	2
414	20	0	445	1
415	20	0	164	1
416	20	0	436	8
417	20	0	132	3
418	20	0	448	1
419	20	0	451	2
420	20	0	455	2
421	20	0	456	1
422	20	0	21	12
423	20	0	153	5
424	20	0	62	1
425	20	0	458	2
426	20	0	459	2
427	21	0	23	5
428	21	0	95	2
429	21	0	21	3
430	21	0	153	2
431	21	0	99	1
432	21	0	26	1
433	21	0	92	3
434	21	0	112	6
435	21	0	29	2
436	21	0	142	11
437	21	0	460	1
438	21	0	114	1
440	21	0	207	1
441	21	0	38	2
442	21	0	20	1
443	21	0	461	2
444	24	0	21	8
445	24	0	24	2
446	24	0	25	1
447	24	0	433	2
448	24	0	30	2
449	24	0	8	1
450	24	0	411	2
451	24	0	19	1
452	24	0	18	1
453	24	0	52	1
454	24	0	464	2
455	24	0	208	1
456	24	0	165	1
457	24	0	56	1
458	24	0	44	1
459	24	0	465	1
460	24	0	41	4
461	24	0	466	2
462	24	0	33	2
463	24	0	17	1
464	24	0	197	2
465	24	0	467	3
466	24	0	95	3
467	24	0	468	1
468	24	0	93	3
469	24	0	144	1
470	24	0	145	1
471	24	0	470	2
472	24	0	471	1
473	24	0	132	3
474	20	0	65	2
475	20	0	66	2
476	24	0	159	2
477	25	0	23	2
478	25	0	95	1
479	25	0	44	1
480	25	0	56	1
481	25	0	18	1
482	25	0	8	1
483	25	0	24	3
484	25	0	25	1
485	25	0	159	2
486	25	0	162	1
487	25	0	17	1
488	25	0	29	1
489	25	0	141	1
490	25	0	38	1
491	25	0	41	2
492	25	0	42	1
493	25	0	51	1
494	25	0	165	1
495	25	0	19	1
496	25	0	169	1
497	25	0	204	1
498	25	0	76	4
499	25	0	205	3
500	25	0	206	3
501	25	0	144	1
502	25	0	145	1
503	25	0	207	1
504	25	0	208	1
505	25	0	9	1
506	25	0	161	2
507	25	26	0	1
509	27	0	44	1
510	27	0	56	1
511	27	0	18	1
512	27	0	8	1
513	27	0	93	2
514	27	0	25	1
515	27	0	159	2
516	27	0	17	1
517	27	0	51	1
518	27	0	165	1
519	27	0	19	1
520	27	0	169	1
521	27	0	208	1
522	27	26	0	1
523	27	0	21	11
524	27	0	153	2
525	27	0	95	2
526	27	0	467	2
527	27	0	24	2
528	27	0	98	1
529	27	0	433	1
530	27	0	197	2
531	27	0	30	2
532	27	0	114	1
533	27	0	206	5
534	27	0	144	1
535	27	0	145	1
536	27	0	101	2
537	27	0	164	1
538	27	0	57	2
439	21	0	412	1
541	27	0	471	1
542	27	0	484	1
543	27	0	92	2
544	27	0	147	3
545	28	0	44	1
546	28	0	56	1
547	28	0	18	1
548	28	0	8	1
549	28	0	93	2
551	28	0	159	2
552	28	0	17	1
553	28	0	51	1
554	28	0	165	1
556	28	0	169	1
557	28	0	208	1
559	28	0	21	11
561	28	0	467	2
562	28	0	24	2
563	28	0	433	1
564	28	0	197	2
565	28	0	30	2
566	28	0	114	1
567	28	0	206	5
568	28	0	144	1
569	28	0	145	1
570	28	0	57	2
571	28	0	471	1
572	28	0	484	1
574	28	0	92	1
575	28	0	147	2
576	28	0	153	3
577	28	0	76	4
578	28	0	38	1
579	27	0	38	1
580	28	0	214	1
581	29	0	533	3
582	29	0	459	1
583	29	0	534	1
584	29	0	537	1
585	29	0	535	2
586	29	0	536	1
587	29	0	371	1
588	29	0	67	4
589	29	0	551	1
590	29	0	552	1
591	29	0	208	2
592	29	0	249	1
593	29	0	165	1
594	29	0	289	1
595	20	0	120	1
596	20	0	698	1
597	29	0	417	4
598	21	0	471	1
599	20	0	607	2
600	20	0	371	1
601	12	0	94	1
602	12	0	432	1
603	12	0	120	1
604	12	0	647	1
605	12	0	439	2
606	12	0	442	1
607	12	0	142	11
608	12	0	461	2
609	12	0	2	1
610	13	18	0	1
612	13	0	23	3
613	13	0	467	2
614	13	0	21	11
615	13	0	24	2
616	13	0	153	4
617	13	0	433	1
618	13	0	685	1
619	13	0	30	2
620	13	0	114	1
621	13	0	33	3
622	13	0	648	2
623	13	0	839	1
624	13	0	41	1
625	13	0	213	1
626	20	0	98	1
627	20	0	647	1
628	20	0	643	1
629	20	0	838	3
630	20	0	779	2
634	15	0	153	5
635	16	0	153	3
638	31	0	2	1
639	31	0	117	4
640	31	0	23	3
641	31	0	94	1
642	31	0	93	2
643	31	0	315	1
644	31	0	432	1
645	31	0	431	2
646	31	0	26	3
647	31	0	163	1
648	31	0	434	1
649	31	0	101	2
650	31	0	67	2
651	31	0	435	1
652	31	0	92	4
653	31	0	439	2
654	31	0	433	2
655	31	0	442	1
656	31	0	444	1
657	31	0	38	2
658	31	0	164	1
659	31	0	132	3
660	31	0	451	2
661	31	0	454	2
662	31	0	455	2
663	31	0	456	1
664	31	0	458	2
665	31	0	459	2
666	31	0	65	2
667	31	0	66	2
668	31	0	120	1
669	31	0	698	1
670	31	0	371	1
671	31	0	98	1
672	31	0	647	1
673	31	0	643	1
674	31	0	838	3
675	31	0	779	2
676	31	0	21	7
677	31	0	95	4
678	31	0	153	4
679	31	0	13	2
680	31	0	440	3
681	31	0	436	5
682	31	0	99	4
683	31	0	100	3
684	20	0	594	1
685	31	0	594	1
686	31	0	837	1
687	20	0	837	1
688	29	0	706	2
689	30	0	95	2
690	30	0	21	23
691	30	0	24	2
692	30	0	93	2
693	30	0	64	4
694	30	0	153	1
695	30	0	2	1
696	30	0	98	2
697	30	0	728	1
698	30	0	99	24
699	30	0	537	2
700	30	0	92	2
701	30	0	76	4
702	30	0	30	2
703	30	0	647	1
704	30	0	643	1
705	30	0	15	1
706	30	0	90	2
707	30	0	100	23
708	30	0	13	23
709	30	0	144	1
710	30	0	145	1
711	30	0	88	1
712	30	0	847	4
713	30	0	38	1
714	30	0	79	1
715	30	0	446	1
716	30	0	164	2
717	30	0	436	6
718	30	0	594	1
719	30	0	5	1
720	30	0	23	1
721	30	0	65	4
722	30	0	66	4
723	30	0	18	1
724	30	0	454	2
725	30	0	455	20
726	30	0	855	20
727	30	0	853	2
728	14	0	455	3
729	14	0	855	3
730	14	0	454	2
731	14	0	853	2
732	31	0	853	2
733	31	0	855	2
734	31	0	856	1
735	20	0	855	2
736	20	0	856	1
737	20	0	454	2
738	20	0	853	2
739	32	0	5	1
740	32	0	15	1
741	32	0	90	4
742	32	0	14	1
743	32	0	18	1
745	32	0	105	14
746	32	0	95	1
747	32	0	24	2
748	32	0	728	1
749	32	0	436	1
750	32	0	144	1
751	32	0	145	1
752	32	0	30	2
753	32	0	132	3
754	32	0	23	5
755	32	0	153	2
756	13	0	105	18
757	13	0	132	3
758	31	0	105	4
760	30	0	105	18
761	13	0	9	1
762	30	0	9	1
763	29	0	885	1
764	31	0	892	1
765	31	0	859	2
766	20	0	859	2
767	20	0	892	1
768	11	0	213	1
769	27	0	213	1
770	28	0	213	1
771	24	0	839	1
772	27	0	839	1
774	30	0	132	3
775	32	0	869	1
384	12	0	412	5
783	36	0	21	12
784	36	0	22	2
251	14	0	187	2
611	15	26	0	1
785	36	0	23	3
786	36	0	24	2
787	36	0	33	2
788	36	0	25	3
789	36	0	26	2
790	36	0	27	2
791	36	0	28	4
792	36	0	29	1
793	36	0	30	1
795	36	0	54	1
796	36	0	56	1
797	36	0	44	1
798	36	0	45	1
799	36	0	38	4
800	36	0	39	2
801	36	0	40	2
802	36	0	57	2
803	36	0	41	3
804	36	0	47	1
805	36	0	46	2
806	36	0	50	1
807	36	0	8	1
808	36	0	52	1
809	36	0	20	1
810	36	0	53	1
811	36	0	18	1
812	36	0	49	2
813	36	0	58	1
814	36	0	60	1
819	36	17	0	1
820	36	0	153	5
821	36	18	0	1
824	37	0	21	12
825	37	0	22	2
826	37	0	23	3
827	37	0	24	2
828	37	0	33	2
829	37	0	25	3
830	37	0	26	2
831	37	0	27	2
832	37	0	28	4
833	37	0	29	1
834	37	0	30	1
836	37	0	54	1
837	37	0	56	1
838	37	0	44	1
839	37	0	45	1
840	37	0	38	4
841	37	0	39	2
842	37	0	40	2
843	37	0	57	2
844	37	0	41	3
845	37	0	47	1
846	37	0	46	2
847	37	0	50	1
848	37	0	8	1
849	37	0	52	1
850	37	0	20	1
851	37	0	53	1
852	37	0	18	1
853	37	0	49	2
854	37	0	58	1
855	37	0	60	1
859	37	17	0	1
860	37	0	153	5
861	37	18	0	1
862	18	0	917	6
383	18	0	193	0.100000000000000006
379	18	0	191	0.100000000000000006
863	7	26	0	1
11	7	0	21	8
864	7	0	467	3
12	7	0	197	2
23	7	0	377	1
21	7	0	30	2
14	7	0	728	2
865	7	0	24	2
16	7	0	159	2
24	7	0	56	2
29	7	0	464	2
866	7	0	873	2
867	7	0	886	1
868	7	0	208	1
869	7	0	165	1
870	38	0	148	2
871	38	0	491	2
872	38	0	339	1
873	38	0	531	1
874	38	0	936	1
875	38	0	315	1
876	7	0	858	14
877	7	0	132	3
878	7	0	466	1
879	7	0	144	1
880	7	0	145	1
881	7	0	470	2
882	7	0	433	2
883	7	0	468	1
555	28	0	20	1
560	28	0	95	1
884	28	0	685	1
885	28	0	648	2
886	28	0	858	14
887	28	0	132	5
888	28	26	0	1
891	12	0	38	100
892	12	0	115	100
896	28	0	886	1
900	28	0	470	1
906	46	0	796	1
539	27	0	65	2
540	27	0	66	2
366	11	0	793	1
232	14	0	21	45
908	14	32	0	1
631	14	0	153	1
744	32	0	886	1
242	14	0	164	2
247	14	0	186	25
235	14	0	92	2
243	14	0	41	4
929	21	0	106	1
229	14	0	23	3
230	14	0	98	2
245	14	0	65	4
246	14	0	66	4
909	14	0	93	2
910	14	0	2	1
911	14	0	537	2
912	14	0	664	1
913	14	0	647	1
930	21	0	858	14
931	21	0	840	1
916	14	0	285	3
932	21	0	974	1
918	14	0	859	1
933	21	0	430	0.25
919	14	0	133	8
920	14	0	84	8
921	14	0	594	1
922	14	0	112	8
241	14	0	741	48
923	7	0	19	1
924	7	0	95	3
925	7	0	934	1
926	7	0	931	2
927	7	0	27	1
239	14	0	183	6
928	14	0	88	3
934	21	0	428	1
941	49	0	411	2
943	49	0	18	1
963	49	0	471	1
993	49	0	56	1
970	49	0	44	1
971	49	0	57	2
1090	63	0	863	1
976	49	0	18	1
983	49	17	0	1
984	49	26	0	1
994	49	0	464	2
995	49	0	873	2
997	49	0	208	1
998	49	0	165	1
1012	50	24	0	1
1013	50	26	0	1
1005	49	0	433	2
1014	60	0	44	1
1015	60	0	56	1
5	7	0	875	0
283	15	0	875	0
782	36	0	875	0
823	37	0	875	0
759	13	0	448	1
1016	60	0	18	1
1017	60	0	8	1
1018	60	0	93	2
1080	59	0	1075	6
1020	60	0	159	2
1095	59	0	1085	1
1022	60	0	51	1
1023	60	0	165	1
1024	60	0	19	1
1026	60	0	208	1
1081	59	0	1087	3
1028	60	0	21	11
1096	59	0	1088	2
1030	60	0	95	2
1031	60	0	467	2
1032	60	0	24	2
1033	60	0	98	1
1034	60	0	433	1
1035	60	0	197	2
1036	60	0	30	2
1037	60	0	114	1
1038	60	0	206	5
1039	60	0	144	1
1040	60	0	145	1
1041	60	0	101	2
1042	60	0	164	1
1043	60	0	57	2
1044	60	0	471	1
1097	59	0	1089	3
1046	60	0	92	2
1079	59	0	1074	0.599999999999999978
1048	60	0	38	1
1049	60	0	213	1
1050	60	0	839	1
1051	60	0	65	2
1052	60	0	66	2
1053	60	0	20	1
1021	60	0	377	1
1045	60	0	484	3
1054	60	0	153	1
1055	60	0	27	1
1056	60	0	1070	1
1057	60	0	648	1
1058	60	0	847	2
1060	60	0	858	14
1061	60	0	132	7
1091	63	0	956	2
1064	57	60	0	1
1065	57	26	0	1
1077	59	0	1072	4
1078	59	0	1073	8
1082	59	0	1077	1
1083	59	0	1078	1
1084	59	0	1071	1
1085	63	0	1079	1
1086	63	0	1082	1
1087	63	0	1080	1
1088	63	0	1083	1
1089	63	0	1081	1
1092	63	0	170	1
1094	63	0	1078	1
1093	63	0	922	0.0050000000000000001
1098	68	0	1091	1
1099	68	0	1095	2
1100	68	0	1096	1
1128	71	0	46	2
1122	71	0	1098	1
1105	68	0	1099	2
1120	66	0	1100	1
1107	54	63	0	1
1123	71	0	1099	2
1124	71	0	873	1
1125	71	0	464	1
1113	49	0	46	2
1114	49	0	976	2
1062	60	0	886	1
1115	54	49	0	1
1126	71	0	1090	1
1127	71	0	1095	1
1130	71	0	1101	1
1131	71	0	50	1
1141	71	0	670	1
1142	71	0	35	1
1143	71	0	36	1
1144	71	0	1104	1
1145	71	0	1113	2
1171	64	3	0	1
1174	74	0	24	3
1175	74	0	64	3
1176	74	0	97	4
1177	74	0	92	6
1178	74	0	660	5
1172	74	0	21	13
1179	74	0	128	5
1180	74	0	831	1
1181	74	0	100	1
1182	74	0	702	1
1183	74	0	102	4
1184	74	0	41	3
1185	74	0	42	2
1186	74	0	133	30
1187	74	0	83	1
1188	74	0	84	2
1189	74	0	82	1
1190	74	0	395	1
1191	74	0	397	1
1192	74	0	901	5
1193	74	0	136	2
1194	74	0	818	4
1195	74	0	683	2
1196	74	0	357	13
1173	74	0	23	5
1197	74	0	1117	4
1198	74	0	1118	4
1199	74	0	1116	2
1200	64	74	0	1
972	49	0	42	2
1202	3	0	95	2
1008	49	0	95	1
1204	3	0	24	3
1205	3	0	315	3
1206	3	0	64	7
1207	3	0	537	3
1208	3	0	90	2
991	49	0	24	4
1210	3	0	99	8
1211	3	0	644	4
1212	3	0	664	1
1213	3	0	779	6
1214	3	0	346	1
1215	3	0	326	2
1216	3	0	76	6
985	49	0	21	10
1218	3	0	678	8
1203	3	0	21	31
1201	3	0	23	10
1217	3	0	659	8
1220	3	0	1119	8
1221	3	0	647	1
1222	3	0	28	8
1219	3	0	651	16
1223	3	0	643	2
1224	3	0	695	1
1225	3	0	29	1
1226	3	0	112	1
1227	3	0	107	1
1228	3	0	117	5
1229	3	0	128	2
1230	3	0	100	9
1232	3	0	183	1
1233	3	0	88	1
1234	3	0	113	3
1235	3	0	115	3
1236	3	0	38	2
1237	3	0	39	17
1238	3	0	79	1
1239	3	0	80	1
1240	3	0	1120	1
1242	3	0	436	1
1243	3	0	132	16
1244	3	0	858	70
1245	3	0	109	1
1246	3	0	875	1
1247	3	0	51	1
1248	3	0	135	9
1249	3	0	1115	9
1250	3	0	447	1
1251	3	0	395	1
1253	3	0	869	1
1254	3	0	680	9
1255	3	0	722	1
1256	3	0	886	1
1257	64	0	1063	1
1258	76	0	21	14
1259	76	0	96	1
1260	76	0	315	1
1261	76	0	153	2
1262	76	0	116	1
1263	76	0	1	1
1264	76	0	1121	1
1265	76	0	1122	1
1266	76	0	653	1
1267	76	0	162	3
1268	76	0	92	2
1269	76	0	850	1
1270	76	0	1123	1
1271	76	0	27	1
1272	76	0	553	1
1273	76	0	1050	1
1274	76	0	657	2
1275	76	0	347	1
1276	76	0	254	1
1277	76	0	648	1
1278	76	0	539	2
1279	76	0	650	1
1280	76	0	100	2
1281	76	0	1124	1
1282	76	0	1125	1
1283	76	0	704	1
1284	76	0	38	1
1285	76	0	39	1
1286	76	0	436	10
1287	76	0	393	1
1288	76	0	132	18
1289	64	76	0	1
1290	76	0	110	1
1291	76	0	285	1
1292	76	0	282	1
1293	76	0	185	1
1294	76	0	937	1
1295	76	0	447	1
1296	76	0	395	1
1297	76	0	403	7
1252	3	0	403	5
1298	76	0	23	2
1299	76	0	719	2
1300	76	0	616	1
1301	76	0	870	1
1004	49	0	1126	2
1001	49	0	466	2
986	49	0	537	3
989	49	0	29	1
1011	49	0	160	1
1303	49	0	662	1
1304	49	0	93	3
1302	49	0	64	4
1305	49	0	26	4
1418	71	0	21	5
1307	49	0	28	4
1308	49	0	1127	1
1421	71	0	153	2
1428	71	0	28	3
1311	49	0	1129	1
1312	49	0	1131	1
1313	49	0	1105	2
1314	49	0	1132	1
1425	71	0	537	2
1316	49	0	35	1
1377	79	0	56	1
1318	49	0	39	2
1317	49	0	38	4
1375	78	0	24	1
1320	49	0	1134	1
1322	77	0	411	2
1323	77	0	18	1
1324	77	0	471	1
1325	77	0	44	1
1326	77	0	57	2
1327	77	0	18	1
1332	77	17	0	1
1333	77	26	0	1
1334	77	0	56	2
1335	77	0	464	2
1336	77	0	873	2
1337	77	0	208	1
1338	77	0	165	1
1339	77	0	858	14
1340	77	0	433	2
1341	77	0	46	2
1342	77	0	976	2
1343	77	0	132	3
1344	77	0	21	16
1345	77	0	206	1
1346	77	0	1126	2
1347	77	0	42	4
1348	77	0	466	2
1349	77	0	537	3
1350	77	0	24	6
1351	77	0	29	1
1352	77	0	160	1
1353	77	0	95	4
1354	77	0	662	1
1355	77	0	93	3
1356	77	0	64	4
1357	77	0	26	4
1358	77	0	92	1
1359	77	0	28	4
1360	77	0	1127	1
1361	77	0	142	2
1362	77	0	1128	2
1363	77	0	1129	1
1364	77	0	1131	1
1365	77	0	1105	2
1366	77	0	1132	1
1367	77	0	728	1
1368	77	0	35	1
1369	77	0	39	2
1370	77	0	38	4
1371	77	0	30	1
1372	77	0	1134	1
1373	77	0	1135	1
1374	78	0	95	1
1376	67	78	0	1
1378	79	0	570	1
1379	79	0	670	1
1380	70	79	0	2
1381	65	0	869	1
1382	65	0	886	1
1383	65	0	20	1
1384	65	0	113	6
1385	65	0	183	4
1386	65	0	88	6
1387	65	0	38	5
1388	65	0	39	5
1389	49	0	728	1
1390	49	0	647	1
1391	49	0	114	2
1392	49	0	1128	2
1393	49	0	1133	1
1394	64	0	324	1
1395	64	0	1137	1
1396	64	0	821	1
1397	64	0	1140	1
1398	64	0	1138	1
1399	64	0	1143	1
1400	64	0	1142	1
1401	64	0	1139	1
1402	64	0	1141	1
1403	64	0	152	4
1404	64	0	775	1
1405	64	0	820	1
1407	64	0	1144	10
1408	64	0	1145	4
1409	64	0	1147	2
1410	64	0	1148	2
1411	64	0	1149	8
1412	64	0	1150	4
1413	64	0	1152	1
1414	64	0	1151	2
1415	64	0	1153	4
1420	71	0	315	1
1422	71	0	297	2
1423	71	0	436	4
1424	71	0	1127	2
1426	71	0	24	4
1427	71	0	114	2
1430	72	0	46	2
1431	72	0	1098	1
1432	72	0	1099	2
1433	72	0	873	1
1434	72	0	464	1
1435	72	0	1090	1
1436	72	0	1095	1
1437	72	0	1101	1
1500	73	0	93	2
1503	73	0	467	2
1443	72	0	1113	2
1446	72	0	21	7
1447	72	0	62	1
1448	72	0	315	1
1449	72	0	297	2
1450	72	0	436	4
1451	72	0	1127	2
1452	72	0	537	2
1453	72	0	24	4
1454	72	0	114	2
1455	72	0	28	4
1456	72	0	26	2
1457	72	0	153	3
1438	72	0	51	1
1440	72	0	1105	1
1442	72	0	667	1
1439	72	0	663	1
1441	72	0	665	1
1459	66	0	1098	1
1460	66	0	1099	2
1461	66	0	873	1
1462	66	0	464	1
1463	66	0	1090	1
1464	66	0	1095	1
1465	66	0	1101	1
1466	66	0	50	1
1472	66	0	38	2
1473	66	0	39	1
1474	66	0	21	7
1475	66	0	62	1
1476	66	0	315	1
1477	66	0	297	2
1478	66	0	436	4
1479	66	0	1127	2
1480	66	0	537	2
1485	66	0	153	3
1458	66	0	46	1
1416	71	0	38	4
1417	71	0	39	2
1444	72	0	38	4
1445	72	0	39	2
1481	66	0	24	2
1484	66	0	26	1
1483	66	0	28	2
1482	66	0	114	1
1468	66	0	1106	1
1470	66	0	1107	1
1467	66	0	663	1
1469	66	0	667	1
1471	66	0	1113	1
1486	73	0	1100	1
1487	73	0	1098	1
1488	73	0	1099	2
1489	73	0	873	1
1490	73	0	464	1
1491	73	0	1090	1
1492	73	0	1095	1
1493	73	0	1101	1
1494	73	0	50	1
1495	73	0	38	2
1496	73	0	39	1
1497	73	0	21	7
1498	73	0	62	1
1499	73	0	315	1
1501	73	0	436	4
1502	73	0	1127	2
1504	73	0	153	3
1505	73	0	46	1
1506	73	0	24	2
1507	73	0	26	1
1508	73	0	28	2
1509	73	0	114	1
1510	73	0	1106	1
1511	73	0	1108	1
1512	73	0	1109	1
1515	64	0	1157	13
1514	73	0	1113	2
1516	80	0	46	2
1517	80	0	1098	1
1518	80	0	1099	2
1519	80	0	873	1
1520	80	0	464	1
1521	80	0	1090	1
1522	80	0	1095	1
1530	80	0	21	7
1531	80	0	62	1
1532	80	0	315	1
1533	80	0	297	2
1534	80	0	436	4
1535	80	0	1127	2
1536	80	0	537	2
1537	80	0	24	4
1538	80	0	114	2
1539	80	0	28	4
1540	80	0	26	2
1541	80	0	153	3
1542	80	0	38	4
1543	80	0	39	2
1526	80	0	1160	1
1525	80	0	1161	1
1527	80	0	662	1
1547	71	0	57	1
1545	65	0	1158	1
1544	80	0	667	1
1528	80	0	671	1
1549	71	0	805	1
1550	71	0	643	1
1551	71	0	1236	2
1552	71	0	1126	1
1553	71	0	26	2
1554	71	0	160	1
1555	67	0	169	1
1556	67	0	919	4
\.


--
-- Data for Name: shops; Type: TABLE DATA; Schema: public; Owner: jrm
--

COPY public.shops (id, supplier_id, shoptype, theday, extra_cost, components_cost, delivery_cost) FROM stdin;
17	9	0	2003-11-17	0	282.5	0
3	2	0	2003-09-08	0	31.9600000000000009	0
20	12	0	2003-08-01	10	250	0
8	2	1	2003-09-19	0.689999999999999947	124.180000000000007	5.45999999999999996
19	11	1	2003-11-17	0	742.5	22.6000000000000014
5	6	1	2002-09-12	0	400	0
32	3	0	2003-11-27	0	403.920000000000016	10
30	12	0	2003-11-25	0	1355	30
29	3	0	2003-11-13	0	85	0
15	2	0	2003-11-07	0	11.3000000000000007	0
10	2	0	2003-10-01	0	10.6050000000000004	0
34	2	0	2003-12-22	0	294	8
4	5	0	2003-09-10	2.25380000000000003	93.2442000000000064	22
18	10	0	2003-11-17	0	568.149999999999977	0
35	14	1	2003-12-23	0	0	\N
36	2	1	2003-12-22	0	142.323000000000008	5.6769999999999996
40	9	1	2002-02-01	0	0	1
37	3	1	2004-01-12	0	0	\N
41	5	1	2004-01-09	0	\N	\N
38	9	1	2002-02-02	0	0	0
6	7	1	2002-09-12	0	120	0
33	2	0	2003-11-27	0	2236.6543999999999	5.45000000000000018
46	2	1	2004-02-19	0	0	0
47	2	1	2004-02-20	0	0	0
49	10	1	2004-02-20	0	0	0
52	2	1	2004-02-25	0	17.9699999999999989	0
51	2	1	2004-02-20	0	64.9200000000000017	0
50	3	1	2004-02-20	0	645.299999999999955	0
53	3	1	2004-02-18	0	0	0
54	1	0	2004-03-03	0	0	0
42	2	1	2004-02-09	0	0	\N
57	19	1	2004-03-05	0	274.5	10
45	9	1	2002-02-11	0	0	0
43	9	1	2002-02-10	0	0	0
62	8	1	2004-03-08	0	0	0
63	4	1	2004-03-09	0	4	0
64	24	1	2004-03-09	0	0	0
65	10	1	2004-03-09	0	0	0
66	25	1	2004-03-10	0	0	0
67	12	1	2004-03-10	0	0	0
58	4	1	2004-03-05	0	48.990000000000002	0
60	4	1	2004-03-06	0	59.7999999999999972	0
68	3	1	2004-03-11	0	47.5	9.69999999999999929
69	12	1	2004-03-12	0	0	0
61	23	1	2004-03-06	0	22.6999999999999993	0
76	2	1	2004-03-25	0	0	0
77	2	1	2004-04-05	0	20.7284100000000002	6
78	2	1	2004-04-02	0	6.15000000000000036	1.58000000000000007
79	10	1	2004-04-06	0	0	0
80	4	1	2004-04-08	0	0	0
81	2	1	1205-08-06	0	0	0
72	2	1	2004-03-16	0	39.0180000000000007	4.01999999999999957
82	2	1	2004-04-12	0	40.5949999999999989	9.19999999999999929
83	4	1	2004-04-16	0	37.4600000000000009	0
71	5	1	2004-03-16	134.580000000000013	2426.45256000000018	341
75	4	1	2004-03-15	0	0	0
56	5	1	2004-03-03	54.0900000000000034	1182.32099999999991	304.879999999999995
84	9	1	2002-04-20	0	0	0
86	2	1	2004-04-15	0	41.4299999999999997	8.40000000000000036
89	23	1	2004-04-23	0	24	0
91	9	1	2002-04-21	0	0	0
93	9	1	2002-04-24	0	0	0
100	9	1	2002-04-22	0	0	0
101	9	1	2002-04-23	0	0	0
92	9	1	2002-02-15	0	0	0
11	9	1	2000-04-30	0	172.72999999999999	0
16	8	1	2003-04-30	0	2	0
1	9	1	2000-04-30	0	4070.63099999999986	0
106	30	1	2004-07-06	0	0	0
104	8	1	2004-06-01	0	37.8200000000000003	0
105	29	1	2004-04-12	0	305.730000000000018	0
107	14	1	2004-08-11	0	0	0
108	4	1	2004-08-13	0	0	0
109	35	1	2004-08-12	0	0	0
110	3	1	2004-08-16	0	0	0
111	2	1	2004-08-16	0	0	0
112	19	1	2004-08-17	0	0	0
120	4	0	2004-09-03	0	0	0
121	4	1	2004-09-03	0	0	0
113	8	1	2004-08-01	0	0	0
114	4	1	2004-08-26	0	0	0
122	4	1	2004-09-08	0	0	0
123	2	1	2004-09-06	0	0	0
115	2	1	2004-08-24	0	0	0
116	9	1	2004-08-26	0	0	0
117	5	1	2004-08-20	0	0	0
118	23	1	2004-08-30	0	0	0
119	2	1	2004-08-30	0	0	0
136	4	1	2004-10-20	0	0	0
125	2	1	2004-09-10	0	0	0
126	4	1	2004-09-24	0	0	0
127	8	1	2004-09-27	0	0	0
128	10	1	2004-10-01	0	0	0
129	2	0	2004-09-30	0	0	0
132	4	1	2004-10-07	0	0	0
133	2	1	2004-10-07	0	0	0
134	2	1	2004-10-11	0	0	0
135	4	1	2004-10-14	0	0	0
130	2	1	2004-09-30	0	0	0
131	4	1	2004-10-04	0	0	0
137	2	1	2004-10-19	0	0	0
138	4	1	2004-10-21	0	0	0
141	4	1	2004-10-22	0	0	0
\.


--
-- Data for Name: supergroups; Type: TABLE DATA; Schema: public; Owner: jrm
--

COPY public.supergroups (name, id) FROM stdin;
Componentes Eletrônicos	1
Ferramentas	6
~ Supergrupo Genérico	0
Componentes Mecânicos	9
Produto Final	11
Montagens Internas	2
Material de Consumo/Acessórios	7
\.


--
-- Data for Name: suppliercodes; Type: TABLE DATA; Schema: public; Owner: jrm
--

COPY public.suppliercodes (supplier_id, component_id, ordercode, rounding, id, partnumber, manufact_id, price, tax, descr) FROM stdin;
40	1452	 187-CL21B104KBCNNNL 	1	926	CL21B104KBCNNNL 	0	0	0	
40	1709	 511-ESDCAN03-2BWY 	1	937	ESDCAN03-2BWY	1	0	0	
40	88	 771-74HCT541D-T 	1	960	 74HCT541D,653 	1	0	0	
40	660	 708-RMCF0805JT270R 	1	948	RMCF0805JT270R 	1	0	0	
0	349		1	967	50K/5W	0	0	0	DEFAULT
0	1012		1	968	10K	0	0	0	DEFAULT
0	1340		1	969	Header 10x2 PCI 90 w guide	0	0	0	DEFAULT
0	1029		1	970	Chave Allen 2.5mm	0	0	0	DEFAULT
0	148		1	971	CI 8 pinos DIP torneado	0	0	0	DEFAULT
0	410		1	972	CI 32 Pinos PLCC	0	0	0	DEFAULT
0	3		1	973	56R	0	0	0	DEFAULT
0	4		1	974	47R	0	0	0	DEFAULT
0	1313		1	975	270K	0	0	0	DEFAULT
0	392		1	976	Fusível 250V Laranja	0	0	0	DEFAULT
0	1309		1	977	DCP010512BP	0	0	0	DEFAULT
0	1315		1	978	Header 20x2 PCI 180 w guide	0	0	0	DEFAULT
0	1311		1	979	Fusível 1/2 3pinos 250V	0	0	0	DEFAULT
0	6		1	980	Cadeira giratória	0	0	0	DEFAULT
0	708		1	981	2N2646	0	0	0	DEFAULT
0	696		1	982	2N6027	0	0	0	DEFAULT
0	712		1	983	2N6109	0	0	0	DEFAULT
0	714		1	984	IRF840A	0	0	0	DEFAULT
0	716		1	985	BTA26-600B	0	0	0	DEFAULT
0	7		1	986	Mesa workflex 1.85x0.70cm	0	0	0	DEFAULT
0	16		1	987	8MHz	0	0	0	DEFAULT
0	40		1	988	BD135	0	0	0	DEFAULT
0	45		1	989	LM35DZ	0	0	0	DEFAULT
0	47		1	990	LM385-1.2	0	0	0	DEFAULT
0	54		1	991	1MHz	0	0	0	DEFAULT
0	171		1	992	PG9	0	0	0	DEFAULT
0	58		1	993	ASH-Rev0	0	0	0	DEFAULT
0	85		1	994	CONV-2B	0	0	0	DEFAULT
0	87		1	995	6B595	0	0	0	DEFAULT
0	89		1	996	D69105D ALCATEL	0	0	0	DEFAULT
0	103		1	997	MOLEX A-2	0	0	0	DEFAULT
0	111		1	998	MOLEX A-4	0	0	0	DEFAULT
0	124		1	999	45V	0	0	0	DEFAULT
0	129		1	1000	P22	0	0	0	DEFAULT
0	130		1	1001	P22	0	0	0	DEFAULT
0	194		1	1002	M3 x 16mm Escariado Fenda	0	0	0	DEFAULT
0	195		1	1003	M3 x 26mm Philips Inox	0	0	0	DEFAULT
0	121		1	1004	24LC512-I/P	0	0	0	DEFAULT
0	139		1	1005	RSHXXX	0	0	0	DEFAULT
0	172		1	1006	Tela de silk-screen	0	0	0	DEFAULT
0	212		1	1007	4.7uF/50V	0	0	0	DEFAULT
0	43		1	1008	Flat Cable 4X2 Fêmea	0	0	0	DEFAULT
0	385		1	1009	RJ-11 Low Profile	0	0	0	DEFAULT
0	450		1	1010	RELE-BR10	0	0	0	DEFAULT
0	462		1	1011	74HC244	0	0	0	DEFAULT
0	465		1	1012	DAC7571	0	0	0	DEFAULT
0	543		1	1013	 9x2 100mils plástico	0	0	0	DEFAULT
0	362		1	1014	DIN 6 Pinos Fêmea Painel	0	0	0	DEFAULT
0	52		1	1015	TLV5606CD	0	0	0	DEFAULT
0	53		1	1016	TPS77050DBVR	0	0	0	DEFAULT
0	880		1	1017	lasercon	0	0	0	DEFAULT
0	241		1	1018	UA710CN	0	0	0	DEFAULT
0	198		1	1019	33pF	0	0	0	DEFAULT
0	296		1	1020	390pF	0	0	0	DEFAULT
0	682		1	1021	10pF	0	0	0	DEFAULT
0	235		1	1022	TL071CP	0	0	0	DEFAULT
0	239		1	1023	IR2112	0	0	0	DEFAULT
0	227		1	1024	74OL6010	0	0	0	DEFAULT
0	1312		1	1025	50mA/250V	0	0	0	DEFAULT
0	149		1	1026	CI 14 pinos DIP torn.	0	0	0	DEFAULT
0	1316		1	1027	0.47uF/6.3V	0	0	0	DEFAULT
0	338		1	1028	220uF/35V	0	0	0	DEFAULT
0	262		1	1029	ADC0808N	0	0	0	DEFAULT
0	266		1	1030	LMC6062AIN	0	0	0	DEFAULT
0	270		1	1031	74LS05	0	0	0	DEFAULT
0	277		1	1032	LM35DT	0	0	0	DEFAULT
0	281		1	1033	LM74CIM	0	0	0	DEFAULT
0	283		1	1034	MAX692A	0	0	0	DEFAULT
0	287		1	1035	LM6218N	0	0	0	DEFAULT
0	290		1	1036	22nF/400V	0	0	0	DEFAULT
0	291		1	1037	220nF/400V	0	0	0	DEFAULT
0	292		1	1038	100nF/630V	0	0	0	DEFAULT
0	293		1	1039	1.5nF/400V	0	0	0	DEFAULT
0	294		1	1040	1nF/400V	0	0	0	DEFAULT
0	295		1	1041	5.6nF/400V	0	0	0	DEFAULT
0	298		1	1042	12nF/400V	0	0	0	DEFAULT
0	299		1	1043	470nF/400V	0	0	0	DEFAULT
0	300		1	1044	1uF/400V	0	0	0	DEFAULT
0	301		1	1045	3.3uF/250V	0	0	0	DEFAULT
0	302		1	1046	15nF/400V	0	0	0	DEFAULT
0	303		1	1047	220nF/250V	0	0	0	DEFAULT
40	1587	 80-C0805C300J4HACTU 	1	927	C0805C300J4HACTU 	0	0	0	
40	1710	 70-ILB1206ER600V 	1	938	ILB1206ER600V	1	0	0	
40	24	 71-CRCW080510K0JNEC 	1	949	CRCW080510K0JNEC 	1	0	0	
40	117	 71-CRCW08054K70JNEB 	1	950	CRCW08054K70JNEB 	1	0	0	
40	1584	 771-TJA1050T/CM118 	1	961	 TJA1050T/CM,118 	1	0	0	
0	304		1	1048	100nF/100V	0	0	0	DEFAULT
0	305		1	1049	220nF/630V	0	0	0	DEFAULT
0	306		1	1050	680nF/250V	0	0	0	DEFAULT
0	307		1	1051	330nF/250V	0	0	0	DEFAULT
0	308		1	1052	8.2nF/400V	0	0	0	DEFAULT
0	309		1	1053	4.7nF/400V	0	0	0	DEFAULT
0	310		1	1054	100nF/250V	0	0	0	DEFAULT
0	311		1	1055	22nF/250V	0	0	0	DEFAULT
0	312		1	1056	3.3nF/400V	0	0	0	DEFAULT
0	314		1	1057	390pF	0	0	0	DEFAULT
0	288		1	1058	33pF	0	0	0	DEFAULT
0	316		1	1059	DB9 Macho Flat Cable	0	0	0	DEFAULT
0	318		1	1060	Flat Cable17x2 Fêmea	0	0	0	DEFAULT
0	319		1	1061	Mini DIN 6 pinos Macho Cabo	0	0	0	DEFAULT
0	320		1	1062	Mini DIN 6 pinos Fêmea Cabo	0	0	0	DEFAULT
0	321		1	1063	DIN 5 pinos Macho Cabo	0	0	0	DEFAULT
0	323		1	1064	Antena 75R Macho Cabo	0	0	0	DEFAULT
0	325		1	1065	2200uF/16V	0	0	0	DEFAULT
0	330		1	1066	22uF/450V	0	0	0	DEFAULT
0	332		1	1067	10uF/50V	0	0	0	DEFAULT
0	333		1	1068	220uF/63V	0	0	0	DEFAULT
0	334		1	1069	1.5uF/63V	0	0	0	DEFAULT
0	335		1	1070	22uF/25V	0	0	0	DEFAULT
0	336		1	1071	2.2uF/100V	0	0	0	DEFAULT
0	337		1	1072	1uF/630V	0	0	0	DEFAULT
0	342		1	1073	3.9nF/1600V	0	0	0	DEFAULT
0	348		1	1074	4.7nF	0	0	0	DEFAULT
0	350		1	1075	27pF	0	0	0	DEFAULT
0	352		1	1076	15pF	0	0	0	DEFAULT
0	345		1	1077	12pF	0	0	0	DEFAULT
0	355		1	1078	Chave de Toque 1mm	0	0	0	DEFAULT
0	356		1	1079	Chave de Toque 6mm	0	0	0	DEFAULT
0	358		1	1080	Chave de Toque 9mm	0	0	0	DEFAULT
0	360		1	1081	DB9 Fêmea PCI 20mm	0	0	0	DEFAULT
0	361		1	1082	Telefone 4/4 Fêmea 90 graus PCI	0	0	0	DEFAULT
0	366		1	1083	Chave de Toque Grande 4mm	0	0	0	DEFAULT
0	367		1	1084	Fasting-Faston Macho	0	0	0	DEFAULT
0	368		1	1085	Fastin-Faston Fêmea	0	0	0	DEFAULT
0	370		1	1086	G1RC2-12V	0	0	0	DEFAULT
0	372		1	1087	11.0592MHz	0	0	0	DEFAULT
0	373		1	1088	16MHz	0	0	0	DEFAULT
0	374		1	1089	12MHz	0	0	0	DEFAULT
0	375		1	1090	24MHz	0	0	0	DEFAULT
0	380		1	1091	A124	0	0	0	DEFAULT
0	381		1	1092	A144	0	0	0	DEFAULT
0	382		1	1093	10A/400V	0	0	0	DEFAULT
0	384		1	1094	Flat Cable 20x2 Fêmea	0	0	0	DEFAULT
0	383		1	1095	Flat Cable 25x2 Fêmea	0	0	0	DEFAULT
0	341		1	1096	22uF/250V	0	0	0	DEFAULT
0	387		1	1097	Telefone 4/4 Fêmea PCI Low Profile	0	0	0	DEFAULT
0	388		1	1098	25A/400V	0	0	0	DEFAULT
0	389		1	1099	15A/400V	0	0	0	DEFAULT
0	390		1	1100	8A/400V	0	0	0	DEFAULT
0	394		1	1101	DB9 Capa	0	0	0	DEFAULT
0	569		1	1102	100mm (aprox) Branca	0	0	0	DEFAULT
0	400		1	1103	MOLEX A 8 Pinos Capa	0	0	0	DEFAULT
0	401		1	1104	MOLEX A 10 Pinos Capa	0	0	0	DEFAULT
0	557		1	1105	LF411CN	0	0	0	DEFAULT
0	407		1	1106	T19	0	0	0	DEFAULT
0	408		1	1107	T24	0	0	0	DEFAULT
0	547		1	1108	1uF/100V	0	0	0	DEFAULT
0	413		1	1109	Bicolor Vermelho/Verde 3 Pinos 5mm	0	0	0	DEFAULT
0	414		1	1110	Infravermelho 5mm	0	0	0	DEFAULT
0	415		1	1111	10nF	0	0	0	DEFAULT
0	418		1	1112	3.3nF/100V	0	0	0	DEFAULT
0	420		1	1113	56pF	0	0	0	DEFAULT
0	422		1	1114	NTC 16R	0	0	0	DEFAULT
0	423		1	1115	S20K250	0	0	0	DEFAULT
0	424		1	1116	4.7nF	0	0	0	DEFAULT
0	425		1	1117	27pF	0	0	0	DEFAULT
0	426		1	1118	100pF	0	0	0	DEFAULT
0	427		1	1119	1nF	0	0	0	DEFAULT
0	429		1	1120	2.2nF	0	0	0	DEFAULT
0	313		1	1121	3.9nF	0	0	0	DEFAULT
0	473		1	1122	SN75177BP	0	0	0	DEFAULT
0	477		1	1123	DG408DJ	0	0	0	DEFAULT
0	479		1	1124	SN75154N	0	0	0	DEFAULT
0	480		1	1125	SN75150P	0	0	0	DEFAULT
40	1700	 187-CL21B225KPFNNNG 	1	928	CL21B225KPFNNNG 	1	0	0	
40	1711	 538-22-27-2061 	1	939	22-27-2061	1	0	0	
40	1719	 603-RC0805DR-07330RL 	1	951	 RC0805DR-07330RL 	1	0	0	
40	1725	 511-STM32F405RGT6 	1	962	STM32F405RGT6 	1	0	0	
0	486		1	1126	DG201DPJ	0	0	0	DEFAULT
0	487		1	1127	LM2825N-5.0	0	0	0	DEFAULT
0	490		1	1128	LM2578AN	0	0	0	DEFAULT
0	492		1	1129	LM2675N-5.0	0	0	0	DEFAULT
0	502		1	1130	DG407DJ	0	0	0	DEFAULT
0	491		1	1131	OP07CP	0	0	0	DEFAULT
0	507		1	1132	MAX1249BCPE	0	0	0	DEFAULT
0	508		1	1133	MAX1248BCPE	0	0	0	DEFAULT
0	509		1	1134	HP2200	0	0	0	DEFAULT
0	511		1	1135	SN75176BP	0	0	0	DEFAULT
0	513		1	1136	IRF740	0	0	0	DEFAULT
0	369		1	1137	P4 Fêmea 90 graus PCI	0	0	0	DEFAULT
0	516		1	1138	1K Vertical	0	0	0	DEFAULT
0	517		1	1139	10K Vertical	0	0	0	DEFAULT
0	519		1	1140	MC1488P	0	0	0	DEFAULT
0	538		1	1141	47uF/20V	0	0	0	DEFAULT
0	540		1	1142	22uF/16V	0	0	0	DEFAULT
0	542		1	1143	1uF/35V	0	0	0	DEFAULT
0	544		1	1144	4.7uF/25V	0	0	0	DEFAULT
0	545		1	1145	10uF/35V	0	0	0	DEFAULT
0	546		1	1146	47uF/35V	0	0	0	DEFAULT
0	548		1	1147	15nF/100V	0	0	0	DEFAULT
0	549		1	1148	47uF/25V	0	0	0	DEFAULT
0	550		1	1149	3.3nF/630V	0	0	0	DEFAULT
0	523		1	1150	TILL111	0	0	0	DEFAULT
0	561		1	1151	TL16C450N	0	0	0	DEFAULT
0	563		1	1152	TMP82C54P-2	0	0	0	DEFAULT
0	566		1	1153	ZREF12Z	0	0	0	DEFAULT
0	567		1	1154	Pino Partido Médio	0	0	0	DEFAULT
0	573		1	1155	1/8" x 1.5" Fenda	0	0	0	DEFAULT
0	574		1	1156	Espada Pequeno	0	0	0	DEFAULT
0	575		1	1157	Capa de DB9 - Trava	0	0	0	DEFAULT
0	354		1	1158	Pino Partido Pequeno	0	0	0	DEFAULT
0	568		1	1159	Pino Partido Grande	0	0	0	DEFAULT
0	578		1	1160	T15	0	0	0	DEFAULT
0	583		1	1161	LM3875TF	0	0	0	DEFAULT
0	584		1	1162	LM3875T	0	0	0	DEFAULT
0	585		1	1163	E2023	0	0	0	DEFAULT
0	586		1	1164	AT90S1200-12PC	0	0	0	DEFAULT
0	587		1	1165	AT90S2313-4PI	0	0	0	DEFAULT
0	499		1	1166	SG3524N	0	0	0	DEFAULT
0	595		1	1167	LM2585T-5.0	0	0	0	DEFAULT
0	599		1	1168	LM2586T-5.0	0	0	0	DEFAULT
0	600		1	1169	LM2586T-ADJ	0	0	0	DEFAULT
0	601		1	1170	DS88C20N	0	0	0	DEFAULT
0	602		1	1171	DS88C120N	0	0	0	DEFAULT
0	603		1	1172	DAC0832LCN	0	0	0	DEFAULT
0	604		1	1173	DS8922AN	0	0	0	DEFAULT
0	605		1	1174	AT29C020-12JC	0	0	0	DEFAULT
0	255		1	1175	DAC0808LCN	0	0	0	DEFAULT
0	606		1	1176	AT90S8515-9JI	0	0	0	DEFAULT
0	608		1	1177	HT2811	0	0	0	DEFAULT
0	609		1	1178	DAC0832LCWM	0	0	0	DEFAULT
0	610		1	1179	TLC0831CP	0	0	0	DEFAULT
0	615		1	1180	DS36F95J	0	0	0	DEFAULT
0	617		1	1181	LM2596T-ADJ	0	0	0	DEFAULT
0	618		1	1182	LM2596T-5.0	0	0	0	DEFAULT
0	620		1	1183	LM3886T	0	0	0	DEFAULT
0	621		1	1184	LM3886TF	0	0	0	DEFAULT
0	623		1	1185	LM2599T-5.0	0	0	0	DEFAULT
0	624		1	1186	ICM6264LD-09	0	0	0	DEFAULT
0	626		1	1187	TL494CN	0	0	0	DEFAULT
0	627		1	1188	MAX1246BCPE	0	0	0	DEFAULT
0	628		1	1189	MAX1110CPP	0	0	0	DEFAULT
0	629		1	1190	MAX1111CPE	0	0	0	DEFAULT
0	630		1	1191	MAX1204BCPP	0	0	0	DEFAULT
0	632		1	1192	DS34C87TM	0	0	0	DEFAULT
0	634		1	1193	HP2232	0	0	0	DEFAULT
0	635		1	1194	DS26C31TN	0	0	0	DEFAULT
0	637		1	1195	MAX149BEAP	0	0	0	DEFAULT
0	638		1	1196	LM747CN	0	0	0	DEFAULT
0	639		1	1197	LM837N	0	0	0	DEFAULT
0	409		1	1198	CI 44 Pinos PLCC	0	0	0	DEFAULT
0	391		1	1199	Fusível 400V	0	0	0	DEFAULT
0	673		1	1200	BZX84C5V6	0	0	0	DEFAULT
0	693		1	1201	RFD14N05L	0	0	0	DEFAULT
0	694		1	1202	LM35CZ	0	0	0	DEFAULT
0	697		1	1203	MRD300	0	0	0	DEFAULT
0	720		1	1204	MUR1540	0	0	0	DEFAULT
0	721		1	1205	TK19	0	0	0	DEFAULT
0	531		1	1206	1nF/100V	0	0	0	DEFAULT
40	1701	 80-C0805C150G8HACTU 	1	929	C0805C150G8HACTU 	1	0	0	
40	1712	 810-VLS3012CX150M1 	1	940	 VLS3012CX-150M-1 	1	0	0	
40	1720	 667-ERJ-PB6D4993V 	1	952	 ERJ-PB6D4993V 	1	0	0	
40	1293	 863-LM358DMR2G 	1	963	 LM358DMR2G 	1	0	0	
0	532		1	1207	2.2nF/100V	0	0	0	DEFAULT
0	514		1	1208	TIC226D	0	0	0	DEFAULT
0	512		1	1209	TIC246D	0	0	0	DEFAULT
0	725		1	1210	P2N80	0	0	0	DEFAULT
0	729		1	1211	TMS370	0	0	0	DEFAULT
0	747		1	1212	150uF/450V	0	0	0	DEFAULT
0	748		1	1213	150uF/400V	0	0	0	DEFAULT
0	749		1	1214	1000uF/250V	0	0	0	DEFAULT
0	753		1	1215	470uF/400V	0	0	0	DEFAULT
0	754		1	1216	Euro 96 Pinos Macho	0	0	0	DEFAULT
0	755		1	1217	Euro 96 Pinos Fêmea	0	0	0	DEFAULT
0	756		1	1218	Pasta Térmica para Solda	0	0	0	DEFAULT
0	757		1	1219	0R22/5%	0	0	0	DEFAULT
0	758		1	1220	33R	0	0	0	DEFAULT
0	759		1	1221	0R33/5%	0	0	0	DEFAULT
0	760		1	1222	0.33R	0	0	0	DEFAULT
0	761		1	1223	220R	0	0	0	DEFAULT
0	762		1	1224	47R	0	0	0	DEFAULT
0	763		1	1225	0.47R	0	0	0	DEFAULT
0	764		1	1226	1K	0	0	0	DEFAULT
0	766		1	1227	0.10R	0	0	0	DEFAULT
0	767		1	1228	180R	0	0	0	DEFAULT
0	768		1	1229	1K	0	0	0	DEFAULT
0	769		1	1230	180R	0	0	0	DEFAULT
0	770		1	1231	56R	0	0	0	DEFAULT
0	771		1	1232	4R7	0	0	0	DEFAULT
0	772		1	1233	33R	0	0	0	DEFAULT
0	773		1	1234	1K	0	0	0	DEFAULT
0	774		1	1235	12R	0	0	0	DEFAULT
0	776		1	1236	NTC 5R	0	0	0	DEFAULT
0	777		1	1237	C30 10A	0	0	0	DEFAULT
0	778		1	1238	C40 6A	0	0	0	DEFAULT
0	780		1	1239	SK4F1/10	0	0	0	DEFAULT
0	781		1	1240	DB3	0	0	0	DEFAULT
0	786		1	1241	BYV96E	0	0	0	DEFAULT
0	787		1	1242	BYV95B	0	0	0	DEFAULT
0	788		1	1243	BYW95C	0	0	0	DEFAULT
0	789		1	1244	1N4729AC	0	0	0	DEFAULT
0	790		1	1245	1N4728AC	0	0	0	DEFAULT
0	798		1	1246	1N5406	0	0	0	DEFAULT
0	799		1	1247	1N5408	0	0	0	DEFAULT
0	800		1	1248	1N5404	0	0	0	DEFAULT
0	801		1	1249	6A8	0	0	0	DEFAULT
0	805		1	1250	1N4004	0	0	0	DEFAULT
0	797		1	1251	BYV95C	0	0	0	DEFAULT
0	812		1	1252	1N5339B	0	0	0	DEFAULT
0	813		1	1253	3G08  4K	0	0	0	DEFAULT
0	824		1	1254	3.3uF/450V	0	0	0	DEFAULT
0	825		1	1255	Azul 5mm	0	0	0	DEFAULT
0	421		1	1256	NTC 25R	0	0	0	DEFAULT
0	736		1	1257	10K	0	0	0	DEFAULT
0	733		1	1258	330K	0	0	0	DEFAULT
0	734		1	1259	33K	0	0	0	DEFAULT
0	684		1	1260	150K	0	0	0	DEFAULT
0	419		1	1261	33pF	0	0	0	DEFAULT
0	826		1	1262	10MHz	0	0	0	DEFAULT
0	827		1	1263	7.2MHz	0	0	0	DEFAULT
0	828		1	1264	18.432MHz	0	0	0	DEFAULT
0	830		1	1265	Chave de Toque 0.5mm	0	0	0	DEFAULT
0	416		1	1266	470pF	0	0	0	DEFAULT
0	402		1	1267	MOLEX A 10 Pinos PCI 180°	0	0	0	DEFAULT
0	832		1	1268	MOLEX A 8 Pinos PCI 180°	0	0	0	DEFAULT
0	833		1	1269	30A/400V	0	0	0	DEFAULT
0	834		1	1270	5A/400V	0	0	0	DEFAULT
0	835		1	1271	20A/400V	0	0	0	DEFAULT
0	596		1	1272	LM2588T-5.0	0	0	0	DEFAULT
0	489		1	1273	IR2151	0	0	0	DEFAULT
0	844		1	1274	SN75176AP	0	0	0	DEFAULT
0	520		1	1275	SN75189AN	0	0	0	DEFAULT
0	849		1	1276	PCI 100mils 90° plástico	0	0	0	DEFAULT
0	851		1	1277	DIN41612	0	0	0	DEFAULT
0	852		1	1278	BC547B	0	0	0	DEFAULT
0	860		1	1279	100 nF	0	0	0	DEFAULT
0	861		1	1280	Parker 2017	0	0	0	DEFAULT
0	862		1	1281	Parker 2018	0	0	0	DEFAULT
0	866		1	1282	Parker 2022	0	0	0	DEFAULT
0	867		1	1283	Parker 2023	0	0	0	DEFAULT
0	868		1	1284	Parker 2027	0	0	0	DEFAULT
0	173		1	1285	Parker 2025	0	0	0	DEFAULT
0	863		1	1286	Parker 2019	0	0	0	DEFAULT
0	871		1	1287	OPA277U-ND	0	0	0	DEFAULT
0	876		1	1288	120pF	0	0	0	DEFAULT
40	1713	 859-LTST-C150EKT 	1	941	 LTST-C150EKT 	1	0	0	
40	1264	 926-LM3940IMP3.3NOPB 	1	964	 LM3940IMP-3.3/NOPB 	1	0	0	
0	377		1	1352	3.6864MHz Low Profile	0	0	0	DEFAULT
40	1702	187-CL31B105KAHNNNE	1	930	CL31B105KAHNNNE 	1	0	0	
40	99	603-RC0805JR-071KP	1	953	RC0805JR-071KP	1	0	0	
0	174		1	1289	Parker 2026	0	0	0	DEFAULT
0	836		1	1290	PCI	0	0	0	DEFAULT
0	859		1	1291	 Dissipador para TO-220 (30mm)	0	0	0	DEFAULT
0	882		1	1292	REG103GA-3.3	0	0	0	DEFAULT
0	484		1	1293	100mils Cinza	0	0	0	DEFAULT
0	817		1	1294	CI 20 pinos DIP torneado	0	0	0	DEFAULT
0	815		1	1295	CI 28 pinos DIP torneado	0	0	0	DEFAULT
0	814		1	1296	CI 28 pinos Longos DIP torneado	0	0	0	DEFAULT
0	816		1	1297	CI 40 pinos DIP torneado	0	0	0	DEFAULT
0	829		1	1298	CI 8 Pinos DIP	0	0	0	DEFAULT
0	921		1	1299	Fita crepe 19x50mm	0	0	0	DEFAULT
0	699		1	1300	2N2369 metal	0	0	0	DEFAULT
0	151		1	1301	Patola PB108	0	0	0	DEFAULT
0	920		1	1302	Super Bonder 3g	0	0	0	DEFAULT
0	854		1	1303	100mils Azul	0	0	0	DEFAULT
0	865		1	1304	Parker 2021	0	0	0	DEFAULT
0	923		1	1305	Parker 2029	0	0	0	DEFAULT
0	924		1	1306	Parker 2043	0	0	0	DEFAULT
0	927		1	1307	Graxazul 500g	0	0	0	DEFAULT
0	915		1	1308	1.6mm aço ráp.	0	0	0	DEFAULT
0	916		1	1309	1.5mm aço ráp.	0	0	0	DEFAULT
0	914		1	1310	2.2mm aço ráp.	0	0	0	DEFAULT
0	910		1	1311	0.8mm aço ráp.	0	0	0	DEFAULT
0	905		1	1312	10mm aço ráp.	0	0	0	DEFAULT
0	912		1	1313	1.0mm aço ráp.	0	0	0	DEFAULT
0	904		1	1314	12mm aço ráp.	0	0	0	DEFAULT
0	911		1	1315	1.2mm aço ráp.	0	0	0	DEFAULT
0	182		1	1316	1/2 pol aço ráp.	0	0	0	DEFAULT
0	908		1	1317	1/4 pol aço ráp.	0	0	0	DEFAULT
0	913		1	1318	2.5mm aço ráp.	0	0	0	DEFAULT
0	181		1	1319	3.6mm aço ráp.	0	0	0	DEFAULT
0	907		1	1320	5.0mm aço ráp.	0	0	0	DEFAULT
0	909		1	1321	5.5mm aço ráp.	0	0	0	DEFAULT
0	906		1	1322	6.5mm aço ráp.	0	0	0	DEFAULT
0	322		1	1323	Mini DIN 6 p Macho - DIN 5 p Fêmea	0	0	0	DEFAULT
0	723		1	1324	Header 5x2 PCI c/ Capa 90°	0	0	0	DEFAULT
0	724		1	1325	Header 7x2 PCI c/ Capa 90°	0	0	0	DEFAULT
0	943		1	1326	Header 7x2 PCI c/ Capa 180°	0	0	0	DEFAULT
0	944		1	1327	Header 8x2 PCI c/ Capa 180°	0	0	0	DEFAULT
0	945		1	1328	Minimal Due	0	0	0	DEFAULT
0	672		1	1329	330pF	0	0	0	DEFAULT
0	677		1	1330	220pF	0	0	0	DEFAULT
0	22		1	1331	27pF	0	0	0	DEFAULT
0	822		1	1332	Minimal Due 3 Vias Capa	0	0	0	DEFAULT
0	654		1	1333	200K	0	0	0	DEFAULT
0	783		1	1334	2.7V/400mW	0	0	0	DEFAULT
0	954		1	1335	Wire Wrapper	0	0	0	DEFAULT
0	955		1	1336	33R	0	0	0	DEFAULT
0	63		1	1337	100pF	0	0	0	DEFAULT
0	81		1	1338	DS36276M	0	0	0	DEFAULT
0	154		1	1339	DB9 Fêmea Cabo	0	0	0	DEFAULT
0	155		1	1340	DB9 Macho Cabo	0	0	0	DEFAULT
0	958		1	1341	200mA/30V Rearmável	0	0	0	DEFAULT
0	74		1	1342	130R	0	0	0	DEFAULT
0	75		1	1343	750R	0	0	0	DEFAULT
0	919		1	1344	Manga 4x26AWG	0	0	0	DEFAULT
0	961		1	1345	Jacaré Peq. Isol. Verm.	0	0	0	DEFAULT
0	962		1	1346	Jacaré Peq. Isol. Preta	0	0	0	DEFAULT
0	963		1	1347	Patola PB-211	0	0	0	DEFAULT
0	964		1	1348	Tomada 3 Pinos Macho Painel s/ aba	0	0	0	DEFAULT
0	966		1	1349	100R	0	0	0	DEFAULT
0	967		1	1350	10K	0	0	0	DEFAULT
0	404		1	1351	MOLEX 2.54mm	0	0	0	DEFAULT
0	980		1	1353	390R	0	0	0	DEFAULT
0	1010		1	1354	1K2	0	0	0	DEFAULT
0	983		1	1355	47R	0	0	0	DEFAULT
0	448		1	1356	100mils Preto	0	0	0	DEFAULT
0	649		1	1357	430R	0	0	0	DEFAULT
0	460		1	1358	Centronics Fêmea de 36 Pinos p/ Cabo	0	0	0	DEFAULT
0	1025		1	1359	3K3	0	0	0	DEFAULT
0	331		1	1360	1000uF/25V	0	0	0	DEFAULT
0	948		1	1361	TIP31C	0	0	0	DEFAULT
0	49		1	1362	LMC6061IN	0	0	0	DEFAULT
0	888		1	1363	750R	0	0	0	DEFAULT
0	327		1	1364	47uF/250V	0	0	0	DEFAULT
40	1703	 647-UWT1E471MNL1S 	1	931	UWT1E471MNL1GS 	1	0	0	
40	1726	 595-TPS54202DDCR 	1	965	 TPS54202DDCR 	1	0	0	
40	26	603-RC0805JR-101ML	1	954	RC0805JR-101ML	1	0	0	
0	1036		1	1437	FES16GT	0	0	0	DEFAULT
40	1714	859-LTST-C150KGKT	1	942	LTST-C150KGKT	1	0	0	
0	340		1	1365	10uF/250V	0	0	0	DEFAULT
0	823		1	1366	470uF/50V	0	0	0	DEFAULT
0	344		1	1367	470uF/25V	0	0	0	DEFAULT
0	329		1	1368	47uF/25V	0	0	0	DEFAULT
0	977		1	1369	39R	0	0	0	DEFAULT
0	978		1	1370	150K	0	0	0	DEFAULT
0	979		1	1371	6K8	0	0	0	DEFAULT
0	146		1	1372	330R	0	0	0	DEFAULT
0	982		1	1373	1K8	0	0	0	DEFAULT
0	984		1	1374	4R7	0	0	0	DEFAULT
0	986		1	1375	1K5	0	0	0	DEFAULT
0	987		1	1376	332R	0	0	0	DEFAULT
0	988		1	1377	75K	0	0	0	DEFAULT
0	989		1	1378	4K7	0	0	0	DEFAULT
0	990		1	1379	330R	0	0	0	DEFAULT
0	991		1	1380	1K	0	0	0	DEFAULT
0	992		1	1381	1K8	0	0	0	DEFAULT
0	993		1	1382	5R6	0	0	0	DEFAULT
0	994		1	1383	680R	0	0	0	DEFAULT
0	985		1	1384	10M	0	0	0	DEFAULT
0	995		1	1385	820R	0	0	0	DEFAULT
0	996		1	1386	220R	0	0	0	DEFAULT
0	936		1	1387	22K	0	0	0	DEFAULT
0	997		1	1388	3K9	0	0	0	DEFAULT
0	998		1	1389	10R	0	0	0	DEFAULT
0	999		1	1390	1K5	0	0	0	DEFAULT
0	1000		1	1391	3R3	0	0	0	DEFAULT
0	1001		1	1392	3K9	0	0	0	DEFAULT
0	1002		1	1393	20K	0	0	0	DEFAULT
0	1005		1	1394	180K	0	0	0	DEFAULT
0	1007		1	1395	560R	0	0	0	DEFAULT
0	1004		1	1396	4K99	0	0	0	DEFAULT
0	1008		1	1397	27R	0	0	0	DEFAULT
0	981		1	1398	270R	0	0	0	DEFAULT
0	150		1	1399	CI 16 pinos DIP torneado	0	0	0	DEFAULT
0	1014		1	1400	1R	0	0	0	DEFAULT
0	1015		1	1401	2K	0	0	0	DEFAULT
0	1016		1	1402	499R	0	0	0	DEFAULT
0	1017		1	1403	4R7	0	0	0	DEFAULT
0	72		1	1404	680R	0	0	0	DEFAULT
0	1018		1	1405	6R8	0	0	0	DEFAULT
0	1019		1	1406	12K	0	0	0	DEFAULT
0	1020		1	1407	8K2	0	0	0	DEFAULT
0	1021		1	1408	100R	0	0	0	DEFAULT
0	1022		1	1409	15R	0	0	0	DEFAULT
0	1023		1	1410	22R	0	0	0	DEFAULT
0	1024		1	1411	56R	0	0	0	DEFAULT
0	1026		1	1412	180K	0	0	0	DEFAULT
0	73		1	1413	68K	0	0	0	DEFAULT
0	1003		1	1414	1K	0	0	0	DEFAULT
0	1027		1	1415	200R	0	0	0	DEFAULT
0	1009		1	1416	470K	0	0	0	DEFAULT
0	701		1	1417	BF245C	0	0	0	DEFAULT
0	711		1	1418	BC327-16	0	0	0	DEFAULT
0	705		1	1419	BC337-40	0	0	0	DEFAULT
0	918		1	1420	BD135 isolado	0	0	0	DEFAULT
0	703		1	1421	BF245A	0	0	0	DEFAULT
0	709		1	1422	BF245B	0	0	0	DEFAULT
0	707		1	1423	BF494B	0	0	0	DEFAULT
0	1006		1	1424	5K6	0	0	0	DEFAULT
0	69		1	1425	1K	0	0	0	DEFAULT
0	71		1	1426	4K7	0	0	0	DEFAULT
0	70		1	1427	470R	0	0	0	DEFAULT
0	359		1	1428	100mm (aprox) Preta	0	0	0	DEFAULT
0	737		1	1429	100K	0	0	0	DEFAULT
0	750		1	1430	CR2430FP2	0	0	0	DEFAULT
0	428		1	1431	Flat Cable 7x2 Fêmea	0	0	0	DEFAULT
0	1031		1	1432	Barra de Pinos PCI 16p simples	0	0	0	DEFAULT
0	1032		1	1433	Barra de Pinos PCI 15p simples	0	0	0	DEFAULT
0	1033		1	1434	7 segmentos verm.	0	0	0	DEFAULT
0	1034		1	1435	SKR 21/08	0	0	0	DEFAULT
0	1035		1	1436	HFA15TB60	0	0	0	DEFAULT
0	1037		1	1438	MUR15-100	0	0	0	DEFAULT
0	1038		1	1439	MJ10008	0	0	0	DEFAULT
0	127		1	1440	2K (3296)	0	0	0	DEFAULT
0	1039		1	1441	200K (8714)	0	0	0	DEFAULT
0	1011		1	1442	39K	0	0	0	DEFAULT
0	1040		1	1443	10K (9441)	0	0	0	DEFAULT
0	1067		1	1444	Wire wrap 30AWG	0	0	0	DEFAULT
0	960		1	1445	Jacaré Média Preta	0	0	0	DEFAULT
0	1042		1	1446	Infravermelho (preto)	0	0	0	DEFAULT
0	1068		1	1447	Wire wrap 32AWG	0	0	0	DEFAULT
0	1043		1	1448	Amarelo	0	0	0	DEFAULT
40	1704	 80-C0805C103K1RACLR 	1	932	C0805C103K1RAC7411 	1	0	0	
40	1715	 859-LTST-C150KSKT 	1	943	 LTST-C150KSKT 	1	0	0	
40	1721	 667-ERA-6AEB1332V 	1	955	 ERA-6AEB1332V 	1	0	0	
40	1727	 815-ABM3B8MHZ101UT 	1	966	ABM3B-8.0-10-1UT	1	0	0	
0	1044		1	1449	TDA1520	0	0	0	DEFAULT
0	1045		1	1450	1K (3386)	0	0	0	DEFAULT
0	1046		1	1451	50K (8423)	0	0	0	DEFAULT
0	765		1	1452	0.22R	0	0	0	DEFAULT
0	1047		1	1453	TIPL763A	0	0	0	DEFAULT
0	959		1	1454	Jacaré Média Verm.	0	0	0	DEFAULT
0	1048		1	1455	10A Automotivo	0	0	0	DEFAULT
0	1049		1	1456	150nF/400V	0	0	0	DEFAULT
0	879		1	1457	BC558B	0	0	0	DEFAULT
0	1051		1	1458	0.05R	0	0	0	DEFAULT
0	1052		1	1459	Banana Plugue	0	0	0	DEFAULT
0	1084		1	1460	Araldite 15min 23g	0	0	0	DEFAULT
0	1053		1	1461	Banana borne	0	0	0	DEFAULT
0	1056		1	1462	2K2 linear	0	0	0	DEFAULT
0	1057		1	1463	15uH	0	0	0	DEFAULT
0	1059		1	1464	200uH	0	0	0	DEFAULT
0	1061		1	1466	Carretel E25	0	0	0	DEFAULT
0	1062		1	1467	Carretel E30/14	0	0	0	DEFAULT
0	1064		1	1468	BD236	0	0	0	DEFAULT
0	1065		1	1469	47uF/100V	0	0	0	DEFAULT
0	1066		1	1470	10uF/63V	0	0	0	DEFAULT
0	974		1	1471	Centronics Fêmea de 36 Pinos CAPA	0	0	0	DEFAULT
0	946		1	1472	Mini DIN 6 pinos Fêmea PCI 90°	0	0	0	DEFAULT
0	317		1	1473	P2 ou P4 Plug	0	0	0	DEFAULT
0	365		1	1474	Telefone 4/4 Macho Cabo	0	0	0	DEFAULT
0	872		1	1475	TPS3705-33DGNR	0	0	0	DEFAULT
0	571		1	1476	M3 x 8mm Cabeça Cônica Allen	0	0	0	DEFAULT
0	1076		1	1477	M4 Inox	0	0	0	DEFAULT
0	1070		1	1478	39K	0	0	0	DEFAULT
0	738		1	1479	1K	0	0	0	DEFAULT
0	676		1	1480	39K	0	0	0	DEFAULT
0	917		1	1481	M3 x 30mm Inox Fenda Chata	0	0	0	DEFAULT
0	1153		1	1482	Plástico M3 x 3mm	0	0	0	DEFAULT
0	339		1	1483	10uF/25V	0	0	0	DEFAULT
0	1157		1	1484	Alongador-teclas-SIMAD	0	0	0	DEFAULT
0	1162		1	1485	25K	0	0	0	DEFAULT
0	328		1	1486	4.7uF/100V	0	0	0	DEFAULT
0	1146		1	1487	M2	0	0	0	DEFAULT
0	108		1	1488	Amarelo 5mm	0	0	0	DEFAULT
0	1167		1	1489	M2	0	0	0	DEFAULT
0	818		1	1490	AS1RC2-12V	0	0	0	DEFAULT
0	1174		1	1491	De-15mm  Di-5mm	0	0	0	DEFAULT
0	78		1	1492	DB9 Fêmea PCI 15mm	0	0	0	DEFAULT
0	718		1	1493	LCD 16x2 com Backlight	0	0	0	DEFAULT
0	572		1	1494	M3 x 6mm Philips	0	0	0	DEFAULT
0	1170		1	1495	10mm	0	0	0	DEFAULT
0	1171		1	1496	De-10mm Di 3mm	0	0	0	DEFAULT
0	1172		1	1497	De-13mm  Di- 4.5mm 	0	0	0	DEFAULT
0	1173		1	1498	De-18mm  Di-7mm	0	0	0	DEFAULT
0	1175		1	1499	De-20mm Di-10mm	0	0	0	DEFAULT
0	1176		1	1500	Pressão De-18mm Di-10mm	0	0	0	DEFAULT
0	1177		1	1501	De-13mm  Di-6mm	0	0	0	DEFAULT
0	1178		1	1502	Pressão M3	0	0	0	DEFAULT
0	1028		1	1503	Chave Allen 2mm	0	0	0	DEFAULT
0	1030		1	1504	Chave Fenda 1mm	0	0	0	DEFAULT
0	925		1	1505	Desandador para macho M2 até M4	0	0	0	DEFAULT
0	179		1	1506	M2x0.4 Aço Rápido	0	0	0	DEFAULT
0	926		1	1507	M3x0.5 Aço Liga	0	0	0	DEFAULT
0	180		1	1508	M3x0.5 Aço Rápido	0	0	0	DEFAULT
0	1179		1	1509	M3 Plástico h=8mm	0	0	0	DEFAULT
0	1169		1	1510	M2 x 10mm Fenda	0	0	0	DEFAULT
0	1212		1	1511	M3 x 10mm Cabeça Cônica Philips Inox	0	0	0	DEFAULT
0	1229		1	1512	TIP32C	0	0	0	DEFAULT
0	1180		1	1513	M2 x 8mm Fenda	0	0	0	DEFAULT
0	1181		1	1514	M2 x 5mm Fenda	0	0	0	DEFAULT
0	1182		1	1515	M2 x 12mm Fenda	0	0	0	DEFAULT
0	1185		1	1516	M3 x 25mm Cabeça Cônica Philips	0	0	0	DEFAULT
0	1225		1	1517	Flat Cable 8x2 Fêmea	0	0	0	DEFAULT
0	1184		1	1518	M3 x 30mm Cabeça Cônica Fenda	0	0	0	DEFAULT
0	1230		1	1519	1A 250V	0	0	0	DEFAULT
0	1231		1	1520	2mm x 10mm	0	0	0	DEFAULT
0	1232		1	1521	1,5mm x 10mm	0	0	0	DEFAULT
0	1186		1	1522	M3 x 20mm Cabeça Cônica Fenda	0	0	0	DEFAULT
0	1242		1	1523	100R (3006)	0	0	0	DEFAULT
0	1187		1	1524	M3 x 25mm Cabeça Cônica Fenda Inox	0	0	0	DEFAULT
0	1215		1	1525	2k (3006)	0	0	0	DEFAULT
40	1705	 667-EEE-1EA220WR 	1	933	 667-EEE-1EA220WR 	1	0	0	
40	1722	 667-ERA-6AEB104V 	1	956	 ERA-6AEB104V 	1	0	0	
40	1657	 661-EKHE401L470MJ40S 	1	884	EKHE401ELL470MJ40S	0	0	0	
2	88	1014013	1	203	MM74HCT541WM	11	0	0	
2	88	1085319	1	509	74HCT541D	4	0	0	
0	1376		1	1588	MBRS340T3G	0	0	0	DEFAULT
0	1377		1	1589	FDS6900AS	0	0	0	DEFAULT
0	1378		1	1590	FDS9435A	0	0	0	DEFAULT
40	1716	771-BC807-40-T/R	1	944	BC807-40,215	1	0	0	
0	1188		1	1526	M3 x 30mm Philips Inox	0	0	0	DEFAULT
0	1189		1	1527	M3 x 16mm Cabeça Cônica Fenda	0	0	0	DEFAULT
0	1190		1	1528	M3 X 20mm Philips Inox	0	0	0	DEFAULT
0	1233		1	1529	RJ-45 low profile	0	0	0	DEFAULT
0	1191		1	1530	M3 x 16mm Cabeça Cônica Philips Inox	0	0	0	DEFAULT
0	1192		1	1531	M3 x 8mm Fenda	0	0	0	DEFAULT
0	1193		1	1532	M3 x 6mm  Allen	0	0	0	DEFAULT
0	1194		1	1533	M3 x 16mm Allen 	0	0	0	DEFAULT
0	1234		1	1534	RJ-11 6pinos	0	0	0	DEFAULT
0	1195		1	1535	M5 x 25mm Fenda	0	0	0	DEFAULT
0	1235		1	1536	RJ-11 4 pinos	0	0	0	DEFAULT
0	1196		1	1537	M3 x 10mm Fenda Inox	0	0	0	DEFAULT
0	1197		1	1538	M3 x 30mm Fenda Inox	0	0	0	DEFAULT
0	1198		1	1539	M2 x 16mm Fenda	0	0	0	DEFAULT
0	1199		1	1540	M5	0	0	0	DEFAULT
0	1200		1	1541	M3 Preta	0	0	0	DEFAULT
0	1183		1	1542	M3 x 20mm Fenda	0	0	0	DEFAULT
0	1168		1	1543	M2 x 6mm Fenda	0	0	0	DEFAULT
0	1222		1	1544	Dupla 090° PCI 04 Pinos	0	0	0	DEFAULT
0	1201		1	1545	1.5mm 	0	0	0	DEFAULT
0	1202		1	1546	2.0mm aço ráp	0	0	0	DEFAULT
0	1223		1	1547	Simples 180° PCI 30 Pinos	0	0	0	DEFAULT
0	1203		1	1548	2.5mm aço ráp	0	0	0	DEFAULT
0	1204		1	1549	3.5mm aço ráp	0	0	0	DEFAULT
0	1205		1	1550	4.0mm aço ráp	0	0	0	DEFAULT
0	1206		1	1551	4.5mm aço ráp	0	0	0	DEFAULT
0	1207		1	1552	4.8mm aço ráp	0	0	0	DEFAULT
0	1208		1	1553	5.0mm aço ráp	0	0	0	DEFAULT
0	1216		1	1554	Simples 180° PCI 02 Pinos	0	0	0	DEFAULT
0	1209		1	1555	5.5mm aço ráp	0	0	0	DEFAULT
0	1210		1	1556	6.0mm aço ráp	0	0	0	DEFAULT
0	1211		1	1557	6.5mm aço ráp	0	0	0	DEFAULT
0	1220		1	1558	Dupla 180° PCI 14 Pinos	0	0	0	DEFAULT
0	1219		1	1559	Dupla 180° PCI  10 Pinos	0	0	0	DEFAULT
0	1221		1	1560	Dupla 180° PCI 16 Pinos	0	0	0	DEFAULT
0	1243		1	1561	OPA340NA	0	0	0	DEFAULT
0	1244		1	1562	OPA340UA	0	0	0	DEFAULT
0	406		1	1563	Sindal 10mm²	0	0	0	DEFAULT
0	576		1	1564	Sindal 22mm²	0	0	0	DEFAULT
0	405		1	1565	Sindal 6mm²	0	0	0	DEFAULT
0	1247		1	1566	Header PCI Fêmea 16x1	0	0	0	DEFAULT
0	809		1	1567	1N5822	0	0	0	DEFAULT
0	1263		1	1568	XC05XL-4VOG100C	0	0	0	DEFAULT
0	1055		1	1569	18K PR03	0	0	0	DEFAULT
0	903		1	1570	82R PR03	0	0	0	DEFAULT
0	1307		1	1571	100R	0	0	0	DEFAULT
0	1337		1	1572	560R	0	0	0	DEFAULT
0	1346		1	1573	74HCT244	0	0	0	DEFAULT
0	1494		1	1574	null	0	0	0	DEFAULT
0	1218		1	1575	01x04 (04 vias)	0	0	0	DEFAULT
0	1348		1	1576	330R	0	0	0	DEFAULT
0	1349		1	1577	220nF	0	0	0	DEFAULT
0	1357		1	1578	220uH/1A	0	0	0	DEFAULT
0	1367		1	1579	DCP021212	0	0	0	DEFAULT
0	1368		1	1580	Simples 90o PCI 8 Pinos	0	0	0	DEFAULT
0	1369		1	1581	74HC595	0	0	0	DEFAULT
0	1370		1	1582	82C55	0	0	0	DEFAULT
0	1371		1	1583	74HC165	0	0	0	DEFAULT
0	1372		1	1584	Flat Cabe 10x2 Fêmea	0	0	0	DEFAULT
0	1373		1	1585	74HC4017	0	0	0	DEFAULT
0	1374		1	1586	74HCT138	0	0	0	DEFAULT
0	1375		1	1587	74HCT688	0	0	0	DEFAULT
0	1381		1	1591	PC104 20x2 40 pinos	0	0	0	DEFAULT
0	1380		1	1592	PC104 32x2 64 pinos	0	0	0	DEFAULT
0	1382		1	1593	82C54	0	0	0	DEFAULT
0	1383		1	1594	PLCC 44 pinos	0	0	0	DEFAULT
0	1384		1	1595	PLCC 28 pinos	0	0	0	DEFAULT
0	1385		1	1596	PLCC 44 pinos SMD	0	0	0	DEFAULT
0	1386		1	1597	74HCT32	0	0	0	DEFAULT
0	1391		1	1598	27R	0	0	0	DEFAULT
0	1392		1	1599	Simples 28 pinos PCI	0	0	0	DEFAULT
0	1393		1	1600	Simples 6 pinos PCI	0	0	0	DEFAULT
40	1706	CL21B224KAFNNNG 	1	934	 187-CL21B224KAFNNNG 	1	0	0	
2	1293	75C0844	1	514	LM358AD	1	0	0	
40	1723	71-CRCW080549R9FKEAC	10	957	CRCW080549R9FKEAC	0	0	0	
40	1717	781-SI2300DS-T1-GE3	1	945	SI2300DS-T1-GE3	1	0	0	
0	1394		1	1601	null	0	0	0	DEFAULT
0	1397		1	1602	1.2nF	0	0	0	DEFAULT
0	1398		1	1603	130R	0	0	0	DEFAULT
0	1399		1	1604	LMC6062AIM	0	0	0	DEFAULT
0	1404		1	1605	BC807-16	0	0	0	DEFAULT
0	1406		1	1606	EXCML32A608U	0	0	0	DEFAULT
0	1407		1	1607	50K	0	0	0	DEFAULT
0	1408		1	1608	1K8 0.25W	0	0	0	DEFAULT
0	1409		1	1609	TLC272CD	0	0	0	DEFAULT
0	1410		1	1610	LM385M3 - 2.5	0	0	0	DEFAULT
0	1457		1	1611	IRF8010	0	0	0	DEFAULT
0	1411		1	1612	HCPL2631	0	0	0	DEFAULT
0	1412		1	1613	IRFZ34N	0	0	0	DEFAULT
0	1458		1	1614	IRFZ24	0	0	0	DEFAULT
0	1459		1	1615	7915	0	0	0	DEFAULT
0	1413		1	1616	teste nome 3	0	0	0	DEFAULT
0	1460		1	1617	LM285Z-2.5	0	0	0	DEFAULT
0	1461		1	1618	BC847 SMD	0	0	0	DEFAULT
0	1462		1	1619	BC857 SMD	0	0	0	DEFAULT
0	1416		1	1620	MCP4922	0	0	0	DEFAULT
0	1417		1	1621	IRG4PC50UD	0	0	0	DEFAULT
0	1423		1	1622	27R	0	0	0	DEFAULT
0	1449		1	1623	1nF/50V	0	0	0	DEFAULT
0	1450		1	1624	4,7nF/50V	0	0	0	DEFAULT
0	1451		1	1625	10nF/400V	0	0	0	DEFAULT
0	1453		1	1626	220nF/400V	0	0	0	DEFAULT
0	1454		1	1627	BTA26-600B	0	0	0	DEFAULT
0	1455		1	1628	IRF530N	0	0	0	DEFAULT
0	1456		1	1629	RFP15N05L	0	0	0	DEFAULT
0	1463		1	1630	BC857BLT1 SMD	0	0	0	DEFAULT
0	1464		1	1631	3V3	0	0	0	DEFAULT
0	1465		1	1632	15V	0	0	0	DEFAULT
0	1471		1	1633	MC14011BCP	0	0	0	DEFAULT
0	1474		1	1634	15V/500mW	0	0	0	DEFAULT
0	1475		1	1635	18V/1W	0	0	0	DEFAULT
0	1473		1	1636	1N5819	0	0	0	DEFAULT
0	1476		1	1637	BYV27-200	0	0	0	DEFAULT
0	1477		1	1638	BYV28-200	0	0	0	DEFAULT
0	1478		1	1639	MUR420	0	0	0	DEFAULT
0	1484		1	1640	KA3525A	0	0	0	DEFAULT
0	1485		1	1641	220K	0	0	0	DEFAULT
0	1486		1	1642	DIP torneado	0	0	0	DEFAULT
0	1041		1	1643	Infravermelho (vinho)	0	0	0	DEFAULT
0	1491		1	1644	2.2uF 20V SMD	0	0	0	DEFAULT
0	1492		1	1645	Header Box 8x2 90graus	0	0	0	DEFAULT
0	1493		1	1646	Resistor SMD 1206 5%	0	0	0	DEFAULT
0	1495		1	1647	Minimal due 5 vias capa	0	0	0	DEFAULT
0	1496		1	1648	Minimal due 1 via capa	0	0	0	DEFAULT
0	1402		1	1649	AM26LS32ACD	0	0	0	DEFAULT
0	1365		1	1650	01x05 (05 vias)	0	0	0	DEFAULT
0	1498		1	1651	DCP010515BP	0	0	0	DEFAULT
0	147		1	1652	100mils c/ Aba Preto	0	0	0	DEFAULT
0	1526		1	1653	TLC277CDR	0	0	0	DEFAULT
0	1527		1	1654	TLC279CD	0	0	0	DEFAULT
0	1528		1	1655	10uH Murata 82103C	0	0	0	DEFAULT
0	1529		1	1656	IRFP2907Z	0	0	0	DEFAULT
0	1530		1	1657	BUZ334	0	0	0	DEFAULT
0	1531		1	1658	TIC263D	0	0	0	DEFAULT
0	1532		1	1659	TIC246D	0	0	0	DEFAULT
0	1533		1	1660	FGH60N60	0	0	0	DEFAULT
0	1534		1	1661	FAN73912	0	0	0	DEFAULT
0	1535		1	1662	IR2110	0	0	0	DEFAULT
0	1536		1	1663	HCPL316J	0	0	0	DEFAULT
0	1538		1	1664	G4PF50WD	0	0	0	DEFAULT
0	1539		1	1665	ACS752	0	0	0	DEFAULT
0	1541		1	1666	TL081CP	0	0	0	DEFAULT
0	1546		1	1667	LM565CN	0	0	0	DEFAULT
0	1552		1	1668	A1120	0	0	0	DEFAULT
0	1553		1	1669	HEF4049BT	0	0	0	DEFAULT
0	1556		1	1670	ACS708T	0	0	0	DEFAULT
0	1559		1	1671	ACS758ECB-200U-PFF-T	0	0	0	DEFAULT
0	1537		1	1672	ACS758ECB-200B-PFF-T	0	0	0	DEFAULT
1	1480		1	825	LM393N	1	0	0	
0	1560		1	1673	A1104	0	0	0	DEFAULT
0	1557		1	1674	74HC04	0	0	0	DEFAULT
0	1549		1	1675	74HCT244D	0	0	0	DEFAULT
0	1555		1	1676	SN75LBC031D	0	0	0	DEFAULT
0	1550		1	1677	SN74HCT00N	0	0	0	DEFAULT
0	1547		1	1678	SN74HC541N	0	0	0	DEFAULT
1	1389		1	826	LT1013CP	1	0	0	
40	199	0805N470J500CT 	1	935	 791-0805N470J500CT 	1	0	0	
40	1718	 279-CRGH1206J120R 	1	946	CRGH1206J120R 	1	0	0	
40	1724	 595-AM26C31IDR 	1	958	 AM26C31IDR 	1	0	0	
1	92		1	700	LL4148	1	0	0	
3	92		1	172		1	0	0	
40	1688	 594-MCT0603MD1003DP5 	1	914	MCT0603MD1003DP500	0	0	0	
40	1690	 710-560112116044 	1	916	560112116044	0	0	0	
40	1693	 71-CRCW06031K00JNEBC 	1	919	CRCW06031K00JNEBC	0	0	0	
40	1689	 603-AF0603FR-0734KL 	1	915	AF0603FR-0734KL	0	0	0	
40	1695	 603-AF0603FR-0736KL	1	921	AF0603FR-0736KL	0	0	0	
40	1692	 71-CRCW12060000Z0EAH 	1	918	CRCW12060000Z0EAHP	0	0	0	
40	1691	 71-RCS12063R30FKEA 	1	917	RCS12063R30FKEA	0	0	0	
40	1694	 71-RCS12064R70JNEA 	1	920	RCS12064R70JNEA	0	0	0	
0	1543		1	1679	SN74HC540N	0	0	0	DEFAULT
0	1542		1	1680	SN74221N	0	0	0	DEFAULT
0	1561		1	1681	HCF4049UBE	0	0	0	DEFAULT
1	493		1	568	LM741CN	1	0	0	
1	493		1	569	CA741CE	1	0	0	
1	493		1	570	UA741CN	1	0	0	
1	9		1	571	MAX232CPE	1	0	0	
1	9		1	572	MAX232N	1	0	0	
1	444		1	573	LM7905C	1	0	0	
1	444		1	574	SD7905C	1	0	0	
1	249		1	575	NE555N	1	0	0	
1	249		1	576	SDA555CE	1	0	0	
1	249		1	577	LM555CN	1	0	0	
1	9		1	578	HIN232CP	1	0	0	
1	9		1	579	ST232CN	1	0	0	
1	474		1	580	CD74HC04E	1	0	0	
1	474		1	581	SN74HC04N	1	0	0	
1	474		1	582	74HC04N	1	0	0	
1	228		1	583	DM74LS14N	1	0	0	
1	228		1	584	GD74LS14	1	0	0	
1	220		1	585	MM74HC14N	1	0	0	
1	220		1	586	SN74HC14E	1	0	0	
1	220		1	587	SN74HC14N	1	0	0	
1	243		1	588	SN74LS373N	1	0	0	
1	243		1	589	T74LS373BI	1	0	0	
1	122		1	590	MM74HC4040M	1	0	0	
1	258		1	591	CD40106BCN	1	0	0	
1	612		1	592	CD40107BE	1	0	0	
1	518		1	593	CD4015	1	0	0	
1	551		1	594	CD4017BE	1	0	0	
1	552		1	595	CD4040	1	0	0	
1	495		1	596	CD4071BCN	1	0	0	
1	265		1	597	CD4093B	1	0	0	
1	265		1	598	CD4093BCN	1	0	0	
1	527		1	599	CD4099BCN	1	0	0	
1	279		1	600	GD4049B	1	0	0	
1	265		1	601	GD4093B	1	0	0	
1	254		1	602	HCF40109BE	1	0	0	
1	253		1	603	HCF4046BE	1	0	0	
1	560		1	604	HCF4066BE	1	0	0	
1	269		1	605	HEF4001BP	1	0	0	
1	258		1	606	HEF40106BP	1	0	0	
1	253		1	607	HEF4046BP	1	0	0	
1	279		1	608	HEF4049BP	1	0	0	
1	500		1	609	HEF4070BE	1	0	0	
1	219		1	610	HEF4081BP	1	0	0	
1	265		1	611	HEF4093BP	1	0	0	
1	528		1	612	MC14024BCP	1	0	0	
1	269		1	613	SD4001BE	1	0	0	
1	258		1	614	SD40106BE	1	0	0	
1	279		1	615	SD4049UBE	1	0	0	
1	552		1	616	TC4040BP	1	0	0	
1	589		1	617	74AC00PC	1	0	0	
1	224		1	618	74HC138N	1	0	0	
1	225		1	619	74HC374N	1	0	0	
1	442		1	620	74HCT04N	1	0	0	
1	598		1	621	74LS164PC	1	0	0	
1	692		1	622	74VHC08N	1	0	0	
1	524		1	623	74VHC138N	1	0	0	
1	691		1	624	74VHC14N	1	0	0	
1	715		1	625	74VHC245N	1	0	0	
1	690		1	626	74VHC32N	1	0	0	
1	582		1	627	74VHC541N	1	0	0	
1	498		1	628	74VHC574N	1	0	0	
1	554		1	629	CD74HC02E	1	0	0	
0	1562		1	1682	M74HC11B1	0	0	0	DEFAULT
0	1554		1	1683	CD4050BE	0	0	0	DEFAULT
0	1540		1	1684	CD4093BE	0	0	0	DEFAULT
0	1564		1	1685	14093B	0	0	0	DEFAULT
0	1565		1	1686	232CB	0	0	0	DEFAULT
0	1566		1	1687	TLC271CD	0	0	0	DEFAULT
0	1567		1	1688	ACS712T	0	0	0	DEFAULT
1	590		1	630	CD74HC132E	1	0	0	
1	562		1	631	CD74HC139E	1	0	0	
1	246		1	632	DM74ALS373BN	1	0	0	
1	485		1	633	DM74ALS541N	1	0	0	
1	223		1	634	DM74ALS573BN	1	0	0	
1	501		1	635	GD74LS06	1	0	0	
1	593		1	636	GD74LS07	1	0	0	
1	564		1	637	HD74LS04P	1	0	0	
1	641		1	638	M74ALS574P	1	0	0	
1	236		1	639	M74HC166BI	1	0	0	
1	592		1	640	M74HC245BI	1	0	0	
1	478		1	641	M74LS86P	1	0	0	
1	251		1	642	MM74HC374N	1	0	0	
1	476		1	643	MC74HC368N	1	0	0	
1	597		1	644	MM74HC191N	1	0	0	
1	216		1	645	MM74HC74AN	1	0	0	
1	640		1	646	SN74ALS244BN	1	0	0	
1	580		1	647	SN74HC02N	1	0	0	
1	231		1	648	SD74LS08D	1	0	0	
1	591		1	649	SN7407N	1	0	0	
1	530		1	650	MM74HC368N	1	0	0	
1	238		1	651	PC74HC688P	1	0	0	
1	261		1	652	SD74LS08E	1	0	0	
1	280		1	653	SD74LS138E	1	0	0	
1	237		1	654	SD74LS164E	1	0	0	
1	588		1	655	SD74LS245E	1	0	0	
1	521		1	656	SD74LS32E	1	0	0	
1	510		1	657	SN7406N	1	0	0	
1	481		1	658	SN7420N	1	0	0	
1	607		1	659	SN74HC541N	1	0	0	
1	472		1	660	SN74LS122N	1	0	0	
1	215		1	661	SN74LS161AN	1	0	0	
1	230		1	662	SN74LS221N	1	0	0	
1	221		1	663	SN74LS323N	1	0	0	
1	633		1	664	SN74LS592N	1	0	0	
1	843		1	665	SN74LS684N	1	0	0	
1	559		1	666	T74LS02BI	1	0	0	
1	222		1	667	T74LS244BI	1	0	0	
1	284		1	668	74HC4051D	1	0	0	
1	438		1	669	74HC4052D	1	0	0	
1	184		1	670	74HCT138D	1	0	0	
1	113		1	671	74HCT574D	1	0	0	
1	77		1	672	MM74HC14M	1	0	0	
1	183		1	674	MM74HC541WM	1	0	0	
1	700		1	675	PN2222A	1	0	0	
1	710		1	676	KTA2907A	1	0	0	
1	878		1	677	PH2369	1	0	0	
1	555		1	678	AN7808	1	0	0	
1	555		1	679	MC7808CT	1	0	0	
1	247		1	680	GL324	1	0	0	
1	273		1	681	GL393	1	0	0	
1	558		1	682	KA3845A	1	0	0	
1	256		1	683	L7908CV	1	0	0	
1	213		1	684	KA7805	1	0	0	
1	213		1	685	L7805CV	1	0	0	
1	727		1	686	L7812CV	1	0	0	
1	234		1	687	LM311N	1	0	0	
1	273		1	688	LM393E	1	0	0	
1	273		1	689	LM393P	1	0	0	
1	259		1	690	WL431	1	0	0	
1	726		1	691	TSL7912CV	1	0	0	
1	247		1	692	CA324E	1	0	0	
1	234		1	693	LM311P	1	0	0	
1	244		1	694	MC14538BCP	1	0	0	
1	558		1	695	UC3845	1	0	0	
1	698		1	698	2N2906A	1	0	0	
1	698		1	699	2N2907A	1	0	0	
1	947		1	701	1N4752	1	0	0	
1	791		1	702	1N4728AC	1	0	0	
1	792		1	703	1N4729AC	1	0	0	
1	802		1	704	1N4734A	1	0	0	
1	811		1	705	1N4735	1	0	0	
1	795		1	706	1N4742	1	0	0	
1	793		1	707	1N4744	1	0	0	
1	794		1	708	1N759A	1	0	0	
1	784		1	709	1N967B	1	0	0	
1	803		1	710	79C4V7	1	0	0	
1	811		1	711	85C6V2	1	0	0	
1	807		1	712	BZX79C51	1	0	0	
1	804		1	713	BZV85C13V	1	0	0	
1	804		1	714	C13P	1	0	0	
1	785		1	715	C4V3PH	1	0	0	
1	678		1	716	BZV55-C3V9	1	0	0	
1	949		1	717	BZX84C3V9	1	0	0	
1	950		1	718	BZV84C5V6	1	0	0	
1	97		1	719	 BZV55C12 	1	0	0	
1	1054		1	720	L7815CV	1	0	0	
1	1122		1	721	1N4745	1	0	0	
1	1122		1	722	BZX85-C16	1	0	0	
1	848		1	723	BZX84C3V9	1	0	0	
1	1261		1	724	74HC04D	1	0	0	
1	1319		1	727	74HCT139D	1	0	0	
2	1305	45J0744	1	732	LM324DG	10	0	0	
2	1339	1097187	1	736	BZV55-C15	1	0	0	
3	93	1166030	1	111		1	0	0	
2	1341	83H7851	1	737		1	0	0	
2	125	06F9447	1	733		1	0	0	
2	1342	1201320	1	738	74HC138D	4	0	0	
2	242	63J7870	1	734	IR2121PBF	12	0	0	
3	417		1	182		3	0	0	
2	11	787-139	1	1		1	0	0	
5	203		1	83		1	0	0	
2	934	420-890	1	144		1	0	0	
2	208	151-794	1	145		1	0	0	
32	135	MC 1.5/3-G-3.5	1	284		1	0	0	
32	136	MC 1.5/4-G-3.81	1	285		1	0	0	
3	397	5274-05A	1	421		1	0	0	
2	1329	41K2616	1	550	LMC6062IM/NOPB	3	0	0	
2	1260	88H7776	1	462	HCPL-0601-000E	7	0	0	
2	1333	88H7787	1	557	HCPL-0631-000E	7	0	0	
2	1336	9589708	1	564	LT1004ID-1-2G4	2	0	0	
2	1332	9589694	1	555	LT1004CD-2-5	2	0	0	
2	1330	8455210	1	551	TLV2553IDW	2	0	0	
2	1119	1400719	1	556	RN73H2BTTD1200B25	9	0	0	
2	1108	1400806	1	553	RN73H2BTTD2203B25	9	0	0	
2	1108	3089587	5	360		1	0	0	
2	115	1081221	10	560	BC807-25	4	0	0	
2	965	9558608	1	561	BC817-25LT1G	10	0	0	
2	1331	1400711	1	554	KOA RN73H2BTTD56R0B25	1	0	0	
2	98	420-177	1	2		1	0	0	
2	97	305-0774	1	3		1	0	0	
2	65	752-022	1	4		1	0	0	
2	66	752-010	1	5		1	0	0	
2	125	411-206	1	6		1	0	0	
2	122	379-633	1	7		1	0	0	
2	119	369-767	1	8		1	0	0	
2	123	249-890	1	9		1	0	0	
2	177	3047787	1	11		1	0	0	
10	191	4 1/2	1	12		1	0	0	
10	192	1 1/2	1	13		1	0	0	
10	193	40mm PVC	1	14		1	0	0	
2	1270	1220984	1	479		1	0	0	
12	196	sc5-2	1	15		1	0	0	
12	201	CH24-5	1	16		1	0	0	
2	77	379-268	1	18		1	0	0	
2	178	249-415	1	20		1	0	0	
10	209	Parker 2029	1	21		1	0	0	
2	101	420-359	1	22		1	0	0	
12	187	FS 5/30	1	23		1	0	0	
2	207	421-560	1	24		1	0	0	
12	200	FS 8/65	1	25		1	0	0	
2	23	109-299	50	26		1	0	0	
2	25	109-325	50	27		1	0	0	
2	51	411-220	1	28		1	0	0	
2	211	109-325	50	29		1	0	0	
2	46	411-681	1	31		1	0	0	
2	284	492-140	1	33		1	0	0	
2	10	787-115	1	35		1	0	0	
2	443	348-302	1	37		1	0	0	
2	95	912-098	50	38		1	0	0	
2	646	911-616	50	41		1	0	0	
2	116	911-987	50	43		1	0	0	
2	1	911-628	50	44		1	0	0	
2	728	912-116	50	45		1	0	0	
2	160	912-128	50	46		1	0	0	
2	653	912-001	50	47		1	0	0	
2	644	911-860	50	49		1	0	0	
2	664	911-872	50	50		1	0	0	
2	27	912-130	50	52		1	0	0	
2	28	912-013	50	54		1	0	0	
2	685	912-141	50	55		1	0	0	
2	657	912-025	50	57		1	0	0	
2	651	911-665	50	58		1	0	0	
2	643	911-896	50	59		1	0	0	
2	29	912-153	50	61		1	0	0	
2	112	911-793	50	62		1	0	0	
2	142	912-037	50	63		1	0	0	
2	30	912-165	50	64		1	0	0	
2	661	911-800	50	65		1	0	0	
2	114	911-914	50	66		1	0	0	
1	92		1	725	PMLL4148L	1	0	0	
2	99	911-859	50	48		1	0	0	
2	660	911-781	50	56		1	0	0	
2	656	911-926	50	67		1	0	0	
2	688	912-177	50	68		1	0	0	
2	645	911-823	50	71		1	0	0	
2	650	912-062	50	72		1	0	0	
2	100	911-835	50	73		1	0	0	
2	118	911-719	50	74		1	0	0	
2	686	109-315	50	75		1	0	0	
2	681	109-316	50	76		1	0	0	
2	34	912-384	50	77		1	0	0	
2	642	420-797	50	79		1	0	0	
2	668	419-898	50	80		1	0	0	
2	442	381-780	1	82		1	0	0	
3	551		1	84		1	0	0	
2	551	573-656	1	85		1	0	0	
3	120		1	86		1	0	0	
3	445		1	89		1	0	0	
3	105		1	90		1	0	0	
3	444		1	91		1	0	0	
3	552		1	92		1	0	0	
2	552	573-681	1	93		1	0	0	
3	439		1	94		1	0	0	
3	432		1	95		1	0	0	
3	94		1	96		1	0	0	
3	537		1	97		1	0	0	
3	435		1	98		1	0	0	
3	431		1	99		1	0	0	
2	1334	1085249	1	558	NXP 74HC1G00GW	1	0	0	
2	839	77C0815	1	562		1	0	0	
2	1335	07B5609	1	563	NSC LMC6061IM	1	0	0	
2	1338	9236767	50	565		1	0	0	
5	8		1	100		1	0	0	
5	18		1	101		1	0	0	
2	461	911-926	1	102		1	0	0	
5	19		1	103		1	0	0	
2	451	361-951	1	104		1	0	0	
2	838	348-302	1	105		1	0	0	
11	44		1	106		1	0	0	
5	56		1	107		1	0	0	
3	197		1	109		1	0	0	
3	62		1	110		1	0	0	
3	91		1	112		1	0	0	
3	76		1	113		1	0	0	
2	2	911-744	50	42		1	0	0	
2	106	911-902	50	60		1	0	0	
3	206		1	114		1	0	0	
3	9		1	115		1	0	0	
3	17		1	116		1	0	0	
3	162		1	118		1	0	0	
15	41		1	120		1	0	0	
15	42		1	121		1	0	0	
6	138		1	122		1	0	0	
16	138		1	123		1	0	0	
14	170		1	124		1	0	0	
3	161		1	125		1	0	0	
3	205		1	126		1	0	0	
10	176		1	127		1	0	0	
3	451		1	128		1	0	0	
3	208	KRE-2	1	130		1	0	0	
3	165	KRE-3	1	131		1	0	0	
2	928	420-815	1	132		1	0	0	
3	33		1	133		1	0	0	
2	929	420-384	1	134		1	0	0	
3	213	7805	1	135		1	0	0	
2	930	420-542	1	136		1	0	0	
2	931	420-657	1	137		1	0	0	
3	430		1	138		1	0	0	
2	932	420-864	1	139		1	0	0	
2	933	420-888	1	140		1	0	0	
2	33	643-660	1	141		1	0	0	
2	153	643-683	1	142		1	0	0	
2	76	643-646	1	143		1	0	0	
2	145	1085255	1	10	NXP 74HC1G32GW 	1	0	0	
2	144	3025913	1	30	PHILIPS 74HC1G08GW 	1	0	0	
2	285	71J5469	1	34	ONSEMI MC14049UBDG	1	0	0	
2	282	71J5481	1	32	MC14093BDG	1	0	0	
2	837	71J5472	1	81	MC14052BDG	1	0	0	
2	165	151-795	1	146		1	0	0	
2	841	151-785	1	147		1	0	0	
1	935	420-980	1	148		1	0	0	
2	842	151-786	1	149		1	0	0	
3	468		1	150		1	0	0	
3	841	KRE-2 Low Profile	1	151		1	0	0	
3	842	KRE-3  Low Profile	1	152		1	0	0	
5	840		1	153		1	0	0	
3	13		1	154		1	0	0	
3	315		1	155		1	0	0	
3	351		1	156		1	0	0	
3	90		1	157		1	0	0	
3	440		1	158		1	0	0	
3	594		1	159		1	0	0	
3	249		1	160		1	0	0	
3	230		1	161		1	0	0	
5	164		1	162		1	0	0	
5	5		1	163		1	0	0	
5	186		1	164		1	0	0	
5	20		1	165		1	0	0	
3	15		1	166		1	0	0	
3	470		1	168		1	0	0	
3	433		1	169		1	0	0	
3	779		1	170		1	0	0	
3	163		1	171		1	0	0	
3	533		100	173		1	0	0	
3	459		100	174		1	0	0	
3	534		100	175		1	0	0	
3	535		100	176		1	0	0	
3	536		100	177		1	0	0	
3	467		10	178		1	0	0	
3	698		1	179		1	0	0	
3	458		100	180		1	0	0	
3	289		1	181		1	0	0	
12	188		1	184		1	0	0	
3	706		1	185		1	0	0	
3	466		1	186		1	0	0	
3	464		1	187		1	0	0	
2	847	420-359	50	189		1	0	0	
3	64		1	190		1	0	0	
15	436		1	191		1	0	0	
3	446	180847	1	192		1	0	0	
2	877	327-219	1	193		1	0	0	
2	9	407-150	1	194		1	0	0	
3	838		1	195		1	0	0	
5	883		1	196		1	0	0	
5	881		1	197		1	0	0	
5	884		1	198		1	0	0	
3	885		1	199		1	0	0	
5	886		1	200		1	0	0	
3	593		1	201		1	0	0	
3	474		1	202		1	0	0	
2	887	513-817	5	204		1	0	0	
4	889		1	205		1	0	0	
4	890		1	206		1	0	0	
4	891		1	207		1	0	0	
3	891		1	208		1	0	0	
4	892		1	209		1	0	0	
4	896		1	210		1	0	0	
4	897		1	211		1	0	0	
4	898		1	212		1	0	0	
23	900		1	213		1	0	0	
23	899		1	214		1	0	0	
23	901		1	215		1	0	0	
23	403		1	216		1	0	0	
23	902		1	217		1	0	0	
19	454	STLZ 950 02 5,08 H	1	218		1	0	0	
19	853	AKZ 950 02 5,08	1	219		1	0	0	
19	855	AKZ 950 03 5,08	1	221		1	0	0	
19	456	STLZ 950 06 5,08 H	1	222		1	0	0	
19	856	AKZ 950 06 5,08	1	223		1	0	0	
10	956		1	224		1	0	0	
2	821	151-745	1	225		1	0	0	
2	820	650-651	1	226		1	0	0	
4	577	CT3311-N	1	227		1	0	0	
2	968	912-712	50	228		1	0	0	
2	952	323-4940	1	229		1	0	0	
2	953	323-4927	1	230		1	0	0	
2	972	912-724	50	231		1	0	0	
2	741	249-403	1	232		1	0	0	
2	970	912-475	50	233		1	0	0	
2	969	912-773	50	234		1	0	0	
2	971	912-554	50	235		1	0	0	
5	976		1	236		1	0	0	
19	1090	CN22AK	1	237		1	0	0	
2	662	308-6185	5	238		1	0	0	
19	1091	CN45AK	1	239		1	0	0	
19	1092	AK700H	1	240		1	0	0	
19	1095	AK 700 03 5,00 V	1	241		1	0	0	
19	1093	AK700V	1	242		1	0	0	
19	1096	AK 700 08 5,00 V	1	243		1	0	0	
19	1094	AK700H	1	244		1	0	0	
5	1100		1	245		1	0	0	
19	1097	AK700H	1	246		1	0	0	
5	1101		1	247		1	0	0	
5	1103		1	248		1	0	0	
19	1099	CNB100	1	249		1	0	0	
5	873		1	250		1	0	0	
31	937	3069-02A	1	251		1	0	0	
31	185	5273-02A	1	252		1	0	0	
31	395	3069-05A	1	253		1	0	0	
31	858		1	254		1	0	0	
15	57		1	257		1	0	0	
10	60		1	258		1	0	0	
2	1111	308-6422	5	259		1	0	0	
10	864		1	260		1	0	0	
31	447	5273-05A	1	261		1	0	0	
10	957		1	262		1	0	0	
31	397	5274-05A	1	263		1	0	0	
8	1088		1	264		1	0	0	
8	1075		1	265		1	0	0	
8	1089		1	266		1	0	0	
3	133		1	267		1	0	0	
4	775		1	268		1	0	0	
3	831		1	269		1	0	0	
4	831		1	270		1	0	0	
33	1137		1	271		1	0	0	
3	346		1	272		1	0	0	
3	347		1	273		1	0	0	
3	326		1	274		1	0	0	
3	553		1	275		1	0	0	
2	1113	348-855	1	276		1	0	0	
2	1114	348-818	1	277		1	0	0	
3	539		1	278		1	0	0	
3	616		1	279		1	0	0	
4	616		1	280		1	0	0	
34	324		1	281		1	0	0	
3	128		1	282		1	0	0	
32	1115		1	286		1	0	0	
32	1116		1	287		1	0	0	
5	875		1	288		1	0	0	
32	1117	MC 1.5-5.08	1	289		1	0	0	
5	869		1	290		1	0	0	
3	680		1	291		1	0	0	
5	1120		1	292		1	0	0	
3	1122		1	293		1	0	0	
3	1123		1	294		1	0	0	
5	680		1	295		1	0	0	
15	1124	CE-20/10/5-1	1	296		1	0	0	
2	1124		1	297		1	0	0	
2	1125		1	298		1	0	0	
15	1125		1	299		1	0	0	
5	870		1	300		1	0	0	
3	254		1	301		1	0	0	
2	1130		1	302		1	0	0	
3	79		1	303		1	0	0	
2	1134	912-104	50	304		1	0	0	
5	1135		1	305		1	0	0	
3	14		1	306		1	0	0	
3	850		1	307		1	0	0	
3	1063		1	308		1	0	0	
35	1063		1	309		1	0	0	
8	1077		1	310		1	0	0	
8	1074		1	311		1	0	0	
30	1085		1	312		1	0	0	
24	922		1	320		1	0	0	
3	393		1	321		1	0	0	
4	393		1	322		1	0	0	
36	570		1	323		1	0	0	
3	83		1	324		1	0	0	
3	84		1	325		1	0	0	
3	110		1	326		1	0	0	
3	109		1	327		1	0	0	
3	82		1	328		1	0	0	
29	1073		1	329		1	0	0	
29	1072		1	330		1	0	0	
8	1087		1	336		1	0	0	
24	152		1	337		1	0	0	
3	683		1	339		1	0	0	
3	96		1	340		1	0	0	
3	1050		1	341		1	0	0	
3	107		1	342		1	0	0	
3	695		1	343		1	0	0	
3	702		1	344		1	0	0	
3	704		1	345		1	0	0	
3	102		1	346		1	0	0	
3	39		1	348		1	0	0	
1	386		1	349		1	0	0	
38	1071		1	350		1	0	0	
2	1119	308-5727	5	351		1	0	0	
2	1109	308-6215	5	352		1	0	0	
2	159	308-6460	5	353		1	0	0	
2	1107	308-9563	5	354		1	0	0	
2	665	308-5946	5	355		1	0	0	
3	937	3069-02A	1	356		1	0	0	
2	655	308-6008	5	357		1	0	0	
2	35	308-9575	5	358		1	0	0	
2	667	308-6252	5	359		1	0	0	
2	671	308-6264	5	361		1	0	0	
2	1110	308-6276	5	362		1	0	0	
2	652	308-6010	5	363		1	0	0	
2	1104	308-6290	5	364		1	0	0	
2	1106	308-5820	5	365		1	0	0	
2	663	308-6070	5	366		1	0	0	
2	1214	273-776	1	367		1	0	0	
2	666	308-6331	5	368		1	0	0	
3	185	5273-02A	1	369		1	0	0	
2	658	308-6094	5	370		1	0	0	
2	1112	308-6100	5	371		1	0	0	
2	670	308-5879	5	372		1	0	0	
2	1245	200335	1	373		1	0	0	
3	399	3069-03A	1	374		1	0	0	
2	37	308-5636	5	375		1	0	0	
2	1129	308-6112	5	376		1	0	0	
2	1105	308-6379	5	377		1	0	0	
2	1132	308-6150	5	378		1	0	0	
2	1133	308-6410	5	379		1	0	0	
2	1128	911-690	50	380		1	0	0	
2	1227	634-529	1	381		1	0	0	
2	1121	911-999	50	382		1	0	0	
2	1127	911-653	50	383		1	0	0	
2	1131	421-091	50	384		1	0	0	
2	1126	752-149	1	385		1	0	0	
31	399	3069-03A	1	387		1	0	0	
2	50	410998	1	388		1	0	0	
2	719	353-164	1	393		1	0	0	
2	113	492-103	1	394		1	0	0	
3	297		1	395		1	0	0	
8	1149		1	396		1	0	0	
8	1144		1	397		1	0	0	
8	1152		1	398		1	0	0	
8	1150		1	399		1	0	0	
8	1151		1	400		1	0	0	
8	1145		1	401		1	0	0	
8	1147		1	402		1	0	0	
8	1148		1	403		1	0	0	
2	1228	200-270	1	404		1	0	0	
2	1158	634-529	1	405		1	0	0	
2	14	569-914	1	406		1	0	0	
3	396	5273-03A	1	407		1	0	0	
2	1159	569-926	1	408		1	0	0	
2	722	257-102	1	409		1	0	0	
19	1098	AK 700 04 5,00 V	1	410		1	0	0	
2	1236	912-190	1	411		1	0	0	
2	678	305-0890	1	412		1	0	0	
31	396	5273-03A	1	413		1	0	0	
19	208	AKZ 120 02 5,08 V	1	414		1	0	0	
2	36	308-6355	5	415		1	0	0	
3	395	3069-05A	1	416		1	0	0	
2	1122	369-860	1	417		1	0	0	
2	1237	912-074	50	418		1	0	0	
3	447	5273-05A	1	419		1	0	0	
2	1160	308-6446	1	420		1	0	0	
2	80	1204767 	1	386		1	0	0	
2	1161	308-6458	1	422		1	0	0	
3	357		1	423		1	0	0	
31	357		1	424		1	0	0	
3	1163		1	425		1	0	0	
31	1163		1	426		1	0	0	
8	1164		1	427		1	0	0	
8	1165		1	428		1	0	0	
8	1166		1	429		1	0	0	
19	165	AKZ 120 03 5,08 V	1	430		1	0	0	
2	1238	912-049	50	431		1	0	0	
19	135	STL 1550\\3 3,5 H	1	432		1	0	0	
3	938	3069-06A	1	433		1	0	0	
19	1115	AK 1550\\3 3,5	1	434		1	0	0	
2	1246	4114462	1	435		1	0	0	
19	136	STLZ 1550\\4 3,81 H	1	436		1	0	0	
31	938	3069-06A	1	437		1	0	0	
19	1116	AKZ 1550\\4 3,81	1	438		1	0	0	
2	1239	912-189	50	439		1	0	0	
19	1118	AKZ 950 03 5,08	1	440		1	0	0	
3	398	5273-06A	1	441		1	0	0	
2	976	954-779  07B5606	1	442		1	0	0	
31	398	5273-06A	1	443		1	0	0	
2	1240	912-207	50	444		1	0	0	
2	1241	912-086	50	446		1	0	0	
2	735	109-311	50	447		1	0	0	
2	648	9333274	50	448		1	0	0	
2	648	912-050	50	69		1	0	0	
2	95	9332405	50	449		1	0	0	
2	1249	9332596	50	451		1	0	0	
2	1250	9238077	50	452		1	0	0	
2	1252	9451110	10	454		1	0	0	
2	1253	9451608	1	455		1	0	0	
2	1254	755771	10	456		1	0	0	
2	1255	7668614	10	457		1	0	0	
2	1256	1216550	10	458		1	0	0	
2	1257	9558659	10	459		1	0	0	
2	1258	38C7700	5	460		1	0	0	
2	1259	13J1665	1	461		1	0	0	
2	1261	1201313	1	463		1	0	0	
2	1262	96K3660	1	464		1	0	0	
2	1265	9488146	1	466		1	0	0	
3	153		1	88		1	0	0	
3	132		1	183		1	0	0	
2	183	379-578	1	470	MM74HC541WM (?)	1	0	0	
2	1266	3734771	1	474		1	0	0	
2	38	1081230	1	475		1	0	0	
2	38	516-843	1	445		1	0	0	
3	38		1	108		1	0	0	
2	1267	9846115	1	476		1	0	0	
2	1268	58K8856	1	477		1	0	0	
2	1269	75C0999	1	478		1	0	0	
2	1272	9846271	1	481		1	0	0	
2	1273	1284348	1	482	6605759-1 (TYCO)	1	0	0	
2	1274	8737908	1	483		1	0	0	
2	1275	1201330	1	484	74HC4066D	1	0	0	
2	1276	1201269	1	485	74HC595D	1	0	0	
2	1277	242500	1	486	BD3/1/4-4S2 (Ferroxcube)	1	0	0	
2	1278	933-7210	50	487		1	0	0	
2	64	9451692	1	489		1	0	0	
2	1279	70K9772	1	491		1	0	0	
2	1281	755679	1	493		1	0	0	
2	1282	755692	1	494		1	0	0	
2	1283	1138869	1	495		1	0	0	
2	1284	9753591	1	496		1	0	0	
2	1285	1216435	1	497		1	0	0	
2	97	1097185	1	499	BZV55-C12	1	0	0	
2	1286	1097197	1	500	BZV55-C3V3	1	0	0	
2	1287	8735743	1	501	BZX384-C5V6	1	0	0	
2	84	1142502	1	502		1	0	0	
2	594	98H0572	1	503	LM317TG	1	0	0	
2	1288	588581	1	505		1	0	0	
2	39	1081244	1	506		1	0	0	
2	515	71J5860	1	507	MJE13007G	1	0	0	
2	1289	1085299	1	508	74HCT04D	1	0	0	
2	186	52F2783	1	510		1	0	0	
2	1290	06F1118	1	511		1	0	0	
2	1291	9663754	1	512	ICM7555IBAZ	1	0	0	
2	1292	88H2402	1	513	IR2175S	1	0	0	
2	1294	89K0711	1	515	LM393D	1	0	0	
2	213	1102157	1	516	LM7805CT	1	0	0	
2	184	52F2352	1	517	SN74HCT138D	1	0	0	
2	1295	90B1233	1	518	TLC1543CDW	1	0	0	
2	28	9332820	50	519		1	0	0	
2	1296	912426	50	522		1	0	0	
2	970	9335757	50	523		1	0	0	
2	1297	9336117	1	524		1	0	0	
2	1298	1200376	1	525		1	0	0	
2	653	9332723	50	526		1	0	0	
2	1299	9333584	50	527		1	0	0	
2	1300	9497587	1	528		1	0	0	
2	646	9332421	50	529		1	0	0	
2	1301	9333479	1	530		1	0	0	
2	664	9332600	50	532		1	0	0	
2	1302	9335790	1	533		1	0	0	
2	1278	9336150	50	534		1	0	0	
2	1303	9477268	1	535		1	0	0	
2	1304	1306691	1	536		1	0	0	
2	1310	976-120	1	537	MCHTC-100M 20mm	1	0	0	
2	1317	316271 	1	538	HARTING 0923 248 6825	1	0	0	
2	1318	1085328 	1	539	74HC21D	1	0	0	
2	184	489554	1	17	74HCT138D	1	0	0	
2	1319	1085308	1	540	NXP 74HCT139D	1	0	0	
19	1321	STLZ 1550 10 G 3.81	1	542		1	0	0	
2	1325	1201249 	1	546	NXP 74HC165D	1	0	0	
2	1327	1085251	1	548	NXP 74HC1G04GW	1	0	0	
19	1322	AKZ 1550 10 3.81	1	543		1	0	0	
2	1308	9336184	50	566		1	0	0	
2	1320	316246	1	541	0923 132 6921	8	0	0	
2	1264	9779230	1	465		1	0	0	
2	92	3051365	1	498	PMLL4148L	1	0	0	
2	99	9332383	50	520		1	0	0	
2	660	9332936	50	531		1	0	0	
2	1326	1085259	1	547	74HC1G125GW	4	0	0	
2	1306	9336265	50	731		1	0.0200000000000000004	0	
2	1285	9752951	1	735		1	0	0	
19	1343	STLZ 950 02 G 5,08 V	1	739		13	0	0	
19	455	STLZ 950 03 5,08 H	1	220		1	0	0	
19	1344	STLZ 950 04 5,08 V	1	740		13	0	0	
19	1345	AKZ 950 04 5,08	1	741		13	0	0	
2	1328	1103133	1	549	CD74HCT86M	2	0	0	
2	1347		1	742		1	0	0	
2	1324	20H4786	1	545	CD4044BD	2	0	0	
2	1271	63K3623	1	480	PM5022-330M-RC	1	0	0	
2	1351		1	743		1	0	0	
2	1352		1	744		1	0	0	
2	1353		1	745		1	0	0	
2	1354		1	746		1	0	0	
23	1355		1	747		1	0	0	
2	1356		1	748		1	0	0	
2	1359		1	750		1	0	0	
2	1360		1	751		1	0	0	
19	1363		1	753		1	0	0	
19	1364		1	754		1	0	0	
4	1366		1	755		1	0	0	
2	1379		1	756	GD75232	1	0	0	
2	1387	8389187	1	757		3	0	0	
2	1388	60K6805	1	758		1	0	0	
2	102	9558497	1	794	BC337-25ZL1G	1	0	0	
2	1429	8454175	1	780	TLC274AID	1	0	0	
2	282	1201296	1	762	HEF4093BT	1	0	0	
2	1415	06F9416	1	763	LM348N	1	0	0	
2	240	19K8418	1	764	IR2113PBF	1	0	0	
2	1418	9333681	1	765	MC01W08050R	1	0	0	
2	1338	9335854	1	766		1	0	0	
2	1419	12T2107	1	767	ERA-8AEB684V	1	0	0	
2	1420	1100137	1	768	WCR1206-R005JI	1	0	0	
2	1421	9336583	1	769		1	0	0	
2	1422	9241124	1	770	RC1206FR-071ML	1	0	0	
2	1424	BRPH000012	1	771	230619753128	1	0	0	
2	1425	9338241	1	772	MCF2W47R	1	0	0	
2	1426	1108073	1	773	LVR03R0500FE70	1	0	0	
2	1390	1108082	1	774	LVR05R0150FE73	1	0	0	
2	1427	41K9029	1	775	LVR05R0500FE12	1	0	0	
2	363	1103845	1	776	2227MC	1	0	0	
2	364	1103846	1	777	2227MC	1	0	0	
2	1428	08F7453	1	778	SN74LS541N	1	0	0	
2	1400	1085315	1	779	74HCT245D	1	0	0	
2	1430	35C1764	1	781	LT1013DD	1	0	0	
2	873	77C3651	1	782	XTR115U	1	0	0	
2	1401	06F1107	1	783	AM26LS31CD	1	0	0	
2	1431	06F9414	1	784	LM348D	1	0	0	
2	1432	01P0907	1	785	INA333AIDGKR	1	0	0	
2	1433		1	786		1	0	0	
2	1434	9589848	1	787	MC79L05ACLP	1	0	0	
2	1435	72K8848	1	788	LM78L05ACZ	1	0	0	
2	1436	88H4758	1	789	MC7805CTG	1	0	0	
2	713	63J7322	1	790	IRF540PBF	1	0	0	
2	451	9936092	1	792	TIP3055	1	0	0	
2	1414	12J3398	1	759	S8025L	1	0	0	
2	1437	01H1005	1	793	TIP41A	1	0	0	
2	1438	1057298	1	795	BTB24-600BRG	1	0	0	
2	1440	10N9718	1	796	NTF2955T1G	1	0	0	
2	1441	58K1480	1	797	FDV304P	1	0	0	
2	1358	58K8857	1	798	FDV303N	1	0	0	
2	1442	1081219	1	799	BC807	1	0	0	
2	1443	25M9343	1	800	EXC-ML32A680U	1	0	0	
2	1405	1651733	1	801	ILB1206ER601V	1	0	0	
2	1058	62K3124	1	802	SRR1206-101YL	1	0	0	
2	1444	61J8346	1	803	SDR1006-151KL	1	0	0	
2	1445	61J8235	1	804	SDR0805-221KL	1	0	0	
2	1361	9451129	1	752	MCGPR16V108M10X16	1	0	0	
2	1362	9451838	1	805	MCRH25V107M6.3X11	1	0	0	
2	1446	55K2067	1	806	UVR1C103MHD	1	0	0	
2	1395	197014	1	807	TAJA106K006RNJ	1	0	0	
2	157	197518	1	808	TAJC106K025RNJ	1	0	0	
2	153	498737	1	809	TAJB106K016RNJ	1	0	0	
2	1396	1135060	1	810	TAJC226K025RNJ	1	0	0	
2	1447	19C6333	1	811	08055C222KAT2A	1	0	0	
2	1448	10R6438	1	812	MC1206X475K250CT	1	0	0	
2	183	1201325	1	473	74HC541D	1	0	0	
2	614	35k4719	1	813	MAX232D	1	0	0	
2	1466	68K4797	1	814	MAX485ECSA+	1	0	0	
2	1467	1332113	1	815		1	0	0	
2	1468	380684	1	816	74HC238N	1	0	0	
2	1469	382425	1	817	74HCT541N	1	0	0	
1	269		1	818	HCF4001BE	1	0	0	
1	279		1	819	HCF4049UBE	1	0	0	
1	279		1	820	CD4049UBE	1	0	0	
2	1470	60K5118	1	821	CD4050BE	1	0	0	
2	9	59K8220	1	822	MAX232N	1	0	0	
2	1472	08J8743	1	823	MCP4921-E/P	1	0	0	
1	1479		1	824	LM358N	1	0	0	
1	1481		1	827	LM324N	1	0	0	
1	1482		1	828	AM26LS31CN	1	0	0	
1	1483		1	829	LM339N	1	0	0	
2	1488	01M8224	1	831		1	0	0	
2	1490	12J4725	1	832		1	0	0	
39	1497		1	833		1	0	0	
40	1558		1	838		1	0	0	
2	24	9332391	50	450		1	0	0	
2	24	911-975	50	40		1	0	0	
40	1586		1	840		1	0	0	
2	659	911-732	50	39		1	0	0	
40	106		1	843		1	0	0	
40	1588		1	844		1	0	0	
1	371		1	845		1	0	0	
40	21		1	846		1	0	0	
40	1280		1	847		1	0	0	
40	1251		1	848		1	0	0	
40	1589		1	850		1	0	0	
40	1591		1	853		1	0	0	
40	1350		1	854		1	0	0	
40	1592		1	856		1	0	0	
40	1593		1	857		1	0	0	
40	1594		1	858		1	0	0	
40	1595		1	859		1	0	0	
40	1596		1	860		1	0	0	
40	1597		1	861		1	0	0	
40	1599		1	864		1	0	0	
40	647		1	866		1	0	0	
40	1314		1	867		1	0	0	
1	412	22-MM74	1	673	MM74HC244WM	1	0	0	
1	0		1	868	MM2345	0	0	0	
40	1545	 512-HCPL-2631 	1	870	10	10	0	0	
19	1631	AKZ 950 02 5.08	1	871	13	13	0	0	
40	1650	 80-C0603C121J3HACTU 	10	878	C0603C121J3HACTU	0	0	0	
40	1658	 81-GRM188R71E154JA1D 	10	885	GRM188R71E154JA01D	0	0	0	
40	1648	 187-CL31B106KAHNNNE 	10	874	CL31B106KAHNNNE	0	0	0	
40	1659	 810-C1608X5R1E155K 	10	886	C1608X5R1E155K080AB	0	0	0	
40	1655	 81-GRM32DR7LV104KW1L 	1	882	GRM32DR7LV104KW01L	0	0	0	
40	1656	 871-B32923C3105M	1	883	B32923C3105M	0	0	0	
40	1662	 603-CC603ZRY5V8BB224 	10	889	CC0603ZRY5V8BB224	0	0	0	
40	1652	 810-C4C0G2J331G060AA 	1	879	CGA5C4C0G2J331G060AA	0	0	0	
40	1661	 581-KGM15ACG1E471JT 	10	888	KGM15ACG1E471JT	0	0	0	
40	1660	 187-CL10B562KB8NNNC 	1	887	CL10B562KB8NNNC	0	0	0	
40	1653	 81-GRM1885C1E621GA1J 	10	880	GRM1885C1E621GA01J	0	0	0	
40	1651	 871-B32924C3225K	1	877	B32924C3225K	0	0	0	
40	1649	 871-B32924C3335M	1	875	B32924C3335M	0	0	0	
40	1654	871-B43510A5228M000	1	881	B43510A5228M000	0	0	0	
40	1616	 504-EHBSA025M1010608 	1	876	EHBSA025M1010608T	0	0	0	
40	1672	595-UCC28070APWR	1	898	UCC28070APWR	0	0	0	
40	1674	 538-39-28-1063 	1	900	39-28-1063	0	0	0	
40	1673	 538-39-28-1083 	1	899	39-28-1083	0	0	0	
40	1664	241-GBJ5010_T0_00601	1	891	GBJ5010_T0_00601	0	0	0	
40	1667	 771-PMEG4005AEAT/R 	1	893	PMEG4005AEA,115	0	0	0	
40	1666	 511-STTH3012WL 	1	892	STTH3012WL	0	0	0	
40	1669	 863-MRA4005T3G 	1	895	MRA4005T3G	0	0	0	
40	1663	 637-SUF4005 	1	890	SUF4005	0	0	0	
40	1668	 833-SMAJ4754A-TP	1	894	SMAJ4754A-TP	0	0	0	
40	1677	726-IMW65R007M2HXKSA	1	903	IMW65R007M2H	0	0	0	
40	1671	 871-B82727E6403A40 	1	897	B82727E6403A40	0	0	0	
40	1675	 693-DSH-22-0001 	1	901	DSH-22-0001	0	0	0	
40	1679	 71-CRCW0603-15.8K-E3 	1	905	CRCW060315K8FKEA	0	0	0	
40	1678	 603-AC0603FR-072KL 	1	904	AC0603FR-072KL	0	0	0	
40	1681	 603-AC1206DR-071ML	1	907	AC1206DR-071ML	0	0	0	
40	1680	 708-RNCP1206FTD10R0 	1	906	RNCP1206FTD10R0	0	0	0	
40	1647	726-FF600R12KT4HOSA1	1	873	F600R12KT4HOSA1	0	0	0	
2	482		1	834	SG3525	1	0	0	
40	1670	710-74279244	1	896	74279244	0	0	0	
40	1698	 869-LNK306DG-TL	1	924	LNK306DG-TL	0	0	0	
40	1676	 919-RAC15-15SK 	1	902	RAC15-15SK	0	0	0	
40	659	 71-CRCW0805J-100-E3 	1	947	CRCW0805100RJNEC 	1	0	0	
40	1699	579-MCP1407-E/SN	1	925	MCP1407-E/SN	0	0	0	
40	92	 637-1N4148W 	1	936	 1N4148W 	1	0	0	
40	1685	 71-CRCW2512J-470K-E3 	1	911	CRCW2512470KJNEG	0	0	0	
40	1686	 660-RK73H1JTTD2492F 	1	912	RK73H1JTTD2492F	0	0	0	
40	1687	 754-RR0816P-9312D94C 	1	913	RR0816P-9312-D-94C	0	0	0	
40	1684	 71-CRCW0603549KFKEAH 	10	910	CRCW0603549KFKEAHP	0	0	0	
40	1683	 594-MCT06030C6492FP5 	10	909	MCT06030C6492FP500	0	0	0	
40	1682	 660-RN73H1JTD7771B25 	1	908	RN73H1JTTD7771B25	0	0	0	
40	1697	 871-B57861S103F40 	1	923	B57861S0103F040	0	0	0	
40	1696	673-PMS9494.100NLT	1	922	PMS9494.100NLT	0	0	0	
40	1590	595-AM26C32IDR	1	959	AM26C32IDR 	1	0	0	
0	0	DEFAULT	1	0	DEFAULT	0	0	0	
0	1568		1	1689	HC86	0	0	0	DEFAULT
0	1569		1	1690	TL071CN	0	0	0	DEFAULT
0	1570		1	1691	14504BG	0	0	0	DEFAULT
0	1571		1	1692	TC4049BP	0	0	0	DEFAULT
0	1572		1	1693	TL082CP	0	0	0	DEFAULT
0	1573		1	1694	HCF4035BE	0	0	0	DEFAULT
0	1574		1	1695	HCF4082BE	0	0	0	DEFAULT
0	1575		1	1696	HCF4030BE	0	0	0	DEFAULT
0	1576		1	1697	082D	0	0	0	DEFAULT
0	1578		1	1698	INT200	0	0	0	DEFAULT
0	1579		1	1699	INT201	0	0	0	DEFAULT
0	1580		1	1700	DS26C32ATN	0	0	0	DEFAULT
0	1581		1	1701	MAX485	0	0	0	DEFAULT
0	1582		1	1702	AM26LS32ACN	0	0	0	DEFAULT
0	1583		1	1703	LMC6062	0	0	0	DEFAULT
0	1577		1	1704	CD4504BE	0	0	0	DEFAULT
0	1563		1	1705	CD4528BCN	0	0	0	DEFAULT
0	1548		1	1706	HCF451BE	0	0	0	DEFAULT
0	1604		1	1707	MUR160	0	0	0	DEFAULT
0	1605		1	1708	Bendal 100-302-SN	0	0	0	DEFAULT
0	1606		1	1709	MEE1S0505SC	0	0	0	DEFAULT
0	1607		1	1710	MEE1S1212SC	0	0	0	DEFAULT
0	1608		1	1711	MEE1S1215SC	0	0	0	DEFAULT
0	1611		1	1712	10K	0	0	0	DEFAULT
0	1615		1	1713	10uF/25V	0	0	0	DEFAULT
0	1618		1	1714	PZT2222A	0	0	0	DEFAULT
0	1622		1	1715	39K	0	0	0	DEFAULT
0	1624		1	1716	Bendal 100-303-SN	0	0	0	DEFAULT
0	1625		1	1717	B1205S-2W	0	0	0	DEFAULT
0	1626		1	1718	IDC 05x2 HEADER	0	0	0	DEFAULT
0	1640		1	1719	470R	0	0	0	DEFAULT
0	1217		1	1720	01x03 (03 vias)	0	0	0	DEFAULT
0	1551		1	1721	CD4504	0	0	0	DEFAULT
0	1635		1	1722	KF7.62-2P (2 vias)	0	0	0	DEFAULT
0	1636		1	1723	5569-4A	0	0	0	DEFAULT
0	1614		1	1724	40106	0	0	0	DEFAULT
0	1641		1	1725	33uF/25V	0	0	0	DEFAULT
0	1638		1	1726	02x10 (20 vias)	0	0	0	DEFAULT
0	1623		1	1727	INA826	0	0	0	DEFAULT
0	1642		1	1728	5569-2A	0	0	0	DEFAULT
0	1598		1	1729	MAX6675	0	0	0	DEFAULT
0	1639		1	1730	Vermelho	0	0	0	DEFAULT
0	1644		1	1731	uA7805	0	0	0	DEFAULT
0	1617		1	1732	01x01 via	0	0	0	DEFAULT
0	1620		1	1733	200R	0	0	0	DEFAULT
0	1619		1	1734	20R 1%	0	0	0	DEFAULT
0	1621		1	1735	33R	0	0	0	DEFAULT
0	717		1	1736	HCPL-7800	0	0	0	DEFAULT
0	1603		1	1737	1uF	0	0	0	DEFAULT
0	1637		1	1738	02x05 (10 vias)	0	0	0	DEFAULT
0	1609		1	1739	FGH60N60SMD	0	0	0	DEFAULT
0	1610		1	1740	4R7	0	0	0	DEFAULT
0	1612		1	1741	AM36C31	0	0	0	DEFAULT
0	1627		1	1742	IR2113	0	0	0	DEFAULT
0	1613		1	1743	HCPL-2601	0	0	0	DEFAULT
0	343		1	1744	2200uF/25V	0	0	0	DEFAULT
0	1634		1	1745	CH3.96-2A (02 vias)	0	0	0	DEFAULT
0	1645		1	1746	CH3.96-3A (03 vias)	0	0	0	DEFAULT
0	1629		1	1747	STLZ 950 03G 5.08 H	0	0	0	DEFAULT
0	1646		1	1748	01x02 (02 vias)	0	0	0	DEFAULT
0	1632		1	1749	AKZ 950 03 5.08	0	0	0	DEFAULT
0	1633		1	1750	AKZ 950 07 5.08	0	0	0	DEFAULT
0	1628		1	1751	STLZ 950 02G 5.08 H	0	0	0	DEFAULT
0	1630		1	1752	STLZ 950 07G 5.08 H	0	0	0	DEFAULT
0	1708		1	1753	02x04 8 vias	0	0	0	DEFAULT
0	1707		1	1754	02x05 10 vias	0	0	0	DEFAULT
40	1728	595-UCC5870QEVM-045	1	1755	UCC5870QEVM-045	2	0	0	Ferramentas de desenvolvimento IC de gestão de alimentação UCC5870-Q1 functiona l safety compliant 1
40	1731	 747-IXFH90N65X3 	1	1758	IXFH90N65X3 	0	0	0	
40	1732	871-B66398W1024T1	1	1759	B66398W1024T001	19	0	0	Núcleos e acessórios de ferrite COIL FORMER RNITE FR 530
40	1734	871-B66398A2000X	1	1761	B66398A2000X000	19	0	0	Núcleos e acessórios de ferrite CLM-ETD59
40	1735	 667-ECW-FE2W225KA 	1	1762	 ECW-FE2W225KA	15	0	0	
40	1736	871-B32923C3225M	1	1763	B32923C3225M	19	0	0	Capacitores de segurança 2.2uF 20% 305Vac MKP X2, LS 21.5MM
40	1738	859-LTV-816S-TA1	1	1765	LTV-816S-TA1	22	0	0	Optoacopladores de saída transistorizados Optocoupler
40	1740	538-45558-0003	1	1767	45558-0003	23	0	0	Distribuidores e Alojamento de Fios MF Jr Hdr Assy 6Ckt t Spl Polz Tin 2 Peg
40	1741	595-LAUNCHXL-F28069M	1	1768	LAUNCHXL-F28069M	2	0	0	Development Boards & Kits - TMS320 MOTION (staSPIN-FOC) C2000 Picolo LnchPa
40	1733	871-B66397GX187	1	1760	B66397GX187	19	0	0	Ferrite Cores & Accessories ETD59/31/22 N87OL  sem GAP
40	1742	511-STTH3012W	1	1769	STTH3012W	5	0	0	Retificadores Ultrafast recovery 1200 V diode
40	1743	726-IKY120N65EH7XKSA	1	1770	IKY120N65EH7XKSA1	12	0	0	IGBTs 650 V, 120 A IGBT with anti-parallel diode in TO247PLUS-4 package
40	1745	511-STTH3010W	1	1772	STTH3010W	5	0	0	Diodos de Comutação de Sinais Pequenos Ultrafast recovery high voltage diode
40	1744	511-STTH3006W	1	1771	STTH3006W	5	0	0	Retificadores high volt rectifier
40	1748	538-39-00-0039	10	1775	39-00-0039	23	0	0	Terminal for MOLEX MiniFit
40	1749	538-45559-0002	1	1776	45559-0002	23	0	0	Headers & Wire Housings 6CKT RECPT HSG
0	1750	667-ECW-FE2J225KA	1	1777		0	0	0	Unpolarized capacitor
40	1256	81-GA355ER7GB473KW1L	1	1779	GA355ER7GB473KW01L	0	0	0	Unpolarized capacitor
40	1752	603-SMAJ15A-AT/TR13	1	1780	SMAJ15A-AT/TR13	21	0	0	400W unidirectional Transient Voltage Suppressor, 15.0Vr, SMA(DO-214AC)
40	1753	70-ILBB0603ER202V	1	1781	ILBB0603ER202V	14	0	0	Ferrite bead, small symbol
40	1754	604-APL3015QGC	1	1782	APL3015QGC	0	0	0	Single Color LEDs GREEN WATER CLEAR
40	1730	747-IXFH90N65X3	1	1757	IXFH90N65X3  	0	0	0	
40	1618	833-PZT2222A-TP	1	1783	PZT2222A-TP	0	0	0	
40	1755	279-3540220RJT	1	1784	3540220RJT	24	0	0	Thick Film Resistors - SMD 3540 220R 5%
40	1751	594-S471K25Y5PN63J5R	1	1778	S471K25Y5PN63J5R	0	0	0	Unpolarized capacitor
40	1739	726-2EDB8259YXUMA1	1	1766	2EDB8259YXUMA1	0	0	0	Drivers de portas GATE DRIVER
40	1756	859-LTV-816S-TA1	1	1785	LTV-816S-TA1	0	0	0	DC Optocoupler, Vce 35V, CTR 50%, SMDIP-4
40	1746	595-TMCS1133C5AQDVGR	1	1773	TMCS1133C5AQDVGR	2	0	0	Board Mount Current Sensors 80ARMS 1MHz Hall-effect current sensor
40	1757	771-HC1G14GV125	1	1786	HC1G14GV125	0	0	0	Logic Level Inverter
40	1747	595-TMCS1133C3AQDVGR	1	1774	TMCS1133C3AQDVGR	2	0	0	Board Mount Current Sensors 80ARMS 1MHz Hall-effect current sensor
40	1737	667-ECW-FE2J225K	1	1764	ECW-FE2J225K	15	0	0	Capacitores de película 2.2uF 630VDC 10% MPP L/S=22.5mm
\.


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: jrm
--

COPY public.suppliers (id, name, legalname, federal_code, state_code, city_code, phone, fax) FROM stdin;
24	De Santis	De Santis Comercial Ltda	\N	\N	\N	\N	\N
3	EDAComp	EDAComp	\N	\N	\N	\N	\N
4	Pinhé	Eletrônica Pinhé Ltda.	\N	\N	\N	\N	\N
5	Digikey	Digikey	\N	\N	\N	\N	\N
6	Micropress	Micropress Circuitos Impressos	\N	\N	\N	\N	\N
7	Visuart	Visuart	\N	\N	\N	\N	\N
8	Camir	Camir Parafusos	\N	\N	\N	\N	\N
10	Esparza	Esparza e Caurin Ltda ME	\N	\N	\N	\N	\N
11	Eletrovolt	Eletrovolt	\N	\N	\N	\N	\N
12	MCE	Microtécnica Sistemas de Energia Ltda	\N	\N	\N	\N	\N
14	Jabu 	Jabu Engenharia Elétrica Ltda	\N	\N	\N	\N	\N
15	Thornton	Thornton	\N	\N	\N	\N	\N
16	Cirvale	Cirvale	\N	\N	\N	\N	\N
17	Phoenix Mechano	Phoenix Mechano	\N	\N	\N	\N	\N
25	Casa Parafuso		\N	\N	\N	\N	\N
18	Arrow	Arrow Americas	\N	\N	\N	\N	\N
19	Alabarce		\N	\N	\N	\N	\N
23	Ca and Ma	Vera Lúcia Capellato Melo ME	\N	\N	\N	\N	\N
2	Farnell	Farnell Newark In One				+55 11 4066 9400	+55 11 4066 9410
28	Metalaser	Metalaser	\N	\N	\N	\N	\N
29	FR Plasticos	FR Plasticos	\N	\N	\N	\N	\N
30	Gualtieri	Gualtieri Comercial Ltda	\N	\N	\N	\N	\N
31	Trancham		\N	\N	\N	\N	\N
32	Phoenix Contact		\N	\N	\N	\N	\N
33	Quickplast		\N	\N	\N	\N	\N
34	Mar-Girius		\N	\N	\N	\N	\N
35	Spectrum	Displays	\N	\N	\N	\N	\N
36	Dec Usinagem		\N	\N	\N	\N	\N
38	Meta Laser		\N	\N	\N	\N	\N
0	00 invalid						
39	Proesi						
41	Aliexpress						
40	Mouser	Mouser do Brazil					https://www.mouser.com
43	Vishay						
1	Geral	Fornecedor genérico					
\.


--
-- Data for Name: usernavs; Type: TABLE DATA; Schema: public; Owner: jrm
--

COPY public.usernavs (id, group_id, location_id) FROM stdin;
0	0	0
\.


--
-- Name: assemblies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jrm
--

SELECT pg_catalog.setval('public.assemblies_id_seq', 80, true);


--
-- Name: cases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jrm
--

SELECT pg_catalog.setval('public.cases_id_seq', 47, true);


--
-- Name: components_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jrm
--

SELECT pg_catalog.setval('public.components_id_seq', 1757, true);


--
-- Name: currencies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jrm
--

SELECT pg_catalog.setval('public.currencies_id_seq', 13, true);


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jrm
--

SELECT pg_catalog.setval('public.groups_id_seq', 196, true);


--
-- Name: labels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jrm
--

SELECT pg_catalog.setval('public.labels_id_seq', 463, true);


--
-- Name: listing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jrm
--

SELECT pg_catalog.setval('public.listing_id_seq', 1, true);


--
-- Name: location_entry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jrm
--

SELECT pg_catalog.setval('public.location_entry_id_seq', 3014, true);


--
-- Name: location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jrm
--

SELECT pg_catalog.setval('public.location_id_seq', 153, true);


--
-- Name: manufacturers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jrm
--

SELECT pg_catalog.setval('public.manufacturers_id_seq', 24, true);


--
-- Name: quotes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jrm
--

SELECT pg_catalog.setval('public.quotes_id_seq', 1395, true);


--
-- Name: relassemblies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jrm
--

SELECT pg_catalog.setval('public.relassemblies_id_seq', 1556, true);


--
-- Name: shops_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jrm
--

SELECT pg_catalog.setval('public.shops_id_seq', 141, true);


--
-- Name: supergroups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jrm
--

SELECT pg_catalog.setval('public.supergroups_id_seq', 17, true);


--
-- Name: suppliercodes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jrm
--

SELECT pg_catalog.setval('public.suppliercodes_id_seq', 1786, true);


--
-- Name: suppliers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jrm
--

SELECT pg_catalog.setval('public.suppliers_id_seq', 43, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jrm
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: assemblies_id_key; Type: INDEX; Schema: public; Owner: jrm
--

CREATE UNIQUE INDEX assemblies_id_key ON public.assemblies USING btree (id);


--
-- Name: components_id_key; Type: INDEX; Schema: public; Owner: jrm
--

CREATE UNIQUE INDEX components_id_key ON public.components USING btree (id);


--
-- Name: currencies_id_key; Type: INDEX; Schema: public; Owner: jrm
--

CREATE UNIQUE INDEX currencies_id_key ON public.currencies USING btree (id);


--
-- Name: groups_id_key; Type: INDEX; Schema: public; Owner: jrm
--

CREATE UNIQUE INDEX groups_id_key ON public.groups USING btree (id);


--
-- Name: location_id_key; Type: INDEX; Schema: public; Owner: jrm
--

CREATE UNIQUE INDEX location_id_key ON public.locations USING btree (id);


--
-- Name: supergroups_id_key; Type: INDEX; Schema: public; Owner: jrm
--

CREATE UNIQUE INDEX supergroups_id_key ON public.supergroups USING btree (id);


--
-- Name: suppliers_id_key; Type: INDEX; Schema: public; Owner: jrm
--

CREATE UNIQUE INDEX suppliers_id_key ON public.suppliers USING btree (id);


--
-- PostgreSQL database dump complete
--

