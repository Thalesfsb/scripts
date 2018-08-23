
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_InsEmail]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_InsEmail]
GO

CREATE PROCEDURE [dbo].[GKSSP_InsEmail]
	@EndEmail	varchar(50)

	AS

	/*
	Documentação
	Arquivo Fonte.....: Email.sql
	Objetivo..........: Inserir dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 20/08/2018
	Ex................: EXEC [dbo].[GKSSP_InsEmail] 'fariataci07@hotmail.com'

	*/

	BEGIN
		
		INSERT INTO Email(EndEmail)
			VALUES (@EndEmail)

		RETURN SCOPE_IDENTITY()

	END
GO

	
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_UpdEmail]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_UpdEmail]
GO

CREATE PROCEDURE [dbo].[GKSSP_UpdEmail]
	@Id			int,
	@EndEmail	varchar(50)

	AS

	/*
	Documentação
	Arquivo Fonte.....: Email.sql
	Objetivo..........: Atualizar email
	Autor.............: SMN - Thales Silveira
 	Data..............: 20/08/2018
	Ex................: EXEC [dbo].[GKSSP_UpdEmail] 2, 'fariataci@hotmail.com'
	select * from email
	*/

	BEGIN
	
		UPDATE Email
			SET EndEmail = @EndEmail
			WHERE Id = @Id

	END
GO
				
				
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_DelEmail]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_DelEmail]
GO

CREATE PROCEDURE [dbo].[GKSSP_DelEmail]
	@Id	int

	AS

	/*
	Documentação
	Arquivo Fonte.....: Email.sql
	Objetivo..........: Deletar email
	Autor.............: SMN - Thales Silveira
 	Data..............: 20/08/2018
	Ex................: EXEC [dbo].[GKSSP_DelEmail] 3

	*/

	BEGIN
	
		DELETE FROM Email 
			WHERE Id = @Id

	END
GO
