Funcionalidade: Recuperar senha
     Como usuário
     Quero recuperar minha senha
     Para retormar o acesso a plataforma


Cenário: Redirecionamento para tela "Esqueci minha senha"
    Ao clicar no link "esqueci minha senha", é feito redirecionamento para a tela de recuperar senha.

    Dado que eu estou na página de login
    Quando eu clico no link "Esqueci minha senha"
    Então eu sou redirecionado para a página "Esqueci minha senha"


Cenário: Senha recuperada com sucesso utilizando nickname
    Ao clicar no botão enviar, o usuário deverá ver mensagem confirmando envio do link de recuperação de senha.

    Dado que eu estou na página de recuperar senha
    Quando eu preencho o campo "Usuário ou e-mail" com "kayques"
    E eu clico no botão "Enviar"
    Então vejo na tela:
      """
      Link enviado para seu e-mail
      """


Cenário: Senha recuperada com sucesso utilizando e-mail
    Ao clicar no botão enviar, o usuário deverá ver mensagem confirmando envio do link de recuperação de senha.

    Dado que eu estou na página de recuperar senha
    Quando eu preencho o campo "Usuário ou e-mail" com "skayque.lss@gmail.com"
    E eu clico no botão "Enviar"
    Então vejo na tela:
      """
      Link enviado para seu e-mail
      """


Cenário: Tentativa de recuperar senha utilizando nickname ou e-mail inexistente
    Ao clicar no botão enviar, o usuário deverá ver mensagem de erro.

    Dado que eu estou na página de recuperar senha
    Quando eu preencho o campo "Usuário ou e-mail" com "eqgwah"
    E eu clico no botão "Enviar"
    Então vejo na tela:
      """
      Conta não existe
      """


Cenário: Tentativa de recuperar senha deixando campo em brancho
    Ao clicar no botão enviar, o usuário deverá ver mensagem de erro.

    Dado que eu estou na página de recuperar senha
    Quando eu preencho o campo "Usuário ou e-mail" com ""
    E eu clico no botão "Enviar"
    Então vejo na tela:
      """
      Preencha este campo.
      """
