Funcionalidade: Realizar login
    Como usuário
    Quero digitar minhas credenciais e ter meu login autorizado
    Para ter acesso a plataforma

Cenário: Login realizado com sucesso usando nickname
    Ao realizar o login, é feito o redirecionamento para o perfil do usuário.

    Dado que eu estou na página de login
    Quando eu preencho "Usuário ou e-mail" com "kayques"
    E eu preencho "Senha" com "123456789"
    E eu clico no botão "Entrar"
    Então sou redirecionado para o dashboard do Applada


Cenário: Login realizado com sucesso usando e-mail
    Ao realizar o login, é feito o redirecionamento para o perfil do usuário.

    Dado que eu estou na página de login
    Quando eu preencho "Usuário ou e-mail" com "skayque.lss@gmail.com"
    E eu preencho "Senha" com "123456789"
    E eu clico no botão "Entrar"
    Então sou redirecionado para o dashboard do Applada


Cenário: Falha no Login por causa de login errado
    Ao  tentar realizar o login, é mostrada a mensagem de falha o tentar realizar login.

    Dado que eu estou na página de login
    Quando eu preencho "Usuário ou e-mail" com "kaayques"
    E eu preencho "Senha" com "12345678"
    E eu clico no botão "Entrar"
    Então vejo na tela:
      """
      Usuário ou senha incorreta
      """

Cenário: Falha no Login por causa de senha errada
    Ao  tentar realizar o login, é mostrada a mensagem de falha o tentar realizar login.

    Dado que eu estou na página de login
    Quando eu preencho "Usuário ou e-mail" com "kayques"
    E eu preencho "Senha" com "eqgwah"
    E eu clico no botão "Entrar"
    Então vejo na tela:
      """
      Usuário ou senha incorreta
      """

Cenário: Falha no Login por causa de login e senha errados
    Ao  tentar realizar o login, é mostrada a mensagem de falha o tentar realizar login.

    Dado que eu estou na página de login
    Quando eu preencho "Usuário ou e-mail" com "kaayques"
    E eu preencho "Senha" com "eqgwah"
    E eu clico no botão "Entrar"
    Então vejo na tela:
      """
      Usuário ou senha incorreta
      """


 Cenário: Falha no Login por causa de login em branco
    Ao  tentar realizar o login, é mostrada a mensagem de falha o tentar realizar login.

    Dado que eu estou na página de login
    Quando eu preencho "Usuário ou e-mail" com "kayques"
    E eu preencho "Senha" com ""
    E eu clico no botão "Entrar"
    Então vejo na tela:
      """
      Preencha este campo.
      """


 Cenário: Falha no Login por causa de senha em branco
    Ao  tentar realizar o login, é mostrada a mensagem de falha o tentar realizar login.

    Dado que eu estou na página de login
    Quando eu preencho "Usuário ou e-mail" com ""
    E eu preencho "Senha" com "eqgwah"
    E eu clico no botão "Entrar"
    Então vejo na tela:
      """
      Preencha este campo.
      """


 Cenário: Falha no Login por causa de login e senha estão em branco
    Ao  tentar realizar o login, é mostrada a mensagem de falha o tentar realizar login.

    Dado que eu estou na página de login
    Quando eu preencho "Usuário ou e-mail" com ""
    E eu preencho "Senha" com ""
    E eu clico no botão "Entrar"
    Então vejo na tela:
      """
      Preencha este campo.
      """
