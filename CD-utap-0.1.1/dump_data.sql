--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.6
-- Dumped by pg_dump version 9.6.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: carver; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.carver (id, value, score, description) FROM stdin;
1	Criticality	1	The associated gap is not useful in addressing the overall issue.
2	Criticality	2	Closing gap would nominally contribute to understanding the overall issue.
3	Criticality	3	Closing gap is of moderate importance to the overall issue.
4	Criticality	4	Closing gap is an important component of the overall issue.
5	Criticality	5	Closing gap is critical to addressing the overall issue.
6	Access	1	No placement and\naccess; prospects for\nfuture placement and\naccess are limited;\ntechnology does not\nexist to collect. No\ncollection capability\nexists nor is in R&D\nfor the next 3-5 years;\nno source\ndevelopment likely.\n
7	Access	2	Placement and\naccess will take\nsignificant time to\ndevelop; technology\ncurrently in\ndevelopment.\nCollection capability\ncurrently undergoing\nR&D work-ups;\navailable in 1-2 years;\ntime needed to\ndevelop source.\n
8	Access	3	Placement and\naccess exists but\nneeds expansion;\ntechnology just\ncoming into inventory;\nprototypes may be\navailable. Prototype\ncollection asset may\nbe available when not\nin testing, may take\nmonths to get;\ninfrequent access to\nsource.\n
9	Access	4	Probable placement\nand access;\ntechnology exists but\nnot readily available.\nCollection assets are\navailable but need to\nbe repositioned/ gain\ncountry clearance;\nmay take weeks to\nget.\n
10	Access	5	Probable placement\nand access;\ntechnology exists and\nis readily available.\nCollection assets are\ncurrently in place/on\nhand and available for\ntasking.\n
11	Risk	1	High associated development or emplacement risk. Performance failure is likely in the field. Risk probably unmanageable.
12	Risk	2	Moderate associated development or emplacement risk.\nPerformance failure is possible in the field. Risk can be managed with difficulty.
13	Risk	3	A few development or emplacement risks. Some risk of performance failure in the field. Risks are manageable but need attention.
14	Risk	4	Minor development or emplacement risks. Satisfactory performance expected in the field. Risks can be effectively managed.
15	Risk	5	No significant associated development or emplacement risk. Good performance expected in the field. No significant risk management issues.
16	Vulnerability and Signature	1	Minor opportunities for technical collection; very difficult target. No signatures, unique or otherwise, are known for this issue.
17	Vulnerability and Signature	2	Limited opportunities for technical collection; expect many difficulties.\nLimited observables are available for collection on this issue.
18	Vulnerability and Signature	3	Moderately vulnerable to technical collection; some difficulties will be encountered.\nObservable signatures are produced for this issue, but they are not unique to the issue.
19	Vulnerability and Signature	4	Fairly vulnerable to technical collection; minor difficulties may occur. Observable signatures are predominantly limited to this issue, although some may conflict with non-targets.
20	Vulnerability and Signature	5	Completely vulnerable to technical collection; should be no technical problems.\nUnique signatures are known and capable of being observed.
21	Effect	1	Collection would have minor impact, if any, in addressing the gap
22	Effect	2	Few collection opportunities would have an impact.
23	Effect	3	Most collection would have a moderate impact.
24	Effect	4	Most collection would have a substantial impact.
25	Effect	5	Collection would have a significant impact on this gap.
26	Recognizability	1	Collection product extremely difficult to understand with extensive orientation. Essential signature libraries nonexistent. Recognition unlikely because of false alarms.
27	Recognizability	2	Hard to understand, confusion probable; requires coordination. Incomplete signature libraries. False alarms are a serious problem.
28	Recognizability	3	Understandable with some training.\nRelevant signatures need to be better characterized. False alarms are manageable.
29	Recognizability	4	Easily understood by most, with little confusion. Most signatures identifiable using existing libraries. Few if any false alarms.
30	Recognizability	5	Easily understood by all with no confusion. Signatures need no library or can be readily identified using existing libraries. No false alarms.
\.


--
-- Name: carver_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.carver_id_seq', 1, false);


--
-- Data for Name: collection_concepts; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.collection_concepts (id, name) FROM stdin;
1	lrw changed 2059
5	Collection Concept
7	Collection Concept
8	Collection Concept
9	Collection Concept
10	Collection Concept
11	Collection Concept
13	Collection Concept 2
14	Collection Concept 2
15	Collection Concept 2
12	Collection Concept
16	Collection Concept
17	Collection Concept 2
18	Collection Concept
19	Collection Concept 2
21	Collection Concept 3
22	Collection Concepts
23	Collection Concept
24	Collection Concept
25	Collection Concept
20	Concept Changed Name 2
28	Collection Concept 3 Copy
27	CC 
26	Collection Concept
29	Collection Concept 3
30	Collection Concept 3
31	Collection Concept 3
32	Collection Concept 3
33	Collection Concept 3
34	Collection Concept 3
35	Collection Concept 3
36	Collection Concept 3
37	Collection Concept
38	Collection Concept
39	Collection Concept
40	Collection Concept
41	Collection Concept
42	1st collection concept 111
43	Collection Concept
44	Collection Concept
45	Collection Concept
46	Collection Concept
47	Collection Concept
48	Collection Concept
49	Collection Concept
50	Collection Concept
51	Collection Concept
52	Collection Concept
53	Collection Concept
\.


--
-- Name: collection_concepts_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.collection_concepts_id_seq', 53, true);


--
-- Data for Name: collection_req_type; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.collection_req_type (id, name) FROM stdin;
1	OSINT
2	ELINT
3	SIGINT
4	IMINT
5	MASINT
6	GEOINT
7	HUMINT
\.


--
-- Name: collection_req_type_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.collection_req_type_id_seq', 1, false);


