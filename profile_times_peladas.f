
Funcionalidade: Ver meu histórico de peladas e times
      Como usuário cadastrado e logado na plataforma
      Quero visualizar os times que participo, e as peladas que eu participei/me inscrevi
      Para ver meu histórico no sistema
 
 
 Cenário: Visualizar página "Perfil"
      Estando logado na plataforma, eu tenho acesso à página "Perfil"

      Dado que eu estou na rota "Dashboard"
      Quando eu clico no botão "Perfil"
      Então eu vejo um submenu com cinco itens: "Feed", "Times", "Peladas", "Seguindo", "Seguidores"
      E eu vejo um campo de pesquisa de jogador
 
 
Cenário: Ver "Times"
	Estando na página "Perfil", eu consigo visualizar os times que eu participo

	Dado que eu estou na página "Perfil"
	Quando eu clico na aba "Times"
	Então eu vejo uma lista de times


Cenário: Ver "Minhas Peladas"
	Estando na página "Jogar", eu consigo visualizar peladas criadas por mim ou que eu participo

	Dado que eu estou na página "Perfil"
	Quando eu clico na aba "Peladas"
	Então eu vejo uma lista de peladas
	E a lista contém os campos "Título", "Data/Hora", "Distância" e "Situação"


