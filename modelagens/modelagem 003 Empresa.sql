
-- 09/08/2018 - Thales Silveira
-- script para criar a tabela de Empresa

	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE Empresa(
			Id						int primary key identity(1,1),
			Cnpj					decimal(14,0) unique not null,
			RazaoSocial				varchar(50) not null,
			NomeFantasia			varchar(50) not null,
			IdColaboradorCadastro	int not null, 
			DataCadastro			dateTime not null,
			IdColaboradorAlteracao	int,		 
			DataAlteracao			dateTime,
			DataInativacao			dateTime
		)

		ALTER TABLE Empresa ADD CONSTRAINT FK_Empresa_ColaboradorCA
		FOREIGN KEY (IdColaboradorCadastro) REFERENCES Colaborador(Id)

		ALTER TABLE Empresa ADD CONSTRAINT FK_Empresa_ColaboradorAL
		FOREIGN KEY (IdColaboradorAlteracao ) REFERENCES Colaborador(Id)

	COMMIT
	