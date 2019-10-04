![AppLada-ModeloER](https://user-images.githubusercontent.com/41648891/65740964-e9a8b080-e0c0-11e9-83ef-4c307866f012.png)

### Tabelas:
**Usuario**(_login_, senha, nome, email, data_nascimento)

**Society**(_id_, _id_dono_, nome, latitude, longitude)
Society._id_dono_ referencia Usuario._login_

**Pelada**(_id_, _id_criador_, latitude, longitude, data_hora, data_criacao)
Pelada._id_criador_ referencia Usuario._login_

**Time**(_sigla_, nome)

**Torneio**(_id_, _id_criador_, latitude, longitude, data_hora, data_criacao)
Torneio._id_criador_ referencia Usuario._login_

**Partida**(_id_, _id_torneio_, latitude, longitude, data_hora, data_criacao)
Partida._id_torneio_ referencia Torneio._id_

**Marca_Presença_Pelada**(_id_jogador_, _id_pelada_)
Marca_Presença_Pelada._id_jogador_ referencia Usuario._login_
Marca_Presença_Pelada._id_pelada_ referencia Pelada._id_

**Marca_Presença_Torneio**(_id_jogador_, _id_torneio_)
Marca_Presença_Torneio._id_jogador_ referencia Usuario._login_
Marca_Presença_Torneio._id_torneio_ referencia Torneio._id_

**Segue**(_id_seguidor_, _id_seguido_)
Segue._id_seguidor_ referencia Usuario._login_
Segue._id_seguido_ referencia Usuario._login_

**Avalia**(_id_avaliador_, _id_society_, nota, comentario)
Avalia._id_avaliador_ referencia Usuario._login_
Avalia._id_society_ referencia Society._id_

**Integra_Time**(_id_integrante_, _id_time_, data_entrada, posicao)
Integra_Time._id_integrante_ referencia Usuario._login_
Integra_Time._id_time_ referencia Time._sigla_

**Joga_Partida**(_id_jogador_, _id_time_, _id_partida_, _id_torneio_, posicao_jogador)
Joga_Partida._id_integrante_ referencia Usuario._login_
Joga_Partida._id_time_ referencia Time._sigla_
Joga_Partida._id_partida_ referencia Partida._id_
Joga_Partida._id_torneio_ referencia Partida._id_torneio_

**Marca_Ponto**(_id_jogador_, _id_time_, _id_partida_, _id_torneio_, quantidade_pontos)
Marca_Ponto._id_integrante_ referencia Usuario._login_
Marca_Ponto._id_time_ referencia Time._sigla_
Marca_Ponto._id_partida_ referencia Partida._id_
Marca_Ponto._id_torneio_ referencia Partida._id_torneio_

