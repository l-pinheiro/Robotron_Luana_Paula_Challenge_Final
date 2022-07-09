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
    Validar status code de login "200"
    Validar a mensagem no campo  Login realizado com sucesso    message     response_login

# Falha - documentação informa 400 mas o retorno é 401 #
Cenario: POST Realizar Login Invalido 400
    [tags]     POST                 POST.LOGIN.INVALIDO
    Criar usuario_invalido estatico login
    POST endpoint /login
    Validar status code de login "400"
    Validar a mensagem no campo  Email e/ou senha inválidos    message     response_login

### Cenarios Extras Que Podem Ocorrer (Fora da Documentação) ###
Cenario: POST Realizar Login Sem Email 400
    [tags]     POST                 POST.LOGIN.SEM.EMAIL
    Criar usuario_sem_email estatico login
    POST endpoint /login
    Validar status code de login "400"
    Validar a mensagem no campo  email não pode ficar em branco          email     response_login

Cenario: POST Realizar Login Sem Senha 400
    [tags]     POST                 POST.LOGIN.SEM.SENHA
    Criar usuario_sem_senha estatico login
    POST endpoint /login
    Validar status code de login "400"
    Validar a mensagem no campo  password não pode ficar em branco       password     response_login