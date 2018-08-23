
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_InsCliente]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_InsCliente]
GO

CREATE PROCEDURE [dbo].[GKSSP_InsCliente]
	@Cpf					decimal(11,0),
	@Nome					varchar(50),		
	@IdEmpresa				int,			
	@IdColaboradorCad		int

	AS
	
	/*
	Documentação
	Arquivo Fonte.....: Cliente.sql
	Objetivo..........: Inserir dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_InsCliente] 23065241221, 'Edgar', 2, 1
	
	*/

	BEGIN
	
		INSERT INTO Cliente (Cpf, Nome, IdEmpresa, IdColaboradorCad, DataCadastro)
			VALUES (@Cpf, @Nome, @IdEmpresa, @IdColaboradorCad, GETDATE())

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
	Ex................: EXEC [dbo].[GKSSP_SelCliente] 23065241221

	*/

	BEGIN
		
		SELECT 	cl.Cpf,
				em.RazaoSocial AS NomeEmpresa,
				cl.Nome,
				cl.DataCadastro,
				colcad.Nome AS NomeColaboradorCad,
				cl.DataAlteracao,
				colalt.Nome AS NomeColaboradorAlT,
				cl.DataInativacao
			FROM Cliente cl WITH(NOLOCK)
				INNER JOIN Empresa em WITH(NOLOCK)
					ON em.Id = cl.IdEmpresa
				INNER JOIN Colaborador colcad WITH(NOLOCK)
					ON colcad.Id = cl.IdColaboradorCad
				LEFT JOIN Colaborador colalt WITH(NOLOCK)
					ON colalt.Id = cl.IdColaboradorAlt
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
				em.RazaoSocial AS NomeEmpresa,
				cl.Nome
			FROM Cliente cl WITH(NOLOCK)
				INNER JOIN Empresa em WITH(NOLOCK)
					ON em.Id = cl.IdEmpresa			

	END
GO
				
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_UpdCliente]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_UpdCliente]
GO

CREATE PROCEDURE [dbo].[GKSSP_UpdCliente]
	@Cpf						decimal(11,0),
	@Nome						varchar(50),		
	@IdEmpresa					int,			
	@IdColaboradorAlt			int

	AS

	/*
	Documentação
	Arquivo Fonte.....: Cliente.sql
	Objetivo..........: Atualizar dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 15/08/2018
	Ex................: EXEC [dbo].[GKSSP_UpdCliente] 23065241221, 'Edgar Momentum', 2, 1

	*/

	BEGIN
	
		UPDATE Cliente
			SET Nome = @Nome,
				IdEmpresa = @IdEmpresa,
				IdColaboradorAlt = @IdColaboradorAlt,
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
