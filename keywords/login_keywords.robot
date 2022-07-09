* Settings *
Documentation       Keywords para ações do endpoint de login
Library             library_teste.py
Resource            ../support/base.robot


* Keywords *
POST endpoint /login
    ${response_login}       POST On Session     serverest   /login    json=&{payload}        expected_status=any
    Log to Console          Response: ${response_login.content}
    Set Global Variable     ${response_login}

# Fazer login e armazenar token
#     POST endpoint /login
#     ${token_auth}           Set Variable    ${response.json()["authorization"]}
#     Set Global Variable     ${token_auth}

Criar ${tipo_de_usuario} estatico login
    ${json}                 Importar JSON estatico      json_login_ex.json
    ${payload}              Set Variable       ${json["${tipo_de_usuario}"]}
    Set Global Variable     ${payload}

Criar usuario adm=${tipo_de_usuario} e guardar dados de login
    Criar dados dinamico usuario    adm=${tipo_de_usuario}
    POST endpoint /usuarios
    ${id_usuario}           Set Variable          ${response.json()["_id"]}
    Set Global Variable     ${id_usuario}
    ${payload}              Pegar Dados Login Usuario      ${id_usuario}
    Set Global Variable     ${payload}

Validar status code de login "${statuscode}"
    Should Be True          ${response_login.status_code} == ${statuscode}

