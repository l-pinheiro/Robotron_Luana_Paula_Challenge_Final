* Settings *
Documentation       Keywords e Variáveis para ações do endpoint de login


* Keywords *
POST endpoint /login
    ${response}             POST On Session     serverest   /login    json=&{payload}        expected_status=any
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

Fazer login e armazenar token
    [Arguments]             ${usuario_adm}
    Criar ${usuario_adm} estatico login
    POST endpoint /login
    ${token_auth}           Set Variable    ${response.json()["authorization"]}
    Set Global Variable     ${token_auth}

Criar ${tipo_de_usuario} estatico login
    ${json}                 Importar JSON estatico      json_login_ex.json
    ${payload}              Set Variable       ${json["${tipo_de_usuario}"]}
    Set Global Variable     ${payload}

Validar ter logado
    Should Be Equal         ${response.json()["message"]}   Login realizado com sucesso
    Should Not Be Empty     ${response.json()["authorization"]}