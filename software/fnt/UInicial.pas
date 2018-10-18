{------------------------------------------------------------------------------------------------

				  O C E A N O   -    M A R    D E    S O L U Ç Õ E S

-------------------------------------------------------------------------------------------------
										  I N I C I O
-------------------------------------------------------------------------------------------------
Criação      : 11/10/2001 02:00:00
Local        : Escritório, Florianópolis
Autor(es)    : Cleber J. Amaral
Descrição    : Formulario inicial da aplicação
Comentário   :
-------------------------------------------------------------------------------------------------
Atualização  : 31/10/2001 10:00
Autor(es)    : Iomani Engelmann Gomes
Comentário   : Inclusao do menu para cadastro de
-------------------------------------------------------------------------------------------------}
unit UInicial;
//-----------------------------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------------------------
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Menus, StdCtrls,
  Buttons, ExtCtrls, WinTypes, WinProcs, Grids, DBGrids, ComCtrls, ToolWin, Dblogdlg, UProduto,
  UCliente, UPedidoExpedicao, UFunGeral;
//-----------------------------------------------------------------------------------------------
type
  TFInicial = class(TForm)
    MenuSuperior: TMainMenu;
    MSistema: TMenuItem;
    mAjuda: TMenuItem;
    smSobre: TMenuItem;
    sm1MPedido: TMenuItem;
    mitCliente: TMenuItem;
    sm1Cardapio: TMenuItem;
    sm1Sair: TMenuItem;
    sm1ControledeExpedicao: TMenuItem;
    MFerramentas: TMenuItem;
    SMRelatrio: TMenuItem;
    mitConfiguracoes: TMenuItem;
	 SMCalculadora: TMenuItem;
    sm1Entregador: TMenuItem;
    SMN1: TMenuItem;
    SMN2: TMenuItem;
	 sm1BlocoDeNotas: TMenuItem;
    mitLimparBase: TMenuItem;
	 ManipulaodeGrupo1: TMenuItem;
    ManipulaodeGrupoCliente1: TMenuItem;
    sm1Vendedores: TMenuItem;
    Janela1: TMenuItem;
    smCascata: TMenuItem;
    smLadoaLado: TMenuItem;
    mAdministracao: TMenuItem;
    sm2ControledeExpedicao: TMenuItem;
    sm1ControledeAcesso: TMenuItem;
	 sm2AlterarSenha: TMenuItem;
    GerentedeBancodeDados1: TMenuItem;
    sm1Ajuda: TMenuItem;
    N1: TMenuItem;
    smLicenca: TMenuItem;
	 N2: TMenuItem;
    StatusBar1: TStatusBar;
    mitControledeBrindes: TMenuItem;
    mitConfigurarPontuacao: TMenuItem;
    N3: TMenuItem;
    mitFormasdepagamento: TMenuItem;
	 mitZerarPontuacaoDeTodos1: TMenuItem;
    mitRelatorios: TMenuItem;
    mitFechamentodecaixa: TMenuItem;
	 procedure Pedidos1Click(Sender: TObject);
    procedure BtHisClieClick(Sender: TObject);
	 procedure BtCadProdClick(Sender: TObject);
    procedure BtSairClick(Sender: TObject);
    procedure smSobreClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
	 procedure FormCreate(Sender: TObject);
	 procedure SMCalculadoraClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sm1BlocoDeNotasClick(Sender: TObject);
    procedure mitLimparBaseClick(Sender: TObject);
	 procedure ManipulaodeGrupo1Click(Sender: TObject);
    procedure ManipulaodeGrupoCliente1Click(Sender: TObject);
	 procedure smLadoaLadoClick(Sender: TObject);
    procedure smCascataClick(Sender: TObject);
    procedure sm2AlterarSenhaClick(Sender: TObject);
	 procedure GerentedeBancodeDados1Click(Sender: TObject);
	 procedure FormDestroy(Sender: TObject);
	 procedure sm1AjudaClick(Sender: TObject);
	 procedure smLicencaClick(Sender: TObject);
	 procedure mitClienteClick(Sender: TObject);
	 procedure mitConfiguracoesClick(Sender: TObject);
	 procedure sm1EntregadorClick(Sender: TObject);
	 procedure mitConfigurarPontuacaoClick(Sender: TObject);
	 procedure mitFormasdepagamentoClick(Sender: TObject);
	 procedure mitZerarPontuacaoDeTodos1Click(Sender: TObject);
	 procedure mitRelatoriosClick(Sender: TObject);
	 procedure mitFechamentodecaixaClick(Sender: TObject);
  private
	 { Private declarations }
		contadorVendedorAtivo:integer;
		FunGeral	: TFunGeral;
		nomeSoft : PChar;
		xAtom: atom;

		NOMEEMPRESA : String;
		ACESSOUSUARIO01 : String;
		ACESSOSENHA01 : String;

  public
	 { Public declarations }
	 procedure alterarContadorVendedorAtivo(qualContadorVendedorAtivo:integer);
	 function verificarSeFormEstaAberto(qualCaptionForm:String):boolean;
	 function fornecerContadorVendedorAtivo:integer;
	 procedure chamarRelatorioComissaoDoEntregador(p_CdEntregador: integer);
	 procedure abrirJanelaDeCliente(p_Codigo: String; p_Inclui: Bool; p_TipoBusca: Integer);
  end;

