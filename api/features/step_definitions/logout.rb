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
    
end

After do
    DatabaseCleaner.clean_with(:deletion)
end



Dado("que faça uma chamada em {string}") do |string|
    @url_logout = string
end

Quando("eu realizar a requisição utilizando o metódo POST") do
    begin
        body = {}.to_json
        header 'Content-Type', 'application/json'
        header 'Authorization', "Bearer #{@token}"
        post @url_logout, body
        @response_contend = JSON.parse(last_response.body)
    rescue
        @flag = false
    end
end

Quando("eu realizar a requisição utilizando o metódo POST sem credenciais") do
    begin
        body = {}.to_json
        header 'Content-Type', 'application/json'
        post @url_logout, body
        @response_contend = JSON.parse(last_response.body)
    rescue
        @flag = true
    end
end

Quando("eu realizar a requisição utilizando o metódo GET") do
    begin
        body = {}.to_json
        header 'Content-Type', 'application/json'
        header 'Authorization', "Bearer #{@token}"
        get @url_logout, body
        @response_contend = JSON.parse(last_response.body)
    rescue
        @flag = true
    end
end

Quando("eu realizar a requisição utilizando o metódo PUT") do
    begin
        body = {}.to_json
        header 'Content-Type', 'application/json'
        header 'Authorization', "Bearer #{@token}"
        put @url_logout, body
        @response_contend = JSON.parse(last_response.body)
    rescue
        @flag = true
    end
end

Quando("eu realizar a requisição utilizando o metódo DEL") do
    begin
        body = {}.to_json
        header 'Content-Type', 'application/json'
        header 'Authorization', "Bearer #{@token}"
        delete @url_logout, body
        @response_contend = JSON.parse(last_response.body)
    rescue
        @flag = true
    end
end

Então("recebo um JSON sem conter erros") do
    expect(@flag).to  eq(false)
end

Então("recebo uma mensagem de erro") do
    expect(@flag).to  eq(true)
end