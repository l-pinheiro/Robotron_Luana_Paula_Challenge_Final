* Settings *
Documentation       Keywords para ações gerais e comuns aos endpoints


* Keywords *
Criar Sessao
    Create Session          serverest           ${Base_URI}

Validar status code "${statuscode}"
    Should Be True          ${response.status_code} == ${statuscode}

Importar JSON estatico
    [Arguments]             ${nome_arquivo}
    ${arquivo}              Get File    ${EXECDIR}/support/fixtures/static/${nome_arquivo}
    ${data}                 Evaluate    json.loads('''${arquivo}''')        json
    [return]                ${data}

Validar a mensagem "${mensagem}"
    Should Be Equal         ${response.json()["message"]}   ${mensagem}

Validar a mensagem no campo
    [Arguments]             ${mensagem}     ${campo}=message    ${nome_response}=response
    Should Be Equal         ${${nome_response}.json()["${campo}"]}   ${mensagem}

Validar retorno no campo
    [Arguments]       @{campos}     
    @{campos}            Create List       @{campos}
    FOR    ${campo}    IN    @{campos}
        Should Not Be Empty          ${response.json()["${campo}"]}
    END

Alterar valor de um campo no dicionario    
    [Arguments]            ${campo}    ${valor}    
    Set to Dictionary      ${payload}    ${campo}=${valor}
    Set Global Variable            &{payload}