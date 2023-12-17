
-- Insert dos dados nas respectivas tabelas



SELECT * FROM processo_eleitoral LIMIT 5;
SELECT * FROM relator LIMIT 5;
SELECT * FROM assunto LIMIT 5;

--Insert Processo OK
INSERT INTO processo (
    id_relator,
    id_classe,
    id_assunto_principal,
    dt_geracao,
    hh_geracao,
    ano_eleicao,
    dt_baixa,
    nr_processo,
    sg_uf_tribunal_origem,
    nr_instancia_origem,
    sg_uf_tribunal,
    nr_instancia,
    dt_distribuicao,
    st_concluso,
    st_em_pauta,
    st_sobrestado,
    st_pedido_vista,
    st_carga_vista_mpe,
    st_recursal,
    st_remessa_superior,
    qt_decisoes
)
SELECT DISTINCT
    r.id_relator,
    pe.id_classe,
    a.id_assunto_principal,
    pe.dt_geracao,
    pe.hh_geracao,
    pe.ano_eleicao,
    pe.dt_baixa,
    pe.nr_processo,
    pe.sg_uf_tribunal_origem,
    pe.nr_instancia_origem,
    pe.sg_uf_tribunal,
    pe.nr_instancia,
    pe.dt_distribuicao,
    pe.st_concluso,
    pe.st_em_pauta,
    pe.st_sobrestado,
    pe.st_pedido_vista,
    pe.st_carga_vista_mpe,
    pe.st_recursal,
    pe.st_remessa_superior,
    pe.qt_decisoes
FROM
    processo_eleitoral pe
JOIN
    relator r ON pe.id_nm_relator = r.id_tipo_cargo_relator AND r.id_tipo_cargo_relator IS NOT NULL
JOIN
    assunto a ON pe.id_assunto_principal = a.id_assunto_principal;




-- insert tabela decisao OK

INSERT INTO decisao (idprocesso, idtipodecisao, id_autor_decisao, sq_decisao, dt_geracao, hh_geracao, ano_eleicao, dt_decisao, sg_tribunal_origem)
SELECT
    p.idprocesso,
    td.idtipodecisao,
    a.id_autor_decisao,
    ped.sq_decisao,
    ped.dt_geracao,
    ped.hh_geracao,
    ped.ano_eleicao,
    ped.dt_decisao,
    ped.sg_uf_tribunal_origem
FROM
    processo p
JOIN
    processos_eleitorais_decisoes ped ON p.nr_processo = ped.nr_processo
JOIN
    autordecisao a ON ped.nm_autor_decisao = a.nm_autor_decisao
JOIN
    tipodecisao td ON ped.ds_tipo_decisao = td.ds_tipo_decisao;



-- Insert Partes Foi
INSERT INTO parte (id_processo, id_polo, id_tipo_parte, st_parte_principal, nm_social_parte, sq_candidato, nome_parte, st_candidato)
SELECT
    p.idprocesso,
    pep.id_polo,
    tpp.id_tipo_parte,
    pep.st_parte_principal,
    pep.nm_social_parte,
    pep.sq_candidato,
    pep.nm_parte,
    pep.st_candidato
FROM
    processo_eleitoral_partes pep
JOIN
    processo p ON pep.nr_processo = p.nr_processo
JOIN
    polo po ON pep.ds_polo = po.ds_polo
JOIN
    tipoparte tpp ON pep.tp_parte = tpp.tp_parte;
;




-- Alimentar tabela tiporecurso OK
INSERT INTO tiporecurso (ds_tipo_recurso)
SELECT DISTINCT
    per.ds_tipo_recurso
FROM
    processo_eleitoral_recursos per;



--insert Decisão  OK
INSERT INTO decisao (

    idtipodecisao,
    id_autor_decisao,
    sq_decisao,
    dt_geracao,
    hh_geracao,
    ano_eleicao,
    dt_decisao,
    sg_tribunal_origem
)
SELECT

    td.idtipodecisao,
    ad.id_autor_decisao,
    ped.sq_decisao,
    ped.dt_geracao,
    ped.hh_geracao,
    ped.ano_eleicao,
    ped.dt_decisao,
    ped.sg_uf_tribunal_origem
FROM
    processos_eleitorais_decisoes ped
