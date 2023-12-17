-- Criacao das tabelas

--tabelas antes da normalizacao

create table if not exists processo_eleitoral (

	DT_GERACAO date not null,
	HH_GERACAO time not null,
	ANO_ELEICAO integer not null,
	NR_PROCESSO varchar(50),
	DT_AUTUACAO date not null,
	DT_BAIXA date,
	SG_UF_TRIBUNAL_ORIGEM varchar(2) not null,
	NR_INSTANCIA_ORIGEM integer not null,
	SG_UF_TRIBUNAL varchar(2) not null,
	NR_INSTANCIA integer not null,
	DT_DISTRIBUICAO date not null,
	id_TIPO_DISTRIBUICAO varchar(1),
	DS_TIPO_DISTRIBUICAO varchar(1),
	id_RELATOR integer not null,
	NM_RELATOR varchar(225) not null,
	id_TIPO_CARGO_RELATOR integer not null,
	DS_TIPO_CARGO_RELATOR varchar(50) not null,
	id_CLASSE integer not null,
	SG_CLASSE varchar (20) not null,
	DS_CLASSE varchar (250) not null,
	id_ASSUNTO_PRINCIPAL integer,
	DS_ASSUNTO_PRINCIPAL varchar (250),
	ST_CONCLUSO	integer,
	ST_EM_PAUTA	integer,
	ST_SOBRESTADO integer,
	ST_PEDIDO_VISTA	integer,
	ST_CARGA_VISTA_MPE	integer,
	ST_RECURSAL	integer ,
	ST_REMESSA_SUPERIOR	integer ,
	QT_DECISOES integer
)

create table if not exists processo_eleitoral (

	DT_GERACAO date not null,
	HH_GERACAO time not null,
	ANO_ELEICAO integer not null,
	NR_PROCESSO varchar(50),
	DT_AUTUACAO date not null,
	DT_BAIXA date,
	SG_UF_TRIBUNAL_ORIGEM varchar(2) not null,
	NR_INSTANCIA_ORIGEM integer not null,
	SG_UF_TRIBUNAL varchar(2) not null,
	NR_INSTANCIA integer not null,
	DT_DISTRIBUICAO date not null,
	id_TIPO_DISTRIBUICAO varchar(1),
	DS_TIPO_DISTRIBUICAO varchar(1),
	ID_NM_RELATOR integer,
	NM_RELATOR varchar(225) not null,
	ID_TIPO_CARGO_RELATOR integer not null,
	DS_TIPO_CARGO_RELATOR varchar(200) not null,
	ID_CLASSE integer not null,
	SG_CLASSE varchar (20) not null,
	ID_DS_CLASSE integer not null,
	DS_CLASSE varchar (250) not null,
	ID_ASSUNTO_PRINCIPAL integer,
	DS_ASSUNTO_PRINCIPAL varchar (250),
	ST_CONCLUSO	integer,
	ST_EM_PAUTA	integer,
	ST_SOBRESTADO integer,
	ST_PEDIDO_VISTA	integer,
	ST_CARGA_VISTA_MPE	integer,
	ST_RECURSAL	integer ,
	ST_REMESSA_SUPERIOR	integer ,
	QT_DECISOES integer
)



create table if not exists processo_eleitoral_partes(

	DT_GERACAO date not null,
	HH_GERACAO time not null,
	ANO_ELEICAO integer not null,
	SG_UF_ORGAO	varchar(2) not null,
	SG_TRIBUNAL_ORIGEM	varchar(10) not null,
	NR_INSTANCIA	integer not null,
	id_processo integer not null,
	NR_PROCESSO	varchar(100) not null,
	id_polo integer,
	DS_POLO	varchar(100),
	id_tp_parte integer,
	TP_PARTE	varchar(150),
	ST_PARTE_PRINCIPAL varchar(1),
	NM_PARTE varchar(250),
	NM_SOCIAL_PARTE varchar(250),
	ST_CANDIDATO varchar(1),
	SQ_CANDIDATO bigint
)
-- 13

create table if not exists processos_eleitorais_decisoes(

	DT_GERACAO date not null,
	HH_GERACAO time not null,
	ANO_ELEICAO integer not null,
	NR_PROCESSO varchar(50),

	SG_UF_TRIBUNAL_ORIGEM varchar(2) not null,
    sq_decisao  integer not null,
	DT_DECISAO	date not null,
	NM_AUTOR_DECISAO varchar(200),
	DS_TIPO_DECISAO varchar(200) not null

);


create table if not exists processo_eleitoral_recursos (

	DT_GERACAO date not null,
	HH_GERACAO time not null,
	ANO_ELEICAO integer not null,
	DS_IDENTIFICACAO_RECURSO varchar not null,
	NR_RECURSO integer not null,
	DT_AUTUACAO	date not null,
	DT_BAIXA	varchar,
	NR_PROCESSO_ORIGEM	varchar not null,
	SG_UF_TRIBUNAL_ORIGEM	varchar(2) not null,
	NR_INSTANCIA_ORIGEM	integer not null,
	SG_UF_TRIBUNAL	varchar(2) not null,
	NR_INSTANCIA	integer not null,
	DT_DISTRIBUICAO date not null,
	id_TIPO_DISTRIBUICAO    varchar,
	DS_TIPO_DISTRIBUICAO	varchar,
	id_RELATOR	integer not null,
	NM_RELATOR	varchar not null,
	id_TIPO_CARGO_RELATOR	integer not null,
	DS_TIPO_CARGO_RELATOR	varchar not null,
	id_CLASSE	integer,
	SG_CLASSE	varchar,
	DS_CLASSE	varchar not null,
	id_ASSUNTO_PRINCIPAL	integer,
	DS_ASSUNTO_PRINCIPAL	varchar,
	DS_TIPO_RECURSO	varchar,
	DS_NATUREZA_RECURSO	varchar,
	ST_CONCLUSO	integer,
	QT_DECISOES	integer,
	DT_ULTIMA_DECISAO	varchar,
	DS_ULTIMA_DECISAO varchar

);

-- set date style
SET datestyle = 'DMY';
SELECT '26/04/2017 21:10:00'::TIMESTAMP;

-- Importacao dos csv das tabelas principais


SET datestyle = 'MDY';


copy public.processos_eleitorais_decisoes
from 'C:\Users\glmgu\Downloads\Banco de Dados\processos_eleitorais_decisoes_2022-1.csv'
delimiter ','
csv header


SET datestyle = 'MDY';
copy public.processo_eleitoral_partes
from 'C:\Users\glmgu\Downloads\Banco de Dados\processos_eleitorais_partes_2022 4.csv'
delimiter ','
csv header

SET datestyle = 'DMY';
copy public.processo_eleitoral_recursos
from 'C:\Users\glmgu\Downloads\Banco de Dados\recursos_eleitorais_2022.csv'
delimiter ';'
csv header


copy public.processo_eleitoral
from 'C:\Users\glmgu\Downloads\Banco de Dados\processo_eleitoral_2022 principal2.csv'
delimiter ','
csv header


