/* Uma loja tem um banco de dados que contém todo o controle de vendas de produtos e de cadastro de clientes. 
Pensando nisso, crie uma função para somar todos os clientes que foram cadastrados na loja durante um dia. */

CREATE TABLE CLIENTES (
    id_cliente SERIAL PRIMARY KEY,
    nome_cliente VARCHAR(50),
    data_cadastro timestamp DEFAULT current_timestamp
);

INSERT INTO CLIENTES (nome_cliente) VALUES
    ('José'),
    ('Ronaldo'),
    ('Juliana'),
    ('Bruna');
    

-- Função para contar clientes.

CREATE OR REPLACE FUNCTION Total_de_Clientes_Dia(data_informada date)
RETURNS bigint AS
$$
DECLARE
    total_clientes integer;
BEGIN
    SELECT COUNT(*) INTO total_clientes
    FROM CLIENTES
    WHERE DATE(data_cadastro) = data_informada;

    RETURN total_clientes;
END;
$$
LANGUAGE plpgsql;

-- Chamando a função e solicitando quantos clientes foram cadastrados na data 24/11/2023.

SELECT Total_de_Clientes_Dia('2023-11-24');
