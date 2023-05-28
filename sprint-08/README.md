# 1 - Análise das Colunas da API 

Após a requisição das credenciais da API, foram analisadas as colunas a fim de definir melhor algumas perguntas que tragam valor à aqueles dados.

## Colunas encontradas

- "id": Índice.
- "title": O título do filme.
- "original_title": O título do filme em seu idioma original.
- "overview": Um breve resumo do filme.
- "popularity": Uma medida da popularidade do filme.
- "vote_count": O número de votos para o filme.
- "vote_average": A classificação média do filme.
- "release_date": A data de lançamento do filme.
- "adult": Se o filme é ou não para adultos.
- "genre_ids": Uma matriz de identificadores para os gêneros do filme.
- "original_language": O idioma original do filme.
- "poster_path": Caminho para o cartaz do filme.
- "backdrop_path": Caminho para o cenário do filme.
- "cast": Informações sobre o elenco do filme.
- "crew": Informações sobre a equipe do filme.
- "keywords": Palavras-chave relacionadas ao filme.
- "videos": Vídeos relacionados ao filme.
- "reviews": Comentários do filme.
- "production_companies": Uma matriz de empresas de produção envolvidas no filme.
- "production_countries": Uma matriz de países onde o filme foi produzido.

Cada um desses campos (como "production_companies" ou "cast") tem seu próprio conjunto de subcampos.

## Tema e Perguntas Definidas

**Tema:** Produtoras

**Perguntas:** 

- Total de filmes de drama/romance de cada produtora 
- Produtoras com filmes mais populares dentro desses gêneros por década
- Países das produtoras que possuem filmes de maior popularidade

---

# 2 - Criação do Script Python

O script escreve o arquivo JSON diretamente no S3 bucket usando a função `put_object` do Boto3 S3. Os dados do JSON são escritos no buffer StringIO, e em seguida, o conteúdo do buffer é enviado para o S3.

![Imagem Demonstrativa](img/preview-columns-notebook.png)

Acesse o notebook com as visualizações completas [aqui.](https://github.com/ianpt0/programa-de-bolsas-compass/sprint-08/imdp.ipynb/)

---

# 3 - Criação do Pacote Zip para Layer Lambda

Foi criado um pacote zip para layer lambda através da WSL, incluindo pacotes como: python, boto3, urllib e pandas.

```bash
$ mkdir python
$ cd python
$ pip install boto3 urllib3 -t .
$ pip install pandas
$ cd ..
$ zip -r meulayer.zip python/
```

![Imagem Demonstrativa](img/evidencia-cli-layer-compactando-pacote.png)

você consegue o arquivo do mesmo __[aqui](https://github.com/ianpt0/programa-de-bolsas-compass/sprint-08/analise-produtoras/meulayer.zip/)__  

após isso criei a camada lambda no console AWS como "meu-layer"

![Imagem Demonstrativa](img/meu-layer.png)

---
# 3 - Criação da função lambda
criei minha função com o nome de "minha-funcao-tmdb" e defini o layer criado na etapa anterior como o personalizado pra essa função

![Imagem Demonstrativa](img/lambda-funcao.png)

