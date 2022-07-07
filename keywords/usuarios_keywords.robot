* Settings *
Documentation       Keywords e Variáveis para ações do endpoint de usuarios
Resource            ../support/base.robot


* Keywords *
GET endpoint /usuarios
    ${response}             GET On Session        serverest         /usuarios
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

GET endpoint /usuarios especifico 
    [Arguments]             ${id_usuario}=${response.json()["_id"]}
    ${response}             GET On Session        serverest         /usuarios/${id_usuario}      expected_status=any
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

POST endpoint /usuarios
    ${response}             POST On Session       serverest         /usuarios      json=&{payload}      expected_status=any
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

PUT endpoint /usuarios
    [Arguments]             ${id_usuario}=${response.json()["_id"]}
    ${response}             PUT On Session        serverest         /usuarios/${id_usuario}      json=&{payload}      expected_status=any
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

DELETE endpoint /usuarios
    [Arguments]             ${id_usuario}=${response.json()["_id"]}
    ${response}             DELETE On Session     serverest         /usuarios/${id_usuario}      expected_status=any
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}