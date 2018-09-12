
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_SelTipoCriticidade]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_SelTipoCriticidade]
GO

CREATE PROCEDURE [dbo].[GKSSP_SelTipoCriticidade]

	AS

	/*
	Documentação
	Arquivo Fonte.....: TipoCriticidade.sql
	Objetivo..........: Buscar tipos de criticidade
	Autor.............: SMN - Thales Silveira
 	Data..............: 03/09/2018
	Ex................: EXEC [dbo].[GKSSP_SelTipoCriticidade]

	*/

	BEGIN
	
		SELECT Id,
			   Nome
			FROM TipoCriticidade

	END
GO
				