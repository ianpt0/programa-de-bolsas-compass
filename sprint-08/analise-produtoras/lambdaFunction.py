import boto3
import urllib3
import json
from collections import defaultdict

api_key = "268b202082529c916c317fd2f539f950"
base_url = "https://api.themoviedb.org/3"
CHUNK_SIZE = 10000
bucket_name = 'raw-zone-compass'  

s3 = boto3.client('s3')

def get_movie_details(movie_id, language='pt-BR'):
    movie_details_url = f"{base_url}/movie/{movie_id}?api_key={api_key}&language={language}"
    http = urllib3.PoolManager()
    response = http.request('GET', movie_details_url)
    return json.loads(response.data)

def download_data(N):
    produtoras_filmes = defaultdict(list)
    idiomas = defaultdict(int)

    for i in range(1, N+1, CHUNK_SIZE):
        top_movies_url = f"{base_url}/movie/top_rated?api_key={api_key}&language=pt-BR&page={i}"
        http = urllib3.PoolManager()
        response = http.request('GET', top_movies_url)
        data = json.loads(response.data)
        
        for movie in data['results']:
            movie_details = get_movie_details(movie['id'])
    
            generos = [genre['name'] for genre in movie_details['genres']]
            if "Romance" in generos or "Drama" in generos:
                for prod_company in movie_details['production_companies']:
                    company_name = prod_company['name']
                    produtoras_filmes[company_name].append({
                        'Titulo': movie['title'],
                        'Data de lançamento': movie['release_date'],
                        'Visão geral': movie['overview'],
                        'Popularidade': movie['popularity'],
                        'Votos': movie['vote_count'],
                        'Média de votos': movie['vote_average'],
                        'País de Origem': ', '.join([country['name'] for country in movie_details['production_countries']]),
                        'Idioma Original': movie_details['original_language'],
                        'Gêneros': ', '.join(generos)
                    })
                idiomas[movie_details['original_language']] += 1

    # Saving the data to an S3 bucket
    s3.put_object(Body=json.dumps(produtoras_filmes), Bucket=bucket_name, Key='produtoras_filmes.json')
    s3.put_object(Body=json.dumps(idiomas), Bucket=bucket_name, Key='idiomas.json')

def lambda_handler(event, context):
    N = 10  # Number of movie pages to download. For example, to download 10 pages of movies.
    download_data(N)
