* Settings *
Documentation       Keywords para ações do endpoint de produtos


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
    [Arguments]             ${token_auth}=${response_login.json()["authorization"]}
    &{header}               Create Dictionary    Authorization=${token_auth}
    ${response}             POST On Session      serverest   /produtos    json=&{payload}     headers=${header}        expected_status=any
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

PUT endpoint /produtos
    [Arguments]             ${id_produto}=${response.json()["_id"]}       ${token_auth}=${response_login.json()["authorization"]}
    &{header}               Create Dictionary    Authorization=${token_auth}
    ${response}             PUT On Session      serverest   /produtos/${id_produto}       headers=${header}     json=&{payload}     expected_status=any
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

DELETE endpoint /produtos
    [Arguments]             ${id_produto}=${response.json()["_id"]}   ${token_auth}=${response_login.json()["authorization"]}
    &{header}               Create Dictionary    Authorization=${token_auth}
    ${response}             DELETE On Session    serverest   /produtos/${id_produto}    headers=${header}        expected_status=any
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

Encontrar um id valido de produto
    GET endpoint /produtos
    ${id_produto}           Set Variable    ${response.json()["produtos"][0]["_id"]}
    Set Global Variable     ${id_produto}


# Criar ${tipo_de_produto} e armazenar id
#     Fazer login e armazenar token   usuario_valido_api
#     Gerar ${tipo_de_produto} estatico
#     POST endpoint /produtos     ${token_auth}
#     ${id_produto}           Set Variable    ${response.json()["_id"]}
#     Set Global Variable     ${id_produto}

Gerar ${tipo_de_produto} estatico
    ${json}                 Importar JSON estatico      json_produto_ex.json
    ${payload}              Set Variable       ${json["${tipo_de_produto}"]}
    Set Global Variable     ${payload}


Pegar quantidade dos produtos em estoque
    ${ids_produtos}         Create List       BeeJh5lz3k6kSIzA         K6leHdftCeOJj8BJ
    ${quantidade}           Pegar Quantidades Dos Produtos          ${ids_produtos}
    [return]     ${quantidade}

Verificar alteração na quantidade de um produto
    [Arguments]             ${quantidade_inicial}       ${quantidade_final}     @{diferença}
    ${diferença}            Create List       @{diferença}
    ${mensagem}             Verificar_Alteracao         ${quantidade_inicial}       ${quantidade_final}     ${diferença}
    Should Not Contain      ${mensagem}             erro na quantidade do estoque