
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_InsChamadoHistoricoStatus]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_InsChamadoHistoricoStatus]
GO

CREATE PROCEDURE [dbo].[GKSSP_InsChamadoHistoricoStatus]
	@IdChamado		int,
	@IdStatus		tinyint,
	@IdColaborador	int = NULL,
	@IdCliente		int = NULL

	AS

	/*
	Documentação
	Arquivo Fonte.....: ChamadoHistoricoStatus.sql
	Objetivo..........: Inserir dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 15/08/2018
	Ex................: EXEC [dbo].[GKSSP_InsChamadoHistoricoStatus] 1, 2, 1, null

	*/

	BEGIN
	
		INSERT INTO ChamadoHistoricoStatus (IdChamado, IdCliente, IdColaborador, IdStatus, DataCadastro)
			VALUES (@IdChamado, @IdCliente,	@IdColaborador,	@IdStatus, GETDATE())

	END
GO
	
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_SelChamadoHistoricoStatus]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_SelChamadoHistoricoStatus]
GO

CREATE PROCEDURE [dbo].[GKSSP_SelChamadoHistoricoStatus]
	@IdChamado int

	AS

	/*
	Documentação
	Arquivo Fonte.....: ChamadoHistoricoStatus.sql
	Objetivo..........: Selecionar historico chamado
	Autor.............: SMN - Thales Silveira
 	Data..............: 15/08/2018
	Ex................: EXEC [dbo].[GKSSP_SelChamadoHistoricoStatus] 1

	*/

	BEGIN
	
		SELECT 	chs.Id,
				chs.DataCadastro,
				chs.IdStatus,
				ts.Nome AS NomeStatus,
				col.Nome AS NomeColaborador,
				cl.Nome AS NomeCliente
			FROM ChamadoHistoricoStatus  chs WITH(NOLOCK)
				INNER JOIN ChamadoTipoStatus ts WITH(NOLOCK)
					ON ts.Id = chs.IdStatus
				LEFT JOIN Colaborador col WITH(NOLOCK)
					ON col.Id = chs.IdColaborador
				LEFT JOIN Cliente cl WITH(NOLOCK)
					ON cl.Id = chs.IdCliente
			WHERE chs.IdChamado = @IdChamado

	END
GO			

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_UpdChamadoHistoricoStatus]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_UpdChamadoHistoricoStatus]
GO

CREATE PROCEDURE [dbo].[GKSSP_UpdChamadoHistoricoStatus]
	@IdChamado int,
	@IdStatus  int

	AS

	/*
	Documentação
	Arquivo Fonte.....: ChamadoHistoricoStatus.sql
	Objetivo..........: Inativar chamado
	Autor.............: SMN - Thales Silveira
 	Data..............: 27/08/2018
	Ex................: EXEC [dbo].[GKSSP_UpdChamadoHistoricoStatus] 1, 1

	*/

	BEGIN
	
		UPDATE ChamadoHistoricoStatus
			SET IdStatus = @IdStatus
			WHERE Id = @IdChamado

	END
GO
