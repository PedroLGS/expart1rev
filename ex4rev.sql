CREATE DATABASE ex4rev

USE ex4rev

CREATE TABLE cliente(
cpf			CHAR(11)		NOT NULL,
nome		VARCHAR(40)		NOT NULL,
telefone	CHAR(08)		NOT NULL
PRIMARY KEY (cpf)
)

CREATE TABLE produto(
codigo			INT				NOT NULL,
descricao		VARCHAR(50)		NOT NULL,
fornecedor		INT				NOT NULL,
preco			NUMERIC(6,2)	NOT NULL
PRIMARY KEY (codigo)
FOREIGN KEY (fornecedor) REFERENCES fornecedor (ID)
)


CREATE TABLE fornecedor(
ID				INT				NOT NULL,
nome			VARCHAR(40)		NOT NULL,
logradouro		VARCHAR(40)		NOT NULL,
num				INT				NOT NULL,
complemento		VARCHAR(40)		NOT NULL,
cidade			VARCHAR(20)		NOT NULL
PRIMARY KEY (ID)
)

CREATE TABLE venda(
codigo			INT					NOT NULL,
produto			INT					NOT NULL,
cliente			CHAR(11)			NOT NULL,
quantidade		INT					NOT NULL,
valor_total	    NUMERIC(6,2)		NOT NULL,
data			DATE				NOT NULL
PRIMARY KEY (codigo, produto, cliente)
FOREIGN KEY (produto) REFERENCES produto(codigo),
FOREIGN KEY (cliente) REFERENCES cliente (cpf)
)

INSERT INTO cliente VALUES
('34578909290','Julio Cesar','82736541'),
('25186533710','Maria Antonia','87652314'),
('87627315416','Luiz Carlos','61289012'),
('79182639800','Paulo Cesar','90765273')

INSERT INTO produto VALUES
(1,'Monitor 19 pol.', 1, 449.99),
(2,'Netbook 1GB Ram 4 Gb HD', 2, 699.99),
(3,'Gravador de DVD - Sata', 1, 99.99),
(4,'Leitor de CD', 1, 49.99),
(5,'Processador - Phenom X3 - 2.1GHz', 3, 349.99),
(6,'Mouse', 4, 19.99),
(7,'Teclado', 4,25.99),
(8,'Placa de Video - Nvidia 9800 GTX - 256MB/256 bits', 5, 599.99)

INSERT INTO fornecedor VALUES
(1,'LG','Rod. Bandeirantes',70000,'Km 70','Itapeva'),
(2,'Asus','Av. Nações Unidas',10206,'Sala 225','São Paulo'),
(3,'AMD','Av. Nações Unidas',10206,'Sala 1095','São Paulo'),
(4,'Leadership','Av. Nações Unidas',10206,'Sala 87','São Paulo'),
(5,'Inno','Av. Nações Unidas',10206,'Sala 34','São Paulo')

INSERT INTO VENDA
VALUES
(1,1,'25186533710',1,449.99,'2009-09-03'),
(1,4,'25186533710',1, 49.99,'2009-09-03'),
(1,5,'25186533710',1,349.99,'2009-09-03'),
(2,6,'79182639800',4,79.96,'2009-09-06'),
(3,8,'87627315416',1,599.99,'2009-09-06'),
(3,3,'87627315416',1,99.99,'2009-09-06'),
(3,7,'87627315416',1,25.99,'2009-09-06'),
(4,2,'34578909290',2,1399.98,'2009-09-08')

SELECT CONVERT(VARCHAR(10),data,103) AS data_venda 
FROM venda
WHERE codigo = 4

ALTER TABLE fornecedor
ADD telefone CHAR(08) NULL

UPDATE fornecedor
SET telefone = '72165371'
WHERE ID = '1'

UPDATE fornecedor
SET telefone = '87153738'
WHERE ID = '2'

UPDATE fornecedor
SET telefone = '36546289'
WHERE ID = '4'

SELECT nome, logradouro + ', ' + CAST(num AS VARCHAR(10)) + ', ' + complemento + ', ' + cidade AS endereco_completo,
telefone
FROM fornecedor
ORDER BY nome ASC

SELECT produto, quantidade, valor_total
FROM venda
WHERE cliente IN (
SELECT cpf
FROM cliente
WHERE nome = 'Julio Cesar'
)

SELECT CONVERT(CHAR(10), data, 103) AS data_venda, valor_total
FROM venda
WHERE cliente IN (
SELECT cpf
FROM cliente
WHERE nome = 'Paulo Cesar'
)

SELECT descricao, preco
FROM produto
ORDER BY descricao DESC