# language: pt
# coding: utf-8

Funcionalidade: Login
    Eu como usuário 
    Quero realizar o login
    Para utilizar a plataforma
    
    Cenário: Login bem sucedido utilizando username
        Após o login ser concluído recebo um JWT Token.
        
        Dado que uma chamada POST seja feita no endpoint de login
        Quando o campo "login" estiver preenchido com "username_teste"
        E o campo "password" com "senha_teste"
        Então recebo um JWT Token.
    
    Cenário: Login bem sucedido utilizando email
        Após o login ser concluído recebo um JWT Token.
        
        Dado que uma chamada POST seja feita no endpoint de login
        Quando o campo "login" estiver preenchido com "username_teste@teste.com"
        E o campo "password" com "senha_teste"
        Então recebo um JWT Token.
    
    Cenário: Falha no login com username correto e senha inválida
        Ao tentar logar com um username válido e a senha incorreta,
        um erro será retornado.
        
        Dado que uma chamada POST seja feita no endpoint de login
        Quando o campo "login" estiver preenchido com "username_teste"
        E o campo "password" com "senha_teste_incorreta"
        Então recebo um erro: "usuário e/ou senha incorretos"
    
    Cenário: Falha no login com email correto e senha inválida
        Ao tentar logar com um email válido e a senha incorreta,
        uma mensagem de falha será exibida.
        
        Dado que uma chamada POST seja feita no endpoint de login
        Quando o campo "login" estiver preenchido com "username_teste@mail.com"
        E o campo "password" com "senha_teste_incorreta"
        Então recebo um erro: "usuário e/ou senha incorretos"
        
    Cenário: Falha no login devido ao username não existir
        Ao tentar logar com um username inexistente, uma mensagem de falha será exibida.
        
        Dado que uma chamada POST seja feita no endpoint de login
        Quando o campo "login" estiver preenchido com "falha_teste"
        E o campo "password" com "senha_teste"
        Então recebo um erro: "usuário e/ou senha incorretos"
    
    Cenário: Falha no login devido ao email não existir
        Ao tentar logar com um email inexistente, uma mensagem de falha será exibida.
        
        Dado que uma chamada POST seja feita no endpoint de login
        Quando o campo "login" estiver preenchido com "falha_teste@mail.com"
        E o campo "password" com "senha_teste"
        Então recebo um erro: "usuário e/ou senha incorretos"
    
    Cenário: Falha no login devido ao username em branco
        Ao tentar logar com com o campo de username em branco,
        uma mensagem de falha será exibida.
        
        Dado que uma chamada POST seja feita no endpoint de login
        Quando o campo "login" estiver preenchido com ""
        E o campo "password" com "senha_teste"
        Então recebo um erro: "usuário e/ou senha incorretos"
    
    Cenário: Falha no login devido ao password em branco
        Ao tentar logar com com o campo de senha em branco,
        uma mensagem de falha será exibida.
        
        Dado que uma chamada POST seja feita no endpoint de login
        Quando o campo "login" estiver preenchido com "username_teste"
        E o campo "password" com ""
        Então recebo um erro: "usuário e/ou senha incorretos"