CREATE DATABASE ex5rev

USE ex5rev

CREATE TABLE produto(
codigo					INT					NOT NULL,
nome					VARCHAR(40)			NOT NULL,
valor_unitario			NUMERIC(5,2)		NOT NULL,
qtd_estoque		        INT					NOT NULL,
descricao				VARCHAR(49)			NOT NULL,
cod_fornecedor		    INT					NOT NULL
PRIMARY KEY (codigo)
FOREIGN KEY (cod_fornecedor) REFERENCES fornecedores (codigo)
)

CREATE TABLE fornecedores(
codigo			INT				NOT NULL,
nome			VARCHAR(40)		NOT NULL,
atividade		VARCHAR(40)		NOT NULL,
telefone		CHAR(08)		NOT NULL
PRIMARY KEY (codigo)
)

CREATE TABLE cliente(
codigo			INT				NOT NULL,
nome			VARCHAR(40)		NOT NULL,
logradouro		VARCHAR(40)		NOT NULL,
numero			INT				NOT NULL,
telefone		CHAR(08)		NOT NULL,
datanasc		DATE			NOT NULL
PRIMARY KEY (codigo)
)

CREATE TABLE pedido(
codigo				INT		NOT NULL,
codigo_cliente		INT		NOT NULL,
codigo_produto		INT		NOT NULL,
quantidade			INT		NOT NULL,
previsao_entrega	DATE	NOT NULL

PRIMARY KEY (codigo, codigo_cliente, codigo_produto)
FOREIGN KEY (codigo_cliente) REFERENCES cliente (codigo),
FOREIGN KEY (codigo_produto) REFERENCES produto (codigo)
)

INSERT INTO produto VALUES
(1,'Banco Imobiliário',65.00,15,'Versão Super Luxo',1001),
(2,'Puzzle 5000 peças',50.00,5,'Mapas Mundo',1005),
(3,'Faqueiro',350.00,0,'120 peças',1004),
(4,'Jogo para churrasco',75.00,3,'7 peças',1004),
(5,'Tablet',750.00,29,'Tablet',1003),
(6,'Detetive',49.00,0,'Nova Versão do Jogo',1001),
(7,'Chocolate com Paçoquinha',6.00,0,'Barra',1002),
(8,'Galak',5.00,65,'Barra',1002)

INSERT INTO fornecedores VALUES
(1001,'Estrela','Brinquedo','41525898'),
(1002,'Lacta','Chocolate','42698596'),
(1003,'Asus','Informática','52014596'),
(1004,'Tramontina','Utensílios Domésticos','50563985'),
(1005,'Grow','Brinquedos','47896325'),
(1006,'Mattel','Bonecos','59865898')

INSERT INTO cliente VALUES
(33601,'Maria Clara','R. 1° de Abril',870,'96325874','2000-08-15'),
(33602,'Alberto Souza','R. XV de Novembro',987,'95873625','1985-02-02'),
(33603,'Sonia Silva','R. Voluntários da Pátria',1151,'75418596','1957-08-23'),
(33604,'José Sobrinho','Av. Paulista',250,'85236547','1986-12-09'),
(33605,'Carlos Camargo','Av. Tiquatira',9652,'75896325','1971-03-25')

INSERT INTO pedido VALUES
(99001,33601,1,1,'2012-06-07'),
(99001,33601,2,1,'2012-06-07'),
(99001,33601,8,3,'2012-06-07'),
(99002,33602,2,1,'2012-06-09'),
(99002,33602,4,3,'2012-06-09'),
(99003,33605,5,1,'2012-06-15')

SELECT pe.quantidade, (pe.quantidade * pr.valor_unitario) AS valor_total,
(pe.quantidade * pr.valor_unitario) - ((pe.quantidade * pr.valor_unitario) * 0.25)  AS valor_total_desconto
FROM pedido pe
INNER JOIN produto pr
ON pr.codigo = pe.codigo_produto
INNER JOIN cliente cl
ON pe.codigo_cliente = cl.codigo
WHERE cl.nome = 'Maria Clara'

SELECT pr.nome AS nome_produto
FROM produto pr
WHERE qtd_estoque = '0'

UPDATE produto
SET valor_unitario = valor_unitario - (valor_unitario * 0.10)
WHERE nome = 'Chocolate com Paçoquinha'

UPDATE produto
SET qtd_estoque = '10'
WHERE nome = 'Faqueiro'

SELECT COUNT(codigo) AS qtd_clientes_mais_40_anos
FROM cliente
WHERE DATEDIFF(YEAR, datanasc, GETDATE()) > 40 

SELECT nome, telefone
FROM fornecedores
WHERE atividade = 'Brinquedos' OR atividade = 'Chocolate'

SELECT nome,
CASE
	WHEN valor_unitario <= 50.00
	THEN valor_unitario - (valor_unitario * 0.25)
	ELSE
	valor_unitario
	END AS valor_unitario
FROM produto

SELECT nome,
CASE
	WHEN valor_unitario >= 100.00
	THEN valor_unitario + (valor_unitario * 0.10)
	ELSE
	valor_unitario
	END AS valor_unitario
FROM produto

SELECT pr.nome, pr.valor_unitario - (pr.valor_unitario * 0.15) AS valor_com_desconto
FROM produto pr
INNER JOIN pedido pe
ON pr.codigo = pe.codigo_produto
WHERE pe.codigo = '99001'

SELECT pe.codigo, cl.nome, DATEDIFF(YEAR, datanasc, GETDATE()) AS idade
FROM cliente cl
INNER JOIN pedido pe
ON cl.codigo = pe.codigo_cliente