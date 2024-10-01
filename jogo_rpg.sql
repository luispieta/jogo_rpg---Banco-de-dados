-- Exercício 1: Lista de Personagens e suas Raças
-- Objetivo: Exibir todos os personagens com suas respectivas raças.
-- Colunas no relatório: NomePersonagem , NomeRaca, Level,Poder
SELECT personagens.NomePersonagem, racas.NomeRaca, Level, Poder
FROM Personagens
INNER JOIN racas
ON personagens.racaID = racas.racaID;

-- Exercício 2: Lista de Batalhas com os Participantes
-- Objetivo: Mostrar todas as batalhas realizadas, incluindo o nome dos personagens vencedores e perdedores.
-- Colunas no relatório: LocalBatalha , DataBatalha, NomeVencedor,NomePerdedor
SELECT 
	batalhas.LocalBatalha,
	batalhas.DataBatalha, 
    resultadosbatalhas.VencedorID, 
    vencedor.nomepersonagem,
    resultadosbatalhas.PerdedorID,
    perdedor.nomepersonagem
FROM batalhas
INNER JOIN resultadosbatalhas
ON resultadosbatalhas.batalhaID = batalhas.batalhaID
LEFT JOIN personagens as vencedor
ON vencedor.PersonagemID = resultadosbatalhas.VencedorID
LEFT JOIN personagens as perdedor
ON perdedor.personagemID = resultadosbatalhas.PerdedorID;

-- 3: Listar Personagens sem Batalhas
-- Objetivo: ** Exibir todos os personagens que ainda não participaram de batalhas.
-- Colunas no relatório: **  ` NomePersonagem ` , ` Level ` , ` Poder ` , ` NomeRaca
SELECT 
	personagens.nomepersonagem,
    personagens.level,
    personagens.poder,
    racas.NomeRaca,
    resultadosbatalhas.BatalhaID
FROM personagens
LEFT JOIN racas
ON racas.racaid = personagens.racaid
LEFT JOIN resultadosbatalhas
ON resultadosbatalhas.batalhaid = personagens.personagemid
GROUP BY 
	personagens.nomepersonagem,
    personagens.level,
    personagens.poder,
    racas.NomeRaca,
    resultadosbatalhas.BatalhaID;

-- Exercício 4: Quantidade de Batalhas por Personagem **
-- Objetivo: ** Contar quais batalhas cada personagem participou (como vencedor ou perdedor).
-- Colunas no relatório: **  ` NomePersonagem ` , ` QtdBatalhas `
SELECT
	perdedor.NomePersonagem,
    count(batalhas.batalhaid) AS batalhas_perdedoras,
    vencedor.NomePersonagem,
    count(batalhas.batalhaid) AS batalhas_vencedoras
FROM resultadosbatalhas
INNER JOIN batalhas
ON batalhas.BatalhaID = resultadosbatalhas.BatalhaID
LEFT JOIN personagens AS perdedor
ON perdedor.personagemid = resultadosbatalhas.perdedorid 
LEFT JOIN personagens AS vencedor
ON vencedor.PersonagemID = resultadosbatalhas.VencedorID
GROUP BY 
	batalhas.batalhaid,
	vencedor.personagemid,
    perdedor.personagemid;

-- Exercício 5: Vencedores por Local da Batalha
-- Objetivo: Exibir todos os vencedores de batalhas agrupados por batalha local.
-- Colunas no relatório: LocalBatalha, NomeVencedor
SELECT 
	batalhas.localbatalha,
	personagens.NomePersonagem
FROM batalhas
INNER JOIN resultadosbatalhas
ON resultadosbatalhas.batalhaid = batalhas.batalhaid
INNER JOIN personagens
ON personagens.personagemid = resultadosbatalhas.vencedorid
GROUP BY
    personagens.NomePersonagem,
    batalhas.localbatalha;

-- Exercício 6: Detalhes de Batalhas em que um Personagem Específico Participou
-- Objetivo: Mostrar todas as batalhas nas quais um personagem específico participou (como vencedor ou perdedor).
-- Colunas no relatório: NomePersonagem , LocalBatalha, Vencedor, Perdedor, DataBatalha
SELECT 
	personagens.NomePersonagem,
    batalhas.localbatalha,
    vencedor.nomepersonagem AS vencedor,
	perdedor.nomepersonagem AS perdedor,
    batalhas.DataBatalha
FROM batalhas
INNER JOIN resultadosbatalhas
ON resultadosbatalhas.batalhaid = batalhas.BatalhaID
INNER JOIN personagens
ON batalhas.batalhaid = personagens.personagemid
INNER JOIN personagens AS vencedor
ON vencedor.PersonagemID = resultadosbatalhas.VencedorID
INNER JOIN personagens AS perdedor
ON perdedor.PersonagemID = resultadosbatalhas.perdedorid
WHERE personagens.NomePersonagem = "legolas"
GROUP BY 
	personagens.NomePersonagem,
    batalhas.localbatalha,
    vencedor.nomepersonagem,
	perdedor.nomepersonagem,
    batalhas.DataBatalha;
    
-- Exercício 7: Corridas com Mais Vitórias
-- Objetivo: Mostrar quais raças têm mais vitórias em batalhas.
-- Colunas no relatório: NomeRaca, QtdVitorias
SELECT 
	racas.nomeraca,
    count(resultadosbatalhas.vencedorid) AS QtdVitorias
FROM personagens
INNER JOIN resultadosbatalhas
ON resultadosbatalhas.vencedorid = personagens.personagemid
INNER JOIN racas
ON personagens.racaid = racas.racaid
GROUP BY 
	racas.NomeRaca;

-- Exercício 8: Personagens por Raça com o Maior Poder
-- Objetivo: Listar os personagens de cada raça ordenada pelo maior poder.
-- Colunas no relatório: NomeRaca, NomePersonagem, Poder
SELECT 
	racas.nomeraca,
    personagens.nomepersonagem,
    personagens.poder
FROM personagens
INNER JOIN racas
ON racas.racaid = personagens.racaid
ORDER BY personagens.poder DESC;

-- Exercício 9: Detalhes de Batalhas por Dados
-- Objetivo: Exibir detalhes de todas as batalhas realizadas em um dado específico.
-- Colunas no relatório: DataBatalha, LocalBatalha, NomeVencedor, NomePerdedor
SELECT 
	batalhas.databatalha,
    batalhas.localbatalha,
    nomeperdedor.NomePersonagem AS nomeperdedor,
    nomevencedor.NomePersonagem AS nomevencedor
FROM batalhas
INNER JOIN resultadosbatalhas
ON resultadosbatalhas.BatalhaID = batalhas.batalhaid
INNER JOIN personagens AS nomevencedor
ON resultadosbatalhas.VencedorID = nomevencedor.PersonagemID
INNER JOIN personagens AS nomeperdedor
ON resultadosbatalhas.PerdedorID = nomeperdedor.PersonagemID;

-- Exercício 10: Personagens que Nunca Venceram Batalhas
-- Objetivo: Mostrar todos os personagens que nunca venceram nenhuma batalha.
-- Colunas no relatório: NomePersonagem, Level, NomeRaca
SELECT
	personagens.nomepersonagem,
    personagens.level,
    racas.nomeraca
FROM personagens
INNER JOIN racas
ON racas.racaid = personagens.racaid
INNER JOIN resultadosbatalhas 
ON resultadosbatalhas.PerdedorID = personagens.personagemid;