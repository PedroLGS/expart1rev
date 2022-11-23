CREATE DATABASE ex1rev

USE ex1rev

CREATE TABLE aluno(
ra           INT              NOT NULL,
nome         VARCHAR(70)      NOT NULL,
sobrenome    VARCHAR(70)      NOT NULL,
logradouro   VARCHAR(150)     NOT NULL,
num          INT              NOT NULL,
bairro       VARCHAR(100)     NOT NULL,
cep          CHAR(8)          NOT NULL,
telefone     CHAR(8)          NULL
PRIMARY KEY (ra)
)

CREATE TABLE curso(
codigo          INT              NOT NULL,
nome            VARCHAR(70)      NOT NULL,
carga_horaria   INT              NOT NULL,
turno           VARCHAR(70)      NOT NULL
PRIMARY KEY (codigo)
)

CREATE TABLE disciplina(
codigo          INT              NOT NULL,
nome            VARCHAR(70)      NOT NULL,
carga_horaria   INT              NOT NULL,
turno           VARCHAR(70)      NOT NULL,
semestre        INT              NOT NULL
PRIMARY KEY (codigo)
)

SELECT * FROM aluno
SELECT * FROM curso
SELECT * FROM disciplina

INSERT INTO aluno (ra, nome, sobrenome, logradouro, num, bairro, cep, telefone) VALUES
('12345', 'José', 'Silva', 'Almirante Noronha',	'236', 'Jardim São Paulo', '1589000', '69875287'),
('12346', 'Ana', 'Maria Bastos', 'Anhaia', '1568', 'Barra Funda', '3569000', '25698526'),
('12347', 'Mario', 'Santos', 'XV de Novembro', '1841', 'Centro', '1020030', NULL),
('12348', 'Marcia', 'Neves', 'Voluntários da Patria', '225', 'Santana', '2785090', '78964152')

INSERT INTO curso (codigo, nome, carga_horaria, turno) VALUES
('1', 'Informática', '2800', 'Tarde'),
('2', 'Informática', '2800', 'Noite'),
('3', 'Logística', '2650', 'Tarde'),
('4', 'Logística', '2650', 'Noite'),
('5', 'Plásticos', '2500', 'Tarde'),
('6', 'Plásticos', '2500', 'Noite')

INSERT INTO disciplina (codigo, nome, carga_horaria, turno, semestre) VALUES
('1', 'Informática', '4', 'Tarde', '1'),
('2', 'Informática', '4', 'Noite', '1'),
('3', 'Quimica', '4', 'Tarde', '1'),
('4', 'Quimica', '4', 'Noite', '1'),
('5', 'Banco de Dados I', '2', 'Tarde', '3'),
('6', 'Banco de Dados I', '2', 'Noite', '3'),
('7', 'Estrutura de Dados', '4', 'Tarde', '4'),
('8', 'Estrutura de Dados', '4', 'Noite', '4')

SELECT nome + ' ' + sobrenome AS nome_completo
FROM aluno

SELECT logradouro, num, cep, telefone
FROM aluno
WHERE telefone is NULL

SELECT telefone
FROM aluno
WHERE ra = '12348'

SELECT nome, turno
FROM curso
WHERE carga_horaria = '2800'

SELECT semestre
FROM disciplina
WHERE nome = 'Banco de Dados I'