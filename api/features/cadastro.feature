# language: pt
# coding: utf-8

Funcionalidade: Cadastro
    Eu como usuário 
    Quero realizar o cadastro
    Para utilizar a plataforma
    
    
    Cenário: Cadastro bem sucedido
        Após o cadastro ser finalizado recebo uma confirmação.
        
        Dado que uma chamada POST seja feita no endpoint de signup
        Quando o campo login estiver preenchido com "username_teste_2" e o campo password com "senha_teste_2" e o campo name com "teste teste teste" e o campo email com "username_teste_2@teste.com" e o campo birthday com "02/02/1970" e o campo gender com "O"
        Então recebo como resposta o meu login: "username_teste_2" e minha senha: "senha_teste_2"
    
    
    Cenário: Falha no cadastro utilizando um login já utilizado
        Ao tentar me registrar com um login já utilizado um erro
        será retornado.
        
        Dado que uma chamada POST seja feita no endpoint de signup
        Quando o campo login estiver preenchido com "username_teste" e o campo password com "senha_teste_2" e o campo name com "teste teste teste" e o campo email com "username_teste_2@teste.com" e o campo birthday com "02/02/1970" e o campo gender com "O"
        Então recebo um erro: "Login has already been taken"
    
    
    Cenário: Falha no cadastro utilizando um email já utilizado
        Ao tentar me registrar com um email já utilizado um erro
        será retornado.
        
        Dado que uma chamada POST seja feita no endpoint de signup
        Quando o campo login estiver preenchido com "username_teste_2" e o campo password com "senha_teste_2" e o campo name com "teste teste teste" e o campo email com "username_teste@teste.com" e o campo birthday com "02/02/1970" e o campo gender com "O"
        Então recebo um erro: "Email has already been taken"
    
    
    Cenário: Falha no cadastro com login faltando
        Ao tentar me registrar com o campo de login vazio um erro
        será retornado.
        
        Dado que uma chamada POST seja feita no endpoint de signup
        Quando o campo login estiver preenchido com "" e o campo password com "senha_teste_2" e o campo name com "teste teste teste" e o campo email com "username_teste_2@teste.com" e o campo birthday com "02/02/1970" e o campo gender com "O"
        Então recebo um erro: "Login can't be blank"
    
    Cenário: Falha no cadastro com password faltando
        Ao tentar me registrar com o campo de password vazio um erro
        será retornado.
        
        Dado que uma chamada POST seja feita no endpoint de signup
        Quando o campo login estiver preenchido com "username_teste_2" e o campo password com "" e o campo name com "teste teste teste" e o campo email com "username_teste_2@teste.com" e o campo birthday com "02/02/1970" e o campo gender com "O"
        Então recebo um erro: "Password can't be blank"

    Cenário: Falha no cadastro com name faltando
        Ao tentar me registrar com o campo de name vazio um erro
        será retornado.
        
        Dado que uma chamada POST seja feita no endpoint de signup
        Quando o campo login estiver preenchido com "username_teste_2" e o campo password com "senha_teste_2" e o campo name com "" e o campo email com "username_teste_2@teste.com" e o campo birthday com "02/02/1970" e o campo gender com "O"
        Então recebo um erro: "Name can't be blank"
    
    
    Cenário: Falha no cadastro com email faltando
        Ao tentar me registrar com o campo de email vazio um erro
        será retornado.
        
        Dado que uma chamada POST seja feita no endpoint de signup
        Quando o campo login estiver preenchido com "username_teste_2" e o campo password com "senha_teste_2" e o campo name com "teste teste teste" e o campo email com "" e o campo birthday com "02/02/1970" e o campo gender com "O"
        Então recebo um erro: "Email can't be blank"
    
    
    Cenário: Falha no cadastro com birthday faltando
        Ao tentar me registrar com o campo de birthday vazio um erro
        será retornado.
        
        Dado que uma chamada POST seja feita no endpoint de signup
        Quando o campo login estiver preenchido com "username_teste_2" e o campo password com "senha_teste_2" e o campo name com "teste teste teste" e o campo email com "username_teste_2@teste.com" e o campo birthday com "" e o campo gender com "O"
        Então recebo um erro: "Birthday can't be blank"
       
        
    Cenário: Falha no cadastro com gender faltando
        Ao tentar me registrar com o campo de gender vazio um erro
        será retornado.
        
        Dado que uma chamada POST seja feita no endpoint de signup
        Quando o campo login estiver preenchido com "username_teste_2" e o campo password com "senha_teste_2" e o campo name com "teste teste teste" e o campo email com "username_teste_2@teste.com" e o campo birthday com "02/02/1970" e o campo gender com ""
        Então recebo um erro: "Gender can't be blank"
    
    
    Cenário: Falha no cadastro com gender inválido
        Ao tentar me registrar com o campo de gender preenchido com um valor
        inválido um erro será retornado.
        
        Dado que uma chamada POST seja feita no endpoint de signup
        Quando o campo login estiver preenchido com "username_teste_2" e o campo password com "senha_teste_2" e o campo name com "teste teste teste" e o campo email com "username_teste_2@teste.com" e o campo birthday com "02/02/1970" e o campo gender com "FAIL"
        Então recebo um erro: "Gender must be 'M', 'F', or 'O'"
    
    
    Cenário: Falha no cadastro com password pequeno
        Ao tentar me registrar com uma senha menor que 8 caracteres um erro
        será retornado.
        
        Dado que uma chamada POST seja feita no endpoint de signup
        Quando o campo login estiver preenchido com "username_teste_2" e o campo password com "teste" e o campo name com "teste teste teste" e o campo email com "username_teste_2@teste.com" e o campo birthday com "02/02/1970" e o campo gender com "O"
        Então recebo um erro: "Password is too short (minimum is 8 characters)"
    
    
    Cenário: Falha no cadastro com password grande
        Ao tentar me registrar com uma senha maior que 16 caracteres um erro
        será retornado.
        
        Dado que uma chamada POST seja feita no endpoint de signup
        Quando o campo login estiver preenchido com "username_teste_2" e o campo password com "teste_senha_fail_16_caracteres" e o campo name com "teste teste teste" e o campo email com "username_teste_2@teste.com" e o campo birthday com "02/02/1970" e o campo gender com "O"
        Então recebo um erro: "Password is too long (maximum is 16 characters)"
    
    
    Cenário: Falha no cadastro com um email invalido
        Ao tentar me registrar com um email invalido um erro
        será retornado.
        
        Dado que uma chamada POST seja feita no endpoint de signup
        Quando o campo login estiver preenchido com "username_teste_2" e o campo password com "senha_teste_2" e o campo name com "teste teste teste" e o campo email com "username_teste_2testecom" e o campo birthday com "02/02/1970" e o campo gender com "O"
        Então recebo um erro: "Email is invalid"
    
    
    Cenário: Falha no cadastro com uma data de nascimento no futuro
        Ao tentar me registrar com uma data de nascimento além da data atual.
        
        Dado que uma chamada POST seja feita no endpoint de signup
        Quando o campo login estiver preenchido com "username_teste_2" e o campo password com "senha_teste_2" e o campo name com "teste teste teste" e o campo email com "username_teste_2@teste.com" e o campo birthday com "02/02/3500" e o campo gender com "O"
        Então recebo um erro: "Birthday can't be in the future"
    
    
    Cenário: Falha no cadastro com um nome com coisas além de letras
        Ao tentar me registrar com um nome com caracteres inválidos um erro
        será retornado.
        
        Dado que uma chamada POST seja feita no endpoint de signup
        Quando o campo login estiver preenchido com "username_teste_2" e o campo password com "senha_teste_2" e o campo name com "teste teste 2" e o campo email com "username_teste_2@teste.com" e o campo birthday com "02/02/1970" e o campo gender com "O"
        Então recebo um erro: "Name can have only letters"
    