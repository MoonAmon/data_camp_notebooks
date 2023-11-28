-- Active: 1701011051961@@127.0.0.1@3306@eshop

INSERT INTO cliente_rel (codcli, nome, rua, cidade, estado, cep, fone1)
VALUES (8989,'João da Silva', 'Rua das Flores', 'São Paulo', 'SP', '01234-567', '11 1234-5678');

INSERT INTO cliente_rel (codcli ,nome, rua, cidade, estado, cep, fone1)
VALUES (1475, 'Maria da Silva', 'Rua das Laranjas', 'Mato Grosso do Sul', 'MT', '23145-654', '21 2546-6643');

INSERT INTO cliente_rel (codcli ,nome, rua, cidade, estado, cep, fone1)
VALUES (4575, 'Jorge Seu', 'Starberryfields', 'Acre', 'AC', '01535-867', '42 1234-5678');

INSERT INTO cliente_rel (codcli ,nome, rua, cidade, estado, cep)
VALUES (7543, 'Jubileu Costa', 'Rua dos Morangos', 'Bahia', 'BA', '12345-678');

INSERT INTO cliente_rel (codcli ,nome, rua, cidade, estado, cep)
VALUES (7452, 'Humberto Costa', 'Lorge Seu', 'Ceará', 'CE', '86453-755');

SELECT * FROM cliente_rel;
--------------------------------------------------

INSERT INTO cliente_vip_rel (cliente_rel_codcli, pontos_bonificacao, desconto_padrao)
SELECT codcli, 100, 10
FROM cliente_rel
WHERE nome = 'João da Silva';

INSERT INTO cliente_especial_rel (cliente_rel_codcli, desconto_padrao)
SELECT codcli, 10
FROM cliente_rel
WHERE nome = 'Jorge Seu';

--------------------------------------------------

INSERT INTO mercadoria_rel (codmer, preço, icms)
VALUES (321, 250, 0.18);

INSERT INTO mercadoria_rel (codmer, preço, icms)
VALUES (654, 150, 0.32);

INSERT INTO mercadoria_rel (codmer, preço, icms)
VALUES (987, 350, 0.10);

INSERT INTO mercadoria_rel (codmer, preço, icms)
VALUES (741, 450, 0.05);

INSERT INTO mercadoria_rel (codmer, preço, icms)
VALUES (852, 550, 0.15);

INSERT INTO mercadoria_rel (codmer, preço, icms)
VALUES 
(963, 650, 0.25),
(159, 750, 0.35),
(357, 850, 0.45),
(258, 950, 0.55),
(456, 1050, 0.65);

SELECT * FROM mercadoria_rel;

--------------------------------------------------

SELECT * FROM pedido_rel

INSERT INTO pedido_rel (codped, data_pedido, data_entrega, rua, cidade, estado, cep, cliente_rel_codcli)
SELECT 1, '2018-02-01', '2018-02-19', rua, cidade, estado, cep, codcli 
FROM cliente_rel
WHERE nome = 'João da Silva';

INSERT INTO pedido_rel (codped, data_pedido, data_entrega, rua, cidade, estado, cep, cliente_rel_codcli)
SELECT 2, '2018-02-01', '2018-02-19', rua, cidade, estado, cep, codcli
FROM cliente_rel
WHERE nome = 'João da Silva';

INSERT INTO pedido_rel (codped, data_pedido, data_entrega, rua, cidade, estado, cep, cliente_rel_codcli)    
SELECT 3, '2018-12-05', '2018-12-19', rua, cidade, estado, cep, codcli
FROM cliente_rel
WHERE nome = 'João da Silva';

INSERT INTO pedido_rel (codped, data_pedido, data_entrega, rua, cidade, estado, cep, cliente_rel_codcli)
SELECT 4, '2019-02-02', '2019-02-19', rua, cidade, estado, cep, codcli
FROM cliente_rel
WHERE nome = 'Maria da Silva';

INSERT INTO pedido_rel (codped, data_pedido, data_entrega, rua, cidade, estado, cep, cliente_rel_codcli)
SELECT 5, '2019-10-02', '2019-10-19', rua, cidade, estado, cep, codcli
FROM cliente_rel
WHERE nome = 'Maria da Silva'
UNION ALL
SELECT 6, '2019-12-02', '2019-12-19', rua, cidade, estado, cep, codcli
FROM cliente_rel
WHERE nome = 'Maria da Silva';

INSERT INTO pedido_rel (codped, data_pedido, data_entrega, rua, cidade, estado, cep, cliente_rel_codcli)
SELECT 7, '2019-12-22', '2019-12-30', rua, cidade, estado, cep, codcli
FROM cliente_rel
WHERE nome = 'Jorge Seu';

--------------------------------------------------

SELECT *
FROM mercadoria_rel
WHERE icms > 0.10 AND icms < 0.50;

SELECT nome, codcli, fone1
FROM cliente_rel
WHERE estado = 'CE' AND cidade = 'Icó';

SELECT *
FROM cliente_vip_rel
WHERE cliente_rel_codcli IN (
    SELECT DISTINCT cliente_rel_codcli
    FROM pedido_rel
);

SELECT *
FROM mercadoria_rel
WHERE codmer not IN (
    SELECT DISTINCT codmer
    FROM item_pedido_rel
);

SELECT codmer, preço
FROM mercadoria_rel 
WHERE codmer IN (
    SELECT no_item
    FROM item_pedido_rel
    WHERE pedido_rel_codped IN (
        SELECT codped
        FROM pedido_rel
        WHERE cliente_rel_codcli IN (
            SELECT cliente_rel_codcli
            FROM cliente_especial_rel
        )
    )
);

SELECT *
FROM pedido_rel
WHERE (cep, cidade, estado) NOT IN (
    SELECT cep, cidade, estado
    FROM cliente_rel
);

SELECT *
FROM mercadoria_rel
WHERE codmer IN (
    SELECT mercadoria_rel_codmer
    FROM item_pedido_rel
    WHERE pedido_rel_codped IN (
        SELECT codped
        FROM pedido_rel
        WHERE data_pedido BETWEEN '2014-01-01' AND '2014-12-31'
    )
);