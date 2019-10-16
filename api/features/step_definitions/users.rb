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