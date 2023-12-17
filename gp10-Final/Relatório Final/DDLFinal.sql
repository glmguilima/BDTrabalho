create table natureza
(
    idnatureza          integer not null
        constraint natureza_pk
            primary key,
    ds_natureza_recurso varchar
);

alter table natureza
    owner to postgres;

create table tiporecurso
(
    idtiporecurso   serial
        constraint tiporecurso_pk
            primary key,
    ds_tipo_recurso varchar
);

alter table tiporecurso
    owner to postgres;

create table assunto
(
    id_assunto_principal integer not null
        constraint assunto_pk
            primary key,
    ds_assunto_principal varchar
);

alter table assunto
    owner to postgres;

create table tipoparte
(
    id_tipo_parte serial
        constraint tipoparte_pk
            primary key,
    tp_parte      varchar
);

alter table tipoparte
    owner to postgres;

create table polo
(
    id_polo serial
        constraint polo_pk
            primary key,
    ds_polo varchar
);

alter table polo
    owner to postgres;

create table tiporelator
(
    id_tipo_cargo_relator serial
        constraint tipocargorelator_pk
            primary key,
    ds_tipo_cargo_relator varchar
);

alter table tiporelator
    owner to postgres;

create table relator
(
    id_relator            serial
        constraint relator_pk
            primary key,
    id_tipo_cargo_relator integer not null
        constraint relator_fk
            references tiporelator,
    nm_relator            varchar(225)
);

alter table relator
    owner to postgres;

create table autordecisao
(
    id_autor_decisao serial
        constraint autordecisao_pk
            primary key,
    nm_autor_decisao varchar
);

alter table autordecisao
    owner to postgres;

create table tipodecisao
(
    idtipodecisao   serial
        constraint tipodecisao_pk
            primary key,
    ds_tipo_decisao varchar
);

alter table tipodecisao
    owner to postgres;

create table classedescricao
(
    idclassedescricao integer not null
        constraint classedescricao_pk
            primary key,
    ds_classe         varchar
);

alter table classedescricao
    owner to postgres;

create table classe
(
    cd_classe         integer not null
        constraint classe_pk
            primary key,
    idclassedescricao integer not null
        constraint classedescricao_fk
            references classedescricao,
    sg_classe         varchar(15)
);

alter table classe
    owner to postgres;

create table processo
(
    idprocesso            serial
        constraint processo_pk
            primary key,
    id_classe             integer not null
        constraint classe_fk
            references classe,
    id_relator            integer not null
        constraint relator_fk
            references relator,
    id_assunto_principal  integer
        constraint assunto_fk
            references assunto,
    dt_geracao            date,
    hh_geracao            time,
    ano_eleicao           smallint,
    dt_baixa              date,
    nr_processo           varchar(100),
    sg_uf_tribunal_origem varchar(2),
    nr_instancia_origem   integer,
    sg_uf_tribunal        varchar(2),
    nr_instancia          integer,
    dt_distribuicao       date,
    st_concluso           integer,
    st_em_pauta           integer,
    st_sobrestado         integer,
    st_pedido_vista       integer,
    st_carga_vista_mpe    integer,
    st_recursal           integer,
    st_remessa_superior   integer,
    qt_decisoes           integer
);

alter table processo
    owner to postgres;

create table decisao
(
    id_decisao         serial
        constraint decisao_pk
            primary key,
    idprocesso         integer
        constraint processo_fk
            references processo,
    idtipodecisao      integer
        constraint tipodecisao_fk
            references tipodecisao,
    id_autor_decisao   integer
        constraint autordecisao_fk
            references autordecisao,
    sq_decisao         integer not null,
    dt_geracao         date,
    hh_geracao         time,
    ano_eleicao        smallint,
    dt_decisao         date,
    sg_tribunal_origem varchar(2)
);

alter table decisao
    owner to postgres;

create table parte
(
    id_partes          serial
        constraint partes_pk
            primary key,
    id_processo        integer not null
        constraint processo_fk
            references processo,
    id_polo            integer not null
        constraint polo_fk
            references polo,
    id_tipo_parte      integer not null
        constraint tipoparte_fk
            references tipoparte,
    st_parte_principal varchar,
    nm_social_parte    varchar(250),
    sq_candidato       bigint,
    nome_parte         varchar(250),
    st_candidato       varchar(1)
);

alter table parte
    owner to postgres;

