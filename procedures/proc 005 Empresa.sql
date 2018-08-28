
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
	Ex................: EXEC [dbo].[GKSSP_InsEmpresa] 12345678998000, 1, 1, 'Magazine&Cia', 'MagazineLuiza', 1
	
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
	@IdCliente int = NULL

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
							
		SELECT em.Id AS Id,	
			   em.Cnpj AS Cnpj,
			   em.RazaoSocial AS RazaoSocial,
			   em.NomeFantasia AS NomeFantasia,
			   em.DataInativacao AS DataInativacao,
			   t.DDD as Ddd,
			   t.Numero AS Numero,
			   e.Cep AS Cep,
			   e.Nom_Endereco AS NomEndereco,
			   e.Num_Endereco AS NumEndereco,
			   e.Bairro AS Bairro,
			   e.Cidade AS Cidade,
			   e.Uf AS Uf,
			   e.Complemento AS Complemento,			  
			   cl.Nome AS NomCliente
			FROM Empresa em WITH(NOLOCK)
				INNER JOIN Endereco e WITH(NOLOCK)
					ON e.Id = em.IdEnderecoPrincipal
				INNER JOIN Telefone t WITH(NOLOCK)
					ON t.Id = em.IdTelefonePrincipal
				LEFT JOIN Cliente cl WITH(NOLOCK)
					ON cl.IdEmpresa = em.Id
			WHERE (@IdCliente IS NULL OR cl.Id = @IdCliente)

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
				