
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_InsEmpresaEndereco]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_InsEmpresaEndereco]
GO

CREATE PROCEDURE [dbo].[GKSSP_InsEmpresaEndereco]
	@Cnpj			decimal(14,0),
	@IdEndereco		int

	AS

	/*
	Documentação
	Arquivo Fonte.....: EmpresaEndereco.sql
	Objetivo..........: Inserir dados endereco
	Autor.............: SMN - Thales Silveira
 	Data..............: 21/08/2018
	Ex................: EXEC [dbo].[GKSSP_InsEmpresaEndereco] 12345678998745, 2

	*/

	BEGIN
	
		INSERT INTO EmpresaEndereco (Cnpj, IdEndereco)
			VALUES (@Cnpj, @IdEndereco)

	END
GO
		
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_SelEmpresaEndereco]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_SelEmpresaEndereco]
GO

CREATE PROCEDURE [dbo].[GKSSP_SelEmpresaEndereco]
	@Cnpj			decimal(14,0)

	AS

	/*
	Documentação
	Arquivo Fonte.....: EmpresaEndereco.sql
	Objetivo..........: Buscar dados endereços
	Autor.............: SMN - Thales Silveira
 	Data..............: 21/08/2018
	Ex................: EXEC [dbo].[GKSSP_SelEmpresaEndereco] 12345678998745

	*/

	BEGIN
	
		SELECT ee.Cnpj,
			   ee.IdEndereco,
			   e.Nom_Endereco,
			   e.Num_Endereco,
			   e.Complemento,
			   e.Bairro,
			   e.Cidade,
			   e.Uf
		FROM EmpresaEndereco ee WITH(NOLOCK)
			INNER JOIN Endereco e WITH(NOLOCK)
				ON e.Id = ee.IdEndereco
		WHERE ee.Cnpj = @Cnpj

	END
GO
		
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_DelEmpresaEndereco]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_DelEmpresaEndereco]
GO

CREATE PROCEDURE [dbo].[GKSSP_DelEmpresaEndereco]
	@Cnpj			decimal(14,0) = NULL,
	@IdEndereco		int = NULL

	AS

	/*
	Documentação
	Arquivo Fonte.....: EmpresaEndereco.sql
	Objetivo..........: Deletar dados endereços
	Autor.............: SMN - Thales Silveira
 	Data..............: 21/08/2018
	Ex................: EXEC [dbo].[GKSSP_DelEmpresaEndereco] 12345678998745, 2

	*/

	BEGIN
	
		DELETE FROM EmpresaEndereco
			WHERE (@IdEndereco IS NULL OR IdEndereco = @IdEndereco)
			   AND(@Cnpj IS NULL OR Cnpj = @Cnpj)
	END
GO
					