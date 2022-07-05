* Settings *
Documentation       Arquivo simples para requisições HTTP em APIs Rest
Library             RequestsLibrary
Resource            ./usuarios_keywords.robot
Resource            ./login_keywords.robot
Resource            ./produtos_keywords.robot
Resource            ./carrinhos_keywords.robot
Resource            ./common.robot


* Test Cases *
#-------------Cenarios GET endpoint /usuarios -------------------------------------------------------------------------------------#
Cenario: GET Todos os Usuarios 200
    [tags]      GET.USUARIOS                    USUARIOS
    Criar Sessao
    GET endpoint /usuarios
    Validar status code "200"

Cenario: GET Usuario Especifico 200
    [tags]     GET.USUARIO                      USUARIOS
    Criar Sessao
    Cadastrar usuario_valido1_adm e armazenar id
    GET endpoint /usuarios especifico   ${id_usuario}
    Validar status code "200"

Cenario: GET Usuario Especifico ID Invalido 400
    [tags]     GET.USUARIO.ERRO                 USUARIOS
    Criar Sessao
    GET endpoint /usuarios especifico   ${id_invalido}
    Validar status code "400"
    Validar a Mensagem "Usuário não encontrado"

#-------------Cenarios POST endpoint /usuarios -------------------------------------------------------------------------------------#
Cenario: POST Cadastrar Usuario 201
    [tags]     POST.USUARIO                     USUARIOS
    Criar Sessao
    Criar usuario_valido_nao_adm estatico   #usuario_valido2_adm
    POST endpoint /usuarios
    Validar status code "201"
    Validar a Mensagem "Cadastro realizado com sucesso"

Cenario: POST Cadastrar Usuario Email Utilizado 400
    [tags]     POST.USUARIO.ERRO                USUARIOS
    Criar Sessao
    Cadastrar usuario_cadastro_email_igual e armazenar id
    POST endpoint /usuarios
    Validar status code "400"
    Validar a Mensagem "Este email já está sendo usado"

#-------------Cenarios PUT endpoint /usuarios -------------------------------------------------------------------------------------#
Cenario: PUT Editar Usuario 200
    [tags]     PUT.USUARIO                      USUARIOS
    Criar Sessao
    Cadastrar usuario_valido3_adm e armazenar id
    Criar usuario_valido3_editado estatico
    PUT endpoint /usuarios/${id_usuario}
    Validar status code "200"
    Validar a Mensagem "Registro alterado com sucesso"

Cenario: PUT Editar Usuario Nao Cadastrado 201
    [tags]     PUT.USUARIO.CADASTRAR            USUARIOS
    Criar Sessao
    Criar usuario_valido4_adm estatico
    PUT endpoint /usuarios/${id_invalido}
    Validar status code "201"
    Validar a Mensagem "Cadastro realizado com sucesso"

Cenario: PUT Criar Usuario Email Utilizado 400
    [tags]     PUT.USUARIO.CADASTRADO           USUARIOS
    Criar Sessao
    Criar usuario_cadastro_email_igual estatico
    PUT endpoint /usuarios/${id_invalido}
    Validar status code "400"
    Validar a Mensagem "Este email já está sendo usado"

#-------------Cenarios DELETE endpoint /usuarios -------------------------------------------------------------------------------------#
Cenario: DELETE Deletar Usuario 200
    [tags]     DELETE.USUARIO                   USUARIOS
    Criar Sessao
    Cadastrar usuario_valido5_adm e armazenar id
    DELETE endpoint /usuarios/${id_usuario}
    Validar status code "200"
    Validar a Mensagem "Registro excluído com sucesso"

Cenario: DELETE Deletar Usuario Carrinho 400
    [tags]     DELETE.USUARIO.CARRINHO          USUARIOS
    Criar Sessao
    Cadastrar usuario_valido6_adm e armazenar id
    Fazer login com id e adicionar carrinho
    DELETE endpoint /usuarios/${id_usuario}
    Validar status code "400"
    Validar a Mensagem "Não é permitido excluir usuário com carrinho cadastrado"

#-------------Cenarios POST endpoint /login -------------------------------------------------------------------------------------#
Cenario: POST Realizar Login 200
    [tags]     POST.LOGIN                       LOGIN
    Criar Sessao
    Criar usuario_valido_api estatico login
    POST endpoint /login
    Validar status code "200"
    Validar a mensagem "Login realizado com sucesso"

Cenario: POST Realizar Login Invalido 401
    [tags]     POST.LOGIN.ERRO                  LOGIN
    Criar Sessao
    Criar usuario_invalido estatico login
    POST endpoint /login
    Validar status code "401"
    Validar a mensagem "Email e/ou senha inválidos"

Cenario: POST Realizar Login Sem Email 400
    [tags]     POST.LOGIN.EMAIL                 LOGIN
    Criar Sessao
    Criar usuario_sem_email estatico login
    POST endpoint /login
    Validar status code "400"
    Validar no campo a mensagem     email    email não pode ficar em branco

