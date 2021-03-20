# flutter-get-and-post

Uma simples aplicação flutter utilizando chamadas GET e POST

## Flutter

Uma aplicação flutter que realiza a consulta na API

## API PHP

Uma API PHP desenvolvida exclusivamente para esse projeto
Armazenamento de notícias que foram verificadas como verdadeiras/falsas

## XAMPP

`docker stop $(docker ps -aq)`

Iniciando todos os serviços do XAMPP

`sudo /opt/lampp/lampp start`

Parando todos os serviços do XAMPP

`sudo /opt/lampp/xampp stop`

Iniciando o XAMPP com a interface gráfica

`sudo /opt/lampp/manager-linux-x64.run`

## ROTAS

Foi alterado o diretório da API no conf file para:

`DocumentRoot "/home/matt/Workspace/flutter/flutter-get-and-post/api"`

`<Directory "/home/matt/Workspace/flutter/flutter-get-and-post/api">`

Com essa alteração as duas rotas podem ser acessadas da seguinte maneira

### Home

`http://localhost`

### Listar - All (GET):

`http://localhost/list`

### Listar - One (GET):

`http://localhost/list?id=ID_REGISTRO`

### Cadastrar (POST)

`http://localhost/store`
