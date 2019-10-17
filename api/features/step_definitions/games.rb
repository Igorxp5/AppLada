Before do
    DatabaseCleaner.clean_with(:deletion)
    header 'Host', 'test.applada.com.br'
    
    @id_partida = 1
    @not_id_partida = 5
end

After do
    DatabaseCleaner.clean_with(:deletion)
end



Dado("que uma chamada GET seja feita no endpoint {string}") do |string|
    @url_games = string
end

Dado("que uma chamada POST seja feita no endpoint {string}") do |string|
    @url_games = string
end

Dado("que uma chamada GET seja feita no endpoint {string}id de uma partida existente") do |string|
    @url_games = string + @id_partida
end

Dado("que uma chamada GET seja feita no endpoint {string}id de uma partida inexistente") do |string|
    @url_games = string + 21
end

Dado("que uma chamada DEL seja feita no endpoint {string}id de uma partida existente que seja minha") do |string|
    @url_games = string + @id_partida
end

Dado("que uma chamada DEL seja feita no endpoint {string}id de uma partida inexistente") do |string|
    @url_games = string + 21
end

Dado("que uma chamada DEL seja feita no endpoint {string}id de uma partida existente que não é minha") do |string|
    @url_games = string + @not_id_partida
end

Quando("eu fornecer minha longitude, latitude e raio de maneira válida") do
    @url_games = @url_games + "games?latitude=39&longitude=15&radius=5"
end

Quando("eu fornecer minha latitude, raio e uma longitude impossível") do
    @url_games = @url_games + "games?latitude=39&longitude=550&radius=5"
end

Quando("eu fornecer minha latitude, raio e o campo de longitude vazio") do
    @url_games = @url_games + "games?latitude=39&longitude=&radius=5"
end

Quando("eu fornecer minha longitude, raio e uma latitude impossível") do
    @url_games = @url_games + "games?latitude=250&longitude=15&radius=5"
end

Quando("eu fornecer minha longitude, raio e o campo de latitude vazio") do
    @url_games = @url_games + "games?latitude=&longitude=15&radius=5"
end

Quando("eu preencher os campos de título, latitude, longitude, descrição e data e fizer a requisição") do
    body = {
        "title": "criação pelada",
    	"latitude": "38",
    	"longitude": "15",
    	"description": "Vem jogar com a gente!",
    	"start_date": "30/01/2025",
    	"end_date": "30/01/2050"
    }.to_json
    
    header 'Content-Type', 'application/json'
    post @url_games, body
    @response_contend = JSON.parse(last_response.body)
end

Quando("eu realizar o request GET") do
    body = {}.to_json
    header 'Content-Type', 'application/json'
    get @url_games, body
    @response_contend = JSON.parse(last_response.body)
end

Quando("eu realizar o request DEL") do
    body = {}.to_json
    header 'Content-Type', 'application/json'
    delete? @url_games, body
    @response_contend = JSON.parse(last_response.body)
end

Então("recebo um JSON com informações de todas as peladas dentro do raio informado a partir da minha localização") do
    expect(@response_contend['data'].empty?).to  eq(true)
end

Então("recebo uma mensagem de erro: {string}") do |string|
    expect(@response_contend['errors'][0]['message']).to  eq(string)
end

Então("recebo um JSON confirmando as informações da minha partida") do
    expect(@response_contend['data']['id']).to  eq("5")
    expect(@response_contend['data']['title']).to  eq("Pelada teste")
    expect(@response_contend['data']['latitude']).to  eq("55")
    expect(@response_contend['data']['longitude']).to  eq("55")
    expect(@response_contend['data']['description']).to  eq("Uma pelada de teste")
    expect(@response_contend['data']['owner']).to  eq("testadorFake")
    expect(@response_contend['data']['start_date']).to  eq("30/01/2025")
    expect(@response_contend['data']['end_date']).to  eq("30/01/2050")
    expect(@response_contend['data']['created_date']).to  eq("30/01/2000")
end

Então("recebo um JSON contendo todas as informações sobre a pelada") do
    expect(@response_contend['data']['id']).to  eq("1")
    expect(@response_contend['data']['title']).to  eq("Minha pelada teste")
    expect(@response_contend['data']['latitude']).to  eq("44")
    expect(@response_contend['data']['longitude']).to  eq("44")
    expect(@response_contend['data']['description']).to  eq("Teste de uma pelada minha")
    expect(@response_contend['data']['owner']).to  eq("testadorOficial")
    expect(@response_contend['data']['start_date']).to  eq("30/01/2020")
    expect(@response_contend['data']['end_date']).to  eq("31/01/2020")
    expect(@response_contend['data']['created_date']).to  eq("25/01/2020")
end

Então("recebo um JSON sem erros") do
    expect(@response_contend['errors'].empty?).to  eq(true)
end