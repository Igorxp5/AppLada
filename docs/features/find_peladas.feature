Funcionalidade: Encontrar peladas
	Como usuário cadastrado e logado na plataforma
	Quero ver peladas próximas a mim, peladas nas quais me inscrevi e criar novas peladas
	Para criar, gerenciar, e participar de peladas

Cenário: Visualizar menu principal
	Ao logar corretamente na plataforma, eu tenho acesso ao menu principal

	Dado que eu sou um usuário cadastrado na plataforma
	Quando eu faço login credenciais
	Então eu sou redirecionado à rota "dashboard"
	E eu vejo meu login na tela
	E eu vejo um menu com os botões "Jogar", "Perfil", "Feed", "Times" e "Torneios"


Cenário: Visualizar página "Jogar"
	Estando logado na plataforma, eu tenho acesso à página "Jogar"
	
	Dado que eu estou na rota "Dashboard"
	Quando eu clico no botão "Jogar"
	Então eu vejo um submenu com três itens "Peladas Pŕoximas", "Minhas Peladas" e "Criar Pelada"
	E eu vejo um campo de pesquisa de peladas
	E eu vejo um mapa


Cenário: Ver peladas próximas
	Estando na página "Jogar", eu consigo visualizar peladas próximas a mim

	Dado que eu estou na página "Jogar"
	Quando eu clico na aba "Peladas Próximas"
	Então eu vejo uma lista de peladas
	E a lista contém os campos "Título", "Data/Hora", "Distância" e "Criado por"


Cenário: Ver "Minhas Peladas"
	Estando na página "Jogar", eu consigo visualizar peladas criadas por mim ou que eu participo

	Dado que eu estou na página "Jogar"
	Quando eu clico na aba "Minhas Peladas"
	Então eu vejo uma lista de peladas
	E a lista contém os campos "Título", "Data/Hora", "Distância" e "Situação"


Cenário: Ver "Criar Pelada"
	Estando na página "Jogar", eu consigo acessar a aba de criar peladas

	Dado que eu estou na página "Jogar"
	Quando eu clico na aba "Criar Pelada"
	Então eu vejo o formulário de criação de peladas
	E o formulário tem os campos "Título", "Data", "Hora de início", "Hora de conclusão" e "Descrição"
	E o formulário tem o botão "Criar pelada"
