* Settings *
Documentation       Keywords e Variáveis para ações do endpoint de carrinhos
Resource            ../support/base.robot


* Keywords *
GET endpoint /carrinhos
    ${response}             GET On Session      serverest   /carrinhos
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

GET endpoint /carrinhos especifico
    [Arguments]             ${id_carrinho}=${id_carrinho}
    ${response}             GET On Session      serverest   /carrinhos/${id_carrinho}
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

POST endpoint /carrinhos
    [Arguments]             ${token_auth}=${response_login.json()["authorization"]}
    &{header}               Create Dictionary    Authorization=${token_auth}
    ${response}             POST On Session      serverest   /carrinhos    json=&{payload}     headers=${header}        expected_status=any
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

DELETE endpoint /carrinhos
    [Arguments]             ${tipo_compra}   ${token_auth}=${response_login.json()["authorization"]}
    &{header}               Create Dictionary    Authorization=${token_auth}
    ${response}             DELETE On Session      serverest   /carrinhos/${tipo_compra}      headers=${header}        expected_status=any
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

Criar ${tipo_carrinho} estatico
    ${json}                 Importar JSON estatico      json_carrinho_ex.json
    ${payload}              Set Variable    ${json["${tipo_carrinho}"]}
    Set Global Variable     ${payload}

# Fazer login e adicionar carrinho
#     Fazer login e armazenar token   usuario_valido_api
#     Adicionar um produto no carrinho
#     POST endpoint /carrinhos     ${token_auth}

Listar carrinhos e pegar um id valido
    GET endpoint /carrinhos
    ${id_carrinho}          Set Variable            ${response.json()["carrinhos"][0]["_id"]}
    Set Global Variable     ${id_carrinho}