import hashlib

while True:
    string = input("Digite uma string: ")
    hash_object = hashlib.sha1(string.encode())
    hex_dig = hash_object.hexdigest()
    print(hex_dig)
    