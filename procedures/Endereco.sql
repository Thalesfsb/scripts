
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_InsEndereco]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_InsEndereco]
GO

CREATE PROCEDURE [dbo].[GKSSP_InsEndereco]
	@Cep			int,
	@Nom_Endereco	varchar(50),
	@Num_Endereco	int,
	@Complemento	varchar(30) = NULL,
	@Bairro			varchar(30),
	@Cidade			varchar(30),
	@Uf				char(2)  

	AS

	/*
	Documentação
	Arquivo Fonte.....: Endereco.sql
	Objetivo..........: Inserir dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 20/08/2018
	Ex................: EXEC [dbo].[GKSSP_InsEndereco] 37900000, 'Onze de dezembro', 370, null, 'Candeias', 'Passos', 'MG'

	*/

	BEGIN
	
		INSERT INTO Endereco(Cep, Nom_Endereco, Num_Endereco, Complemento, Bairro, Cidade, Uf)
			VALUES(@Cep, @Nom_Endereco, @Num_Endereco, @Complemento, @Bairro, @Cidade, @Uf)

	END
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_UpdEndereco]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_UpdEndereco]
GO

CREATE PROCEDURE [dbo].[GKSSP_UpdEndereco]
	@Id				int,
	@Cep			int,
	@Nom_Endereco	varchar(50),
	@Num_Endereco	int,
	@Complemento	varchar(30),
	@Bairro			varchar(30),
	@Cidade			varchar(30),
	@Uf				char(2)  

	AS

	/*
	Documentação
	Arquivo Fonte.....: Endereco.sql
	Objetivo..........: Atualizar dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 20/08/2018
	Ex................: EXEC [dbo].[GKSSP_UpdEndereco] 

	*/

	BEGIN
		
		UPDATE Endereco
			SET Cep = @Cep,
				Nom_Endereco = @Nom_Endereco,
				Num_Endereco = @Num_Endereco,
				Complemento = @Complemento,
				Bairro = @Bairro,
				Cidade = @Cidade,
				Uf = @Uf
			WHERE Id = @Id

	END
GO
				
			
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_DelEndereco]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_DelEndereco]
GO

CREATE PROCEDURE [dbo].[GKSSP_DelEndereco]
	@Id int

	AS

	/*
	Documentação
	Arquivo Fonte.....: Endereco.sql
	Objetivo..........: Deletar endereco
	Autor.............: SMN - Thales Silveira
 	Data..............: 20/08/2018
	Ex................: EXEC [dbo].[GKSSP_DelEndereco] 

	*/

	BEGIN
	
		DELETE Endereco 
			WHERE Id = @Id

	END
GO
					
				