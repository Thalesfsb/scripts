
-- 21/08/2018 - Thales Silveira
-- script para criar a tabela de EmpresaTelefone

	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE EmpresaTelefone (
			Cnpj		decimal(14,0) not null,
			IdTelefone	int not null
		)

		ALTER TABLE EmpresaTelefone ADD CONSTRAINT PK_EmpresaTelefone_Empresa
		PRIMARY KEY (Cnpj, IdTelefone)

		ALTER TABLE EmpresaTelefone ADD CONSTRAINT FK_EmpresaTelefone_Empresa
		FOREIGN KEY (Cnpj) REFERENCES Empresa(Cnpj)

		ALTER TABLE EmpresaTelefone ADD CONSTRAINT FK_EmpresaTelefone_Telefone
		FOREIGN KEY (IdTelefone) REFERENCES Telefone(Id)
	
	COMMIT