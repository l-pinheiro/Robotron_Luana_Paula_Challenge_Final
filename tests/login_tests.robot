* Settings *
Documentation       Arquivo de testes para o endpoint /login
Resource            ../support/base.robot
Suite Setup         Criar Sessao


* Test Cases *
#-------------Cenarios POST endpoint /login -------------------------------------------------------------------------------------#
Cenario: POST Realizar Login 200
    [tags]     POST                 POST.LOGIN
    Criar usuario_valido_api estatico login
    POST endpoint /login
    Validar status code "200"
    Validar a mensagem "Login realizado com sucesso"

# Falha - documentação informa 400 mas o retorno é 401 #
Cenario: POST Realizar Login Invalido 400
    [tags]     POST                 POST.LOGIN.INVALIDO
    Criar usuario_invalido estatico login
    POST endpoint /login
    Validar status code "400"
    Validar a mensagem "Email e/ou senha inválidos"

### Cenarios Extras Que Podem Ocorrer (Fora da Documentação) ###
Cenario: POST Realizar Login Sem Email 400
    [tags]     POST                 POST.LOGIN.SEM.EMAIL
    Criar usuario_sem_email estatico login
    POST endpoint /login
    Validar status code "400"
    Validar no campo a mensagem     email           email não pode ficar em branco

Cenario: POST Realizar Login Sem Senha 400
    [tags]     POST                 POST.LOGIN.SEM.SENHA
    Criar usuario_sem_senha estatico login
    POST endpoint /login
    Validar status code "400"
    Validar no campo a mensagem     password        password não pode ficar em branco