JOIN
    processo_eleitoral pe ON ped.nr_processo = pe.nr_processo
JOIN
    tipodecisao td ON ped.ds_tipo_decisao = td.ds_tipo_decisao
LEFT JOIN
    autordecisao ad ON ped.nm_autor_decisao = ad.nm_autor_decisao;

-- Inserir dados na tabela natureza OK
INSERT INTO natureza (idnatureza, ds_natureza_recurso)
VALUES
    (1, 'Interno'),
    (2, 'Externo');



-- insert tiporecurso OK
INSERT INTO tiporecurso (ds_tipo_recurso)
SELECT DISTINCT
    per.ds_tipo_recurso
FROM
    processo_eleitoral_recursos per;
-- insert classe OK
insert into public.classe(cd_classe, idclassedescricao, sg_classe)
(
	select distinct on (id_classe) id_classe, id_ds_classe, sg_classe
	from public.processo_eleitoral
	where id_classe is not null
);

-- insert classedescricao OK
insert into public.classedescricao(idclassedescricao, ds_classe)
(
	select distinct on (id_ds_classe) id_ds_classe, processo_eleitoral.ds_classe
	from public.processo_eleitoral
	where processo_eleitoral.id_ds_classe is not null
);


-- insert tiporelator OK
INSERT INTO relator (id_tipo_cargo_relator, nm_relator)
SELECT DISTINCT
    pe.id_tipo_cargo_relator,
    pe.nm_relator
FROM
    processo_eleitoral pe;


-- insert relator OK
insert into public.relator(id_tipo_cargo_relator, nm_relator)(

	SELECT DISTINCT ON (id_tipo_cargo_relator, upper(nm_relator))id_tipo_cargo_relator, nm_relator
	from public.processo_eleitoral
	where id_tipo_cargo_relator is not null

);

-- insert tipodecisao OK
insert into public.tipodecisao (ds_tipo_decisao)(

	SELECT DISTINCT ON (upper(ds_tipo_decisao)) ds_tipo_decisao
	from public.processos_eleitorais_decisoes
	where ds_tipo_decisao is not null

);

-- insert autordecisao OK
insert into public.autordecisao (nm_autor_decisao)(

	SELECT DISTINCT ON (upper(nm_autor_decisao)) nm_autor_decisao
	from public.processos_eleitorais_decisoes
	where nm_autor_decisao is not null


);



-- insert tiporelator OK
insert into public.tiporelator (ds_tipo_cargo_relator)(

	SELECT DISTINCT ON (upper(ds_tipo_cargo_relator)) ds_tipo_cargo_relator
	from public.processo_eleitoral
	where ds_tipo_cargo_relator is not null

);

-- insert polo OK
insert into public.polo (ds_polo)(

	SELECT DISTINCT ON (upper(ds_polo)) ds_polo
	from public.processo_eleitoral_partes
	where ds_polo is not null

);


-- insert tipoparte OK
insert into public.tipoparte (tp_parte)(

	SELECT DISTINCT ON (upper(tp_parte)) tp_parte
	from public.processo_eleitoral_partes
	where tp_parte is not null

);


-- insert Recurso Ok
INSERT INTO recursos (id_recurso, idprocesso, idtiporecurso, idnatureza, ds_identificacao_recurso, dt_autuacao, dt_baixa, sg_uf_origem, nr_instancia_origem, sg_uf_tribunal, nr_instancia, dt_distribuicao)
SELECT
    per.nr_recurso,
    pr.idprocesso,
    tr.idtiporecurso,
    n.idnatureza,
    per.ds_identificacao_recurso,
    per.dt_autuacao,
    per.dt_baixa,
    per.sg_uf_tribunal_origem,
    per.nr_instancia_origem,
    per.sg_uf_tribunal,
    per.nr_instancia,
    per.dt_distribuicao
FROM
    processo_eleitoral_recursos per
JOIN
    processo pr ON per.nr_processo_origem = pr.nr_processo
JOIN
    tiporecurso tr ON per.ds_tipo_recurso = tr.ds_tipo_recurso
JOIN
    natureza n ON per.ds_natureza_recurso = n.ds_natureza_recurso
ON CONFLICT (id_recurso) DO NOTHING;
