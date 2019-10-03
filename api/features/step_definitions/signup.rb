Before do
    user_teste = User.create!(login: "username_teste", email: "username_teste@teste.com",
                        password: "senha_teste", name: "TestadorDoTime",
                        birthday: "30/01/2000", gender: "M")
    header 'Host', 'api.applada.com.br'
end


Dado("que uma chamada POST seja feita no endpoint de signup") do
    @url_signup = 'signup'
end

Quando("o campo login estiver preenchido com {string} e o campo password com {string} e o campo name com {string} e o campo email com {string} e o campo birthday com {string} e o campo gender com {string}") do |string, string2, string3, string4, string5, string6|
    body = {login: string, password: string2, name: string3, email: string4, birthday: string5, gender: string6}.to_json
    header 'Content-Type', 'application/json'
    post @url_signup, body
    @response_contend = JSON.parse(last_response.body)
end

Então("recebo como resposta o meu login: {string} e minha senha: {string}") do |string, string2|
    response_login = @response_contend['data']['login']
    response_password = @response_contend['data']['password']
    expect(response_login).to  eq(string)
    expect(response_password).to  eq(string2)
end

Então("recebo um erro: {string}") do |string|
    #puts @response_contend['errors']
    expect(@response_contend['errors'][0]['message']).to  eq(string)
end