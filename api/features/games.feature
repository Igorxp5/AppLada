# language: pt
# coding: utf-8

Funcionalidade: Games
    Eu como usuário 
    Quero visualizar quais peladas ocorrerão próximas de mim
    Para poder escolher de qual quero participar
    
    # GET /games
    Cenário: Buscar partidas a partir de cordenadas corretas
        Após solicitar a lista de peladas próximas de mim devo receber uma listagem delas
        ordenadas por distância crescente.
        
        Dado que uma chamada GET seja feita no endpoint "games/"
        Quando eu fornecer minha longitude, latitude e raio de maneira válida
        Então recebo um JSON com informações de todas as peladas dentro do raio informado a partir da minha localização
        
    Cenário: Buscar peladas com longitude impossível
        Após solicitar a lista de peladas próximas de mim utilizando uma longitude impossível
        eu devo receber um erro.
        
        Dado que uma chamada GET seja feita no endpoint "games/"
        Quando eu fornecer minha latitude, raio e uma longitude impossível
        Então recebo uma mensagem de erro: "Impossible longitude"
    
    Cenário: Buscar peladas com longitude vazia
        Após solicitar a lista de peladas próximas de mim sem informar a minha longitude
        eu devo receber um erro.
        
        Dado que uma chamada GET seja feita no endpoint "games/"
        Quando eu fornecer minha latitude, raio e o campo de longitude vazio
        Então recebo uma mensagem de erro: "Longitude can't be blank"
    
    Cenário: Buscar peladas com latitude impossível
        Após solicitar a lista de peladas próximas de mim utilizando uma latitude impossível
        eu devo receber um erro.
        
        Dado que uma chamada GET seja feita no endpoint "games/"
        Quando eu fornecer minha longitude, raio e uma latitude impossível
        Então recebo uma mensagem de erro: "Impossible latitude"
    
    Cenário: Buscar peladas com latitude vazia
        Após solicitar a lista de peladas próximas de mim sem informar a minha latitude
        eu devo receber um erro.
        
        Dado que uma chamada GET seja feita no endpoint "games/"
        Quando eu fornecer minha longitude, raio e o campo de latitude vazio
        Então recebo uma mensagem de erro: "Latitude can't be blank"
    
    
    # POST /games
    Cenário: Criar uma pelada
        Desejo criar uma pelada fornecendo o seu título, a latitude e longitude além de dar-lhe uma
        descrição e informar sua data de ocorrência.
        
        Dado que uma chamada POST seja feita no endpoint "games/"
        Quando eu preencher os campos de título, latitude, longitude, descrição e data e fizer a requisição
        Então recebo um JSON confirmando as informações da minha partida
    
    
    # GET /games/:id
    Cenário: Buscar informações de uma pelada existente
        Desejo obter informações de uma pelada em específico fornecendo o seu ID, caso ela exista
        recebo todas as suas informações.
        
        Dado que uma chamada GET seja feita no endpoint "games/"id de uma partida existente
        Quando eu realizar o request GET
        Então recebo um JSON contendo todas as informações sobre a pelada
    
    Cenário: Buscar informações de uma pelada inexistente
        Caso eu tente obter informações de uma pelada que não existe eu devo receber um erro.
        
        Dado que uma chamada GET seja feita no endpoint "games/"id de uma partida inexistente
        Quando eu realizar o request GET
        Então recebo uma mensagem de erro: "Resource not found"
    
    
    # DEL /games/:id
    Cenário: Deletar uma pelada que eu criei
        Desejo excluir uma pelada que criei.
        
        Dado que uma chamada DEL seja feita no endpoint "games/"id de uma partida existente que seja minha
        Quando eu realizar o request DEL
        Então recebo um JSON sem erros
    
    Cenário: Deletar uma pelada que não existe
        Caso eu tente excluir uma pelada que não existe devo receber uma mensagem de erro.
        
        Dado que uma chamada DEL seja feita no endpoint "games/"id de uma partida inexistente
        Quando eu realizar o request DEL
        Então recebo uma mensagem de erro: "Resource not found"
    
    Cenário: Deletar uma pelada que não é minha
        Caso eu tente excluir uma pelada que não me pertence devo receber uma mensagem de erro.
        
        Dado que uma chamada DEL seja feita no endpoint "games/"id de uma partida existente que não é minha
        Quando eu realizar o request DEL
        Então recebo uma mensagem de erro: "You don't have permission to do this action"