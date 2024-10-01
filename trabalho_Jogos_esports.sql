Create table JOGADORES(
	ID INT NOT NULL,
    NOME VARCHAR(60) NOT NULL,
    NICKNAME VARCHAR(60) UNIQUE,
    NACIONALIDADE VARCHAR(40),
    NASCIMENTO DATE,
    NOME_TIME INT,
    PRIMARY KEY(ID),
    FOREIGN KEY(NOME_TIME) REFERENCES TIMES(ID)
);

INSERT INTO JOGADORES VALUES
(1, "Lebron James", "KING JAMES", "USA", "1984-12-30", 2),
(2, "Dennis Rodman", "Rodman", "USA", "1961-05-13", 4),
(3, "Kyrie Irving", "Irving", "AUS", "1992-03-23", 3),
(4, "Kobe Bryant", "Mamba Mentality", "USA", "1978-08-23", 2),
(5, "Earvin Johnson Jr.", "Magic Johnson", "USA", "1959-08-14", 2),
(6, "Larry Bird", "Larry Legend", "USA", "1956-12-07", 3),
(7, "Isiah Thomas", "Little Isiah", "USA", "1961-04-30", 4),
(8, "Mark Aguirre", "Aguirre", "USA", "1959-12-10", 4),
(9, "Bill Russell", "Bill", "USA", "1934-02-12", 3),
(10, "Michael Jordan", "MJ", "USA", "1963-02-17", 1),
(11, "Scootie Pipien", "Pippen", "USA", "1965-09-25", 1),
(12, "Derrick Rose", "Rose", "USA", "1988-10-04", 1);

select * from jogadores;

CREATE TABLE TIMES(
	ID INT NOT NULL,
    NOME VARCHAR(60) NOT NULL UNIQUE,
    CRIACAO DATE,
    PRIMARY KEY(ID)
);

INSERT INTO TIMES VALUES
(1, "Chicago Bulls", "1966-01-16"),
(2, "Las Angeles Lakers", "1947-01-01"),
(3, "Boston Celtis", "1946-06-06"),
(4, "Detroit Pistons", "1941-06-29");

select * from times;

CREATE TABLE TORNEIOS(
	ID INT NOT NULL,
	NOME VARCHAR(60) NOT NULL UNIQUE,
	DATA_INICIO DATE,
	DATA_TERMINO DATE,
	PRIMARY KEY(ID)
);

INSERT INTO TORNEIOS VALUES
(1, 'NBA Finals 2024', '2024-06-01', '2024-06-20'),
(2, 'NBA Playoffs 2024', '2024-04-15', '2024-05-30');

CREATE TABLE PARTIDAS(
	ID INT NOT NULL,
    DATA_HORA DATETIME NOT NULL,
    PRIMARY KEY(ID),
    TORNEIO INT,
    TIME1 INT,
    TIME2 INT,
    FOREIGN KEY(TORNEIO) REFERENCES TORNEIOS(ID),
    FOREIGN KEY(TIME1) REFERENCES TIMES(ID),
    FOREIGN KEY(TIME2) REFERENCES TIMES(ID)
);

INSERT INTO PARTIDAS VALUES
(1, '2024-05-25 20:00:00', 1, 1, 2),
(2, '2024-06-01 21:00:00', 2, 4, 3),
(3, "2024-06-04 21:30:00", 2, 3, 2);

SELECT * FROM PARTIDAS;

CREATE TABLE RESULTADOS(
	ID INT NOT NULL,
	PARTIDA INT,
	TIME_VENCEDOR VARCHAR(60) NOT NULL,
    PONTUACAO_TIME1 INT NOT NULL,
    PONTUACAO_TIME2 INT NOT NULL,
    PRIMARY KEY(ID),
    FOREIGN KEY(PARTIDA) REFERENCES PARTIDAS(ID)
);

INSERT INTO RESULTADOS VALUES
(1, 1, 'Los Angeles Lakers', 105, 99),
(2, 2, 'Boston Celtis', 98, 95);

