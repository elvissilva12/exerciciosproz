-- Desenvolva um banco de dados e relacione tabelas através de chaves estrangeiras ou nomes de colunas iguais. Siga as instruções:
-- crie uma base de dados; 
-- crie tabelas nessa base de dados;
-- em cada tabela, adicione atributos;
-- insira dados em cada tabela;
-- utilize os comandos Joins para realizar consultas nas tabelas. 

-- Respostas --

-- Criando uma base de dados --

create database Empresa

-- Criando tabelas, adicionando atributos e definindo chave estrangeira.

CREATE TABLE departamento (
  id SERIAL PRIMARY KEY,
  nome_departamento VARCHAR(25) UNIQUE
)

CREATE TABLE funcionario (
  ID SERIAL PRIMARY KEY,
  nome_funcionario VARCHAR(30) NOT NULL,
  setor_id INT,
  CONSTRAINT fk_setor FOREIGN KEY (setor_id) REFERENCES departamento (ID)
)

-- Inserindo dados em cada tabela.

INSERT INTO departamento (nome_departamento) VALUES
    ('Setor de T.I'),
	  ('Setor Administrativo'),
    ('Setor Contábil'),
    ('RH');
    
    
INSERT INTO funcionario (nome_funcionario, setor_id) VALUES
	  ('Fernando', 1),
    ('Bruna', 2),
    ('Juliana', 3),
    ('Marcio', 3),
    ('Samuel', NULL),
    ('Augusto', 1),
    ('Rafael', NULL);
    
SELECT * FROM funcionario    
  
-- Utilizando os comandos Joins para realizar consultas nas tabelas.

-- comando JOIN

SELECT nome_funcionario, nome_departamento from funcionario
INNER JOIN departamento
on departamento.id = funcionario.setor_id;

-- comando LEFT JOIN

SELECT nome_funcionario, nome_departamento 
FROM funcionario LEFT JOIN departamento
on departamento.id = funcionario.setor_id;

-- comando RIGHT JOIN

SELECT nome_funcionario, nome_departamento 
FROM funcionario RIGHT JOIN departamento
ON departamento.id = funcionario.setor_id;

-- OUTER JOIN, FULL OUTER JOIN ou FULL JOIN.

SELECT nome_funcionario, nome_departamento
FROM funcionario LEFT JOIN departamento 
ON departamento.id = funcionario.setor_id
UNION
SELECT nome_funcionario, nome_departamento
FROM funcionario RIGHT JOIN departamento 
ON departamento.id = funcionario.setor_id;