
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_InsClienteEmail]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_InsClienteEmail]
GO

CREATE PROCEDURE [dbo].[GKSSP_InsClienteEmail]
	@Cpf		decimal(11,0),
	@IdEmail	int	

	AS
	
	/*
	Documentação
	Arquivo Fonte.....: ClienteEmail.sql
	Objetivo..........: Inserir dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 21/08/2018
	Ex................: EXEC [dbo].[GKSSP_InsClienteEmail] 23065241221, 1
			
	*/

	BEGIN
	
		INSERT INTO ClienteEmail (Cpf, IdEmail)
			VALUES (@Cpf, @IdEmail)

	END
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_SelClienteEmails]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_SelClienteEmails]
GO

CREATE PROCEDURE [dbo].[GKSSP_SelClienteEmails]
	@Cpf	decimal(11,0)

	AS
	
	/*
	Documentação
	Arquivo Fonte.....: ClienteEmail.sql
	Objetivo..........: Buscar e-mails
	Autor.............: SMN - Thales Silveira
 	Data..............: 21/08/2018
	Ex................: EXEC [dbo].[GKSSP_SelClienteEmails] 23065241221
	*/

	BEGIN
	
		SELECT  ce.Cpf, 
				ce.IdEmail,
				e.EndEmail
			FROM ClienteEmail ce WITH(NOLOCK)
				INNER JOIN Email e WITH(NOLOCK)
					ON e.Id = ce.IdEmail
			WHERE ce.Cpf = @Cpf

	END
GO


IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_DelClienteEmail]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_DelClienteEmail]
GO

CREATE PROCEDURE [dbo].[GKSSP_DelClienteEmail]
	@IdEmail	int = NULL,
	@Cpf		decimal(11,0) = NULL

	AS

	/*
	Documentação
	Arquivo Fonte.....: Email.sql
	Objetivo..........: Deletar email
	Autor.............: SMN - Thales Silveira
 	Data..............: 21/08/2018
	Ex................: EXEC [dbo].[GKSSP_DelClienteEmail] 3, null

	*/

	BEGIN
	
		DELETE FROM ClienteEmail 
			WHERE (@IdEmail IS NULL OR IdEmail = @IdEmail)
			  AND (@Cpf IS NULL OR Cpf = @Cpf)

	END
GO

