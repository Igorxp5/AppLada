# language: pt
# coding: utf-8

Funcionalidade: Logout
    Eu como usuário 
    Quero desconectar da paltaforma
    Para que eu não consiga mais executar ações no site com a conta antes logada
    
    # POST /logout
    Cenário: Deslogar estando logado
        Após solicitar para deslogar estando com uma conta online eu sou desconectado e não recebo erros.
        
        Dado que faça uma chamada em "logout/"
        Quando eu realizar a requisição utilizando o metódo POST
        Então recebo um JSON sem conter erros
    
    Cenário: Deslogar não estando logado
        Após solicitar para deslogar sem estar conectado eu devo receber um erro.
        
        Dado que faça uma chamada em "logout/"
        Quando eu realizar a requisição utilizando o metódo POST sem credenciais
        Então recebo uma mensagem de erro
    
    
    #GET /logout
    Cenário: Realizar chamada GET no logout
        Após requisitar com utilizando um metódo que não possui rota devo receber um erro.
        
        Dado que faça uma chamada em "logout/"
        Quando eu realizar a requisição utilizando o metódo GET
        Então recebo uma mensagem de erro
    
    #PUT /logout
    Cenário: Realizar chamada PUT no logout
        Após requisitar com utilizando um metódo que não possui rota devo receber um erro.
        
        Dado que faça uma chamada em "logout/"
        Quando eu realizar a requisição utilizando o metódo PUT
        Então recebo uma mensagem de erro
    
    #DEL /logout
    Cenário: Realizar chamada DEL no logout
        Após requisitar com utilizando um metódo que não possui rota devo receber um erro.
        
        Dado que faça uma chamada em "logout/"
        Quando eu realizar a requisição utilizando o metódo DEL
        Então recebo uma mensagem de erro
    