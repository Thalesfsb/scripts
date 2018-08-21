
-- 20/08/2018 - Thales Silveira
-- script para criar a tabela de ClienteEmail

	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE ClienteEmail (
			Cpf			decimal(11,0) not null,
			IdEmail		int not null
		)

		ALTER TABLE ClienteEmail ADD CONSTRAINT FK_ClienteEmail_Cliente
		FOREIGN KEY (Cpf) REFERENCES Cliente(Cpf)

		ALTER TABLE ClienteEmail ADD CONSTRAINT FK_ClienteEmail_Email
		FOREIGN KEY (IdEmail) REFERENCES Email(Id)
	
	COMMIT