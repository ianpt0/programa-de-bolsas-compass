# Usando Python 3 como imagem base
FROM python:3

# Copiando o arquivo carguru.py pro container
COPY carguru.py /

# Instalando a dependencia do random
RUN pip install random2

# Setando o diretório
WORKDIR /

# Rodando o carguru.py script quando o container iniciar
CMD ["python", "carguru.py"]
