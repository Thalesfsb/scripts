IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSFNC_GetProximoNumeroChamado]') AND objectproperty(id, N'IsScalarFunction')=1)
	DROP FUNCTION [dbo].[GKSFNC_GetProximoNumeroChamado]
GO 

CREATE FUNCTION [dbo].[GKSFNC_GetProximoNumeroChamado]
	(@IdEmpresa tinyint)

	RETURNS int

	AS

	/*
		Documenta��o
		Objetivo............: Seleciona o �ltimo registro do chamado, pega o n�mero e gera um novo n�mero de chamado
		Autor...............: SMN - Thales Silveira
 		Data................: 24/08/2018
		Exemplo.............: SELECT [dbo].[GKSFNC_GetProximoNumeroChamado] (2)
		select * from chamado
	*/
	
	BEGIN
			
			RETURN ISNULL((SELECT TOP 1 ch.NumeroChamado
								FROM Chamado ch WITH(NOLOCK)
									INNER JOIN Cliente cl WITH(NOLOCK)
										ON cl.Id = ch.IdClienteCad
								WHERE cl.IdEmpresa = @IdEmpresa
								ORDER BY ch.Id DESC),0) + 1

	END
GO
