
-- 21/08/2018 - Thales Silveira
-- script para criar a tabela de EmpresaTelefone

	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE EmpresaTelefone (
			Cnpj		decimal(14,0) not null,
			IdTelefone	int not null
		)

		ALTER TABLE EmpresaTelefone ADD CONSTRAINT FK_Cnpj_Empresa
		FOREIGN KEY (Cnpj) REFERENCES Empresa(Cnpj)

		ALTER TABLE EmpresaTelefone ADD CONSTRAINT FK_Cnpj_Telefone
		FOREIGN KEY (IdTelefone) REFERENCES Telefone(Id)
	
	COMMIT