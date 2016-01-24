# simple-realtime-message

Simple Realtime Message - Rails NodeJS Socket.io

Autor: GilcierWeb gilcierweb@gmail.com.

Website: http://gilcierweb.com.br.

Licença: http://www.opensource.org/licenses/mit-license.php The MIT License.

Demo: 

[![Realtime Socket.io, NodeJs e Ruby On Rails](http://img.youtube.com/vi/Dn5bIOnEpAY/0.jpg)](https://youtu.be/Dn5bIOnEpAY "Realtime Socket.io, NodeJs e Ruby On Rails")


1. Entre na pasta do projeto pelo terminal
```shell
cd simple-realtime-message/
```

2. Terminal baixe as dependencias do nodejs vai rodar na porta 3002 para nao dar conflito com a porta onde roda rails 3000

```shell
npm install
```

3. Start o servidor nodejs

```shell
node server.js
```

4. Terminal baixe as dependencias do rails

```shell
bundle install
```

5. Criar o banco de dados mysql

```shell
rake db:create:all
rake db:migrate
rails server
