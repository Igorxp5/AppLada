Before do
  user_teste = User.create!(login: "username_teste", email: "username_teste@teste.com",
                     password: "senha_teste", name: "TestadorDoTime",
                     birthday: "30/01/2000", gender: "M")
end

Dado("que uma chamada POST seja feita no endpoint de login") do
    @url_login = 'api.applada.com.br/login'
end

Quando("o campo login estiver preenchido com {string} e o campo password com {string}") do |string, string2|
  @response = HTTParty.post(@url_login, :body => {"login": string, "password": string2})
end

Então("recebo um JWT Token válido.") do
    begin
        JsonWebToken.decode(@response.body['data']['token'])
    rescue
        raise "Invalid JWT Token"
    end
end

Então("recebo o erro: {string}") do |string|
    expect(@response.body['errors'][0]['message']).to  eq(string)
end