var
		FInicial: TFInicial;
//-----------------------------------------------------------------------------------------------
implementation {$R *.DFM}
//-----------------------------------------------------------------------------------------------
uses UPedido, UFuncoes, UTabTele, USobre,  URelPedi, UAlteraSenha, ULicenca,
  UGerTabe, UEntregador, UClienteGrupo, UProdutoGrupo, ULimpezaBase,
  UClienteGrupoManipulacao, UProdutoGrupoManipulacao;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.alterarContadorVendedorAtivo(qualContadorVendedorAtivo:integer);
begin
  contadorVendedorAtivo:=qualContadorVendedorAtivo;
end;
//-----------------------------------------------------------------------------------------------
function TFInicial.fornecerContadorVendedorAtivo:integer;
begin
  result:=contadorVendedorAtivo;
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.Pedidos1Click(Sender: TObject);
begin
	if not verificarSeFormEstaAberto('frmPedido') then
	begin
		Application.createForm(TfrmPedido,frmPedido);
	end
	else
	begin
		frmPedido.WindowState := wsNormal;
		frmPedido.Show();
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.BtHisClieClick(Sender: TObject);
begin
	if not verificarSeFormEstaAberto('frmPedidoExpedicao') then
	begin
		Application.CreateForm(TfrmPedidoExpedicao,frmPedidoExpedicao)
	end
	else
	begin
		frmPedidoExpedicao.WindowState := wsNormal;
		frmPedidoExpedicao.Show();
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.BtCadProdClick(Sender: TObject);
begin
	if (mostrarJaneladeAcesso(
			nomeSoft,
			ACESSOUSUARIO01,
			ACESSOSENHA01
	)) then begin
        	if not verificarSeFormEstaAberto('FrmProduto') then
        	begin
        		Application.CreateForm(TfrmProduto,frmProduto);
        	end
        	else
        	begin
        		frmProduto.WindowState := wsNormal;
        		frmProduto.Show();
        	end;
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.BtSairClick(Sender: TObject);
begin
  try
	 Close;
  except
	 MessageDlg('Erro ao fechar a aplicação!', mtError, [mbOk], 0);
  end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.smSobreClick(Sender: TObject);
