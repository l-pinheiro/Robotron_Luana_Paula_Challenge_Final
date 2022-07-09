* Settings *
Documentation       Keywords para ações gerais
Library             OperatingSystem
Library             RequestsLibrary
Library             Collections


* Keywords *
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

# Validar retorno do GET
#     Log to Console          ${response.json()}
#     Should Not Be Empty     ${response.json()}