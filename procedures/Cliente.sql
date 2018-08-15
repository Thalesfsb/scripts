
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
	@IdColaboradorCadastro	int

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
	
		INSERT INTO Cliente (Cpf, Nome, Sobrenome, Email, UserName, Senha, IdEmpresa, IdColaboradorCadastro, DataCadastro)
			VALUES (@Cpf, @Nome, @Sobrenome, @Email, @UserName, @Senha, @IdEmpresa, @IdColaboradorCadastro, GETDATE())

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
	Objetivo..........: Buscar dados cliente
	Autor.............: SMN - Thales Silveira
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_SelCliente]

	*/

	BEGIN
		
		SELECT 	cl.Cpf,
				em.RazaoSocial AS Empresa,
				cl.Nome,
				cl.Sobrenome,
				cl.Email,
				cl.UserName,
				cl.DataCadastro,
				colcad.Nome,
				colcad.Sobrenome,
				cl.DataAlteracao,
				colalt.Nome,
				colalt.Sobrenome,
				cl.DataInativacao
			FROM Cliente cl WITH(NOLOCK)
				INNER JOIN Empresa em WITH(NOLOCK)
					ON em.Id = cl.IdEmpresa
				INNER JOIN Colaborador colcad WITH(NOLOCK)
					ON colcad.IdColaboradorCadastro = cl.IdColaboradorCadastro
				LEFT JOIN Colaborador colalt WITH(NOLOCK)
					ON colalt.IdColaboradorAlteracao = cl.IdColaboradorAlteracao
			WHERE cl.Cpf = @Cpf

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
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_SelClientes]

	*/

	BEGIN
	
		SELECT 	cl.Cpf,
				em.RazaoSocial AS Empresa,
				cl.Nome,
				cl.Sobrenome,
				cl.Email,
				cl.UserName,
				cl.DataCadastro,
				colcad.Nome,
				colcad.Sobrenome,
				cl.DataAlteracao,
				colalt.Nome,
				colalt.Sobrenome,
				cl.DataInativacao
			FROM Cliente cl WITH(NOLOCK)
				INNER JOIN Empresa em WITH(NOLOCK)
					ON em.Id = cl.IdEmpresa
				INNER JOIN Colaborador colcad WITH(NOLOCK)
					ON colcad.IdColaboradorCadastro = cl.IdColaboradorCadastro
				LEFT JOIN Colaborador colalt WITH(NOLOCK)
					ON colalt.IdColaboradorAlteracao = cl.IdColaboradorAlteracao

	END
GO
				
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_UpdCliente]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_UpdCliente]
GO

CREATE PROCEDURE [dbo].[GKSSP_UpdCliente]
	@Cpf						decimal(11,0),
	@Nome						varchar(30),		
	@Sobrenome					varchar(30),
	@Email						varchar(100),
	@UserName					varchar(50),
	@Senha						varchar(20),
	@IdEmpresa					int,			
	@IdColaboradorAlteracao		int

	AS

	/*
	Documentação
	Arquivo Fonte.....: Cliente.sql
	Objetivo..........: Atualizar dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 15/08/2018
	Ex................: EXEC [dbo].[GKSSP_UpdCliente]

	*/

	BEGIN
	
		UPDATE Cliente
			SET Cpf = @Cpf,
				Nome = @Nome,
				Sobrenome = @Sobrenome,
				Email = @Email,
				UserName = @UserName,
				Senha = @Senha,
				IdEmpresa = @IdEmpresa,
				IdColaboradorAlteracao = @IdColaboradorAlteracao,
				DataAlteracao = GETDATE()
			WHERE Cpf = @Cpf

	END
GO
				
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_DelCliente]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_DelCliente]
GO

CREATE PROCEDURE [dbo].[GKSSP_DelCliente]
	@Cpf decimal(11,0)

	AS

	/*
	Documentação
	Arquivo Fonte.....: Cliente.sql
	Objetivo..........: Inativa cliente
	Autor.............: SMN - Thales Silveira
 	Data..............: 15/08/2018
	Ex................: EXEC [dbo].[GKSSP_DelCliente]

	*/

	BEGIN
		
		UPDATE Cliente
			SET DataInativacao = GETDATE()
			WHERE Cpf = @Cpf

	END
GO
				