
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
	Ex................: EXEC [dbo].[GKSSP_InsColaboradorChamado] 1, 2

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
	Ex................: EXEC [dbo].[GKSSP_SelColaboradoresChamado] 1

	*/

	BEGIN
	
		SELECT  ch.IdChamado,
				col.Nome AS ColaboradorChamado
			FROM ColaboradorChamado ch WITH(NOLOCK)
				INNER JOIN Colaborador col WITH(NOLOCK)
					ON col.Id = ch.IdColaborador				
			WHERE IdChamado = @IdChamado

	END
GO
				