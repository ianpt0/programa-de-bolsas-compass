-- Tabela tb_cliente
CREATE TABLE tb_cliente (
  idCliente INT,
  nomeCliente VARCHAR(100),
  cidadeCliente VARCHAR(40),
  estadoCliente VARCHAR(40),
  paisCliente VARCHAR(40),
  PRIMARY KEY (idCliente)
);

-- Tabela tb_carro
CREATE TABLE tb_carro (
  idCarro INT,
  kmCarro INT,
  classiCarro VARCHAR(50),
  marcaCarro VARCHAR(80),
  modeloCarro VARCHAR(80),
  anoCarro INT,
  idCombustivel INT,
  PRIMARY KEY (idCarro),
  FOREIGN KEY (idCombustivel) REFERENCES tb_combustivel (idCombustivel)
);

-- Tabela tb_combustivel
CREATE TABLE tb_combustivel (
  idCombustivel INT,
  tipoCombustivel VARCHAR(20),
  PRIMARY KEY (idCombustivel)
);

-- Tabela tb_locacao
CREATE TABLE tb_locacao (
  idLocacao INT,
  idCliente INT,
  idCarro INT,
  idVendedor INT,
  dataLocacao DATETIME,
  horaLocacao TIME,
  qtdDiaria INT,
  virDiaria DECIMAL(18,2),
  dataEntrega DATE,
  horaEntrega TIME,
  PRIMARY KEY (idLocacao),
  FOREIGN KEY (idCliente) REFERENCES tb_cliente (idCliente),
  FOREIGN KEY (idCarro) REFERENCES tb_carro (idCarro),
  FOREIGN KEY (idVendedor) REFERENCES tb_vendedor (idVendedor)
);

-- Tabela tb_locacao_detalhes
CREATE TABLE tb_locacao_detalhes (
  idLocacao INT,
  dataLocacao DATETIME,
  horaLocacao TIME,
  qtdDiaria INT,
  virDiaria DECIMAL(18,2),
  dataEntrega DATE,
  horaEntrega TIME,
  PRIMARY KEY (idLocacao),
  FOREIGN KEY (idLocacao) REFERENCES tb_locacao (idLocacao)
);

-- Tabela tb_vendedor
CREATE TABLE tb_vendedor (
  idVendedor INT,
  nomeVendedor VARCHAR(15),
  sexoVendedor SMALLINT,
  estadoVendedor VARCHAR(40),
  PRIMARY KEY (idVendedor)
);
