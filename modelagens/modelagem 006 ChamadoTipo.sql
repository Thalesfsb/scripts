
-- 09/08/2018 - Thales Silveira
-- script para criar a tabela ChamadoTipo

	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE ChamadoTipo(
			Id		tinyint not null,
			Nome	varchar(50) not null,
		)

		ALTER TABLE ChamadoTipo ADD CONSTRAINT PK_ChamadoTipo
		PRIMARY KEY (Id)

		INSERT INTO ChamadoTipo (Id, Nome) VALUES (1, 'Erro')
		INSERT INTO ChamadoTipo (Id, Nome) VALUES (2, 'Solicitação')

	COMMIT