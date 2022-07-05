* Settings *
Documentation       Keywords e Variáveis para ações do endpoint de usuarios
Library             FakerLibrary


* Keywords *
GET endpoint /usuarios
    ${response}             GET On Session      serverest   /usuarios
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

GET endpoint /usuarios especifico 
    [Arguments]             ${id_usuario}
    ${response}             GET On Session     serverest   /usuarios/${id_usuario}     expected_status=any
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

PUT endpoint /usuarios/${id_usuario}
    ${response}             PUT On Session      serverest   /usuarios/${id_usuario}   json=&{payload}     expected_status=any
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

POST endpoint /usuarios
    ${response}             POST On Session      serverest   /usuarios   json=&{payload}     expected_status=any
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

DELETE endpoint /usuarios/${id}
    ${response}             DELETE On Session      serverest   /usuarios/${id}      expected_status=any
    Log to Console          Response: ${response.content}
    Set Global Variable     ${response}

Criar ${tipo_de_usuario} estatico
    ${json}                 Importar JSON estatico      json_usuario_ex.json
    ${payload}              Set Variable       ${json["${tipo_de_usuario}"]}
    Set Global Variable     ${payload}

Cadastrar ${tipo_de_usuario} e armazenar id
    Criar ${tipo_de_usuario} estatico
    POST endpoint /usuarios
    ${id_usuario}           Set Variable    ${response.json()["_id"]}
    Set Global Variable     ${id_usuario}

Fazer login com id e adicionar carrinho
    GET endpoint /usuarios especifico   ${id_usuario}
    ${email_do_usuario}     Set Variable     ${response.json()["email"]}
    ${senha_do_usuario}     Set Variable     ${response.json()["password"]}
    &{payload}              Create Dictionary   email=${email_do_usuario}   password=${senha_do_usuario}
    Set Global Variable     &{payload}
    POST endpoint /login
    ${token_auth}           Set Variable    ${response.json()["authorization"]}
    Set Global Variable     ${token_auth}
    Adicionar um produto no carrinho
    POST endpoint /carrinhos     ${token_auth}

Validar ter criado usuario
    Should Be Equal         ${response.json()["message"]}       Cadastro realizado com sucesso
    Should Not Be Empty     ${response.json()["_id"]}




Criar novo usuario
    ${nome_do_usuario}             FakerLibrary.Name
    ${email_do_usuario}            FakerLibrary.Email
    ${senha_do_usuario}            FakerLibrary.Password
    ${data}                        Create Dictionary   nome=${nome_do_usuario}   email=${email_do_usuario}  password=${senha_do_usuario}    administrador=true
    [return]                       ${data}

