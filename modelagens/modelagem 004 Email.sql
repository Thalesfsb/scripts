
-- 20/08/2018 - Thales Silveira
-- script para criar a tabela de Email

	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE Email(
			Id			int identity(1,1) not null,
			EndEmail	varchar(50) not null
		)
	
		ALTER TABLE Email ADD CONSTRAINT PK_Email
		PRIMARY KEY (Id)

	COMMIT
