
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_InsEmpresa]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_InsEmpresa]
GO

CREATE PROCEDURE [dbo].[GKSSP_InsEmpresa]
	@Cnpj						decimal(14,0),
	@RazaoSocial				varchar(50),
	@NomeFantasia				varchar(50),
	@IdColaboradorCadastro		int

	AS

	/*
	Documentação
	Arquivo Fonte.....: Empresa.sql
	Objetivo..........: Inserir dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_InsEmpresa] 12345678912346,  'MagazineLuiza&Empresa', 'MagazineLuiza', 1

	*/

	BEGIN
		
		INSERT INTO Empresa (Cnpj, RazaoSocial, NomeFantasia, IdColaboradorCadastro, DataCadastro)
			VALUES (@Cnpj, @RazaoSocial, @NomeFantasia, @IdColaboradorCadastro, GETDATE())		

	END
GO
				
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_SelEmpresa]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_SelEmpresa]
GO

CREATE PROCEDURE [dbo].[GKSSP_SelEmpresa]
	@Cnpj decimal(14,0)

	AS

	/*
	Documentação
	Arquivo Fonte.....: Empresa.sql
	Objetivo..........: Buscar dados empresa
	Autor.............: SMN - Thales Silveira
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_SelEmpresa] 12345678912345

	*/

	BEGIN
		
		SELECT em.Cnpj,
			   em.RazaoSocial,
			   em.NomeFantasia,
			   colcad.Nome AS NomeColaboradorCad,
			   em.DataCadastro,
			   colalt.Nome AS NomeColaboradorAlt,
			   em.DataAlteracao,
			   em.DataInativacao			
			FROM Empresa em WITH(NOLOCK)
				INNER JOIN Colaborador colcad WITH(NOLOCK)
					ON colcad.Id = em.IdColaboradorCadastro
				LEFT JOIN Colaborador colalt WITH(NOLOCK)
					ON colalt.Id = em.IdColaboradorAlteracao
			WHERE Cnpj = @Cnpj

	END
GO
				
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_SelEmpresas]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_SelEmpresas]
GO

CREATE PROCEDURE [dbo].[GKSSP_SelEmpresas]

	AS

	/*
	Documentação
	Arquivo Fonte.....: Empresa.sql
	Objetivo..........: Buscar dados empresas
	Autor.............: SMN - Thales Silveira
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_SelEmpresas]

	*/

	BEGIN
	
		SELECT em.Cnpj,
			   em.RazaoSocial,
			   em.NomeFantasia,
			   colcad.Nome AS NomeColaboradorCad,
			   em.DataCadastro,
			   colalt.Nome AS NomeColaboradorAlt,
			   em.DataAlteracao,
			   em.DataInativacao			
			FROM Empresa em WITH(NOLOCK)
				INNER JOIN Colaborador colcad WITH(NOLOCK)
					ON colcad.Id = em.IdColaboradorCadastro
				LEFT JOIN Colaborador colalt WITH(NOLOCK)
					ON colalt.Id = em.IdColaboradorAlteracao

	END
GO
				
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_UpdEmpresa]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_UpdEmpresa]
GO

CREATE PROCEDURE [dbo].[GKSSP_UpdEmpresa]
	@Cnpj						decimal(14,0),
	@RazaoSocial				varchar(50),
	@NomeFantasia				varchar(50),
	@IdColaboradorAlteracao		int,
	@DataAlteracao				dateTime 
	AS

	/*
	Documentação
	Arquivo Fonte.....: Empresa.sql
	Objetivo..........: Atualizar dados cadastrais
	Autor.............: SMN - Thales Silveira
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_UpdEmpresa]

	*/

	BEGIN
	
		UPDATE Empresa
			SET Cnpj = @Cnpj,
				RazaoSocial = @RazaoSocial,
				NomeFantasia = @NomeFantasia,
				IdColaboradorAlteracao = @IdColaboradorAlteracao,
				DataAlteracao = GETDATE()
			WHERE Cnpj = @Cnpj

	END
GO
				
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_DelEmpresa]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_DelEmpresa]
GO

CREATE PROCEDURE [dbo].[GKSSP_DelEmpresa]
	@Cnpj decimal(14,0)

	AS

	/*
	Documentação
	Arquivo Fonte.....: Empresa.sql
	Objetivo..........: Inativar empresa
	Autor.............: SMN - Thales Silveira
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_DelEmpresa]

	*/

	BEGIN
		
		UPDATE Empresa
			SET DataInativacao = GETDATE()
			WHERE Cnpj = @Cnpj

	END
GO
				