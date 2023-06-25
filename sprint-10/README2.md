Antes de criar o Sketch do meu Dashboard no Figma, preciso ter bem definido o meu objetivo com a análise, juntamente com o Storytelling que será criado partindo dos dados analisados.

Isso foi definido na __[Sprint 8](https://github.com/ianpt0/programa-de-bolsas-compass/tree/master/sprint-08)__ mas farei algumas adições e alterações para enriquecer a análise, segue o que foi definido:

**Tema:** Produtoras

**Objetivo:** Investigar os países onde a maioria dos filmes de Drama/Romance foram produzidos e descobrir quais as produtoras que possuem maior diversidade cultural de produção.

- Total de filmes de drama/romance de cada produtora 
- Quantidade de filmes produzidos em cada país de origem (por produtora)
- Top 3 filmes mais populares, seu país de origem e sua produtora
- Top 3 filmes menos populares, seu país de origem e sua produtora

# Revisão das tabelas para visualização dos dados com o QuickSight

Já tenho a tabela Refined que foi construída na __[Sprint 9](https://github.com/ianpt0/programa-de-bolsas-compass/tree/master/sprint-09/assignment-4-modelagem-dados-refined)__ então só vou criar novas Views que serão fundamentais para construção do Dashboard.

## Tabelas do Refined

| Colunas       | Significado   |
| ------------- |:-------------:|
| col0          | Index         |
| col1          | Titulo        |
| col2          | Lançamento    |
| col3          | Visão geral   |
| col4          | Votos         |
| col5          | Média de votos|
| col6          | Produtora     |
| col7          | País          |
| col8          | Idioma        |
| col9          | Gênero        |

## View 1 "filmes_por_produtora" | Total de filmes de drama/romance de cada produtora 


