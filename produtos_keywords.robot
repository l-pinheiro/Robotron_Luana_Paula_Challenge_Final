* Settings *
Documentation       Keywords e Variáveis para ações do endpoint de produtos

* Keywords *
GET endpoint /produtos
    ${response}             GET On Session      serverest   /produtos
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

GET endpoint /produtos especifico
    [Arguments]             ${id_produto}
    ${response}             GET On Session      serverest   /produtos/${id_produto}        expected_status=any
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

POST endpoint /produtos
    [Arguments]             ${token_auth}
    &{header}               Create Dictionary    Authorization=${token_auth}
    ${response}             POST On Session      serverest   /produtos    json=&{payload}     headers=${header}        expected_status=any
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

PUT endpoint /produtos
    [Arguments]             ${token_auth}       ${id_produto}=${id_produto}        
    &{header}               Create Dictionary    Authorization=${token_auth}
    ${response}             PUT On Session      serverest   /produtos/${id_produto}       headers=${header}     json=&{payload}     expected_status=any
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

DELETE endpoint /produtos
    [Arguments]             ${token_auth}
    &{header}               Create Dictionary    Authorization=${token_auth}
    ${response}             DELETE On Session    serverest   /produtos/${id_produto}    headers=${header}        expected_status=any
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

Encontrar id de um produto cadastrado
    GET endpoint /produtos
    ${id_produto}           Set Variable    ${response.json()["produtos"][0]["_id"]}
    Set Global Variable     ${id_produto}

Validar ter criado produto
    Should Be Equal         ${response.json()["message"]}       Cadastro realizado com sucesso
    Should Not Be Empty     ${response.json()["_id"]}

Criar ${tipo_de_produto} e armazenar id
    Fazer login e armazenar token   usuario_valido_api
    Gerar ${tipo_de_produto} estatico
    POST endpoint /produtos     ${token_auth}
    ${id_produto}           Set Variable    ${response.json()["_id"]}
    Set Global Variable     ${id_produto}

Gerar ${tipo_de_produto} estatico
    ${json}                 Importar JSON estatico      json_produto_ex.json
    ${payload}              Set Variable       ${json["${tipo_de_produto}"]}
    Set Global Variable     ${payload}