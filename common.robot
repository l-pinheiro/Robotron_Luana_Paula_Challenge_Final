* Settings *
Documentation       Keywords e Variáveis para ações gerais
Library             OperatingSystem


* Variables *
${id_invalido}          IdInvalido123
${token_invalido}       tokeninvalido123


* Keywords *
Validar status code "${statuscode}"
    Should Be True          ${response.status_code} == ${statuscode}

Importar JSON estatico
    [Arguments]             ${nome_arquivo}
    ${arquivo}              Get File    ${EXECDIR}/${nome_arquivo}
    ${data}                 Evaluate    json.loads('''${arquivo}''')        json
    [return]                ${data}

Validar a mensagem "${mensagem}"
    Should Be Equal         ${response.json()["message"]}   ${mensagem}

Validar no campo a mensagem
    [Arguments]             ${campo}    ${mensagem}
    Should Be Equal         ${response.json()["${campo}"]}   ${mensagem}