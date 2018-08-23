
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_InsColaboradorEmail]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_InsColaboradorEmail]
GO

CREATE PROCEDURE [dbo].[GKSSP_InsColaboradorEmail]
	@Cpf		decimal(11,0),
	@IdEmail	int

	AS

	/*
	Documentação
	Arquivo Fonte.....: ColaboradorEmail.sql
	Objetivo..........: Inserir dados 
	Autor.............: SMN - Thales Silveira
 	Data..............: 21/08/2018
	Ex................: EXEC [dbo].[GKSSP_InsColaboradorEmail] 51618249649, 2
	
	*/

	BEGIN
	
		INSERT INTO ColaboradorEmail (Cpf, IdEmail)
			VALUES(@Cpf, @IdEmail)
	END
GO
	
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_SelColaboradorEmail]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_SelColaboradorEmail]
GO

CREATE PROCEDURE [dbo].[GKSSP_SelColaboradorEmail]
	@Cpf		decimal(11,0)

	AS

	/*
	Documentação
	Arquivo Fonte.....: ColaboradorEmail.sql
	Objetivo..........: Selecionar dados 
	Autor.............: SMN - Thales Silveira
 	Data..............: 21/08/2018
	Ex................: EXEC [dbo].[GKSSP_SeLColaboradorEmail] 51618249649

	*/

	BEGIN
	
		SELECT c.Cpf,
			   c.Nome,
			   e.Id,
			   e.EndEmail
		FROM ColaboradorEmail ce WITH(NOLOCK)
			INNER JOIN Email e WITH(NOLOCK)
				ON e.Id = ce.IdEmail
			INNER JOIN Colaborador c WITH(NOLOCK)
				ON c.Cpf = ce.Cpf
		WHERE c.Cpf = @Cpf

	END
GO
				
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_DelColaboradorEmail]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_DelColaboradorEmail]
GO

CREATE PROCEDURE [dbo].[GKSSP_DelColaboradorEmail]
	@Cpf		decimal(11,0) = NULL,
	@IdEmail	int = NULL

	AS

	/*
	Documentação
	Arquivo Fonte.....: ColaboradorEmail.sql
	Objetivo..........: Deletar dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 21/08/2018
	Ex................: EXEC [dbo].[GKSSP_DelColaboradorEmail] null, 3

	*/

	BEGIN
	
		DELETE FROM ColaboradorEmail
			WHERE(@Cpf IS NULL OR Cpf = @Cpf)
			  AND(@IdEmail IS NULL OR IdEmail = @IdEmail)

	END
GO
				