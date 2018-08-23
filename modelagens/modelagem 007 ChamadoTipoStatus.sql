
-- 09/08/2018 - Thales Silveira
-- script para criar a tabela ChamadoTipoStatus

	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE ChamadoTipoStatus(
			Id		tinyint not null,
			Nome	varchar(50) not null,
		)

		ALTER TABLE ChamadoTipoStatus ADD CONSTRAINT PK_ChamadoTipoStatus
		PRIMARY KEY (Id)

		INSERT INTO ChamadoTipoStatus (Id, Nome) VALUES (1, 'Pendente de an�lise')
		INSERT INTO ChamadoTipoStatus (Id, Nome) VALUES (2, 'Em an�lise')
		INSERT INTO ChamadoTipoStatus (Id, Nome) VALUES (3, 'Em homologa��o')
		INSERT INTO ChamadoTipoStatus (Id, Nome) VALUES (4, 'Pendente de publica��o produ��o')
		INSERT INTO ChamadoTipoStatus (Id, Nome) VALUES (5, 'Publicado produ��o')
		INSERT INTO ChamadoTipoStatus (Id, Nome) VALUES (6, 'Conclu�do')

	COMMIT