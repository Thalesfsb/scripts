
-- 09/08/2018 - Thales Silveira
-- script para criar a tabela ColaboradorChamado

	USE SmnHelpDesk
	
	BEGIN TRAN

		CREATE TABLE ColaboradorChamado(
			IdChamado		int not null,
			IdColaborador	int not null			
		)
		
		ALTER TABLE ColaboradorChamado ADD CONSTRAINT PK_ColaboradorChamado
		PRIMARY KEY (IdChamado, IdColaborador)

		ALTER TABLE ColaboradorChamado ADD CONSTRAINT FK_ColaboradorChamado_Chamado
		FOREIGN KEY (IdChamado) REFERENCES Chamado(Id)

		ALTER TABLE ColaboradorChamado ADD CONSTRAINT FK_ColaboradorChamado_Colaborador
		FOREIGN KEY (IdColaborador) REFERENCES Colaborador(Id)

	COMMIT
