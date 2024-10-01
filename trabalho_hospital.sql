CREATE DATABASE hospital;
USE hospital;

CREATE TABLE cidadaos (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    idade INT,
    sexo CHAR(1),
    bairro VARCHAR(100),
    doenca VARCHAR(100)
);

INSERT INTO cidadaos (id, nome, idade, sexo, bairro, doenca) VALUES
(1, 'Ana Silva', 34, 'F', 'Centro', 'Diabetes'),
(2, 'Bruno Costa', 45, 'M', 'Centro', 'Hipertensão'),
(3, 'Carlos Oliveira', 29, 'M', 'Centro', 'Asma'),
(4, 'Diana Souza', 50, 'F', 'Centro', 'Hipertensão'),
(5, 'Eduardo Lima', 22, 'M', 'Centro', 'Diabetes'),
(6, 'Fernanda Rocha', 31, 'F', 'Centro', 'Asma'),
(7, 'Gabriel Martins', 38, 'M', 'Zona Norte', 'Diabetes'),
(8, 'Helena Cardoso', 60, 'F', 'Zona Norte', 'Hipertensão'),
(9, 'Igor Santos', 40, 'M', 'Zona Norte', 'Diabetes'),
(10, 'Juliana Almeida', 27, 'F', 'Zona Norte', 'Asma'),
(11, 'Kleber Ramos', 35, 'M', 'Zona Norte', 'Hipertensão'),
(12, 'Larissa Mendes', 49, 'F', 'Zona Norte', 'Asma'),
(13, 'Marcelo Ferreira', 33, 'M', 'Zona Sul', 'Diabetes'),
(14, 'Nathalia Moreira', 41, 'F', 'Zona Sul', 'Hipertensão'),
(15, 'Otávio Barbosa', 55, 'M', 'Zona Sul', 'Diabetes'),
(16, 'Patrícia Oliveira', 30, 'F', 'Zona Sul', 'Asma'),
(17, 'Quirino Andrade', 62, 'M', 'Zona Sul', 'Hipertensão'),
(18, 'Renata Farias', 44, 'F', 'Zona Sul', 'Diabetes'),
(19, 'Sérgio Cunha', 28, 'M', 'Centro', 'Asma'),
(20, 'Tânia Lima', 47, 'F', 'Centro', 'Diabetes'),
(21, 'Ulisses Campos', 37, 'M', 'Zona Oeste', 'Hipertensão'),
(22, 'Valéria Duarte', 53, 'F', 'Zona Oeste', 'Diabetes'),
(23, 'Wagner Carvalho', 42, 'M', 'Zona Oeste', 'Asma'),
(24, 'Xavier Borges', 50, 'M', 'Zona Oeste', 'Hipertensão'),
(25, 'Yara Teixeira', 34, 'F', 'Zona Oeste', 'Asma'),
(26, 'Zenaide Pereira', 61, 'F', 'Zona Oeste', 'Diabetes'),
(27, 'Arthur Souza', 46, 'M', 'Centro', 'Hipertensão'),
(28, 'Bia Silva', 39, 'F', 'Centro', 'Asma'),
(29, 'Cássio Ribeiro', 31, 'M', 'Zona Norte', 'Diabetes'),
(30, 'Daniela Franco', 24, 'F', 'Zona Sul', 'Asma'),
(31, 'Elias Melo', 52, 'M', 'Centro', 'Hipertensão'),
(32, 'Flávia Gomes', 36, 'F', 'Zona Oeste', 'Diabetes'),
(33, 'Gustavo Araújo', 29, 'M', 'Zona Sul', 'Asma'),
(34, 'Heloisa Barbosa', 57, 'F', 'Centro', 'Diabetes'),
(35, 'Ícaro Nogueira', 48, 'M', 'Zona Norte', 'Hipertensão'),
(36, 'Júlio Vieira', 40, 'M', 'Zona Oeste', 'Diabetes'),
(37, 'Lívia Castro', 33, 'F', 'Zona Sul', 'Asma'),
(38, 'Mário Braga', 56, 'M', 'Zona Norte', 'Diabetes'),
(39, 'Nina Duarte', 45, 'F', 'Centro', 'Hipertensão'),
(40, 'Otávio Silva', 25, 'M', 'Zona Norte', 'Asma');

-- 1. Distribuição Etária
SELECT idade, COUNT(idade) AS quantidade_idade
FROM cidadaos
GROUP BY idade;

-- 2. Análise de Doenças por Sexo
SELECT doenca, sexo, COUNT(doenca) AS quantidade_de_doentes
FROM cidadaos
GROUP BY doenca, sexo;

-- 3. Indicadores por Bairro
SELECT bairro, doenca, COUNT(doenca) AS quantidade_bairro
FROM cidadaos
WHERE doenca IN( "Hipertensão", "Diabetes")
GROUP BY doenca, bairro;

-- 4. Faixa Etária e Doenças
SELECT doenca, idade, COUNT(doenca) AS pessoas_diabetes
FROM cidadaos
WHERE doenca = "Diabetes"
GROUP BY doenca, idade
HAVING idade <= 40;

-- 6. Análise de Risco
SELECT bairro, 
	CASE 
		WHEN idade BETWEEN 20 AND 39 THEN "20-39"
		WHEN idade BETWEEN 40 AND 59 THEN "40-59"
        ELSE "60-79"
	END AS faixa_etaria, COUNT(*) AS total_etaria
    FROM cidadaos
    GROUP BY bairro, faixa_etaria
    ORDER BY bairro, faixa_etaria;
