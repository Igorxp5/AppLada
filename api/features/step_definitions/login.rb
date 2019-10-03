Before do
    DatabaseCleaner.clean_with(:deletion)
    user_teste = User.create!(login: "username_teste", email: "username_teste@teste.com",
                        password: "senha_teste", name: "TestadorDoTime",
                        birthday: "30/01/2000", gender: "M")
    header 'Host', 'api.applada.com.br'
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
end

Então("recebo um JWT Token válido.") do
    begin
        JsonWebToken.decode(@response_contend['data']['token'])
    rescue
        raise "Invalid JWT Token"
    end
end

Então("recebo o erro: {string}") do |string|
    expect(@response_contend['errors'][0]['message']).to  eq(string)
end