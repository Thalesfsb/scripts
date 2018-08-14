
-- 09/08/2018 - Thales Silveira
-- script para criar a tabela ChamadoTipo
	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE ChamadoTipo(
			Id		tinyint primary key not null,
			Nome	varchar(50) not null,
		)

	ROLLBACK --COMMIT