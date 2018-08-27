
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GKSSP_UpdDescricaoMotivoCancel]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[GKSSP_UpdDescricaoMotivoCancel]
GO

CREATE PROCEDURE [dbo].[GKSSP_UpdDescricaoMotivoCancel]
	@Id					   int,
	@DescricaoMotivoCancel varchar(100)

	AS

	/*
	Documentação
	Arquivo Fonte.....: DescricaoMotivoCancel.sql
	Objetivo..........: Atualizar DescricaoMotivoCancel do chamado
	Autor.............: SMN - Thales Silveira
 	Data..............: 24/08/2018
	Ex................: EXEC [dbo].[GKSSP_UpdDescricaoMotivoCancel] 1, 'Foi cancelado o chamado pelo motivo de duplicidade'

	*/

	BEGIN
	
		UPDATE Chamado
			SET DescricaoMotivoCancel = @DescricaoMotivoCancel
		WHERE Id = @Id

	END
GO
