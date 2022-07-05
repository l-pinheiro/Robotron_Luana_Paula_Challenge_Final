* Settings *
Documentation       Keywords e Variáveis para geração de dados dinamicos
Library             FakerLibrary


* Keywords *
# Criar dados dinamico usuario valido adm=${tipo_de_usuario}
#     ${nome_do_usuario}             FakerLibrary.Name
#     ${email_do_usuario}            FakerLibrary.Email
#     ${senha_do_usuario}            FakerLibrary.Password
#     ${payload}                     Create Dictionary   nome=${nome_do_usuario}   email=${email_do_usuario}  password=${senha_do_usuario}    administrador=${tipo_de_usuario}
#     Set Global Variable            ${payload}

Criar dados dinamico usuario
    [Arguments]                    ${campo}=valido    ${adm}=true
    ${payload}                     Criar usuario dinamico        ${campo}    ${adm}
    Log to Console                 ${payload}
    Set Global Variable            ${payload}

Criar dados dinamico produto
    ${nome_do_produto}             FakerLibrary.Text                max_nb_chars=10
    ${preco_do_produto}            FakerLibrary.Random Number       digits=3
    ${descricao_do_produto}        FakerLibrary.Text                max_nb_chars=10
    ${quantidade_do_produto}       FakerLibrary.Random Number       digits=2
    ${payload}                     Create Dictionary   nome=${nome_do_produto}   preco=${preco_do_produto}  descricao=${descricao_do_produto}    quantidade=${quantidade_do_produto}
    Set Global Variable            ${payload}