
-- 09/08/2018 - Thales Silveira
-- script para criar a tabela TipoCriticidade

	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE TipoCriticidade(
			Id		tinyint not null,
			Nome	varchar(50) not null,
		)

		ALTER TABLE TipoCriticidade ADD CONSTRAINT PK_TipoCriticidade	
		PRIMARY KEY (Id)

		INSERT INTO TipoCriticidade (Id, Nome) VALUES (1, 'Baixo')
		INSERT INTO TipoCriticidade (Id, Nome) VALUES (2, 'Médio')
		INSERT INTO TipoCriticidade (Id, Nome) VALUES (3, 'Alto')

	COMMIT
	