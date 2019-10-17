Before do
    DatabaseCleaner.clean_with(:deletion)
    user_teste = User.create!(login: "UsernameTeste", email: "username_teste@teste.com",
                        password: "senha_teste", name: "TestadorDoTime",
                        birthday: "30/01/2000", gender: "M")
    header 'Host', 'test.applada.com.br'
end

After do
    DatabaseCleaner.clean_with(:deletion)
end



Dado("que uma chamada GET seja feita no endpoint {string}login de um usuário existente") do |string|
    @url_users = string + "/UsernameTeste"
end

Dado("que uma chamada GET seja feita no endpoint {string}login de um usuário inexistente") do |string|
    @url_users = string + "/UsernameInexistente"
end

Quando("eu efetuar a requisição") do
    body = {"initials":"initials"}.to_json
    header 'Content-Type', 'application/json'
    get @url_users, body
    @response_contend = JSON.parse(last_response.body)
end

Quando("a rota {string} for chamada") do |string|
    @url_users = @url_users + string
    body = {}.to_json
    header 'Content-Type', 'application/json'
    get @url_users, body
    @response_contend = JSON.parse(last_response.body)
    
end

Quando("a rota {string} for chamada com os parâmetros de busca no modo padrão") do |string|
    @url_users = @url_users + string + "?offset=0&limit=20&status"
    body = {}.to_json
    header 'Content-Type', 'application/json'
    get @url_users, body
    @response_contend = JSON.parse(last_response.body)
end

Então("recebo um JSON contendo as informações do usuário") do
    expect(@response_contend['data']['login']).to  eq("UsernameTeste")
    expect(@response_contend['data']['name']).to  eq("TestadorDoTime")
    expect(@response_contend['data']['avatar']).to  eq("")
    expect(@response_contend['data']['email']).to  eq("username_teste@teste.com")
    expect(@response_contend['data']['birthday']).to  eq("30/01/2000")
    expect(@response_contend['data']['level']).to  eq("1")
    expect(@response_contend['data']['gender']).to  eq("M")
end

Então("recebo um erro informando que o usuário não existe") do
    pending
    # ERRO DESCONHECIDO AINDA
end

Então("recebo um JSON contendo as informações dos societies daquele usuário") do
    expect(@response_contend['data'].empty?).to  eq(true)
end

Então("recebo um JSON contendo nenhuma informações sobre societies") do
    expect(@response_contend['data'].empty?).to  eq(true)
end

Então("recebo um JSON contendo as estatísticas do usuário") do
    expect(@response_contend['data']["total_played_tournaments"]).to  eq(0)
    expect(@response_contend['data']["total_win_tournaments"]).to  eq(0)
    expect(@response_contend['data']["last_played_tournament"]).to  eq(0)
    expect(@response_contend['data']["total_played_games"]).to  eq(0)
end

Então("recebo um JSON contendo as informações sobre as partidas do usuário") do
    expect(@response_contend['data'].empty?).to  eq(true)
end
