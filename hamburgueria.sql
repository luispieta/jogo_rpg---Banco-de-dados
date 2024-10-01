CREATE DATABASE hambugueria;

CREATE TABLE pessoas(
	NOME VARCHAR(20) NOT NULL,
    CPF VARCHAR(11) NOT NULL,
    ENDERECO VARCHAR(40) NOT NULL,
    NUMERO INT NOT NULL,
    BAIRRO VARCHAR(30) NOT NULL ,
    DATA_ANIVERSARIO DATE,
    BONUS DECIMAL(5,2)
);

INSERT INTO pessoas VALUES 
('Luis Felipe', '11111111111', 'Rua José Fraron', '23', 'Fraron', '2006-03-22', '10.00'),
('Erika Louize', '22222222222', 'Av. Tupi', '642', 'Centro', '2001-03-17', NULL),
('Erico Pieta', '88888888888', 'Av. Tupi', '233', 'Centro', '1980-11-03', '15.00'),
('Edeci Fátima', '55555555555', 'Rua Osvaldo', '2', 'La Salle', '1973-07-27', '3.00');

SELECT * FROM pessoas WHERE bonus < '15';
SELECT * FROM pessoas WHERE nome = 'Luis Felipe';