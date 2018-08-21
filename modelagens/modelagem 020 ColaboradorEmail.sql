
-- 21/08/2018 - Thales Silveira
-- script para criar a tabela de ColaboradorEmail

	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE ColaboradorEmail(
			Cpf		decimal(11,0) not null,
			IdEmail	int not null
		)
	
		ALTER TABLE ColaboradorEmail ADD CONSTRAINT FK_ColaboradorEmail_Colaborador
		FOREIGN KEY (Cpf) REFERENCES Colaborador(Cpf)

		ALTER TABLE ColaboradorEmail ADD CONSTRAINT FK_ColaboradorEmail_Email
		FOREIGN KEY (IdEmail) REFERENCES Email(Id)
	
	COMMIT