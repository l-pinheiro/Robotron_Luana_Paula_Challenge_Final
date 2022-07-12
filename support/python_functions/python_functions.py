# Arquivo de funções personalizadas em python para serem consumidas no Robot

import requests as req
from faker import Faker

def Pegar_Dados_Login_Usuario (id_usuario):
    r = req.get("http://localhost:3000/usuarios/" + id_usuario)
    response_json = r.json()
    payload = {'email': response_json["email"], 'password':  response_json["password"]}
    return payload
        
def Criar_usuario_dinamico (campo, adm):
    fake = Faker()
    if campo == "valido":
        nome = fake.name()
        email = fake.email()
        senha = fake.password()
        payload = {'nome': nome, 'email': email, 'password': senha, 'administrador': adm}
    elif campo == "sem nome":
        email = fake.email()
        senha = fake.password()
        payload = {'email': email, 'password': senha, 'administrador': adm}
    elif campo == "sem email":
        nome = fake.name()
        senha = fake.password()
        payload = {'nome': nome, 'password': senha, 'administrador': adm}
    elif campo == "sem senha":
        nome = fake.name()
        email = fake.email()
        payload = {'nome': nome, 'email': email, 'administrador': adm}
    elif campo == "sem adm":
        nome = fake.name()
        email = fake.email()
        senha = fake.password()
        payload = {'nome': nome, 'email': email, 'password': senha}
    return payload

def Pegar_Quantidades_Dos_Produtos (ids_produtos):
    quantidades = []
    for id in ids_produtos:
        r = req.get("http://localhost:3000/produtos/" + id)
        response_json = r.json()
        quantidades.append(response_json["quantidade"])
    return quantidades

def Verificar_Alteracao (quantidade_inicial, quantidade_final, diferenca):
    mensagem = []
    for i in range(len(quantidade_inicial)):
        if quantidade_inicial[i] + int(diferenca[i]) == quantidade_final[i]:
            mensagem.append("quantidade certa em estoque")
        else:
            mensagem.append("erro na quantidade do estoque")
    return mensagem