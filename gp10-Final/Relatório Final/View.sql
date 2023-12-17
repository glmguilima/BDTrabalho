CREATE OR REPLACE VIEW vw_tipos_decisoes_autor AS
SELECT
    id_autor_decisao,
    nm_autor_decisao,
    idtipodecisao,
    ds_tipo_decisao
FROM (
    SELECT
        a.id_autor_decisao,
        a.nm_autor_decisao,
        d.idtipodecisao,
        td.ds_tipo_decisao,
        ROW_NUMBER() OVER (PARTITION BY a.id_autor_decisao ORDER BY td.ds_tipo_decisao) AS row_num
    FROM
        autordecisao a
    JOIN
        decisao d ON a.id_autor_decisao = d.id_autor_decisao
    JOIN
        tipodecisao td ON d.idtipodecisao = td.idtipodecisao
) AS numbered_rows
WHERE
    row_num = 1;

CREATE OR REPLACE VIEW vw_contagem_decisoes_autor AS
SELECT
    a.id_autor_decisao,
    a.nm_autor_decisao,
    COUNT(d.id_decisao) AS num_decisoes
FROM
    autordecisao a
JOIN
    decisao d ON a.id_autor_decisao = d.id_autor_decisao
GROUP BY
    a.id_autor_decisao, a.nm_autor_decisao;


CREATE OR REPLACE VIEW vw_processos_decisoes AS
SELECT
    p.idprocesso,
    p.nr_processo,
    d.id_decisao,
    td.ds_tipo_decisao
FROM
    processo p
    JOIN decisao d ON p.idprocesso = d.idprocesso
    JOIN tipodecisao td ON d.idtipodecisao = td.idtipodecisao;

CREATE OR REPLACE VIEW vw_contagem_tipos_decisoes AS
SELECT
    td.idtipodecisao,
    td.ds_tipo_decisao,
    COUNT(d.id_decisao) AS num_decisoes
FROM
    tipodecisao td
    LEFT JOIN decisao d ON td.idtipodecisao = d.idtipodecisao
GROUP BY
    td.idtipodecisao, td.ds_tipo_decisao;




CREATE OR REPLACE VIEW vw_contagem_recursos_por_tipo AS
SELECT
    tr.idtiporecurso,
    tr.ds_tipo_recurso,
    COUNT(DISTINCT r.id_recurso) AS num_recursos
FROM
    tiporecurso tr
    LEFT JOIN recursos r ON tr.idtiporecurso = r.idtiporecurso
GROUP BY
    tr.idtiporecurso, tr.ds_tipo_recurso;




CREATE OR REPLACE VIEW vw_contagem_recursos_por_mes_autuaçao AS
SELECT
    EXTRACT(MONTH FROM pe.dt_autuacao) AS mes,
    COUNT(*) AS num_recursos
FROM
    processo_eleitoral_recursos pe
GROUP BY
    mes
ORDER BY
    mes;

CREATE VIEW vw_contagem_recursos_por_mes_baixa AS
SELECT
    EXTRACT(MONTH FROM pe.dt_baixa) AS mes,
    COUNT(*) AS num_recursos
FROM
    processo_eleitoral_recursos pe
GROUP BY
    mes
ORDER BY
    mes;




CREATE or replace VIEW vw_contagem_processos_e_decisoes_por_assunto AS
SELECT
    a.id_assunto_principal,
    a.ds_assunto_principal,
    COUNT(DISTINCT p.idprocesso) AS num_processos,
    COUNT(DISTINCT d.id_decisao) AS num_decisoes
FROM
    assunto a
    LEFT JOIN processo p ON a.id_assunto_principal = p.id_assunto_principal
    LEFT JOIN decisao d ON p.idprocesso = d.idprocesso
GROUP BY
    a.id_assunto_principal, a.ds_assunto_principal
HAVING
    COUNT(DISTINCT p.idprocesso) > 0 OR COUNT(DISTINCT d.id_decisao) > 0;

CREATE or replace VIEW vw_autor_decisao_assunto_processo AS
SELECT
    ad.id_autor_decisao,
    ad.nm_autor_decisao,
    a.id_assunto_principal,
    a.ds_assunto_principal,
    p.nr_processo,
    COUNT(d.id_decisao) AS num_decisoes
FROM
    autordecisao ad
    JOIN decisao d ON ad.id_autor_decisao = d.id_autor_decisao
    JOIN processo p ON d.idprocesso = p.idprocesso
    LEFT JOIN assunto a ON p.id_assunto_principal = a.id_assunto_principal
GROUP BY
    ad.id_autor_decisao, ad.nm_autor_decisao, a.id_assunto_principal, a.ds_assunto_principal, p.nr_processo;


CREATE or replace VIEW vw_processos_concluidos_decisao_autor AS
SELECT
    p.idprocesso,
    p.nr_processo,
    d.id_decisao,
    td.ds_tipo_decisao,
    ad.id_autor_decisao,
    ad.nm_autor_decisao,
    d.dt_decisao
FROM
    processo p
    JOIN decisao d ON p.idprocesso = d.idprocesso
    JOIN tipodecisao td ON d.idtipodecisao = td.idtipodecisao
    JOIN autordecisao ad ON d.id_autor_decisao = ad.id_autor_decisao
WHERE
    p.st_concluso = 1;


