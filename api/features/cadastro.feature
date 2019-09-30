# language: pt
# coding: utf-8

Funcionalidade: Cadastro
    Eu como usuário 
    Quero realizar o cadastro
    Para utilizar a plataforma
    
    Cenário: Cadastro bem sucedido
        Após o cadastro ser finalizado recebo uma confirmação.
        
        Dado que uma chamada POST seja feita no endpoint de signup
        Quando o campo "login" estiverem preenchido com "username_teste_2"
        E o campo "password" com "senha_teste_2"
        E o campo "name" com "teste teste 2"
        E o campo "email" com "username_teste_2@teste.com"
        E o campo "birthday" com "02/02/1970"
        E o campo "gender" com "other"
        Então recebo como resposta o meu username e minha senha
    
    Cenário: Falha no cadastro utilizando um username já utilizado
        Ao tentar me registrar com um username já utilizado um erro
        será retornado.
        
        Dado que uma chamada POST seja feita no endpoint de signup
        Quando o campo "login" estiverem preenchido com "username_teste"
        E o campo "password" com "senha_teste_2"
        E o campo "name" com "teste teste 2"
        E o campo "email" com "username_teste_2@teste.com"
        E o campo "birthday" com "02/02/1970"
        E o campo "gender" com "other"
        Então recebo um erro: "username já utilizado"
    
    Cenário: Falha no cadastro utilizando um email já utilizado
        Ao tentar me registrar com um email já utilizado um erro
        será retornado.
        
        Dado que uma chamada POST seja feita no endpoint de signup
        Quando o campo "login" estiverem preenchido com "username_teste_2"
        E o campo "password" com "senha_teste_2"
        E o campo "name" com "teste teste 2"
        E o campo "email" com "username_teste@teste.com"
        E o campo "birthday" com "02/02/1970"
        E o campo "gender" com "other"
        Então recebo um erro: "email já utilizado"
    
    Cenário: Falha no cadastro com username faltando
        Ao tentar me registrar com o campo de username vazio um erro
        será retornado.
        
        Dado que uma chamada POST seja feita no endpoint de signup
        Quando o campo "login" estiverem preenchido com ""
        E o campo "password" com "senha_teste_2"
        E o campo "name" com "teste teste 2"
        E o campo "email" com "username_teste_2@teste.com"
        E o campo "birthday" com "02/02/1970"
        E o campo "gender" com "other"
        Então recebo um erro: "username vazio"
    
    Cenário: Falha no cadastro com password faltando
        Ao tentar me registrar com o campo de email vazio um erro
        será retornado.
        
        Dado que uma chamada POST seja feita no endpoint de signup
        Quando o campo "login" estiverem preenchido com "username_teste_2"
        E o campo "password" com ""
        E o campo "name" com "teste teste 2"
        E o campo "email" com "username_teste_2@teste.com"
        E o campo "birthday" com "02/02/1970"
        E o campo "gender" com "other"
        Então recebo um erro: "password inválido"

    Cenário: Falha no cadastro com name faltando
        Ao tentar me registrar com o campo de name vazio um erro
        será retornado.
        
        Dado que uma chamada POST seja feita no endpoint de signup
        Quando o campo "login" estiverem preenchido com "username_teste_2"
        E o campo "password" com "senha_teste_2"
        E o campo "name" com ""
        E o campo "email" com "username_teste_2@teste.com"
        E o campo "birthday" com "02/02/1970"
        E o campo "gender" com "other"
        Então recebo um erro: "name inválido"
    
    Cenário: Falha no cadastro com email faltando
        Ao tentar me registrar com o campo de email vazio um erro
        será retornado.
        
        Dado que uma chamada POST seja feita no endpoint de signup
        Quando o campo "login" estiverem preenchido com "username_teste_2"
        E o campo "password" com "senha_teste_2"
        E o campo "name" com "teste teste 2"
        E o campo "email" com ""
        E o campo "birthday" com "02/02/1970"
        E o campo "gender" com "other"
        Então recebo um erro: "email inválido"
    
    Cenário: Falha no cadastro com birthday faltando
        Ao tentar me registrar com o campo de birthday vazio um erro
        será retornado.
        
        Dado que uma chamada POST seja feita no endpoint de signup
        Quando o campo "login" estiverem preenchido com "username_teste_2"
        E o campo "password" com "senha_teste_2"
        E o campo "name" com "teste teste 2"
        E o campo "email" com "username_teste_2@teste.com"
        E o campo "birthday" com ""
        E o campo "gender" com "other"
        Então recebo um erro: "birthday inválido"
        
    Cenário: Falha no cadastro com gender faltando
        Ao tentar me registrar com o campo de gender vazio um erro
        será retornado.
        
        Dado que uma chamada POST seja feita no endpoint de signup
        Quando o campo "login" estiverem preenchido com "username_teste_2"
        E o campo "password" com "senha_teste_2"
        E o campo "name" com "teste teste 2"
        E o campo "email" com "username_teste_2@teste.com"
        E o campo "birthday" com "02/02/1970"
        E o campo "gender" com ""
        Então recebo um erro: "gender inválido"