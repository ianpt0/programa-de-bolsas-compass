CREATE VIEW dim_cliente AS
SELECT
    idCliente,
    nomeCliente,
    cidadeCliente,
    estadoCliente,
    paisCliente
FROM
    tb_cliente;

-- View para a dimensão Combustível
CREATE VIEW dim_combustivel AS
SELECT
    idCombustivel,
    tipoCombustivel
FROM
    tb_combustivel;

-- View para a dimensão Carro
CREATE VIEW dim_carro AS
SELECT
    idCarro,
    kmCarro,
    classiCarro,
    marcaCarro,
    modeloCarro,
    anoCarro,
    idCombustivel
FROM
    tb_carro;

-- View para a dimensão Vendedor
CREATE VIEW dim_vendedor AS
SELECT
    idVendedor,
    nomeVendedor,
    sexoVendedor,
    estadoVendedor
FROM
    tb_vendedor;

-- View para o fato Locação
CREATE VIEW fact_locacao AS
SELECT
    l.idLocacao,
    c.idCliente,
    c.nomeCliente,
    d.idCarro,
    d.marcaCarro,
    v.idVendedor,
    v.nomeVendedor,
    l.dataLocacao,
    l.horaLocacao,
    l.qtdDiaria,
    l.virDiaria,
    l.dataEntrega,
    l.horaEntrega
FROM
    tb_locacao l
INNER JOIN
    tb_cliente c ON l.idCliente = c.idCliente
INNER JOIN
    tb_carro d ON l.idCarro = d.idCarro
INNER JOIN
    tb_vendedor v ON l.idVendedor = v.idVendedor;