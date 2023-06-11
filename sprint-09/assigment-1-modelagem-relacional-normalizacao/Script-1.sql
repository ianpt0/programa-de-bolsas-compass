-- Criando a tabela tb_cliente
CREATE TABLE tb_cliente (
  idCliente INT PRIMARY KEY,
  nomeCliente VARCHAR(100),
  cidadeCliente VARCHAR(40),
  estadoCliente VARCHAR(40),
  paisCliente VARCHAR(40)
);

-- Criando a tabela tb_combustivel
CREATE TABLE tb_combustivel (
  idCombustivel INT PRIMARY KEY,
  tipoCombustivel VARCHAR(20)
);

-- Criando a tabela tb_carro
CREATE TABLE tb_carro (
  idCarro INT PRIMARY KEY,
  kmCarro INT,
  classiCarro VARCHAR(50),
  marcaCarro VARCHAR(80),
  modeloCarro VARCHAR(80),
  anoCarro INT,
  idCombustivel INT,
  FOREIGN KEY (idCombustivel) REFERENCES tb_combustivel(idCombustivel)
);

-- Criando a tabela tb_vendedor
CREATE TABLE tb_vendedor (
  idVendedor INT PRIMARY KEY,
  nomeVendedor VARCHAR(15),
  sexoVendedor SMALLINT,
  estadoVendedor VARCHAR(40)
);

-- Criando a tabela tb_locacao
CREATE TABLE tb_locacao (
  idLocacao INT PRIMARY KEY,
  idCliente INT,
  idCarro INT,
  idVendedor INT,
  dataLocacao DATETIME,
  horaLocacao TIME,
  qtdDiaria INT,
  virDiaria DECIMAL(18, 2),
  dataEntrega DATE,
  horaEntrega TIME,
  FOREIGN KEY (idCliente) REFERENCES tb_cliente(idCliente),
  FOREIGN KEY (idCarro) REFERENCES tb_carro(idCarro),
  FOREIGN KEY (idVendedor) REFERENCES tb_vendedor(idVendedor)
);
