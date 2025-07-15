--
-- PostgreSQL database dump
--

-- Dumped from database version 13.9 (Debian 13.9-0+deb11u1)
-- Dumped by pg_dump version 13.9 (Debian 13.9-0+deb11u1)

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

CREATE DATABASE lister WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF-8';


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

SET default_table_access_method = heap;

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
    box integer DEFAULT 1
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
    quant integer DEFAULT 0 NOT NULL
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
    code text DEFAULT ''::text,
    rounding integer DEFAULT 1,
    active boolean DEFAULT true,
    id integer NOT NULL,
    partnumber text DEFAULT ''::text,
    manufact_id integer DEFAULT 1,
    price double precision DEFAULT 0,
    tax double precision DEFAULT 0
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
12	0805-CAP	
13	Porta Fus PCI	
14	SOD-80C	
15	TO-92	
16	DIP-8	
17	DIP-14-7	
18	CE100	
19		
20	SO-8	
0	not set	Unknown or unset case.
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
33pF	6	198	12
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
390pF	6	296	12
10pF	6	682	12
2K7	2	1306	10
56R	2	3	10
47R	2	4	10
180R	2	34	10
270K	2	1313	10
Fusível 250V Preto PCI	39	1310	13
Fusível 250V Laranja	39	392	0
TIP31B	9	464	1
HCPL7800	3	717	16
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
2200uF/25V	18	343	0
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
P4 Fêmea 90 graus PCI	11	369	0
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
TILL111	3	523	0
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
27pF	6	22	12
22pF	6	197	12
330pF	6	672	12
220pF	6	677	12
47pF	6	199	12
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
BC817-25	9	965	0
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
6N137	3	13	0
100mm (aprox) Preta	69	359	0
LT1004CZ25	3	51	0
Dupla 090° PCI 80 Pinos	35	133	0
1N4148	20	779	0
BC337-25	9	102	0
74HC14	101	77	0
BPW34S	90	741	0
15K	21	534	0
10nF/400V	27	93	0
LM92CIM	100	875	0
Flat Cable 5x2 Fêmea	11	386	0
2K7	1	106	9
12pF	6	90	12
100K	59	737	9
100K	2	968	10
1K	2	970	10
330K	2	969	10
4K7	2	971	10
ConVD 5.08mm 2.5mm² 90° PCI 3 vias	166	455	0
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
Calibrador SIMAD I	143	1060	0
Carretel E25	34	1061	0
Carretel E30/14	34	1062	0
Sensor AS - Copo	150	1079	0
Sensor AS - Corpo	150	1080	0
BD236	9	1064	0
Sensor AS - Filtro	150	1081	0
47uF/100V	18	1065	0
Sensor AS - Trava Copo	150	1082	0
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
1N4148 (1206/SOD80)	26	92	14
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
MDC-1	24	86	0
Número de Série 28x16mm	24	169	0
47uF/16V	7	539	0
Número de Série 60x45mm	24	1078	0
Simad-Logger-13teclas	24	1139	0
Simad-Logger-6teclas	24	1155	0
10uF/25V	18	339	0
Simad-Logger-LCD	24	1138	0
Simad-Logger-Power-AC	24	1154	0
Simad-Logger-Power-DC	24	1143	0
Simad-Logger-Prog	24	1142	0
Simad-Logger-RS232	24	1141	0
Simad-Logger-Reles	24	1140	0
Simad-Logger-semLCD	24	1156	0
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
4093	102	282	0
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
BC807-25	9	115	0
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
74HCT541	101	88	0
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
Simples 180° PCI 04 Pinos	35	1218	0
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
LM3940IMP-3.3	100	1264	0
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
LM393	100	1294	0
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
560K	1	1239	9
820K	1	1240	9
82K	1	1241	9
68K	1	1237	9
10nF	6	1251	12
33nF	6	1254	12
39pF/200V	6	1255	12
47nF	6	1256	12
1nF	6	1280	12
470pF	6	1281	12
2.2nF	6	1282	12
100pF	6	1284	12
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
100uF/25V	18	1362	0
ConVD 5.08mm 1.5mm²  90° PCI 2 vias	166	1363	0
ConVD 5.08mm 1.5mm²  Plug 2 vias	166	1364	0
Simples 180° PCI 05 Pinos	35	1365	0
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
AM26LS31CD	100	1401	0
AM26LS32ACD	100	1402	0
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
LT1013DD	100	1430	0
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
BC807	9	1442	0
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
HCPL2631	3	1545	0
LM565CN	3	1546	0
A1120	3	1552	0
HEF4049BT	3	1553	0
ACS708T	3	1556	0
HCPL2630	3	1558	0
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
TJA1050	100	1584	0
INA826	100	1585	0
125R	1	1586	0
30pF	6	1587	0
SI2300	81	1588	0
ESP32-S3-DevKitC	179	1589	0
AM26C32	100	1590	0
CD4504	102	1551	0
CD4504BE	61	1577	0
CD4528BCN	61	1563	0
HCF451BE	61	1548	0
220uF/25V	18	1591	0
ConVD 5.08mm 2.5mm² 180º PCI 3 vias	166	1350	0
Conector JST XH 2.5mm Vert 4 vias	11	1592	0
ConVD 5.08mm 2.5mm² plug 7 vias	166	1593	0
TIL78	9	1594	0
TIL32	23	1595	0
MEE1S1205C	180	1597	0
MAX6675	100	1598	0
P6KE6.8CA	19	1599	0
100nF	17	62	0
100nF	6	21	12
Inválido	0	0	0
Simples 180º PCI 03 Pinos	35	1217	0
1uF	6	1603	0
MUR160	20	1604	0
Bendal 100-302-SN	11	1605	0
MP1584	180	1596	0
MEE1S0505SC	180	1606	0
MEE1S1212SC	180	1607	0
MEE1S1215SC	180	1608	0
FGH60N60SMD	167	1609	0
4R7	1	1610	0
10K	2	1611	0
AM36C31	100	1612	0
HCPL-2601	3	1613	0
40106	102	1614	0
\.


--
-- Data for Name: currencies; Type: TABLE DATA; Schema: public; Owner: jrm
--

COPY public.currencies (id, name, symbol, rate) FROM stdin;
1	Real	R$	1
3	EURO	EUR	3.29
2	Dólar	US$	3.07
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
Resistor SMD 0805 1%	1	1
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
Etiqueta	24	7
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
Calibrador	143	7
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
7404	172	1
flat	173	1
Soquete	39	1
Diodo LED	23	1
Conector	11	1
Placa Módulo	179	1
TIC263D	175	1
Half Bridge	176	1
DCDC	180	1
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

