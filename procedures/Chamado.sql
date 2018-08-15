
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_InsChamado]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_InsChamado]
GO

CREATE PROCEDURE [dbo].[GKSSP_InsChamado]
	@Nome					varchar(50), 
	@Descricao				varchar(500),
	@IdCriticidade			tinyint,
	@IdTipo					tinyint,
	@IdStatus				tinyint,
	@IdClienteCadastro		int

	AS

	/*
	Documentação
	Arquivo Fonte.....: Chamado.sql
	Objetivo..........: Inserir dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 15/08/2018
	Ex................: EXEC [dbo].[GKSSP_InsChamado]

	*/

	BEGIN
	
		INSERT INTO Chamado (Nome,
							 Descricao,
							 IdCriticidade,
							 IdTipo,
							 IdStatus,
							 IdClienteCadastro,
							 DataCadastro)

		VALUES				(@Nome,
							 @Descricao,
							 @IdCriticidade,
							 @IdTipo,
							 @IdStatus,
							 @IdClienteCadastro,
							 GETDATE())

	END
GO
				
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_SelChamado]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_SelChamado]
GO

CREATE PROCEDURE [dbo].[GKSSP_SelChamado]
	@Id int

	AS

	/*
	Documentação
	Arquivo Fonte.....: Chamado.sql
	Objetivo..........: Buscar chamado
	Autor.............: SMN - Thales Silveira
 	Data..............: 15/08/2018
	Ex................: EXEC [dbo].[GKSSP_SelChamado]

	*/

	BEGIN
		
		SELECT
		     c.Id AS Chamado, 
		     em.RazaoSocial AS Empresa,
		     ccad.Nome AS Solicitante,
		     c.Nome AS Problema,
		     cri.Nome AS Criticidade,
		     col.Nome AS Atendimento,
		     c.Descricao,
		     c.DataCadastro,
		     ct.Nome AS TipoChamado,
		     ts.Nome AS TipoStatus,
		     c.DataAlteracao,
		     calt.Nome AS SolicitanteAlt
			
		FROM Chamado c WITH(NOLOCK)
			INNER JOIN TipoCriticidade cri WITH(NOLOCK)
				ON cri.Id = c.IdCriticidade 
			INNER JOIN ChamadoTipo ct WITH(NOLOCK)
				ON ct.Id = c.IdTipo
			INNER JOIN ChamadoTipoStatus ts WITH(NOLOCK)
				ON ts.Id = c.IdStatus
			INNER JOIN Cliente ccad WITH(NOLOCK)
				ON ccad.Id = c.IdClienteCadastro
			LEFT JOIN Cliente calt WITH(NOLOCK)
				ON calt.Id = c.IdClienteAlteracao
			INNER JOIN Empresa em WITH(NOLOCK)
				ON em.Id = ccad.IdEmpresa
			INNER JOIN ColaboradorChamado colc WITH(NOLOCK)
				ON colc.IdChamado = c.Id
			INNER JOIN Colaborador col WITH(NOLOCK)
				ON col.Id = colc.IdColaborador
		WHERE c.Id = @Id

	END
GO
		
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_SelChamados]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_SelChamados]
GO

CREATE PROCEDURE [dbo].[GKSSP_SelChamados]

	AS

	/*
	Documentação
	Arquivo Fonte.....: Chamado.sql
	Objetivo..........: Buscar chamados
	Autor.............: SMN - Thales Silveira
 	Data..............: 15/08/2018
	Ex................: EXEC [dbo].[GKSSP_SelChamados]

	*/

	BEGIN
	
		SELECT
			 c.Id AS Chamado, 
			 em.RazaoSocial AS Empresa,
			 cc.Nome AS Solicitante,
			 c.Nome AS Problema,
			 cri.Nome AS Criticidade,
			 col.Nome AS Atendimento,
			 c.Descricao,
			 c.DataCadastro,
			 ct.Nome AS TipoChamado,
			 ts.Nome AS TipoStatus,
			 c.DataAlteracao,
			 ca.Nome AS SolicitanteAlt
			
		FROM Chamado c WITH(NOLOCK)
			INNER JOIN TipoCriticidade cri WITH(NOLOCK)
				ON cri.Id = c.IdCriticidade 
			INNER JOIN ChamadoTipo ct WITH(NOLOCK)
				ON ct.Id = c.IdTipo
			INNER JOIN ChamadoTipoStatus ts WITH(NOLOCK)
				ON ts.Id = c.IdStatus
			INNER JOIN Cliente cc WITH(NOLOCK)
				ON cc.Id = c.IdClienteCadastro
			LEFT JOIN Cliente ca WITH(NOLOCK)
				ON ca.Id = c.IdClienteAlteracao
			INNER JOIN Empresa em WITH(NOLOCK)
				ON em.Id = cc.IdEmpresa
			INNER JOIN ColaboradorChamado colc WITH(NOLOCK)
				ON colc.IdChamado = c.Id
			INNER JOIN Colaborador col WITH(NOLOCK)
				ON col.Id = colc.IdColaborador

	END
GO
						
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_UpdChamado]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_UpdChamado]
GO

CREATE PROCEDURE [dbo].[GKSSP_UpdChamado]
	@Nome					varchar(50), 
	@Descricao				varchar(500),
	@IdCriticidade			tinyint,
	@IdTipo					tinyint,
	@IdStatus				tinyint,
	@IdClienteAlteracao		int
	AS

	/*
	Documentação
	Arquivo Fonte.....: Chamado.sql
	Objetivo..........: Atualizar dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 15/08/2018
	Ex................: EXEC [dbo].[GKSSP_UpdChamado]

	*/

	BEGIN
	
		UPDATE Chamado
			SET Nome = @Nome,
				Descricao = @Descricao,
				IdCriticidade = @IdCriticidade,
				IdTipo = @IdTipo,
				IdStatus = @IdStatus,
				IdClienteAlteracao = @IdClienteAlteracao,
				DataAlteracao = GETDATE()

	END
GO				