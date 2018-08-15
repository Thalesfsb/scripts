
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_InsColaboradorChamado]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_InsColaboradorChamado]
GO

CREATE PROCEDURE [dbo].[GKSSP_InsColaboradorChamado]
	@IdChamado		int,
	@IdColaborador  int 

	AS

	/*
	Documentação
	Arquivo Fonte.....: ColaboradorChamado.sql
	Objetivo..........: Inserir dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 15/08/2018
	Ex................: EXEC [dbo].[GKSSP_InsColaboradorChamado]

	*/

	BEGIN
		
		INSERT INTO ColaboradorChamado (IdChamado, IdColaborador)
			VALUES (@IdChamado, @IdColaborador)

	END
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_SelColaboradoresChamado]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_SelColaboradoresChamado]
GO

CREATE PROCEDURE [dbo].[GKSSP_SelColaboradoresChamado]
	@IdChamado  int

	AS

	/*
	Documentação
	Arquivo Fonte.....: ColaboradorChamado.sql
	Objetivo..........: Buscar colaboradores
	Autor.............: SMN - Thales Silveira
 	Data..............: 15/08/2018
	Ex................: EXEC [dbo].[GKSSP_SelColaboradoresChamado]

	*/

	BEGIN
	
		SELECT  col.Nome,
				col.Sobrenome
			FROM ColaboradorChamado ch WITH(NOLOCK)
				INNER JOIN Colaborador col WITH(NOLOCK)
					ON col.Id = ch.IdColaborador
			WHERE IdChamado = @IdChamado

	END
GO
				
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_UpdColaboradoresChamado]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_UpdColaboradoresChamado]
GO

CREATE PROCEDURE [dbo].[GKSSP_UpdColaboradoresChamado]
	@IdChamado     int,
	@IdColaborador int
	AS

	/*
	Documentação
	Arquivo Fonte.....: ColaboradorChamado.sql
	Objetivo..........: Atualizar colaborador chamado
	Autor.............: SMN - Thales Silveira
 	Data..............: 15/08/2018
	Ex................: EXEC [dbo].[GKSSP_UpdColaboradoresChamado]

	*/

	BEGIN
		
		UPDATE ColaboradorChamado
			SET IdColaborador = @IdColaborador
			WHERE IdChamado = @IdChamado

	END
GO
				