ALTER PROCEDURE [dbo].[GKSSP_LoginMVC]
	@Cod_Logon			varchar(10),
	@Cod_Senha			varchar(10),
	@Ind_Param  		char(1) = NULL,
    @Cod_EmpLog 		tinyint = NULL,
	@Num_IP				varchar(30) = NULL,
	@Nom_Requisicao		varchar(200) = NULL,
	@Ind_OrigemAcesso	char(1) = NULL

	AS

	/*
	Documentação
	Arquivo Fonte.....: LoginMVC.sql  
	Objetivo..........: Efetuar logon de usuario - Sistema novo MVC
	Autor.............: Ricardo Corrales   
 	Data..............:	31/10/2013
	Considerações.....: A procedure deverá receber como parâmetros os códigos de logon e 
						senha e devolver dois datASets um com parâmetros de saída: código 
						do usuário, numero do funcionário, código e nome da empresa padrão, 
						o código de retorno do processamento, o tempo de execução da SP e 
						outro com as opções de menu	habilitadas diretamente ou herdadas de 
						outros funcionários e outro com as empresas habilitadas e ainda 
						as filiais habilitadas.
	Observações.......: O parâmetro @Ind_Param indica se o dataset de parametros deve ser devolvido ou não (S/N)
                                    @Cod_EmpLog indica em que empresa logar, caso não informado logar na empresa padrão 
                                    @Num_IP indica o ip do usuario que esta se logando
	Variáveis.........: @Dat_Exp - Data em que a senha expira
						@Tmp_Ini - Tempo Inicial do processamento
						@Cnt_Opc - Armazena quantidade de opções habilitadAS
						@Tmp_Rec - Armazena o tempo de execução de sub-procedures
						@Cod_Usua - Armazena codigo do usuario
						@Cod_Emp - Armazena codigo da empresa
						@Nom_Emp - Armazena nome da empresa
						@Cod_Ret - Armazena codigo de retorno
						@Tmp_Exec - armazena tempo total de execução
						@Num_Reg - armazena o numero do funcionario quando o usuario for um
						@Nom_Apelido - armazena o apelido do usuario
						@Nom_CorFundo - armazena a cor de fundo da area de menu
						@Nom_CorFrente - armazena a cor de frente da area de menu
						@Cod_Atendente - código do atendente caso o usuário logado seja um atendente
						@Nom_Atendente - nome do atendente caso o usuário logado seja um atendente
						@Cod_Dep - código do departamento
						@Nom_Dep - nome do departamento 
						@Cod_CaixaOper - código do caixa operacional caso o usuário a efetuar o login tenha um (somente 1)
						@Num_CtaCtbCaixa - número da conta do caixa operacional do usuário logado
						@Nom_CtaCtbCaixa - nome da conta do caixa operacional do usuário logado
					    @Nom_ApelidoEmp - apelido para o nome da empresa
                        @Ind_PermTrocaEmpr - Indicador se o usuario pode trocar de empresa automaticamente 
                        @Nom_CidAloc - Cidade que o usuario esta alocado caso seja funcionário
                        @Ind_SolMarcaEntAlm - Indicador se é para sugerir a marcação de ponto de retorno do almoço
	Codigos de retorno: 0 - Execução ok Logon liberado
						1 - Logon Inexistente
						2 - Senha expirada
						3 - Logon desativado
						4 - Usuário sem empresa padrão habilitada
						5 - Usuário sem opções habilitadas
						6 - Estação de trabalho não autorizada a efetuar logon
			            7 - Rotinas estão bloqueadas - abonos pendentes de solicitação
			            8 - Rotinas estão bloqueadas - abonos pendentes de aprovação
			            9 - Rotinas estão bloqueadas - hora-extras pendentes de aprovação
			           10 - Rotinas estao bloqueadas - compensão de horas pendentes de aprovação
			           11 - Senha não confere

	Exemplo...........: EXEC [dbo].[GKSSP_LoginMVC] 1757, 'kasil123', null, NULL, NULL
						EXEC [dbo].[GKSSP_LoginMVC] 1143, 'zenimo38', NULL, NULL, NULL
						EXEC [dbo].[GKSSP_LoginMVC] 0, 'teste123@', NULL, NULL, NULL


						BEGIN TRANSACTION
						DECLARE @RET int
						EXEC @RET = [dbo].[GKSSP_LoginMVC] '193', '060288', 'S', NULL, '10.11.0.6'
						SELECT @RET
						ROLLBACK TRANSACTION
						
	*/

	BEGIN
 
        SET NOCOUNT ON
        
		DECLARE @Dat_Exp 		   			datetime,
				@Dat_Desativ 	   			datetime,
				@Tmp_Ini 		   			datetime,
				@Cnt_Opc 		   			smallint,
				@Tmp_Rec 		   			smallint,
				@Cod_Usua		   			int,
				@Cod_Emp 		   			tinyint,
				@Nom_Emp		   			varchar(50),
				@Cod_Ret		   			tinyint,
				@Tmp_Exec 		   			int,
				@Num_Reg		   			int,
				@Nom_Func		   			varchar(50),
				@Nom_Apelido       			varchar(30),
				@Nom_CorFundo	   			varchar(50),
				@Nom_CorFrente     			varchar(50),
				@Cod_Atendente     			int,
				@Nom_Atendente     			varchar(50),
				@Cod_Time		   			smallint,
				@Cod_Dep		   			smallint,
				@Nom_Dep		   			varchar(50),
				@Cod_CaixaOper	   			tinyint,
				@Num_CtaCtbCaixa   			int,
				@Nom_CtaCtbCaixa   			varchar(100),
				@Ind_PermAcessExt  			char(1),
               	@Dat_HojeSemHora   			datetime,
				@Nom_ApelidoEmp	   			varchar(50),
               	@Pend_Pto          			tinyint,
                @Ind_PermTrocaEmpr 			char(1),
                @Ind_RestringeIP   			char(1),
                @Nom_CidAloc	   			varchar(50),
				@Cod_TipHor					smallint,
				@Num_SeqlAreaIP				smallint,
				@Ind_SolMarcaEntAlm			char(1), 
				@Nom_ErroMarcaPonto			varchar(200),
				@Ind_AcessoChat				char(1),
				@Cod_StatusUsua				tinyint,
				@Nom_Email					varchar(50),
				@Ind_AtivaMonitoramento		char(1),
				@Ind_MarcaPonto			    char(1),
				--@PossuiPendenciaConciliacao varchar(max),
				@Cod_Fil					smallint,
				@Cod_FilMat					smallint,
				@Nom_Fil					varchar(50),
				@Pendencia_DocDig			char(2),
				@Pend_ConferenciaDocDig		char(1),
				@Cod_TipoUsuario			tinyint
	
		-- Capturando instante de processamento
		SET @Tmp_Ini = GETDATE()
        SET @Dat_HojeSemHora = [dbo].[GKSFNC_DataSemHora] (@Tmp_Ini)
        SET @Ind_SolMarcaEntAlm = 'N'

        CREATE TABLE #tmp_Opcoes (Cod_Opc   smallint)
		CREATE TABLE #PossuiPendenciaConciliacao (Cod_Emp varchar(3), Num_Rlc varchar(MAX), Qtd_diasAtraso int)

		-- Recuperando dados do usuário 
		SELECT 	@Cod_Usua 		   		= us.Cod_Usua,
				@Num_Reg 		   		= us.Num_Reg,
				@Nom_Func 		   		= fn.Nom_Func,
				@Nom_Apelido 	   		= us.Nom_Apelido,
				@Dat_Exp 		   		= us.Dat_Exp,
				@Dat_Desativ 	   		= us.Dat_Desativ,
				@Ind_PermAcessExt  		= us.Ind_PermAcessExt,
				@Ind_AcessoChat	   		= us.Ind_AcessoChat,
				@Cod_StatusUsua	   		= us.Cod_StatusUsua,
				@Ind_PermTrocaEmpr 		= ISNULL(us.Ind_PermTrocaEmpr, 'N'),
				@Ind_RestringeIP   		= ISNULL(us.Ind_RestringeIP,'S'),
				@Cod_TipHor		   		= COALESCE(he.Cod_TipHor, fn.Cod_TipHor),
				@Num_SeqlAreaIP	   		= fn.Num_SeqlAreaIP,
				@Nom_Email		   		= COALESCE(us.Nom_Email, fn.Nom_Email),
				@Ind_AtivaMonitoramento = ISNULL(us.Ind_AtivaMonitoramento, 'N'),
				@Cod_Fil				= [dbo].[GKSFNC_PegaFilFunc](@Num_Reg),
				@Ind_MarcaPonto		    = ISNULL(fn.Ind_MarcPonto,'S'),
				@Cod_TipoUsuario		= us.Cod_TipoUsuario
			FROM [dbo].[GKS_Usuarios] us WITH(NOLOCK)
				LEFT OUTER JOIN [dbo].[GKSDP_Funcionarios] fn WITH(NOLOCK)
					ON fn.Num_Reg = us.Num_Reg
				LEFT OUTER JOIN [dbo].[GKSDP_FuncionarioAlocacao] fa WITH(NOLOCK)
					ON fa.Num_Reg = fn.Num_Reg
						AND fa.Dat_IniAloc <= @Dat_HojeSemHora
						AND ISNULL(fa.Dat_FimAloc, @Dat_HojeSemHora) >= @Dat_HojeSemHora
				LEFT OUTER JOIN [dbo].[GKSDP_CidadesAlocacao] ca WITH(NOLOCK)
					ON ca.Num_SeqlCidAloc = fa.Num_SeqlCidAloc
				LEFT OUTER JOIN [dbo].[GKSDP_FuncHorEventuais] he WITH(NOLOCK)
					ON he.Num_Reg = fn.Num_Reg
						AND Dat_Ini <= @Dat_HojeSemHora
        				AND Dat_Fim >= @Dat_HojeSemHora
			WHERE us.Cod_Logon = @Cod_Logon
				AND us.Cod_Senha  = [dbo].[GKSFNC_CriptografaSenha](@Cod_Senha)
              
		-- Recuperando cidade de alocação
		IF @Num_Reg IS NOT NULL
			BEGIN
				SELECT @Nom_CidAloc = COALESCE(ca.Nom_CidAloc, fl.Nom_Cid, 'Sem Cidade Alocação'),
						@Nom_Fil = fl.Nom_Fil
					FROM [dbo].[GKSDP_Funcionarios] fu WITH(NOLOCK)
						LEFT OUTER JOIN [dbo].[GKSDP_FuncionarioAlocacao] fa WITH(NOLOCK)
							ON fa.Num_Reg = fu.Num_Reg
								AND fa.Dat_IniAloc <= @Dat_HojeSemHora
								AND ISNULL(fa.Dat_FimAloc, @Dat_HojeSemHora) >= @Dat_HojeSemHora
						LEFT OUTER JOIN [dbo].[GKSDP_CidadesAlocacao] ca WITH(NOLOCK)
							ON ca.Num_SeqlCidAloc = fa.Num_SeqlCidAloc
						LEFT OUTER JOIN [dbo].[GKS_Filiais] fl WITH(NOLOCK)
							ON fl.Cod_Fil = @Cod_Fil
					WHERE fu.Num_Reg = @Num_Reg
			END
		ELSE SET @Nom_CidAloc = 'Sem Cidade Alocação'
		        		
		-- Recuperando dados empresa
		IF @Cod_EmpLog IS NULL
			BEGIN
				SELECT @Cod_Emp = ue.Cod_Emp,
						@Cod_EmpLog = ue.Cod_Emp
					FROM [dbo].[GKS_UsuariosEmp] ue WITH(NOLOCK)
					WHERE ue.Cod_Usua = @Cod_Usua
						AND ue.Ind_Padrao = 'S'
			END
		ELSE
			BEGIN
				SELECT @Cod_Emp = ue.Cod_Emp
					FROM [dbo].[GKS_UsuariosEmp] ue WITH(NOLOCK)
					WHERE ue.Cod_Usua = @Cod_Usua
						AND ue.Cod_Emp    = @Cod_EmpLog
			END

		SELECT @Cod_FilMat = Cod_Fil	
			FROM [dbo].[GKS_Filiais] 
				WHERE Cod_Emp = @Cod_EmpLog
				AND Ind_MatFil = 'M'

		SELECT 	@Nom_Emp 		   = em.Nom_Emp,
				@Nom_CorFundo 	   = em.Nom_CorFundo,
				@Nom_CorFrente 	   = em.Nom_CorFrente,
				@Nom_ApelidoEmp	   = em.Nom_ApelidoEmp
			FROM [dbo].[GKS_Empresas] em WITH(NOLOCK)
			WHERE em.Cod_Emp = @Cod_Emp

		-- Verificações 
		-- Checagem Logon Inexistente
		IF NOT EXISTS(SELECT TOP 1 1 
						FROM [dbo].[GKS_Usuarios] WITH(NOLOCK)
						WHERE Cod_Logon = @Cod_Logon)
			BEGIN
				SET @Cod_Ret = 1
				GOTO Devolve_vazio
			END

		-- 11 - Senha não confere
		IF @Cod_Usua IS NULL
			BEGIN
				SET @Cod_Ret = 11
				GOTO Devolve_vazio
			END
			
		-- Checagem Senha expirada
		IF (COALESCE(@Dat_Exp,DATEADD(d,1,GETDATE())) <= GETDATE())
			BEGIN
				SET @Cod_Ret = 2
				GOTO Devolve_vazio
			END

		-- Checagem logon desativado
		IF (COALESCE(@Dat_Desativ,DATEADD(d,1,GETDATE())) <= GETDATE())
			BEGIN
				SET @Cod_Ret = 3
				GOTO Devolve_vazio
			END

		-- Checagem empresa padrão não habilitada
		IF (@Cod_Emp IS NULL)
			BEGIN
				SET @Cod_Ret = 4
				GOTO Devolve_vazio
			END

		-- Validando IP
		IF @Num_IP IS NOT NULL AND @Ind_PermAcessExt = 'N'
			BEGIN
				-- ACESSO REDE INTERNA
				IF NOT EXISTS(SELECT TOP 1 1
								FROM [dbo].[GKS_IPInterno] WITH(NOLOCK)
								WHERE @Num_IP LIKE Num_IPInt + '%')
					BEGIN
						SET @Cod_Ret = 6
						GOTO Devolve_vazio
					END
		END

		-- VERIFICANDO ORIGEM DE ACESSO
		IF	@Ind_RestringeIP = 'S' 
			AND
				NOT EXISTS(SELECT TOP 1 1
							FROM [dbo].[GKS_IPInterno] WITH(NOLOCK)
							WHERE Num_IPInt = SUBSTRING(@Num_IP, 1, DATALENGTH(Num_IPInt))) 
			AND
				NOT EXISTS(SELECT TOP 1 1
							FROM [dbo].[GKS_IPsAutorizados] WITH (NOLOCK)
							WHERE IP_Local = @Num_IP)
			BEGIN
				SET @Cod_Ret = 6
				GOTO Devolve_vazio
			END

		-- Pegando dados do atendente
		SELECT TOP 1 @Cod_Atendente = ate.Cod_Atendente,
					 @Nom_Atendente = ate.Nom_Atendente,
					 @Cod_Time = ta.Cod_Time
			FROM [dbo].[GKSLT_Atendente] ate WITH(NOLOCK)
				LEFT OUTER JOIN [dbo].[GKSLT_TimeAtende] ta WITH(NOLOCK)
					ON ta.Cod_Atendente = ate.Cod_Atendente
			WHERE ate.Cod_Usua = @Cod_Usua
			ORDER BY ta.Dat_Cad DESC

		-- Pegando departamento
		IF @Num_Reg IS NOT NULL
			BEGIN
				SELECT @Cod_Dep = [dbo].[GKSFNC_PegaDepFunc](@Num_Reg)

				IF @Cod_Dep IS NOT NULL
					BEGIN
						SELECT @Nom_Dep = Nom_Dep
							FROM [dbo].[GKS_Departamentos] WITH(NOLOCK)
							WHERE Cod_Dep = @Cod_Dep
					END
			END

		-- Pegando caixa operacional
		SELECT  @Cod_CaixaOper   = 0,
				@Num_CtaCtbCaixa = 0,
				@Nom_CtaCtbCaixa = ''

        IF EXISTS(SELECT TOP 1 1
                    FROM [dbo].[GKSCX_SaldoCaixa] sa WITH(NOLOCK)
                    WHERE sa.Dat_Abre >= @Dat_HojeSemHora
				        AND sa.Dat_Fecha IS NULL)
            BEGIN
        		SELECT  @Cod_CaixaOper   = sa.Cod_CaixaOper,
        				@Num_CtaCtbCaixa = pc.Num_CtaCtb,
        				@Nom_CtaCtbCaixa = pc.Nom_CtaCtb
        			FROM [dbo].[GKSCX_SaldoCaixa] sa WITH(NOLOCK)
        				INNER JOIN [dbo].[GKSCX_CaixaOperacional] cx WITH(NOLOCK)
        					ON cx.Cod_CaixaOper = sa.cod_CaixaOper
        				INNER JOIN [dbo].[GKSCT_PlanoContas] pc WITH(NOLOCK)
        					ON pc.Num_ChavCta = cx.Num_ChavCta
        				INNER JOIN [dbo].[GKSCT_GrupoContabil] gc WITH(NOLOCK)
        					ON gc.Num_SeqlGrup = pc.Num_SeqlGrup
                   	WHERE sa.Dat_Abre >= @Dat_HojeSemHora
        				AND sa.Dat_Fecha IS NULL
        				AND cx.Cod_UsuaResp = @Cod_Usua
        				AND gc.Cod_Emp = @Cod_Emp
            END
		IF @Num_Reg IS NOT NULL SET @Pend_Pto =  [dbo].[GKSFNC_VerificaPontoAbono] (@Num_Reg , @Dat_HojeSemHora) 
		ELSE SET @Pend_Pto =  0
		-- Carrega opções habilitadas quando houver bloqueio por problemas no Ponto
		IF @Pend_Pto <> 0
			BEGIN
				INSERT INTO #tmp_opcoes (Cod_Opc)
					SELECT	op.Cod_Opc
        				FROM [dbo].[GKS_OpcoesGrupos] og WITH(NOLOCK)
        					INNER JOIN [dbo].[GKS_UsuariosGrupos] ug WITH(NOLOCK)
        						ON ug.Cod_GrupUsua = og.Cod_GrupUsua
        					INNER JOIN [dbo].[GKS_OpcoesMenu] op WITH(NOLOCK)
        						ON op.Cod_Opc = og.Cod_Opc
						 WHERE og.Cod_GrupUsua = 998
			END

			IF @Pend_Pto = 1 AND @Num_Reg IS NOT NULL
				BEGIN 
					-- Inserindo aviso de Menu Bloqueado por pendencia de RLC
					INSERT INTO [dbo].[GKSDP_Avisos](Cod_Emp, Num_Reg, Dat_Ini, Dat_Fim, Nom_TextAviso, Ind_Pers, Cod_UsuaCad, Dat_Cad)
						VALUES(@Cod_Emp, @Num_Reg, @Dat_HojeSemHora, DATEADD(SECOND, -1, DATEADD(DAY, 1, @Dat_HojeSemHora)), 
								'Menu bloqueado por falta de solicitação de abonos ', 
								'N', 0, @Tmp_Ini)
				END 
			IF @Pend_Pto = 2 AND @Num_Reg IS NOT NULL
				BEGIN 
					-- Inserindo aviso de Menu Bloqueado por pendencia de RLC
					INSERT INTO [dbo].[GKSDP_Avisos](Cod_Emp, Num_Reg, Dat_Ini, Dat_Fim, Nom_TextAviso, Ind_Pers, Cod_UsuaCad, Dat_Cad)
						VALUES(@Cod_Emp, @Num_Reg, @Dat_HojeSemHora, DATEADD(SECOND, -1, DATEADD(DAY, 1, @Dat_HojeSemHora)), 
								'Menu bloqueado por falta de aprovação de abonos ', 
								'N', 0, @Tmp_Ini)
				END 

			IF @Pend_Pto =3  AND @Num_Reg IS NOT NULL
				BEGIN 
					-- Inserindo aviso de Menu Bloqueado por pendencia de RLC
					INSERT INTO [dbo].[GKSDP_Avisos](Cod_Emp, Num_Reg, Dat_Ini, Dat_Fim, Nom_TextAviso, Ind_Pers, Cod_UsuaCad, Dat_Cad)
						VALUES(@Cod_Emp, @Num_Reg, @Dat_HojeSemHora, DATEADD(SECOND, -1, DATEADD(DAY, 1, @Dat_HojeSemHora)), 
								'Menu bloqueado por falta de aprovação de hora-extra ', 
								'N', 0, @Tmp_Ini)
				END 

			IF @Pend_Pto =4  AND @Num_Reg IS NOT NULL
				BEGIN 
					-- Inserindo aviso de Menu Bloqueado por pendencia de RLC
					INSERT INTO [dbo].[GKSDP_Avisos](Cod_Emp, Num_Reg, Dat_Ini, Dat_Fim, Nom_TextAviso, Ind_Pers, Cod_UsuaCad, Dat_Cad)
						VALUES(@Cod_Emp, @Num_Reg, @Dat_HojeSemHora, DATEADD(SECOND, -1, DATEADD(DAY, 1, @Dat_HojeSemHora)), 
								'Menu bloqueado por falta de aprovação de compensacao ', 
								'N', 0, @Tmp_Ini)
				END 
            
        -- Verificando se o usuário possui pendencias a serem resolvidas
		
			BEGIN
				--SELECT @PossuiPendenciaConciliacao = [dbo].[GKSFNC_VerificaPendenciaConciliacao](@Cod_Fil, @Cod_Usua)
				INSERT INTO #PossuiPendenciaConciliacao (Cod_Emp, Num_Rlc, Qtd_diasAtraso)
					SELECT SUBSTRING(item,2,2), SUBSTRING(item,1, LEN(item) - PATINDEX('%-%', REVERSE(item))), REVERSE(SUBSTRING(REVERSE(item),1,PATINDEX('%-%', REVERSE(item)) - 1))
						FROM [dbo].[GKSFNC_QuebraRangeMAX]([dbo].[GKSFNC_VerificaPendenciaConciliacao](@Cod_FilMat, @Cod_Usua),'_')
				SELECT @Pendencia_DocDig		   = [dbo].[GKSFNC_VerificaPendenciaDocumentoDigitalizado] (@Cod_Logon)
				SELECT @Pend_ConferenciaDocDig	   = [dbo].[GKSFNC_VerificaPendenciaConferenciaDocumento](@Cod_Usua)  
			END
		
		SELECT Num_RLC
			INTO #Pendencias_RLC
			FROM [dbo].[GKSFNC_VerificaPendenciaRLC](@Cod_Fil, @Cod_Usua) 
            
		-- Para liberar ponto sem problemas set @Pend_Pto = 0
	
		-- Carrega opções habilitadas quando houver bloqueio por problemas de RLC
		IF EXISTS (SELECT TOP 1 1 
						FROM #Pendencias_RLC)
			BEGIN
				INSERT INTO #tmp_opcoes (Cod_Opc)
					SELECT Cod_Opc 
						FROM [dbo].[GKS_LoginOpcoesLiberadasBloqueio] WITH(NOLOCK)
						WHERE Cod_TipoBloqueio = 2
			END

		-- Carrega opções habilitadas quando houver bloqueio por problemas de conciliação
		IF EXISTS (SELECT TOP 1 1 
						FROM #PossuiPendenciaConciliacao 
						WHERE Cod_Emp = @Cod_Emp) --@PossuiPendenciaConciliacao <> ''
			BEGIN 
				INSERT INTO #tmp_opcoes (Cod_Opc)
					SELECT Cod_Opc 
						FROM [dbo].[GKS_LoginOpcoesLiberadasBloqueio] WITH(NOLOCK)
						WHERE Cod_TipoBloqueio = 1
			END 

		-- Carrega opções habilitadas quando houver bloqueio por problemas de assinatura de documento
		IF @Pendencia_DocDig = 'S'
			BEGIN
				INSERT INTO #tmp_opcoes (Cod_Opc)
					SELECT Cod_Opc 
						FROM [dbo].[GKS_LoginOpcoesLiberadasBloqueio] WITH(NOLOCK)
						WHERE Cod_TipoBloqueio = 3
			END

		

		-- Carrega opções habilitadas quando houver bloqueio por problema de conferência de documento
		IF @Pend_ConferenciaDocDig = 'B'
			BEGIN
				INSERT INTO #tmp_opcoes (Cod_Opc)
					SELECT Cod_Opc 
						FROM [dbo].[GKS_LoginOpcoesLiberadasBloqueio] WITH(NOLOCK)
						WHERE Cod_TipoBloqueio = 4
			END
		
		-- Caso o usuário não tenha nenhum tipo de bloqueio é carregado o menu normalmente	
		IF NOT EXISTS (SELECT TOP 1 1 FROM #Pendencias_RLC) 
			AND NOT EXISTS (SELECT TOP 1 1 
								FROM #PossuiPendenciaConciliacao 
								WHERE Cod_Emp = @Cod_Emp)
			--@PossuiPendenciaConciliacao = '' 
			AND @Pendencia_DocDig = 'N' AND COALESCE(@Pend_ConferenciaDocDig, 'P') = 'P' 
			AND @Pend_Pto = 0
			BEGIN
				-- Monta tabela temporária de herança
				SELECT * INTO #Tmp_Heranca
					FROM [dbo].[GKSFNC_MontaHeranca](@Cod_Usua, @Tmp_Ini)    

				INSERT INTO #Tmp_Opcoes (Cod_Opc)
					SELECT DISTINCT og.Cod_Opc
        					FROM [dbo].[GKS_UsuariosGrupos] ug WITH(NOLOCK)
        						INNER JOIN [dbo].[GKS_OpcoesGrupos] og WITH(NOLOCK)
        							ON og.Cod_GrupUsua = ug.Cod_GrupUsua
							WHERE ug.Cod_Usua = @Cod_Usua
								AND ug.Cod_Emp = @Cod_Emp

				INSERT INTO #Tmp_Opcoes (Cod_Opc)
					SELECT DISTINCT og.Cod_Opc
        					FROM [dbo].[GKS_UsuariosGrupos] ug WITH(NOLOCK)
        						INNER JOIN [dbo].[GKS_OpcoesGrupos] og WITH(NOLOCK)
        							ON og.Cod_GrupUsua = ug.Cod_GrupUsua
        						INNER JOIN #tmp_Heranca he
        							ON ug.Cod_Usua = he.Cod_Usua
        						LEFT OUTER JOIN #Tmp_Opcoes tmp
        							ON tmp.Cod_Opc = og.Cod_Opc
							WHERE ug.Cod_Emp = @Cod_Emp
								AND tmp.Cod_Opc IS NULL

				-- Insere na tabela temporária AS opções personalizadAS (I)
				INSERT INTO #Tmp_Opcoes (Cod_Opc)
					SELECT DISTINCT oup.Cod_Opc
        					FROM [dbo].[GKS_OpcoesUsuariosPers] oup WITH(NOLOCK)
        						LEFT OUTER JOIN #Tmp_Opcoes tmp
        							ON tmp.Cod_Opc = oup.Cod_Opc
        					WHERE oup.Cod_Usua = @Cod_Usua
        						AND oup.Cod_Emp = @Cod_Emp
        						AND oup.Ind_InsRet = 'I'
								AND tmp.Cod_Opc IS NULL

				INSERT INTO #Tmp_Opcoes (Cod_Opc)
					SELECT DISTINCT oup.Cod_Opc
        					FROM [dbo].[GKS_OpcoesUsuariosPers] oup WITH(NOLOCK)
        						INNER JOIN #tmp_Heranca he
        							ON oup.Cod_Usua = he.Cod_Usua
        						LEFT OUTER JOIN #Tmp_Opcoes tmp
        							ON tmp.Cod_Opc = oup.Cod_Opc
							WHERE oup.Cod_Emp = @Cod_Emp
								AND tmp.Cod_Opc IS NULL
        						AND oup.Ind_InsRet = 'I'
            				
				DROP TABLE #Tmp_Heranca
				
				-- Limpando Opções da MOmentum se Usuário Logado em outra Empresa				
				IF  @Cod_Emp <> 15
					BEGIN
						DELETE #Tmp_Opcoes WHERE Cod_Opc IN(1,93)
					END       
			END
		

		-- Checagem de nenhuma opção habilitada
		IF NOT EXISTS (SELECT TOP 1 1
            				FROM #Tmp_Opcoes opc
            					LEFT OUTER JOIN 
            									(SELECT DISTINCT oup.Cod_Opc
            										FROM [dbo].[GKS_OpcoesUsuariosPers] oup WITH(NOLOCK)
            										WHERE   oup.Cod_Usua = @Cod_Usua
            											AND oup.Cod_Emp = @Cod_Emp
            											AND oup.Ind_InsRet = 'R') ret
            						ON opc.Cod_Opc = ret.Cod_Opc
            				WHERE ret.Cod_Opc IS NULL)
			BEGIN
				SET @Cod_Ret = 5
				SET @Tmp_Exec = DATEDIFF(ms,@Tmp_Ini, GETDATE())
				GOTO Devolve_vazio
			END
		
		-- Passou pelas verificações
		SET @Cod_Ret = 0

		-- Devolve dataset com opções habilitadas e herdadas para o usuario em questão
		SELECT x.Cod_Opc,
			   x.Nom_Opc,
			   x.Nom_Icon,
			   x.Nom_URLAngular,
			   x.Cod_OpcMae,
			   x.Dat_Conversao,
			   x.Cod_DomOpc,
			   uef.Num_Ordem,
			   (CASE WHEN uef.Cod_Opc IS NOT NULL THEN 'S' ELSE 'N' END) AS Ind_Fav
			FROM 
					(
						SELECT DISTINCT
							   op.Cod_Opc,
							   op.Cod_OpcMae,
							   op.Dat_Conversao,
							   op.Cod_DomOpc,
							   ISNULL(op.Ind_LiberaAcessoComPendencia,'N') AS Ind_LiberaAcessoComPendencia,
							   op.Nom_Opc,
							   op.Nom_Icon,
							   op.Nom_URLAngular
							FROM #Tmp_Opcoes opc
								INNER JOIN [dbo].[GKS_OpcoesMenu] op WITH(NOLOCK)
									ON op.Cod_Opc = opc.Cod_Opc
								LEFT OUTER JOIN 
												(SELECT DISTINCT oup.Cod_Opc
													FROM [dbo].[GKS_OpcoesUsuariosPers] oup WITH(NOLOCK)
													WHERE   oup.Cod_Usua = @Cod_Usua
														AND oup.Cod_Emp = @Cod_Emp
														AND oup.Ind_InsRet = 'R') ret
									ON opc.Cod_Opc = ret.Cod_Opc
							WHERE ret.Cod_Opc IS NULL
					) x
					LEFT OUTER JOIN [dbo].[GKS_UsuariosEmpFav] uef WITH(NOLOCK)
						ON uef.Cod_Usua = @Cod_Usua
							AND uef.Cod_Emp = @Cod_Emp
							AND uef.Cod_Opc = x.Cod_Opc
			ORDER BY [dbo].[GKSFNC_ClassificaOpcAlafabetica](x.Cod_Opc)
	       
	    IF EXISTS(SELECT TOP 1 1 FROM #Pendencias_RLC) AND @Num_Reg IS NOT NULL
			BEGIN 
				-- Inserindo aviso de Menu Bloqueado por pendencia de RLC
				INSERT INTO [dbo].[GKSDP_Avisos](Cod_Emp, Num_Reg, Dat_Ini, Dat_Fim, Nom_TextAviso, Ind_Pers, Cod_UsuaCad, Dat_Cad)
					VALUES(@Cod_Emp, @Num_Reg, @Dat_HojeSemHora, DATEADD(SECOND, -1, DATEADD(DAY, 1, @Dat_HojeSemHora)), 
							SUBSTRING(	'Menu bloqueado por pendência de regularização de RLC: ' + 
										STUFF((SELECT ', ' + CAST(Num_RLC AS VARCHAR) 
												FROM #Pendencias_RLC 
												FOR XML PATH('')), 1,2,''), 1, 2000), 
							'N', 0, @Tmp_Ini)
			END 

	
			
		 IF EXISTS (SELECT TOP 1 1 
								FROM #PossuiPendenciaConciliacao 
								WHERE Cod_Emp = @Cod_Emp)
			AND @Num_Reg IS NOT NULL
		 --@PossuiPendenciaConciliacao <> '' 
			BEGIN 
				-- Inserindo aviso de Menu Bloqueado por pendencia de RLC
				INSERT INTO [dbo].[GKSDP_Avisos](Cod_Emp, Num_Reg, Dat_Ini, Dat_Fim, Nom_TextAviso, Ind_Pers, Cod_UsuaCad, Dat_Cad, Qtd_DiasAtraso)
					SELECT @Cod_Emp, 
						   @Num_Reg, 
						   @Dat_HojeSemHora, 
						   DATEADD(SECOND, -1, DATEADD(DAY, 1, @Dat_HojeSemHora)), 
						   'Menu bloqueado por pendência de Conciliações Contábeis ' + Num_Rlc, 
							'N', 
							0, 
							@Tmp_Ini,
							Qtd_DiasAtraso
						FROM #PossuiPendenciaConciliacao 
						WHERE Cod_Emp = @Cod_Emp
			END 

		IF @Pendencia_DocDig = 'S' AND @Num_Reg IS NOT NULL
			BEGIN

				INSERT INTO [dbo].[GKSDP_Avisos](Cod_Emp, Num_Reg, Dat_Ini, Dat_Fim, Nom_TextAviso, Ind_Pers, Cod_UsuaCad, Dat_Cad)
					VALUES(@Cod_Emp, @Num_Reg, @Dat_HojeSemHora, DATEADD(SECOND, -1, DATEADD(DAY, 1, @Dat_HojeSemHora)), 
							'Menu bloqueado por pendência de assinatura de documento digitalizado', 
							'N', 0, @Tmp_Ini)

			END
			
		IF @Pend_ConferenciaDocDig = 'B' AND @Num_Reg IS NOT NULL
			BEGIN
				INSERT INTO [dbo].[GKSDP_Avisos](Cod_Emp, Num_Reg, Dat_Ini, Dat_Fim, Nom_TextAviso, Ind_Pers, Cod_UsuaCad, Dat_Cad)
					VALUES(@Cod_Emp, @Num_Reg, @Dat_HojeSemHora, DATEADD(SECOND, -1, DATEADD(DAY, 1, @Dat_HojeSemHora)), 
							'Menu bloqueado por pendência de conferência de documentos digitalizados', 
							'N', 0, @Tmp_Ini)
			END
			
		DROP TABLE #Tmp_Opcoes
		DROP TABLE #Pendencias_RLC

		GOTO Devolve_Parametros


Devolve_vazio:
		-- Devolve datASet de opções vazio
		SELECT  NULL AS Cod_Opc,
				NULL AS Ind_Fav


Devolve_Parametros:
		-- Registrando ação de logon 
		INSERT INTO [dbo].[GKS_RegistroLogon](Num_IP, Dat_Logon, Cod_Logon, Cod_Senha, Cod_EmpLog, Cod_RetLogon,Nom_Requisicao, Ind_OrigemAcesso)
			VALUES(@Num_IP, GETDATE(), @Cod_Logon, [dbo].[GKSFNC_CriptografaSenha](@Cod_Senha), @Cod_EmpLog, @Cod_Ret, @Nom_Requisicao, @Ind_OrigemAcesso)

		-- Efetuando marcação de ponto automatica
		IF @Ind_MarcaPonto = 'S'
			BEGIN
				IF @Cod_TipHor IS NOT NULL
					AND @Num_SeqlAreaIP IS NOT NULL
					BEGIN
						DECLARE @RetPto			int,
								@Retorno		varchar(8),
								@Hora			int,
								@Minuto			int,
								@Num_HorEnt		tinyint,
								@Num_HorSaiAlm	tinyint,
								@Num_HorEntAlm	tinyint
				
						-- Recuperando marcação de ponto
						SELECT  @Num_HorEnt = Num_HorEnt,
								@Num_HorSaiAlm = Num_HorSaiAlm,
								@Num_HorEntAlm = Num_HorEntAlm
							FROM [dbo].[GKSDP_Pontos] pt WITH(NOLOCK)
							WHERE pt.Num_Reg = @Num_Reg
								AND pt.Dat_Ponto = @Dat_HojeSemHora
						
						IF	@Num_HorEnt IS NULL AND 
							[dbo].[GKSFNC_ValidaIPFuncPonto](@Num_Reg, @Num_IP) = 'N'
							BEGIN
								-- Inserindo aviso de não marcação de ponto
								SET @Nom_ErroMarcaPonto = 'Marcação de ponto não autorizada para o IP que o usuario esta utilizando. IP.: ' + ISNULL(@Num_IP, 'Não Informado')
								INSERT INTO [dbo].[GKSDP_Avisos](Cod_Emp, Num_Reg, Dat_Ini, Dat_Fim, Nom_TextAviso, Ind_Pers, Cod_UsuaCad, Dat_Cad)
									VALUES(@Cod_Emp, @Num_Reg, @Dat_HojeSemHora, DATEADD(SECOND, -1, DATEADD(DAY, 1, @Dat_HojeSemHora)), 
											@Nom_ErroMarcaPonto, 
											'N', 0, @Tmp_Ini)
							END
						ELSE
							BEGIN
								IF @Num_HorEnt IS NULL 
									BEGIN
										SET @Hora = DATEPART(HOUR, @Tmp_Ini)
										SET @Minuto = DATEPART(MINUTE, @Tmp_Ini)
							
										-- Inserindo marcação de ponto
										SET @Nom_ErroMarcaPonto = NULL
										EXEC @RetPto = [dbo].[GKSSP_InsPontos] @Num_Reg, @Dat_HojeSemHora, @Cod_TipHor, @Hora, @Minuto, 'S', @Num_IP, @Retorno OUTPUT
								
										IF PATINDEX('%' + [dbo].[GKSFNC_FormataIntZero](@RetPto, 2) + '%', '06-08-11-12-13-17') > 0
											BEGIN
												-- Inserindo aviso de não marcação de ponto
												INSERT INTO [dbo].[GKSDP_Avisos](Cod_Emp, Num_Reg, Dat_Ini, Dat_Fim, Nom_TextAviso, Ind_Pers, Cod_UsuaCad, Dat_Cad)
													VALUES(@Cod_Emp, @Num_Reg, @Dat_HojeSemHora, DATEADD(SECOND, -1, DATEADD(DAY, 1, @Dat_HojeSemHora)), 
															'Não foi possível efetuar a marcação de ponto automatica pelos seguintes codigos de inconsistência.: ' + @Retorno, 
															'N', 0, @Tmp_Ini)
											END
									END
								ELSE IF @Num_HorSaiAlm IS NOT NULL AND @Num_HorEntAlm IS NULL SET @Ind_SolMarcaEntAlm = 'S'
							END
					END
			END
			
		-- Devolvendo dataset com parametros de retorno
		IF ISNULL(@Ind_Param, 'S') <> 'N'
			BEGIN
				SET @Tmp_Exec = DATEDIFF(ms, @Tmp_Ini, GETDATE())
		
				SELECT	@Cod_Usua 		   		AS Cod_Usua,
						@Num_Reg 		   		AS Num_Reg,
						@Nom_Func		   		AS Nom_Func,
						@Nom_Apelido 	   		AS Nom_Apelido,
						@Nom_Email		   		AS Nom_Email,
						@Cod_Emp 		   		AS Cod_Emp,
						@Nom_Emp 		   		AS Nom_Emp,
						@Nom_CorFundo 	   		AS Nom_CorFundo,
						@Nom_CorFrente 	   		AS Nom_CorFrente,
						@Cod_Atendente     		AS Cod_Atendente,
						@Nom_Atendente	   		AS Nom_Atendente,
						@Cod_Time		  		AS Cod_Time,
						@Cod_Dep		   		AS Cod_Dep,
						@Nom_Dep		   		AS Nom_Dep,
						@Cod_CaixaOper     		AS Cod_CaixaOper,
						@Num_CtaCtbCaixa   		AS Num_CtaCtbCaixa,
						@Nom_CtaCtbCaixa   		AS Nom_CtaCtbCaixa,
						@Cod_Ret 		   		AS Cod_Ret,
						@Tmp_Exec 		   		AS Tmp_Exec,
					    @Nom_ApelidoEmp    		AS Nom_ApelidoEmp,
                        @Pend_Pto		   		AS Pend_Pto,
                        @Ind_PermTrocaEmpr 		AS Ind_PermTrocaEmpr,
                        @Ind_AcessoChat	   		AS Ind_AcessoChat,
                        @Cod_StatusUsua	   		AS Cod_StatusUsua,
                        @Nom_CidAloc       		AS Nom_CidAloc,
                        @Ind_SolMarcaEntAlm		AS Ind_SolMarcaEntAlm,
						@Nom_ErroMarcaPonto		AS Nom_ErroMarcaPonto,
          				@Ind_AtivaMonitoramento AS Ind_AtivaMonitoramento,
						@Cod_Fil				AS Cod_Fil,
						@Nom_Fil				AS Nom_Fil,
						(SELECT Cod_GrupUsua FROM [dbo].[GKS_UsuariosGrupos] WHERE Cod_Usua = @Cod_Usua AND Cod_Emp = @Cod_Emp) AS Cod_GrupUsua,
						@Cod_TipoUsuario		AS Cod_TipoUsuario
			END
			
		RETURN 0
	END


