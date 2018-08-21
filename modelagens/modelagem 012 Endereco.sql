
-- 20/08/2018 - Thales Silveira
-- script para criar a tabela de Endereco

	USE SmnHelpDesk

	BEGIN TRAN

		CREATE TABLE Endereco(
			Id				int primary key identity(1,1),
			Cep				int not null,
			Nom_Endereco	varchar(50) not null,
			Num_Endereco	int not null,
			Complemento		varchar(30),
			Bairro			varchar(30) not null,
			Cidade			varchar(30) not null,
			Uf				char(2) not null,

		)

	COMMIT
	