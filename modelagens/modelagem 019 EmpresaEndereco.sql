
-- 21/08/2018 - Thales Silveira
-- script para criar a tabela de EmpresaEndereco

	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE EmpresaEndereco (
			Cnpj		    decimal(14,0) not null,
			IdEndereco		int not null
		)

		ALTER TABLE EmpresaEndereco ADD CONSTRAINT FK_EmpresaEndereco_Empresa
		FOREIGN KEY (Cnpj) REFERENCES Empresa(Cnpj)

		ALTER TABLE EmpresaEndereco ADD CONSTRAINT FK_EmpresaEndereco_Endereco
		FOREIGN KEY (IdEndereco) REFERENCES Endereco(Id)
	
	COMMIT