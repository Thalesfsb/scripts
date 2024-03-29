 
-- 09/08/2018 - Thales Silveira
-- script para criar a tabela ChamadoHistoricoStatus
	
	USE SmnHelpDesk
	
	BEGIN TRAN
		
		CREATE TABLE ChamadoHistoricoStatus(
			Id				int identity (1,1) not null,
			IdChamado		int not null,
			IdStatus		tinyint not null,
			DataCadastro	datetime not null,
			IdColaborador	int,
			IdCliente		int
			
		)

		ALTER TABLE ChamadoHistoricoStatus ADD CONSTRAINT PK_ChamadoHistoricoStatus
		PRIMARY KEY (Id)

		ALTER TABLE ChamadoHistoricoStatus ADD CONSTRAINT FK_ChamadoHistoricoStatus_Chamado
		FOREIGN KEY (IdChamado) REFERENCES Chamado(Id)
	
		ALTER TABLE ChamadoHistoricoStatus ADD CONSTRAINT FK_ChamadoHistoricoStatus_ChamadoTipoStatus
		FOREIGN KEY (IdStatus) REFERENCES ChamadoTipoStatus(Id)
		
		ALTER TABLE ChamadoHistoricoStatus ADD CONSTRAINT FK_ChamadoHistoricoStatus_Colaborador
		FOREIGN KEY (IdColaborador) REFERENCES Colaborador(Id)
	
		ALTER TABLE ChamadoHistoricoStatus ADD CONSTRAINT FK_ChamadoHistoricoStatus_Cliente
		FOREIGN KEY (IdCliente) REFERENCES Cliente(Id)

	COMMIT

	
