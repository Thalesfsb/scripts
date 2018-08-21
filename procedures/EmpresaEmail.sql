
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_InsEmpresaEmail]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_InsEmpresaEmail]
GO

CREATE PROCEDURE [dbo].[GKSSP_InsEmpresaEmail]
	@Cnpj		decimal(14,0),
	@IdEmail	int

	AS

	/*
	Documentação
	Arquivo Fonte.....: EmpresaEmail.sql
	Objetivo..........: Inserir dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 21/08/2018
	Ex................: EXEC [dbo].[GKSSP_InsEmpresaEmail] 12345678912345, 4

	*/

	BEGIN
	
		INSERT INTO EmpresaEmail (Cnpj, IdEmail)
			VALUES (@Cnpj, @IdEmail)

	END
GO
		
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_SelEmpresaEmails]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_SelEmpresaEmails]
GO

CREATE PROCEDURE [dbo].[GKSSP_SelEmpresaEmails]
	@Cnpj	decimal(14,0)

	AS

	/*
	Documentação
	Arquivo Fonte.....: EmpresaEmail.sql
	Objetivo..........: Buscar emails
	Autor.............: SMN - Thales Silveira
 	Data..............: 21/08/2018
	Ex................: EXEC [dbo].[GKSSP_SelEmpresaEmails] 12345678912345

	*/

	BEGIN
	
		SELECT  ee.IdEmail,
				ee.Cnpj,
				em.RazaoSocial,
				e.Endereco	
		FROM EmpresaEmail ee WITH(NOLOCK)
			INNER JOIN Email e WITH(NOLOCK)
				ON e.Id = ee.IdEmail
			INNER JOIN Empresa em WITH(NOLOCK)
				ON em.Cnpj = ee.Cnpj
		WHERE ee.Cnpj = @Cnpj

	END
GO
						
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_DelEmpresaEmail]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_DelEmpresaEmail]
GO

CREATE PROCEDURE [dbo].[GKSSP_DelEmpresaEmail]
	@IdEmail	int = NULL,
	@Cnpj		decimal(14,0) = NULL

	AS

	/*
	Documentação
	Arquivo Fonte.....: EmpresaEmail.sql
	Objetivo..........: Deletar emails
	Autor.............: SMN - Thales Silveira
 	Data..............: 21/08/2018
	Ex................: EXEC [dbo].[GKSSP_DelEmpresaEmail] 3

	*/

	BEGIN
	
		DELETE FROM EmpresaEmail
			WHERE (@IdEmail IS NULL OR IdEmail = @IdEmail) 
			   AND(@Cnpj IS NULL OR Cnpj = @Cnpj)
	END
GO
				