-- 1. Ordenação Simples
 -- Ordene a lista de pokémons pelo nome em ordem alfabética.
SELECT *
FROM POKEMONS
ORDER BY NOME;

-- 2. Ordenação por Múltiplas Colunas
-- Ordene os pokémons pelo tipo em ordem alfabética e, em seguida, pela destreza em ordem decrescente.
SELECT TIPO, DESTREZA
FROM POKEMONS
ORDER BY TIPO, DESTREZA DESC;

-- 3. Agrupamento por Tipo
-- Enunciado: Agrupe os pokémons pelo tipo e exiba a quantidade total de pokémons em cada tipo.
SELECT TIPO, COUNT(TIPO) AS QUANTIDADE_POKEMONS 
FROM POKEMONS
GROUP BY TIPO
ORDER BY QUANTIDADE_POKEMONS DESC;

-- 4. Média de Ataque por Tipo
-- Enunciado: Calcule a média de ataque para cada tipo de pokémon, agrupando-os pelo tipo.
SELECT TIPO, COUNT(TIPO) AS QUANTIDADE_POKEMONS, AVG(ATAQUE) AS MEDIA_ATAQUE
FROM POKEMONS
GROUP BY TIPO
ORDER BY MEDIA_ATAQUE DESC, TIPO DESC;

-- 5. Máximo e Mínimo de Defesa
-- Enunciado: Encontre o valor máximo e mínimo de defesa entre todos os pokémons.
SELECT TIPO, MIN(DEFESA) AS MIN_DEFESA, MAX(DEFESA) AS MAX_DEFESA
FROM POKEMONS
GROUP BY TIPO
ORDER BY MAX_DEFESA DESC, MIN_DEFESA DESC;

-- 6. Filtragem com HAVING
-- Enunciado: Encontre os tipos de pokémons que têm uma média de destreza superior a 60.
SELECT TIPO, AVG(DESTREZA) AS MEDIA_DESTREZA
FROM POKEMONS
GROUP BY TIPO
HAVING MEDIA_DESTREZA > 60;

-- 7. Soma de Ataques para Pokémons do Tipo Fogo
-- Enunciado: Calcule a soma total dos valores de ataque para todos os pokémons do tipo "Fogo".
SELECT TIPO, SUM(ATAQUE) AS SOMA_ATAQUE
FROM POKEMONS
GROUP BY TIPO
HAVING TIPO = "FOGO"; 

-- 8. Ordenação de Pokémons por Defesa
-- Enunciado: Ordene os pokémons pela defesa em ordem crescente e, em caso de empate, pela destreza em ordem decrescente.
SELECT *
FROM POKEMONS
ORDER BY DEFESA DESC, DESTREZA ASC;

-- 9. Agrupamento e Contagem de Pokémons com Mais de 80 de Ataque
-- Enunciado: Agrupe os pokémons por tipo e conte quantos pokémons em cada tipo têm ataque maior que 80.
SELECT TIPO, COUNT(TIPO) AS CONTAGEM
FROM POKEMONS
GROUP BY TIPO
HAVING COUNT(ATAQUE) > 80;

-- 10. Ordenação por Tipo e Média de Ataque
-- Enunciado: Agrupe os pokémons pelo tipo, calcule a média de ataque para cada tipo e ordene os resultados pela média de ataque em ordem decrescente.
SELECT TIPO, AVG(ATAQUE) AS MEDIA_ATAQUE
FROM POKEMONS
GROUP BY TIPO
ORDER BY MEDIA_ATAQUE;