
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_InsColaborador]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_InsColaborador]
GO

CREATE PROCEDURE [dbo].[GKSSP_InsColaborador]
	@Cpf						decimal(14,0),
	@Nome						varchar(30),
	@Sobrenome					varchar(30),
	@Email						varchar(100),
	@Senha						varchar(20),
	@IdTipoColaborador			tinyint,
	@IdColaboradorCadastro		int, 
	@DataCadastro				dateTime

	AS

	/*
	Documentação
	Arquivo Fonte.....: Colaborador.sql
	Objetivo..........: Inserir os dados cadastrais de um colaborador
	Autor.............: SMN - Thales Silveira
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_InsColaborador]

	*/

	BEGIN
		
		INSERT INTO Colaborador	(Cpf,
								 Nome,
								 Sobrenome,
								 Email,
								 Senha,
								 IdTipoColaborador,
								 IdColaboradorCadastro,
								 DataCadastrO)

		VALUES					(@Cpf,
								 @Nome,
								 @Sobrenome,
								 @Email,
								 @Senha,
								 @IdTipoColaborador,
								 @IdColaboradorCadastro,
								 GETDATE())		

	END
GO


IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_SelColaborador]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_SelColaborador]
GO

CREATE PROCEDURE [dbo].[GKSSP_SelColaborador]
	@Cpf decimal(14,0)

	AS

	/*
	Documentação
	Arquivo Fonte.....: Colaborador.sql
	Objetivo..........: Buscar dados de um colaborador
	Autor.............: SMN - Thales Silveira
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_SelColaborador]

	*/

	BEGIN
	   
	   SELECT Cpf,
			  Nome,
			  Sobrenome,
			  Email,
			  IdTipoColaborador,
			  IdColaboradorCadastro,
			  DataCadastro
		FROM Colaborador WITH(NOLOCK)
		WHERE Cpf = @Cpf
		

	END
GO
		
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_SelColaboradores]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_SelColaboradores]
GO

CREATE PROCEDURE [dbo].[GKSSP_SelColaboradores]

	AS

	/*
	Documentação
	Arquivo Fonte.....: Colaborador.sql
	Objetivo..........: buscar os dados dos calaboradores
	Autor.............: SMN - Thales Silveira
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_SelColaboradores]

	*/

	BEGIN
		
		SELECT Cpf,
			   Nome,
			   Sobrenome,
			   Email,
			   

		FROM Colaborador
		

	END
GO
						