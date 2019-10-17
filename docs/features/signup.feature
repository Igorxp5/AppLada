Funcionalidade: Realizar cadastro
     Como usuário
     Quero digitar meus dados e me cadastrar na plataforma
     Para ter acesso a plataforma


Cenário: Redirecionamento para tela de cadastro
    Ao  clicar no link de criar conta, o usuário é redirecionado para a tela de cadastro.

    Dado que eu estou na página de login
    Quando eu clico no link "Criar uma conta"
    Então eu sou redirecionado para a tela Registrar-se.


Cenário: Cadastro realizado com sucesso
   Ao realizar o cadastro, é feito o redirecionamento para a tela de login.
 
    Dado que eu estou na página de registro
    Quando eu preencho "Nome" com "Usuário Teste Applada".
    E eu preencho "Usuário" com "AppladaTestUser"
    E eu preencho "E-mail" com "applada_teste_user@adb.def"
    E eu preencho "dd/mm/aaaa" com "01/01/2000"
    E eu preencho "Senha" com "appladateste"
    E eu preencho "Confirmar Senha" com "appladateste"
    E eu clico no botão "Criar conta"
    Então vejo na tela:
      """
      Usuário criado com sucesso
      """
    Então sou redirecionado para a página "Entrar"


Cenário: Login de cadastro recém criado realizado com sucesso usando nickname
    Ao realizar o login, é feito o redirecionamento para o perfil do usuário.

    Dado que eu estou na página de login
    Quando eu preencho "Usuário ou e-mail" com "AppladaTestUser"
    E eu preencho "Senha" com "appladateste"
    E eu clico no botão "Entrar"
    Então sou redirecionado para o dashboard do Applada


Cenário: Login de cadastro recém criado realizado com sucesso usando e-mail
    Ao realizar o login, é feito o redirecionamento para o perfil do usuário.

    Dado que eu estou na página de login
    Quando eu preencho "Usuário ou e-mail" com "applada_teste_user@adb.def"
    E eu preencho "Senha" com "appladateste"
    E eu clico no botão "Entrar"
    Então sou redirecionado para o dashboard do Applada


Cenário: Tentativa de cadastro com todos os campos obrigatórios em branco
   Ao tentar realizar o cadastro, com campos obrigatórios estejam em branco, é exibida uma mensagem para preencher os campos obrigatórios
 
    Dado que eu estou na página de registro
    Quando eu preencho "Nome" com ""
    E eu preencho "Usuário" com ""
    E eu preencho "E-mail" com ""
    E eu preencho "dd/mm/aaaa" com ""
    E eu preencho "Senha" com ""
    E eu preencho "Confirmar Senha" com ""
    E eu clico no botão "Criar conta"
    Então vejo na tela:
      """
      Preencha este campo
      """


Cenário: Tentativa de cadastro com e-mail inválido 1
   Ao tentar realizar o cadastro, com um e-mail que não possua @, é exibida uma mensagem para consertar o e-mail
 
    Dado que eu estou na página de registro
    Quando eu preencho "Nome" com "Usuario Teste Applada".
    E eu preencho "Usuário" com "AppladaTestUser"
    E eu preencho "E-mail" com "applada_teste_user"
    E eu preencho "dd/mm/aaaa" com "01/01/2000"
    E eu preencho "Senha" com "appladateste"
    E eu preencho "Confirmar Senha" com "appladateste"
    E eu clico no botão "Criar conta"
    Então vejo na tela:
      """
      Inclua um "@" no endereço de e-mail. "appladateste" está com um "@" faltando.
      """


Cenário: Tentativa de cadastro com e-mail inválido 2
   Ao tentar realizar o cadastro, com um e-mail que não possua @, é exibida uma mensagem para consertar o e-mail
 
    Dado que eu estou na página de registro
    Quando eu preencho "Nome" com "Usuario Teste Applada".
    E eu preencho "Usuário" com "AppladaTestUser"
    E eu preencho "E-mail" com "applada_teste_user@abc."
    E eu preencho "dd/mm/aaaa" com "01/01/2000"
    E eu preencho "Senha" com "appladateste"
    E eu preencho "Confirmar Senha" com "appladateste"
    E eu clico no botão "Criar conta"
    Então vejo na tela:
      """
      "." está sendo usado em uma posição incorreta em "abc".
      """


Cenário: Tentativa de cadastro com senhas diferentes
   Ao realizar o cadastro, é feito o redirecionamento para a tela de login.
 
    Dado que eu estou na página de registro
    Quando eu preencho "Nome" com "Usuário Teste Applada".
    E eu preencho "Usuário" com "AppladaTestUser"
    E eu preencho "E-mail" com "applada_teste_user@adb.def"
    E eu preencho "dd/mm/aaaa" com "01/01/2000"
    E eu preencho "Senha" com "appladateste"
    E eu preencho "Confirmar Senha" com "applada"
    E eu clico no botão "Criar conta"
    Então vejo na tela:
      """
      As senhas não coincidem
      """


Cenário: Tentativa de cadastro com nickname e e-mail já utilizados
   Ao realizar o cadastro, é feito o redirecionamento para a tela de login.
 
    Dado que eu estou na página de registro
    Quando eu preencho "Nome" com "Usuário Teste Applada".
    E eu preencho "Usuário" com "AppladaTestUser"
    E eu preencho "E-mail" com "applada_teste_user@adb.def"
    E eu preencho "dd/mm/aaaa" com "01/01/2000"
    E eu preencho "Senha" com "appladateste"
    E eu preencho "Confirmar Senha" com "applada"
    E eu clico no botão "Criar conta"
    Então vejo na tela:
      """
      O Usuário já foi utilizado
      O Email já foi utilizado
      """
