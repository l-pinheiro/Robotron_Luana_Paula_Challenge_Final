* Settings *
Documentation       Arquivo de testes para o endpoint /produtos
Resource            ../support/base.robot
Suite Setup         Criar Sessao


* Test Cases *
#-------------Cenarios GET endpoint /produtos -------------------------------------------------------------------------------------#
Cenario: GET Todos os Produtos 200
    [tags]      GET.PRODUTOS
    GET endpoint /produtos
    Validar status code "200"

Cenario: GET Produto Especifico 200
    [tags]     GET.PRODUTO
    Criar usuario_valido_api estatico login
    POST endpoint /login
    Criar dados dinamico produto
    POST endpoint /produtos
    GET endpoint /produtos especifico
    Validar status code "200"

Cenario: GET Produto Especifico ID Invalido 400
    [tags]     GET.PRODUTO.ID.INVALIDO
    GET endpoint /produtos especifico   ${id_invalido}
    Validar status code "400"
    Validar a Mensagem "Produto não encontrado"

#-------------Cenarios POST endpoint /produtos -------------------------------------------------------------------------------------#
Cenario: POST Cadastrar Produto 201
    [tags]     POST.PRODUTO
    Criar usuario_valido_api estatico login
    POST endpoint /login
    #Fazer login e armazenar token
    Criar dados dinamico produto
    POST endpoint /produtos
    Validar status code "201"
    Validar a Mensagem "Cadastro realizado com sucesso"

Cenario: POST Cadastrar Produto Nome Utilizado 400
    [tags]     POST.PRODUTO.NOME.UTILIZADO
    Criar usuario_valido_api estatico login
    POST endpoint /login
    #Fazer login e armazenar token
    Criar dados dinamico produto
    POST endpoint /produtos
    POST endpoint /produtos
    Validar status code "400"
    Validar a Mensagem "Já existe produto com esse nome"

Cenario: POST Cadastrar Produto Token Invalido 401
    [tags]     POST.PRODUTO.TOKEN.INVALIDO
    Criar dados dinamico produto
    POST endpoint /produtos     ${token_invalido}
    Validar status code "401"
    Validar a Mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"

Cenario: POST Cadastrar Produto Usuario Não Administrador 403
    [tags]     POST.PRODUTO.NAO.ADM
    Criar usuario adm=false e guardar dados de login
    POST endpoint /login
    #Fazer login e armazenar token
    Criar dados dinamico produto
    POST endpoint /produtos
    Validar status code "403"
    Validar a Mensagem "Rota exclusiva para administradores"

#-------------Cenarios PUT endpoint /produtos -------------------------------------------------------------------------------------#
Cenario: PUT Editar Produto 200
    [tags]     PUT.PRODUTO
    Criar usuario_valido_api estatico login
    Fazer login e armazenar token           #NAO DA PRA USAR SEM - OPCAO RESPONSE_LOGIN
    Criar dados dinamico produto
    POST endpoint /produtos
    Criar dados dinamico produto
    PUT endpoint /produtos     ${token_auth}
    Validar status code "200"
    Validar a Mensagem "Registro alterado com sucesso"

Cenario: PUT Editar Produto Nao Cadastrado 201
    [tags]     PUT.PRODUTO.NAO.CADASTRADO
    Criar usuario_valido_api estatico login
    #POST endpoint /login
    Fazer login e armazenar token
    Criar dados dinamico produto
    PUT endpoint /produtos     ${token_auth}      ${id_invalido}
    Validar status code "201"
    Validar a Mensagem "Cadastro realizado com sucesso"

Cenario: PUT Editar Produto Nome Utilizado 400
    [tags]     PUT.PRODUTO.NOME.UTILIZADO
    Criar usuario_valido_api estatico login
    Fazer login e armazenar token
    Criar dados dinamico produto
    POST endpoint /produtos
    PUT endpoint /produtos     ${token_auth}      ${id_invalido}
    Validar status code "400"
    Validar a Mensagem "Já existe produto com esse nome"

Cenario: PUT Editar Produto Token Invalido 401
    [tags]     PUT.PRODUTO.TOKEN.INVALIDO
    Criar usuario_valido_api estatico login
    POST endpoint /login
    #Fazer login e armazenar token
    Criar dados dinamico produto
    POST endpoint /produtos
    PUT endpoint /produtos     ${token_invalido}
    Validar status code "401"
    Validar a Mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"

Cenario: PUT Editar Produto Usuario Nao Administrador 403
    [tags]     PUT.PRODUTO.NAO.ADM
    Criar usuario adm=false e guardar dados de login
    Fazer login e armazenar token
    # Criar dados dinamico produto
    # POST endpoint /produtos
    Encontrar id de um produto cadastrado
    PUT endpoint /produtos     ${token_auth}       ${id_produto}
    Validar status code "403"
    Validar a Mensagem "Rota exclusiva para administradores"

#-------------Cenarios DELETE endpoint /produtos -------------------------------------------------------------------------------------#
Cenario: DELETE Excluir Produto Existente 200
    [tags]     DELETE.PRODUTO
    Criar usuario_valido_api estatico login
    Fazer login e armazenar token
    Criar dados dinamico produto
    POST endpoint /produtos
    DELETE endpoint /produtos     ${token_auth}
    Validar status code "200"
    Validar a Mensagem "Registro excluído com sucesso"

Cenario: DELETE Excluir Produto Inexistente 200
    [tags]     DELETE.PRODUTO.INEXISTENTE
    Criar usuario_valido_api estatico login
    Fazer login e armazenar token
    DELETE endpoint /produtos     ${token_auth}     ${id_invalido}
    Validar status code "200"
    Validar a Mensagem "Nenhum registro excluído"

Cenario: DELETE Excluir Produto No Carrinho 400
    [tags]     DELETE.PRODUTO.CARRINHO
    Fazer login e adicionar carrinho
    DELETE endpoint /produtos     ${token_auth}
    Validar status code "400"
    Validar a Mensagem "Não é permitido excluir produto que faz parte de carrinho"

Cenario: DELETE Excluir Produto Token Invalido 401
    [tags]     DELETE.PRODUTO.TOKEN.INVALIDO
    Criar usuario_valido_api estatico login
    Fazer login e armazenar token
    Criar dados dinamico produto
    POST endpoint /produtos
    DELETE endpoint /produtos     ${token_invalido}
    Validar status code "401"
    Validar a Mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"

Cenario: DELETE Excluir Produto Usuario Nao Administrador 403
    [tags]     DELETE.PRODUTO.NAO.ADM
    Criar usuario adm=false e guardar dados de login
    Fazer login e armazenar token
    Encontrar id de um produto cadastrado
    DELETE endpoint /produtos     ${token_auth}       ${id_produto}
    Validar status code "403"
    Validar a Mensagem "Rota exclusiva para administradores"