
-- 09/08/2018 - Thales Silveira
-- script para criar a tabela TipoCriticidade
	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE TipoCriticidade(
			Id		tinyint primary key not null,
			Nome	varchar(50) not null,
		)

		INSERT INTO TipoCriticidade(Id, Nome) VALUES(1, 'Alto')
		INSERT INTO TipoCriticidade(Id, Nome) VALUES(2, 'Médio')
		INSERT INTO TipoCriticidade(Id, Nome) VALUES(3, 'Baixo')

	ROLLBACK --COMMIT
	