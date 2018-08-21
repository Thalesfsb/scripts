
-- 20/08/2018 - Thales Silveira
-- script para criar a tabela de Email

	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE Email(
			Id			int primary key identity(1,1),
			Endereco	varchar(50) not null
		)
	
	COMMIT
