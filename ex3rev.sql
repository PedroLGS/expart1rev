CREATE DATABASE ex3rev

USE ex3rev

CREATE TABLE pacientes(
cpf			CHAR(11)		NOT NULL,
nome		VARCHAR(40)		NOT NULL,
rua			VARCHAR(40)		NOT NULL,
num			INT				NOT NULL,
bairro		VARCHAR(40)		NOT NULL,
telefone	CHAR(08)		NULL,
datanasc    DATE			NOT NULL
PRIMARY KEY (cpf)
)

CREATE TABLE medico(
codigo			INT				NOT NULL,
nome			VARCHAR(40)		NOT NULL,
especialidade	VARCHAR(20)		NOT NULL
PRIMARY KEY (codigo)
)

CREATE TABLE prontuario(
data			DATE			NOT NULL,			
cpf_paciente	CHAR(11)		NOT NULL,
cod_medico		INT				NOT NULL,
diagnostico		VARCHAR(30)		NOT NULL,
medicamento		VARCHAR(30)		NOT NULL
PRIMARY KEY (data, cpf_paciente, cod_medico)
)

INSERT INTO pacientes VALUES 
('35454562890','José Rubens','Campos Salles',2750,'Centro','21450998','1954-10-18'),
('29865439810','Ana Claudia','Sete de Setembro',178,'Centro','97382764','1960-05-29'),
('82176534800','Marcos Aurélio','Timóteo Penteado',236,'Vila Galvão','68172651','1980-09-24'),
('12386758770','Maria Rita','Castello Branco',7765,'Vila Rosália',NULL,'1975-03-30'),
('92173458910','Joana de Souza','XV de Novembro',298,'Centro','21276578','1944-04-24')

INSERT INTO medico VALUES
(1,'Wilson Cesar','Pediatra'),
(2,'Marcia Matos','Geriatra'),
(3,'Carolina Oliveira','Ortopedista'),
(4,'Vinicius Araujo','Clínico Geral')

INSERT INTO prontuario VALUES
('2020-09-10','35454562890',2,'Reumatismo','Celebra'),
('2020-09-10','92173458910',2,'Renite Alérgica','Allegra'),
('2020-09-12','29865439810',1,'Inflamação de garganta','Nimesulida'),
('2020-09-13','35454562890',2,'H1N1','Tamiflu'),
('2020-09-15','82176534800',4,'Gripe','Resprin'),
('2020-09-15','12386758770',3,'Braço Quebrado','Dorflex + Gesso')

SELECT * FROM pacientes
SELECT * FROM medico
SELECT * FROM prontuario

SELECT nome, rua + ', ' + CAST(num AS VARCHAR(10)) + ', ' + bairro AS endereco
FROM pacientes
WHERE DATEDIFF(YEAR, datanasc, GETDATE()) > 50

SELECT especialidade
FROM medico
WHERE nome = 'Carolina Oliveira'

SELECT medicamento
FROM prontuario
WHERE diagnostico = 'Reumatismo'

SELECT diagnostico, medicamento
FROM prontuario
WHERE cpf_paciente IN (
SELECT cpf
FROM pacientes
WHERE nome = 'José Rubens'
)

SELECT nome, 
	CASE WHEN (LEN(especialidade) > 3)
	THEN SUBSTRING(especialidade, 1, 3)+'.'
	ELSE especialidade
	END AS especialidade
FROM medico
WHERE codigo IN (
SELECT cod_medico
FROM prontuario
WHERE cpf_paciente IN (
SELECT cpf
FROM pacientes
WHERE nome = 'José Rubens'
))

SELECT SUBSTRING(cpf,1,3)+'.'+SUBSTRING(cpf,4,6)+'.'+SUBSTRING(cpf,7,9)+'-'+SUBSTRING(cpf,10,11) AS cpf,
nome, rua + ', ' + CAST(num AS VARCHAR(10)) + ', ' + bairro AS endereco_completo,
CASE WHEN (telefone is null)
THEN
	'-'
ELSE
	telefone
END AS telefone
FROM pacientes
WHERE cpf IN (
SELECT cpf_paciente
FROM prontuario
WHERE cod_medico IN (
SELECT codigo
FROM medico
WHERE NOME LIKE 'Vinicius%'
))

SELECT DATEDIFF(DAY, data, GETDATE()) AS dias_consulta
FROM prontuario
WHERE cpf_paciente IN (
SELECT cpf
FROM pacientes
WHERE nome = 'Maria Rita'
)

UPDATE pacientes
SET telefone = '98345621'
WHERE nome = 'Maria Rita'

UPDATE pacientes
SET rua = 'Voluntários da Pátria'
WHERE nome = 'Joana de Souza'

UPDATE pacientes
SET num = '1980'
WHERE nome = 'Joana de Souza'

UPDATE pacientes
SET bairro = 'Jd. Aeroporto'
WHERE nome = 'Joana de Souza'
