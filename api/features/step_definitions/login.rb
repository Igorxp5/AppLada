Before do
    DatabaseCleaner.clean_with(:deletion)
    user_teste = User.create!(login: "usernameteste", email: "username_teste@teste.com",
                        password: "senha_teste", name: "TestadorDoTime",
                        birthday: "30/01/2000", gender: "M")
    header 'Host', 'test.applada.com.br'
end

After do
    DatabaseCleaner.clean_with(:deletion)
end



Dado("que uma chamada POST seja feita no endpoint de login") do
    @url_login = 'login'
end

Quando("o campo login estiver preenchido com {string} e o campo password com {string}") do |string, string2|
    body = {login: string, password: string2}.to_json
    header 'Content-Type', 'application/json'
    post @url_login, body
    @response_contend = JSON.parse(last_response.body)
    @response_status = last_response.status
end

Quando("o campo email estiver preenchido com {string} e o campo password com {string}") do |string, string2|
    body = {email: string, password: string2}.to_json
    header 'Content-Type', 'application/json'
    post @url_login, body
    @response_contend = JSON.parse(last_response.body)
    @response_status = last_response.status
end

Então("recebo um JWT Token válido.") do
    expect(@response_status).to  eq(200)
end

Então("receberei o erro: {string}") do |string|
    expect(@response_contend['errors'][0]['message']).to  eq(string)
end