Cenario: POST Realizar Login Sem Senha 400
    [tags]     POST.LOGIN.SENHA                 LOGIN
    Criar Sessao
    Criar usuario_sem_senha estatico login
    POST endpoint /login
    Validar status code "400"
    Validar no campo a mensagem     password    password não pode ficar em branco

#-------------Cenarios GET endpoint /produtos -------------------------------------------------------------------------------------#
Cenario: GET Todos os Produtos 200
    [tags]      GET.PRODUTOS                    PRODUTOS
    Criar Sessao
    GET endpoint /produtos
    Validar status code "200"

Cenario: GET Produto Especifico 200
    [tags]     GET.PRODUTO                      PRODUTOS
    Criar Sessao
    Criar produto_valido1 e armazenar id
    GET endpoint /produtos especifico   ${id_produto}
    Validar status code "200"

Cenario: GET Produto Especifico ID Invalido 400
    [tags]     GET.PRODUTO.ERRO                 PRODUTOS
    Criar Sessao
    GET endpoint /produtos especifico   ${id_invalido}
    Validar status code "400"
    Validar a Mensagem "Produto não encontrado"

#-------------Cenarios POST endpoint /produtos -------------------------------------------------------------------------------------#
Cenario: POST Criar Produto 201
    [tags]     POST.PRODUTO                     PRODUTOS
    Criar Sessao
    Fazer login e armazenar token   usuario_valido_api
    Gerar produto_valido2 estatico
    POST endpoint /produtos     ${token_auth}
    Validar status code "201"
    Validar a Mensagem "Cadastro realizado com sucesso"

Cenario: POST Criar Produto Nome Utilizado 400
    [tags]     POST.PRODUTO.NOME                PRODUTOS
    Criar Sessao
    Fazer login e armazenar token   usuario_valido_api
    Gerar produto_nome_igual estatico
    POST endpoint /produtos     ${token_auth}
    Validar status code "400"
    Validar a Mensagem "Já existe produto com esse nome"

Cenario: POST Criar Produto Token Invalido 401
    [tags]     POST.PRODUTO.TOKEN               PRODUTOS
    Criar Sessao
    Gerar produto_valido2 estatico
    POST endpoint /produtos     ${token_invalido}
    Validar status code "401"
    Validar a Mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"

Cenario: POST Criar Produto Não Administrador 403
    [tags]     POST.PRODUTO.ADM                 PRODUTOS
    Criar Sessao
    Fazer login e armazenar token   usuario_valido_nao_adm
    Gerar produto_valido2 estatico
    POST endpoint /produtos     ${token_auth}
    Validar status code "403"
    Validar a Mensagem "Rota exclusiva para administradores"

#-------------Cenarios PUT endpoint /produtos -------------------------------------------------------------------------------------#
Cenario: PUT Editar Produto 200
    [tags]     PUT.PRODUTO                      PRODUTOS
    Criar Sessao
    Criar produto_valido3 e armazenar id
    Gerar produto_valido3_editado estatico
    PUT endpoint /produtos     ${token_auth}
    Validar status code "200"
    Validar a Mensagem "Registro alterado com sucesso"

Cenario: PUT Editar Produto 201
    [tags]     PUT.PRODUTO.CRIAR                PRODUTOS
    Criar Sessao
    Fazer login e armazenar token   usuario_valido_api
    Gerar produto_valido4 estatico
    PUT endpoint /produtos     ${token_auth}    ${id_invalido}
    Validar status code "201"
    Validar a Mensagem "Cadastro realizado com sucesso"

Cenario: PUT Editar Produto Nome Utilizado 400
    [tags]     PUT.PRODUTO.ERRO                 PRODUTOS
    Criar Sessao
    Fazer login e armazenar token   usuario_valido_api
    Gerar produto_nome_igual estatico
    PUT endpoint /produtos     ${token_auth}
    Validar status code "400"
    Validar a Mensagem "Já existe produto com esse nome"

Cenario: PUT Editar Produto Token Invalido 401
    [tags]     PUT.PRODUTO.TOKEN                PRODUTOS
    Criar Sessao
    Fazer login e armazenar token   usuario_valido_api
    Criar produto_valido5 e armazenar id
    PUT endpoint /produtos     ${token_invalido}
    Validar status code "401"
    Validar a Mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"

Cenario: PUT Editar Produto Não Administrador 403
    [tags]     PUT.PRODUTO.ADM                  PRODUTOS
    Criar Sessao
    Fazer login e armazenar token   usuario_valido_nao_adm
    Encontrar id de um produto cadastrado
    PUT endpoint /produtos     ${token_auth}
    Validar status code "403"
    Validar a Mensagem "Rota exclusiva para administradores"

#-------------Cenarios DELETE endpoint /produtos -------------------------------------------------------------------------------------#
Cenario: DELETE Excluir Produto 200
    [tags]     DELETE.PRODUTO                   PRODUTOS
    Criar Sessao
    Criar produto_valido6 e armazenar id
    DELETE endpoint /produtos     ${token_auth}
    Validar status code "200"

