* Settings *
Documentation       Arquivo de testes para o endpoint /produtos
Resource            ../support/base.robot
Suite Setup         Criar Sessao


* Test Cases *
#-------------Cenarios GET endpoint /produtos -------------------------------------------------------------------------------------#
Cenario: GET Todos os Produtos 200
    [tags]      GET                 GET.PRODUTOS
    GET endpoint /produtos
    Validar status code "200"

Cenario: GET Produto Especifico 200
    [tags]     GET                  GET.PRODUTO
    Encontrar um id valido de produto
    GET endpoint /produtos especifico   ${id_produto}
    Validar status code "200"

Cenario: GET Produto Especifico ID Invalido 400
    [tags]     GET                  GET.PRODUTO.ID.INVALIDO
    GET endpoint /produtos especifico   ${id_invalido}
    Validar status code "400"
    Validar a Mensagem "Produto não encontrado"

#-------------Cenarios POST endpoint /produtos -------------------------------------------------------------------------------------#
Cenario: POST Cadastrar Produto 201
    [tags]     POST                 POST.PRODUTO
    Criar usuario_valido_api estatico login
    POST endpoint /login
    Criar dados dinamico produto
    POST endpoint /produtos
    Validar status code "201"
    Validar a Mensagem "Cadastro realizado com sucesso"

Cenario: POST Cadastrar Produto Nome Utilizado 400
    [tags]     POST                 POST.PRODUTO.NOME.UTILIZADO
    Criar usuario_valido_api estatico login
    POST endpoint /login
    Criar dados dinamico produto
    POST endpoint /produtos
    POST endpoint /produtos
    Validar status code "400"
    Validar a Mensagem "Já existe produto com esse nome"

Cenario: POST Cadastrar Produto Token Invalido 401
    [tags]     POST                 POST.PRODUTO.TOKEN.INVALIDO
    Criar dados dinamico produto
    POST endpoint /produtos         ${token_invalido}
    Validar status code "401"
    Validar a Mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"

Cenario: POST Cadastrar Produto Usuario Não Administrador 403
    [tags]     POST                 POST.PRODUTO.NAO.ADM
    Criar usuario adm=false e guardar dados de login
    POST endpoint /login
    Criar dados dinamico produto
    POST endpoint /produtos
    Validar status code "403"
    Validar a Mensagem "Rota exclusiva para administradores"

#-------------Cenarios PUT endpoint /produtos -------------------------------------------------------------------------------------#
Cenario: PUT Editar Produto 200
    [tags]     PUT                  PUT.PRODUTO
    Criar usuario_valido_api estatico login
    POST endpoint /login
    Encontrar um id valido de produto
    Criar dados dinamico produto
    PUT endpoint /produtos          ${id_produto}
    Validar status code "200"
    Validar a Mensagem "Registro alterado com sucesso"

Cenario: PUT Editar Produto Nao Cadastrado 201
    [tags]     PUT                  PUT.PRODUTO.NAO.CADASTRADO
    Criar usuario_valido_api estatico login
    POST endpoint /login
    Criar dados dinamico produto
    PUT endpoint /produtos          ${id_invalido}
    Validar status code "201"
    Validar a Mensagem "Cadastro realizado com sucesso"

Cenario: PUT Editar Produto Nome Utilizado 400
    [tags]     PUT                  PUT.PRODUTO.NOME.UTILIZADO
    Criar usuario_valido_api estatico login
    POST endpoint /login
    Criar dados dinamico produto
    POST endpoint /produtos
    PUT endpoint /produtos          ${id_invalido}
    Validar status code "400"
    Validar a Mensagem "Já existe produto com esse nome"

Cenario: PUT Editar Produto Token Invalido 401
    [tags]     PUT                  PUT.PRODUTO.TOKEN.INVALIDO
    Criar usuario_valido_api estatico login
    POST endpoint /login
    Encontrar um id valido de produto
    Criar dados dinamico produto
    PUT endpoint /produtos          ${id_produto}           ${token_invalido}
    Validar status code "401"
    Validar a Mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"

Cenario: PUT Editar Produto Usuario Nao Administrador 403
    [tags]     PUT                  PUT.PRODUTO.NAO.ADM
    Criar usuario adm=false e guardar dados de login
    POST endpoint /login
    Encontrar um id valido de produto
    Criar dados dinamico produto
    PUT endpoint /produtos          ${id_produto}
    Validar status code "403"
    Validar a Mensagem "Rota exclusiva para administradores"

#-------------Cenarios DELETE endpoint /produtos -------------------------------------------------------------------------------------#
Cenario: DELETE Excluir Produto Existente 200
    [tags]     DELETE               DELETE.PRODUTO
    Criar usuario_valido_api estatico login
    POST endpoint /login
    Criar dados dinamico produto
    POST endpoint /produtos
    DELETE endpoint /produtos
    Validar status code "200"
    Validar a Mensagem "Registro excluído com sucesso"

Cenario: DELETE Excluir Produto Inexistente 200
    [tags]     DELETE               DELETE.PRODUTO.INEXISTENTE
    Criar usuario_valido_api estatico login
    POST endpoint /login
    DELETE endpoint /produtos       ${id_invalido}
    Validar status code "200"
    Validar a Mensagem "Nenhum registro excluído"

Cenario: DELETE Excluir Produto No Carrinho 400
    [tags]     DELETE               DELETE.PRODUTO.CARRINHO
    Criar usuario adm=true e guardar dados de login
    POST endpoint /login
    Criar carrinho_valido estatico
    POST endpoint /carrinhos
    DELETE endpoint /produtos       BeeJh5lz3k6kSIzA
    Validar status code "400"
    Validar a Mensagem "Não é permitido excluir produto que faz parte de carrinho"

Cenario: DELETE Excluir Produto Token Invalido 401
    [tags]     DELETE               DELETE.PRODUTO.TOKEN.INVALIDO
    Criar usuario_valido_api estatico login
    POST endpoint /login
    Encontrar um id valido de produto
    DELETE endpoint /produtos       ${id_produto}           ${token_invalido}
    Validar status code "401"
    Validar a Mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"

Cenario: DELETE Excluir Produto Usuario Nao Administrador 403
    [tags]     DELETE               DELETE.PRODUTO.NAO.ADM
    Criar usuario adm=false e guardar dados de login
    POST endpoint /login
    Encontrar um id valido de produto
    DELETE endpoint /produtos       ${id_produto}
    Validar status code "403"
    Validar a Mensagem "Rota exclusiva para administradores"