COPY public.location_entry (id, location_id, component_id, quant_unit, quant_min, quant, labels, box) FROM stdin;
1170	74	1276	0	0	10		1
278	81	346	0	0	25		1
1156	74	1263	0	0	2		2
1146	74	1258	0	0	5		2
1124	74	95	0	0	50		2
1135	74	1250	0	0	50		3
1158	74	1265	0	0	2		1
271	81	350	0	0	45		1
1147	74	809	0	0	5		2
1145	74	1257	0	0	10		2
1171	74	1277	0	0	10		2
1136	74	659	0	0	50		2
268	81	347	0	0	19		1
1148	74	15	0	0	3		2
1126	74	1249	0	0	50		2
1134	74	117	0	0	50		3
1161	74	1267	0	0	10		3
1138	74	1251	0	0	50		1
1162	74	1269	0	0	3		1
273	81	345	0	0	19		1
266	81	351	0	0	2		1
1149	74	1259	0	0	1		2
1127	74	27	0	0	50		2
1139	74	682	0	0	10		1
1150	74	1260	0	0	6		1
1163	74	1270	0	0	3		1
274	81	419	0	0	5		1
269	81	348	0	0	7		1
1140	74	1253	0	0	6		1
1151	74	1261	0	0	5		1
275	81	416	0	0	15		1
277	81	1065	0	0	1		1
1164	74	1271	0	0	2		2
1129	74	28	0	0	50		2
1141	74	197	0	0	20		1
1152	74	412	0	0	10		1
279	81	62	0	0	186		1
270	81	349	0	0	3		1
1165	74	1272	0	0	15		3
1130	74	1278	0	0	50		2
1142	74	1254	0	0	10		1
1153	74	183	0	0	10		1
276	81	63	0	0	11		1
280	81	316	0	0	1		2
281	81	318	0	0	9		2
282	81	319	0	0	8		2
283	81	320	0	0	5		2
284	81	321	0	0	2		2
285	81	323	0	0	1		2
286	81	484	0	0	1		2
287	81	854	0	0	0		2
1804	35	708	0	0	0		2
289	81	448	0	0	4		2
290	81	460	0	0	4		2
291	81	147	0	0	54		2
292	81	317	0	0	2		2
294	81	338	0	0	4		3
295	81	64	0	0	0		3
296	81	325	0	0	10		3
297	81	330	0	0	2		3
298	81	332	0	0	0		3
299	81	333	0	0	1		3
300	81	334	0	0	20		3
301	81	335	0	0	0		3
302	81	336	0	0	0		3
303	81	337	0	0	3		3
304	81	342	0	0	2		3
305	81	343	0	0	0		3
306	81	341	0	0	3		3
307	81	824	0	0	1		3
308	81	331	0	0	0		3
309	81	327	0	0	8		3
310	81	340	0	0	9		3
311	81	823	0	0	0		3
312	81	344	0	0	3		3
313	81	329	0	0	0		3
314	81	1066	0	0	1		3
315	81	339	0	0	159		3
316	81	326	0	0	19		3
317	81	328	0	0	33		3
318	81	224	0	0	3		4
319	81	222	0	0	8		4
320	81	215	0	0	3		4
321	81	230	0	0	3		4
322	81	231	0	0	0		4
323	81	236	0	0	2		4
324	81	237	0	0	1		4
325	81	228	0	0	7		4
1186	82	1260	2	0	9	  ISO4 ISO7	1
1193	82	39	2	0	20	  Q4 Q5	1
1176	82	1279	1	0	10	 C23	1
1173	82	21	51	0	140	 C5 C6 C7 C9 C10 C12 C15 C27 C29 C31 C33 C42 CD1 CD1A CD2 CD3 CD4 CD5 CD6 CD8 CD9 CD10 CD11 CD12 CD13 CD14 CD15 CD16 CD17 CD23 CD29 CS1A CS1B CS2A CS2B CS3A CS3B CS4A CS4B CS5A CS5B CS6A CS6B CS7A CS7B CS8A CS8B CS10A CS10B CS11A CS11B	3
1128	74	99	0	0	20		2
1174	82	64	4	0	9	 C1 C8 C18 C20 CD1B	1
1199	82	1291	3	0	6	  U8 U9 U10	1
1198	82	1290	2	0	6	  U6 U16	1
1137	74	21	0	0	110		1
1194	82	515	3	0	6	  Q3 Q6 Q7	1
1205	82	184	1	0	6	  U23	1
1195	82	1289	1	0	5	  U2	1
1177	82	1280	6	0	10	 C2 C3 C4 C30 C34 C35	1
1197	82	186	1	0	2	  U4	1
1196	82	88	2	0	3	   U3 U5	1
1179	82	1282	2	0	10	 C38 C39	1
1178	82	1281	2	0	10	 C36 C37	1
1175	82	1251	3	0	15	  C17 C21 C28	1
1212	82	117	1	0	50	 R54	1
1221	82	1301	1	0	50	 R57	1
1218	82	1299	1	0	50	 R47	1
1222	82	1302	2	0	50	 RR53 R64	1
326	81	241	0	0	2		4
327	81	244	0	0	4		4
328	81	221	0	0	10		4
329	81	238	0	0	4		4
330	81	270	0	0	4		4
332	81	280	0	0	8		4
333	81	552	0	0	1		4
334	81	269	0	0	3		4
335	81	273	0	0	13		4
336	81	220	0	0	2		4
1157	74	1264	0	0	8	 	1
331	81	279	0	0	12	 	4
790	81	413	0	0	2		5
791	81	414	0	0	4		5
792	81	415	0	0	41		5
793	81	418	0	0	10		5
1159	74	38	0	0	9	 	3
794	81	420	0	0	3		5
795	81	422	0	0	10		5
796	81	423	0	0	20		5
797	81	424	0	0	10		5
798	81	425	0	0	26		5
799	81	426	0	0	17		5
800	81	427	0	0	24		5
801	81	429	0	0	13		5
802	81	825	0	0	4		5
803	81	421	0	0	7		5
804	81	417	0	0	171		5
805	81	84	0	0	37		5
806	81	83	0	0	2		5
807	81	82	0	0	23		5
808	81	110	0	0	58		5
809	81	109	0	0	84		5
810	81	108	0	0	22		5
1166	74	1273	0	0	2		2
1131	74	643	0	0	50		3
1143	74	1255	0	0	10		1
1154	74	1262	0	0	2		1
267	81	315	0	0	47		1
1167	74	1274	0	0	10		2
1132	74	114	0	0	50		3
1215	82	1297	0	0	50		1
1144	74	1256	0	0	10		1
272	81	352	0	0	51		1
1155	74	886	0	0	5		2
1133	74	648	0	0	50		3
1168	74	1268	0	0	10		3
1192	82	38	0	0	20		1
1226	82	660	0	0	50		1
10	0	1	0	0	10		1
11	0	3	0	0	0		1
12	0	4	0	0	0		1
13	0	6	0	0	0		1
14	0	885	0	0	1		1
15	0	35	0	0	4		1
16	0	7	0	0	0		1
18	0	11	0	0	0		1
19	0	16	0	0	0		1
20	0	34	0	0	0		1
21	0	36	0	0	5		1
22	0	40	0	0	10		1
23	0	42	0	0	100		1
24	0	45	0	0	0		1
25	0	47	0	0	0		1
26	0	54	0	0	10		1
27	0	171	0	0	1		1
28	0	58	0	0	20		1
29	0	60	0	0	50		1
30	0	85	0	0	20		1
31	0	57	0	0	74		1
32	0	87	0	0	0		1
33	0	89	0	0	0		1
34	0	103	0	0	0		1
35	0	111	0	0	0		1
36	0	124	0	0	0		1
37	0	129	0	0	0		1
38	0	130	0	0	0		1
39	0	194	0	0	0		1
40	0	195	0	0	0		1
41	0	121	0	0	0		1
42	0	138	0	0	10		1
43	0	139	0	0	20		1
44	0	206	0	0	0		1
45	0	152	0	0	0		1
46	0	177	0	0	1		1
48	0	172	0	0	0		1
49	0	212	0	0	0		1
50	0	187	0	0	0		1
53	0	192	0	0	0		1
54	0	191	0	0	0		1
55	0	193	0	0	0		1
56	0	196	0	0	0		1
57	0	200	0	0	0		1
58	0	201	0	0	0		1
60	0	296	0	0	0		1
61	0	43	0	0	0		1
62	0	385	0	0	0		1
63	0	436	0	0	0		1
64	0	443	0	0	0		1
65	0	445	0	0	0		1
66	0	450	0	0	0		1
67	0	462	0	0	0		1
69	0	465	0	0	0		1
70	0	468	0	0	0		1
71	0	470	0	0	0		1
72	0	543	0	0	0		1
74	0	362	0	0	0		1
75	0	52	0	0	0		1
76	0	53	0	0	1		1
77	0	841	0	0	0		1
78	0	842	0	0	0		1
79	0	880	0	0	0		1
80	0	438	0	0	0		1
81	0	922	0	0	1		1
82	0	921	0	0	1		1
83	0	151	0	0	0		1
84	0	927	0	0	1		1
85	0	928	0	0	0		1
86	0	929	0	0	0		1
87	0	930	0	0	0		1
1190	82	594	1	0	5	  IC1	1
1200	82	1292	2	0	6	  U11 U12	1
1180	82	1283	1	0	10	 C40	1
1182	82	1285	1	0	3	 C22	1
1191	82	1288	2	0	10	 JP12 JP19	1
1224	82	1278	1	0	50	 R67	1
88	0	932	0	0	0		1
89	0	935	0	0	0		1
90	0	178	0	0	50		1
91	0	74	0	0	14		1
92	0	75	0	0	30		1
93	0	963	0	0	1		1
94	0	188	0	0	0		1
96	0	966	0	0	12		1
97	0	41	0	0	76		1
98	0	1032	0	0	0		1
99	0	127	0	0	0		1
100	0	1077	0	0	2		1
101	0	1084	0	0	1		1
102	0	1070	0	0	0		1
103	0	1071	0	0	0		1
104	0	1072	0	0	89		1
105	0	1073	0	0	148		1
106	0	1074	0	0	4		1
107	0	1079	0	0	0		1
108	0	1080	0	0	0		1
109	0	1081	0	0	0		1
110	0	1082	0	0	0		1
111	0	1083	0	0	0		1
112	0	1120	0	0	4		1
113	0	1126	0	0	1		1
114	0	1104	0	0	16		1
115	0	1085	0	0	10		1
116	0	1090	0	0	24		1
117	0	1091	0	0	2		1
118	0	1092	0	0	0		1
119	0	1093	0	0	58		1
120	0	1094	0	0	0		1
121	0	1095	0	0	28		1
122	0	1096	0	0	0		1
123	0	1097	0	0	0		1
124	0	974	0	0	4		1
125	0	1098	0	0	0		1
126	0	1099	0	0	2		1
127	0	1103	0	0	0		1
128	0	1107	0	0	5		1
129	0	1110	0	0	0		1
130	0	1111	0	0	0		1
131	0	1112	0	0	0		1
132	0	1113	0	0	0		1
133	0	1114	0	0	0		1
134	0	1137	0	0	0		1
135	0	1124	0	0	0		1
136	0	1125	0	0	0		1
137	0	1135	0	0	0		1
138	0	1150	0	0	0		1
139	0	1152	0	0	0		1
140	0	917	0	0	50		1
141	0	1153	0	0	0		1
142	0	1157	0	0	0		1
143	0	1148	0	0	0		1
144	0	1158	0	0	0		1
145	0	1162	0	0	0		1
146	0	1170	0	0	0		1
147	0	1229	0	0	5		1
148	0	1228	0	0	10		1
149	0	1230	0	0	5		1
150	0	1231	0	0	30		1
151	0	1232	0	0	10		1
152	0	1235	0	0	4		1
153	0	1213	0	0	10		1
156	2	119	0	0	20		1
158	2	642	0	0	43		1
159	2	645	0	0	113		1
160	2	648	0	0	115		1
161	2	847	0	0	79		1
162	2	649	0	10	47		1
163	2	99	0	0	164		1
166	2	98	0	0	216		1
167	2	38	0	20	64		1
169	2	643	0	0	63		1
171	2	100	0	0	86		1
172	2	112	0	0	5		1
173	2	650	0	0	49		1
174	2	651	0	0	77		1
175	2	116	0	0	84		1
176	2	644	0	0	102		1
2023	48	107	0	0	0		2
2024	48	1025	0	0	0		2
2025	48	72	0	0	0		2
2026	48	1018	0	0	0		2
2027	48	1019	0	0	0		2
2028	48	1020	0	0	0		2
170	2	115	0	10	18		1
2029	48	1021	0	0	0		2
2030	48	1022	0	0	0		2
2031	48	1023	0	0	0		2
2032	48	1024	0	0	0		2
2033	48	1026	0	0	0		2
2034	48	533	0	0	0		2
2035	48	73	0	0	0		2
2036	48	1003	0	0	0		2
2037	48	1027	0	0	0		2
2038	48	1009	0	0	0		2
2039	48	467	0	0	0		2
2040	48	1123	0	0	0		2
2041	48	537	0	0	0		2
2042	48	205	0	0	0		2
2141	19	97	0	0	0		4
2142	19	160	0	0	0		4
2143	19	728	0	0	0		4
337	11	355	0	0	1		1
338	11	356	0	0	2		1
339	11	358	0	0	10		1
340	11	360	0	0	1		1
341	11	361	0	0	4		1
342	11	366	0	0	174		1
343	11	367	0	0	0		1
344	11	368	0	0	45		1
345	11	369	0	0	1		1
346	11	384	0	0	1		1
347	11	383	0	0	7		1
348	11	829	0	0	2		1
349	11	363	0	0	8		1
350	11	830	0	0	2		1
351	11	364	0	0	16		1
352	11	577	0	0	82		1
353	11	365	0	0	31		1
354	11	208	0	0	41		1
356	11	357	0	0	28		1
357	11	1163	0	0	10		1
412	11	557	0	0	14		5
1805	35	696	0	0	0		2
1806	35	695	0	0	0		2
1807	35	700	0	0	0		2
1808	35	699	0	0	0		2
1809	35	947	0	0	0		2
1810	35	710	0	0	0		2
1811	35	246	0	0	0		2
1812	35	701	0	0	0		2
1813	35	223	0	0	0		2
1814	35	243	0	0	0		2
413	11	491	0	0	12		5
414	11	554	0	0	10		5
415	11	523	0	0	5		5
416	11	559	0	0	20		5
417	11	560	0	0	10		5
418	11	561	0	0	4		5
419	11	562	0	0	10		5
420	11	563	0	0	4		5
421	11	564	0	0	10		5
422	11	566	0	0	2		5
423	11	474	0	0	20		5
424	11	558	0	0	21		5
425	11	412	0	10	0		5
426	11	493	0	0	14		5
427	11	1064	0	0	0		5
155	0	892	0	0	0		1
428	11	128	0	0	55		5
394	11	410	0	0	4		3
393	11	409	0	0	9		3
382	11	382	0	0	1		3
384	11	388	0	0	10		3
386	11	390	0	0	5		3
398	11	833	0	0	9		3
388	11	396	0	0	5		3
383	11	387	0	0	11		3
391	11	407	0	0	10		3
392	11	408	0	0	1		3
395	11	831	0	0	13		3
381	11	392	0	0	4		3
355	11	165	0	0	5		1
487	19	617	0	0	2		1
488	19	618	0	0	2		1
489	19	620	0	0	1		1
490	19	621	0	0	2		1
491	19	623	0	0	4		1
492	19	624	0	0	4		1
493	19	626	0	0	4		1
494	19	627	0	0	2		1
495	19	628	0	0	2		1
496	19	629	0	0	2		1
497	19	630	0	0	2		1
498	19	632	0	0	2		1
499	19	633	0	0	25		1
500	19	634	0	0	7		1
501	19	635	0	0	2		1
502	19	637	0	0	1		1
503	19	638	0	0	2		1
504	19	639	0	0	3		1
505	19	640	0	0	5		1
506	19	528	0	0	5		1
507	19	616	0	0	18		1
508	19	641	0	0	10		1
509	19	113	0	0	16		1
510	19	482	0	0	24		1
511	19	44	0	0	5		1
512	19	183	0	0	20		1
2043	48	980	0	0	0		3
2044	48	983	0	0	0		3
2045	48	977	0	0	0		3
2046	48	978	0	0	0		3
2047	48	979	0	0	0		3
2048	48	146	0	0	0		3
2049	48	982	0	0	0		3
2050	48	984	0	0	0		3
2051	48	986	0	0	0		3
2052	48	987	0	0	0		3
2053	48	988	0	0	0		3
2054	48	989	0	0	0		3
2055	48	990	0	0	0		3
2056	48	991	0	0	0		3
2057	48	992	0	0	0		3
2058	48	993	0	0	0		3
2059	48	994	0	0	0		3
2060	48	985	0	0	0		3
2061	48	981	0	0	0		3
2062	48	1050	0	0	0		3
2144	19	1115	0	0	0		5
2145	19	136	0	0	0		5
2146	19	1116	0	0	0		5
2147	19	1118	0	0	0		5
2148	19	135	0	0	0		5
2149	19	1117	0	0	0		5
1815	35	698	0	0	0		2
1816	35	711	0	0	0		2
1817	35	704	0	0	0		2
1818	35	705	0	0	0		2
1819	35	918	0	0	0		2
1820	35	703	0	0	0		2
1821	35	709	0	0	0		2
1822	35	707	0	0	0		2
1823	35	102	0	0	0		2
1824	35	702	0	0	0		2
1825	35	88	0	0	0		2
591	23	814	0	0	21		1
592	23	815	0	0	17		1
593	23	816	0	0	23		1
594	23	817	0	0	7		1
595	23	154	0	0	33		1
596	23	155	0	0	35		1
599	23	371	0	0	3		1
600	23	148	0	0	0		1
601	23	818	0	0	18		1
602	23	1227	0	0	1		1
1955	25	861	0	0	0		5
1956	25	862	0	0	0		5
621	25	289	0	0	3		1
622	25	290	0	0	6		1
623	25	291	0	0	41		1
624	25	292	0	0	20		1
625	25	293	0	0	8		1
626	25	294	0	0	6		1
627	25	295	0	0	6		1
628	25	298	0	0	4		1
629	25	299	0	0	17		1
630	25	300	0	0	1		1
631	25	301	0	0	2		1
632	25	302	0	0	2		1
633	25	303	0	0	16		1
634	25	304	0	0	47		1
635	25	305	0	0	4		1
636	25	306	0	0	1		1
637	25	307	0	0	1		1
638	25	308	0	0	1		1
639	25	309	0	0	1		1
640	25	310	0	0	1		1
641	25	311	0	0	1		1
642	25	312	0	0	1		1
643	25	314	0	0	21		1
644	25	288	0	0	21		1
645	25	93	0	0	11		1
646	25	297	0	0	34		1
647	26	898	0	0	7		1
648	26	1061	0	0	0		1
649	26	1062	0	0	0		1
650	26	78	0	0	46		1
651	26	79	0	0	39		1
1957	25	866	0	0	0		5
1958	25	867	0	0	0		5
1959	25	868	0	0	0		5
1960	25	173	0	0	0		5
1961	25	863	0	0	0		5
1962	25	174	0	0	0		5
1963	25	176	0	0	0		5
1964	25	865	0	0	0		5
1965	25	923	0	0	0		5
1966	25	924	0	0	0		5
1967	25	957	0	0	0		5
1968	25	956	0	0	0		5
1969	25	864	0	0	0		5
1981	25	712	0	0	0		6
1982	25	713	0	0	0		6
1983	25	714	0	0	0		6
1984	25	715	0	0	0		6
1985	25	716	0	0	0		6
1986	25	719	0	0	0		6
1987	25	690	0	0	0		6
1988	25	691	0	0	0		6
1989	25	692	0	0	0		6
1990	25	693	0	0	0		6
1991	25	694	0	0	0		6
1992	25	697	0	0	0		6
1993	25	720	0	0	0		6
1994	25	721	0	0	0		6
1995	25	725	0	0	0		6
1996	25	852	0	0	0		6
1997	25	706	0	0	0		6
1998	25	1055	0	0	0		6
1999	25	1214	0	0	0		6
2063	48	1240	0	0	0		5
2064	48	1241	0	0	0		5
2065	48	1237	0	0	0		5
2066	48	1119	0	0	0		5
2067	48	114	0	0	0		5
2068	48	1127	0	0	0		5
2069	48	1134	0	0	0		5
2070	48	1128	0	0	0		5
2071	48	1131	0	0	0		5
2072	48	1109	0	0	0		5
2073	48	1105	0	0	0		5
2074	48	1108	0	0	0		5
2075	48	1132	0	0	0		5
2076	48	1106	0	0	0		5
2077	48	1129	0	0	0		5
2078	48	1160	0	0	0		5
2079	48	1161	0	0	0		5
2080	48	1236	0	0	0		5
2081	48	1238	0	0	0		5
2082	48	1239	0	0	0		5
723	35	249	0	0	74		1
724	35	235	0	0	10		1
725	35	239	0	0	6		1
726	35	225	0	0	17		1
728	35	251	0	0	10		1
729	35	242	0	0	1		1
730	35	227	0	0	1		1
731	35	253	0	0	4		1
732	35	216	0	0	6		1
733	35	258	0	0	13		1
734	35	259	0	0	27		1
735	35	261	0	0	9		1
736	35	219	0	0	4		1
737	35	265	0	0	23		1
738	35	551	0	0	3		1
739	35	247	0	0	5		1
740	35	727	0	0	0		1
741	35	234	0	0	37		1
742	35	726	0	0	0		1
1893	35	472	0	0	0		6
1894	35	473	0	0	0		6
1895	35	476	0	0	0		6
1896	35	477	0	0	0		6
1897	35	478	0	0	0		6
1898	35	479	0	0	0		6
1899	35	480	0	0	0		6
1900	35	481	0	0	0		6
1901	35	485	0	0	0		6
1902	35	486	0	0	0		6
1903	35	487	0	0	0		6
1904	35	490	0	0	0		6
1905	35	492	0	0	0		6
1906	35	495	0	0	0		6
1907	35	500	0	0	0		6
897	48	903	0	0	1		1
898	48	1010	0	0	98		1
899	48	435	0	0	4		1
900	48	432	0	0	7		1
901	48	535	0	0	107		1
902	48	1007	0	0	105		1
903	48	1004	0	0	192		1
904	48	1008	0	0	94		1
905	48	1012	0	0	24		1
906	48	1014	0	0	50		1
907	48	1015	0	0	122		1
908	48	1016	0	0	333		1
909	48	1017	0	0	9		1
910	48	458	0	0	180		1
912	48	536	0	0	149		1
913	48	534	0	0	71		1
914	48	1011	0	0	171		1
919	50	1144	0	0	333		1
920	50	571	0	0	207		1
921	50	572	0	0	155		1
922	50	1151	0	0	20		1
923	50	1169	0	0	51		1
924	50	1180	0	0	53		1
925	50	1181	0	0	52		1
926	50	1185	0	0	15		1
927	50	1184	0	0	5		1
928	50	1149	0	0	55		1
929	50	1183	0	0	21		1
930	50	1168	0	0	223		1
953	52	186	0	0	98		1
954	52	8	0	0	9		1
955	56	919	0	0	0		1
2084	48	660	0	0	0		6
2085	48	37	0	0	0		6
2086	48	664	0	0	0		6
1016	61	1088	0	0	6		1
1017	61	1075	0	10	29		1
1018	61	1089	0	0	9		1
1019	61	1147	0	0	166		1
1020	61	1167	0	0	92		1
1021	61	1174	0	0	11		1
1022	61	1171	0	0	43		1
1023	61	1172	0	0	7		1
1024	61	1173	0	0	5		1
1025	61	1175	0	0	7		1
1026	61	1176	0	0	10		1
1027	61	1177	0	0	3		1
1028	61	1178	0	0	4		1
1029	61	1179	0	0	30		1
1036	63	86	0	0	40		1
1037	63	169	0	0	81		1
1038	63	1078	0	0	34		1
1039	63	1139	0	0	9		1
1040	63	1155	0	0	7		1
1041	63	1138	0	0	8		1
1042	63	1154	0	0	6		1
1043	63	1143	0	0	10		1
1044	63	1142	0	0	43		1
1045	63	1141	0	0	16		1
1046	63	1140	0	0	16		1
1047	63	1156	0	0	7		1
1048	64	1087	0	0	9		1
1049	64	1076	0	10	31		1
1050	64	1146	0	0	91		1
2083	48	661	0	0	180	 	6
1051	64	1145	0	0	152		1
1052	64	1199	0	0	15		1
1053	64	1200	0	0	15		1
1054	65	1063	0	0	4		1
1055	65	718	0	0	3		1
1056	66	1212	0	0	10		1
1057	66	1182	0	0	37		1
1058	66	1186	0	0	20		1
1059	66	1187	0	0	11		1
1060	66	1188	0	0	20		1
1061	66	1189	0	0	3		1
1062	66	1190	0	0	3		1
1063	66	1191	0	0	3		1
1064	66	1192	0	0	16		1
1065	66	1193	0	0	36		1
1066	66	1194	0	0	40		1
1067	66	1195	0	0	15		1
1068	66	1196	0	0	4		1
1069	66	1197	0	0	6		1
1070	66	1198	0	0	5		1
1071	67	1201	0	0	1		1
1072	67	1202	0	0	1		1
1073	67	1203	0	0	1		1
1074	67	1166	0	0	1		1
1075	67	1204	0	0	1		1
1076	67	1205	0	0	1		1
1077	67	1206	0	0	1		1
1078	67	1207	0	0	1		1
1079	67	1208	0	0	1		1
1080	67	1209	0	0	1		1
1081	67	1210	0	0	1		1
1082	67	1211	0	0	1		1
1169	74	1275	0	0	5		1
1184	82	97	0	0	10		2
1188	82	84	3	0	15	 DS1 DS4 DS5	2
1203	82	1294	1	0	5	  U15	2
1206	82	1295	1	0	3	  U29	2
1185	82	1287	1	0	10	 D13	2
1187	82	1286	1	0	5	 D12	2
1189	82	1277	6	0	20	 FB1 FB3 FB4 FB6 FB7 FB8	2
1223	82	1303	1	0	10	 R65	2
1207	82	95	6	0	50	 R1 R41 R55 R83 R94 R95	2
1217	82	653	2	0	50	 R45 R60	2
1183	82	92	7	0	40	   D1 D2 D8 D15 D16 D17 D18	2
2087	48	666	0	0	0		6
2088	48	461	0	0	0		6
2089	48	663	0	0	0		6
2090	48	658	0	0	0		6
2091	48	654	0	0	0		6
2092	48	655	0	0	0		6
2093	48	656	0	0	0		6
2094	48	653	0	0	0		6
2095	48	652	0	0	0		6
2096	48	668	0	0	0		6
2097	48	662	0	0	0		6
2098	48	106	0	0	0		6
2099	48	667	0	0	0		6
2100	48	665	0	0	0		6
2101	48	657	0	0	0		6
2102	48	26	0	0	0		6
2103	48	647	0	0	0		6
1209	82	28	2	0	50	 R82 R84	2
1220	82	646	3	0	50	  R52 R76 R92	2
1826	35	780	0	0	0		3
1827	35	781	0	0	0		3
1828	35	786	0	0	0		3
1829	35	787	0	0	0		3
1830	35	788	0	0	0		3
1831	35	789	0	0	0		3
1832	35	790	0	0	0		3
1833	35	798	0	0	0		3
1834	35	799	0	0	0		3
1835	35	800	0	0	0		3
1836	35	801	0	0	0		3
1837	35	797	0	0	0		3
1838	35	792	0	0	0		3
1839	35	802	0	0	0		3
1840	35	795	0	0	0		3
1841	35	793	0	0	0		3
1842	35	794	0	0	0		3
1843	35	784	0	0	0		3
1844	35	803	0	0	0		3
1845	35	785	0	0	0		3
652	11	553	0	0	9		4
653	11	547	0	0	5		4
654	11	313	0	0	2		4
655	11	538	0	0	1		4
656	11	540	0	0	8		4
657	11	542	0	0	19		4
658	11	544	0	0	1		4
659	11	545	0	0	3		4
660	11	546	0	0	39		4
661	11	548	0	0	4		4
662	11	549	0	0	20		4
663	11	550	0	0	10		4
664	11	91	0	0	57		4
665	11	531	0	0	48		4
1272	88	1217	2	0	0	JP2 JP3	1
1244	87	1299	1	0	0	R9	2
1241	87	1306	2	0	50	 R2 R18	2
1254	87	148	1	0	10	 U1	2
1230	87	64	4	0	0	C4 C11 C13 C16	1
1268	87	23	1	0	11	SEP1	2
1236	87	464	1	0	4	 Q1	2
1249	87	96	2	0	10	R1 R19	1
1243	87	1121	1	0	47	R8	1
1273	88	21	5	0	0	C1 C2 C3 C4 C5	1
1259	74	1310	0	0	9		3
1233	87	998	1	0	0	R4	1
1260	87	1310	3	0	1	F1 F2 F3	2
1252	87	80	1	0	2	 U3	1
1234	87	213	2	0	0	 U4 U5	1
1216	82	1298	2	0	6	   R42 R56	2
666	11	532	0	0	4		4
667	11	33	0	0	2		4
1247	87	93	2	0	10	 C6 C17	1
1248	87	1285	1	0	10	 C8	1
669	11	539	0	0	4		4
670	11	76	0	0	19		4
1846	35	783	0	0	0		3
1847	35	791	0	0	0		3
671	11	157	0	0	2		4
399	11	834	0	0	3		3
400	11	835	0	0	2		3
1255	11	0	0	0	0		3
402	11	395	0	0	19		3
403	11	937	0	0	19		3
404	11	938	0	0	2		3
406	11	399	0	0	6		3
727	35	240	0	0	0	 	1
407	11	398	0	0	1		3
408	11	185	0	0	5		3
409	11	397	0	0	5		3
401	11	836	0	0	10		3
411	11	405	0	0	10		3
1256	11	447	0	0	3		3
1257	11	1311	0	0	6		3
1258	11	1310	0	0	1		3
1225	82	1304	1	0	3	  R75	2
1274	88	1316	1	0	0	C6	1
1275	88	839	1	0	0	U4	1
1262	87	1312	3	0	0	F1 F2 F3	1
1238	87	1309	1	0	2	 U7	1
1231	87	426	1	0	0	 C7	1
1263	87	433	2	0	0	D1 D2	1
1237	87	717	1	0	2	U1	1
1239	87	125	1	0	6	 U6	1
1251	87	1305	1	0	6	 U2	1
1276	88	66	1	0	0	Z1	1
1264	87	92	1	0	236	D3	1
1245	87	968	8	0	50	 R3 R6 R7 R11 R12 R13 R14 R15 	2
1269	87	1314	1	0	0	R10	1
1270	88	28	4	0	0	R1 R2 R3 R4	1
1271	88	1315	1	0	0	JP1	1
1277	88	1317	4	0	0	CN1 CN2 CN3 CN4	1
1278	88	1318	1	0	0	U1	1
1279	88	184	1	0	0	U2	1
1280	88	1319	1	0	0	U3	1
1281	88	208	1	0	0	JP4	1
1253	87	149	2	0	0	U3 U7	2
1240	87	21	6	0	0	C1 C2 C3 C5 C9 C12 C15 	1
1250	87	1307	1	0	0	R16	2
1267	87	1313	1	0	0	R17	2
1202	82	1293	3	0	10	  U3 U14 U17	2
1242	87	646	1	0	44	R5	1
668	11	153	0	0	0		4
1384	93	99	3	0	0	R13 R22 R23	1
1428	89	643	2	0	0	R18 R37	1
1429	89	659	8	0	0	R8 R17 R27 R34 R40 R47 R54 R59	1
1430	89	1108	32	0	0	R2 R3 R6 R7 R9 R12 R15 R16 R20 R21 R25 R26 R28 R30 R32 R33 R35 R36 R38 R39 R42 R43 R46 R49 R50 R51 R52 R53 R56 R57 R58 R60	1
1431	89	1119	8	0	0	R5 R14 R24 R31 R41 R48 R55 R61	1
1426	89	649	3	0	0	R19 R29 R45	1
1433	89	1330	1	0	0	U9	1
1406	90	186	1	0	0	U17	1
1407	90	1276	1	0	0	U22	1
1385	93	24	1	0	0	R11	1
2104	19	735	0	0	0		3
1848	35	779	0	0	0		3
1386	93	1260	1	0	0	U4	1
1387	93	1333	1	0	0	U7	1
1443	90	21	25	0	0	 C4 C5 C6 C12 C18 C23 C25 C28 C49 C50  C29 C36 C37 C38 C39 C40 C41 C42 C43 C44 C45 C46 C47 C48 C53	1
1388	93	88	1	0	0	U10	1
1450	89	1260	3	0	0	U1 U13 U4	1
1435	89	1329	4	0	0	U3 U8 U12 U15	1
1389	93	1320	1	0	0	JP1	1
1390	93	1321	2	0	0	CN1 CN2	1
2105	19	736	0	0	0		3
1391	93	1322	2	0	0	EXTERNOS	1
1392	93	839	1	0	0	U14	1
1393	93	80	1	0	0	U16	1
1394	93	1217	1	0	0	JP2	1
1376	92	99	3	0	0	R66 R67 R97	1
1377	92	659	3	0	0	R73 R74 R95	1
1378	92	95	3	0	0	R70 R76 R93	1
1374	92	21	10	0	0	C30 C31 C32 C33 C34 C35 C51 C52 C54 C55 	1
1366	92	1327	3	0	0	U19 U21 U37	1
1369	92	1329	1	0	0	U20	1
1368	92	1335	1	0	0	U36	1
1380	92	1333	1	0	0	U18	1
1370	92	1260	1	0	0	U40	1
1381	93	64	2	0	0	C26 C27	1
1382	93	1316	1	0	0	C22	1
1395	93	1326	1	0	0	U5	1
1396	93	115	1	0	0	Q3	1
1397	93	965	1	0	0	Q2	1
1408	90	1260	2	0	0	U4 U32	1
1400	90	644	1	0	0	R88	1
1399	90	24	11	0	0	R11 R64 R82 R84 R85 R86 R89 R90 R91 R92 R96	1
1409	90	1333	2	0	0	U7 U23	1
1404	90	23	8	0	0	R62 R63 R69 R71 R72 R75 R77 R78	1
1484	90	649	4	0	0	R81 R83 R19 R29	1
1401	90	99	5	0	0	R13 R22 R23 R79 R80	1
1410	90	1325	1	0	0	U29	1
1411	90	1324	2	0	0	U26 U31	1
1412	90	1334	2	0	0	U30 U33	1
1413	90	1328	2	0	0	U27 U34	1
1414	90	145	2	0	0	U38 U41	1
1415	90	1318	1	0	0	U39	1
1416	90	144	1	0	0	U35	1
1466	89	21	25	0	0	 C1 C2 C7 C8 C9 C10 C11 C13 C14 C16 C17 C19 C20 C21 C24  C4 C5 C6 C12 C18 C23 C25 C28 C49 C50	1
1418	90	1327	2	0	0	U25 U28	1
1478	90	64	3	0	0	C3 C26 C27	1
1482	90	965	2	0	0	Q4 Q2	1
1402	90	1296	2	0	0	R10 R87	1
1422	90	92	9	0	0	D1 D2 D3 D4 D5 D6 D7 D8 D9	1
1424	89	153	1	0	0	C15	1
1462	89	115	2	0	0	Q1 Q3	1
1459	89	64	2	0	0	 C26 C27	1
1437	89	1336	1	0	0	U6	1
1438	89	1332	1	0	0	U11	1
1383	93	1296	1	0	0	R10	1
1439	93	649	2	0	0	R19 R29	1
1375	92	649	3	0	0	R65 R68 R94	1
1471	90	88	1	0	0	U10	1
1446	93	21	10	0	0	 C4 C5 C6 C12 C18 C23 C25 C28 C49 C50	1
1417	90	1326	2	0	0	U5 U24	1
1472	90	1320	1	0	0	JP1	1
1449	89	24	1	0	0	R11	1
1451	89	1333	1	0	0	U7	1
1452	89	88	1	0	0	U10	1
1453	89	1320	1	0	0	JP1	1
1454	89	1321	2	0	0	CN1 CN2	1
1455	89	1322	2	0	0	EXTERNOS	1
1456	89	839	1	0	0	U14	1
1457	89	80	1	0	0	U16	1
1458	89	1217	1	0	0	JP2	1
1460	89	1316	1	0	0	C22	1
1463	89	965	1	0	0	Q2	1
1473	90	1321	2	0	0	CN1 CN2	1
1474	90	1322	2	0	0	EXTERNOS	1
1475	90	839	1	0	0	U14	1
1476	90	80	1	0	0	U16	1
1477	90	1217	1	0	0	JP2	1
1479	90	1316	1	0	0	C22	1
1421	90	115	2	0	0	Q3 Q5	1
1461	89	1326	2	0	0	U2 U5	1
1425	89	99	5	0	0	R13 R22 R23 R1 R44	1
1464	89	1296	2	0	0	R4 R10	1
1636	23	159	0	0	0		3
1486	89	1308	32	0	0	   R2 R3 R6 R7 R9 R12 R15 R16 R20 R21 R25 R26 R28 R30 R32 R33 R35 R36 R38 R39 R42 R43 R46 R49 R50 R51 R52 R53 R56 R57 R58 R60 	1
1488	89	1338	8	0	0	  R5 R14 R24 R31 R41 R48 R55 R61 	1
1490	87	1339	0	0	17	 	2
1491	87	242	0	0	5	 	2
1492	87	1278	0	0	50	 	2
1493	87	1340	0	0	1	 	2
1494	87	1341	0	0	4	 	2
1495	87	1342	0	0	10	 	2
915	48	96	0	0	195		1
1849	35	1122	0	0	0		3
1850	35	850	0	0	0		3
1908	35	502	0	0	0		6
1909	35	507	0	0	0		6
1910	35	508	0	0	0		6
1911	35	509	0	0	0		6
1912	35	510	0	0	0		6
1913	35	511	0	0	0		6
1914	35	513	0	0	0		6
1915	35	515	0	0	0		6
1916	35	516	0	0	0		6
1917	35	517	0	0	0		6
1918	35	518	0	0	0		6
1919	35	519	0	0	0		6
1920	35	530	0	0	0		6
1921	35	729	0	0	0		6
1922	35	843	0	0	0		6
1923	35	489	0	0	0		6
1924	35	844	0	0	0		6
1925	35	520	0	0	0		6
1926	35	56	0	0	0		6
1927	35	49	0	0	0		6
1928	35	9	0	0	0		6
2106	19	197	0	0	0		3
2107	19	672	0	0	0		3
2108	19	673	0	0	0		3
2110	19	681	0	0	0		3
2111	19	670	0	0	0		3
2112	19	25	0	0	0		3
2113	19	860	0	0	0		3
2114	19	848	0	0	0		3
2115	19	949	0	0	0		3
2116	19	950	0	0	0		3
2117	19	678	0	0	0		3
2118	19	676	0	0	0		3
2119	19	39	0	0	0		3
2120	19	683	0	0	0		3
2121	19	29	0	0	0		3
2123	19	28	0	0	0		3
1851	35	856	0	0	0		4
1852	35	456	0	0	0		4
1497	82	1343	3	0	0	 JP10 JP11  JP15	3
1498	82	853	3	0	0	 JP10* JP11* JP15*	3
1499	82	1344	1	0	0	  JP6	3
1496	82	1333	8	0	0	  ISO1 ISO2 ISO3 ISO5 ISO6 ISO8 ISO10 ISO11	3
1501	82	1346	1	0	0	  U1	3
1505	82	649	15	0	0	 R17 R18 R19 R20 R21 R22 R23 R24 R34 R73 R74 R77 R78 R87 R106	3
1506	82	82	2	0	0	 DS2 DS3	3
1507	82	1348	5	0	0	 R4 R6 R7 R28 R35	3
1508	82	1349	3	0	0	 C16 C19 C26	4
1509	82	1350	2	0	0	 JP13 JP14	4
1510	82	855	3	0	0	 JP13* JP14*	4
1500	82	1345	1	0	0	 JP6* 	3
1511	82	1339	3	0	0	 D10 D11 D14	4
1219	82	1300	8	0	30	 R48(2) R49(2) R50(2) R51(2)	2
1512	82	2	6	0	0	 R97 R98 R99 R107 R108 R109 	4
1514	82	98	1	0	0	 R5	4
288	81	322	0	0	1	 ??	2
1853	35	889	0	0	0		4
1854	35	891	0	0	0		4
1855	35	902	0	0	0		4
1856	35	896	0	0	0		4
1857	35	897	0	0	0		4
1858	35	953	0	0	0		4
1859	35	952	0	0	0		4
1860	35	454	0	0	0		4
1861	35	853	0	0	0		4
1862	35	455	0	0	0		4
1863	35	855	0	0	0		4
1864	35	899	0	0	0		4
1865	35	900	0	0	0		4
1866	35	890	0	0	0		4
1867	35	1057	0	0	0		4
1868	35	1058	0	0	0		4
1869	35	1059	0	0	0		4
1870	35	901	0	0	0		4
1871	35	1246	0	0	0		4
1872	35	1245	0	0	0		4
1929	25	749	0	0	0		2
1930	25	753	0	0	0		2
1931	25	754	0	0	0		2
1932	25	755	0	0	0		2
1933	25	756	0	0	0		2
1934	25	920	0	0	0		2
1935	25	750	0	0	0		2
1558	107	569	0	0	0		1
1559	107	567	0	0	0		1
1560	107	570	0	0	0		1
1561	107	573	0	0	0		1
1562	107	574	0	0	0		1
1563	107	575	0	0	0		1
1564	107	354	0	0	0		1
1565	107	568	0	0	0		1
1566	107	578	0	0	0		1
1567	107	514	0	0	0		1
1568	107	512	0	0	0		1
1569	107	403	0	0	0		1
1570	107	404	0	0	0		1
1571	107	359	0	0	0		1
1572	107	576	0	0	0		1
1618	23	820	0	0	0		2
1619	23	821	0	0	0		2
1620	23	723	0	0	0		2
1621	23	724	0	0	0		2
1622	23	943	0	0	0		2
1623	23	944	0	0	0		2
1624	23	945	0	0	0		2
1625	23	822	0	0	0		2
1626	23	961	0	0	0		2
1627	23	962	0	0	0		2
1628	23	964	0	0	0		2
1629	23	428	0	0	0		2
1630	23	960	0	0	0		2
1631	23	959	0	0	0		2
1632	23	447	0	0	0		2
1633	23	946	0	0	0		2
1634	23	1225	0	0	0		2
1635	23	1247	0	0	0		2
1637	23	184	0	0	0		3
1638	23	805	0	0	0		3
1639	23	812	0	0	0		3
1640	23	813	0	0	0		3
1641	23	811	0	0	0		3
1642	23	807	0	0	0		3
1643	23	804	0	0	0		3
1644	23	737	0	0	0		3
1645	23	948	0	0	0		3
1646	23	77	0	0	0		3
1647	23	741	0	0	0		3
1648	23	1056	0	0	0		3
1649	23	738	0	0	0		3
1650	23	65	0	0	0		3
1651	23	144	0	0	0		3
1652	23	145	0	0	0		3
1653	23	433	0	0	0		3
1654	23	162	0	0	0		3
1655	23	809	0	0	0		3
1656	23	66	0	0	0		3
1657	23	757	0	0	0		4
1658	23	758	0	0	0		4
1659	23	759	0	0	0		4
1660	23	760	0	0	0		4
1661	23	761	0	0	0		4
1662	23	762	0	0	0		4
1663	23	763	0	0	0		4
1664	23	764	0	0	0		4
1665	23	766	0	0	0		4
1666	23	767	0	0	0		4
1667	23	768	0	0	0		4
1668	23	769	0	0	0		4
1669	23	770	0	0	0		4
1670	23	771	0	0	0		4
1671	23	772	0	0	0		4
1672	23	773	0	0	0		4
1673	23	774	0	0	0		4
1674	23	776	0	0	0		4
1675	23	777	0	0	0		4
1676	23	778	0	0	0		4
1677	23	431	0	0	0		4
1678	23	967	0	0	0		4
1679	23	765	0	0	0		4
1680	23	775	0	0	0		4
1936	25	459	0	0	0		3
1937	25	161	0	0	0		3
1938	25	888	0	0	0		3
1939	25	887	0	0	0		3
1940	25	995	0	0	0		3
1941	25	996	0	0	0		3
1942	25	936	0	0	0		3
1943	25	997	0	0	0		3
1944	25	998	0	0	0		3
1945	25	999	0	0	0		3
1681	23	878	0	0	0		5
1682	23	871	0	0	0		5
1683	23	430	0	0	0		5
1684	23	876	0	0	0		5
1685	23	877	0	0	0		5
1686	23	203	0	0	0		5
1687	23	883	0	0	0		5
1688	23	954	0	0	0		5
1689	23	81	0	0	0		5
1690	23	875	0	0	0		5
1691	23	840	0	0	0		5
1692	23	1067	0	0	0		5
1693	23	1068	0	0	0		5
1694	23	839	0	0	0		5
1695	23	879	0	0	0		5
1696	23	1101	0	0	0		5
1697	23	19	0	0	0		5
1698	23	164	0	0	0		5
1699	23	872	0	0	0		5
1700	23	20	0	0	0		5
1701	23	1100	0	0	0		5
1702	23	873	0	0	0		5
1703	23	886	0	0	0		5
1704	23	869	0	0	0		5
1705	23	870	0	0	0		5
1946	25	1000	0	0	0		3
1947	25	1001	0	0	0		3
1948	25	1002	0	0	0		3
1949	25	1005	0	0	0		3
1950	25	69	0	0	0		3
1951	25	71	0	0	0		3
1952	25	70	0	0	0		3
2000	19	262	0	0	0		2
2001	19	266	0	0	0		2
2002	19	277	0	0	0		2
1706	23	439	0	0	0		6
1707	23	837	0	0	0		6
1708	23	859	0	0	0		6
1709	23	446	0	0	0		6
1710	23	442	0	0	0		6
1711	23	142	0	0	0		6
1712	23	958	0	0	0		6
1713	23	933	0	0	0		6
1714	23	968	0	0	0		6
1715	23	970	0	0	0		6
1716	23	969	0	0	0		6
1717	23	971	0	0	0		6
1718	23	931	0	0	0		6
1719	23	972	0	0	0		6
2003	19	125	0	0	0		2
2004	19	281	0	0	0		2
2005	19	283	0	0	0		2
2006	19	284	0	0	0		2
2007	19	122	0	0	0		2
2008	19	287	0	0	0		2
2009	19	10	0	0	0		2
2010	19	444	0	0	0		2
2011	19	555	0	0	0		2
2012	19	256	0	0	0		2
2013	19	51	0	0	0		2
2014	19	1052	0	0	0		2
2015	19	1053	0	0	0		2
2016	19	1054	0	0	0		2
2017	19	1060	0	0	0		2
2018	19	976	0	0	0		2
2019	19	46	0	0	0		2
2020	19	50	0	0	0		2
1720	23	934	0	0	0		6
1721	23	90	0	0	0		6
1722	23	2	0	0	0		6
1723	23	451	0	0	0		6
1724	23	838	0	0	0		6
1725	23	1133	0	0	0		6
1726	23	80	0	0	0		6
1727	23	117	0	0	0		6
1728	23	95	0	0	0		6
1729	23	1242	0	0	0		6
1730	23	1215	0	0	0		6
1731	107	1244	0	0	0		2
1732	107	370	0	0	0		2
1733	107	389	0	0	0		2
1734	107	400	0	0	0		2
1735	107	401	0	0	0		2
1736	107	402	0	0	0		2
1737	107	832	0	0	0		2
1738	107	372	0	0	0		2
1739	107	373	0	0	0		2
1740	107	374	0	0	0		2
1741	107	375	0	0	0		2
1742	107	380	0	0	0		2
1743	107	381	0	0	0		2
1744	107	722	0	0	0		2
1745	107	826	0	0	0		2
1746	107	827	0	0	0		2
1747	107	828	0	0	0		2
1748	107	377	0	0	0		2
1749	107	466	0	0	0		2
1750	107	14	0	0	0		2
1751	107	15	0	0	0		2
1752	107	1159	0	0	0		2
1753	107	393	0	0	0		2
1754	107	1233	0	0	0		2
1755	107	1234	0	0	0		2
1756	107	17	0	0	0		2
1757	107	386	0	0	0		2
1758	107	406	0	0	0		2
1759	107	1243	0	0	0		2
1760	107	394	0	0	0		2
1761	107	580	0	0	0		4
1762	107	582	0	0	0		4
1763	107	583	0	0	0		4
1764	107	584	0	0	0		4
1765	107	585	0	0	0		4
1766	107	586	0	0	0		4
1767	107	587	0	0	0		4
1768	107	588	0	0	0		4
1769	107	589	0	0	0		4
1770	107	590	0	0	0		4
1771	107	591	0	0	0		4
1772	107	592	0	0	0		4
1773	107	501	0	0	0		4
1774	107	521	0	0	0		4
1775	107	524	0	0	0		4
1776	107	593	0	0	0		4
1777	107	499	0	0	0		4
1778	107	527	0	0	0		4
1779	107	120	0	0	0		4
1781	107	595	0	0	0		5
1782	107	597	0	0	0		5
1783	107	498	0	0	0		5
1784	107	598	0	0	0		5
1785	107	599	0	0	0		5
1786	107	600	0	0	0		5
1787	107	601	0	0	0		5
1788	107	602	0	0	0		5
1789	107	603	0	0	0		5
1790	107	604	0	0	0		5
1791	107	605	0	0	0		5
1792	107	255	0	0	0		5
1793	107	606	0	0	0		5
1794	107	608	0	0	0		5
1795	107	609	0	0	0		5
1796	107	610	0	0	0		5
1797	107	612	0	0	0		5
1798	107	615	0	0	0		5
1799	107	607	0	0	0		5
1800	107	614	0	0	0		5
1801	107	596	0	0	0		5
1802	107	254	0	0	0		5
1803	107	594	0	0	0		5
1873	35	1031	0	0	0		5
1874	35	1033	0	0	0		5
1875	35	1034	0	0	0		5
1876	35	1035	0	0	0		5
1877	35	1036	0	0	0		5
1878	35	1037	0	0	0		5
1879	35	1038	0	0	0		5
1880	35	1039	0	0	0		5
1881	35	1040	0	0	0		5
1882	35	1041	0	0	0		5
1883	35	1042	0	0	0		5
1884	35	1043	0	0	0		5
1885	35	1044	0	0	0		5
1886	35	1045	0	0	0		5
1887	35	1046	0	0	0		5
1888	35	1047	0	0	0		5
1889	35	1048	0	0	0		5
1890	35	1049	0	0	0		5
1891	35	1051	0	0	0		5
1892	35	170	0	0	0		5
1953	25	747	0	0	0		4
1954	25	748	0	0	0		4
1970	19	133	0	0	0		6
1971	19	132	0	0	0		6
1972	19	858	0	0	0		6
1973	19	1222	0	0	0		6
1974	19	1223	0	0	0		6
1975	19	1216	0	0	0		6
1976	19	1217	0	0	0		6
1977	19	1218	0	0	0		6
1978	19	1220	0	0	0		6
1979	19	1219	0	0	0		6
1980	19	1221	0	0	0		6
2021	19	285	0	0	0		2
2022	19	282	0	0	0		2
2124	19	688	0	0	0		4
2125	19	22	0	0	0		4
2126	19	684	0	0	0		4
2127	19	118	0	0	0		4
2128	19	686	0	0	0		4
2129	19	199	0	0	0		4
2130	19	198	0	0	0		4
2131	19	733	0	0	0		4
2132	19	734	0	0	0		4
2133	19	685	0	0	0		4
2134	19	849	0	0	0		4
2135	19	851	0	0	0		4
2136	19	955	0	0	0		4
2137	19	27	0	0	0		4
2138	19	30	0	0	0		4
2139	19	207	0	0	0		4
2140	19	671	0	0	0		4
597	23	149	0	0	0	 	1
2241	114	1379	0	0	4	 	1
2222	113	1365	1	0	0	 JP1	1
2154	111	1351	4	0	0	 	1
2155	111	1352	1	0	0	 	1
2156	111	279	1	0	0	 	1
2157	111	1353	1	0	0	 	1
2158	111	87	1	0	0	 	1
2159	111	1269	1	0	0	 	1
2160	111	1354	1	0	0	 	1
2161	111	1355	2	0	0	 	1
2213	113	1368	1	0	0	  CN3	1
2164	111	1356	1	0	0	 	1
2221	113	363	1	0	0	  U2	1
2169	111	62	16	0	0	 	1
2170	111	1360	2	0	0	 	1
2223	113	853	1	0	0	 CN2	1
2171	111	1361	1	0	0	  	1
2172	111	1362	1	0	0	 	1
2173	111	50	1	0	0	 	1
2187	112	62	4	0	0	  C3 C4 C5 C7	1
2197	112	346	1	0	0	  C2	1
2176	111	1364	2	0	0	 	1
2177	111	1117	3	0	0	  	1
2178	111	1118	1	0	0	 	1
2179	111	1217	19	0	0	 	1
2180	111	1365	4	0	0	 	1
2200	112	291	1	0	0	  C35	1
2189	112	33	2	0	0	  C1 C25	1
2190	112	329	1	0	0	  C11	1
2192	112	265	1	0	0	  U1	1
2206	112	240	16	0	0	 U4	1
2207	112	1367	16	0	0	 U10	1
2151	111	148	4	0	0	  	2
2152	111	817	2	0	0	 	2
2150	111	149	1	0	0	   	2
2153	111	150	1	0	0	 	2
2162	111	42	3	0	0	 	2
2163	111	850	1	0	0	 	2
2165	111	1357	1	0	0	 	2
2166	111	1358	1	0	0	 	2
2167	111	1359	1	0	0	 	2
2168	111	694	1	0	0	 	2
2174	111	896	1	0	0	 	2
2181	111	533	1	0	0	 	2
2184	111	536	5	0	0	 	2
2182	111	1021	7	0	0	  	2
2183	111	71	7	0	0	  	2
2185	111	983	2	0	0	 	2
2186	111	459	2	0	0	 	2
2224	113	454	1	0	0	 CN2	1
2226	114	0	0	0	0		1
2227	114	1369	0	0	5	 	1
2242	114	1381	0	0	5	 	1
2228	114	723	0	0	1	 	1
2230	114	386	0	0	4	 	1
2202	112	149	3	0	0	 U1 U10 U4	1
2203	112	1350	1	0	0	  JP1	1
2204	112	855	1	0	0	 JP1	1
2199	112	779	1	0	0	  D2	1
2188	112	797	2	0	0	  D1 D3	1
2201	112	1366	2	0	0	  Sopre IG1 e IG4	1
2194	112	533	2	0	0	  R4 R5	1
2196	112	458	1	0	0	  R1	1
2193	112	71	2	0	0	  R2 R3	1
2191	112	984	2	0	0	  R8 R18	1
2195	112	1314	1	0	0	  R6	1
2205	112	363	3	0	0	   U1 U4 U10	1
2198	112	714	2	0	0	  IG1 IG4	1
2231	114	1371	0	0	5	 	1
2210	113	648	5	0	0	 R1 R2 R3 R4 R5	1
2211	113	356	5	0	0	 PB1 PB2 PB3 PB4 PB5	1
2208	113	213	1	0	0	  U1	1
2209	113	594	1	0	0	  U3	1
2212	113	219	1	0	0	 U2	1
2214	19	1368	0	1	0	 	6
2215	113	2	1	0	0	 R6	1
2216	113	647	19	0	0	 R7	1
2217	113	21	4	0	0	 C3 C5 C6 C7	1
2218	113	64	2	0	0	 C2 C4	1
2219	113	329	1	0	0	 C1	1
2220	113	1216	1	0	0	 JP2	1
2232	114	224	0	0	2	 	1
2233	114	1372	0	0	6	 	1
2234	114	1373	1	0	1	 	1
2251	114	238	1	0	8	   	1
2235	114	1374	0	0	2	 	1
2236	114	442	0	0	3	 	1
2238	114	1376	0	0	20	 	1
2239	114	1377	0	0	4	 	1
2240	114	1378	0	0	1	 	1
2243	114	1380	0	0	5	 	1
2229	114	1370	1	0	6	   	1
2245	114	1384	0	0	6	 	1
2246	114	1383	0	0	2	 	1
2247	114	1385	0	0	3	 	1
2248	114	474	0	0	13	 	1
2249	114	1386	0	0	9	 	1
2244	114	1382	0	0	4	  	1
2250	114	524	0	0	7	 	1
2252	114	216	0	0	4	 	1
2253	114	607	0	0	12	 	1
2254	114	582	0	0	4	 	1
2122	19	680	0	0	2	 	3
2255	71	680	0	0	4	 	6
2256	71	1244	0	0	2	 	6
2257	71	1387	0	0	4	 	6
2258	71	1388	0	0	5	 	6
2259	115	706	3	0	0	 	1
2260	115	704	2	0	0	 	1
2261	115	713	3	0	0	 	1
2262	115	451	2	0	0	 	1
2263	115	40	2	0	0	 	1
2264	115	1389	2	0	0	 	1
2265	115	109	3	0	0	 	1
2266	115	356	3	0	0	 	1
2267	115	254	1	0	0	 	1
2268	115	455	1	0	0	  	1
2269	115	78	1	0	0	 	1
2270	115	1390	1	0	0	 	1
2271	115	9	1	0	0	 	1
2272	115	1361	1	0	0	 	1
2273	115	64	4	0	0	 	1
2274	115	1362	2	0	0	 	1
2275	115	1348	3	0	0	 	1
2276	115	971	3	0	0	 	1
2277	115	968	1	0	0	 	1
2278	115	654	1	0	0	 	1
2280	115	662	2	0	0	 	1
2282	115	1391	2	0	0	 	1
2283	115	98	2	0	0	 	1
2284	115	1308	1	0	0	 	1
2281	115	159	3	0	0	  	1
2285	115	928	2	0	0	 	1
2286	115	1014	1	0	0	 	1
2279	115	1307	4	0	0	  	1
2287	115	676	3	0	0	 	1
2288	115	213	1	0	0	 	1
2289	115	62	1	0	0	 	1
2290	115	148	2	0	0	 	1
2291	115	1392	2	0	0	 	1
2292	115	1393	1	0	0	 	1
2293	115	363	1	0	0	 	1
2294	115	150	1	0	0	 	1
2295	19	0	0	0	0		1
2297	117	95	4	0	0	 	1
2355	116	88	2	0	6	    U2, U4	1
2302	118	1282	2	0	34	  C35, C36	1
2310	116	157	1	0	19	  C41	1
2326	118	1264	1	0	4	    U7	1
2376	119	454	0	0	23		1
2322	118	1329	4	0	6	   U1, U2, U4, U5	1
2296	116	1282	1	0	0	 C1	1
2377	119	208	0	0	6		1
2305	116	21	21	0	0	 C3 C7 C13 C17 C23 C25 C27 C30-C34 C37 C38 C40 C44 C46-C50	1
2330	118	1354	1	0	9	   U11	1
2307	116	1397	1	0	0	 C5	1
2308	116	291	4	0	4	 C6, C15, C26, C35	1
2309	116	1251	10	0	50	 C8-C12, C16, C18, C20, C21, C22	1
2311	116	153	1	0	9	  C42	1
2324	118	1400	1	0	9	   U3	1
2378	119	165	0	0	1		1
2312	116	1396	1	0	0	 C44	1
2313	118	1340	2	0	0	 CN2, CN3	1
2306	116	1280	6	0	23	   C4 C14 C19 C24 C29 C36	1
2301	118	1395	6	0	0	    C34, C38, C41, C42, C45, C46. C37?	1
2316	118	659	8	0	0	 R46-R53	1
2304	116	1395	4	0	0	  C2, C28, C39, C45	1
2303	118	1396	1	0	9	  C39	1
2317	118	24	1	0	0	  R54	1
2340	116	659	10	0	13	     R1, R10, R15, R18, R22, R24, R27, R29, R45, R47	2
2315	118	970	3	0	47	 R43, R44, R45	2
1214	82	970	0	0	3		1
2337	118	1406	1	0	9	 FB4	1
2325	118	213	1	0	0	  U6	1
2336	118	1405	5	0	15	 FB1, FB2, FB3, FB5, FB6	1
2380	119	1423	0	0	5		1
2381	119	1424	0	0	8		1
598	23	150	0	0	53	 	1
2363	35	1412	0	0	3		1
2342	116	99	4	0	44	   R4, R7, R40, R42	2
2382	119	1425	0	0	10		1
2364	116	1413	2	0	1	U1 U2	1
2383	119	1426	0	0	6		1
2333	73	884	0	0	1		1
2354	116	1409	5	0	5	  U1, U3, U5, U8, U13	1
2386	119	363	0	0	21	 	2
2350	116	1296	6	0	44	  R26, R31, R34, R36, R41, R44	2
2344	116	1407	2	0	0	 R6, R12	2
2353	116	142	1	0	0	  R55	1
2345	116	1390	1	0	0	 R8	2
2356	116	1410	1	0	10	 U6	1
2346	116	23	1	0	0	 R9	2
2362	116	656	2	0	0	  R2 R3	2
2347	116	1408	5	0	0	 R13, R17, R23, R25, R38	2
2348	116	1314	5	0	0	 R14, RR19, R20, R35, R43	2
2367	119	1419	0	0	50		1
2360	116	727	1	0	0	 U12	1
2368	119	1420	0	0	50		1
2349	116	24	3	0	46	 R16,   R21, R28, R30	2
2299	118	21	36	0	243	    C1-C33, C40, C43, C44	1
2369	119	1338	0	0	50		1
2332	118	88	1	0	19	   U14	1
2359	116	213	1	0	0	   U14	1
2384	119	1390	0	0	3		1
2329	118	1346	2	2	6	  U12, U13	1
2351	116	100	4	0	0	 R32, R33, R37, R39	2
2370	119	1421	0	0	50		1
2352	116	117	10	0	0	 R46, R48 - R54, R56, R57	2
2327	118	1269	1	0	9	   U8	1
2361	116	277	1	0	5	 U15	2
2371	119	1422	0	0	300		1
2338	116	41	1	0	0	 FB	1
2372	119	1308	0	0	50		1
2358	116	1264	1	0	0	 U10	1
2314	118	971	42	0	0	 R1-R42	2
2385	119	1427	0	0	6		1
2318	118	1398	1	0	0	 R55	2
2319	118	1128	2	0	0	 R56, R57	2
2321	118	668	1	0	0	 R58	2
2335	118	1404	1	0	0	Q1	2
2373	119	855	0	0	19		1
2374	119	853	0	0	26		1
2375	119	455	0	0	9		1
2388	119	1415	0	0	20		2
2392	119	282	0	0	7		2
2393	119	1416	0	0	4		2
2394	119	1400	0	0	10		2
2395	119	1429	0	0	5		2
2397	119	873	0	0	5		2
2396	119	1430	0	0	15	 	2
2399	119	1431	0	0	10		2
2400	119	1432	0	0	12		2
2401	119	1433	0	0	4		2
2402	119	1434	0	0	5		2
2403	119	1435	0	0	5		2
2404	119	1436	0	0	9		2
2387	119	364	0	0	9	 	2
2407	119	713	0	0	17		3
2408	119	451	0	0	15		3
2409	119	40	0	0	6		3
2522	119	1481	0	0	10		8
2413	119	1437	0	0	8		3
2415	119	1438	0	0	2		3
2416	119	1440	0	0	10		3
2417	119	1441	0	0	10		3
2418	119	1358	0	0	20		3
2419	119	1442	0	0	100		3
2421	119	1405	0	0	20		3
2422	119	1058	0	0	6		3
2423	119	1444	0	0	6		3
2424	119	1445	0	0	10	 	3
2425	119	1271	0	0	3		3
2426	119	1361	0	0	10		4
2428	119	1446	0	0	5		4
2429	119	1395	0	0	20		4
2431	119	153	0	0	20		4
2398	119	1401	0	0	5	 	2
2343	116	664	2	0	46	   R5, R11	2
2405	119	1417	0	0	1	  	3
2420	119	1443	0	0	41	 	3
2366	119	1418	0	0	46	 	1
2391	119	1428	0	0	6	 	2
2357	116	1411	3	0	7	    U7, U9, U11	1
2432	119	1396	0	0	20		4
2433	119	1447	0	0	10		4
2434	119	1448	0	0	10		4
2365	119	1414	0	0	8	   	3
2427	119	1362	0	0	9	 	4
2435	119	339	0	0	29		4
2436	119	326	0	0	1		4
2437	119	329	0	0	1		4
2438	119	1449	0	0	6		4
2439	119	1450	0	0	15		4
2440	119	1451	0	0	1		4
2442	119	1453	0	0	1		4
2443	119	1454	0	0	38		5
2445	119	1455	0	0	10		5
2446	119	1456	0	0	10		5
2447	119	1457	0	0	20		5
2448	119	1458	0	0	10		5
2450	119	727	0	0	15		5
2451	119	1054	0	0	15		5
2452	119	726	0	0	15		5
2453	119	1459	0	0	15		5
2454	119	45	0	0	10		5
2455	119	1460	0	0	10		5
2456	119	125	0	0	4		5
2458	119	1461	0	0	50		6
2460	119	1463	0	0	4		6
2461	119	1294	0	0	2		6
2462	119	1346	0	0	1		6
2463	119	1464	0	0	2		6
2464	119	1465	0	0	6		6
2465	119	183	0	0	10		6
2466	119	88	0	0	8		6
2467	119	1295	0	0	2		6
2468	119	1260	0	0	4		6
2469	119	614	0	0	2		6
2470	119	1466	0	0	2		6
2471	119	1467	0	0	7		6
2473	119	829	0	0	4		7
2474	119	589	0	0	6		7
2475	119	474	0	0	1		7
2476	119	442	0	0	5		7
2477	119	220	0	0	1		7
2478	119	524	0	0	2		7
2479	119	1468	0	0	5		7
2480	119	715	0	0	2		7
2481	119	1469	0	0	4		7
2482	119	607	0	0	2		7
2483	119	498	0	0	1		7
2484	119	269	0	0	10		7
2485	119	258	0	0	10		7
2486	119	279	0	0	11		7
2487	119	1470	0	0	3		7
2488	119	265	0	0	1		7
2489	119	9	0	0	5		7
2490	119	1471	0	0	10		7
2491	119	1472	0	0	19		7
2492	119	779	0	0	20		8
2493	119	1473	0	0	6		8
2494	119	1474	0	0	64		8
2495	119	1475	0	0	6		8
2497	119	1477	0	0	20		8
2498	19	797	0	0	3		8
2499	119	1478	0	0	40		8
2500	119	801	0	0	50		8
2501	119	1480	0	0	1		8
2502	119	1389	0	0	3		8
2503	119	249	0	0	10		8
2504	119	558	0	0	8		8
2506	119	1483	0	0	9		8
2507	119	499	0	0	10		8
2508	119	1484	0	0	4		8
2509	119	84	0	0	6		8
2510	119	706	0	0	1		5
2441	119	1452	0	0	45	 	4
2511	119	764	0	0	8		6
2512	119	1485	0	0	10		6
2513	119	1345	0	0	2		4
2514	119	1344	0	0	1		4
2515	119	1486	0	0	40		3
2516	119	970	0	0	4		6
2517	119	106	0	0	44		6
2518	119	1301	0	0	36		6
2519	119	95	0	0	10		5
2520	119	1487	0	0	12		5
2521	119	1312	0	0	12		5
2523	119	1479	0	0	10		8
2524	120	1488	0	0	50	 	1
2525	121	1490	0	0	100	 	1
2526	121	1491	0	0	4	 	1
2527	121	1492	0	0	30		1
2528	23	1495	0	0	100		2
2529	23	1496	0	0	50		2
2530	82	112	0	0	6	 	2
2531	23	0	0	0	0		2
2533	120	1498	0	0	5	 	1
2536	132	1249	1	0	0	 	1
2537	132	1526	1	0	0	 	1
2538	132	369	1	0	0		1
1160	74	1266	0	0	26	 	3
2539	133	1346	2	0	0	  	1
2540	133	1289	1	0	0	 	1
2542	134	1527	1	0	0		1
2543	134	1497	1	0	0		1
2544	134	1528	1	0	0		1
2430	119	157	0	0	17	 	4
2449	119	213	0	0	14	 	5
2331	118	1402	3	0	2	   U9, U10, U15, U16	1
1181	82	1284	1	0	0	  C41	1
2109	19	677	0	0	5	 	3
2496	119	1476	0	0	19	 	8
2414	119	102	0	0	75	  	3
2457	119	702	0	0	98	 	5
2459	119	1462	0	0	46	 	6
911	48	1006	0	0	132	 	1
2551	137	1530	0	0	6		1
2547	136	0	0	0	0		1
2548	136	0	0	0	0		1
2549	136	1529	0	0	13		1
2550	137	1529	0	0	13		1
2552	137	1531	0	0	6		1
2553	137	1532	0	0	5		1
2554	137	1533	0	0	14		1
2555	137	1534	0	0	6		1
2562	137	1536	0	0	12		1
2563	138	1537	0	0	16		1
2564	137	1538	0	0	3		1
2565	138	1539	0	0	2		1
2566	138	1540	0	0	20		1
2567	138	1541	0	0	17		1
2560	137	1535	0	0	10	 	1
2505	119	1482	0	0	6	  	8
2568	138	1542	0	0	4		1
2569	138	1543	0	0	13		1
2570	138	1544	0	0	3		1
2572	138	1480	0	0	20		1
2573	138	1546	0	0	3		1
2574	138	1547	0	0	11		1
2576	138	1549	0	0	40		1
2579	138	1552	0	0	5		2
2581	138	1554	0	0	10		2
2584	138	1497	0	0	18	 	2
2585	138	1557	0	0	50		2
2586	138	1558	0	0	45		2
2587	138	1559	0	0	3		1
2588	138	1560	0	0	5		2
2577	138	1550	0	0	20	 	3
2583	138	1556	0	0	7	 	3
2578	138	1551	0	0	10	 	3
2582	138	1555	0	0	3	 	3
2580	138	1553	0	0	10	 	3
2589	138	0	0	0	0		2
2590	138	1561	0	0	10		2
2591	138	1562	0	0	5		2
2592	138	1563	0	0	20		2
2593	138	1564	0	0	3		3
2594	138	1565	0	0	3		3
2595	138	1566	0	0	10		3
2596	138	1294	0	0	6		3
2597	138	1567	0	0	6		3
2598	138	1568	0	0	1		3
2599	138	1569	0	0	20		2
2600	138	1570	0	0	40		3
2601	138	1289	0	0	20		3
2575	138	1548	0	0	10	 	1
2602	138	1571	0	0	6		4
1780	107	13	0	0	6	  	4
2604	35	1573	0	0	2	HCF4035BE	1
2605	35	1574	0	0	2		1
2606	35	1575	0	0	1		1
2603	138	1572	0	0	8	 	4
2607	138	1576	0	0	2		4
2608	138	1577	0	0	11		4
2609	119	240	0	0	10		2
2610	119	242	0	0	6		2
2611	137	1578	0	0	3		1
2612	137	1579	0	0	3		1
2613	138	1580	0	0	10		4
2614	138	1581	0	0	3		4
2615	138	635	0	0	10		4
2616	81	1582	0	0	10		4
2571	138	1545	0	0	3	 	1
2617	138	1583	0	0	3		4
2618	140	1294	1	0	0	 	1
2621	140	1442	2	0	0	 	1
2623	140	1584	1	0	0		1
2619	140	1558	1	0	1	  	1
2624	140	1585	3	0	0	 	1
2626	140	1586	3	0	0		1
2627	140	2	1	0	0		1
2628	140	659	6	0	0	 	1
2625	140	24	6	0	0	 	1
2630	140	112	2	0	0	 	1
2632	140	1588	2	0	0		1
2633	140	371	1	0	0		1
2637	140	1589	1	0	0		1
2638	140	1590	1	0	0		1
2639	140	117	3	0	0		1
2622	140	965	4	0	0	 	1
2640	140	1551	1	0	0		1
2642	140	1591	1	0	0		1
2643	140	455	3	0	0	 	1
2645	140	1592	3	0	0		1
2646	140	1593	1	0	0		1
2647	140	1594	1	0	0		1
2648	140	1595	1	0	0		1
2649	140	369	1	0	0		1
2650	140	1596	1	0	0		1
2651	140	1597	1	0	0		1
2653	140	1598	1	0	0		1
2654	140	1599	2	0	0		1
2655	140	26	1	0	0		1
2631	140	106	3	0	0	 	1
2656	140	647	1	0	0		1
2657	140	1314	2	0	0		1
2679	139	21	9	0	0		1
2680	139	1280	1	0	0		1
2681	139	1603	4	0	0		1
2682	139	305	1	0	0		1
2629	140	1587	2	0	0		1
2683	139	331	1	0	0		1
2673	140	343	1	0	0		1
2672	140	21	11	0	0		1
2641	140	1362	1	0	0	 	1
2674	140	1280	1	0	0		1
2675	140	1251	3	0	0		1
2684	139	1591	3	0	0		1
2685	139	1284	1	0	0		1
2676	140	92	5	0	0	Trocar para um de maior capacidade	1
2709	139	1294	1	0	0		1
2686	139	1219	1	0	0	Talvez trocar por IDC	1
2687	139	1604	1	0	0		1
2688	139	1605	2	0	0		1
2689	139	1596	1	0	0		1
2690	139	1606	1	0	0		1
2691	139	1607	1	0	0		1
2692	139	1608	1	0	0		1
2693	139	1442	1	0	0		1
2694	139	1609	2	0	0		1
2695	139	1296	3	0	0		1
2696	139	99	4	0	0		1
2697	139	114	1	0	0		1
2698	139	1610	2	0	0		1
2700	139	24	2	0	0		1
2701	139	659	1	0	0		1
2702	139	1590	1	0	0		1
2703	139	1612	1	0	0		1
2704	139	1545	1	0	0		1
2705	139	1613	1	0	0		1
2706	139	1614	1	0	0		1
2707	139	282	1	0	0		1
2708	139	240	1	0	0		1
2644	140	454	4	0	0	Usar código STLZ e usar conector macho	1
293	81	324	0	0	3		2
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: jrm
--

