![compass logo](img/readme_logo.png)

# Challenge Final
[![Badge ServeRest](https://img.shields.io/badge/API-ServeRest-green)](https://github.com/ServeRest/ServeRest/)

Este repositório contem o projeto final pertencente a sprint 06 da trilha Robotron - PB da COMPASS.UOL

O projeto consiste na criação de testes automatizados com Robot para a validação da API pública [ServeRest](https://serverest.dev/). 



## Pré requisitos
- Node.js
- Python 3.x
- Python libraries:
  - requests
  - faker
- Robot Framework
- Robot libraries:
  - OperatingSystem
  - RequestsLibrary
  - Faker Library
  - Collections
- Para instalar as bibliotecas:
```text
> pip install requests
> pip install Faker
> pip install robotframework
> pip install robotframework-requests
> pip install robotframework-faker
```


  
## Execução dos Testes
Execute a API ServeRest localmente:
```text
> npx serverest
```
Abra o cmd na pasta deste repositório e escolha quais grupos de testes deseja executar.
- Para executar todos os testes:
```text
> robot -d ./reports ./tests
```
- Para executar os testes de um endpoint:
```text
> robot -d ./reports ./tests/'nomedoendpoint'_tests.robot
```
- Para executar os testes de um endpoint por tag [^1]:
    [^1]: Cada cenário de teste possui 2 tags: <br>
        Ex:   &nbsp;&nbsp;&nbsp;&nbsp; [tags]      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GET       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GET.USUARIOS <br>
        1ª tag - corresponde a uma identificação do conjunto de cenários com o mesmo metodo HTTP. <br>
        2ª tag - corresponde a uma identificação unica de cada teste. <br>
   
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Todos os testes de um metodo HTTP:
```text
> robot -d ./reports -i 'METODO' ./tests/'nomedoendpoint'_tests.robot
```
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   Um unico teste pela sua tag especifica:
```text
> robot -d ./reports -i 'TAG.ESPECIFICA' ./tests/'nomedoendpoint'_tests.robot
```

    

## Estrutura de Diretórios
Abaixo encontra-se uma breve descrição dos diretórios presentes neste repositório.

* [Testes/](Testes)*: diretório com todos os arquivos que compoem os testes automatizados.
    * [keywords/](Testes/keywords)*: possui arquivos com keywords para ações em cada endpoint da API.
        <details><summary><i>arquivos</i></summary>
        usuarios_keywords.robot <br>
        login_keywords.robot <br>
        produtos_keywords.robot <br>
        carrinhos_keywords.robot </details>      
    * [reports/](Testes/reports)*: possui arquivos referentes as estatisticas e retornos da execução dos testes.
        <details><summary><i>arquivos</i></summary> 
        log.html <br>
        output.xml <br>
        report.html </details>        
    * [support/](Testes/support)*: possui arquivos de suporte para o funcionamento dos testes.
        *  [common/](Testes/support/common)*: possui arquivo com as keywords comuns a todos os endpoints.
            <details><summary><i>arquivo</i></summary> 
            commom.robot </details>           
        *  [fixtures/](Testes/support/fixtures)*: possui as massas de dados estáticas e dinamicas que são usadas nos testes.
            *  [static/](Testes/support/fixtures/static)*: massas de dados estáticas.
                  <details><summary><i>arquivos</i></summary> 
                  json_carrinho_ex.json <br>
                  json_login_ex.json </details>
            *  dynamics.robot            
        *  [python_functions/](Testes/support/python_functions)*: possui arquivo com funções personalizadas em python que são consumidas no robot.
            <details><summary><i>arquivo</i></summary> 
            python_functions.py </details>             
        *  [variables/](Testes/support/variables)*: possui arquivo com as variáveis comuns utilizadas nos testes.
            <details><summary><i>arquivo</i></summary> 
            serverest_variables.robot </details>            
        *  base.robot
    *  [tests/](Testes/tests)*: possui arquivos dos casos de testes de cada endpoint da API.
        <details><summary><i>arquivos</i></summary>
        usuarios_tests.robot <br>
        login_tests.robot <br>
        produtos_tests.robot <br>
        carrinhos_tests.robot </details>
