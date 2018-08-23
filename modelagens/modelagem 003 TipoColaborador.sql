
-- 09/08/2018 - Thales Silveira
-- script para criar a tabela de TipoColaborador

	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE TipoColaborador(
			Id		tinyint not null,
			Nome	varchar(20) not null
		)
		
		ALTER TABLE TipoColaborador ADD CONSTRAINT PK_TipoColaborador
		PRIMARY KEY (Id)

		INSERT INTO TipoColaborador (Id, Nome) VALUES (1, 'Master')
		INSERT INTO TipoColaborador (Id, Nome) VALUES (2, 'Colaborador')
	
	COMMIT