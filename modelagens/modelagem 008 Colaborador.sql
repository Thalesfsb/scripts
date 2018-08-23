
-- 09/08/2018 - Thales Silveira
-- script para criar a tabela Colaborador

	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE Colaborador(
			Id							int identity(1,1) not null,
			Cpf							decimal(11,0) unique  not null,
			Nome						varchar(50) not null,
			Logon						varchar(50) not null,
			Senha						varchar(20) not null,
			IdTipoColaborador			tinyint not null,
			IdColaboradorCad			int not null, 
			DataCadastro				dateTime not null,
			IdColaboradorAlt			int,		  
			DataAlteracao				dateTime,
			DataInativacao				datetime
		)

		ALTER TABLE Colaborador ADD CONSTRAINT PK_Colaborador
		PRIMARY KEY (Id)

		ALTER TABLE Colaborador ADD CONSTRAINT FK_Colaborador_TipoColaborador
		FOREIGN KEY (IdTipoColaborador) REFERENCES TipoColaborador(Id)
		
		INSERT INTO Colaborador (Cpf, Nome, Logon, Senha, IdTipoColaborador, IdColaboradorCad, DataCadastro) 
			VALUES (11826065636, 'Thales Silveira', 'thales.silveira', '123', 1, 1, GETDATE())

		ALTER TABLE Colaborador ADD CONSTRAINT FK_Colaborador_ColaboradorCad
		FOREIGN KEY (IdColaboradorCad) REFERENCES Colaborador(Id)
	
		ALTER TABLE Colaborador ADD CONSTRAINT FK_Colaborador_ColaboradorAlt
		FOREIGN KEY (IdColaboradorAlt) REFERENCES Colaborador(Id)

	COMMIT


	