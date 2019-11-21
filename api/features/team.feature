# language: pt
# coding: utf-8

Funcionalidade: Team
    Eu como usuário 
    Quero ver os times existentes
    Para visualizar várias informações sobre eles
    
    # GET /teams
    Cenário: Recuperar lista de times existentes
        Após solicitar informações dos times existentes devo receber suas informações.
        
        Dado que uma chamada seja realizada no endpoint "teams/"
        Quando eu realizar a requisição GET
        Então recebo um JSON contendo as informações
    
    
    # GET /teams/:initials
    Cenário: Recuperar informações de um time específico existente
        Após solicitar informações de um time existente devo receber suas informações.
        
        Dado que uma chamada seja realizada no endpoint "teams/"
        Quando eu requisitar junto a uma initials de um time existente utilizando GET
        Então recebo um JSON contendo as informações
    
    Cenário: Tentar recuperar informações de um time inexistente
        Após solicitar informações de um time inexistentes devo receber uma mensagem de erro.
        
        Dado que uma chamada seja realizada no endpoint "teams/"
        Quando eu requisitar junto a uma initials de um time inexistente utilizando GET
        Então receberei um erro
    
    
    # GET /teams/:initials/statistics
    Cenário: Recuperar estatísticas de um time específico existente
        Após solicitar estatísticas de um time existente devo receber suas informações.
        
        Dado que uma chamada seja realizada no endpoint "teams/"
        Quando eu requisitar as estatisticas junto a uma initials de um time existente utilizando GET
        Então recebo um JSON contendo as informações
    
    Cenário: Tentar recuperar estatísticas de um time inexistente
        Após solicitar estatísticas de um time inexistentes devo receber uma mensagem de erro.
        
        Dado que uma chamada seja realizada no endpoint "teams/"
        Quando eu requisitar as estatísticas junto a uma initials de um time inexistente utilizando GET
        Então receberei um erro
    
    
    # POST /teams/:initials
    Cenário: Criar um time
        Após realizar a chamada corretamente o time deve ser criado
        
        Dado que uma chamada seja realizada no endpoint "teams/"
        Quando eu realizar a chamada POST com uma initials ainda não utilizada
        Então não receberei um erro
    
    Cenário: Tentar criar um time com initials já usada
        Após realizar a chamada com uma initials já usado devo receber um erro
        
        Dado que uma chamada seja realizada no endpoint "teams/"
        Quando eu realizar a chamada POST com uma initials já utilizada
        Então receberei um erro
    
    
    # PUT /teams/:initials
    Cenário: Atualizar dados de um time pertencente a mim
        Após realizar a chamada corretamente os dados do time devem mudar
        
        Dado que uma chamada seja realizada no endpoint "teams/"
        Quando eu realizar a chamada PUT com as novas informações do meu time
        Então não receberei um erro
    
    Cenário: Atualizar dados de um time que não pertence a mim
        Após realizar a chamada corretamente para um time que não é meu devo receber um erro
        
        Dado que uma chamada seja realizada no endpoint "teams/"
        Quando eu realizar a chamada PUT com as novas informações para um time que não é meu
        Então receberei um erro
    
    Cenário: Atualizar dados de um time que não existe
        Após realizar a chamada corretamente para um time que não existe devo receber um erro
        
        Dado que uma chamada seja realizada no endpoint "teams/"
        Quando eu realizar a chamada PUT com as novas informações para um time que não existe
        Então receberei um erro
    
    
    # DEL /teams/:initials
    Cenário: Deletar um time pertencente a mim
        Após realizar a chamada corretamente o time deve ser deletado
        
        Dado que uma chamada seja realizada no endpoint "teams/"
        Quando eu realizar a chamada DEL para as initials do meu time
        Então não receberei um erro
    
    Cenário: Deletar um time que não pertence a mim
        Após realizar a chamada corretamente para um time que não é meu devo receber um erro
        
        Dado que uma chamada seja realizada no endpoint "teams/"
        Quando eu realizar a chamada DEL para as initials do time que não é meu
        Então receberei um erro
    
    Cenário: Deletar um time que não existe
        Após realizar a chamada corretamente para um time que não existe devo receber um erro
        
        Dado que uma chamada seja realizada no endpoint "teams/"
        Quando eu realizar a chamada DEL para as initials do time que não existe
        Então receberei um erro