
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_InsColaboradorEmpresa]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_InsColaboradorEmpresa]
GO

CREATE PROCEDURE [dbo].[GKSSP_InsColaboradorEmpresa]
	@IdEmpresa		int,
	@IdColaborador  int 
	
	AS

	/*
	Documentação
	Arquivo Fonte.....: ColaboradorEmpresa.sql
	Objetivo..........: Inserir dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 16/08/2018
	Ex................: EXEC [dbo].[GKSSP_InsColaboradorEmpresa]

	*/

	BEGIN
	
		INSERT INTO ColaboradorEmpresa (IdColaborador, IdEmpresa)
			VALUES (@IdColaborador, @IdEmpresa)

	END
GO
				
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_SelColaboradorEmpresa]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_SelColaboradorEmpresa]
GO

CREATE PROCEDURE [dbo].[GKSSP_SelColaboradorEmpresa]

	AS

	/*
	Documentação
	Arquivo Fonte.....: ColaboradorEmpresa.sql
	Objetivo..........: Buscar dados 
	Autor.............: SMN - Thales Silveira
 	Data..............: 16/08/2018
	Ex................: EXEC [dbo].[GKSSP_SelColaboradorEmpresa]

	*/

	BEGIN
	
		SELECT IdColaborador,
			   c.Nome,	
			   IdEmpresa,
			   em.NomeFantasia
			FROM ColaboradorEmpresa ce WITH(NOLOCK)
				INNER JOIN Empresa em WITH(NOLOCK)
					ON em.Id = ce.IdEmpresa
				INNER JOIN Colaborador c WITH(NOLOCK)
					ON c.Id = ce.IdColaborador

	END
GO
				