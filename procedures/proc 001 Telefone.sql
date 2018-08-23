
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_InsTelefone]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_InsTelefone]
GO

CREATE PROCEDURE [dbo].[GKSSP_InsTelefone]
	@IdTelefoneTipo		int,
	@DDD				tinyint,
	@Numero				int,
	@Ramal				tinyint = null

	AS

	/*
	Documentação
	Arquivo Fonte.....: Telefone.sql
	Objetivo..........: Inserir dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 20/08/2018
	Ex................: EXEC [dbo].[GKSSP_InsTelefone]  1, 34, 997209047

	*/
	
	
	BEGIN
	
		INSERT INTO Telefone(IdTelefoneTipo, DDD, Numero, Ramal) 
			VALUES(@IdTelefoneTipo, @DDD, @Numero, @Ramal)

		RETURN SCOPE_IDENTITY()

	END
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_UpdTelefone]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_UpdTelefone]
GO

CREATE PROCEDURE [dbo].[GKSSP_UpdTelefone]
	@Id					int,
	@IdTelefoneTipo		tinyint,
	@DDD				tinyint,
	@Numero				int,
	@Ramal				int = null
	AS

	/*
	Documentação
	Arquivo Fonte.....: Telefone.sql
	Objetivo..........: ATualiza dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 20/08/2018
	Ex................: EXEC [dbo].[GKSSP_UpdTelefone] 

	*/
	BEGIN
	
		UPDATE Telefone
			SET IdTelefoneTipo = @IdTelefoneTipo,
				Numero = @Numero,
				DDD = @DDD,
				Ramal = @Ramal
			WHERE Id = @Id

	END
GO
		
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_DelTelefone]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_DelTelefone]
GO

CREATE PROCEDURE [dbo].[GKSSP_DelTelefone]
	@Id int
	AS

	/*
	Documentação
	Arquivo Fonte.....: Telefone.sql
	Objetivo..........: Deletar dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 20/08/2018
	Ex................: EXEC [dbo].[GKSSP_DelTelefone] 

	*/

	BEGIN
	
		DELETE FROM Telefone 
			WHERE Id = @Id

	END
GO
							