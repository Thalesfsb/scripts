	-- 09/08/2018 - Thales Silveira
-- script para criar a tabela ChamadoTipoStatus
	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE ChamadoTipoStatus(
			Id		tinyint primary key not null,
			Nome	varchar(50) not null,
		)

	ROLLBACK --COMMIT