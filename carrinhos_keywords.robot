* Settings *
Documentation       Keywords e Variáveis para ações do endpoint de carrinhos
Library	            JSONLibrary


* Variables *
${quantidade}       1


* Keywords *
GET endpoint /carrinhos
    ${response}             GET On Session      serverest   /carrinhos
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

GET endpoint /carrinhos/${id_carrinho}
    ${response}             GET On Session      serverest   /carrinhos/${id_carrinho}
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

POST endpoint /carrinhos
    [Arguments]             ${token_auth}
    &{header}               Create Dictionary    Authorization=${token_auth}
    ${response}             POST On Session      serverest   /carrinhos    json=&{json}     headers=${header}        expected_status=any
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

DELETE endpoint /carrinhos
    [Arguments]             ${tipo_compra}   ${token_auth}
    &{header}               Create Dictionary    Authorization=${token_auth}
    ${response}             DELETE On Session      serverest   /carrinhos/${tipo_compra}      headers=${header}        expected_status=any
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

Adicionar um produto no carrinho
    Encontrar id de um produto cadastrado
    #${json}=                Convert String to JSON    {"produtos": []}
    #${payload}              Create Dictionary   idProduto=${id_produto}   quantidade=${quantidade}
    #${json} =	            Add Object To Json	        ${json}	    $..produtos	    ${payload}
    ${json}                 Importar JSON estatico      json_carrinho_ex.json
    Set Global Variable     ${json}
    ${id_carrinho}          Set Variable    ${json["produtos"][0]["idProduto"]}
    Set Global Variable     ${id_carrinho}


Fazer login e adicionar carrinho
    Fazer login e armazenar token   usuario_valido_api
    Adicionar um produto no carrinho
    POST endpoint /carrinhos     ${token_auth}

Listar carrinhos e pegar um id valido
    GET endpoint /carrinhos
    ${id_carrinho}          Set Variable    ${response.json()["carrinhos"][0]["_id"]}
    Set Global Variable     ${id_carrinho}