COPY public.locations (id, name, note, nbox, quant) FROM stdin;
48	R		6	0
52	P01	Caixa de papelão comprida	1	0
56	P02	caixa papelão	1	0
26	P03	Antiga C04	1	0
61	M02	Arruelas	1	0
64	M03	Porcas	1	0
50	M01	Parafusos	1	0
63	P04	Etiquetas	1	0
65	P05	Caixa com LCDs	1	0
66	M05	Parafusos	1	0
67	M04	Brocas	1	0
72	M06	Parafusos, porcas, terminais, espaçadores	1	0
73	Satelite	Componentes do Satélite	1	0
74	ACBOX	Pedidos: W37530 e W37354	3	0
88	CBUS		1	0
92	CADR-DA		1	0
90	CADR-IO		1	0
89	CADR-AN		1	0
93	CADR	Não existe: somente para acrescentar nas outras montagens	1	0
87	A420		2	0
2	A18		1	0
82	INV09	Pedido W35429	4	0
104	CADR-MIX	2 DA, 1PWM, 2OUT, 3IN, 4 ANALOG	1	0
11	G	Está sem a G2 -- Caixa 1: A06; Caixa 2: A07 e A08 (erro?); 4: A09; 5: A10;	5	0
23	C		6	0
107	B	Falta Caixa 3	5	0
35	D		5	0
25	E		1	0
112	invleg	Ainda sem caixa	1	0
113	OSC-1	Projeto com o Heitor	1	0
19	F		6	0
114	GDEC	Existem vários componentes que não fazem parte da placa GDEC	1	0
71	X	Espaço gde vazio - componentes não catalogados	6	0
111	BoatArm		2	0
115	Fuel Cell		1	0
116	Invslave1		2	0
118	Headcon1	Comprar: C34, quem é C37?	2	0
120	CHOPPER		1	0
121	Marcelo	Compra Farnell jul 2015	1	0
119	FRD		8	0
132	A4INPUTS		1	0
133	BLESH2		1	0
134	A420C		1	0
137	Chaves		1	0
138	Integrados		3	0
140	2030 lacep_control	Placa em fabricação	1	4
81	A	A/1 etc. ok -- Antigas Caixas A01 A02 A03 A04 A05	5	0
143	3 2030 armbed		1	0
141	2030 iv420		1	30
139	2030 invleg6v2	Placa já fabricada	1	20
\.


