
-- 09/08/2018 - Thales Silveira
-- script para criar a tabela Cliente

	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE Cliente(
			Id						int identity(1,1) not null,
			Cpf						decimal(11,0) unique not null,
			Nome					varchar(50) not null,		
			IdEmpresa				int not null,			
			IdColaboradorCad		int not null, 
			DataCadastro			dateTime not null,
			IdColaboradorAlt		int,		 
			DataAlteracao			dateTime,
			DataInativacao			dateTime
		)

		ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente
		PRIMARY KEY (Id)

		ALTER TABLE Cliente ADD CONSTRAINT FK_Cliente_Empresa
		FOREIGN KEY (IdEmpresa) REFERENCES Empresa(Id)

		ALTER TABLE Cliente ADD CONSTRAINT FK_Cliente_ColaboradorCad
		FOREIGN KEY (IdColaboradorCad) REFERENCES Colaborador(Id)

		ALTER TABLE Cliente ADD CONSTRAINT FK_Cliente_ColaboradorAlt
		FOREIGN KEY (IdColaboradorAlt) REFERENCES Colaborador(Id)

	COMMIT

		