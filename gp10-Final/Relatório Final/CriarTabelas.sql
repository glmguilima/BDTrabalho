-- tabelas atualizadas
create table if not exists processo
(
    idprocesso serial not null
        constraint processo_pk
            primary key,


	id_classe         integer not null
        constraint classe_fk
            references classe,


	id_relator         integer not null
        constraint relator_fk
            references relator,


	id_assunto_principal         integer
        constraint assunto_fk
            references assunto,


    dt_geracao            date,
    hh_geracao            time,
    ano_eleicao           smallint,
    dt_baixa              date,
	nr_processo           varchar(100),
    sg_uf_tribunal_origem varchar(2),
    nr_instancia_origem    integer,
    sg_uf_tribunal        varchar(2),
    nr_instancia          integer,
    dt_distribuicao       date,
	ST_CONCLUSO	integer,
	ST_EM_PAUTA	integer,
	ST_SOBRESTADO integer,
	ST_PEDIDO_VISTA	integer,
	ST_CARGA_VISTA_MPE	integer,
	ST_RECURSAL	integer ,
	ST_REMESSA_SUPERIOR	integer ,
	QT_DECISOES integer

);


create table if not exists classe
(
    cd_classe  integer not null
        constraint classe_pk
            primary key,

	idClasseDescricao              integer not null
        constraint ClasseDescricao_fk
            references classeDescricao,

    sg_classe  varchar(15)

);

create table if not exists classeDescricao
(
    idClasseDescricao   integer not null
        constraint ClasseDescricao_pk
            primary key,

    ds_classe    varchar

);


create table if not exists decisao
(
    id_decisao         serial not null
        constraint decisao_pk
            primary key,

	idProcesso      integer
        constraint processo_fk
            references processo,

	idTipoDecisao      integer
        constraint tipoDecisao_fk
            references tipoDecisao,


	id_autor_decisao      integer
        constraint autorDecisao_fk
            references autorDecisao,
	sq_decisao         integer not null,
    dt_geracao         date,
    hh_geracao         time,
    ano_eleicao        smallint,
    dt_decisao         date,
    sg_tribunal_origem varchar(2)

);



create table if not exists tipoDecisao
(
    idTipoDecisao     serial not null
        constraint TipoDecisao_pk
            primary key,

    ds_tipo_decisao varchar

);



create table if not exists autorDecisao
(
    id_autor_decisao serial not null
        constraint autorDecisao_pk
            primary key,

    nm_autor_decisao   varchar

);


create table if not exists relator
(

	id_relator serial
	     constraint relator_pk
            primary key,

	id_tipo_cargo_relator         integer not null
        constraint relator_fk
            references tiporelator,

    nm_relator varchar(225)

);




create table if not exists tipoRelator
(
    id_tipo_cargo_relator            serial not null
        constraint tipoCargoRelator_pk
            primary key,

    ds_tipo_cargo_relator varchar

);





create table if not exists polo
(
    id_Polo    serial not null
        constraint polo_pk
            primary key,

    ds_Polo    varchar

);

create table if not exists tipoParte
(
    id_tipo_parte serial not null
        constraint tipoParte_pk
            primary key,

    tp_parte      varchar

);


create table if not exists Assunto
(
    id_assunto_principal integer not null
        constraint assunto_pk
            primary key,

    ds_assunto_principal varchar

);



create table if not exists recursos
(
    id_recurso               integer not null
        constraint recursos_pk
            primary key,

    idprocesso integer
         constraint processo_fk
            references processo,

	idTipoRecurso            integer
        constraint tipoRecurso_fk
            references tipoRecurso,

	idNatureza               integer
        constraint natureza_fk
            references natureza,

    ds_identificacao_recurso varchar,
    dt_autuacao              date,
    dt_baixa                 date,
    sg_uf_origem             varchar,
    nr_instancia_origem      integer,
    sg_uf_tribunal           varchar,
    nr_instancia             integer,
    dt_distribuicao          date


);


create table if not exists tipoRecurso
(
	idTipoRecurso serial not null
        constraint tipoRecurso_pk
            primary key,

    ds_tipo_recurso varchar

);


create table if not exists natureza
(
    idNatureza        integer not null
        constraint natureza_pk
            primary key,

    ds_natureza_recurso varchar

);


create table if not exists parte
(
    id_Partes        serial not null
        constraint partes_pk
            primary key,

	id_processo         integer not null
        constraint processo_fk
            references processo,

	id_Polo         integer not null
        constraint polo_fk
            references polo,

	id_tipo_parte         integer not null
        constraint tipoParte_fk
            references tipoParte,

    st_parte_principal varchar,
    nm_social_parte    varchar (250),
    sq_candidato       bigint,
    nome_parte         varchar (250),
    st_candidato       varchar(1)

);

create table if not exists autorDecisao
(
    id_autor_decisao serial not null
        constraint autorDecisao_pk
            primary key,

    nm_autor_decisao   varchar

);