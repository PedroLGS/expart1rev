CREATE DATABASE ex2rev

USE ex2rev

CREATE TABLE cliente(
nome			VARCHAR(40)		NOT NULL,
logradouro		VARCHAR(40)		NOT NULL,
num				INT				NOT NULL,
bairro			VARCHAR(40)		NOT NULL,
telefone		CHAR(8)			NOT NULL,
carro			CHAR(7)			NOT NULL
PRIMARY KEY (carro)
FOREIGN KEY (carro) REFERENCES carro(placa)
)

CREATE TABLE carro(
placa		CHAR(7)	    	NOT NULL,
marca		VARCHAR(40)		NOT NULL,
modelo		VARCHAR(40)		NOT NULL,
cor			VARCHAR(40)		NOT NULL,
ano			INT				NOT NULL,
PRIMARY KEY (placa)
)

CREATE TABLE pecas(
codigo		INT				NOT NULL,	
nome		VARCHAR(40)		NOT NULL,
valor		INT				NOT NULL
PRIMARY KEY (codigo)
)

CREATE TABLE servico(
carro			CHAR(7)	    NOT NULL,	
peca			INT			NOT NULL,
quantidade		INT			NOT NULL,
valor			INT			NOT NULL,
data			DATE		NOT NULL
PRIMARY KEY (carro, peca, data)
FOREIGN KEY (carro) REFERENCES carro(placa),
FOREIGN KEY (peca) REFERENCES pecas(codigo)
)

INSERT INTO cliente VALUES
('João Alves','R. Pereira Barreto',1258,'Jd. Oliveiras','21549658','DXO9876'),
('Ana Maria','R. 7 de Setembro',259,'Centro','96588541','LKM7380'),
('Clara Oliveira','Av. Nações Unidas',10254,'Pinheiros','24589658','EGT4631'),
('José Simões','R. XV de Novembro',36,'Água Branca','78952459','BCD7521'),
('Paula Rocha','R. Anhaia',548,'Barra Funda','69582548','AFT9087')

INSERT INTO carro VALUES
('AFT9087','VW','Gol','Preto',2007),
('DXO9876','Ford','Ka','Azul',2000),
('EGT4631','Renault','Clio','Verde',2004),
('LKM7380','Fiat','Palio','Prata',1997),
('BCD7521','Ford','Fiesta','Preto',1999)

INSERT INTO pecas VALUES
(1,'Vela',70),
(2,'Correia Dentada',125),
(3,'Trambulador',90),
(4,'Filtro de Ar',30)

INSERT INTO servico VALUES
('DXO9876',1,4,280,'2020-08-01'),
('DXO9876',4,1,30,'2020-08-01'),
('EGT4631',3,1,90,'2020-08-02'),
('DXO9876',2,1,125,'2020-08-07')

SELECT * FROM cliente
SELECT * FROM carro
SELECT * FROM pecas
SELECT * FROM servico

SELECT SUBSTRING(telefone, 1, 4) + '-' + SUBSTRING(telefone, 5, 8) AS telefone
FROM cliente 
WHERE carro IN (
SELECT placa
FROM carro 
WHERE modelo = 'Ka' and cor = 'Azul'
)

SELECT logradouro + ', ' + CAST(num AS VARCHAR(10)) + ', ' + bairro AS endereco
FROM cliente
WHERE carro IN (
SELECT carro
FROM servico
WHERE data = '2009-08-02'
)

SELECT placa
FROM carro
WHERE ano < 2001

SELECT marca, modelo, cor
FROM carro
WHERE ano > 2005

SELECT codigo, nome
FROM pecas
WHERE valor < 80.00