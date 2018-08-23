
-- 09/08/2018 - Thales Silveira
-- script para criar a tabela de Empresa

	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE Empresa(
			Id						int identity(1,1) not null,
			IdTelefonePrincipal		int not null,
			IdEnderecoPrincipal		int not null,
			Cnpj					decimal(14,0) unique not null,
			RazaoSocial				varchar(50) not null,
			NomeFantasia			varchar(50) not null,
			IdColaboradorCad		int not null, 
			DataCadastro			dateTime not null,
			IdColaboradorAlt		int,		 
			DataAlteracao			dateTime,
			DataInativacao			dateTime
		)

		ALTER TABLE Empresa ADD CONSTRAINT PK_Empresa
		PRIMARY KEY (Id)

		ALTER TABLE Empresa ADD CONSTRAINT FK_Empresa_ColaboradorCad
		FOREIGN KEY (IdColaboradorCad) REFERENCES Colaborador(Id)

		ALTER TABLE Empresa ADD CONSTRAINT FK_Empresa_ColaboradorAlt
		FOREIGN KEY (IdColaboradorAlt ) REFERENCES Colaborador(Id)

		ALTER TABLE Empresa ADD CONSTRAINT FK_Empresa_Telefone
		FOREIGN KEY (IdTelefonePrincipal) REFERENCES Telefone(Id)

		ALTER TABLE Empresa ADD CONSTRAINT FK_Empresa_Endereco
		FOREIGN KEY (IdEnderecoPrincipal) REFERENCES Endereco(Id)
		
	COMMIT
	