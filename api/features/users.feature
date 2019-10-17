# language: pt
# coding: utf-8

Funcionalidade: Users
    Eu como usuário 
    Quero acessar o perfil de um usuário
    Para visualizar várias informações sobre a conta dele
    
    # /users/:login
    Cenário: Acesso ao perfil de um usuário existente
        Após solicitar informações do perfil de um usuário eu devo recebe-las como retorno
        
        Dado que uma chamada GET seja feita no endpoint "users/"login de um usuário existente
        Quando eu efetuar a requisição
        Então recebo um JSON contendo as informações do usuário
        
    Cenário: Acesso ao perfil de um usuário inexistente
        Após solicitar informações do perfil de um usuário que não existe eu devo receber um erro
        
        Dado que uma chamada GET seja feita no endpoint "users/"login de um usuário inexistente
        Quando eu efetuar a requisição
        Então recebo um erro informando que o usuário não existe
        
        
    # /users/:login/societies
    Cenário: Visualizar os societies de um usuário existente
        Após solicitar informações dos societies de um usuário existente eu devo receber informações
        sobre eles.
        
        Dado que uma chamada GET seja feita no endpoint "users/"login de um usuário existente
        Quando a rota "societies " for chamada
        Então recebo um JSON contendo as informações dos societies daquele usuário
    
    Cenário: Visualizar os societies de um usuário não existe
        Após solicitar informações dos societies de um usuário que não existe deve receber um erro.
        
        Dado que uma chamada GET seja feita no endpoint "users/"login de um usuário inexistente
        Quando a rota "societies " for chamada
        Então recebo um erro informando que o usuário não existe
    
    
    # /users/:login/statistics
    Cenário: Visualizar as estatísticas de um usuário existente
        Após solicitar as estatísticas de um usuário existente devo recebe-las.
        
        Dado que uma chamada GET seja feita no endpoint "users/"login de um usuário existente
        Quando a rota "statistics" for chamada
        Então recebo um JSON contendo as estatísticas do usuário
    
    Cenário: Visualizar as estatísticas de um usuário inexistente
        Após solicitar as estatísticas de um usuário que não existe devo uma mensagem de erro.
        
        Dado que uma chamada GET seja feita no endpoint "users/"login de um usuário inexistente
        Quando a rota "statistics" for chamada
        Então recebo um erro informando que o usuário não existe
    
    
    # /users/:login/matches
    # /users/:login/matches?offset=0&limit=20&status
    
    Cenário: Visualizar as partidas de um usuário existente
        Após solicitar as informações das partidas de um usuário existente eu devo receber as 
        informações detalhadas de cada uma delas.
        
        Dado que uma chamada GET seja feita no endpoint "users/"login de um usuário existente
        Quando a rota "matches" for chamada com os parâmetros de busca no modo padrão
        Então recebo um JSON contendo as informações sobre as partidas do usuário
    
    Cenário: Tentar visualizar as partidas de um usuário inexistente
        Após solicitar as informações das partidas de um usuário inexistente eu devo receber um erro.
        
        Dado que uma chamada GET seja feita no endpoint "users/"login de um usuário inexistente
        Quando a rota "matches" for chamada com os parâmetros de busca no modo padrão
        Então recebo um erro informando que o usuário não existe
    