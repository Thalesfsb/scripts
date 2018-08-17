
-- 09/08/2018 - Thales Silveira
--script para criar a tabela Colaborador

	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE Colaborador(
			Id							int primary key identity(1,1),
			Cpf							decimal(11,0) unique  not null,
			Nome						varchar(50) not null,
			Email						varchar(100) not null,
			Logon						varchar(50) not null,
			Senha						varchar(20) not null,
			IdTipoColaborador			tinyint not null,
			IdColaboradorCadastro		int not null, 
			DataCadastro				dateTime not null,
			IdColaboradorAlteracao		int,		  
			DataAlteracao				dateTime,
			DataInativacao				datetime
		)

		ALTER TABLE Colaborador ADD CONSTRAINT FK_Colaborador_TipoColaborador
		FOREIGN KEY (IdTipoColaborador) REFERENCES TipoColaborador(Id)

		INSERT INTO Colaborador (Cpf, Nome, Email, Logon, Senha, IdTipoColaborador, IdColaboradorCadastro, DataCadastro) 
			VALUES (11826065636, 'Thales Silveira', 'thales.silveira@smn.com.br', 'thales.silveira', '123', 1, 1, GETDATE())

		ALTER TABLE Colaborador ADD CONSTRAINT FK_Colaborador_ColaboradorCA
		FOREIGN KEY (IdColaboradorCadastro) REFERENCES Colaborador(Id)

		ALTER TABLE Colaborador ADD CONSTRAINT FK_Colaborador_ColaboradorAL
		FOREIGN KEY (IdColaboradorAlteracao) REFERENCES Colaborador(Id)

	COMMIT