Cenario: DELETE Excluir Produto No Carrinho 400
    [tags]     DELETE.PRODUTO.CARRINHO          PRODUTOS
    Criar Sessao
    Fazer login e adicionar carrinho
    DELETE endpoint /produtos     ${token_auth}
    Validar status code "400"
    Validar a Mensagem "Não é permitido excluir produto que faz parte de carrinho"

Cenario: DELETE Excluir Produto Token Invalido 401
    [tags]     DELETE.PRODUTO.TOKEN             PRODUTOS
    Criar Sessao
    Criar produto_valido6 e armazenar id
    DELETE endpoint /produtos     ${token_invalido}
    Validar status code "401"
    Validar a Mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"

Cenario: DELETE Excluir Produto Não Administrador 403
    [tags]     DELETE.PRODUTO.ADM               PRODUTOS
    Criar Sessao
    Fazer login e armazenar token   usuario_valido_nao_adm
    Encontrar id de um produto cadastrado
    DELETE endpoint /produtos     ${token_auth}
    Validar status code "403"
    Validar a Mensagem "Rota exclusiva para administradores"

#-------------Cenarios GET endpoint /carrinhos -------------------------------------------------------------------------------------#
Cenario: GET Listar Todos Carrinhos 200
    [tags]     GET.CARRINHOS                    CARRINHOS
    Criar Sessao
    GET endpoint /carrinhos
    Validar status code "200"

Cenario: GET Carrinho Especifico 200
    [tags]     GET.CARRINHO                     CARRINHOS
    Criar Sessao
    Listar carrinhos e pegar um id valido
    GET endpoint /carrinhos/${id_carrinho}
    Validar status code "200"

#-------------Cenarios POST endpoint /carrinhos -------------------------------------------------------------------------------------#
Cenario: POST Criar Carrinho 200
    [tags]     POST.CARRINHO                    CARRINHOS
    Criar Sessao
    Fazer login e armazenar token   usuario_valido_nao_adm
    Adicionar um produto no carrinho
    POST endpoint /carrinhos     ${token_auth}
    Validar status code "201"
    Validar a Mensagem "Cadastro realizado com sucesso"

#-------------Cenarios DELETE endpoint /carrinhos -------------------------------------------------------------------------------------#
Cenario: DELETE Excluir Carrinho Concluir Compra Com Carrinho 200
    [tags]     DELETE.COM.CARRINHO.CONCLUIR     CARRINHOS
    Criar Sessao
    Fazer login e adicionar carrinho
    DELETE endpoint /carrinhos      concluir-compra    ${token_auth}
    Validar status code "200"
    Validar a Mensagem "Registro excluído com sucesso"

Cenario: DELETE Excluir Carrinho Concluir Compra Sem Carrinho 200
    [tags]     DELETE.SEM.CARRINHO.CONCLUIR     CARRINHOS
    Criar Sessao
    Fazer login e armazenar token   usuario_valido_api
    DELETE endpoint /carrinhos      concluir-compra    ${token_auth}
    Validar status code "200"
    Validar a Mensagem "Não foi encontrado carrinho para esse usuário"

Cenario: DELETE Excluir Carrinho Concluir Token Invalido 401
    [tags]     DELETE.CARRINHO.CONCLUIR.TOKEN   CARRINHOS
    Criar Sessao
    Fazer login e adicionar carrinho
    DELETE endpoint /carrinhos      concluir-compra    ${token_invalido}
    Validar status code "401"
    Validar a Mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"

Cenario: DELETE Excluir Carrinho Cancelar Compra Com Carrinho 200
    [tags]     DELETE.COM.CARRINHO.CANCELAR     CARRINHOS
    Criar Sessao
    Fazer login e adicionar carrinho
    DELETE endpoint /carrinhos      cancelar-compra    ${token_auth}
    Validar status code "200"
    Validar a Mensagem "Registro excluído com sucesso. Estoque dos produtos reabastecido"

Cenario: DELETE Excluir Carrinho Cancelar Compra Sem Carrinho 200
    [tags]     DELETE.SEM.CARRINHO.CANCELAR     CARRINHOS
    Criar Sessao
    Fazer login e armazenar token   usuario_valido_api
    DELETE endpoint /carrinhos      cancelar-compra    ${token_auth}
    Validar status code "200"
    Validar a Mensagem "Não foi encontrado carrinho para esse usuário"

Cenario: DELETE Excluir Carrinho Cancelar Token Invalido 401
    [tags]     DELETE.CARRINHO.CANCELAR.TOKEN   CARRINHOS
    Criar Sessao
    Fazer login e adicionar carrinho
    DELETE endpoint /carrinhos      cancelar-compra    ${token_invalido}
    Validar status code "401"
    Validar a Mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"


# Sessão para criação de Keywords personalizadas
* Keywords *
Criar Sessao
    Create Session          serverest       http://localhost:3000/      #https://serverest.dev