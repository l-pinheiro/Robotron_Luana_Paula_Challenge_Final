* Settings *
Documentation       Arquivo base de importações das bibliotecas e recursos necessários para os testes

Library             OperatingSystem
Library             RequestsLibrary
Library             Collections
Library             FakerLibrary

Library             ./python_functions/python_functions.py

Resource            ./common/common.robot
Resource            ./fixtures/dynamics.robot
Resource            ./variables/serverest_variables.robot
Resource            ../keywords/usuarios_keywords.robot
Resource            ../keywords/login_keywords.robot
Resource            ../keywords/produtos_keywords.robot
Resource            ../keywords/carrinhos_keywords.robot