begin
	try
		if not verificarSeFormEstaAberto('FSobre') then begin
			Application.createForm(TfrmSobre,frmSobre);
			frmSobre.ShowModal();
		end else begin
			frmSobre.ShowModal();
		end;
	except
		MessageDlg('Erro ao abrir a janela de sobre!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not (MessageDlg('Deseja realmente fechar o aplicativo?', mtWarning, [mbYes, mbNo], 0) = mrYes) then begin
	 Abort;
	 Exit;
  end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.FormCreate(Sender: TObject);
begin
	try
		//-- Procura na tabela para verificar se o programa já está rodando - Se Não encontrou
		nomeSoft := 'Softiza Attend 2009';
		if GlobalFindAtom(nomeSoft) = 0 then begin
			xAtom := GlobalAddAtom(nomeSoft)
		end else begin
			MessageDlg('Este aplicativo já está sendo executado!', mtInformation, [mbOk], 0);
//			Halt;
		end;

  		NOMEEMPRESA := FTabTele.retornarVariavel('NOMEEMPRESA','Empresa');
		ACESSOUSUARIO01 := FTabTele.retornarVariavel('ACESSOUSUARIO01','Gerente');
		ACESSOSENHA01 := FTabTele.retornarSenhaDecriptografada(FTabTele.retornarVariavel('ACESSOSENHA01',FTabTele.retornarVarSenhaCriptPadrao()));


		FTabTele.aplicarConfiguracaoPadrao();
	except
		MessageDlg('Erro ao criar janela inicial!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.SMCalculadoraClick(Sender: TObject);
begin
  try
	 WinExec('CALC.EXE',SW_SHOWNORMAL);
  except
	 MessageDlg('Calculadora do windows não encontrada!', mtInformation, [mbOk], 0);
  end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.FormShow(Sender: TObject);
begin
	Caption := Application.Title+' - '+NOMEEMPRESA;
	Application.CreateForm(TfrmLicenca, frmLicenca);
	frmLicenca.setarParametros(1,20,25,4,24,23,23,22,2,8,14,18);
	frmLicenca.setNomeSoftware('Attend2009');//nomeSoft
	frmLicenca.carregarCampos();
	frmLicenca.setarDadosEmpresa(
		FTabTele.retornarVarEmailEmpresa,
		FTabTele.retornarVarWebSiteEmpresa,
		FTabTele.retornarVarFoneEmpresa,
		FTabTele.retornarVarSmtpEmpresa
	);
	if not (frmLicenca.retornarRegistro(true)) then frmLicenca.mostrarMsgPedidoDeRegistro();

//	FTabTele.cadastrarClienteTemporario();
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.sm1BlocoDeNotasClick(Sender: TObject);
begin
	try
		WinExec('NOTEPAD.EXE',SW_SHOWNORMAL);
	except
		MessageDlg('Editor de Texto do windows não encontrado.', mtInformation, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.mitLimparBaseClick(Sender: TObject);
begin
	if (mostrarJaneladeAcesso(
		nomeSoft,
		ACESSOUSUARIO01,
		ACESSOSENHA01
	)) then
	begin
		if not verificarSeFormEstaAberto('frmLimpezaBase') then
		begin
			Application.CreateForm(TfrmLimpezaBase,frmLimpezaBase);
		end
		else
		begin
			frmLimpezaBase.WindowState := wsNormal;
			frmLimpezaBase.Show();
		end;
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.ManipulaodeGrupo1Click(Sender: TObject);
begin
	if (mostrarJaneladeAcesso(
		nomeSoft,
		ACESSOUSUARIO01,
		ACESSOSENHA01
	)) then
	begin
		if not verificarSeFormEstaAberto('frmProdutoGrupoManipulacao') then
		begin
			Application.CreateForm(TfrmProdutoGrupoManipulacao,frmProdutoGrupoManipulacao);
		end
		else
		begin
			frmProdutoGrupoManipulacao.WindowState := wsNormal;
			frmProdutoGrupoManipulacao.Show();
		end;
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.ManipulaodeGrupoCliente1Click(Sender: TObject);
begin
	if (mostrarJaneladeAcesso(
		nomeSoft,
		ACESSOUSUARIO01,
		ACESSOSENHA01
	)) then
	begin
		if not verificarSeFormEstaAberto('frmClienteGrupoManipulacao') then
		begin
			Application.CreateForm(TfrmClienteGrupoManipulacao,frmClienteGrupoManipulacao);
		end
		else
		begin
			frmClienteGrupoManipulacao.WindowState := wsNormal;
			frmClienteGrupoManipulacao.Show();
		end;
	end;
end;
//-----------------------------------------------------------------------------------------------
function TFInicial.verificarSeFormEstaAberto(qualCaptionForm:String):boolean;
var I      : integer;
begin
	result := False;
	for I := FInicial.MDIChildCount-1 downto 0 do
		if UpperCase(FInicial.MDIChildren[I].Name) = UpperCase(qualCaptionForm) then
			result := True;
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.smLadoaLadoClick(Sender: TObject);
begin
  FInicial.Tile();
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.smCascataClick(Sender: TObject);
begin
  FInicial.Cascade();
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.sm2AlterarSenhaClick(Sender: TObject);
begin
  Application.CreateForm(TFAlteraSenha, FAlteraSenha);
  FAlteraSenha.ShowModal();
  FAlteraSenha.Destroy();
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.GerentedeBancodeDados1Click(Sender: TObject);
begin
	if (mostrarJaneladeAcesso(
		nomeSoft,
		ACESSOUSUARIO01,
		ACESSOSENHA01
	)) then begin
		if not verificarSeFormEstaAberto('FGerTabe') then begin
			Application.CreateForm(TFGerTabe, FGerTabe);
			FGerTabe.ShowModal;
		end else begin
			FGerTabe.WindowState := wsNormal;
			FGerTabe.ShowModal;
		end;
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.FormDestroy(Sender: TObject);
begin
  //-- Remove o item da tabela, de modo que a aplicação possa ser executada novamente}
  GlobalDeleteAtom(xAtom);
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.sm1AjudaClick(Sender: TObject);
begin
	MessageDlg('Para obter ajuda, por favor, consulte a documentação atualizada disponível no web-site.'+#13+'Os meios para contactar nossa equipe de suporte estão descritos na janela "Sobre" ou no web-site.', mtInformation, [mbOk], 0);
//  Application.HelpFile := 'Tele.hlp';
//  Application.HelpJump('TApplication_HelpJump');
//  Application.HelpContext(1);
end;
//-----------------------------------------------------------------------------------------------
//-- Chama Gera RElatorio Comissao do Entregador
procedure TFInicial.chamarRelatorioComissaoDoEntregador(p_CdEntregador: integer);
begin
	frmRelatorio.gerarRelatorioComissaoDoEntregador(p_CdEntregador);
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.smLicencaClick(Sender: TObject);
begin
	frmLicenca.ShowModal();
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.mitClienteClick(Sender: TObject);
begin
	if not verificarSeFormEstaAberto('FrmCliente') then
	begin
		Application.CreateForm(TfrmCliente,frmCliente);
	end
	else
	begin
		frmCliente.WindowState := wsNormal;
		frmCliente.Show();
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.abrirJanelaDeCliente(p_Codigo: String; p_Inclui: Bool; p_TipoBusca: Integer);
begin
	mitClienteClick(nil);
	frmCliente.setarCliente(p_Codigo,p_Inclui,p_TipoBusca);
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.mitConfiguracoesClick(Sender: TObject);
var	inputString:	String;
begin
	if not FunGeral.mostrarJaneladeAcesso(
		NOMEEMPRESA,
		ACESSOUSUARIO01,
		ACESSOSENHA01
	)then Exit;

	abrirQuery(FTabTele.qTele,'SELECT CONTADOR, UPPER(NOME) AS NOME, DADO FROM VARIAVEL ORDER BY NOME ASC');
	while not (FTabTele.qTele.Eof) do begin
		if
			(FTabTele.qTele.FieldByName('Nome').AsString <> 'ACESSOSENHA01')
		and
			(FTabTele.qTele.FieldByName('Nome').AsString <> 'VERSAODB')
		then begin
			inputString := FTabTele.retornarVariavel(FTabTele.qTele.FieldByName('Nome').AsString,'');
			if (InputQuery(FTabTele.qTele.FieldByName('Nome').AsString, FTabTele.qTele.FieldByName('Nome').AsString, inputString)) then begin
				FTabTele.alterarVariavel(FTabTele.qTele.FieldByName('Nome').AsString,inputString);
			end else begin
				Exit;
			end;
		end;
		FTabTele.qTele.Next();
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.sm1EntregadorClick(Sender: TObject);
begin
	if not verificarSeFormEstaAberto('FrmEntregador') then
	begin
		Application.CreateForm(TFrmEntregador,FrmEntregador);
	end
	else
	begin
		frmEntregador.WindowState := wsNormal;
		frmEntregador.Show();
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.mitConfigurarPontuacaoClick(Sender: TObject);
var	inputString:	String;
begin
	abrirQuery(FTabTele.qTeleOpen,'SELECT * FROM PRODUTOGRUPO ORDER BY NOME ASC');
	while not (FTabTele.qTeleOpen.Eof) do begin
		inputString := FTabTele.qTeleOpen.FieldByName('Pontuacao').AsString;
		if (InputQuery(FTabTele.qTeleOpen.FieldByName('Nome').AsString, FTabTele.qTeleOpen.FieldByName('Nome').AsString, inputString)) then begin
			if (inputString = '') then begin
				//-- Se for '' então grava ZERO
				executarQuery(FTabTele.qTele,'UPDATE PRODUTOGRUPO SET PONTUACAO=0 WHERE CONTADOR='+FTabTele.qTeleOpen.FieldByName('Contador').AsString);
			end else begin
				executarQuery(FTabTele.qTele,'UPDATE PRODUTOGRUPO SET PONTUACAO='+inputString+' WHERE CONTADOR='+FTabTele.qTeleOpen.FieldByName('Contador').AsString);
			end;
		end;
		FTabTele.qTeleOpen.Next();
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.mitFormasdepagamentoClick(Sender: TObject);
var	inputString:	String;
begin
	abrirQuery(FTabTele.qTeleOpen,'SELECT CONTADOR, NOME, IDESTADO, TROCO FROM FORMAPAGAMENTO');
	while not (FTabTele.qTeleOpen.Eof) do begin
		inputString := FTabTele.qTeleOpen.FieldByName('IDESTADO').AsString;
		if (InputQuery(FTabTele.qTeleOpen.FieldByName('NOME').AsString, '0 = Inativo e 1 = Ativo', inputString)) then begin
			executarQuery(
				FTabTele.qTele,
				'UPDATE FORMAPAGAMENTO SET IDESTADO='+inputString+
				' WHERE CONTADOR='+FTabTele.qTeleOpen.FieldByName('CONTADOR').AsString
			);
		end;
		FTabTele.qTeleOpen.Next();
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.mitZerarPontuacaoDeTodos1Click(Sender: TObject);
begin
	try
		if MessageDlg('Esta opção irá zerar a pontuação de todos os clientes. Deseja proceguir?', mtWarning, [mbYes, mbNo], 0) = mrYes then begin
			executarQuery(
				FTabTele.qTele,
				'UPDATE CLIENTE SET PONTUACAO=0'
			);
		end;
	except
		MessageDlg('Erro ao zerar pontuação do cliente', mtInformation, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.mitRelatoriosClick(Sender: TObject);
begin
	if (mostrarJaneladeAcesso(
			nomeSoft,
			ACESSOUSUARIO01,
			ACESSOSENHA01
	)) then begin
		FrmRelatorio.ShowModal();
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFInicial.mitFechamentodecaixaClick(Sender: TObject);
begin
	FrmRelatorio.gerarRelatorioVendasGrupo();
end;
//-----------------------------------------------------------------------------------------------
end.
//-----------------------------------------------------------------------------------------------
//   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM
//-----------------------------------------------------------------------------------------------


