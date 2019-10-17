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
	19: "Recursno não encontrado",
	20: "Token inválido ou vazio",
	21: "Token expirou"
}

export default function getError(errorCode) {
	if (errorCodes[errorCode] !== undefined) {
		return errorCodes[errorCode];
	}
	return errorCodes[0] + " (" + errorCode + ")"
}