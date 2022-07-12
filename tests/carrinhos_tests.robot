* Settings *
Documentation       Arquivo de testes para o endpoint /carrinhos
Resource            ../support/base.robot
Suite Setup         Criar Sessao

* Test Cases *
#-------------Cenarios GET endpoint /carrinhos -------------------------------------------------------------------------------------#
Cenario: GET Listar Todos Carrinhos 200
    [tags]     GET                  GET.CARRINHOS
    GET endpoint /carrinhos
    Validar status code "200"

Cenario: GET Carrinho Especifico 200
    [tags]     GET                  GET.CARRINHO
    Listar carrinhos e pegar um id valido
    GET endpoint /carrinhos especifico
    Validar status code "200"

Cenario: GET Carrinho ID Invalido 400
    [tags]     GET                  GET.CARRINHO.ID.INVALIDO
    GET endpoint /carrinhos especifico      ${id_invalido}
    Validar status code "400"
    Validar a Mensagem "Carrinho não encontrado"

#-------------Cenarios POST endpoint /carrinhos -------------------------------------------------------------------------------------#
Cenario: POST Cadastrar Carrinho 200
    [tags]     POST                 POST.CARRINHO
    Criar usuario adm=true e guardar dados de login
    POST endpoint /login
    ${quant_inicial}   Pegar quantidade dos produtos em estoque
    Criar carrinho_valido estatico
    POST endpoint /carrinhos
    ${quant_final}     Pegar quantidade dos produtos em estoque
    Verificar alteração na quantidade de um produto     ${quant_inicial}        ${quant_final}       -5       -10
    Validar status code "201"
    Validar a Mensagem "Cadastro realizado com sucesso"

Cenario: POST Cadastrar Carrinho Com Produto Duplicado 400
    [tags]     POST                 POST.CARRINHO.PRODUTO.DUPLICADO
    Criar usuario adm=true e guardar dados de login
    POST endpoint /login
    Criar carrinho_produto_duplicado estatico
    POST endpoint /carrinhos
    Validar status code "400"
    Validar a Mensagem "Não é permitido possuir produto duplicado"

Cenario: POST Cadastrar Mais de Um Carrinho 400
    [tags]     POST                 POST.CARRINHO.MAIS.UM
    Criar usuario adm=true e guardar dados de login
    POST endpoint /login
    Criar carrinho_valido estatico
    POST endpoint /carrinhos
    POST endpoint /carrinhos
    Validar status code "400"
    Validar a Mensagem "Não é permitido ter mais de 1 carrinho"

Cenario: POST Cadastrar Carrinho Com Produto Invalido 400
    [tags]     POST                 POST.CARRINHO.PRODUTO.INVALIDO
    Criar usuario adm=true e guardar dados de login
    POST endpoint /login
    Criar carrinho_invalido estatico
    POST endpoint /carrinhos
    Validar status code "400"
    Validar a Mensagem "Produto não encontrado"

Cenario: POST Cadastrar Carrinho Com Produto Insuficiente 400
    [tags]     POST                 POST.CARRINHO.QUANTIDADE.INSUFICIENTE
    Criar usuario adm=true e guardar dados de login
    POST endpoint /login
    Criar carrinho_quantidade_insuficiente estatico
    POST endpoint /carrinhos
    Validar status code "400"
    Validar a Mensagem "Produto não possui quantidade suficiente"

Cenario: POST Cadastrar Carrinho Token Invalido 401
    [tags]     POST                 POST.CARRINHO.TOKEN.INVALIDO
    Criar carrinho_valido estatico
    POST endpoint /carrinhos     ${token_invalido}
    Validar status code "401"
    Validar a Mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"

#-------------Cenarios DELETE endpoint /carrinhos -------------------------------------------------------------------------------------#
Cenario: DELETE Excluir Carrinho Concluir Compra Com Carrinho 200
    [tags]     DELETE               DELETE.COM.CARRINHO.CONCLUIR
    Criar usuario adm=true e guardar dados de login
    POST endpoint /login
    ${quant_inicial}   Pegar quantidade dos produtos em estoque
    Criar carrinho_valido estatico
    POST endpoint /carrinhos
    DELETE endpoint /carrinhos      concluir-compra
    ${quant_final}     Pegar quantidade dos produtos em estoque
    Verificar alteração na quantidade de um produto     ${quant_inicial}   ${quant_final}       -5       -10
    Validar status code "200"
    Validar a Mensagem "Registro excluído com sucesso"

Cenario: DELETE Excluir Carrinho Concluir Compra Sem Carrinho 200
    [tags]     DELETE               DELETE.SEM.CARRINHO.CONCLUIR
    Criar usuario adm=true e guardar dados de login
    POST endpoint /login
    DELETE endpoint /carrinhos      concluir-compra
    Validar status code "200"
    Validar a Mensagem "Não foi encontrado carrinho para esse usuário"

Cenario: DELETE Excluir Carrinho Concluir Compra Token Invalido 401
    [tags]     DELETE               DELETE.CARRINHO.CONCLUIR.TOKEN
    Criar carrinho_valido estatico
    DELETE endpoint /carrinhos      concluir-compra    ${token_invalido}
    Validar status code "401"
    Validar a Mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"

# Falha - documentação informa "Registro excluído com sucesso." mas o retorno é "Registro excluído com sucesso. Estoque dos produtos reabastecido"
Cenario: DELETE Excluir Carrinho Cancelar Compra Com Carrinho 200
    [tags]     DELETE               DELETE.COM.CARRINHO.CANCELAR
    Criar usuario adm=true e guardar dados de login
    POST endpoint /login
    Criar carrinho_valido estatico
    POST endpoint /carrinhos
    ${quant_inicial}   Pegar quantidade dos produtos em estoque
    DELETE endpoint /carrinhos      cancelar-compra
    ${quant_final}     Pegar quantidade dos produtos em estoque
    Verificar alteração na quantidade de um produto     ${quant_inicial}   ${quant_final}       5       10
    Validar status code "200"
    Validar a Mensagem "Registro excluído com sucesso."

Cenario: DELETE Excluir Carrinho Cancelar Compra Sem Carrinho 200
    [tags]     DELETE               DELETE.SEM.CARRINHO.CANCELAR
    Criar usuario adm=true e guardar dados de login
    POST endpoint /login
    DELETE endpoint /carrinhos      cancelar-compra
    Validar status code "200"
    Validar a Mensagem "Não foi encontrado carrinho para esse usuário"

Cenario: DELETE Excluir Carrinho Cancelar Compra Token Invalido 401
    [tags]     DELETE               DELETE.CARRINHO.CANCELAR.TOKEN
    Criar carrinho_valido estatico
    DELETE endpoint /carrinhos      cancelar-compra    ${token_invalido}
    Validar status code "401"
    Validar a Mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"











