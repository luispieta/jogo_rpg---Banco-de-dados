CREATE TABLE cupons(
	id INT NOT NULL AUTO_INCREMENT,
    codigo VARCHAR(20),
    percentual_desconto DECIMAL(4, 2),
    data_expiracao DATE,
    PRIMARY KEY(ID)
);

CREATE TABLE uso_cupons(
	id INT NOT NULL AUTO_INCREMENT, 
    pedido_id INT,
    cupom_id INT, 
    data_uso DATE,
    PRIMARY KEY(ID),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (cupom_id) REFERENCES cupons(id)
);

INSERT INTO cupons (codigo, percentual_desconto, data_expiracao)
VALUES 
('SALETEC20', 20.00, '2024-11-20'),
('BACK2SCHOOL', 15.00, '2024-10-05'),
('CYBERWEEK', 35.00, '2024-12-05');

INSERT INTO uso_cupons (pedido_id, cupom_id, data_uso)
VALUES 
(1, 3, '2024-09-10'),  
(2, 1, '2024-09-11'),  
(1, 2, '2024-09-12');

/*
O código do cupom.
O nome do cliente que utilizou o cupom.
A data de uso do cupom.
O número do pedido em que o cupom foi aplicado.
O valor total do pedido antes do desconto.
O percentual de desconto do cupom.
O valor total final do pedido com o desconto aplicado.
*/

-- CONSULTAS
SELECT 
	cupons.codigo AS codigo_cupom,
	clientes.nome AS nome_cliente,
    pedidos.id AS pedido,
    uso_cupons.data_uso AS data_usocupom,
    pedidos.valor_total AS sem_desconto,
    cupons.percentual_desconto AS porcento_desconto,
    (pedidos.valor_total *(percentual_desconto / 100)) AS com_desconto
FROM uso_cupons
INNER JOIN cupons
ON uso_cupons.cupom_id = cupons.id
INNER JOIN pedidos
ON pedidos.id = uso_cupons.pedido_id
INNER JOIN clientes
ON clientes.id = pedidos.cliente_id;