--
-- Data for Name: manufacturers; Type: TABLE DATA; Schema: public; Owner: jrm
--

COPY public.manufacturers (id, name, descr, web) FROM stdin;
0	00 invalid		
2	TI	Texas Instruments	http://www.ti.com
3	NSC	National Semiconductors	http://www.national.com/catalog
4	NXP	NXP	http://www.nxp.com
5	ST	SGS Thompsom	http://www.st.com
8	HAR	HARTING	http://www.harting.com.br
9	KOA	KOA	http://
11	FCH	FAIRCHILD	http://www.fairchildsemi.com
1	 		
7	AVG	AVAGO Semiconductors	http://www.avagotech.com
12	IR	International Rectifier	http://www.irf.com
10	ON	ONSEMI	http://www.onsemi.com
13	PTR	Phoenix Mecano	http://
\.


--
-- Data for Name: quotes; Type: TABLE DATA; Schema: public; Owner: jrm
--

COPY public.quotes (id, shop_id, component_id, deprecated, quantity, price, currency_id, tax) FROM stdin;
97	10	144	1	10	0.4935	1	\N
98	10	145	1	10	0.567	1	\N
3	1	5	1	10	7.55	2	\N
4	3	10	1	1	15.12	1	\N
5	3	11	1	1	16.84	1	\N
6	1	13	1	1	3	1	\N
1	1	1	1	10	0.02	1	\N
107	17	59	1	1	25	1	0
99	11	177	1	1	11.73	1	\N
100	11	178	1	50	3.22	1	\N
101	15	177	1	1	11.3	1	\N
102	16	179	6	1	1	1	\N
8	1	0	1	1	2.75	2	\N
9	1	15	1	1	0.7	1	\N
10	1	53	1	1	0.9	2	\N
13	4	53	1	1	0.9	2	\N
14	4	18	1	1	1.73	2	\N
15	4	49	1	1	2.11	2	\N
17	4	47	1	1	2.76	2	\N
18	4	46	1	1	2.76	2	\N
19	1	21	1	1	0.1	1	\N
20	1	22	1	1	0.27	1	\N
22	1	50	1	1	15	1	\N
23	4	8	1	1	5.3	2	\N
24	4	52	1	1	3.11	2	\N
26	4	45	1	1	1.98	2	\N
28	1	33	1	10	2.2	1	\N
29	1	41	1	100	0.05	1	\N
30	1	42	1	100	0.05	1	\N
31	1	57	1	100	0.05	1	\N
32	1	23	1	50	0.02	1	\N
33	1	24	1	50	0.02	1	\N
34	1	25	1	50	0.02	1	\N
35	1	26	1	50	0.02	1	\N
37	1	28	1	50	0.02	1	\N
38	1	29	1	50	0.02	1	\N
39	1	30	1	50	0.02	1	\N
41	1	38	1	10	0.8	1	\N
42	1	39	1	10	0.8	1	\N
43	1	40	1	10	0.8	1	\N
44	1	54	1	10	1	1	\N
45	1	58	1	20	39.67	1	\N
47	1	60	1	50	30	1	\N
46	1	59	1	1	1	6	\N
49	1	62	1	10	0.15	1	\N
50	1	63	1	10	0.15	1	\N
51	1	64	1	1	0.2	1	\N
52	1	66	1	1	3.47	1	\N
53	1	74	1	10	0.15	1	\N
54	1	75	1	10	0.15	1	\N
55	1	69	1	100	0.007	1	\N
56	1	70	1	100	0.007	1	\N
57	1	71	1	100	0.007	1	\N
58	1	72	1	100	0.007	1	\N
59	1	73	1	100	0.007	1	\N
60	1	76	1	1	1	1	\N
61	1	77	1	2	1.5	1	\N
63	1	79	1	1	6	1	\N
103	16	181	6	1	1	1	\N
65	1	81	1	10	1.85	2	\N
66	1	83	1	1	0.5	1	\N
67	1	84	1	1	0.5	1	\N
68	1	82	1	1	0.5	1	\N
70	1	65	1	1	3.5	1	\N
71	1	67	1	5	0.1	1	\N
64	1	80	1	10	49.5	1	\N
72	5	85	1	20	20	1	\N
74	8	95	2	50	0.03	1	\N
104	1	189	1	1	1	5	\N
76	8	25	3	50	0.03	1	\N
77	8	106	3	50	0.03	1	\N
78	8	27	3	50	0.03	1	\N
79	8	112	3	50	0.03	1	\N
80	8	118	3	50	0.03	1	\N
81	8	100	2	50	0.03	1	\N
82	8	114	3	50	0.03	1	\N
83	8	99	2	50	0.03	1	\N
84	8	98	2	50	0.04	1	\N
85	8	97	2	15	0.11	1	\N
105	17	190	1	1	160	1	\N
87	8	65	4	8	1.01	1	\N
86	8	66	4	8	0.99	1	\N
92	8	119	2	20	0.16	1	\N
93	1	138	1	10	25	1	\N
94	1	139	1	20	30	1	\N
106	17	140	1	1	20	1	\N
48	1	61	1	1	1	4	\N
95	1	140	1	1	1	4	\N
108	17	189	1	1	80	1	\N
109	18	191	1	1	471	1	\N
110	18	192	1	1	52.4	1	\N
113	18	173	1	1	0.35	1	\N
114	18	174	1	1	0.35	1	\N
115	18	175	1	1	1.2	1	\N
116	18	176	1	1	1.2	1	\N
112	18	193	1	1	41.3	1	\N
118	20	196	1	10	25	1	\N
169	34	144	1	10	0.54	1	0
123	29	90	1	100	0.1	1	\N
124	29	22	1	100	0.15	1	\N
125	29	197	1	100	0.15	1	\N
126	29	198	1	100	0.15	1	\N
127	29	199	1	100	0.15	1	\N
128	29	21	1	100	0.15	1	\N
133	32	21	1	352	0.18	1	0
134	32	90	1	132	0.18	1	0
135	32	197	1	100	0.18	1	0
136	32	22	1	100	0.18	1	0
137	32	198	1	100	0.18	1	0
138	32	199	1	100	0.18	1	0
139	32	0	1	100	0.18	1	0
141	32	76	1	16	0.6	1	0
142	32	0	1	16	0.6	1	0
143	32	13	1	40	2.3	1	0
144	32	0	1	40	2.3	1	0
145	32	15	1	8	0.95	1	0
146	32	67	1	32	0.05	1	0
150	33	25	1	50	0.03	1	2
151	33	99	1	50	0.03	1	2
152	33	100	1	50	0.03	1	2
153	33	98	1	50	0.04	1	2
154	33	0	1	50	0.04	1	2
155	33	23	1	100	0.03	1	2
156	33	29	1	100	0.03	1	2
157	33	142	1	50	0.03	1	2
158	33	0	1	50	0.03	1	2
159	33	101	1	50	0.04	1	2
160	33	65	1	50	0.95	1	10
161	33	66	1	42	0.88	1	5
162	33	77	1	50	0.44	1	5
164	33	0	1	48	1.26	1	5
167	33	95	1	50	0.03	1	2
168	33	184	1	10	0.68	1	5
130	30	187	1	20	55	1	0
131	30	200	1	3	85	1	0
91	8	123	2	4	6.67	1	0
170	34	145	1	10	0.52	1	0
171	34	25	1	50	0.05	1	0
172	34	0	1	10	12	1	0
173	34	51	1	10	12	1	0
174	34	207	1	10	1.34	1	0
176	34	159	1	10	2.75	1	0
177	18	209	1	1	0.35	1	0
178	36	207	3	10	1.34	1	2
180	36	211	5	50	0.05	1	2
179	36	51	5	10	12.01	1	5
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
88	8	10	5	1	14.4	1	0
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
149	33	24	21	50	0.03	1	2
75	8	24	21	50	0.03	1	0
89	8	125	5	5	1.69	1	0
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
2	1	2	1	10	0.02	1	0
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
682	45	56	20	60	4.49	2	0
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
830	50	858	12	3200	0.02375	1	0
831	50	430	46	2	2.3	1	0
832	50	876	0	1	0	1	0
833	50	21	2	700	0.1	1	0
834	50	93	25	5	0.3	1	0
835	50	153	27	100	0.6	1	0
836	50	76	27	54	0.5	1	0
837	50	546	27	32	0.75	1	0
838	50	339	9	4	0.1	1	0
839	50	13	17	25	2.3	1	0
840	50	594	18	5	3.5	1	0
841	50	249	35	15	0.5	1	0
843	50	444	5	8	0.6	1	0
845	50	551	35	4	0.5	1	0
847	50	208	11	39	0.6	1	0
848	50	165	11	9	0.8	1	0
849	50	15	12	8	1	1	0
850	50	162	44	16	0.05	1	0
854	51	837	47	3	1.68	1	0
855	51	142	0	1	0	1	0
858	51	30	3	50	0.02	1	0
859	51	23	4	100	0.06	1	0
860	51	51	5	2	18.58	1	0
861	51	207	3	5	1.63	1	0
862	51	88	36	1	1.47	1	0
863	51	2	47	50	0.03	1	0
857	51	95	47	50	0.02	1	0
856	51	442	47	4	0.9	1	0
864	52	877	46	3	5.99	1	0
865	51	142	47	50	0.03	1	0
866	45	878	46	25	0	1	0
867	45	879	46	218	0	1	0
868	50	439	47	8	0.2	1	0
870	50	818	0	1	0	1	0
874	50	431	28	6	0.9	1	0
875	50	451	47	8	5	1	0
873	50	459	31	10	0.02	1	0
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
890	50	458	48	6	0.01	1	0
891	50	536	48	6	0.01	1	0
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
909	56	186	46	40	0.8	2	0
910	56	164	46	12	1.67	2	0
911	56	8	32	15	4.54	2	0
913	56	886	46	15	1.68	2	0
903	56	203	46	4	6.19	2	0
901	56	839	46	10	1.02	2	0
906	56	840	46	5	1.17	2	0
900	56	869	46	10	10.08	2	0
908	56	883	46	10	1.38	2	0
907	56	884	49	5	2.47	2	0
905	56	882	49	10	4.7	2	0
904	56	881	49	5	6.67	2	0
232	38	265	35	15	0	1	0
217	38	253	35	3	0	1	0
246	38	279	10	3	0	1	0
231	38	265	35	2	0	1	0
222	38	258	35	10	0	1	0
248	38	279	10	9	0	1	0
846	50	552	10	4	0.5	1	0
196	38	552	10	1	0	1	0
852	50	838	47	12	2.8	1	0
902	56	20	46	10	0.87	2	0
914	38	147	8	70	0	1	0
915	38	448	8	5	0	1	0
916	38	484	8	1	0	1	0
917	38	887	33	20	0	1	0
918	38	888	33	40	0	1	0
919	57	454	37	25	0.79	1	0
920	57	853	51	25	1.6	1	0
921	57	455	0	50	1.19	1	0
922	57	855	51	50	2.39	1	0
923	57	456	51	5	2.38	1	0
924	57	856	51	5	4.77	1	0
926	58	889	51	20	0.142	1	0
928	58	891	51	2	1.21	1	0
929	58	892	0	2	21.81	1	0
927	58	890	51	20	0.0055	1	0
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
936	60	896	0	1	3.2	1	0
937	60	897	0	1	3.2	1	0
938	60	898	0	6	8.9	1	0
939	61	371	23	1	2.5	1	0
940	61	435	48	3	0.4	1	0
941	61	899	51	5	0.2	1	0
942	61	900	51	5	0.2	1	0
947	62	917	0	50	0.8	1	0
945	61	902	0	3	1	1	0
943	61	901	1	30	0.2	1	0
944	61	403	16	40	0.2	1	0
946	40	903	48	1	0	1	0
949	63	0	0	1	0	1	0
950	63	0	0	1	0	1	0
951	63	0	0	1	0	1	0
952	63	0	0	1	0	1	0
953	63	918	0	5	0.8	1	0
954	63	577	0	100	0.0693	1	0
955	63	162	0	100	0.03	1	0
956	63	779	0	100	0.03	1	0
957	63	919	0	4	1.91	1	0
958	63	920	0	1	3.5	1	0
959	64	922	0	1	20.87	1	0
960	64	921	0	1	3.89	1	0
961	65	923	0	2	0.35	1	0
962	65	924	0	6	1.2	1	0
964	43	925	0	1	0	1	0
965	66	926	0	1	15	1	0
966	62	179	0	1	60.1	1	0
967	65	927	0	1	7	1	0
968	38	701	0	11	0	1	0
969	68	92	0	200	0.15	1	0
970	68	371	0	5	3.5	1	0
971	71	186	0	250	0.63	2	0
972	71	164	0	35	2.2772	2	0
973	71	886	0	25	1.38	2	0
975	71	883	0	10	1.35	2	0
976	71	869	0	35	8.5952	2	0
977	71	22	0	100	0.0442	2	0
979	71	881	0	8	6.84	2	0
978	71	80	0	10	9.64	2	0
980	71	873	0	25	2.3	2	0
974	71	839	0	35	0.75	2	0
981	72	51	0	2	18.58	1	5
781	45	723	22	60	0	1	0
782	45	724	22	10	0	1	0
982	38	943	0	1	0	1	0
983	45	944	0	10	0	1	0
984	45	945	0	53	0	1	0
414	43	428	0	17	0	1	0
999	76	412	0	5	1.11	1	0
985	45	447	0	12	0	1	0
1000	76	159	0	25	2.76	1	0
986	45	946	0	10	0	1	0
987	69	937	0	19	0	1	0
988	69	403	0	200	0	1	0
989	69	399	0	3	0	1	0
990	69	395	0	17	0	1	0
991	69	938	0	2	0	1	0
1001	76	144	0	12	0.66	1	0
993	75	33	0	11	1.68	1	0
992	75	947	0	4	0.42	1	0
994	75	466	0	3	0.53	1	0
995	75	948	0	1	2.11	1	0
1002	76	145	0	12	0.64	1	0
36	1	27	1	50	0.02	1	0
996	45	27	0	200	0	1	0
1003	76	643	0	50	0.02	1	0
366	43	784	37	34	0	1	0
997	45	949	0	50	0	1	0
1004	45	644	0	50	0	1	0
998	45	950	0	50	0	1	0
165	33	178	1	10	2.67	1	2
651	45	183	19	19	0	1	0
1005	77	953	0	10	1.83	1	13.27
1008	78	648	0	100	0.02	1	2.5
1006	78	688	0	100	0.02	1	2.5
1007	78	95	0	100	0.02	1	2.5
1009	79	173	0	6	0.25	1	0
1010	79	862	0	4	0.15	1	0
1011	79	863	0	5	0.15	1	0
1012	79	956	0	5	0.2	1	0
1013	79	957	0	3	0.3	1	0
1014	80	948	0	5	0	1	0
1015	80	466	0	5	0	1	0
1016	82	958	0	10	3.53	1	15
1017	83	962	0	1	1.26	1	0
1018	83	960	0	1	1.26	1	0
1019	83	959	0	1	1.26	1	0
1020	83	961	0	1	1.26	1	0
1021	83	963	0	1	19.26	1	0
1022	83	964	0	2	6.58	1	0
1023	84	766	0	50	0	1	0
1024	84	773	0	1	0	1	0
1025	84	966	0	12	0	1	0
1026	84	967	0	4	0	1	0
1027	84	9	0	1	0	1	0
1029	86	972	0	50	0.04	1	2
1031	86	931	0	50	0.06	1	2
1032	86	968	0	50	0.04	1	2
1033	86	969	0	50	0.04	1	2
1034	86	970	0	50	0.03	1	2
1035	86	971	0	50	0.04	1	2
1028	86	88	0	20	1.22	1	5
1030	86	934	0	50	0.06	1	2
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
16	4	875	1	1	4.05	2	0
1143	93	955	0	100	0	1	0
1139	1	339	0	1	0	1	0
1147	100	765	0	2	0	1	0
1140	40	1066	0	1	0	1	0
1144	93	1067	0	1	0	1	0
1141	93	1065	0	1	0	1	0
1142	100	1056	0	1	0	1	0
1145	93	1068	0	1	0	1	0
1157	104	1087	0	15	0.97	1	0
1146	1	756	0	1	0	1	0
1158	104	1088	0	18	0.1	1	0
1148	104	1074	0	3	9.38	1	0
1151	104	1077	0	2	2.54	1	0
1152	104	1084	0	1	14.58	1	0
1153	105	1073	0	148	1.29	1	0
1154	105	1072	0	89	1.29	1	0
1150	104	1075	0	54	0.02	1	0
1149	104	1076	0	29	0.06	1	0
1155	106	1085	0	10	3.4	1	0
1156	35	170	0	1	1.3	1	0
1159	93	1120	0	5	6.6	2	30
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
1211	93	1179	0	30	0.08	1	0
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
1244	107	170	0	10	0.93	1	0
1236	93	1204	0	1	0	1	0
1250	109	1063	0	2	83.28	1	0
1237	93	1205	0	1	0	1	0
1245	93	8	0	8	0	1	0
1238	93	1206	0	1	0	1	0
1304	113	1087	0	15	0	1	0
1239	93	1207	0	1	0	1	0
1246	93	359	0	92	0	1	0
1240	93	1208	0	1	0	1	0
1247	108	775	0	1	13.65	1	0
1241	93	1209	0	1	0	1	0
1252	110	339	0	73	0.1	1	0
1242	93	1210	0	1	0	1	0
1248	93	1075	0	19	0	1	0
1243	93	1211	0	1	0	1	0
1253	110	326	0	10	0.15	1	0
1249	93	1212	0	10	0	1	0
1254	110	297	0	33	0.44	1	0
1255	110	93	0	18	0.3	1	0
1256	110	153	0	30	0.7	1	0
1257	110	539	0	4	3	1	0
1258	110	357	0	17	0.4	1	0
1259	110	14	0	5	1.2	1	0
1260	110	1213	0	10	0.25	1	0
1261	110	793	0	5	0.2	1	0
1262	110	466	0	4	0.15	1	0
1263	110	84	0	44	0.15	1	0
1264	110	82	0	22	0.15	1	0
1265	110	83	0	10	0.15	1	0
1266	110	1123	0	11	0.15	1	0
1267	110	537	0	50	0.15	1	0
1268	110	1050	0	10	0.15	1	0
1269	110	107	0	10	0.15	1	0
1270	110	695	0	10	1.5	1	0
1271	110	948	0	37	1.2	1	0
1272	110	185	0	5	0.3	1	0
1273	110	397	0	5	0.9	1	0
1274	111	1121	0	50	0.03	1	0
1275	111	820	0	1	17.02	1	0
1276	111	28	0	100	0.04	1	0
1277	111	26	0	50	0.02	1	0
1278	111	1134	0	50	0.02	1	0
1279	111	722	0	1	3.9	1	0
1280	111	821	0	1	8.03	1	0
1281	111	97	0	10	0.13	1	0
1282	111	51	0	6	14.59	1	0
1283	111	50	0	5	14.63	1	0
1284	111	1128	0	50	0.02	1	0
1285	111	1127	0	50	0.02	1	0
1286	111	100	0	50	0.02	1	0
1287	111	29	0	50	0.02	1	0
1288	111	114	0	50	0.02	1	0
1289	111	1108	0	5	2.55	1	0
1290	111	23	0	50	0.06	1	0
1291	111	1131	0	50	0.07	1	0
1292	111	1126	0	12	1.58	1	0
1293	111	38	0	150	0.09	1	0
1294	111	1214	0	3	5.58	1	0
1295	112	1090	0	24	15.67	1	0
1296	112	1091	0	2	17.28	1	0
1297	112	1099	0	2	5.02	1	0
1298	112	1095	0	28	2.08	1	0
1299	112	1093	0	58	1.39	1	0
1300	112	208	0	10	0.92	1	0
1301	112	165	0	10	1.38	1	0
1302	112	135	0	22	1.54	1	0
1303	112	1115	0	12	3.4	1	0
1251	110	315	0	50	0.3	1	0
1305	113	1089	0	7	0	1	0
1306	113	1074	0	1	0	1	0
1307	114	297	0	10	0.89	1	0
1308	114	1215	0	20	3.68	1	0
1309	115	113	0	13	1.02	1	0
1310	115	88	0	2	0.98	1	0
1311	115	46	0	8	2.06	1	0
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
1328	122	386	0	12	1.93	1	0
1322	117	1100	0	8	1.73	2	0
1321	117	1101	0	12	1.13	2	0
1323	118	885	0	2	1.5	1	0
1324	119	976	0	10	7.14	1	0
1329	123	1105	0	15	3.14	1	0
1326	121	1225	0	6	0	1	0
1330	123	1133	0	10	3.23	1	0
1327	121	386	0	10	0	1	0
1331	123	113	0	8	1.08	1	0
1332	123	1104	0	5	2.55	1	0
1333	123	1106	0	10	3.19	1	0
1334	123	1129	0	10	3.16	1	0
1335	123	1132	0	10	2.57	1	0
1336	123	1107	0	5	3.16	1	0
1337	123	1161	0	15	3.16	1	0
1338	123	35	0	10	2.58	1	0
1339	123	662	0	15	2.56	1	0
1340	123	1119	0	40	3.22	1	0
1341	123	1160	0	15	3.17	1	0
1342	123	1109	0	5	3.17	1	0
1343	123	1122	0	5	0.21	1	0
1344	123	1227	0	2	48.81	1	0
1345	123	88	0	9	0.98	1	0
1346	125	46	0	40	2.06	1	0
1347	125	1214	0	2	5.58	1	0
1348	125	1228	0	10	4.71	1	0
1349	126	792	0	4	0.44	1	0
1350	126	1230	0	5	0.53	1	0
1351	126	1229	0	5	2.11	1	0
1352	127	1232	0	10	0.1	1	0
1353	127	1231	0	30	0.1	1	0
1354	128	863	0	15	0.15	1	0
1355	128	956	0	25	0.2	1	0
1359	132	297	0	30	0.89	1	0
1356	101	1233	0	2	0	1	0
1360	133	24	0	100	0.02	1	0
1357	101	1234	0	6	0	1	0
1361	133	1236	0	100	0.03	1	0
1358	100	1235	0	4	0	1	0
1362	133	644	0	100	0.03	1	0
1363	133	1126	0	5	1.47	1	0
1364	133	1127	0	100	0.02	1	0
1365	132	1126	0	1	0	1	0
1383	136	947	0	4	0.44	1	0
1366	134	1237	0	100	0.02	1	5
1384	136	1215	0	8	3.69	1	0
1385	137	1245	0	2	6.58	1	0
1368	130	1238	0	100	0.02	1	5
1386	137	1246	0	1	5.64	1	0
1387	137	976	0	14	6.33	1	0
1388	138	1242	0	7	1.95	1	0
1369	130	1239	0	100	0.02	1	5
1370	130	1240	0	100	0.02	1	5
1391	140	577	0	100	0.8	1	0
1372	130	1237	0	100	0.02	1	5
1373	130	657	0	100	0.02	1	5
1374	130	142	0	100	0.02	1	5
1375	130	688	0	100	0.02	1	5
1376	130	95	0	100	0.02	1	5
1377	130	728	0	100	0.02	1	5
1378	130	26	0	100	0.02	1	5
1371	130	1241	0	100	0.03	1	5
1379	131	1242	0	5	3.69	1	5
1380	135	919	0	25	2	1	5
1381	135	947	0	8	0.44	1	5
1392	140	722	0	5	0.84	1	0
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
383	18	0	193	0.1
379	18	0	191	0.1
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
1079	59	0	1074	0.6
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
1093	63	0	922	0.005
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
3	2	0	2003-09-08	0	31.96	0
20	12	0	2003-08-01	10	250	0
8	2	1	2003-09-19	0.69	124.18	5.46
19	11	1	2003-11-17	0	742.5	22.6
5	6	1	2002-09-12	0	400	0
32	3	0	2003-11-27	0	403.92	10
30	12	0	2003-11-25	0	1355	30
29	3	0	2003-11-13	0	85	0
15	2	0	2003-11-07	0	11.3	0
10	2	0	2003-10-01	0	10.605	0
34	2	0	2003-12-22	0	294	8
4	5	0	2003-09-10	2.2538	93.2442	22
18	10	0	2003-11-17	0	568.15	0
35	14	1	2003-12-23	0	0	\N
36	2	1	2003-12-22	0	142.323	5.677
40	9	1	2002-02-01	0	0	1
37	3	1	2004-01-12	0	0	\N
41	5	1	2004-01-09	0	\N	\N
38	9	1	2002-02-02	0	0	0
6	7	1	2002-09-12	0	120	0
33	2	0	2003-11-27	0	2236.6544	5.45
46	2	1	2004-02-19	0	0	0
47	2	1	2004-02-20	0	0	0
49	10	1	2004-02-20	0	0	0
52	2	1	2004-02-25	0	17.97	0
51	2	1	2004-02-20	0	64.92	0
50	3	1	2004-02-20	0	645.3	0
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
58	4	1	2004-03-05	0	48.99	0
60	4	1	2004-03-06	0	59.8	0
68	3	1	2004-03-11	0	47.5	9.7
69	12	1	2004-03-12	0	0	0
61	23	1	2004-03-06	0	22.7	0
76	2	1	2004-03-25	0	0	0
77	2	1	2004-04-05	0	20.72841	6
78	2	1	2004-04-02	0	6.15	1.58
79	10	1	2004-04-06	0	0	0
80	4	1	2004-04-08	0	0	0
81	2	1	1205-08-06	0	0	0
72	2	1	2004-03-16	0	39.018	4.02
82	2	1	2004-04-12	0	40.595	9.2
83	4	1	2004-04-16	0	37.46	0
71	5	1	2004-03-16	134.58	2426.45256	341
75	4	1	2004-03-15	0	0	0
56	5	1	2004-03-03	54.09	1182.321	304.88
84	9	1	2002-04-20	0	0	0
86	2	1	2004-04-15	0	41.43	8.4
89	23	1	2004-04-23	0	24	0
91	9	1	2002-04-21	0	0	0
93	9	1	2002-04-24	0	0	0
100	9	1	2002-04-22	0	0	0
101	9	1	2002-04-23	0	0	0
92	9	1	2002-02-15	0	0	0
11	9	1	2000-04-30	0	172.73	0
16	8	1	2003-04-30	0	2	0
1	9	1	2000-04-30	0	4070.631	0
106	30	1	2004-07-06	0	0	0
104	8	1	2004-06-01	0	37.82	0
105	29	1	2004-04-12	0	305.73	0
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

