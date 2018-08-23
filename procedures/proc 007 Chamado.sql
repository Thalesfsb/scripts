
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_InsChamado]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_InsChamado]
GO

CREATE PROCEDURE [dbo].[GKSSP_InsChamado]
	@NumeroChamado			int,
	@NomeProblema			varchar(50), 
	@Descricao				varchar(500),
	@IdCriticidade			tinyint,
	@IdTipo					tinyint,
	@IdStatus				tinyint,
	@IdClienteCad			int

	AS

	/*
	Documentação
	Arquivo Fonte.....: Chamado.sql
	Objetivo..........: Inserir dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 15/08/2018
	Ex................: EXEC [dbo].[GKSSP_InsChamado] 1, 'Erro cadastrar lote', 'Quando clicado no botao salvar a tela fecha', 1, 1, 1, 1
	
	*/

	BEGIN
	
		INSERT INTO Chamado (NumeroChamado, NomeProblema, Descricao, IdCriticidade, IdTipo, IdStatus, IdClienteCad, DataCadastro)
			VALUES (@NumeroChamado, @NomeProblema, @Descricao, @IdCriticidade, @IdTipo, @IdStatus, @IdClienteCad, GETDATE())

	END
GO
				
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_SelChamado]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_SelChamado]
GO

CREATE PROCEDURE [dbo].[GKSSP_SelChamado] 
	@NumeroChamado int

	AS

	/*
	Documentação
	Arquivo Fonte.....: Chamado.sql
	Objetivo..........: Buscar os dados de um chamado
	Autor.............: SMN - Thales Silveira
 	Data..............: 15/08/2018
	Ex................: EXEC [dbo].[GKSSP_SelChamado]  1

	*/

	BEGIN
		SELECT  c.Descricao,	
				c.NumeroChamado,			
				cri.Nome AS NomeCriticidade,
				ts.Nome AS NomeTipoStatus
			FROM Chamado c WITH(NOLOCK)
				INNER JOIN TipoCriticidade cri WITH(NOLOCK)
					ON cri.Id = c.IdCriticidade 
				INNER JOIN ChamadoTipoStatus ts WITH(NOLOCK)
					ON ts.Id = c.IdStatus				
			WHERE c.NumeroChamado = @NumeroChamado

	END
GO
		
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_SelChamados]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_SelChamados]
GO

CREATE PROCEDURE [dbo].[GKSSP_SelChamados]
	@IdEmpresa	int = null,
	@IdStatus	tinyint = null,
	@idCliente	int = null

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
	
		SELECT  c.Id, 
				c.NumeroChamado,
				em.RazaoSocial AS NomeEmpresa,
				ccad.Nome AS NomeClienteCad,
				c.NomeProblema AS NomeProblema,
				cri.Nome AS NomeCriticidade,
				ts.Nome AS NomeTipoStatus
			FROM Chamado c WITH(NOLOCK)
				INNER JOIN TipoCriticidade cri WITH(NOLOCK)
					ON cri.Id = c.IdCriticidade 
				INNER JOIN ChamadoTipoStatus ts WITH(NOLOCK)
					ON ts.Id = c.IdStatus
				INNER JOIN Cliente ccad WITH(NOLOCK)
					ON ccad.Id = c.IdClienteCad
				LEFT JOIN Cliente calt WITH(NOLOCK)
					ON calt.Id = c.IdClienteAlt
				INNER JOIN Empresa em WITH(NOLOCK)
					ON em.Id = ccad.IdEmpresa
			WHERE (@IdEmpresa IS NULL OR ccad.IdEmpresa = @IdEmpresa) 
				AND (@IdStatus IS NULL OR c.IdStatus = @IdStatus)
				AND (@idCliente IS NULL OR c.IdClienteCad = @idCliente)
	END
GO
						
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_UpdChamado]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_UpdChamado]
GO

CREATE PROCEDURE [dbo].[GKSSP_UpdChamado]
	@NumeroChamado			int,
	@NomeProblema			varchar(50), 
	@Descricao				varchar(500),
	@IdCriticidade			tinyint,
	@IdTipo					tinyint,
	@IdStatus				tinyint,
	@IdClienteAlt			int

	AS

	/*
	Documentação
	Arquivo Fonte.....: Chamado.sql
	Objetivo..........: Atualizar dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 15/08/2018
	Ex................: EXEC [dbo].[GKSSP_UpdChamado] 1, 'Erro cadastrar lote', 'Quando clicado no botao salvar a tela fecha', 3, 1, 1, 1

	*/

	BEGIN
	
		UPDATE Chamado
			SET NomeProblema = @NomeProblema,
				Descricao = @Descricao,
				IdCriticidade = @IdCriticidade,
				IdTipo = @IdTipo,
				IdStatus = @IdStatus,
				IdClienteAlt = @IdClienteAlt,
				DataAlteracao = GETDATE()
			WHERE NumeroChamado = @NumeroChamado
	END
GO				