--
-- Data for Name: concept_carver_scores; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.concept_carver_scores (collection_concept_id, carver_id) FROM stdin;
1	12
8	1
8	7
8	13
8	19
8	25
8	26
9	1
9	7
9	13
9	19
9	25
9	26
11	1
11	7
11	13
11	19
11	25
11	26
12	1
12	7
12	13
12	19
12	25
12	26
15	5
15	9
15	13
15	17
15	21
15	27
16	26
16	1
16	7
16	12
16	18
16	23
17	5
17	9
17	13
17	17
17	21
17	27
18	26
18	1
18	7
18	12
18	18
18	23
19	5
19	9
19	13
19	17
19	21
19	27
20	1
21	5
21	9
21	13
21	17
21	21
21	27
22	1
22	7
22	13
22	19
22	25
22	29
23	1
23	7
23	13
23	19
23	25
23	26
24	1
24	7
24	13
24	19
24	25
24	26
25	2
25	9
25	12
25	19
25	22
25	29
20	28
28	5
28	9
28	13
28	17
28	21
28	27
27	21
27	13
27	18
27	8
27	3
27	26
26	13
26	5
26	9
26	17
26	21
26	30
29	5
29	9
29	13
29	17
29	21
29	27
30	27
30	21
30	17
30	13
30	9
30	5
31	27
31	21
31	17
31	13
31	9
31	5
32	27
32	21
32	17
32	13
32	9
32	5
33	27
33	21
33	17
33	13
33	9
33	5
34	27
34	21
34	17
34	13
34	9
34	5
35	5
35	9
35	13
35	17
35	21
35	27
36	5
36	9
36	13
36	17
36	21
36	27
37	1
37	7
37	13
37	19
37	25
37	26
38	5
38	9
38	13
38	17
38	21
38	30
39	5
39	9
39	13
39	17
39	21
39	30
40	5
40	9
40	13
40	17
40	21
40	30
41	4
41	6
41	14
41	18
41	22
41	29
42	1
42	7
42	13
42	19
42	25
42	26
43	1
43	6
43	11
43	16
43	21
43	26
44	5
44	9
44	13
44	17
44	21
44	30
45	5
45	9
45	13
45	17
45	21
45	30
46	5
46	9
46	13
46	17
46	21
46	30
47	5
47	9
47	13
47	17
47	21
47	30
48	5
48	9
48	13
48	17
48	21
48	30
49	5
49	9
49	13
49	17
49	21
49	30
50	5
50	9
50	13
50	17
50	21
50	30
51	5
51	9
51	13
51	17
51	21
51	26
52	1
52	7
52	13
52	18
52	24
52	30
53	5
53	9
53	13
53	17
53	21
53	30
\.


--
-- Name: concept_carver_scores_carver_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.concept_carver_scores_carver_id_seq', 1, false);


--
-- Name: concept_carver_scores_collection_concept_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.concept_carver_scores_collection_concept_id_seq', 1, false);