COPY public.suppliercodes (supplier_id, component_id, code, rounding, active, id, partnumber, manufact_id, price, tax) FROM stdin;
1	493		1	t	568	LM741CN	1	0	0
1	493		1	t	569	CA741CE	1	0	0
1	493		1	t	570	UA741CN	1	0	0
1	9		1	t	571	MAX232CPE	1	0	0
1	9		1	t	572	MAX232N	1	0	0
1	444		1	t	573	LM7905C	1	0	0
1	444		1	t	574	SD7905C	1	0	0
1	249		1	t	575	NE555N	1	0	0
1	249		1	t	576	SDA555CE	1	0	0
1	249		1	t	577	LM555CN	1	0	0
1	9		1	t	578	HIN232CP	1	0	0
1	9		1	t	579	ST232CN	1	0	0
1	474		1	t	580	CD74HC04E	1	0	0
1	474		1	t	581	SN74HC04N	1	0	0
1	474		1	t	582	74HC04N	1	0	0
1	228		1	t	583	DM74LS14N	1	0	0
1	228		1	t	584	GD74LS14	1	0	0
1	220		1	t	585	MM74HC14N	1	0	0
1	220		1	t	586	SN74HC14E	1	0	0
1	220		1	t	587	SN74HC14N	1	0	0
1	243		1	t	588	SN74LS373N	1	0	0
1	243		1	t	589	T74LS373BI	1	0	0
1	122		1	t	590	MM74HC4040M	1	0	0
1	258		1	t	591	CD40106BCN	1	0	0
1	612		1	t	592	CD40107BE	1	0	0
1	518		1	t	593	CD4015	1	0	0
1	551		1	t	594	CD4017BE	1	0	0
1	552		1	t	595	CD4040	1	0	0
1	495		1	t	596	CD4071BCN	1	0	0
1	265		1	t	597	CD4093B	1	0	0
1	265		1	t	598	CD4093BCN	1	0	0
1	527		1	t	599	CD4099BCN	1	0	0
1	279		1	t	600	GD4049B	1	0	0
1	265		1	t	601	GD4093B	1	0	0
1	254		1	t	602	HCF40109BE	1	0	0
1	253		1	t	603	HCF4046BE	1	0	0
1	560		1	t	604	HCF4066BE	1	0	0
1	269		1	t	605	HEF4001BP	1	0	0
1	258		1	t	606	HEF40106BP	1	0	0
1	253		1	t	607	HEF4046BP	1	0	0
1	279		1	t	608	HEF4049BP	1	0	0
1	500		1	t	609	HEF4070BE	1	0	0
1	219		1	t	610	HEF4081BP	1	0	0
1	265		1	t	611	HEF4093BP	1	0	0
1	528		1	t	612	MC14024BCP	1	0	0
1	269		1	t	613	SD4001BE	1	0	0
1	258		1	t	614	SD40106BE	1	0	0
1	279		1	t	615	SD4049UBE	1	0	0
1	552		1	t	616	TC4040BP	1	0	0
1	589		1	t	617	74AC00PC	1	0	0
1	224		1	t	618	74HC138N	1	0	0
1	225		1	t	619	74HC374N	1	0	0
1	442		1	t	620	74HCT04N	1	0	0
1	598		1	t	621	74LS164PC	1	0	0
1	692		1	t	622	74VHC08N	1	0	0
1	524		1	t	623	74VHC138N	1	0	0
1	691		1	t	624	74VHC14N	1	0	0
1	715		1	t	625	74VHC245N	1	0	0
1	690		1	t	626	74VHC32N	1	0	0
1	582		1	t	627	74VHC541N	1	0	0
1	498		1	t	628	74VHC574N	1	0	0
1	554		1	t	629	CD74HC02E	1	0	0
1	590		1	t	630	CD74HC132E	1	0	0
1	562		1	t	631	CD74HC139E	1	0	0
1	246		1	t	632	DM74ALS373BN	1	0	0
1	485		1	t	633	DM74ALS541N	1	0	0
1	223		1	t	634	DM74ALS573BN	1	0	0
1	501		1	t	635	GD74LS06	1	0	0
1	593		1	t	636	GD74LS07	1	0	0
1	564		1	t	637	HD74LS04P	1	0	0
1	641		1	t	638	M74ALS574P	1	0	0
1	236		1	t	639	M74HC166BI	1	0	0
1	592		1	t	640	M74HC245BI	1	0	0
1	478		1	t	641	M74LS86P	1	0	0
1	251		1	t	642	MM74HC374N	1	0	0
1	476		1	t	643	MC74HC368N	1	0	0
1	597		1	t	644	MM74HC191N	1	0	0
1	216		1	t	645	MM74HC74AN	1	0	0
1	640		1	t	646	SN74ALS244BN	1	0	0
1	580		1	t	647	SN74HC02N	1	0	0
1	231		1	t	648	SD74LS08D	1	0	0
1	591		1	t	649	SN7407N	1	0	0
1	530		1	t	650	MM74HC368N	1	0	0
1	238		1	t	651	PC74HC688P	1	0	0
1	261		1	t	652	SD74LS08E	1	0	0
1	280		1	t	653	SD74LS138E	1	0	0
1	237		1	t	654	SD74LS164E	1	0	0
1	588		1	t	655	SD74LS245E	1	0	0
1	521		1	t	656	SD74LS32E	1	0	0
1	510		1	t	657	SN7406N	1	0	0
1	481		1	t	658	SN7420N	1	0	0
1	607		1	t	659	SN74HC541N	1	0	0
1	472		1	t	660	SN74LS122N	1	0	0
1	215		1	t	661	SN74LS161AN	1	0	0
1	230		1	t	662	SN74LS221N	1	0	0
1	221		1	t	663	SN74LS323N	1	0	0
1	633		1	t	664	SN74LS592N	1	0	0
1	843		1	t	665	SN74LS684N	1	0	0
1	559		1	t	666	T74LS02BI	1	0	0
1	222		1	t	667	T74LS244BI	1	0	0
1	284		1	t	668	74HC4051D	1	0	0
1	438		1	t	669	74HC4052D	1	0	0
1	184		1	t	670	74HCT138D	1	0	0
1	113		1	t	671	74HCT574D	1	0	0
1	77		1	t	672	MM74HC14M	1	0	0
1	183		1	t	674	MM74HC541WM	1	0	0
1	700		1	t	675	PN2222A	1	0	0
1	710		1	t	676	KTA2907A	1	0	0
1	878		1	t	677	PH2369	1	0	0
1	555		1	t	678	AN7808	1	0	0
1	555		1	t	679	MC7808CT	1	0	0
1	247		1	t	680	GL324	1	0	0
1	273		1	t	681	GL393	1	0	0
1	558		1	t	682	KA3845A	1	0	0
1	256		1	t	683	L7908CV	1	0	0
1	213		1	t	684	KA7805	1	0	0
1	213		1	t	685	L7805CV	1	0	0
1	727		1	t	686	L7812CV	1	0	0
1	234		1	t	687	LM311N	1	0	0
1	273		1	t	688	LM393E	1	0	0
1	273		1	t	689	LM393P	1	0	0
1	259		1	t	690	WL431	1	0	0
1	726		1	t	691	TSL7912CV	1	0	0
1	247		1	t	692	CA324E	1	0	0
1	234		1	t	693	LM311P	1	0	0
1	244		1	t	694	MC14538BCP	1	0	0
1	558		1	t	695	UC3845	1	0	0
1	698		1	t	698	2N2906A	1	0	0
1	698		1	t	699	2N2907A	1	0	0
1	92		1	t	700	LL4148	1	0	0
1	947		1	t	701	1N4752	1	0	0
1	791		1	t	702	1N4728AC	1	0	0
1	792		1	t	703	1N4729AC	1	0	0
1	802		1	t	704	1N4734A	1	0	0
1	811		1	t	705	1N4735	1	0	0
1	795		1	t	706	1N4742	1	0	0
1	793		1	t	707	1N4744	1	0	0
1	794		1	t	708	1N759A	1	0	0
1	784		1	t	709	1N967B	1	0	0
1	803		1	t	710	79C4V7	1	0	0
1	811		1	t	711	85C6V2	1	0	0
1	807		1	t	712	BZX79C51	1	0	0
1	804		1	t	713	BZV85C13V	1	0	0
1	804		1	t	714	C13P	1	0	0
1	785		1	t	715	C4V3PH	1	0	0
1	678		1	t	716	BZV55-C3V9	1	0	0
1	949		1	t	717	BZX84C3V9	1	0	0
1	950		1	t	718	BZV84C5V6	1	0	0
1	97		1	t	719	 BZV55C12 	1	0	0
1	1054		1	t	720	L7815CV	1	0	0
1	1122		1	t	721	1N4745	1	0	0
1	1122		1	t	722	BZX85-C16	1	0	0
1	848		1	t	723	BZX84C3V9	1	0	0
1	1261		1	t	724	74HC04D	1	0	0
1	92		1	t	725	PMLL4148L	1	0	0
1	1319		1	t	727	74HCT139D	1	0	0
2	1305	45J0744	1	t	732	LM324DG	10	0	0
2	1339	1097187	1	t	736	BZV55-C15	1	0	0
3	93	1166030	1	t	111		1	0	0
2	1341	83H7851	1	t	737		1	0	0
2	125	06F9447	1	t	733		1	0	0
2	1342	1201320	1	t	738	74HC138D	4	0	0
2	242	63J7870	1	t	734	IR2121PBF	12	0	0
3	417		1	t	182		3	0	0
2	11	787-139	1	t	1		1	0	0
5	203		1	t	83		1	0	0
2	934	420-890	1	t	144		1	0	0
2	208	151-794	1	t	145		1	0	0
32	135	MC 1.5/3-G-3.5	1	t	284		1	0	0
32	136	MC 1.5/4-G-3.81	1	t	285		1	0	0
3	397	5274-05A	1	t	421		1	0	0
2	1329	41K2616	1	t	550	LMC6062IM/NOPB	3	0	0
2	1260	88H7776	1	t	462	HCPL-0601-000E	7	0	0
2	1333	88H7787	1	t	557	HCPL-0631-000E	7	0	0
2	1336	9589708	1	t	564	LT1004ID-1-2G4	2	0	0
2	1332	9589694	1	t	555	LT1004CD-2-5	2	0	0
2	1330	8455210	1	t	551	TLV2553IDW	2	0	0
2	1119	1400719	1	t	556	RN73H2BTTD1200B25	9	0	0
2	1108	1400806	1	t	553	RN73H2BTTD2203B25	9	0	0
2	1108	3089587	5	t	360		1	0	0
2	115	1081221	10	t	560	BC807-25	4	0	0
2	965	9558608	1	t	561	BC817-25LT1G	10	0	0
2	88	1014013	1	t	203	MM74HCT541WM	11	0	0
2	1331	1400711	1	t	554	KOA RN73H2BTTD56R0B25	1	0	0
2	98	420-177	1	t	2		1	0	0
2	97	305-0774	1	t	3		1	0	0
2	65	752-022	1	t	4		1	0	0
2	66	752-010	1	t	5		1	0	0
2	125	411-206	1	t	6		1	0	0
2	122	379-633	1	t	7		1	0	0
2	119	369-767	1	t	8		1	0	0
2	123	249-890	1	t	9		1	0	0
2	177	3047787	1	t	11		1	0	0
10	191	4 1/2	1	t	12		1	0	0
10	192	1 1/2	1	t	13		1	0	0
10	193	40mm PVC	1	t	14		1	0	0
2	1270	1220984	1	t	479		1	0	0
12	196	sc5-2	1	t	15		1	0	0
12	201	CH24-5	1	t	16		1	0	0
2	77	379-268	1	t	18		1	0	0
2	178	249-415	1	t	20		1	0	0
10	209	Parker 2029	1	t	21		1	0	0
2	101	420-359	1	t	22		1	0	0
12	187	FS 5/30	1	t	23		1	0	0
2	207	421-560	1	t	24		1	0	0
12	200	FS 8/65	1	t	25		1	0	0
2	23	109-299	50	t	26		1	0	0
2	25	109-325	50	t	27		1	0	0
2	51	411-220	1	t	28		1	0	0
2	211	109-325	50	t	29		1	0	0
2	46	411-681	1	t	31		1	0	0
2	284	492-140	1	t	33		1	0	0
2	10	787-115	1	t	35		1	0	0
2	443	348-302	1	t	37		1	0	0
2	95	912-098	50	t	38		1	0	0
2	646	911-616	50	t	41		1	0	0
2	116	911-987	50	t	43		1	0	0
2	1	911-628	50	t	44		1	0	0
2	728	912-116	50	t	45		1	0	0
2	160	912-128	50	t	46		1	0	0
2	653	912-001	50	t	47		1	0	0
2	99	911-859	50	t	48		1	0	0
2	644	911-860	50	t	49		1	0	0
2	664	911-872	50	t	50		1	0	0
2	27	912-130	50	t	52		1	0	0
2	28	912-013	50	t	54		1	0	0
2	685	912-141	50	t	55		1	0	0
2	660	911-781	50	t	56		1	0	0
2	657	912-025	50	t	57		1	0	0
2	651	911-665	50	t	58		1	0	0
2	643	911-896	50	t	59		1	0	0
2	29	912-153	50	t	61		1	0	0
2	112	911-793	50	t	62		1	0	0
2	142	912-037	50	t	63		1	0	0
2	30	912-165	50	t	64		1	0	0
2	661	911-800	50	t	65		1	0	0
2	114	911-914	50	t	66		1	0	0
2	656	911-926	50	t	67		1	0	0
2	688	912-177	50	t	68		1	0	0
2	645	911-823	50	t	71		1	0	0
2	650	912-062	50	t	72		1	0	0
2	100	911-835	50	t	73		1	0	0
2	118	911-719	50	t	74		1	0	0
2	686	109-315	50	t	75		1	0	0
2	681	109-316	50	t	76		1	0	0
2	34	912-384	50	t	77		1	0	0
2	642	420-797	50	t	79		1	0	0
2	668	419-898	50	t	80		1	0	0
2	442	381-780	1	t	82		1	0	0
3	551		1	t	84		1	0	0
2	551	573-656	1	t	85		1	0	0
3	120		1	t	86		1	0	0
3	445		1	t	89		1	0	0
3	105		1	t	90		1	0	0
3	444		1	t	91		1	0	0
3	552		1	t	92		1	0	0
2	552	573-681	1	t	93		1	0	0
3	439		1	t	94		1	0	0
3	432		1	t	95		1	0	0
3	94		1	t	96		1	0	0
3	537		1	t	97		1	0	0
3	435		1	t	98		1	0	0
3	431		1	t	99		1	0	0
2	1334	1085249	1	t	558	NXP 74HC1G00GW	1	0	0
2	839	77C0815	1	t	562		1	0	0
2	1335	07B5609	1	t	563	NSC LMC6061IM	1	0	0
2	1338	9236767	50	t	565		1	0	0
5	8		1	t	100		1	0	0
5	18		1	t	101		1	0	0
2	461	911-926	1	t	102		1	0	0
5	19		1	t	103		1	0	0
2	451	361-951	1	t	104		1	0	0
2	838	348-302	1	t	105		1	0	0
11	44		1	t	106		1	0	0
5	56		1	t	107		1	0	0
3	197		1	t	109		1	0	0
3	62		1	t	110		1	0	0
3	91		1	t	112		1	0	0
3	76		1	t	113		1	0	0
2	2	911-744	50	f	42		1	0	0
2	106	911-902	50	f	60		1	0	0
3	206		1	t	114		1	0	0
3	9		1	t	115		1	0	0
3	17		1	t	116		1	0	0
9	140		1	t	117		1	0	0
3	162		1	t	118		1	0	0
7	169		1	t	119		1	0	0
15	41		1	t	120		1	0	0
15	42		1	t	121		1	0	0
6	138		1	t	122		1	0	0
16	138		1	t	123		1	0	0
14	170		1	t	124		1	0	0
3	161		1	t	125		1	0	0
3	205		1	t	126		1	0	0
10	176		1	t	127		1	0	0
3	451		1	t	128		1	0	0
3	208	KRE-2	1	t	130		1	0	0
3	165	KRE-3	1	t	131		1	0	0
2	928	420-815	1	t	132		1	0	0
3	33		1	t	133		1	0	0
2	929	420-384	1	t	134		1	0	0
3	213	7805	1	t	135		1	0	0
2	930	420-542	1	t	136		1	0	0
2	931	420-657	1	t	137		1	0	0
3	430		1	t	138		1	0	0
2	932	420-864	1	t	139		1	0	0
2	933	420-888	1	t	140		1	0	0
2	33	643-660	1	t	141		1	0	0
2	153	643-683	1	t	142		1	0	0
2	76	643-646	1	t	143		1	0	0
2	145	1085255	1	t	10	NXP 74HC1G32GW 	1	0	0
2	144	3025913	1	t	30	PHILIPS 74HC1G08GW 	1	0	0
2	285	71J5469	1	t	34	ONSEMI MC14049UBDG	1	0	0
2	282	71J5481	1	t	32	MC14093BDG	1	0	0
2	837	71J5472	1	t	81	MC14052BDG	1	0	0
2	165	151-795	1	t	146		1	0	0
2	841	151-785	1	t	147		1	0	0
1	935	420-980	1	t	148		1	0	0
2	842	151-786	1	t	149		1	0	0
3	468		1	t	150		1	0	0
3	841	KRE-2 Low Profile	1	t	151		1	0	0
3	842	KRE-3  Low Profile	1	t	152		1	0	0
5	840		1	t	153		1	0	0
3	13		1	t	154		1	0	0
3	315		1	t	155		1	0	0
3	351		1	t	156		1	0	0
3	90		1	t	157		1	0	0
3	440		1	t	158		1	0	0
3	594		1	t	159		1	0	0
3	249		1	t	160		1	0	0
3	230		1	t	161		1	0	0
5	164		1	t	162		1	0	0
5	5		1	t	163		1	0	0
5	186		1	t	164		1	0	0
5	20		1	t	165		1	0	0
3	15		1	t	166		1	0	0
9	59		1	t	167		1	0	0
3	470		1	t	168		1	0	0
3	433		1	t	169		1	0	0
3	779		1	t	170		1	0	0
3	163		1	t	171		1	0	0
3	92		1	t	172		1	0	0
3	533		100	t	173		1	0	0
3	459		100	t	174		1	0	0
3	534		100	t	175		1	0	0
3	535		100	t	176		1	0	0
3	536		100	t	177		1	0	0
3	467		10	t	178		1	0	0
3	698		1	t	179		1	0	0
3	458		100	t	180		1	0	0
3	289		1	t	181		1	0	0
12	188		1	t	184		1	0	0
3	706		1	t	185		1	0	0
3	466		1	t	186		1	0	0
3	464		1	t	187		1	0	0
2	847	420-359	50	t	189		1	0	0
3	64		1	t	190		1	0	0
15	436		1	t	191		1	0	0
3	446	180847	1	t	192		1	0	0
2	877	327-219	1	t	193		1	0	0
2	9	407-150	1	t	194		1	0	0
3	838		1	t	195		1	0	0
5	883		1	t	196		1	0	0
5	881		1	t	197		1	0	0
5	884		1	t	198		1	0	0
3	885		1	t	199		1	0	0
5	886		1	t	200		1	0	0
3	593		1	t	201		1	0	0
3	474		1	t	202		1	0	0
2	887	513-817	5	t	204		1	0	0
4	889		1	t	205		1	0	0
4	890		1	t	206		1	0	0
4	891		1	t	207		1	0	0
3	891		1	t	208		1	0	0
4	892		1	t	209		1	0	0
4	896		1	t	210		1	0	0
4	897		1	t	211		1	0	0
4	898		1	t	212		1	0	0
23	900		1	t	213		1	0	0
23	899		1	t	214		1	0	0
23	901		1	t	215		1	0	0
23	403		1	t	216		1	0	0
23	902		1	t	217		1	0	0
19	454	STLZ 950 02 5,08 H	1	t	218		1	0	0
19	853	AKZ 950 02 5,08	1	t	219		1	0	0
19	855	AKZ 950 03 5,08	1	t	221		1	0	0
19	456	STLZ 950 06 5,08 H	1	t	222		1	0	0
19	856	AKZ 950 06 5,08	1	t	223		1	0	0
10	956		1	t	224		1	0	0
2	821	151-745	1	t	225		1	0	0
2	820	650-651	1	t	226		1	0	0
4	577	CT3311-N	1	t	227		1	0	0
2	968	912-712	50	t	228		1	0	0
2	952	323-4940	1	t	229		1	0	0
2	953	323-4927	1	t	230		1	0	0
2	972	912-724	50	t	231		1	0	0
2	741	249-403	1	t	232		1	0	0
2	970	912-475	50	t	233		1	0	0
2	969	912-773	50	t	234		1	0	0
2	971	912-554	50	t	235		1	0	0
5	976		1	t	236		1	0	0
19	1090	CN22AK	1	t	237		1	0	0
2	662	308-6185	5	t	238		1	0	0
19	1091	CN45AK	1	t	239		1	0	0
19	1092	AK700H	1	t	240		1	0	0
19	1095	AK 700 03 5,00 V	1	t	241		1	0	0
19	1093	AK700V	1	t	242		1	0	0
19	1096	AK 700 08 5,00 V	1	t	243		1	0	0
19	1094	AK700H	1	t	244		1	0	0
5	1100		1	t	245		1	0	0
19	1097	AK700H	1	t	246		1	0	0
5	1101		1	t	247		1	0	0
5	1103		1	t	248		1	0	0
19	1099	CNB100	1	t	249		1	0	0
5	873		1	t	250		1	0	0
31	937	3069-02A	1	t	251		1	0	0
31	185	5273-02A	1	t	252		1	0	0
31	395	3069-05A	1	t	253		1	0	0
31	858		1	t	254		1	0	0
15	57		1	t	257		1	0	0
10	60		1	t	258		1	0	0
2	1111	308-6422	5	t	259		1	0	0
10	864		1	t	260		1	0	0
31	447	5273-05A	1	t	261		1	0	0
10	957		1	t	262		1	0	0
31	397	5274-05A	1	t	263		1	0	0
8	1088		1	t	264		1	0	0
8	1075		1	t	265		1	0	0
8	1089		1	t	266		1	0	0
3	133		1	t	267		1	0	0
4	775		1	t	268		1	0	0
3	831		1	t	269		1	0	0
4	831		1	t	270		1	0	0
33	1137		1	t	271		1	0	0
3	346		1	t	272		1	0	0
3	347		1	t	273		1	0	0
3	326		1	t	274		1	0	0
3	553		1	t	275		1	0	0
2	1113	348-855	1	t	276		1	0	0
2	1114	348-818	1	t	277		1	0	0
3	539		1	t	278		1	0	0
3	616		1	t	279		1	0	0
4	616		1	t	280		1	0	0
34	324		1	t	281		1	0	0
3	128		1	t	282		1	0	0
32	1115		1	t	286		1	0	0
32	1116		1	t	287		1	0	0
5	875		1	t	288		1	0	0
32	1117	MC 1.5-5.08	1	t	289		1	0	0
5	869		1	t	290		1	0	0
3	680		1	t	291		1	0	0
5	1120		1	t	292		1	0	0
3	1122		1	t	293		1	0	0
3	1123		1	t	294		1	0	0
5	680		1	t	295		1	0	0
15	1124	CE-20/10/5-1	1	t	296		1	0	0
2	1124		1	t	297		1	0	0
2	1125		1	t	298		1	0	0
15	1125		1	t	299		1	0	0
5	870		1	t	300		1	0	0
3	254		1	t	301		1	0	0
2	1130		1	t	302		1	0	0
3	79		1	t	303		1	0	0
2	1134	912-104	50	t	304		1	0	0
5	1135		1	t	305		1	0	0
3	14		1	t	306		1	0	0
3	850		1	t	307		1	0	0
3	1063		1	t	308		1	0	0
35	1063		1	t	309		1	0	0
8	1077		1	t	310		1	0	0
8	1074		1	t	311		1	0	0
30	1085		1	t	312		1	0	0
7	1078		1	t	313		1	0	0
7	1140		1	t	314		1	0	0
7	1138		1	t	315		1	0	0
7	1143		1	t	316		1	0	0
7	1142		1	t	317		1	0	0
7	1141		1	t	318		1	0	0
7	1139		1	t	319		1	0	0
24	922		1	t	320		1	0	0
3	393		1	t	321		1	0	0
4	393		1	t	322		1	0	0
36	570		1	t	323		1	0	0
3	83		1	t	324		1	0	0
3	84		1	t	325		1	0	0
3	110		1	t	326		1	0	0
3	109		1	t	327		1	0	0
3	82		1	t	328		1	0	0
29	1073		1	t	329		1	0	0
29	1072		1	t	330		1	0	0
37	1083		1	t	331		1	0	0
37	1079		1	t	332		1	0	0
37	1080		1	t	333		1	0	0
37	1081		1	t	334		1	0	0
37	1082		1	t	335		1	0	0
8	1087		1	t	336		1	0	0
24	152		1	t	337		1	0	0
4	818		1	t	338		1	0	0
3	683		1	t	339		1	0	0
3	96		1	t	340		1	0	0
3	1050		1	t	341		1	0	0
3	107		1	t	342		1	0	0
3	695		1	t	343		1	0	0
3	702		1	t	344		1	0	0
3	704		1	t	345		1	0	0
3	102		1	t	346		1	0	0
3	39		1	t	348		1	0	0
1	386		1	t	349		1	0	0
38	1071		1	t	350		1	0	0
2	1119	308-5727	5	t	351		1	0	0
2	1109	308-6215	5	t	352		1	0	0
2	159	308-6460	5	t	353		1	0	0
2	1107	308-9563	5	t	354		1	0	0
2	665	308-5946	5	t	355		1	0	0
3	937	3069-02A	1	t	356		1	0	0
2	655	308-6008	5	t	357		1	0	0
2	35	308-9575	5	t	358		1	0	0
2	667	308-6252	5	t	359		1	0	0
2	671	308-6264	5	t	361		1	0	0
2	1110	308-6276	5	t	362		1	0	0
2	652	308-6010	5	t	363		1	0	0
2	1104	308-6290	5	t	364		1	0	0
2	1106	308-5820	5	t	365		1	0	0
2	663	308-6070	5	t	366		1	0	0
2	1214	273-776	1	t	367		1	0	0
2	666	308-6331	5	t	368		1	0	0
3	185	5273-02A	1	t	369		1	0	0
2	658	308-6094	5	t	370		1	0	0
2	1112	308-6100	5	t	371		1	0	0
2	670	308-5879	5	t	372		1	0	0
2	1245	200335	1	t	373		1	0	0
3	399	3069-03A	1	t	374		1	0	0
2	37	308-5636	5	t	375		1	0	0
2	1129	308-6112	5	t	376		1	0	0
2	1105	308-6379	5	t	377		1	0	0
2	1132	308-6150	5	t	378		1	0	0
2	1133	308-6410	5	t	379		1	0	0
2	1128	911-690	50	t	380		1	0	0
2	1227	634-529	1	t	381		1	0	0
2	1121	911-999	50	t	382		1	0	0
2	1127	911-653	50	t	383		1	0	0
2	1131	421-091	50	t	384		1	0	0
2	1126	752-149	1	t	385		1	0	0
31	399	3069-03A	1	t	387		1	0	0
2	50	410998	1	t	388		1	0	0
7	86		1	t	389		1	0	0
7	1155		1	t	390		1	0	0
7	1154		1	t	391		1	0	0
7	1156		1	t	392		1	0	0
2	719	353-164	1	t	393		1	0	0
2	113	492-103	1	t	394		1	0	0
3	297		1	t	395		1	0	0
8	1149		1	t	396		1	0	0
8	1144		1	t	397		1	0	0
8	1152		1	t	398		1	0	0
8	1150		1	t	399		1	0	0
8	1151		1	t	400		1	0	0
8	1145		1	t	401		1	0	0
8	1147		1	t	402		1	0	0
8	1148		1	t	403		1	0	0
2	1228	200-270	1	t	404		1	0	0
2	1158	634-529	1	t	405		1	0	0
2	14	569-914	1	t	406		1	0	0
3	396	5273-03A	1	t	407		1	0	0
2	1159	569-926	1	t	408		1	0	0
2	722	257-102	1	t	409		1	0	0
19	1098	AK 700 04 5,00 V	1	t	410		1	0	0
2	1236	912-190	1	t	411		1	0	0
2	678	305-0890	1	t	412		1	0	0
31	396	5273-03A	1	t	413		1	0	0
19	208	AKZ 120 02 5,08 V	1	t	414		1	0	0
2	36	308-6355	5	t	415		1	0	0
3	395	3069-05A	1	t	416		1	0	0
2	1122	369-860	1	t	417		1	0	0
2	1237	912-074	50	t	418		1	0	0
3	447	5273-05A	1	t	419		1	0	0
2	1160	308-6446	1	t	420		1	0	0
2	80	1204767 	1	t	386		1	0	0
2	1161	308-6458	1	t	422		1	0	0
3	357		1	t	423		1	0	0
31	357		1	t	424		1	0	0
3	1163		1	t	425		1	0	0
31	1163		1	t	426		1	0	0
8	1164		1	t	427		1	0	0
8	1165		1	t	428		1	0	0
8	1166		1	t	429		1	0	0
19	165	AKZ 120 03 5,08 V	1	t	430		1	0	0
2	1238	912-049	50	t	431		1	0	0
19	135	STL 1550\\3 3,5 H	1	t	432		1	0	0
3	938	3069-06A	1	t	433		1	0	0
19	1115	AK 1550\\3 3,5	1	t	434		1	0	0
2	1246	4114462	1	t	435		1	0	0
19	136	STLZ 1550\\4 3,81 H	1	t	436		1	0	0
31	938	3069-06A	1	t	437		1	0	0
19	1116	AKZ 1550\\4 3,81	1	t	438		1	0	0
2	1239	912-189	50	t	439		1	0	0
19	1118	AKZ 950 03 5,08	1	t	440		1	0	0
3	398	5273-06A	1	t	441		1	0	0
2	976	954-779  07B5606	1	t	442		1	0	0
31	398	5273-06A	1	t	443		1	0	0
2	1240	912-207	50	t	444		1	0	0
2	1241	912-086	50	t	446		1	0	0
2	735	109-311	50	t	447		1	0	0
2	648	9333274	50	t	448		1	0	0
2	648	912-050	50	f	69		1	0	0
2	95	9332405	50	t	449		1	0	0
2	1249	9332596	50	t	451		1	0	0
2	1250	9238077	50	t	452		1	0	0
2	1252	9451110	10	t	454		1	0	0
2	1253	9451608	1	t	455		1	0	0
2	1254	755771	10	t	456		1	0	0
2	1255	7668614	10	t	457		1	0	0
2	1256	1216550	10	t	458		1	0	0
2	1257	9558659	10	t	459		1	0	0
2	1258	38C7700	5	t	460		1	0	0
2	1259	13J1665	1	t	461		1	0	0
2	1261	1201313	1	t	463		1	0	0
2	1262	96K3660	1	t	464		1	0	0
2	1264	9779230	1	t	465		1	0	0
2	1265	9488146	1	t	466		1	0	0
3	153		1	f	88		1	0	0
3	132		1	f	183		1	0	0
2	183	379-578	1	t	470	MM74HC541WM (?)	1	0	0
2	1266	3734771	1	t	474		1	0	0
2	38	1081230	1	t	475		1	0	0
2	38	516-843	1	f	445		1	0	0
3	38		1	f	108		1	0	0
2	1267	9846115	1	t	476		1	0	0
2	1268	58K8856	1	t	477		1	0	0
2	1269	75C0999	1	t	478		1	0	0
2	1272	9846271	1	t	481		1	0	0
2	1273	1284348	1	t	482	6605759-1 (TYCO)	1	0	0
2	1274	8737908	1	t	483		1	0	0
2	1275	1201330	1	t	484	74HC4066D	1	0	0
2	1276	1201269	1	t	485	74HC595D	1	0	0
2	1277	242500	1	t	486	BD3/1/4-4S2 (Ferroxcube)	1	0	0
2	1278	933-7210	50	t	487		1	0	0
2	64	9451692	1	t	489		1	0	0
2	1279	70K9772	1	t	491		1	0	0
2	1281	755679	1	t	493		1	0	0
2	1282	755692	1	t	494		1	0	0
2	1283	1138869	1	t	495		1	0	0
2	1284	9753591	1	t	496		1	0	0
2	1285	1216435	1	t	497		1	0	0
2	92	3051365	1	t	498	PMLL4148L	1	0	0
2	97	1097185	1	t	499	BZV55-C12	1	0	0
2	1286	1097197	1	t	500	BZV55-C3V3	1	0	0
2	1287	8735743	1	t	501	BZX384-C5V6	1	0	0
2	84	1142502	1	t	502		1	0	0
2	594	98H0572	1	t	503	LM317TG	1	0	0
2	1288	588581	1	t	505		1	0	0
2	39	1081244	1	t	506		1	0	0
2	515	71J5860	1	t	507	MJE13007G	1	0	0
2	1289	1085299	1	t	508	74HCT04D	1	0	0
2	186	52F2783	1	t	510		1	0	0
2	1290	06F1118	1	t	511		1	0	0
2	1291	9663754	1	t	512	ICM7555IBAZ	1	0	0
2	1292	88H2402	1	t	513	IR2175S	1	0	0
2	1293	75C0844	1	t	514	LM358AD	1	0	0
2	1294	89K0711	1	t	515	LM393D	1	0	0
2	213	1102157	1	t	516	LM7805CT	1	0	0
2	184	52F2352	1	t	517	SN74HCT138D	1	0	0
2	1295	90B1233	1	t	518	TLC1543CDW	1	0	0
2	99	9332383	50	t	520		1	0	0
2	28	9332820	50	t	519		1	0	0
2	1296	912426	50	t	522		1	0	0
2	970	9335757	50	t	523		1	0	0
2	1297	9336117	1	t	524		1	0	0
2	1298	1200376	1	t	525		1	0	0
2	653	9332723	50	t	526		1	0	0
2	1299	9333584	50	t	527		1	0	0
2	1300	9497587	1	t	528		1	0	0
2	646	9332421	50	t	529		1	0	0
2	1301	9333479	1	t	530		1	0	0
2	660	9332936	50	t	531		1	0	0
2	664	9332600	50	t	532		1	0	0
2	1302	9335790	1	t	533		1	0	0
2	1278	9336150	50	t	534		1	0	0
2	1303	9477268	1	t	535		1	0	0
2	1304	1306691	1	t	536		1	0	0
2	1310	976-120	1	t	537	MCHTC-100M 20mm	1	0	0
2	1317	316271 	1	t	538	HARTING 0923 248 6825	1	0	0
2	1318	1085328 	1	t	539	74HC21D	1	0	0
2	184	489554	1	t	17	74HCT138D	1	0	0
2	1319	1085308	1	t	540	NXP 74HCT139D	1	0	0
19	1321	STLZ 1550 10 G 3.81	1	t	542		1	0	0
2	1325	1201249 	1	t	546	NXP 74HC165D	1	0	0
2	1327	1085251	1	t	548	NXP 74HC1G04GW	1	0	0
19	1322	AKZ 1550 10 3.81	1	t	543		1	0	0
2	1308	9336184	50	t	566		1	0	0
2	1320	316246	1	t	541	0923 132 6921	8	0	0
2	88	1085319	1	t	509	74HCT541D	4	0	0
2	1326	1085259	1	t	547	74HC1G125GW	4	0	0
2	1306	9336265	50	t	731		1	0.02	0
2	1285	9752951	1	t	735		1	0	0
19	1343	STLZ 950 02 G 5,08 V	1	t	739		13	0	0
19	455	STLZ 950 03 5,08 H	1	t	220		1	0	0
19	1344	STLZ 950 04 5,08 V	1	t	740		13	0	0
19	1345	AKZ 950 04 5,08	1	t	741		13	0	0
2	1328	1103133	1	t	549	CD74HCT86M	2	0	0
2	1347		1	t	742		1	0	0
2	1324	20H4786	1	f	545	CD4044BD	2	0	0
2	1271	63K3623	1	t	480	PM5022-330M-RC	1	0	0
2	1351		1	t	743		1	0	0
2	1352		1	t	744		1	0	0
2	1353		1	t	745		1	0	0
2	1354		1	t	746		1	0	0
23	1355		1	t	747		1	0	0
2	1356		1	t	748		1	0	0
2	1359		1	t	750		1	0	0
2	1360		1	t	751		1	0	0
19	1363		1	t	753		1	0	0
19	1364		1	t	754		1	0	0
4	1366		1	t	755		1	0	0
2	1379		1	t	756	GD75232	1	0	0
2	1387	8389187	1	t	757		3	0	0
2	1388	60K6805	1	t	758		1	0	0
2	102	9558497	1	t	794	BC337-25ZL1G	1	0	0
2	1429	8454175	1	t	780	TLC274AID	1	0	0
2	282	1201296	1	t	762	HEF4093BT	1	0	0
2	1415	06F9416	1	t	763	LM348N	1	0	0
2	240	19K8418	1	t	764	IR2113PBF	1	0	0
2	1418	9333681	1	t	765	MC01W08050R	1	0	0
2	1338	9335854	1	t	766		1	0	0
2	1419	12T2107	1	t	767	ERA-8AEB684V	1	0	0
2	1420	1100137	1	t	768	WCR1206-R005JI	1	0	0
2	1421	9336583	1	t	769		1	0	0
2	1422	9241124	1	t	770	RC1206FR-071ML	1	0	0
2	1424	BRPH000012	1	t	771	230619753128	1	0	0
2	1425	9338241	1	t	772	MCF2W47R	1	0	0
2	1426	1108073	1	t	773	LVR03R0500FE70	1	0	0
2	1390	1108082	1	t	774	LVR05R0150FE73	1	0	0
2	1427	41K9029	1	t	775	LVR05R0500FE12	1	0	0
2	363	1103845	1	t	776	2227MC	1	0	0
2	364	1103846	1	t	777	2227MC	1	0	0
2	1428	08F7453	1	t	778	SN74LS541N	1	0	0
2	1400	1085315	1	t	779	74HCT245D	1	0	0
2	1430	35C1764	1	t	781	LT1013DD	1	0	0
2	873	77C3651	1	t	782	XTR115U	1	0	0
2	1401	06F1107	1	t	783	AM26LS31CD	1	0	0
2	1431	06F9414	1	t	784	LM348D	1	0	0
2	1432	01P0907	1	t	785	INA333AIDGKR	1	0	0
2	1433		1	t	786		1	0	0
2	1434	9589848	1	t	787	MC79L05ACLP	1	0	0
2	1435	72K8848	1	t	788	LM78L05ACZ	1	0	0
2	1436	88H4758	1	t	789	MC7805CTG	1	0	0
2	713	63J7322	1	t	790	IRF540PBF	1	0	0
2	451	9936092	1	t	792	TIP3055	1	0	0
2	1414	12J3398	1	t	759	S8025L	1	0	0
2	1437	01H1005	1	t	793	TIP41A	1	0	0
2	1438	1057298	1	t	795	BTB24-600BRG	1	0	0
2	1440	10N9718	1	t	796	NTF2955T1G	1	0	0
2	1441	58K1480	1	t	797	FDV304P	1	0	0
2	1358	58K8857	1	t	798	FDV303N	1	0	0
2	1442	1081219	1	t	799	BC807	1	0	0
2	1443	25M9343	1	t	800	EXC-ML32A680U	1	0	0
2	1405	1651733	1	t	801	ILB1206ER601V	1	0	0
2	1058	62K3124	1	t	802	SRR1206-101YL	1	0	0
2	1444	61J8346	1	t	803	SDR1006-151KL	1	0	0
2	1445	61J8235	1	t	804	SDR0805-221KL	1	0	0
2	1361	9451129	1	t	752	MCGPR16V108M10X16	1	0	0
2	1362	9451838	1	t	805	MCRH25V107M6.3X11	1	0	0
2	1446	55K2067	1	t	806	UVR1C103MHD	1	0	0
2	1395	197014	1	t	807	TAJA106K006RNJ	1	0	0
2	157	197518	1	t	808	TAJC106K025RNJ	1	0	0
2	153	498737	1	t	809	TAJB106K016RNJ	1	0	0
2	1396	1135060	1	t	810	TAJC226K025RNJ	1	0	0
2	1447	19C6333	1	t	811	08055C222KAT2A	1	0	0
2	1448	10R6438	1	t	812	MC1206X475K250CT	1	0	0
2	183	1201325	1	t	473	74HC541D	1	0	0
2	614	35k4719	1	t	813	MAX232D	1	0	0
2	1466	68K4797	1	t	814	MAX485ECSA+	1	0	0
2	1467	1332113	1	t	815		1	0	0
2	1468	380684	1	t	816	74HC238N	1	0	0
2	1469	382425	1	t	817	74HCT541N	1	0	0
1	269		1	t	818	HCF4001BE	1	0	0
1	279		1	t	819	HCF4049UBE	1	0	0
1	279		1	t	820	CD4049UBE	1	0	0
2	1470	60K5118	1	t	821	CD4050BE	1	0	0
2	9	59K8220	1	t	822	MAX232N	1	0	0
2	1472	08J8743	1	t	823	MCP4921-E/P	1	0	0
1	1479		1	t	824	LM358N	1	0	0
1	1480		1	t	825	LM393N	1	0	0
1	1389		1	t	826	LT1013CP	1	0	0
1	1481		1	t	827	LM324N	1	0	0
1	1482		1	t	828	AM26LS31CN	1	0	0
1	1483		1	t	829	LM339N	1	0	0
2	1488	01M8224	1	t	831		1	0	0
2	1490	12J4725	1	t	832		1	0	0
39	1497		1	t	833		1	0	0
2	482		1	t	834		1	0	0
40	1558		1	t	838		1	0	0
40	24		1	t	839		1	0	0
2	24	9332391	50	f	450		1	0	0
2	24	911-975	50	f	40		1	0	0
40	1586		1	t	840		1	0	0
2	659	911-732	50	f	39		1	0	0
40	659		1	t	841		1	0	0
40	1587		1	t	842		1	0	0
40	106		1	t	843		1	0	0
40	1588		1	t	844		1	0	0
1	371		1	t	845		1	0	0
40	21		1	t	846		1	0	0
40	1280		1	t	847		1	0	0
40	1251		1	t	848		1	0	0
40	1589		1	t	850		1	0	0
40	1590		1	t	851		1	0	0
40	117		1	t	852		1	0	0
40	1591		1	t	853		1	0	0
40	1350		1	t	854		1	0	0
40	1592		1	t	856		1	0	0
40	1593		1	t	857		1	0	0
40	1594		1	t	858		1	0	0
40	1595		1	t	859		1	0	0
40	1596		1	t	860		1	0	0
40	1597		1	t	861		1	0	0
40	1598		1	t	863		1	0	0
40	1599		1	t	864		1	0	0
40	26		1	t	865		1	0	0
40	647		1	t	866		1	0	0
40	1314		1	t	867		1	0	0
1	412	22-MM74	1	t	673	MM74HC244WM	1	0	0
1	0		1	f	868	MM2345	0	0	0
\.


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: jrm
--

