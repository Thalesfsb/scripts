
-- 20/08/2018 - Thales Silveira
-- script para criar a tabela de TelefoneTipo

	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE TelefoneTipo(
			Id		int not null,
			Nome	varchar(20) not null
		)
	
		ALTER TABLE TelefoneTipo ADD CONSTRAINT PK_TelefoneTipo
		PRIMARY KEY (Id)
				
		INSERT INTO TelefoneTipo (Id, Nome) VALUES (1, 'Residencial')
		INSERT INTO TelefoneTipo (Id, Nome) VALUES (2, 'Comercial')
		INSERT INTO TelefoneTipo (Id, Nome) VALUES (3, 'Celular')
		INSERT INTO TelefoneTipo (Id, Nome) VALUES (4, 'Recado')
		INSERT INTO TelefoneTipo (Id, Nome) VALUES (5, 'Fax')

	COMMIT