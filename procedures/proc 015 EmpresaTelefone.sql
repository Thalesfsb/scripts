
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_InsEmpresaTelefone]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_InsEmpresaTelefone]
GO

CREATE PROCEDURE [dbo].[GKSSP_InsEmpresaTelefone]
	@Cnpj			decimal(14,0),
	@IdTelefone		int

	AS

	/*
	Documentação
	Arquivo Fonte.....: EmpresaTelefone.sql
	Objetivo..........: Inserir dados 
	Autor.............: SMN - Thales Silveira
 	Data..............: 20/08/2018
	Ex................: EXEC [dbo].[GKSSP_InsEmpresaTelefone] 12345678998745, 1

	*/

	BEGIN
	
		INSERT INTO EmpresaTelefone(Cnpj, IdTelefone)
			VALUES(@Cnpj, @IdTelefone)

	END
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_SelEmpresaTelefones]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_SelEmpresaTelefones]
GO

CREATE PROCEDURE [dbo].[GKSSP_SelEmpresaTelefones]
	@Cnpj decimal(14,0)

	AS

	/*
	Documentação
	Arquivo Fonte.....: EmpresaTelefone.sql
	Objetivo..........: Buscar telefones 
	Autor.............: SMN - Thales Silveira
 	Data..............: 21/08/2018
	Ex................: EXEC [dbo].[GKSSP_SelEmpresaTelefones] 12345678998745

	*/

	BEGIN
	
		SELECT et.Cnpj,
			   et.IdTelefone,
			   t.DDD,
			   t.Numero,
			   t.Ramal
		FROM EmpresaTelefone et WITH(NOLOCK)
			INNER JOIN Telefone t WITH(NOLOCK)
				ON t.Id = et.IdTelefone
		WHERE et.Cnpj = @Cnpj

	END
GO
				

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_DelEmpresaTelefone]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_DelEmpresaTelefone]
GO

CREATE PROCEDURE [dbo].[GKSSP_DelEmpresaTelefone]
	@IdTelefone int = NULL,
	@Cnpj		decimal(14,0) = NULL

	AS

	/*
	Documentação
	Arquivo Fonte.....: EmpresaTelefone.sql
	Objetivo..........: Deletar telefone
	Autor.............: SMN - Thales Silveira
 	Data..............: 21/08/2018
	Ex................: EXEC [dbo].[GKSSP_DelEmpresaTelefone] 7

	*/

	BEGIN
	
		DELETE FROM EmpresaTelefone
			WHERE (@IdTelefone IS NULL OR IdTelefone = @IdTelefone)
			   AND(@Cnpj IS NULL OR Cnpj = @Cnpj)

	END
GO
				
				