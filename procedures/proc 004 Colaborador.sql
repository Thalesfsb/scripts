
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_InsColaborador]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_InsColaborador]
GO

CREATE PROCEDURE [dbo].[GKSSP_InsColaborador]
	@Cpf						decimal(11,0),
	@Nome						varchar(50),
	@Logon						varchar(20),
	@Senha						varchar(20),
	@IdTipoColaborador			tinyint,
	@IdColaboradorCad			int

	AS

	/*
	Documentação
	Arquivo Fonte.....: Colaborador.sql
	Objetivo..........: Inserir os dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_InsColaborador] 51618249649, 'Taciane Cardoso', 'TaCa', '123', 2, 1

	*/

	BEGIN
		
		INSERT INTO Colaborador	(Cpf, Nome, Logon, Senha, IdTipoColaborador, IdColaboradorCad, DataCadastrO)
			VALUES (@Cpf, @Nome, @Logon, @Senha, @IdTipoColaborador, @IdColaboradorCad, GETDATE())		

	END
GO


IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_SelColaborador]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_SelColaborador]
GO

CREATE PROCEDURE [dbo].[GKSSP_SelColaborador]
	@Cpf decimal(11,0)

	AS

	/*
	Documentação
	Arquivo Fonte.....: Colaborador.sql
	Objetivo..........: Buscar dados colaborador
	Autor.............: SMN - Thales Silveira
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_SelColaborador] 51618249649

	*/

	BEGIN
	   
	   SELECT c.Cpf,
			  c.Nome,
			  c.Logon,
			  c.IdTipoColaborador,
			  c.IdColaboradorCad,
			  co.Nome AS NomeColaboradorCad,
			  c.DataCadastro,
			  c.IdColaboradorAlt,
			  col.Nome AS NomeColaboradorAlt,
			  c.DataAlteracao,
			  c.DataInativacao
			FROM Colaborador c WITH(NOLOCK)
				INNER JOIN Colaborador co WITH(NOLOCK)
					ON co.Id = c.IdColaboradorCad
				LEFT JOIN Colaborador col WITH(NOLOCK)
					ON col.Id = c.IdColaboradorAlt
			WHERE c.Cpf = @Cpf
		

	END
GO
		
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_SelColaboradores]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_SelColaboradores]
GO

CREATE PROCEDURE [dbo].[GKSSP_SelColaboradores]

	AS

	/*
	Documentação
	Arquivo Fonte.....: Colaborador.sql
	Objetivo..........: Buscar dados colaboradores
	Autor.............: SMN - Thales Silveira
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_SelColaboradores]

	*/
	BEGIN
		
		SELECT c.Cpf,
			   tc.Nome AS NomeTipoColaborador,  
			   c.Nome,
			   c.Logon
			FROM Colaborador c WITH(NOLOCK)		
				INNER JOIN TipoColaborador tc WITH(NOLOCK)
					ON tc.Id = c.IdTipoColaborador

	END
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_UpdColaborador]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_UpdColaborador]
GO

CREATE PROCEDURE [dbo].[GKSSP_UpdColaborador]
	@Cpf						decimal(11,0),
	@Nome						varchar(50),
	@Logon						varchar(20),
	@Senha						varchar(20),
	@IdTipoColaborador			tinyint,
	@IdColaboradoAlt			int

	AS

	/*
	Documentação
	Arquivo Fonte.....: Colaborador.sql
	Objetivo..........: Atualizar dados
	Autor.............: SMN - Thales Silveira
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_UpdColaborador] 51618249649, 'Taciane Cardoso', 'Ta2Ca4', '123', 2, 1

	*/

	BEGIN
		
		UPDATE Colaborador
			SET Cpf = @Cpf,
				Nome = @Nome,
				Logon = @Logon,
				Senha = @Senha,
				IdTipoColaborador = @IdTipoColaborador,
				IdColaboradorAlt = @IdColaboradoAlt,
				DataAlteracao = GETDATE()
			WHERE Cpf = @Cpf		

	END
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_DelColaborador]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_DelColaborador]
GO

CREATE PROCEDURE [dbo].[GKSSP_DelColaborador]
	@Cpf	decimal(14,0)

	AS

	/*
	Documentação
	Arquivo Fonte.....: Colaborador.sql
	Objetivo..........: Inativar colaborador
	Autor.............: SMN - Thales Silveira
 	Data..............: 14/08/2018
	Ex................: EXEC [dbo].[GKSSP_DelColaborador]

	*/

	BEGIN
	
		UPDATE Colaborador
			SET DataInativacao = GETDATE()
			WHERE Cpf = @Cpf
			
	END
GO
				
				
				