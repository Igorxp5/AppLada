Funcionalidade: Criar peladas
    Como usuário cadastrado e logado na plataforma
    Quero criar uma pelada
    Para divulgar e convidar amigos
    
    
Cenário: Criar pelada com sucesso
    Ao preencher os campos do formulário "Criar pelada" corretamente, uma pelada é criada

    Dado que eu estou na página "Jogar", na aba "Criar pelada"
    Quando eu preencho "Título"  com "Pelada de Teste"
    E eu preencho "Data" com "01/01/2030"
    E eu preencho "De" com "20:00"
    E eu preencho "Até" com "21:00"
    E eu clico em "Criar pelada"
    Então eu vejo na tela 
      """
      Pelada criada com sucesso"
      """

    
Cenário: Ver pelada criada em "Minhas Peladas"
    Ao criar uma pelada, eu posso ver informações dela na aba "Minhas Peladas"
    
    Dado que eu estou na página "Jogar"
    Quando eu clico na aba "Minhas Peladas"
    Então eu vejo na tela "Pelada de Teste"


Cenário: Tentativa de criar pelada com os campos obrigatórios em branco
    Ao tentar criar uma pelada, com os obrigatórios em branco, é exibida uma mensagem para preencher os campos obrigatórios

    Dado eu estou na página "Jogar", na aba "Criar pelada"
    Quando eu preencho "Título"  com ""
    E eu preencho "Data" com ""
    E eu preencho "De" com ""
    E eu preencho "Até" com ""
    E eu clico em "Criar pelada"
    Então eu vejo na tela 
      """
      Preencha este campo
      """

    
