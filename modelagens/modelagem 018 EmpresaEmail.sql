
-- 21/08/2018 - Thales Silveira
-- script para criar a tabela de EmpresaEmail

	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE EmpresaEmail (
			Cnpj		decimal(14,0) not null,
			IdEmail		int not null
		)

		ALTER TABLE EmpresaEmail ADD CONSTRAINT FK_EmpresaEmail_Empresa
		FOREIGN KEY (Cnpj) REFERENCES Empresa(Cnpj)

		ALTER TABLE EmpresaEmail ADD CONSTRAINT FK_EmpresaEmail_Email
		FOREIGN KEY (IdEmail) REFERENCES Email(Id)
	
	COMMIT