create table processo_eleitoral_recursos
(
    dt_geracao               date       not null,
    hh_geracao               time       not null,
    ano_eleicao              integer    not null,
    ds_identificacao_recurso varchar    not null,
    nr_recurso               integer    not null,
    dt_autuacao              date       not null,
    dt_baixa                 date,
    nr_processo_origem       varchar    not null,
    sg_uf_tribunal_origem    varchar(2) not null,
    nr_instancia_origem      integer    not null,
    sg_uf_tribunal           varchar(2) not null,
    nr_instancia             integer    not null,
    dt_distribuicao          date       not null,
    id_tipo_distribuicao     varchar,
    ds_tipo_distribuicao     varchar,
    id_relator               integer    not null,
    nm_relator               varchar    not null,
    id_tipo_cargo_relator    integer    not null,
    ds_tipo_cargo_relator    varchar    not null,
    id_classe                integer,
    sg_classe                varchar,
    ds_classe                varchar    not null,
    id_assunto_principal     integer,
    ds_assunto_principal     varchar,
    ds_tipo_recurso          varchar,
    ds_natureza_recurso      varchar,
    st_concluso              integer,
    qt_decisoes              integer,
    dt_ultima_decisao        varchar,
    ds_ultima_decisao        varchar
);

alter table processo_eleitoral_recursos
    owner to postgres;

create table processos_eleitorais_decisoes
(
    dt_geracao            date         not null,
    hh_geracao            time         not null,
    ano_eleicao           integer      not null,
    nr_processo           varchar(50),
    sg_uf_tribunal_origem varchar(2)   not null,
    sq_decisao            integer      not null,
    dt_decisao            date         not null,
    nm_autor_decisao      varchar(200),
    ds_tipo_decisao       varchar(200) not null
);

alter table processos_eleitorais_decisoes
    owner to postgres;

create table processo_eleitoral_partes
(
    dt_geracao         date         not null,
    hh_geracao         time         not null,
    ano_eleicao        integer      not null,
    sg_uf_orgao        varchar(2)   not null,
    sg_tribunal_origem varchar(10)  not null,
    nr_instancia       integer      not null,
    id_processo        integer      not null,
    nr_processo        varchar(100) not null,
    id_polo            integer,
    ds_polo            varchar(100),
    id_tp_parte        integer,
    tp_parte           varchar(150),
    st_parte_principal varchar(1),
    nm_parte           varchar(250),
    nm_social_parte    varchar(250),
    st_candidato       varchar(1),
    sq_candidato       bigint
);

alter table processo_eleitoral_partes
    owner to postgres;

create table processo_eleitoral
(
    dt_geracao            date         not null,
    hh_geracao            time         not null,
    ano_eleicao           integer      not null,
    nr_processo           varchar(50),
    dt_autuacao           date         not null,
    dt_baixa              date,
    sg_uf_tribunal_origem varchar(2)   not null,
    nr_instancia_origem   integer      not null,
    sg_uf_tribunal        varchar(2)   not null,
    nr_instancia          integer      not null,
    dt_distribuicao       date         not null,
    id_tipo_distribuicao  varchar(1),
    ds_tipo_distribuicao  varchar(1),
    id_nm_relator         integer,
    nm_relator            varchar(225) not null,
    id_tipo_cargo_relator integer      not null,
    ds_tipo_cargo_relator varchar(200) not null,
    id_classe             integer      not null,
    sg_classe             varchar(20)  not null,
    id_ds_classe          integer      not null,
    ds_classe             varchar(250) not null,
    id_assunto_principal  integer,
    ds_assunto_principal  varchar(250),
    st_concluso           integer,
    st_em_pauta           integer,
    st_sobrestado         integer,
    st_pedido_vista       integer,
    st_carga_vista_mpe    integer,
    st_recursal           integer,
    st_remessa_superior   integer,
    qt_decisoes           integer
);

alter table processo_eleitoral
    owner to postgres;

