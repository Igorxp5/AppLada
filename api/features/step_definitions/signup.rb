Before do
    DatabaseCleaner.clean_with(:deletion)
    user_teste = User.create!(login: "username_teste", email: "username_teste@teste.com",
                        password: "senha_teste", name: "TestadorDoTime",
                        birthday: "30/01/2000", gender: "M")
    header 'Host', 'test.applada.com.br'
end

After do
    DatabaseCleaner.clean_with(:deletion)
end



Dado("que uma chamada POST seja feita no endpoint de signup") do
    @url_signup = 'signup'
end

Quando("o campo login estiver preenchido com {string} e o campo password com {string} e o campo name com {string} e o campo email com {string} e o campo birthday com {string} e o campo gender com {string}") do |string, string2, string3, string4, string5, string6|
    begin
        body = {login: string, password: string2, name: string3, email: string4, birthday: string5, gender: string6}.to_json
        header 'Content-Type', 'application/json'
        post @url_signup, body
        @response_contend = JSON.parse(last_response.body)
    rescue
        @flag = true
    end
end

Então("não recebo erros") do
    expect(@response_contend['errors']).to  eq([])
end

Então("recebo um erro: {string}") do |string|
    begin
        expect(@response_contend['errors'][0]['message']).to  eq(string)
    rescue
        expect(@flag).to  eq(true)
    end
end