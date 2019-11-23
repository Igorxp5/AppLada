const errorCodes = {
	0: "Ocorreu um erro desconhecido",
	1: "Senha muito curta (mínimo é 8 caracteres)",
	2: "Senha muito longa (máximo é 16 caracteres)",
	3: "Email inválido",
	4: "O campo Usuário está vazio",
	5: "O campo Data de Nascimento está vazio",
	6: "O campo Email está vazio",
	7: "O campo Nome está vazio",
	8: "O campo Senha está vazio",
	9: "O campo Genêro está vazio",
	10: "O Email já foi utlizado",
	11: "O Usuário já foi utilziado",
	12: "Data de Nascimento não pode ser no futuro",
	13: "Genêro inválido",
	14: "Genêro deve ser 'M', 'F' ou 'O'",
	15: "Nome deve ter somente letras",
	16: "Acesso não autorizado",
	17: "Parâmetros inválidos",
	18: "Usuário ou senha incorreta",
	19: "Recurso não encontrado",
	20: "Token inválido ou vazio",
	21: "Token expirou",
	22: "Longitude inválida",
	23: "Latitude inválida",
	24: "Longitude não pode ser vazia",
	25: "ID da partida inválida",
	26: "Permissão negada",
	27: "Usuário não encontrado",
	28: "Login ou e-mail é necessário",
	29: "Você já segue este usuário",
	30: "Você não está seguindo este usuário",
	31: "Você não pode seguir você mesmo",
	32: "Você não tem permissão para realizar essa ação",
	33: "Inicias do time é obrigatório",
	34: "Inicias do time já utilizadas",
	35: "Esse nome já foi utilizado",
	36: "Limite deve ser igual ou menor que 20",
	37: "Este membro não está no time",
	38: "Data de início é obrigatório",
	39: "Data de fim é obrigatório",
	40: "Latitude é inválida",
	41: "Longitude é inválida",
	42: "Latitude é obrigatória",
	43: "Data de início não pode ser no passado",
	44: "Data de fim não pode ser no passado",
	45: "Data de início não pode ser antes da data de início",
	46: "Data de fim deve ser no mínimo uma hora depois que a data de início",
	47: "O raio de procura deve ser no máximo 10",
	48: "Você não pode sair de uma pelada que não participa",
	49: "Você já está participando dessa pelada",
	50: "Este jogo foi removido porque não tinha mais participantes",
	51: "Título é obrigatório",
	52: "Este membro não está no time ou não existe",
	53: "Você não tem convites pendentes deste time",
	54: "Este usuário já é membro do time",
	55: "Telefone inválidos",
	56: "Telefone inválido. Formato é: +5500111111111",
	57: "A nota deve ser entre 0 e 5",
	58: "O dono do society não pode avaliar o próprio society",
	59: "Você já avaliou este society",
	60: "Selecion um society",
	61: "O society não existe",
	62: "Data do fim da inscrição é obrigatório",
	63: "Data fim dever no mínimo um dia a mais da data de ínicio",
	64: "Data de inscrição deve ser antes da data de início",
	65: "Data de início deve ser no minímo uma hora depois da data de fim da inscrição",
	66: "Limite de times é obrigatório",
	67: "Limite do time deve ser um número",
	68: "Preço deve ser um número",
	69: "Society só pode ter um torneio ativo",
	70: "Time precisa ser escolhido",
	71: "Time não encontrado",
	72: "O time já enviou uma requisição",
	73: "Este time não está inscrito",
	74: "Valor de status inválido",
	75: "Este time já foi aceito",
	76: "Este time já foi recusado",
	77: "Deve ser selecionado dois times",
	78: "Times não estão inscritos no torneio",
	79: "O scoreboard deve ser númerico",
	80: "Vencedor não pode ser um perdedor",
	81: "Vencedor não encnotrado nas inscrições do torneio",
	82: "Perdedor não encnotrado nas inscrições do torneio",
	83: "Vencedor e perdedor só podem ser definidos se a partida tiver finalizado",
	84: "Vencedor e perdedor só podem ser definidos se a partida tiver finalizado",
	85: "Ranking deve ser uma lista com as inicias dos times",
	86: "Ranking deve ter somente times inscritos",
	87: "A data de início da partida deve ser durante o torneio"
}

export default function getError(errorCode) {
	if (errorCodes[errorCode] !== undefined) {
		return errorCodes[errorCode];
	}
	return errorCodes[0] + " (" + errorCode + ")"
}