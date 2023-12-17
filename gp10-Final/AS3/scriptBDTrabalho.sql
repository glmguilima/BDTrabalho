create table if not exists processo
(
    idprocesso            integer not null
        constraint processo_pk
            primary key,
    dt_geracao            date,
    hh_geracao            time,
    ano_eleicao           smallint,
    dt_baixa              date,
    sg_uf_tribunal_origem varchar(2),
    nr_instacia_origem    integer,
    sg_uf_tribunal        varchar(2),
    nr_instancia          integer,
    de_distribuicao       date
);

alter table processo
    owner to postgres;

create table if not exists classe
(
    cd_classe  integer not null
        constraint classe_pk
            primary key,
    idprocesso integer
        constraint classe___fk
            references processo,
    sg_classe  varchar(15)
);

alter table classe
    owner to postgres;

create table if not exists decisao
(
    sq_decisao         integer not null
        constraint decisao_pk
            primary key,
    idprocesso         integer
        constraint idprocesso
            references processo,
    dt_geracao         date,
    hh_geracao         time,
    ano_eleicao        smallint,
    dt_decisao         date,
    sg_tribunal_origem varchar(2)
);

alter table decisao
    owner to postgres;

create table if not exists relator
(
    cd_relator integer not null
        constraint relator_pk
            primary key,
    idprocesso integer
        constraint relator___fk
            references processo,
    nm_relator varchar(225)
);

alter table relator
    owner to postgres;

create table if not exists "tipoDecisao"
(
    "IdDecisao"     integer not null
        constraint "TipoDecisao_pk"
            primary key,
    ds_tipo_decisao varchar,
    sq_decisao      integer
        constraint sq_decisao
            references decisao
);

alter table "tipoDecisao"
    owner to postgres;

create table if not exists "autorDecisao"
(
    "Id_autor_decisao" integer not null
        constraint "autorDecisao_pk"
            primary key,
    nm_autor_decisao   varchar,
    sq_decisao         integer
        constraint "autorDecisao___fk"
            references decisao
);

alter table "autorDecisao"
    owner to postgres;

create table if not exists "classeDescricao"
(
    "IdClasse"   integer not null
        constraint "classeDescricao_pk"
            primary key,
    ds_classe    varchar,
    cd_classe_fk integer
        constraint cd_classe_fk
            references classe
);

alter table "classeDescricao"
    owner to postgres;

create table if not exists "tipoRelator"
(
    id_relator            integer not null
        constraint "tipoRelator_pk"
            primary key,
    ds_tipo_cargo_relator varchar,
    cd_relator_fk         integer
        constraint "tipoRelator___fk"
            references relator
);

alter table "tipoRelator"
    owner to postgres;

create table if not exists partes
(
    "Id_Partes"        integer not null
        constraint partes_pk
            primary key,
    st_parte_principal varchar,
    nm_social_parte    varchar,
    sq_candidato       integer,
    nome_parte         integer,
    st_candidato       boolean,
    id_processo_fk     integer
        constraint partes___fk
            references processo
);

alter table partes
    owner to postgres;

create table if not exists polo
(
    "id_Polo"    integer not null
        constraint polo_pk
            primary key,
    "ds_Polo"    varchar,
    "idParte_fk" integer
        constraint polo___fk
            references partes
);

alter table polo
    owner to postgres;

create table if not exists "tipoParte"
(
    id_tipo_parte integer not null
        constraint "tipoParte_pk"
            primary key,
    tp_parte      varchar,
    parte_fk      integer
        constraint "tipoParte___fk"
            references partes
);

alter table "tipoParte"
    owner to postgres;

create table if not exists recursos
(
    id_recurso               integer not null
        constraint recursos_pk
            primary key,
    ds_identificacao_recurso varchar,
    dt_autuacao              date,
    dt_baixa                 date,
    sg_uf_origem             varchar,
    nr_instancia_origem      integer,
    sg_uf_tribunal           varchar,
    nr_instancia             integer,
    dt_distribuicao          date,
    id_processo_fk           integer
        constraint id_processo_fk
            references processo
);

alter table recursos
    owner to postgres;

create table if not exists "Assunto"
(
    cd_assunto_principal integer not null
        constraint assunto_pk
            primary key,
    ds_assunto_principal varchar,
    idprocesso_fk        integer
        constraint id_processo_fk
            references processo
);

alter table "Assunto"
    owner to postgres;

create table if not exists "tipoRecurso"
(
    ds_tipo_recurso varchar,
    recurso_fk      integer
        constraint recurso_fk
            references recursos,
    "IdTipoRecurso" integer not null
        constraint "tipoRecurso_pk"
            primary key
);

alter table "tipoRecurso"
    owner to postgres;

create table if not exists natureza
(
    "IdNatureza"        integer not null
        constraint natureza_pk
            primary key,
    ds_natureza_recurso integer,
    recurso_fk          integer
        constraint recurso_fk
            references recursos
);

alter table natureza
    owner to postgres;


