CREATE TABLE reservas_mesas (
	id INT NOT NULL AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    mesa_id INT NOT NULL,
    data_reserva DATE NOT NULL,
    hora_reserva TIME NOT NULL,
    quantidade_pessoas INT,
    PRIMARY KEY(ID),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (mesa_id) REFERENCES mesas(id)
);

INSERT INTO reservas_mesas (cliente_id, mesa_id, data_reserva, hora_reserva, quantidade_pessoas) 
VALUES
(1, 3, '2024-09-13', '19:00:00', 5),
(2, 1, '2024-09-14', '20:30:00', 4),
(3, 2, '2024-09-15', '18:00:00', 2);

-- O nome do cliente que fez a reserva.
-- O número da mesa reservada.
-- A capacidade da mesa.
-- A data e hora da reserva.
-- O número de pessoas na reserva.
-- O valor total dos pedidos feitos pelo cliente (se houver). 

SELECT 	
	clientes.nome AS nome_cliente,
    mesas.numero AS numero_mesa,
    mesas.capacidade AS capacidade,
    reservas_mesas.data_reserva AS data_reserva,
    reservas_mesas.hora_reserva AS hora_reserva,
    reservas_mesas.quantidade_pessoas AS quantidade_pessoas,
    pagamentos.valor_pago AS valor_total
FROM reservas_mesas
INNER JOIN clientes
ON clientes.id = reservas_mesas.cliente_id
INNER JOIN mesas
ON mesas.id = reservas_mesas.mesa_id
LEFT JOIN pagamentos
ON pagamentos.id = pagamentos.valor_pago;