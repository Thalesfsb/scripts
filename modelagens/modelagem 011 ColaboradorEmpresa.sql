
-- 16/08/2018 - Thales Silveira
-- script para criar a tabela ColaboradorEmpresa

	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE ColaboradorEmpresa(
			IdColaborador	int not null,
			IdEmpresa		int not null
		)

		ALTER TABLE ColaboradorEmpresa ADD CONSTRAINT PK_ColaboradorEmpresa
		PRIMARY KEY (IdColaborador, IdEmpresa)

		ALTER TABLE ColaboradorEmpresa ADD CONSTRAINT FK_ColaboradorEmpresa_Colaborador
		FOREIGN KEY (IdColaborador) REFERENCES Colaborador(Id)

		ALTER TABLE ColaboradorEmpresa ADD CONSTRAINT FK_ColaboradorEmpresa_Empresa
		FOREIGN KEY (IdEmpresa) REFERENCES Empresa(Id)
	
	COMMIT