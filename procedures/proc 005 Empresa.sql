
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_InsEmpresa]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_InsEmpresa]
GO

CREATE PROCEDURE [dbo].[GKSSP_InsEmpresa]
	@Cnpj						decimal(14,0),
	@IdTelefonePrincipal		int,
	@IdEnderecoPrincipal		int,
	@RazaoSocial				varchar(50),
	@NomeFantasia				varchar(50),
	@IdColaboradorCad			int

	AS

	/*
	Documentação
	Arquivo Fonte.....: Empresa.sql
	Objetivo..........: Inserir dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_InsEmpresa] 12345678998745, 1, 1, 'Momentum&Cia', 'Momentum', 1
	
	*/

	BEGIN
		
		INSERT INTO Empresa (Cnpj, IdTelefonePrincipal, IdEnderecoPrincipal, RazaoSocial, NomeFantasia, IdColaboradorCad, DataCadastro)
			VALUES (@Cnpj, @IdTelefonePrincipal, @IdEnderecoPrincipal, @RazaoSocial, @NomeFantasia, @IdColaboradorCad, GETDATE())		

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
	Ex................: EXEC [dbo].[GKSSP_SelEmpresa] 12345678998745
	
	*/

	BEGIN
		SELECT em.Id,
			   em.Cnpj,
			   em.RazaoSocial,
			   em.NomeFantasia,
			   e.Nom_Endereco,
			   e.Num_Endereco,
			   e.Complemento,
			   e.Bairro,
			   e.Cep,
			   e.Cidade,
			   e.Uf,
			   tt.Nome,
			   t.DDD,
			   t.Numero,
			   t.Ramal			   
			FROM Empresa em WITH(NOLOCK)
				INNER JOIN Endereco e WITH(NOLOCK)
					ON e.Id = em.IdEnderecoPrincipal 
				INNER JOIN Telefone t WITH(NOLOCK)
					ON t.Id = em.IdTelefonePrincipal
				INNER JOIN TelefoneTipo tt WITH(NOLOCK)
					ON tt.Id = t.IdTelefoneTipo
			WHERE em.Cnpj = @Cnpj

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
	
		SELECT em.NomeFantasia,
			   ee.Nom_Endereco,
			   ee.Num_Endereco,
			   ee.Bairro,
			   ee.Cidade,
			   ee.Uf,
			   t.DDD,
			   t.Numero
			FROM Empresa em WITH(NOLOCK)
				INNER JOIN Endereco ee WITH(NOLOCK)
					ON ee.Id = em.IdEnderecoPrincipal
				INNER JOIN Telefone t WITH(NOLOCK)
					ON t.Id = em.IdTelefonePrincipal

	END
GO
				
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_UpdEmpresa]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_UpdEmpresa]
GO

CREATE PROCEDURE [dbo].[GKSSP_UpdEmpresa]
	@Cnpj						decimal(14,0),
	@IdTelefonePrincipal		int,
	@IdEnderecoPrincipal		int,
	@RazaoSocial				varchar(50),
	@NomeFantasia				varchar(50),
	@IdColaboradorAlt			int

	AS

	/*
	Documentação
	Arquivo Fonte.....: Empresa.sql
	Objetivo..........: Atualizar dados cadastrais
	Autor.............: SMN - Thales Silveira
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_UpdEmpresa] 12345678998745, 1, 1, 'Momentum&Cia', 'Momentum', 2

	*/

	BEGIN
	
		UPDATE Empresa
			SET Cnpj = @Cnpj,
				IdTelefonePrincipal = @IdTelefonePrincipal,
				IdEnderecoPrincipal = @IdEnderecoPrincipal,
				RazaoSocial = @RazaoSocial,
				NomeFantasia = @NomeFantasia,
				IdColaboradorAlt = @IdColaboradorAlt,
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
				