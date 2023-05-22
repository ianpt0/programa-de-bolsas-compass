import boto3
import logging
from botocore.exceptions import ClientError

def upload_file_to_s3(file_name, bucket, object_name=None):
    # Se o nome do objeto S3 não foi especificado, usamos o nome do arquivo
    if object_name is None:
        object_name = file_name

    # Faz o upload do arquivo
    s3_client = boto3.client('s3')
    try:
        response = s3_client.upload_file(file_name, bucket, object_name)
    except ClientError as e:
        logging.error(e)
        return False
    return True

upload_file_to_s3('movies.csv', 'meu-data-lake')
upload_file_to_s3('series.csv', 'meu-data-lake')