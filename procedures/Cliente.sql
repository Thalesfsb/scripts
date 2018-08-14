
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_InsCliente]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_InsCliente]
GO

CREATE PROCEDURE [dbo].[GKSSP_InsCliente]
	@Cpf					decimal(11,0),
	@Nome					varchar(30),		
	@Sobrenome				varchar(30),
	@Email					varchar(100),
	@UserName				varchar(50),
	@Senha					varchar(20),
	@IdEmpresa				int,			
	@IdColaboradorCadastro	int, 
	@DataCadastro			dateTime 

	AS

	/*
	Documentação
	Arquivo Fonte.....: Cliente.sql
	Objetivo..........: Inserir dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_InsCliente]

	*/

	BEGIN
	
		INSERT INTO Cliente (Cpf,
							 Nome,
							 Sobrenome,
							 Email,
							 UserName,
							 Senha,
							 IdEmpresa,
							 IdColaboradorCadastro,
							 DataCadastro)

		VALUES			   (@Cpf,
							@Nome,
						    @Sobrenome,
						    @Email,
						    @UserName,
						    @Senha,
						    @IdEmpresa,
						    @IdColaboradorCadastro,
						    GETDATE())

	END
GO
				
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_SelCliente]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_SelCliente]
GO

CREATE PROCEDURE [dbo].[GKSSP_SelCliente]
	@Cpf	decimal(11,0) 

	AS

	/*
	Documentação
	Arquivo Fonte.....: Cliente.sql
	Objetivo..........: Buscar dadoS cliente
	Autor.............: SMN - Thales Silveira
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_SelCliente]

	*/

	BEGIN
		
		SELECT 
			Cpf,
			Nome,
			Sobrenome,
			Email,
			UserName,
			IdColaboradorCadastro,
			DataCadastro
		FROM Cliente WITH(NOLOCK)
		WHERE Cpf = @Cpf

	END
GO
				
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_SelClientes]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_SelClientes]
GO

CREATE PROCEDURE [dbo].[GKSSP_SelClientes]

	AS

	/*
	Documentação
	Arquivo Fonte.....: Cliente.sql
	Objetivo..........: Buscar dados clientes
	Autor.............: SMN - Thales Silveira
 	Data..............: 01/01/2017
	Ex................: EXEC [dbo].[GKSSP_SelClientes]

	*/

	BEGIN
	
		SELECT 
			Cpf,
			Nome,
			Sobrenome,
			IdEmpresa,
			Email,
			UserName,
			IdColaboradorCadastro,
			DataCadastro
		FROM Cliente WITH(NOLOCK)

	END
GO
				