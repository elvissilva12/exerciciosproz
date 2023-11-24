/* Crie um banco de dados, adicione tabelas e determine quais são os atributos de cada uma. 
Em seguida, execute um trigger que se relacione com algum comando, como insert, select, delete ou update. */


-- Criando uma base de dados --

create database Empresa

-- Criando a tabela funcionário e seus atributos --

CREATE TABLE funcionario (
  ID SERIAL PRIMARY KEY,
  nome_funcionario VARCHAR(30) NOT NULL
);

-- Criando a tabela auditoria_funcionario e seus atributos --

CREATE TABLE auditoria_funcionario (
  id_funcionario INT NOT NULL,
  nome VARCHAR(30),
  data_hora VARCHAR(30) NOT NULL
);

/* A função a seguir onde utilizarei na trigger, tem como objetivo de fazer uma "auditoria", ou seja, no momento que um dado for
inserido na tabela funcionario, a tabela auditoria_funcionario irá gravar o ID, o nome do funcionário e a data e hora em que este dado
foi inserido. */

CREATE OR REPLACE FUNCTION audit()
RETURNS TRIGGER AS $$
   BEGIN
      INSERT INTO auditoria_funcionario(id_funcionario, nome, data_hora) VALUES (new.ID, NEW.nome_funcionario, current_timestamp);
      RETURN NEW;
   END;
$$ LANGUAGE plpgsql;

-- Criando a trigger auditar_tabela que utilizará a função criada acima --

 CREATE TRIGGER auditar_tabela
 AFTER INSERT ON funcionario
 FOR EACH ROW EXECUTE PROCEDURE audit();
 
 -- Inserindo dados na tabela funcionario --
 
 INSERT INTO funcionario (nome_funcionario) VALUES
    ('Fernando'),
    ('Bruna'),
    ('Juliana'),
    ('Marcio');
    
-- Consultando a tabela funcionario com SELECT --
 
 SELECT * FROM funcionario
 
/* Verificando através do SELECT se a tabela auditoria_funcionario gravou o ID, nome, data e hora dos funcionários inseridos na tabela
funcionário */

 SELECT * FROM auditoria_funcionario
