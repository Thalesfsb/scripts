
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_SelChamadoTipos]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_SelChamadoTipos]
GO

CREATE PROCEDURE [dbo].[GKSSP_SelChamadoTipos]

	AS

	/*
	Documentação
	Arquivo Fonte.....: ChamadoTipos.sql
	Objetivo..........: Buscar os tipos de chamado
	Autor.............: SMN - Thales Silveira
 	Data..............: 03/09/2018
	Ex................: EXEC [dbo].[GKSSP_SelChamadoTipos]

	*/

	BEGIN
	
		SELECT Id,
			   Nome
			FROM ChamadoTipo

	END
GO
				