COPY public.suppliers (id, name, legalname, federal_code, state_code, city_code, phone, fax) FROM stdin;
24	De Santis	De Santis Comercial Ltda	\N	\N	\N	\N	\N
9	Autsens	Autsens Indústria e Comércio de Equipamentos Eletrônicos Ltda. ME	\N	\N	\N	\N	\N
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
37	Varoto		\N	\N	\N	\N	\N
38	Meta Laser		\N	\N	\N	\N	\N
0	00 invalid						
1	0 gen.	Fornecedor genérico					
39	Proesi						
40	0 Mouser	Mouser do Brazil					https://www.mouser.com
41	Aliexpress						
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

SELECT pg_catalog.setval('public.cases_id_seq', 20, true);


--
-- Name: components_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jrm
--

SELECT pg_catalog.setval('public.components_id_seq', 1614, true);


--
-- Name: currencies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jrm
--

SELECT pg_catalog.setval('public.currencies_id_seq', 13, true);


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jrm
--

SELECT pg_catalog.setval('public.groups_id_seq', 180, true);


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

SELECT pg_catalog.setval('public.location_entry_id_seq', 2711, true);


--
-- Name: location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jrm
--

SELECT pg_catalog.setval('public.location_id_seq', 143, true);


--
-- Name: manufacturers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jrm
--

SELECT pg_catalog.setval('public.manufacturers_id_seq', 13, true);


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

SELECT pg_catalog.setval('public.suppliercodes_id_seq', 869, true);


--
-- Name: suppliers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jrm
--

SELECT pg_catalog.setval('public.suppliers_id_seq', 42, true);


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

