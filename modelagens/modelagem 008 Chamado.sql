
-- 09/08/2018 - Thales Silveira
--script para criar a tabela Chamado

	USE SmnHelpDesk
	
	BEGIN TRAN
		
		CREATE TABLE Chamado(
			Id						int primary key identity(1,1) not null,
			NumeroChamado			int not null,
			Nome					varchar(50) not null,
			Descricao				varchar(500) not null,
			IdCriticidade			tinyint not null,
			IdTipo					tinyint not null,
			IdStatus				tinyint not null,
			IdClienteCadastro		int not null, 
			DataCadastro			dateTime not null,
			IdClienteAlteracao		int,		 
			DataAlteracao			dateTime,
		)		

		ALTER TABLE Chamado ADD CONSTRAINT FK_Chamado_TiposCriticidade
		FOREIGN KEY (IdCriticidade) REFERENCES TipoCriticidade(Id)

		ALTER TABLE Chamado ADD CONSTRAINT FK_Chamado_ChamadoTipo
		FOREIGN KEY (IdTipo)REFERENCES ChamadoTipo(Id)

		ALTER TABLE Chamado ADD CONSTRAINT FK_Chamado_ChamadoTipoStatus
		FOREIGN KEY (IdStatus) REFERENCES ChamadoTipoStatus(Id)		

		ALTER TABLE Chamado ADD CONSTRAINT FK_Chamado_ClienteCA
		FOREIGN KEY (IdClienteCadastro )REFERENCES Cliente(Id)

		ALTER TABLE Chamado ADD CONSTRAINT FK_Chamado_ClienteAL
		FOREIGN KEY (IdClienteAlteracao) REFERENCES Cliente(Id)

	ROLLBACK --COMMIT
