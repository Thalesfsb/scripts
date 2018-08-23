
-- 09/08/2018 - Thales Silveira
-- script para criar a tabela Chamado

	USE SmnHelpDesk
	
	BEGIN TRAN
		
		CREATE TABLE Chamado(
			Id						int identity(1,1) not null,
			NumeroChamado			int not null,
			NomeProblema			varchar(50) not null,
			Descricao				varchar(500) not null,
			IdCriticidade			tinyint not null,
			IdTipo					tinyint not null,
			IdStatus				tinyint not null,
			IdClienteCad			int not null, 
			DataCadastro			dateTime not null,
			IdClienteAlt			int,		 
			DataAlteracao			dateTime,
		)		

		ALTER TABLE Chamado ADD CONSTRAINT PK_Chamado
		PRIMARY KEY (Id) 

		ALTER TABLE Chamado ADD CONSTRAINT FK_Chamado_TiposCriticidade
		FOREIGN KEY (IdCriticidade) REFERENCES TipoCriticidade(Id)

		ALTER TABLE Chamado ADD CONSTRAINT FK_Chamado_ChamadoTipo
		FOREIGN KEY (IdTipo) REFERENCES ChamadoTipo(Id)

		ALTER TABLE Chamado ADD CONSTRAINT FK_Chamado_ChamadoTipoStatus
		FOREIGN KEY (IdStatus) REFERENCES ChamadoTipoStatus(Id)		

		ALTER TABLE Chamado ADD CONSTRAINT FK_Chamado_ClienteCad
		FOREIGN KEY (IdClienteCad) REFERENCES Cliente(Id)

		ALTER TABLE Chamado ADD CONSTRAINT FK_Chamado_ClienteAlt
		FOREIGN KEY (IdClienteAlt) REFERENCES Cliente(Id)

	COMMIT
