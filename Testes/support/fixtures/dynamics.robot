* Settings *
Documentation       Keywords para geração de dados dinamicos

* Keywords *
Criar dados dinamico usuario
    [Arguments]                    ${campo}=valido                  ${adm}=true
    ${payload}                     Criar usuario dinamico           ${campo}            ${adm}
    Set Global Variable            ${payload}

Criar dados dinamico produto
    ${nome_do_produto}             FakerLibrary.Text                max_nb_chars=10
    ${preco_do_produto}            FakerLibrary.Random Number       digits=3
    ${descricao_do_produto}        FakerLibrary.Text                max_nb_chars=10
    ${quantidade_do_produto}       FakerLibrary.Random Number       digits=2
    ${payload}                     Create Dictionary                nome=${nome_do_produto}   preco=${preco_do_produto}  descricao=${descricao_do_produto}    quantidade=${quantidade_do_produto}
    Set Global Variable            ${payload}