--
-- Data for Name: countries; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.countries (id, name) FROM stdin;
AF	Afghanistan
AX	Åland Islands
AL	Albania
DZ	Algeria
AS	American Samoa
AD	Andorra
AO	Angola
AI	Anguilla
AQ	Antarctica
AG	Antigua and Barbuda
AR	Argentina
AM	Armenia
AW	Aruba
AU	Australia
AT	Austria
AZ	Azerbaijan
BS	Bahamas
BH	Bahrain
BD	Bangladesh
BB	Barbados
BY	Belarus
BE	Belgium
BZ	Belize
BJ	Benin
BM	Bermu{da
BT	Bhutan
BO	Bolivia, Plurinational State of
BQ	Bonaire, Sint Eustatius and Saba
BA	Bosnia and Herzegovina
BW	Botswana
BV	Bouvet Island
BR	Brazil
IO	British Indian Ocean Territory
BN	Brunei Darussalam
BG	Bulgaria
BF	Burkina Faso
BI	Burundi
KH	Cambodia
CM	Cameroon
CA	Canada
CV	Cape Verde
KY	Cayman Islands
CF	Central African Republic
TD	Chad
CL	Chile
CN	China
CX	Christmas Island
CC	Cocos (Keeling) Islands
CO	Colombia
KM	Comoros
CG	Congo
CD	Congo, the Democratic Republic of the
CK	Cook Islands
CR	Costa Rica
CI	Côte d'Ivoire
HR	Croatia
CU	Cuba
CW	Curaçao
CY	Cyprus
CZ	Czech Republic
DK	Denmark
DJ	Djibouti
DM	Dominica
DO	Dominican Republic
EC	Ecuador
EG	Egypt
SV	El Salvador
GQ	Equatorial Guinea
ER	Eritrea
EE	Estonia
ET	Ethiopia
FK	Falkland Islands (Malvinas)
FO	Faroe Islands
FJ	Fiji
FI	Finland
FR	France
GF	French Guiana
PF	French Polynesia
TF	French Southern Territories
GA	Gabon
GM	Gambia
GE	Georgia
DE	Germany
GH	Ghana
GI	Gibraltar
GR	Greece
GL	Greenland
GD	Grenada
GP	Guadeloupe
GU	Guam
GT	Guatemala
GG	Guernsey
GN	Guinea
GW	Guinea-Bissau
GY	Guyana
HT	Haiti
HM	Heard Island and McDonald Islands
VA	Holy See (Vatican City State)
HN	Honduras
HK	Hong Kong
HU	Hungary
IS	Iceland
IN	India
ID	Indonesia
IR	Iran, Islamic Republic of
IQ	Iraq
IE	Ireland
IM	Isle of Man
IL	Israel
IT	Italy
JM	Jamaica
JP	Japan
JE	Jersey
JO	Jordan
KZ	Kazakhstan
KE	Kenya
KI	Kiribati
KP	Korea, Democratic People's Republic of
KR	Korea, Republic of
KW	Kuwait
KG	Kyrgyzstan
LA	Lao People's Democratic Republic
LV	Latvia
LB	Lebanon
LS	Lesotho
LR	Liberia
LY	Libya
LI	Liechtenstein
LT	Lithuania
LU	Luxembourg
MO	Macao
MK	Macedonia, the former Yugoslav Republic of
MG	Madagascar
MW	Malawi
MY	Malaysia
MV	Maldives
ML	Mali
MT	Malta
MH	Marshall Islands
MQ	Martinique
MR	Mauritania
MU	Mauritius
YT	Mayotte
MX	Mexico
FM	Micronesia, Federated States of
MD	Moldova, Republic of
MC	Monaco
MN	Mongolia
ME	Montenegro
MS	Montserrat
MA	Morocco
MZ	Mozambique
MM	Myanmar
NA	Namibia
NR	Nauru
NP	Nepal
NL	Netherlands
NC	New Caledonia
NZ	New Zealand
NI	Nicaragua
NE	Niger
NG	Nigeria
NU	Niue
NF	Norfolk Island
MP	Northern Mariana Islands
NO	Norway
OM	Oman
PK	Pakistan
PW	Palau
PS	Palestinian Territory, Occupied
PA	Panama
PG	Papua New Guinea
PY	Paraguay
PE	Peru
PH	Philippines
PN	Pitcairn
PL	Poland
PT	Portugal
PR	Puerto Rico
QA	Qatar
RE	Réunion
RO	Romania
RU	Russian Federation
RW	Rwanda
BL	Saint Barthélemy
SH	Saint Helena, Ascension and Tristan da Cunha
KN	Saint Kitts and Nevis
LC	Saint Lucia
MF	Saint Martin (French part)
PM	Saint Pierre and Miquelon
VC	Saint Vincent and the Grenadines
WS	Samoa
SM	San Marino
ST	Sao Tome and Principe
SA	Saudi Arabia
SN	Senegal
RS	Serbia
SC	Seychelles
SL	Sierra Leone
SG	Singapore
SX	Sint Maarten (Dutch part)
SK	Slovakia
SI	Slovenia
SB	Solomon Islands
SO	Somalia
ZA	South Africa
GS	South Georgia and the South Sandwich Islands
SS	South Sudan
ES	Spain
LK	Sri Lanka
SD	Sudan
SR	Suriname
SJ	Svalbard and Jan Mayen
SZ	Swaziland
SE	Sweden
CH	Switzerland
SY	Syrian Arab Republic
TW	Taiwan, Province of China
TJ	Tajikistan
TZ	Tanzania, United Republic of
TH	Thailand
TL	Timor-Leste
TG	Togo
TK	Tokelau
TO	Tonga
TT	Trinidad and Tobago
TN	Tunisia
TR	Turkey
TM	Turkmenistan
TC	Turks and Caicos Islands
TV	Tuvalu
UG	Uganda
UA	Ukraine
AE	United Arab Emirates
GB	United Kingdom
USA	United States
UM	United States Minor Outlying Islands
UY	Uruguay
UZ	Uzbekistan
VU	Vanuatu
VE	Venezuela, Bolivarian Republic of
VN	Viet Nam
VG	Virgin Islands, British
VI	Virgin Islands, U.S.
WF	Wallis and Futuna
EH	Western Sahara
YE	Yemen
ZM	Zambia
ZW	Zimbabwe
\.


--
-- Data for Name: framework; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.framework (id, name, description, created_by, updated_by, created_date, updated_date) FROM stdin;
3	LRW - Testing from Postman	test desc	test_user_for_now	test_user_for_now	2018-08-30 20:01:10.231	2018-08-30 20:01:10.232
5	MEB - Test Framework	\N	test_user_for_now	test_user_for_now	2018-08-31 16:35:39.302	2018-08-31 16:35:39.302
19	MEB - Test Framework 2	\N	test_user_for_now	test_user_for_now	2018-09-05 17:54:51.462	2018-09-05 17:54:51.463
21	np-test1	\N	test_user_for_now	test_user_for_now	2018-09-18 08:58:03.241	2018-09-18 08:58:03.242
22	np-test2	\N	test_user_for_now	test_user_for_now	2018-09-18 09:08:18.065	2018-09-18 09:08:18.065
24	LRW test	\N	test_user_for_now	test_user_for_now	2018-09-21 00:07:33.503	2018-09-21 00:07:33.503
25	Testing Framework load create	\N	test_user_for_now	test_user_for_now	2018-09-21 14:46:19.277	2018-09-21 14:46:19.279
26	test_aar	This is a test framework	test_user_for_now	test_user_for_now	2018-09-24 13:47:00.879	2018-09-24 13:47:00.879
27	Verify functionality of site	Description to test the functionality	test_user_for_now	test_user_for_now	2018-09-25 20:47:33.577	2018-09-25 20:47:33.577
28	test-jll	Testing framework	test_user_for_now	test_user_for_now	2018-09-28 19:44:02.135	2018-09-28 19:44:02.135
29	Radiant	Radiant Solutions Demo	test_user_for_now	test_user_for_now	2018-10-02 13:02:28.942	2018-10-02 13:02:28.942
30	LRW test 3	A test framework	test_user_for_now	test_user_for_now	2018-10-03 13:39:39.633	2018-10-03 13:39:39.633
31	UTAP Demo	Demo description	test_user_for_now	test_user_for_now	2018-10-03 16:38:13.853	2018-10-03 16:38:13.853
\.


--
-- Name: framework_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.framework_id_seq', 31, true);


--
-- Data for Name: node; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.node (id, name, path, created_date, created_by, updated_date, updated_by, be_number, be_link, classification, country, description, image_blob, has_rfi, speculated) FROM stdin;
386	Location	384.386	2018-10-03 16:38:58.044	test_user_for_now	2018-10-03 16:39:21.68	\N			\N			386	f	f
387	Network	384.385.387	2018-10-03 16:39:02.217	test_user_for_now	2018-10-03 16:40:43.2	\N			\N	AQ		387	t	t
399	Child of ABC	103.289.393.399	2018-10-04 12:09:37.097	test_user_for_now	2018-10-05 14:44:01.154	\N			\N			399	f	f
293	(NODE)	103.293	2018-10-01 18:25:47.686	test_user_for_now	2018-10-01 18:25:47.686	\N	\N	\N	\N	\N		293	f	f
310	Radiant	310	2018-10-02 13:02:28.944	test_user_for_now	2018-10-02 14:27:26.695	\N	\N	\N	\N	\N	TestFramework\n	310	f	f
311	Transportation	310.311	2018-10-02 14:31:11.454	test_user_for_now	2018-10-02 14:31:11.454	\N	\N	\N	\N	\N		311	f	f
312	Parking Lot	310.311.312	2018-10-02 14:32:14.605	test_user_for_now	2018-10-02 14:32:14.606	\N	\N	\N	\N	\N		312	f	f
357	little blue	13.357	2018-10-02 17:22:36.433	test_user_for_now	2018-10-02 17:23:04.345	\N			\N			357	f	f
384	UTAP Demo	384	2018-10-03 16:38:13.854	test_user_for_now	2018-10-03 16:38:13.855	\N	\N	\N	\N	\N	Demo description	384	f	f
385	Security	384.385	2018-10-03 16:38:49.427	test_user_for_now	2018-10-03 16:39:12.168	\N			\N			385	f	f
115	GeoTest	112.114.115	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now			\N			115	t	t
5	LRW Renamed Root Node	5	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now			\N			5	f	f
75	(NODE) 2	34.42.75	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now			\N			75	f	f
43	(NODE) 3	34.42.43	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now			\N			43	f	f
76	(PROCESS)	34.42.76	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now	\N	\N	\N	\N		76	f	f
313	(PROCESS)	310.311.312.313	2018-10-02 14:32:47.63	test_user_for_now	2018-10-02 14:32:47.631	\N	\N	\N	\N	\N		313	f	f
314	Bus Transit	310.311.314	2018-10-02 14:33:25.213	test_user_for_now	2018-10-02 14:33:25.214	\N	\N	\N	\N	\N		314	f	f
315	Bus Models	310.311.314.315	2018-10-02 14:33:48.557	test_user_for_now	2018-10-02 14:33:48.557	\N	\N	\N	\N	\N		315	f	f
316	Bus Transfer Locations	310.311.314.316	2018-10-02 14:34:16.679	test_user_for_now	2018-10-02 14:34:16.68	\N	\N	\N	\N	\N		316	f	f
317	Bus Maintenance Locations	310.311.314.317	2018-10-02 14:34:41.137	test_user_for_now	2018-10-02 14:34:41.137	\N	\N	\N	\N	\N		317	f	f
390	I am a leaf	103.289.290.390	2018-10-04 12:58:49.702	test_user_for_now	2018-10-05 14:43:49.612	\N			\N		hello	390	f	f
216	(NODE)	122.216	2018-09-28 19:42:19.842	test_user_for_now	2018-09-28 19:42:19.843	test_user_for_now	\N	\N	\N	\N		216	f	f
217	test-jll	217	2018-09-28 19:44:02.137	test_user_for_now	2018-09-28 19:44:02.138	test_user_for_now	\N	\N	\N	\N	Testing framework	217	f	f
103	LRW test	103	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now	\N	\N	\N	\N	\N	103	f	f
58	changed the name	5.50.58	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now	BE Number	BE Link	\N	CA	General Description 1	58	f	t
59	(NODE)	5.56.59	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now	\N	\N	\N	\N	\N	59	f	f
74	(NODE) 1	34.42.74	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now			\N			74	f	f
34	MEB - Test Framework 2	34	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now	\N	\N	\N	\N	\N	34	f	f
401	2 - Node 111	13.25.129.388.401	2018-10-05 13:49:58.699	test_user_for_now	2018-10-05 13:49:58.708	\N	BE Number		\N	PL	Here lies my testing node	401	t	t
122	Verify functionality of site	122	2018-09-25 20:47:33.606	test_user_for_now	2018-09-25 20:47:33.607	test_user_for_now	\N	\N	\N	\N	Description to test the functionality	122	f	f
318	Ruckersville	310.311.314.317.318	2018-10-02 14:35:31.543	test_user_for_now	2018-10-02 14:35:31.545	\N			\N			318	f	f
319	test3	310.311.314.317.318.319	2018-10-02 14:36:20.807	test_user_for_now	2018-10-02 14:36:20.807	\N	\N	\N	\N	\N		319	f	f
320	testw	310.311.314.317.318.320	2018-10-02 14:38:31.178	test_user_for_now	2018-10-02 14:38:31.179	\N	\N	\N	\N	\N		320	f	f
321	Richmond	310.311.314.317.321	2018-10-02 14:39:12.167	test_user_for_now	2018-10-02 14:39:12.169	\N	\N	\N	\N	\N		321	f	f
289	Process B	103.289	2018-10-01 16:53:38.185	test_user_for_now	2018-10-01 18:30:17.93	test_user_for_now			\N			289	f	f
393	Process B	103.289.393	2018-10-04 14:02:30.299	test_user_for_now	2018-10-05 14:44:01.157	\N			\N			393	f	f
322	(NODE)	310.311.314.317.321.322	2018-10-02 14:39:39.19	test_user_for_now	2018-10-02 14:39:39.191	\N	\N	\N	\N	\N		322	f	f
323	(NODE)	310.311.314.317.321.323	2018-10-02 14:40:04.221	test_user_for_now	2018-10-02 14:40:04.222	\N	\N	\N	\N	\N		323	f	f
324	Personnel	310.324	2018-10-02 14:40:25.56	test_user_for_now	2018-10-02 14:40:25.562	\N	\N	\N	\N	\N		324	f	f
25	The light blue	13.25	2018-09-25 01:28:01.316331	test_user_for_now	2018-10-03 18:21:33.311	test_user_for_now			\N		Light blue box 	25	f	f
330	Jack	310.324.329.330	2018-10-02 14:46:32.157	test_user_for_now	2018-10-02 14:46:32.159	\N	\N	\N	\N	\N		330	f	t
325	Security	310.324.325	2018-10-02 14:41:03.14	test_user_for_now	2018-10-02 14:41:03.141	\N		http://visualdataweb.de/webvowl/#	\N	\N		325	f	f
327	Maintenance	310.324.327	2018-10-02 14:43:57.805	test_user_for_now	2018-10-02 14:43:57.806	\N			\N			327	f	f
328	Contractors	310.324.328	2018-10-02 14:45:01.476	test_user_for_now	2018-10-02 14:45:01.477	\N			\N			328	f	f
329	Advanced Security	310.324.329	2018-10-02 14:45:57.982	test_user_for_now	2018-10-02 14:45:57.982	\N			\N			329	f	f
331	Adam	310.324.329.331	2018-10-02 14:47:30.36	test_user_for_now	2018-10-02 14:47:30.361	\N			\N			331	f	f
332	Environment	310.332	2018-10-02 14:47:57.022	test_user_for_now	2018-10-02 14:47:57.022	\N	\N	\N	\N	\N		332	f	f
333	Topography	310.332.333	2018-10-02 14:49:11.593	test_user_for_now	2018-10-02 14:49:11.594	\N			\N	AF	kjkj	333	f	f
334	Infrastructure	310.334	2018-10-02 14:49:47.798	test_user_for_now	2018-10-02 14:49:47.799	\N	\N	\N	\N	\N		334	f	f
335	HVAC	310.334.335	2018-10-02 14:50:16.199	test_user_for_now	2018-10-02 14:50:16.199	\N	\N	\N	\N	\N		335	f	f
336	Comms	310.334.336	2018-10-02 14:50:42.007	test_user_for_now	2018-10-02 14:50:42.008	\N	\N	\N	\N	\N		336	f	f
337	Networks	310.334.336.337	2018-10-02 14:52:38.539	test_user_for_now	2018-10-02 14:52:38.539	\N	\N	\N	\N	\N		337	f	f
338	Dev Network	310.334.336.337.338	2018-10-02 14:53:02.58	test_user_for_now	2018-10-02 14:53:02.581	\N	\N	\N	\N	\N		338	f	f
339	a	310.334.336.337.338.339	2018-10-02 14:53:25.816	test_user_for_now	2018-10-02 14:53:25.817	\N	\N	\N	\N	\N		339	f	f
340	(NODE)	310.334.336.337.338.340	2018-10-02 14:53:49.728	test_user_for_now	2018-10-02 14:53:49.728	\N	\N	\N	\N	\N		340	f	f
290	Process C	103.289.290	2018-10-01 16:53:55.224	test_user_for_now	2018-10-05 14:43:49.615	test_user_for_now			\N			290	f	f
129	2 - Node 111	13.25.129	2018-09-27 16:51:22.824	test_user_for_now	2018-10-04 20:51:09.449	test_user_for_now	BE Number		\N	PL	Here lies my testing node	129	t	t
326	UVA Research Park Security	310.324.325.326	2018-10-02 14:42:44.413	test_user_for_now	2018-10-06 17:56:10.847	\N			\N			326	t	t
388	Process Testing	13.25.129.388	2018-10-03 18:31:26.61	test_user_for_now	2018-10-04 20:33:27.824	\N	be num	be link	\N	AM		388	t	t
402	(NODE) 2 try from localhost   	13.357.402	2018-10-05 13:50:12.444	test_user_for_now	2018-10-05 13:50:12.444	\N	BE Number	BE Link	\N	AG	Short Description	402	t	f
403	Process Testing	9999999	2018-10-05 13:50:28.608	test_user_for_now	\N	\N	be num	be link	\N	AM		403	t	t
404	Process Testing	9999999.404	2018-10-05 13:50:42.902	test_user_for_now	2018-10-05 13:50:42.902	\N	be num	be link	\N	AM		404	t	t
77	np-test1	77	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now	\N	\N	\N	\N	\N	77	f	f
97	(NODE)	34.97	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now	\N	\N	\N	\N		97	f	f
78	(NODE)	9999999	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now	\N	\N	\N	\N		78	f	f
50	B Side	5.50	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now	BE Number	BE Link	\N	CC	General Description 1	50	t	t
56	A Side	5.56	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now	BE Number	BE Link	\N	CA	General Description 1	56	f	t
26	(NODE) 2 try from localhost   	13.25.26	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-27 14:49:01.145	test_user_for_now	BE Number	BE Link	\N	AG	Short Description	26	t	f
80	(PROCESS)	9999999	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now	\N	\N	\N	\N		80	f	f
98	(DOMAIN)	9999999	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now	\N	\N	\N	\N		98	f	f
79	(PROCESS)-one	9999999	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now			\N			79	f	f
81	(NODE)	9999999	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now	\N	\N	\N	\N		81	f	f
82	(NODE)	9999999	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now	\N	\N	\N	\N		82	f	f
83	np-test2	83	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now	\N	\N	\N	\N	\N	83	f	f
84	domain1	9999999	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now			\N			84	f	f
99	(PROCESS)	9999999	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now	\N	\N	\N	\N		99	f	f
100	(NODE)	9999999	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now	\N	\N	\N	\N		100	f	f
101	(PROCESS)	34.97.101	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now	\N	\N	\N	\N		101	f	f
57	changed the name	5.56.59.57	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now	BE Number	BE Link	\N	CA	General Description 1	57	f	t
102	(NODE)	9999999	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now	\N	\N	\N	\N		102	f	f
8	(NODE)	5.50.58.8	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now			\N			8	f	f
107	Testing Framework load create	107	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now	\N	\N	\N	\N	\N	107	f	f
113	A	112.113	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now			\N			113	f	f
114	B	112.114	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now			\N			114	f	f
112	test_aar	112	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now			\N		\ntest	112	f	f
117	(NODE)	112.114.115.116.117	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now	\N	\N	\N	\N		117	f	f
116	C	112.114.115.116	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now			\N			116	f	f
343	Water	310.334.343	2018-10-02 14:56:49.055	test_user_for_now	2018-10-02 14:56:49.056	\N	\N	\N	\N	\N		343	f	f
344	Power	310.334.344	2018-10-02 14:57:19.431	test_user_for_now	2018-10-02 14:57:19.432	\N	\N	\N	\N	\N		344	f	f
118	(NODE)	112.114.115.118	2018-09-25 01:28:01.316331	test_user_for_now	2018-09-25 01:28:01.316331	test_user_for_now	\N	\N	\N	\N		118	f	f
342	BYOD WiFi	310.334.336.337.341.342	2018-10-02 14:56:23.528	test_user_for_now	2018-10-05 16:51:03.305	\N		http://www.google.com	\N			342	t	t
345	Security	310.334.345	2018-10-02 14:57:45.285	test_user_for_now	2018-10-02 14:57:45.286	\N	\N	\N	\N	\N		345	f	f
346	Main Entrance	310.334.345.346	2018-10-02 14:58:44.812	test_user_for_now	2018-10-02 14:58:44.812	\N	\N	\N	\N	\N		346	t	t
347	Garage Elevator	310.334.345.347	2018-10-02 14:59:19.103	test_user_for_now	2018-10-02 14:59:19.103	\N	\N	\N	\N	\N		347	f	f
348	Facilities	310.348	2018-10-02 14:59:41.689	test_user_for_now	2018-10-02 14:59:41.69	\N	\N	\N	\N	\N		348	f	f
349	UVA Research Park	310.348.349	2018-10-02 15:00:04.566	test_user_for_now	2018-10-02 15:00:04.567	\N	\N	\N	\N	\N		349	f	f
350	Bakery	310.348.349.350	2018-10-02 15:00:31.841	test_user_for_now	2018-10-02 15:00:31.843	\N	\N	\N	\N	\N		350	f	f
351	Reston Sunset Valley	310.348.351	2018-10-02 15:00:59.395	test_user_for_now	2018-10-02 15:00:59.396	\N	\N	\N	\N	\N		351	f	f
352	Gaithersburg Diamond Ave	310.348.352	2018-10-02 15:01:21.777	test_user_for_now	2018-10-02 15:01:21.778	\N	\N	\N	\N	\N		352	f	f
353	Accounting	310.348.352.353	2018-10-02 15:01:48.374	test_user_for_now	2018-10-02 15:01:48.375	\N	\N	\N	\N	\N		353	f	f
13	MEB - Test Framework	13	2018-09-25 01:28:01.316331	test_user_for_now	2018-10-04 20:30:44.515	test_user_for_now			\N		testing	13	f	f
376	C	372.376	2018-10-03 13:40:12.568	test_user_for_now	2018-10-03 13:41:09.225	\N			\N			376	f	f
372	LRW test 3	372	2018-10-03 13:39:39.654	test_user_for_now	2018-10-03 13:39:39.655	\N	\N	\N	\N	\N	A test framework	372	f	f
374	Security	372.374	2018-10-03 13:40:03.515	test_user_for_now	2018-10-03 13:40:50.766	\N			\N			374	f	f
373	Network	372.374.373	2018-10-03 13:39:48.32	test_user_for_now	2018-10-03 13:47:47.084	\N			\N			373	t	t
375	B	372.375	2018-10-03 13:40:08.45	test_user_for_now	2018-10-03 13:41:03.42	\N			\N			375	f	f
377	Laundry	372.376.377	2018-10-03 13:48:36.54	test_user_for_now	2018-10-03 13:50:01.699	\N			\N			377	f	f
341	Business Network	310.334.336.337.341	2018-10-02 14:54:13.02	test_user_for_now	2018-10-05 16:49:39.158	\N	\N	\N	\N	\N		341	f	f
\.


--
-- Data for Name: framework_nodes; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.framework_nodes (framework_id, node_id) FROM stdin;
25	107
5	401
5	402
3	5
5	403
26	112
3	8
26	113
26	114
26	115
26	116
5	13
26	117
26	118
5	404
27	122
5	25
5	26
24	289
24	290
5	129
24	293
19	34
19	43
3	50
3	56
3	57
3	58
3	59
29	310
29	311
29	312
29	313
29	314
29	315
29	316
29	317
29	318
29	319
29	320
29	321
19	74
19	75
19	76
21	77
21	78
21	79
21	80
21	81
21	82
22	83
22	84
29	322
29	323
29	324
29	325
29	326
29	327
29	328
29	329
27	216
28	217
29	330
29	331
19	97
19	98
19	99
19	100
19	101
3	102
24	103
29	332
29	333
29	334
29	335
29	336
29	337
29	338
29	339
29	340
29	341
29	342
29	343
29	344
29	345
29	346
29	347
29	348
29	349
29	350
29	351
29	352
29	353
5	357
30	372
30	373
30	374
30	375
30	376
30	377
31	384
31	385
31	386
31	387
5	388
24	390
24	393
24	399
\.


--
-- Name: framework_nodes_framework_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.framework_nodes_framework_id_seq', 1, false);


--
-- Name: framework_nodes_node_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.framework_nodes_node_id_seq', 1, false);


--
-- Name: node_accesses_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_accesses_id_seq', 1, false);


--
-- Name: node_accesses_node_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_accesses_node_id_seq', 1, false);


--
-- Name: node_accesses_vsa_type_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_accesses_vsa_type_id_seq', 1, false);


--
-- Data for Name: node_collection_concepts; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.node_collection_concepts (node_id, collection_concept_id) FROM stdin;
50	29
56	34
57	35
58	36
115	41
129	49
373	52
401	53
\.


--
-- Name: node_collection_concepts_collection_concept_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_collection_concepts_collection_concept_id_seq', 1, false);


--
-- Name: node_collection_concepts_node_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_collection_concepts_node_id_seq', 1, false);


--
-- Data for Name: node_collection_reqs; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.node_collection_reqs (id, node_id, collection_req_type_id, link, user_comments, collection_flag) FROM stdin;
24	50	3	\N	LRW Testing Coll Req	t
29	115	3	\N	\N	t
28	115	5	\N	\N	t
39	129	3	collection req link	comment	t
42	373	2	\N	A collection requirement	t
43	387	3	\N	\N	t
45	401	3	collection req link	comment	t
46	290	3	http://www.google.com	\N	t
47	342	5	\N	asdf	t
\.


--
-- Name: node_collection_reqs_collection_req_type_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_collection_reqs_collection_req_type_id_seq', 1, false);


--
-- Name: node_collection_reqs_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_collection_reqs_id_seq', 47, true);


--
-- Name: node_collection_reqs_node_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_collection_reqs_node_id_seq', 1, false);


--
-- Name: node_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_id_seq', 404, true);


--
-- Name: node_image_blob_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_image_blob_seq', 404, true);


--
-- Data for Name: node_locations; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.node_locations (id, node_id, name, lat, lon, comments) FROM stdin;
65	115	\N	40.73347023268492	-74.00667618200053	\N
66	115	\N	40.732949922769336	-73.97750324431748	\N
67	115	\N	40.70823051511181	-74.02040462326313	\N
68	115	\N	40.72280306615735	-73.953479477609	\N
90	388	\N	40.74309523218185	-73.98758759695141	\N
91	388	\N	40.737892702684064	-73.99033558245151	\N
92	388	\N	40.74816730666263	-73.97988940133696	\N
93	403	\N	40.74309523218185	-73.98758759695141	\N
94	403	\N	40.737892702684064	-73.99033558245151	\N
95	403	\N	40.74816730666263	-73.97988940133696	\N
96	404	\N	40.74309523218185	-73.98758759695141	\N
97	404	\N	40.737892702684064	-73.99033558245151	\N
98	404	\N	40.74816730666263	-73.97988940133696	\N
99	290	\N	40.74075414426252	-73.9952534239496	\N
100	290	\N	40.73691718310342	-73.98890748527184	\N
101	342	\N	40.73737242735457	-74.01216755850558	\N
102	342	\N	40.72514478577351	-73.98024893257	\N
103	342	\N	40.71903012236456	-73.99705353676983	\N
104	326	\N	40.71890001704013	-74.02485882541548	\N
105	326	\N	40.7221525738643	-74.00649703522672	\N
\.


--
-- Name: node_locations_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_locations_id_seq', 105, true);


--
-- Name: node_locations_node_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_locations_node_id_seq', 1, false);


--
-- Data for Name: node_processes; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.node_processes (id, node_id, name, sequence_num, duration, comments, has_rfi) FROM stdin;
120	357	\N	1	0	\N	f
122	374	\N	1	0	\N	f
123	375	\N	1	0	\N	f
124	376	\N	1	0	\N	f
126	373	\N	1	0	\N	f
127	377	Sorting	1	0	\N	t
128	377	Washing	2	0	\N	f
129	377	Drying	3	0	\N	f
130	377	Folding	4	0	\N	f
131	385	\N	1	0	\N	f
132	386	\N	1	0	\N	f
134	387	\N	1	0	\N	f
135	25	\N	1	0	\N	f
142	399	\N	1	0	\N	f
144	13	\N	1	0	\N	f
146	129	\N	1	0	\N	f
96	26	\N	1	0	\N	f
148	401	\N	1	0	\N	f
149	402	\N	1	0	\N	f
150	390	\N	1	0	\N	f
153	342	\N	1	0	\N	f
156	326	\N	1	0	\N	f
\.


--
-- Name: node_processes_duration_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_processes_duration_seq', 1, false);


--
-- Name: node_processes_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_processes_id_seq', 156, true);


--
-- Name: node_processes_node_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_processes_node_id_seq', 1, false);


--
-- Data for Name: node_selectors; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.node_selectors (id, node_id, selector, has_rfi) FROM stdin;
\.


--
-- Name: node_selectors_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_selectors_id_seq', 1, false);


--
-- Name: node_selectors_node_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_selectors_node_id_seq', 1, false);


--
-- Name: node_signatures_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_signatures_id_seq', 1, false);


--
-- Name: node_signatures_node_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_signatures_node_id_seq', 1, false);


--
-- Name: node_signatures_vsa_type_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_signatures_vsa_type_id_seq', 1, false);


--
-- Data for Name: sources; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.sources (id, name) FROM stdin;
1	OSINT
2	ELINT
3	SIGINT
4	IMINT
5	MASINT
6	GEOINT
7	HUMINT
\.


--
-- Data for Name: node_sources; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.node_sources (node_id, source_id, link, doc_blob, comments) FROM stdin;
50	2	\N	\N	LRW Testing Source
115	2	https://digitalguardian.com/blog/what-nist-sp-800-53-definition-and-tips-nist-sp-800-53-compliance 	\N	SD
115	3	h	\N	\N
373	3	\N	\N	A souce
387	3	\N	\N	\N
388	3	Link	\N	Co,mment
403	3	Link	\N	Co,mment
404	3	Link	\N	Co,mment
290	3	\N	\N	\N
342	4	\N	\N	\N
342	6	\N	\N	\N
326	2	\N	\N	\N
\.


--
-- Name: node_sources_node_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_sources_node_id_seq', 1, false);


--
-- Name: node_sources_source_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_sources_source_id_seq', 1, false);


--
-- Data for Name: tags; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.tags (id, name) FROM stdin;
1	Administrative
2	Physical
3	Technological
4	Activity
5	Equipment
\.


--
-- Data for Name: node_tags; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.node_tags (node_id, tag_id) FROM stdin;
373	3
373	5
387	4
8	2
390	3
390	2
388	3
401	5
401	1
403	3
404	3
50	3
56	2
56	3
57	2
57	3
58	2
58	3
50	4
129	5
129	1
\.


--
-- Name: node_tags_node_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_tags_node_id_seq', 1, false);


--
-- Name: node_tags_tag_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_tags_tag_id_seq', 1, false);


--
-- Data for Name: type; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.type (id, name) FROM stdin;
1	NODE
2	DOMAIN
3	PROCESS
4	ROOT
5	FRAMEWORK
6	TEMPLATE
\.


--
-- Data for Name: node_types; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.node_types (node_id, node_type_id) FROM stdin;
107	4
401	1
402	1
5	4
403	3
112	4
8	1
113	2
114	2
115	1
116	1
13	4
117	1
118	1
404	3
122	4
25	2
26	1
289	3
290	3
129	1
293	1
34	4
43	1
50	1
56	1
57	1
58	1
59	1
310	4
311	2
312	1
313	3
314	1
315	1
316	1
317	1
318	1
319	1
320	1
321	1
74	1
75	1
76	3
77	4
78	1
79	3
80	3
81	1
82	1
83	4
84	2
322	1
323	1
324	2
325	1
326	1
327	1
328	1
329	1
216	1
217	4
330	1
331	1
97	1
98	2
99	3
100	1
101	3
102	1
103	4
332	2
333	1
334	2
335	1
336	1
337	1
338	1
339	1
340	1
341	1
342	1
343	1
344	1
345	1
346	1
347	1
348	2
349	1
350	3
351	1
352	1
353	1
357	2
372	4
373	1
374	2
375	2
376	2
377	3
384	4
385	2
386	2
387	1
388	3
390	1
393	3
399	1
\.


--
-- Name: node_types_node_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_types_node_id_seq', 1, false);


--
-- Name: node_types_node_type_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_types_node_type_id_seq', 1, false);


--
-- Data for Name: vsa_category; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.vsa_category (id, value) FROM stdin;
1	Signature
2	Access
3	Vulnerability
\.


--
-- Data for Name: vsa_type; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.vsa_type (id, value) FROM stdin;
1	unknown
2	yes
3	N/A
\.


--
-- Data for Name: vsa; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.vsa (id, vsa_type_id, vsa_category_id, description) FROM stdin;
2	2	3	abc
3	1	3	Vulnerability
4	2	3	abc
5	2	3	abc
6	2	3	abc
7	2	3	abc
8	2	3	abc
10	2	3	abc
11	2	3	abc
12	1	3	Vulnerability
13	2	1	Signature
14	3	2	Access
15	1	3	Vulnerability
16	2	1	Signature
17	3	2	Access
18	2	2	Access
19	1	3	Vulnerability
20	2	1	Signature
21	3	2	Access
22	1	3	Vulnerability
23	2	1	Signature
24	3	2	Access
25	2	3	Vulnerability
26	3	1	Signature
27	1	2	Access
28	1	3	Vulnerability
29	2	1	Signature
30	3	2	Access
31	1	3	Vulnerability
32	1	3	Vulnerability
33	2	3	Vulnerability
34	1	3	Vulnerability
35	2	1	Signature
36	3	2	Access
37	1	3	Vulnerability
38	2	1	Signature
39	3	2	Access
40	1	3	Vulnerability
41	2	3	V2
42	2	1	Signature
43	3	2	Access
44	1	3	Vulnerability
45	2	3	V2
46	2	1	Signature
47	3	2	Access
48	1	3	Vulnerability
49	2	3	V2
50	2	1	Signature
51	3	2	Access
52	1	3	Vulnerability
53	2	1	Signature
54	3	2	Access
55	1	3	Vulnerability
56	2	1	Signature
57	3	2	Access
58	1	3	Vulnerability
59	2	1	Signature
60	3	2	Access
61	1	3	Vulnerability
62	2	1	Signature
63	3	2	Access
64	1	3	Vulnerability
65	2	1	Signature
66	3	2	Access
67	1	3	Vulnerability
68	2	1	Signature
69	3	2	Access
70	1	3	Vulnerability
71	2	1	Signature
72	3	2	Access
73	1	3	Vulnerability
74	2	1	Signature
75	3	2	Access
76	1	3	Vulnerability
77	2	1	Signature
78	3	2	Access
79	1	3	Vulnerability
80	2	1	Signature
81	3	2	Access
82	1	3	Vulnerability
83	2	1	Signature
84	3	2	Access
85	1	3	Vulnerability
86	2	1	Signature
87	3	2	Access
88	1	3	Vulnerability
89	2	1	Signature
90	3	2	Access
91	1	3	Vulnerability
92	2	1	Signature
93	3	2	Access
94	1	3	Vulnerability
95	2	1	Signature
96	3	2	Access
97	1	3	Vulnerability
98	2	1	Signature
99	3	2	Access
100	1	3	Vulnerability
101	2	1	Signature
102	3	2	Access
103	1	3	Vulnerability
104	2	1	Signature
105	3	2	Access
106	1	3	Vulnerability
107	2	1	Signature
108	3	2	Access
109	1	3	Vulnerability
110	2	1	Signature
111	3	2	Access
112	2	3	LRW Vulnerability Test
113	2	3	LRW Vulnerability Test
114	2	3	LRW Vulnerability Test
115	2	3	LRW Vulnerability Test
116	2	3	LRW Vulnerability Test
117	2	3	LRW Vulnerability Test
118	2	3	LRW Vulnerability Test
119	1	3	Vulnerability
120	2	1	Signature
121	3	2	Access
122	1	3	Vulnerability
123	2	1	Signature
124	3	2	Access
125	1	3	Vulnerability
126	2	1	Signature
127	3	2	Access
128	1	3	Vulnerability
129	2	1	Signature
130	3	2	Access
131	1	3	Vulnerability
132	2	1	Signature
133	3	2	Access
138	2	1	sig
140	1	3	vuln
141	1	3	Vuln er a bilities
142	2	1	Signature
143	3	2	Access
146	2	3	khgf
147	2	2	khfg
148	2	3	khgf
149	2	2	khfg
150	2	3	khgf
151	2	2	khfg
152	2	3	khgf
153	2	2	khfg
154	2	3	khgf
155	2	1	j
156	2	2	khfg
157	2	3	khgf
158	2	1	j
159	2	2	khfg
160	2	3	khgf
161	2	1	j
162	2	2	khfg
174	2	1	Sig
175	3	2	Acc
173	1	3	Vulnerability 111
177	2	1	S
178	3	2	A
179	2	1	SSS
176	2	3	Vuk
180	3	2	555
181	1	3	asdf
182	1	3	vuln
183	1	3	1234455
184	2	1	asdf
185	1	2	asdf
191	2	1	sig
193	2	3	A vulnerability
197	2	1	sig
198	2	3	Test
199	2	1	kl
\.


--
-- Data for Name: node_vsa; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.node_vsa (node_id, vsa_id) FROM stdin;
50	118
129	191
387	193
401	197
290	198
326	199
115	160
115	161
115	162
\.


--
-- Name: node_vsa_node_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_vsa_node_id_seq', 1, true);


--
-- Name: node_vulnerabilities_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_vulnerabilities_id_seq', 1, false);


--
-- Name: node_vulnerabilities_node_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_vulnerabilities_node_id_seq', 1, false);


--
-- Name: node_vulnerabilities_vsa_type_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.node_vulnerabilities_vsa_type_id_seq', 1, false);


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.permissions (id, name) FROM stdin;
1	view
2	edit
3	manage
4	delete
\.


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.permissions_id_seq', 4, true);


--
-- Data for Name: related_nodes; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.related_nodes (node_id, related_node_id) FROM stdin;
56	8
57	8
58	8
50	59
129	13
373	376
377	374
401	13
\.


--
-- Name: related_nodes_node_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.related_nodes_node_id_seq', 1, false);


--
-- Name: related_nodes_related_node_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.related_nodes_related_node_id_seq', 1, false);


--
-- Data for Name: roles; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.roles (id, name) FROM stdin;
1	user
2	viewer
3	blocked
\.


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.roles_id_seq', 3, true);


--
-- Name: sources_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.sources_id_seq', 1, false);


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.tags_id_seq', 1, false);


--
-- Data for Name: template; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.template (id) FROM stdin;
\.


--
-- Name: template_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.template_id_seq', 1, false);


--
-- Data for Name: template_nodes; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.template_nodes (id, template_id, name, path) FROM stdin;
\.


--
-- Name: template_nodes_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.template_nodes_id_seq', 1, false);


--
-- Name: template_nodes_name_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.template_nodes_name_seq', 1, false);


--
-- Name: template_nodes_template_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.template_nodes_template_id_seq', 1, false);


--
-- Name: type_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.type_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.users (id, dn) FROM stdin;
2	CN=Sample Joe Anthony jasampl, OU=D001, OU=Agency A, OU=DoD, O=U.S. Government, C=US
3	CN=Abdel-Rahman Adam aabdel, OU=UTAPDEV, OU=The Initiative, OU=VA Office, O=Radiant Solutions, C=US
4	CN=Bellus Mary mbellus, OU=UTAPDEV, OU=The Initiative, OU=VA Office, O=Radiant Solutions, C=US
5	CN=Garrett Missy mgarrett, OU=UTAPDEV, OU=The Initiative, OU=VA Office, O=Radiant Solutions, C=US
6	CN=Fortney Jonathon jfortney, OU=UTAPDEV, OU=The Initiative, OU=VA Office, O=Radiant Solutions, C=US
7	CN=Harbulak Paul pharbulak, OU=UTAPDEV, OU=The Initiative, OU=VA Office, O=Radiant Solutions, C=US
8	CN=Harrison Justin jharrison, OU=UTAPDEV, OU=The Initiative, OU=VA Office, O=Radiant Solutions, C=US
9	CN=McMahon Jonathan jmcmahon, OU=UTAPDEV, OU=The Initiative, OU=VA Office, O=Radiant Solutions, C=US
10	CN=Siebken Shane ssiebken, OU=UTAPDEV, OU=The Initiative, OU=VA Office, O=Radiant Solutions, C=US
11	CN=Wong Craig cwong, OU=UTAPDEV, OU=The Initiative, OU=VA Office, O=Radiant Solutions, C=US
12	CN=Patra Nirmalendu npatra, OU=UTAPDEV, OU=The Initiative, OU=TX Office, O=Radiant Solutions, C=US
13	CN=Webb Laura lwebb, OU=UTAPDEV, OU=The Initiative, OU=CO Offic, O=Radiant Solutions, C=US
\.


--
-- Data for Name: user_permissions; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.user_permissions (user_id, permissions_id, framework_id) FROM stdin;
13	1	3
13	2	3
13	3	3
13	4	3
8	3	3
13	1	5
13	2	5
5	1	3
5	2	3
5	3	3
4	1	3
7	1	3
\.


--
-- Data for Name: user_permissions_bak; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.user_permissions_bak (id, user_id, permissions_id, framework_id) FROM stdin;
12	13	1	3
14	13	2	3
16	13	3	3
18	13	4	3
43	8	3	3
44	12	2	3
45	12	3	3
46	12	4	3
47	12	1	3
\.


--
-- Name: user_permissions_framework_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.user_permissions_framework_id_seq', 1, false);


--
-- Name: user_permissions_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.user_permissions_id_seq', 47, true);


--
-- Name: user_permissions_permissions_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.user_permissions_permissions_id_seq', 1, false);


--
-- Name: user_permissions_users_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.user_permissions_users_id_seq', 1, false);


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.user_roles (roles_id, user_id) FROM stdin;
1	5
1	6
2	8
1	9
1	12
2	7
2	11
1	13
2	10
1	4
1	3
\.


--
-- Data for Name: user_roles_bak; Type: TABLE DATA; Schema: utap; Owner: utap
--

COPY utap.user_roles_bak (id, roles_id, user_id) FROM stdin;
5	1	5
6	1	6
8	2	8
9	1	9
12	1	12
7	2	7
13	2	13
11	2	11
20	3	2
\.


--
-- Name: user_roles_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.user_roles_id_seq', 20, true);


--
-- Name: user_roles_roles_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.user_roles_roles_id_seq', 1, false);


--
-- Name: user_roles_users_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.user_roles_users_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.users_id_seq', 13, true);


--
-- Name: vsa_category_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.vsa_category_id_seq', 3, true);


--
-- Name: vsa_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.vsa_id_seq', 199, true);


--
-- Name: vsa_type_id_seq; Type: SEQUENCE SET; Schema: utap; Owner: utap
--

SELECT pg_catalog.setval('utap.vsa_type_id_seq', 1, false);


--
-- PostgreSQL database dump complete
--

