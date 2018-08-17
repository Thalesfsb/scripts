
-- 09/08/2018 - Thales Silveira
-- script para criar a tabela Cliente

	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE Cliente(
			Id						int primary key identity(1,1),
			Cpf						decimal(11,0) unique not null,
			Nome					varchar(50) not null,		
			IdEmpresa				int not null,			
			IdColaboradorCadastro	int not null, 
			DataCadastro			dateTime not null,
			IdColaboradorAlteracao	int,		 
			DataAlteracao			dateTime,
			DataInativacao			dateTime
		)

		ALTER TABLE Cliente ADD CONSTRAINT FK_Cliente_Empresa
		FOREIGN KEY (IdEmpresa )REFERENCES Empresa(Id)

		ALTER TABLE Cliente ADD CONSTRAINT FK_Cliente_ColaboradorCA
		FOREIGN KEY (IdColaboradorCadastro )REFERENCES Colaborador(Id)

		ALTER TABLE Cliente ADD CONSTRAINT FK_Cliente_ColaboradorAL
		FOREIGN KEY (IdColaboradorAlteracao) REFERENCES Colaborador(Id)

	COMMIT

		