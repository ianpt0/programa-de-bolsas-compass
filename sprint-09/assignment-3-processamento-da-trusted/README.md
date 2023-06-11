# Processamento da Trusted

Aqui faremos uso do Apache Spark no processo, integrando dados existentes na camada Raw Zone. O objetivo é gerar uma visão padronizada dos dados, persistida no S3,  compreendendo a Trusted Zone do data lake. Nossos jobs Spark serão criados por meio do AWS Glue.

Todos os dados serão persistidos na Trusted no formato PARQUET, particionados por data de criação do tweet  ou data de coleta do TMDB (dt=<ano\mês\dia> exemplo: dt=2018\03\31). A exceção fica para os dados oriundos do processamento batch (CSV), que não precisam ser particionados.

Iremos separar o processamento em dois jobs: o primeiro, para carga histórica, será responsável pelo processamento dos arquivos CSV  e o segundo, para carga de dados do TMDB. Lembre-se que suas origens serão os dados existentes na RAW Zone.

![Imagem Demonstrativa](img/instrucoes.png)

## 1 - Primeiro Job | Processamento do arquivo CSV:

Primeiro vamos dar uma olhada de como está meu Bucket de RAW Zone atualmente.
![Imagem Demonstrativa](img/raw-zone.png)

Faremos a carga histórica do arquivo "filmes.csv" seguindo os seguintes passos:

- Criando um novo job no AWS Glue para processar os arquivos CSV.
- Na configuração do job, definindo o local de origem dos arquivos CSV no meu bucket.
- Especificando o formato dos arquivos CSV como fonte de dados no AWS Glue.
- Configurando a estrutura de colunas dos arquivos CSV no esquema do AWS Glue.
- Definindo a opção de particionamento para não particionar os dados históricos CSV, conforme mencionado na exceção.
- Escolhendo o formato de destino como PARQUET.
- Especificando o local de destino no S3 para armazenar os dados processados no formato PARQUET.
- Executando o job para processar os arquivos CSV e salvar os dados resultantes no formato PARQUET na minha Trusted Zone.


### Script pro Glue feito baseado nos processos citados anteriormente:

```python
import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job


args = getResolvedOptions(sys.argv, ['JOB_NAME'])

source_bucket = "raw-zone-compass"
source_path_csv = "filmes.csv"

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

connection_options = {
    "paths": [f"s3://{source_bucket}/{source_path_csv}"],
    "recurse": True
}

data_frame = glueContext.create_dynamic_frame.from_options(
    connection_type="s3",
    connection_options=connection_options,
    format="csv",
    format_options={
        "withHeader": True,
        "separator": ","
    }
)

data_frame_df = data_frame.toDF()
data_frame_df = data_frame_df.withColumnRenamed("Data de lançamento", "Data_de_lancamento")

data_frame_dynamic = glueContext.create_dynamic_frame.from_catalog(
    database = "minha-database",
    table_name = "minha-tabela",
    transformation_ctx = "data_frame_dynamic"
)

glueContext.write_dynamic_frame.from_options(
    frame=data_frame_dynamic,
    connection_type="s3",
    connection_options={
        "path": f"s3://{source_bucket}/{source_path_csv}.parquet"
    },
    format="parquet"
)

job.commit()

```

Feito! Importante observar os logs para localizar possíveis erros e ajustar o script conforme necessário.

![Imagem Demonstrativa](img/job-1.png)

Na imagem abaixo visualizamos novamente nosso Bucket mas agora atualizado com nosso arquivo PARQUET.

![Imagem Demonstrativa](img/parq.png)

## 2 - Segundo Job | carga de dados do TMDB:

Criaremos um segundo job com um Script para carregar dados do TMDB usando o AWS Glue:




-----

### Script pro Glue feito baseado nos processos citados anteriormente:

https://raw-zone-compass.s3.amazonaws.com/filmes.csv
s3://meu-bucket-glue
database: minha-database
table: minha-tabela
