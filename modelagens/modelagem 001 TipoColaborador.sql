
-- 09/08/2018 - Thales Silveira
--script para criar a tabela de TipoColaborador

	CREATE DATABASE SmnHelpDesk

	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE TipoColaborador(
			Id		tinyint primary key,
			Nome	varchar(20) not null
		)
	
		INSERT INTO TipoColaborador (Id, Nome) VALUES (1, 'Master')
		INSERT INTO TipoColaborador (Id, Nome) VALUES (2, 'Colaborador')
	
	COMMIT
	