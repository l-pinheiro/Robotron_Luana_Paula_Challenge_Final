* Settings *
Documentation       Arquivo simples para requisições HTTP em APIs Rest
Resource            ./common/common.robot
Resource            ./fixtures/dynamics.robot
Resource            ./variables/serverest_variables.robot

Resource            ../keywords/usuarios_keywords.robot
Resource            ../keywords/login_keywords.robot
Resource            ../keywords/produtos_keywords.robot
Resource            ../keywords/carrinhos_keywords.robot


* Keywords *
Criar Sessao
    Create Session          serverest           ${Base_URI}