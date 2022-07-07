* Settings *
Documentation       Arquivo de testes para o endpoint /usuarios
Resource            ../support/base.robot
Suite Setup         Criar Sessao


* Test Cases *
#-------------Cenarios GET endpoint /usuarios -------------------------------------------------------------------------------------#
Cenario: GET Todos os Usuarios 200
    [tags]      GET                 GET.USUARIOS
    GET endpoint /usuarios
    Validar status code "200"

Cenario: GET Usuario Especifico 200
    [tags]      GET                 GET.USUARIO
    Criar dados dinamico usuario
    POST endpoint /usuarios
    GET endpoint /usuarios especifico
    Validar status code "200"

Cenario: GET Usuario Especifico ID Invalido 400
    [tags]      GET                 GET.USUARIO.ID.INVALIDO
    GET endpoint /usuarios especifico   ${id_invalido}
    Validar status code "400"
    Validar a Mensagem "Usuário não encontrado"

#-------------Cenarios POST endpoint /usuarios -------------------------------------------------------------------------------------#
Cenario: POST Cadastrar Usuario 201
    [tags]     POST                 POST.USUARIO
    Criar dados dinamico usuario
    POST endpoint /usuarios
    Validar status code "201"
    Validar a Mensagem "Cadastro realizado com sucesso"

Cenario: POST Cadastrar Usuario Email Utilizado 400
    [tags]     POST                 POST.USUARIO.EMAIL.UTILIZADO
    Criar dados dinamico usuario    adm=false
    POST endpoint /usuarios
    POST endpoint /usuarios
    Validar status code "400"
    Validar a Mensagem "Este email já está sendo usado"

### Cenarios Extras Que Podem Ocorrer (Fora da Documentação) ###
Cenario: POST Cadastrar Usuario Sem Nome 400
    [tags]     POST                 POST.USUARIO.SEM.NOME
    Criar dados dinamico usuario    sem nome
    POST endpoint /usuarios
    Validar status code "400"
    Validar no campo a mensagem     nome           nome é obrigatório

Cenario: POST Cadastrar Usuario Sem Email 400
    [tags]     POST                 POST.USUARIO.SEM.EMAIL
    Criar dados dinamico usuario    sem email
    POST endpoint /usuarios
    Validar status code "400"
    Validar no campo a mensagem     email          email é obrigatório

Cenario: POST Cadastrar Usuario Sem Senha 400
    [tags]     POST                 POST.USUARIO.SEM.SENHA
    Criar dados dinamico usuario    sem senha
    POST endpoint /usuarios
    Validar status code "400"
    Validar no campo a mensagem     password       password é obrigatório
### FIM Cenarios Extras Que Podem Ocorrer (Fora da Documentação) ###

#-------------Cenarios PUT endpoint /usuarios -------------------------------------------------------------------------------------#
Cenario: PUT Editar Usuario 200
    [tags]     PUT                  PUT.USUARIO
    Criar dados dinamico usuario    adm=true
    POST endpoint /usuarios
    Criar dados dinamico usuario    adm=false
    PUT endpoint /usuarios
    Validar status code "200"
    Validar a Mensagem "Registro alterado com sucesso"

Cenario: PUT Editar/Cadastrar Usuario Nao Cadastrado 201
    [tags]     PUT                  PUT.USUARIO.NAO.CADASTRADO
    Criar dados dinamico usuario
    PUT endpoint /usuarios          ${id_invalido}
    Validar status code "201"
    Validar a Mensagem "Cadastro realizado com sucesso"

Cenario: PUT Editar/Cadastrar Usuario Email Utilizado 400
    [tags]     PUT                  PUT.USUARIO.EMAIL.UTILIZADO
    Criar dados dinamico usuario
    POST endpoint /usuarios
    PUT endpoint /usuarios          ${id_invalido}
    Validar status code "400"
    Validar a Mensagem "Este email já está sendo usado"

#-------------Cenarios DELETE endpoint /usuarios -------------------------------------------------------------------------------------#
Cenario: DELETE Deletar Usuario Existente 200
    [tags]     DELETE               DELETE.USUARIO
    Criar dados dinamico usuario
    POST endpoint /usuarios
    DELETE endpoint /usuarios
    Validar status code "200"
    Validar a Mensagem "Registro excluído com sucesso"

Cenario: DELETE Deletar Usuario Inexistente 200
    [tags]     DELETE               DELETE.USUARIO.INEXISTENTE
    DELETE endpoint /usuarios       ${id_invalido}
    Validar status code "200"
    Validar a Mensagem "Nenhum registro excluído"

Cenario: DELETE Deletar Usuario Com Carrinho 400
    [tags]     DELETE               DELETE.USUARIO.CARRINHO
    Criar usuario adm=true e guardar dados de login
    POST endpoint /login
    Criar carrinho_valido estatico
    POST endpoint /carrinhos
    DELETE endpoint /usuarios       ${id_usuario}
    Validar status code "400"
    Validar a Mensagem "Não é permitido excluir usuário com carrinho cadastrado"