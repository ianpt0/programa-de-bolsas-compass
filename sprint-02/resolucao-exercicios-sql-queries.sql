-----------------------------------------------------------------------------------
--                 ESTUDO DE CASO 1 | BIBLIOTECA
-----------------------------------------------------------------------------------

-- CODING EXERCISE 1
-- Apresente a query para listar todos os livros publicados após 2014. 
-- Ordenar pela coluna cod, em ordem crescente, as linhas.  
-- Atenção às colunas esperadas no resultado final: cod, titulo, autor, editora, valor, publicacao, 
-- edicao, idioma
SELECT cod, titulo, autor, editora, valor, publicacao, edicao, idioma 
FROM livro
WHERE publicacao >= '2015-01-01' 
ORDER BY cod

-- CODING EXERCISE 2
-- Apresente a query para listar os 10 livros mais caros. Ordenar as linhas pela coluna valor, 
-- em ordem decrescente.  Atenção às colunas esperadas no resultado final:  titulo, valor.
SELECT titulo, valor
FROM livro
ORDER BY livro.valor DESC
LIMIT  10

-- CODING EXERCISE 3
--  Apresente a query para listar as 5 editoras com mais livros na biblioteca. 
-- O resultado deve conter apenas as colunas quantidade, nome, estado e cidade. 
-- Ordenar as linhas pela coluna que representa a quantidade de livros em ordem decrescente.
SELECT COUNT(livro.cod) AS quantidade,
editora.nome,
endereco.estado,
endereco.cidade
FROM editora 
INNER JOIN endereco ON editora.endereco = endereco.codendereco
INNER JOIN livro ON editora.codeditora = livro.editora
GROUP BY editora.nome, endereco.estado, endereco.cidade 

-- CODING EXERCISE 4
-- Apresente a query para listar a quantidade de livros publicada por cada autor. 
-- Ordenar as linhas pela coluna nome (autor), em ordem crescente. Além desta, 
-- apresentar as colunas codautor, nascimento e quantidade (total de livros de sua autoria).
SELECT autor.nome,
autor.codautor,
autor.nascimento,
COALESCE(COUNT(livro.cod),0) AS quantidade
FROM autor
LEFT JOIN livro ON autor.codautor = livro.autor 
GROUP BY autor.nome

-- CODING EXERCISE 5
-- Apresente a query para listar o nome dos autores que publicaram livros através 
-- de editoras NÃO situadas na região sul do Brasil. Ordene o resultado pela coluna nome, 
-- em ordem crescente. Não podem haver nomes repetidos em seu retorno.
SELECT DISTINCT autor.nome 
FROM autor
RIGHT JOIN livro ON autor.codautor = livro.autor
RIGHT JOIN editora ON livro.editora = editora.codeditora
RIGHT JOIN endereco ON editora.endereco = endereco.codendereco
WHERE (endereco.estado <> 'RIO GRANDE DO SUL') 
AND (endereco.estado <> 'SANTA CATARINA')
AND (endereco.estado <> 'PARANÁ')
AND (autor.nome IS NOT NULL) 
ORDER BY autor.nome

-- CODING EXERCISE 6
-- Apresente a query para listar o autor com maior número de livros publicados. 
-- O resultado deve conter apenas as colunas codautor, nome, quantidade_publicacoes.
SELECT autor.codautor, autor.nome, COUNT(*) as quantidade_publicacoes
FROM autor
INNER JOIN livro ON autor.codautor = livro.autor
GROUP BY autor.codautor, autor.nome
ORDER BY quantidade_publicacoes DESC
LIMIT 1;

-- CODING EXERICSE 7
-- Apresente a query para listar o nome dos autores com nenhuma publicação. 
-- Apresentá-los em ordem crescente.
SELECT autor.nome
FROM autor
LEFT JOIN livro ON autor.codautor = livro.autor
GROUP BY autor.nome
HAVING COUNT(livro.autor) = 0
ORDER BY autor.nome

-----------------------------------------------------------------------------------
--                   ESTUDO DE CASO 2 | LOJA
-----------------------------------------------------------------------------------

-- CODING EXERCISE 8
-- Apresente a query para listar o código e o nome do vendedor com maior número de vendas (contagem), 
-- e que estas vendas estejam com o status concluída.  As colunas presentes no resultado devem ser,
-- portanto, cdvdd e nmvdd.
SELECT v.cdvdd, v.nmvdd
FROM tbvendedor v
INNER JOIN tbvendas s ON v.cdvdd = s.cdvdd
WHERE s.status = 'Concluído'
GROUP BY v.cdvdd, v.nmvdd
ORDER BY COUNT(s.cdvdd) DESC
LIMIT 1

