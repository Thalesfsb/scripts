
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_InsChamadoHistoricoStatus]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_InsChamadoHistoricoStatus]
GO

CREATE PROCEDURE [dbo].[GKSSP_InsChamadoHistoricoStatus]
	@IdChamado		int,
	@IdStatus		tinyint,
	@IdColaborador	int,
	@IdCliente		int 
	AS

	/*
	Documentação
	Arquivo Fonte.....: ChamadoHistoricoStatus.sql
	Objetivo..........: Inserir dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 15/08/2018
	Ex................: EXEC [dbo].[GKSSP_InsChamadoHistoricoStatus]

	*/

	BEGIN
	
		INSERT INTO ChamadoHistoricoStatus (IdChamado, IdCliente, IdColaborador, IdStatus)
			VALUES (@IdChamado, @IdCliente,	@IdColaborador,	@IdStatus)

	END
GO
	
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_SelChamadoHistoricoStatus]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_SelChamadoHistoricoStatus]
GO

CREATE PROCEDURE [dbo].[GKSSP_SelChamadoHistoricoStatus]
	@Id int
	AS

	/*
	Documentação
	Arquivo Fonte.....: ChamadoHistoricoStatus.sql
	Objetivo..........: Selecionar historico chamado
	Autor.............: SMN - Thales Silveira
 	Data..............: 15/08/2018
	Ex................: EXEC [dbo].[GKSSP_SelChamadoHistoricoStatus]

	*/

	BEGIN
	
		SELECT 	ts.Nome,
				c.DataCadastro,
				c.DataAlteracao,
				col.Nome,
				col.Sobrenome,
				cl.Nome,
				cl.Sobrenome
			FROM ChamadoHistoricoStatus  chs WITH(NOLOCK)
				INNER JOIN Chamado c WITH(NOLOCK)
					ON c.Id = chs.IdChamado
				INNER JOIN ChamadoTipoStatus ts WITH(NOLOCK)
					ON ts.Id = chs.IdStatus
				INNER JOIN Colaborador col WITH(NOLOCK)
					ON col.Id = chs.IdColaborador
				INNER JOIN Cliente cl WITH(NOLOCK)
					ON cl.Id = chs.IdCliente
			WHERE chs.Id = @Id

	END
GO
				
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_SelChamadosHistoricoStatus]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_SelChamadosHistoricoStatus]
GO

CREATE PROCEDURE [dbo].[GKSSP_SelChamadosHistoricoStatus]

	AS

	/*
	Documentação
	Arquivo Fonte.....: ChamadoHistoricoStatus.sql
	Objetivo..........: Selecionar historicos de chamado
	Autor.............: SMN - Thales Silveira
 	Data..............: 15/08/2018
	Ex................: EXEC [dbo].[GKSSP_SelChamadosHistoricoStatus]

	*/

	BEGIN
		
		SELECT  ts.Nome,
				c.DataCadastro,
				c.DataAlteracao,
				col.Nome,
				col.Sobrenome,
				cl.Nome,
				cl.Sobrenome
			FROM ChamadoHistoricoStatus  chs WITH(NOLOCK)
				INNER JOIN Chamado c WITH(NOLOCK)
					ON c.Id = chs.IdChamado
				INNER JOIN ChamadoTipoStatus ts WITH(NOLOCK)
					ON ts.Id = chs.IdStatus
				INNER JOIN Colaborador col WITH(NOLOCK)
					ON col.Id = chs.IdColaborador
				INNER JOIN Cliente cl WITH(NOLOCK)
					ON cl.Id = chs.IdCliente

	END
GO


IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_UpdChamadoHistoricoStatus]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_UpdChamadoHistoricoStatus]
GO

CREATE PROCEDURE [dbo].[GKSSP_UpdChamadoHistoricoStatus]
	@IdChamado		int,
	@IdStatus		tinyint,
	@IdColaborador	int
		
	AS

	/*
	Documentação
	Arquivo Fonte.....: ChamadoHistoricoStatus.sql
	Objetivo..........: Atualizar historico
	Autor.............: SMN - Thales Silveira
 	Data..............: 15/08/2018
	Ex................: EXEC [dbo].[GKSSP_UpdChamadoHistoricoStatus]

	*/

	BEGIN
	
		UPDATE ChamadoHistoricoStatus
			SET IdStatus = @IdStatus,
				IdColaborador = @IdColaborador
			WHERE IdChamado = @IdChamado
	END
GO
											