create table recursos
(
    id_recurso               integer not null
        constraint recursos_pk
            primary key,
    idprocesso               integer
        constraint processo_fk
            references processo,
    idtiporecurso            integer
        constraint tiporecurso_fk
            references tiporecurso,
    idnatureza               integer
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

alter table recursos
    owner to postgres;

create view vw_tipos_decisoes_autor(id_autor_decisao, nm_autor_decisao, idtipodecisao, ds_tipo_decisao) as
SELECT id_autor_decisao,
       nm_autor_decisao,
       idtipodecisao,
       ds_tipo_decisao
FROM (SELECT a.id_autor_decisao,
             a.nm_autor_decisao,
             d.idtipodecisao,
             td.ds_tipo_decisao,
             row_number() OVER (PARTITION BY a.id_autor_decisao ORDER BY td.ds_tipo_decisao) AS row_num
      FROM autordecisao a
               JOIN decisao d ON a.id_autor_decisao = d.id_autor_decisao
               JOIN tipodecisao td ON d.idtipodecisao = td.idtipodecisao) numbered_rows
WHERE row_num = 1;

alter table vw_tipos_decisoes_autor
    owner to postgres;

create view vw_contagem_decisoes_autor(id_autor_decisao, nm_autor_decisao, num_decisoes) as
SELECT a.id_autor_decisao,
       a.nm_autor_decisao,
       count(d.id_decisao) AS num_decisoes
FROM autordecisao a
         JOIN decisao d ON a.id_autor_decisao = d.id_autor_decisao
GROUP BY a.id_autor_decisao, a.nm_autor_decisao;

alter table vw_contagem_decisoes_autor
    owner to postgres;

create view vw_processos_decisoes(idprocesso, nr_processo, id_decisao, ds_tipo_decisao) as
SELECT p.idprocesso,
       p.nr_processo,
       d.id_decisao,
       td.ds_tipo_decisao
FROM processo p
         JOIN decisao d ON p.idprocesso = d.idprocesso
         JOIN tipodecisao td ON d.idtipodecisao = td.idtipodecisao;

alter table vw_processos_decisoes
    owner to postgres;

create view vw_contagem_tipos_decisoes(idtipodecisao, ds_tipo_decisao, num_decisoes) as
SELECT td.idtipodecisao,
       td.ds_tipo_decisao,
       count(d.id_decisao) AS num_decisoes
FROM tipodecisao td
         LEFT JOIN decisao d ON td.idtipodecisao = d.idtipodecisao
GROUP BY td.idtipodecisao, td.ds_tipo_decisao;

alter table vw_contagem_tipos_decisoes
    owner to postgres;

create view vw_contagem_recursos_por_tipo(idtiporecurso, ds_tipo_recurso, num_recursos) as
SELECT tr.idtiporecurso,
       tr.ds_tipo_recurso,
       count(DISTINCT r.id_recurso) AS num_recursos
FROM tiporecurso tr
         LEFT JOIN recursos r ON tr.idtiporecurso = r.idtiporecurso
GROUP BY tr.idtiporecurso, tr.ds_tipo_recurso;

alter table vw_contagem_recursos_por_tipo
    owner to postgres;

create view vw_contagem_recursos_por_mes_baixa(mes, num_recursos) as
SELECT EXTRACT(month FROM dt_baixa) AS mes,
       count(*)                     AS num_recursos
FROM processo_eleitoral_recursos pe
GROUP BY (EXTRACT(month FROM dt_baixa))
ORDER BY (EXTRACT(month FROM dt_baixa));

alter table vw_contagem_recursos_por_mes_baixa
    owner to postgres;

create view vw_contagem_recursos_por_mes_autuaçao(mes, num_recursos) as
SELECT EXTRACT(month FROM dt_autuacao) AS mes,
       count(*)                        AS num_recursos
FROM processo_eleitoral_recursos pe
GROUP BY (EXTRACT(month FROM dt_autuacao))
ORDER BY (EXTRACT(month FROM dt_autuacao));

alter table vw_contagem_recursos_por_mes_autuaçao
    owner to postgres;

create view vw_contagem_processos_e_decisoes_por_assunto
            (id_assunto_principal, ds_assunto_principal, num_processos, num_decisoes) as
SELECT a.id_assunto_principal,
       a.ds_assunto_principal,
       count(DISTINCT p.idprocesso) AS num_processos,
       count(DISTINCT d.id_decisao) AS num_decisoes
FROM assunto a
         LEFT JOIN processo p ON a.id_assunto_principal = p.id_assunto_principal
         LEFT JOIN decisao d ON p.idprocesso = d.idprocesso
GROUP BY a.id_assunto_principal, a.ds_assunto_principal
HAVING count(DISTINCT p.idprocesso) > 0
    OR count(DISTINCT d.id_decisao) > 0;

alter table vw_contagem_processos_e_decisoes_por_assunto
    owner to postgres;

create view vw_autor_decisao_assunto_processo
            (id_autor_decisao, nm_autor_decisao, id_assunto_principal, ds_assunto_principal, nr_processo,
             num_decisoes) as
SELECT ad.id_autor_decisao,
       ad.nm_autor_decisao,
       a.id_assunto_principal,
       a.ds_assunto_principal,
       p.nr_processo,
       count(d.id_decisao) AS num_decisoes
FROM autordecisao ad
         JOIN decisao d ON ad.id_autor_decisao = d.id_autor_decisao
         JOIN processo p ON d.idprocesso = p.idprocesso
         LEFT JOIN assunto a ON p.id_assunto_principal = a.id_assunto_principal
GROUP BY ad.id_autor_decisao, ad.nm_autor_decisao, a.id_assunto_principal, a.ds_assunto_principal, p.nr_processo;

alter table vw_autor_decisao_assunto_processo
    owner to postgres;

create view vw_processos_concluidos_decisao_autor
            (idprocesso, nr_processo, id_decisao, ds_tipo_decisao, id_autor_decisao, nm_autor_decisao, dt_decisao,
             total_processos_concluidos)
as
SELECT p.idprocesso,
       p.nr_processo,
       d.id_decisao,
       td.ds_tipo_decisao,
       ad.id_autor_decisao,
       ad.nm_autor_decisao,
       d.dt_decisao,
       count(*) OVER () AS total_processos_concluidos
FROM processo p
         JOIN decisao d ON p.idprocesso = d.idprocesso
         JOIN tipodecisao td ON d.idtipodecisao = td.idtipodecisao
         JOIN autordecisao ad ON d.id_autor_decisao = ad.id_autor_decisao
WHERE p.st_concluso = 1;

alter table vw_processos_concluidos_decisao_autor
    owner to postgres;