-- CODING EXERCISE 9
-- Apresente a query para listar o código e nome do produto mais vendido entre 
-- as datas de 2014-02-03 até 2018-02-02, e que estas vendas estejam com o status concluída. 
-- As colunas presentes no resultado devem ser cdpro e nmpro.
SELECT tbvendas.cdpro, tbvendas.nmpro 
FROM tbvendas
WHERE tbvendas.dtven BETWEEN '2014-02-03' AND '2018-02-02'
AND tbvendas.status = 'Concluído'
GROUP BY tbvendas.cdpro, tbvendas.nmpro 
ORDER BY COUNT(tbvendas.cdvdd) DESC
LIMIT 1

-- CODING EXERCISE 10
-- calcule a comissão de todos os vendedores, considerando todas as vendas 
-- armazenadas na base de dados com status concluído.
SELECT tbvendedor.nmvdd AS vendedor,
SUM(tbvendas.qtd * tbvendas.vrunt) AS valor_total_vendas,
ROUND(SUM(tbvendas.qtd * tbvendas.vrunt) * tbvendedor.perccomissao / 100, 2) AS comissao
FROM tbvendas
INNER JOIN tbvendedor ON tbvendas.cdvdd = tbvendedor.cdvdd 
WHERE tbvendas.status = 'Concluído'
GROUP BY tbvendedor.nmvdd 
ORDER BY ROUND(comissao,2) DESC

--CODING EXERCISE 11
-- Apresente a query para listar o código e nome cliente com maior gasto na loja. 
-- As colunas presentes no resultado devem ser cdcli, nmcli e gasto, esta última 
-- representando o somatório das vendas (concluídas) atribuídas ao cliente.
SELECT tbvendas.cdcli,
tbvendas.nmcli,
SUM(tbvendas.qtd * tbvendas.vrunt)AS gasto
FROM tbvendas
WHERE tbvendas.status = 'Concluído'
GROUP BY tbvendas.nmcli 
ORDER BY gasto DESC
LIMIT 1

-- CODING EXERCISE 12
-- Apresente a query para listar código, nome e data de nascimento dos dependentes 
-- do vendedor com menor valor total bruto em vendas (não sendo zero). As colunas 
-- presentes no resultado devem ser cddep, nmdep, dtnasc e valor_total_vendas.
SELECT tbdependente.cddep,
tbdependente.nmdep,
tbdependente.dtnasc,
SUM(tbvendas.vrunt * tbvendas.qtd) AS valor_total_vendas
FROM tbdependente 
INNER JOIN tbvendas ON tbdependente.cdvdd = tbvendas.cdvdd
WHERE tbvendas.status = 'Concluído'
GROUP BY tbdependente.cddep 
ORDER BY valor_total_vendas 
LIMIT 1

-- CODING EXERCISE 13
-- Apresente a query para listar os 10 produtos menos vendidos pelos 
-- canais de E-Commerce ou Matriz (Considerar apenas vendas concluídas).  
-- As colunas presentes no resultado devem ser cdpro, nmcanalvendas, nmpro e quantidade_vendas.
SELECT tbvendas.cdpro,
tbvendas.nmcanalvendas,
tbvendas.nmpro,
SUM(tbvendas.qtd) AS quantidade_vendas
FROM tbvendas 
WHERE tbvendas.status = 'Concluído' AND (tbvendas.nmcanalvendas = 'Ecommerce' OR tbvendas.nmcanalvendas = 'Matriz')
GROUP BY tbvendas.cdpro, tbvendas.nmcanalvendas, tbvendas.nmpro 
ORDER BY quantidade_vendas 

-- CODING EXERCISE 14
-- Apresente a query para listar o gasto médio por estado da federação. 
-- As colunas presentes no resultado devem ser estado e gastomedio. Considere 
-- apresentar a coluna gastomedio arredondada na segunda casa decimal e ordenado de forma decrescente.
SELECT tbvendas.estado,
ROUND(AVG(tbvendas.vrunt * tbvendas.qtd),2) AS gastomedio
FROM tbvendas 
WHERE tbvendas.status = 'Concluído'
GROUP BY tbvendas.estado
ORDER BY ROUND(gastomedio,2) DESC

-- CODING EXERCISE 15
--Apresente a query para listar os códigos das vendas identificadas como deletadas. 
-- Apresente o resultado em ordem crescente.
SELECT tbvendas.cdven
FROM tbvendas 
WHERE tbvendas.deletado > 0

-- CODING EXERCISE 16
-- Apresente a query para listar a quantidade média vendida de cada produto 
-- agrupado por estado da federação
SELECT tbvendas.estado,
tbvendas.nmpro,
ROUND(AVG(tbvendas.qtd),4) AS quantidade_media
FROM tbvendas 
WHERE tbvendas.status = 'Concluído'
GROUP BY tbvendas.estado, tbvendas.nmpro  
ORDER BY tbvendas.estado ASC, tbvendas.nmpro ASC










