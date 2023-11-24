/* Uma empresa de vendas tem um banco de dados com informações sobre os seus produtos. 
Ela precisa criar um relatório que faça um levantamento diário da quantidade de produtos 
comprados por dia. Para ajudar a empresa, crie um procedure para agilizar esse processo. */

CREATE TABLE PRODUTOS (
    id_produto SERIAL PRIMARY KEY,
    nome_produto VARCHAR(50),
    valor NUMERIC
);

CREATE TABLE VENDAS (
    id_venda SERIAL PRIMARY KEY,
    dia_venda DATE,
    quantidade_vendida INTEGER,
	cod_produto INTEGER REFERENCES PRODUTOS(id_produto)
);

INSERT INTO PRODUTOS (nome_produto, valor) VALUES
    ('Notebook', 2.900),
    ('Monitor', 950),
    ('TV', 1800),
    ('Geladeira', 2100);
    
INSERT INTO VENDAS (dia_venda, quantidade_vendida, cod_produto) VALUES
    ('2023-11-12', 2, 1),
    ('2023-11-12', 3, 2),
    ('2023-11-14', 5, 3),
    ('2023-11-15', 9, 4);
	

/* A procedure a seguir irá retornar as quantidades vendidas no dia referenciado na CALL (após o código da procedure) e também o nome do produto que foi vendido */

CREATE OR REPLACE PROCEDURE relatorio_diario_quantidades(dia DATE) AS $$
DECLARE
    nome_prod VARCHAR(50);
    quantidade_vendida INTEGER;
BEGIN
    FOR nome_prod, quantidade_vendida IN
        SELECT p.nome_produto, v.quantidade_vendida
        FROM vendas v
        JOIN produtos p ON v.cod_produto = p.id_produto
        WHERE v.dia_venda = dia
    LOOP
        RAISE NOTICE 'O produto: %, teve % unidades vendidas', nome_prod, quantidade_vendida;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

CALL relatorio_diario_quantidades('2023-11-12')




