Before do
    DatabaseCleaner.clean_with(:deletion)
    user_teste = User.create!(login: "usernameteste", email: "username_teste@teste.com",
                        password: "senha_teste", name: "TestadorDoTime",
                        birthday: "30/01/2000", gender: "M")
    
    header 'Host', 'test.applada.com.br'
    
    #Obtenção de Token
    body = {email: "username_teste@teste.com", password: "senha_teste"}.to_json
    header 'Content-Type', 'application/json'
    post 'login', body
    response_body = JSON.parse(last_response.body)
    @token = response_body['data']['token']

        
    @my_initials = "TEST"
    @other_initials = "FAIL"
    @unknow_initials = "CAQE"
end



Dado("que uma chamada seja realizada no endpoint {string}") do |string|
    @url_team = string
    
    # Usuário 2
    user_teste2 = User.create!(login: "usernamefake", email: "user2_teste@teste.com",
                        password: "senha_teste2", name: "Testador",
                        birthday: "25/02/2002", gender: "F")
    
    # Meu time
    my_team = Team.create(
            initials: "test",
            name: "testador",
            avatar: nil,
            owner: "usernameteste"
        )
    
    # Time que não é meu
    other_initials = Team.create!(
            initials: "fail",
            name: "testadorFail",
            avatar: nil,
            owner: "usernamefake"
        )
end

Quando("eu realizar a requisição GET") do
    @url_team = @url_team + "?offset=0&limit=20"
    
    body = {}.to_json
    header 'Content-Type', 'application/json'
    header 'Authorization', "Bearer #{@token}"
    get @url_team, body
    @response_contend = JSON.parse(last_response.body)
end

Quando("eu requisitar junto a uma initials de um time existente utilizando GET") do
    @url_team = @url_team + @my_initials
    
    body = {}.to_json
    header 'Content-Type', 'application/json'
    header 'Authorization', "Bearer #{@token}"
    get @url_team, body
    @response_contend = JSON.parse(last_response.body)
end

Quando("eu requisitar junto a uma initials de um time inexistente utilizando GET") do
    @url_team = @url_team + @unknow_initials
    
    body = {}.to_json
    header 'Content-Type', 'application/json'
    header 'Authorization', "Bearer #{@token}"
    get @url_team, body
    @response_contend = JSON.parse(last_response.body)
end

Quando("eu requisitar as estatisticas junto a uma initials de um time existente utilizando GET") do
    @url_team = @url_team + @my_initials + "/statistics"
    
    body = {}.to_json
    header 'Content-Type', 'application/json'
    header 'Authorization', "Bearer #{@token}"
    get @url_team, body
    @response_contend = JSON.parse(last_response.body)
end

Quando("eu requisitar as estatísticas junto a uma initials de um time inexistente utilizando GET") do
    @url_team = @url_team + @unknow_initials + "/statistics"
    
    body = {}.to_json
    header 'Content-Type', 'application/json'
    header 'Authorization', "Bearer #{@token}"
    get @url_team, body
    @response_contend = JSON.parse(last_response.body)
end

Quando("eu realizar a chamada POST com uma initials ainda não utilizada") do
    @url_team = @url_team
    
    body = {
        name: "desconhecido",
        initials: @unknow_initials
    }.to_json
    header 'Content-Type', 'application/json'
    header 'Authorization', "Bearer #{@token}"
    post @url_team, body
    @response_contend = JSON.parse(last_response.body)
end

Quando("eu realizar a chamada POST com uma initials já utilizada") do
    @url_team = @url_team
    
    body = {
        name: "existente",
        initials: @my_initials
    }.to_json
    header 'Content-Type', 'application/json'
    header 'Authorization', "Bearer #{@token}"
    post @url_team, body
    @response_contend = JSON.parse(last_response.body)
end

Quando("eu realizar a chamada PUT com as novas informações do meu time") do
    @url_team = @url_team + @my_initials
    
    body = {
        name: "novotime"
    }.to_json
    header 'Content-Type', 'application/json'
    header 'Authorization', "Bearer #{@token}"
    put @url_team, body
    @response_contend = JSON.parse(last_response.body)
end

Quando("eu realizar a chamada PUT com as novas informações para um time que não é meu") do
    @url_team = @url_team + @other_initials
    
    body = {
        initials: "newt" ,
        name: "novotime"
    }.to_json
    header 'Content-Type', 'application/json'
    header 'Authorization', "Bearer #{@token}"
    put @url_team, body
    @response_contend = JSON.parse(last_response.body)
end

Quando("eu realizar a chamada PUT com as novas informações para um time que não existe") do
    @url_team = @url_team + @unknow_initials
    
    body = {
        initials: "newt" ,
        name: "novotime"
    }.to_json
    header 'Content-Type', 'application/json'
    header 'Authorization', "Bearer #{@token}"
    put @url_team, body
    @response_contend = JSON.parse(last_response.body)
end

Quando("eu realizar a chamada DEL para as initials do meu time") do
    @url_team = @url_team + @my_initials
    
    body = {}.to_json
    header 'Content-Type', 'application/json'
    header 'Authorization', "Bearer #{@token}"
    delete @url_team, body
    @response_contend = JSON.parse(last_response.body)
end

Quando("eu realizar a chamada DEL para as initials do time que não é meu") do
    @url_team = @url_team + @other_initials
    
    body = {}.to_json
    header 'Content-Type', 'application/json'
    header 'Authorization', "Bearer #{@token}"
    delete @url_team, body
    @response_contend = JSON.parse(last_response.body)
end

Quando("eu realizar a chamada DEL para as initials do time que não existe") do
    @url_team = @url_team + @unknow_initials
    
    body = {}.to_json
    header 'Content-Type', 'application/json'
    header 'Authorization', "Bearer #{@token}"
    delete @url_team, body
    @response_contend = JSON.parse(last_response.body)
end

Então("não receberei um erro") do
    begin
        expect(@response_contend['errors'].empty?).to  eq(true)
    rescue
        expect(@response_contend['errors'].nil?).to  eq(true)
    end
end

Então("receberei um erro") do
    expect(@response_contend['errors'].empty?).to  eq(false)
end

Então("recebo um JSON contendo as informações") do
    expect(last_response.status).to  eq(200)
end