
-- 20/08/2018 - Thales Silveira
-- script para criar a tabela de Telefone

	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE Telefone(
			Id				int primary key identity(1,1),
			IdTelefoneTipo  int not null,
			DDD				tinyint not null,
			Numero			int not null,
			Ramal			int 
		)

		ALTER TABLE Telefone ADD CONSTRAINT FK_Telefone_TelefoneTipo
		FOREIGN KEY (IdTelefoneTipo) REFERENCES TelefoneTipo(Id)

	COMMIT