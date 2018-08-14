
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_InsColaborador]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_InsColaborador]
GO

CREATE PROCEDURE [dbo].[GKSSP_InsColaborador]
	@Cpf						decimal(14,0),
	@Nome						varchar(30),
	@Sobrenome					varchar(30),
	@Email						varchar(100),
	@UserName					varchar(50),
	@Senha						varchar(20),
	@IdTipoColaborador			tinyint,
	@IdColaboradorCadastro		int, 
	@DataCadastro				dateTime

	AS

	/*
	Documentação
	Arquivo Fonte.....: Colaborador.sql
	Objetivo..........: Inserir os dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_InsColaborador]

	*/

	BEGIN
		
		INSERT INTO Colaborador	(Cpf,
								 Nome,
								 Sobrenome,
								 Email,
								 UserName,
								 Senha,
								 IdTipoColaborador,
								 IdColaboradorCadastro,
								 DataCadastrO)

		VALUES					(@Cpf,
								 @Nome,
								 @Sobrenome,
								 @Email,
								 @UserName,
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
	Objetivo..........: Buscar dados colaborador
	Autor.............: SMN - Thales Silveira
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_SelColaborador]

	*/

	BEGIN
	   
	   SELECT Cpf,
			  Nome,
			  Sobrenome,
			  Email,
			  UserName,
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
	Objetivo..........: Buscar dados colaboradores
	Autor.............: SMN - Thales Silveira
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_SelColaboradores]

	*/

	BEGIN
		
		SELECT Cpf,
			   Nome,
			   Sobrenome,
			   Email,
			   UserName  
		FROM Colaborador WITH(NOLOCK)		

	END
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_UpdColaborador]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_UpdColaborador]
GO

CREATE PROCEDURE [dbo].[GKSSP_UpdColaborador]
	@Cpf						decimal(14,0),
	@Nome						varchar(30),
	@Sobrenome					varchar(30),
	@Email						varchar(100),
	@UserName					varchar(50),
	@Senha						varchar(20),
	@IdTipoColaborador			tinyint,
	@IdColaboradoAlteracao		int, 
	@DataAlteracao				dateTime

	AS

	/*
	Documentação
	Arquivo Fonte.....: Colaborador.sql
	Objetivo..........: Atualizar dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_UpdColaborador]

	*/

	BEGIN
		
		UPDATE Colaborador
			SET Cpf = @Cpf,
				Nome = @Nome,
				Sobrenome = @Sobrenome,
				Email = @Email,
				UserName = @UserName,
				Senha = @Senha,
				IdTipoColaborador = @IdTipoColaborador,
				IdColaboradorAlteracao = @IdColaboradoAlteracao,
				DataAlteracao = GETDATE()
			WHERE Cpf = @Cpf		

	END
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_DelColaborador]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_DelColaborador]
GO

CREATE PROCEDURE [dbo].[GKSSP_DelColaborador]
	@Cpf	decimal(14,0)

	AS

	/*
	Documentação
	Arquivo Fonte.....: Colaborador.sql
	Objetivo..........: Inativar colaborador
	Autor.............: SMN - Thales Silveira
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_DelColaborador]

	*/

	BEGIN
	
		UPDATE Colaborador
			SET DataInativacao = GETDATE()
			WHERE Cpf = @Cpf
			
	END
GO
				
				
				