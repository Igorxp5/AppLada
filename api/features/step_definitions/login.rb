Before do
  #@user_teste = User.create
  #@user_teste.login = "username_teste",
  #@user_teste.name = "Testador do time",
  #@user_teste.email = "username_teste@teste.com",
  #@user_teste.password = "senha_teste",
  #@user_teste.birthday = "30/01/2000",
  #@user_teste.gender = "M"
  
  @user_teste = User.create(login: "username_teste", email: "username_teste@teste.com",
                     password: "senha_teste", name: "Testador do time",
                     birthday: "30/01/2000", gender: "M")
  @user_teste.save
end

After do
  print User.find_by_login("username_teste")
  print "AQUIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
end

Dado("que uma chamada POST seja feita no endpoint de login") do
  pending
end

Quando("o campo {string} estiver preenchido com {string}") do |string, string2|
  pending # Write code here that turns the phrase above into concrete actions
end

Então("recebo um JWT Token.") do
  pending # Write code here that turns the phrase above into concrete actions
end

Então("recebo um erro: {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end