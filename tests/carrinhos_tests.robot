* Settings *
Documentation       Arquivo de testes para o endpoint /carrinhos
Resource            ../support/base.robot
Suite Setup         Criar Sessao

* Test Cases *
#-------------Cenarios GET endpoint /carrinhos -------------------------------------------------------------------------------------#
Cenario: GET Listar Todos Carrinhos 200
    [tags]     GET.CARRINHOS
    GET endpoint /carrinhos
    Validar status code "200"

Cenario: GET Carrinho Especifico 200
    [tags]     GET.CARRINHO
    Listar carrinhos e pegar um id valido
    GET endpoint /carrinhos especifico
    Validar status code "200"

Cenario: GET Carrinho ID Invalido 400
    [tags]     GET.CARRINHO.ID.INVALIDO
    GET endpoint /carrinhos especifico      ${id_invalido}
    Validar status code "400"
    Validar a Mensagem "Carrinho não encontrado"

#-------------Cenarios POST endpoint /carrinhos -------------------------------------------------------------------------------------#
Cenario: POST Cadastrar Carrinho 200
    [tags]     POST.CARRINHO
    Criar usuario adm=true e guardar dados de login
    Fazer login e armazenar token
    Criar carrinho_valido estatico
    POST endpoint /carrinhos     ${token_auth}
    Validar status code "201"
    Validar a Mensagem "Cadastro realizado com sucesso"

Cenario: POST Cadastrar Carrinho Com Produto Duplicado 400
    [tags]     POST.CARRINHO.PRODUTO.DUPLICADO
    Criar usuario adm=true e guardar dados de login
    Fazer login e armazenar token
    Criar carrinho_produto_duplicado estatico
    POST endpoint /carrinhos     ${token_auth}
    Validar status code "400"
    Validar a Mensagem "Não é permitido possuir produto duplicado"

Cenario: POST Cadastrar Mais de Um Carrinho 400
    [tags]     POST.CARRINHO.MAIS.UM
    Criar usuario adm=true e guardar dados de login
    Fazer login e armazenar token
    Criar carrinho_valido estatico
    POST endpoint /carrinhos     ${token_auth}
    POST endpoint /carrinhos     ${token_auth}
    Validar status code "400"
    Validar a Mensagem "Não é permitido ter mais de 1 carrinho"

Cenario: POST Cadastrar Carrinho Com Produto Invalido 400
    [tags]     POST.CARRINHO.PRODUTO.INVALIDO
    Criar usuario adm=true e guardar dados de login
    Fazer login e armazenar token
    Criar carrinho_invalido estatico
    POST endpoint /carrinhos     ${token_auth}
    Validar status code "400"
    Validar a Mensagem "Produto não encontrado"

Cenario: POST Cadastrar Carrinho Com Produto Insuficiente 400
    [tags]     POST.CARRINHO.QUANTIDADE.INSUFICIENTE
    Criar usuario adm=true e guardar dados de login
    Fazer login e armazenar token
    Criar carrinho_quantidade_insuficiente estatico
    POST endpoint /carrinhos     ${token_auth}
    Validar status code "400"
    Validar a Mensagem "Produto não possui quantidade suficiente"

Cenario: POST Cadastrar Carrinho Token Invalido 401
    [tags]     POST.CARRINHO.TOKEN.INVALIDO
    Criar carrinho_valido estatico
    POST endpoint /carrinhos     ${token_invalido}
    Validar status code "401"
    Validar a Mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"

#-------------Cenarios DELETE endpoint /carrinhos -------------------------------------------------------------------------------------#
Cenario: DELETE Excluir Carrinho Concluir Compra Com Carrinho 200
    [tags]     DELETE.COM.CARRINHO.CONCLUIR
    Criar usuario adm=true e guardar dados de login
    Fazer login e armazenar token
    Criar carrinho_valido estatico
    POST endpoint /carrinhos     ${token_auth}
    DELETE endpoint /carrinhos      concluir-compra    ${token_auth}
    Validar status code "200"
    Validar a Mensagem "Registro excluído com sucesso"

Cenario: DELETE Excluir Carrinho Concluir Compra Sem Carrinho 200
    [tags]     DELETE.SEM.CARRINHO.CONCLUIR
    Criar usuario adm=true e guardar dados de login
    Fazer login e armazenar token
    DELETE endpoint /carrinhos      concluir-compra    ${token_auth}
    Validar status code "200"
    Validar a Mensagem "Não foi encontrado carrinho para esse usuário"

Cenario: DELETE Excluir Carrinho Concluir Compra Token Invalido 401
    [tags]     DELETE.CARRINHO.CONCLUIR.TOKEN
    Criar carrinho_valido estatico
    DELETE endpoint /carrinhos      concluir-compra    ${token_invalido}
    Validar status code "401"
    Validar a Mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"

Cenario: DELETE Excluir Carrinho Cancelar Compra Com Carrinho 200
    [tags]     DELETE.COM.CARRINHO.CANCELAR
    Criar usuario adm=true e guardar dados de login
    Fazer login e armazenar token
    Criar carrinho_valido estatico
    POST endpoint /carrinhos     ${token_auth}
    DELETE endpoint /carrinhos      cancelar-compra    ${token_auth}
    Validar status code "200"
    Validar a Mensagem "Registro excluído com sucesso. Estoque dos produtos reabastecido"

Cenario: DELETE Excluir Carrinho Cancelar Compra Sem Carrinho 200
    [tags]     DELETE.SEM.CARRINHO.CANCELAR
    Criar usuario adm=true e guardar dados de login
    Fazer login e armazenar token
    DELETE endpoint /carrinhos      cancelar-compra    ${token_auth}
    Validar status code "200"
    Validar a Mensagem "Não foi encontrado carrinho para esse usuário"

Cenario: DELETE Excluir Carrinho Cancelar Compra Token Invalido 401
    [tags]     DELETE.CARRINHO.CANCELAR.TOKEN
    Criar carrinho_valido estatico
    DELETE endpoint /carrinhos      cancelar-compra    ${token_invalido}
    Validar status code "401"
    Validar a Mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"