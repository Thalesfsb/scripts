
-- 09/08/2018 - Thales Silveira
-- script para criar a tabela ChamadoTipoStatus

	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE ChamadoTipoStatus(
			Id		tinyint primary key,
			Nome	varchar(50) not null,
		)

		INSERT INTO ChamadoTipoStatus (Id, Nome) VALUES (1, 'Pendente de análise')
		INSERT INTO ChamadoTipoStatus (Id, Nome) VALUES (2, 'Em análise')
		INSERT INTO ChamadoTipoStatus (Id, Nome) VALUES (3, 'Em homologação')
		INSERT INTO ChamadoTipoStatus (Id, Nome) VALUES (4, 'Pendente de publicação produção')
		INSERT INTO ChamadoTipoStatus (Id, Nome) VALUES (5, 'Publicado produção')
		INSERT INTO ChamadoTipoStatus (Id, Nome) VALUES (6, 'Concluído')

	COMMIT