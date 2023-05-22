# Use uma imagem base Python
FROM python:3

# Copie o código Python para o container
COPY . /app
WORKDIR /app

# Instale as dependências necessárias
RUN pip install boto3

# Defina o comando de execução
CMD ["python", "script-python.py"]