-- Relatório de Desempenho de Times
-- Instrução: Crie um relatório que mostre o desempenho de cada time em um torneio específico.
-- O relatório deve incluir o número de partidas vencidas e a pontuação total acumulada.
SELECT 
    NOME AS NOME_TIME,
    
    (SELECT COUNT(*) 
     FROM RESULTADOS 
     WHERE TIME_VENCEDOR = TIMES.NOME 
       AND PARTIDA IN (SELECT ID FROM PARTIDAS 
                       WHERE TORNEIO = (SELECT ID FROM TORNEIOS WHERE NOME = 'NBA Finals 2024'))
    ) AS PARTIDAS_VENCIDAS,

    (SELECT SUM(PONTUACAO_TIME1) 
     FROM PARTIDAS, RESULTADOS 
     WHERE PARTIDAS.ID = RESULTADOS.PARTIDA 
       AND PARTIDAS.TIME1 = TIMES.ID 
       AND PARTIDAS.TORNEIO = (SELECT ID FROM TORNEIOS WHERE NOME = 'NBA Finals 2024')
    ) +
    (SELECT SUM(PONTUACAO_TIME2) 
     FROM PARTIDAS, RESULTADOS 
     WHERE PARTIDAS.ID = RESULTADOS.PARTIDA 
       AND PARTIDAS.TIME2 = TIMES.ID 
       AND PARTIDAS.TORNEIO = (SELECT ID FROM TORNEIOS WHERE NOME = 'NBA Finals 2024')
    ) AS PONTUACAO_TOTAL

FROM TIMES;

-- Relatório de Desempenho de Jogadores
-- Instrução: Crie um relatório que mostre o desempenho dos jogadores em termos de participação e resultados nas partidas.
SELECT 
    J.NOME AS NOME_JOGADOR,
    J.NICKNAME AS APELIDO,
    
    (SELECT COUNT(*) 
     FROM PARTIDAS P
     WHERE P.TIME1 = J.NOME_TIME OR P.TIME2 = J.NOME_TIME
    ) AS PARTIDAS_JOGADAS,

    (SELECT COUNT(*) 
     FROM PARTIDAS P, RESULTADOS R
     WHERE P.ID = R.PARTIDA 
       AND (P.TIME1 = J.NOME_TIME OR P.TIME2 = J.NOME_TIME)
       AND R.TIME_VENCEDOR = (SELECT NOME FROM TIMES T WHERE T.ID = J.NOME_TIME)
    ) AS PARTIDAS_VENCIDAS
    
FROM 
    JOGADORES J;
    
-- Relatório de Análise do Torneio
-- Instrução: Crie um relatório final que resuma o torneio, 
-- indicando o time campeão, o número total de partidas jogadas, e outras estatísticas relevantes.
SELECT 
    -- Time campeão do torneio (com o maior número de vitórias)
    (SELECT NOME 
     FROM TIMES 
     WHERE ID = (
         SELECT NOME_TIME 
         FROM JOGADORES 
         WHERE NOME_TIME = (
             SELECT TIME_VENCEDOR_ID 
             FROM (
                 SELECT 
                     (SELECT ID FROM TIMES WHERE NOME = TIME_VENCEDOR) AS TIME_VENCEDOR_ID, 
                     COUNT(*) AS VITORIAS 
                 FROM RESULTADOS 
                 WHERE PARTIDA IN (SELECT ID 
                                   FROM PARTIDAS 
                                   WHERE TORNEIO = (SELECT ID FROM TORNEIOS WHERE NOME = 'NBA Finals 2024'))
                 GROUP BY TIME_VENCEDOR_ID 
                 ORDER BY VITORIAS DESC 
                 LIMIT 1
             ) AS TEMP
         ) LIMIT 1
     )
    ) AS TIME_CAMPEAO,

    -- Número total de partidas jogadas no torneio
    (SELECT COUNT(*) 
     FROM PARTIDAS 
     WHERE TORNEIO = (SELECT ID FROM TORNEIOS WHERE NOME = 'NBA Finals 2024')) AS TOTAL_PARTIDAS_JOGADAS,

    -- Pontuação total do torneio (soma de todos os pontos de todas as partidas)
    (SELECT SUM(PONTUACAO_TIME1 + PONTUACAO_TIME2) 
     FROM RESULTADOS 
     WHERE PARTIDA IN (SELECT ID 
                       FROM PARTIDAS 
                       WHERE TORNEIO = (SELECT ID FROM TORNEIOS WHERE NOME = 'NBA Finals 2024'))
    ) AS PONTUACAO_TOTAL_TORNEIO,

    -- Número médio de pontos por partida
    (SELECT AVG(PONTUACAO_TIME1 + PONTUACAO_TIME2) 
     FROM RESULTADOS 
     WHERE PARTIDA IN (SELECT ID 
                       FROM PARTIDAS 
                       WHERE TORNEIO = (SELECT ID FROM TORNEIOS WHERE NOME = 'NBA Finals 2024'))
    ) AS MEDIA_PONTOS_POR_PARTIDA;