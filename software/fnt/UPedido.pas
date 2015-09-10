{------------------------------------------------------------------------------------------------

				  O C E A N O   -    M A R    D E    S O L U Ç Õ E S

-------------------------------------------------------------------------------------------------
										  I N I C I O
-------------------------------------------------------------------------------------------------
Criação      : 11/10/2001 16:00
Local        : Escritório, Florianópolis
Autor(es)    : Cleber J. Amaral
Descrição    :
Comentário   :
-------------------------------------------------------------------------------------------------
Atualização  :
Autor(es)    :
Comentário   :
-------------------------------------------------------------------------------------------------}
unit UPedido;
//-----------------------------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------------------------
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ExtCtrls, StdCtrls, Buttons,
  comctrls, Grids, DBCtrls, DB, Dialogs, Mask, DBGrids, UImpPedi, Menus, UFunDB, UFunGeral,
  DBTables, UPedidoFinalizacao, UObservacao, UPedidoUltimo;
//-----------------------------------------------------------------------------------------------
type
	TfrmPedido = class(TForm)
		MainMenu1: TMainMenu;
		MCliente: TMenuItem;
		SMAlterarDados: TMenuItem;
		MPedido: TMenuItem;
		SMFinalizarPedido: TMenuItem;
		SMUltimoPedido: TMenuItem;
		MOculto: TMenuItem;
		SMCampoCodigo: TMenuItem;
		mitSelecionarPedidoMovimentacao: TMenuItem;
		SMIniciarPedido: TMenuItem;
		SMGrupo: TMenuItem;
		sbPedido: TScrollBox;
		smCadastrarObservacao: TMenuItem;
		panCampos: TPanel;
		panProcura: TPanel;
		edtCodigo: TEdit;
		IniciarPedido1: TMenuItem;
		sm1TotalizarPedido: TMenuItem;
		N1: TMenuItem;
		N2: TMenuItem;
		panPedidosAbertos: TPanel;
		sbCamposClientes: TScrollBox;
		dsqPedidoMovimentacao: TDataSource;
		smRemanejarPedido: TMenuItem;
		labTotalPedido: TLabel;
		sgPedidosAbertos: TStringGrid;
		Label6: TLabel;
		edtNome: TEdit;
		labNome: TLabel;
		labLogradouro: TLabel;
		edtLogradouro: TEdit;
		edtNumero: TEdit;
		labNumero: TLabel;
		edtComplemento: TEdit;
		labComplemento: TLabel;
		edtReferencia: TEdit;
		labReferencia: TLabel;
		edtCidade: TEdit;
		labCidade: TLabel;
		edtBairro: TEdit;
		labBairro: TLabel;
		labDataUltimoPedido: TLabel;
		mitExibir: TMenuItem;
		mitDescricao: TMenuItem;
		mitListagemDeProdutos: TMenuItem;
		mitPedidosAbertos: TMenuItem;
		labCodigo: TLabel;
		Label2: TLabel;
		dsqProduto: TDataSource;
		panGrades: TPanel;
		dbgPedidoMovimentacao: TDBGrid;
		panPedidoMovimentacao: TPanel;
		Panel2: TPanel;
		eCodigo: TEdit;
		LCodigo: TLabel;
		panListagemDeProdutos: TPanel;
		dbgListagemDeProdutos: TDBGrid;
		panProdutoTop: TPanel;
		Label4: TLabel;
		Label5: TLabel;
		panDescricao: TPanel;
		labDescricao: TLabel;
		edtDescricao: TEdit;
		panBtFinalizar: TPanel;
		btFinalizar: TBitBtn;
		btTotalizar: TBitBtn;
    qryProduto: TQuery;
		qryTemporaria: TQuery;
		Label12: TLabel;
		labProxPedido: TLabel;
		Label10: TLabel;
		qryProdutoGrupo: TQuery;
		dsqProdutoGrupo: TDataSource;
		lcbProdutoGrupo: TDBLookupComboBox;
		btnCancelarFiltros: TBitBtn;
		labListagemDeProdutos: TLabel;
		edtContador: TEdit;
		qryPedidoMovimentacao: TQuery;
		Label1: TLabel;
		edtDataUltimoPedido: TEdit;
		edtObs2: TEdit;
		edtObs1: TEdit;
		labObs: TLabel;
    mitZerarPontuacao: TMenuItem;
    PopupMenu1: TPopupMenu;
    mitLancar: TMenuItem;
    mitInserirItem: TMenuItem;
    N4: TMenuItem;
    btnBuscarCliente: TBitBtn;
    mitBuscar: TMenuItem;
		procedure FormShow(Sender: TObject);
		procedure inicializarPedidos();
		procedure TelefoneKeyPress(Sender: TObject; var Key: Char);
		procedure edtCodigoEnter(Sender: TObject);
		procedure MostraCampos;
		procedure OcultaCampos;
		procedure FormCreate(Sender: TObject);
		procedure edtProcuraNomeKeyPress(Sender: TObject; var Key: Char);
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		procedure BtUltPedidoClick(Sender: TObject);
		procedure BtFinalizarPedidoClick(Sender: TObject);
		procedure eCodigoEnter(Sender: TObject);
		procedure eCodigoExit(Sender: TObject);
		procedure eCodigoKeyPress(Sender: TObject; var Key: Char);
		procedure SMCampoCodigoClick(Sender: TObject);
		procedure mitSelecionarPedidoMovimentacaoClick(Sender: TObject);
		procedure dbgListagemDeProdutosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
		procedure SMGrupoClick(Sender: TObject);
		procedure SMAlterarDadosClick(Sender: TObject);
		procedure dbgPedidoMovimentacaoDblClick(Sender: TObject);
		procedure smCadastrarObservacaoClick(Sender: TObject);
		//-- Atualiza grades de produtos e pedidos
		procedure atualizarGrades();
		procedure btTotalizarClick(Sender: TObject);
		procedure sgPedidosAbertosSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
		procedure sgPedidosAbertosDblClick(Sender: TObject);
		procedure smRemanejarPedidoClick(Sender: TObject);
		procedure SMIniciarPedidoClick(Sender: TObject);
		procedure exibirPainel(Sender: TObject);
		procedure mitListagemDeProdutosClick(Sender: TObject);
		procedure mitPedidosAbertosClick(Sender: TObject);
		procedure filtrarProdutos();
		procedure lcbProdutoGrupoClick(Sender: TObject);
		procedure btnCancelarFiltrosClick(Sender: TObject);
		procedure qryPedidoMovimentacaoBeforeInsert(DataSet: TDataSet);
		procedure dbgListagemDeProdutosCellClick(Column: TColumn);
		procedure dbgListagemDeProdutosKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
		procedure FormActivate(Sender: TObject);
		procedure dbgPedidoMovimentacaoDragDrop(Sender, Source: TObject; X,	Y: Integer);
		procedure dbgPedidoMovimentacaoDragOver(Sender, Source: TObject; X,	Y: Integer; State: TDragState; var Accept: Boolean);
	 procedure mitZerarPontuacaoClick(Sender: TObject);
	 procedure mitLancarClick(Sender: TObject);
	 procedure mitInserirItemClick(Sender: TObject);
    procedure btnBuscarClienteClick(Sender: TObject);
    procedure dbgListagemDeProdutosDblClick(Sender: TObject);
    procedure dbgListagemDeProdutosMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
//-----------------------------------------------------------------------------------------------
	private
		{ Private declarations }
		reTotalizacao				: TRichEdit;
		TRAVADIGI : bool;
		MOSTRAJANELAOBSERVACOES : bool;
		MOSTRAGRADEPEDIABERTOS : bool;
		GUARDADADOSTEMPPEDI    : bool;
		MOSTRALISTAGEMDEPRODUTOS : bool;
		MOSTRADESCRICAO : bool;
		USATOTALIZAR : bool;
		IMPRIMEVLITEM : bool;
		MOSTRAVALORESNOIMPRIMIR : bool;
		IMPRIMEESPECIAL : bool;
		CADASTRACLIENTEAUTO : bool;
		RESUMIRCABECALHONOIMPRIMIR : bool;
		MOSTRARODAPENOIMPRIMIR : bool;
		VISUALIZARPEDIDO : bool;
		CONFIMPPEDI : bool;
		CAMPOCODIGOCLIENTE : String;
		NOMEEMPRESA : String;
		ACESSOUSUARIO01 : String;
		ACESSOSENHA01 : String;
		NUMINICIALCUPOM : String;
		HORAVIRADA : String;
		RELLINHA1 : String;
		RELLINHA2 : String;
		RELLINHA3 : String;
		TAXASERVICO : Real;
		MSGREL : String;
		NULINHASBRANCO : String;

		procedure atualizarGradeMovimentacao(p_idCliente: Integer);
	protected
		{ Protected declarations }
		//-- Variavel utilizada para preparar a janela de pedidos ao carregar os dados de um cliente vindo da janela de clientes
		clienteVemDaJanelaDeClientes : Bool;
		//-- INI - Atributos do cliente selecionado
		CodigoDigitado: string;
		idClienteGrupo: Integer;
		//-- FIM - Atributos do cliente selecionado

		FunDB: TFunDB;
		FunGeral: TFunGeral;
//-----------------------------------------------------------------------------------------------
	public
		{ Public declarations }
		//-- Mostra valor atual da variavel
		function mostrarClienteVemDaJanelaDeClientes: Bool;
		//-- Altera valor da variavel
		procedure alterarClienteVemDaJanelaDeClientes(pvalor : Bool);
		//-- Capturar próx Nº de pedido para mostrar na tela
		procedure capturarProxNPed();
		//-- Verifica se o numero de telefone contém entre 6 e 8 caracteres
		function verificarFormatoTelefone(p_Telefone:string):boolean;
		//-- Atualiza grade de pedidos em aberto
		procedure atualizarGradePedidosAbertos();
		//-- Retorna o Codigo (Telefone/Comanda/Mesa) digitado
		function retornarCodigoDigitado: string;
		function retornarCliente():Integer;
		function retornarContadorDePedidoMovimentacao():Integer;
		procedure processarCliente();
		procedure carregarCampoIngredientes();
		function incluirItemPedido(pQtPedaco, p_ContadorCliente: Integer; pPedaco1, pPedaco2, pPedaco3, pPedaco4, p_ObsPedaco1, p_ObsPedaco2, p_ObsPedaco3, p_ObsPedaco4: String): Integer;
		procedure alterarCampoTelefone(p_Telefone: String);
		function retornarMostraGradePediAbertos: bool;
		procedure inserirItemPedido(codigo: String);
		procedure alterarPedidoMovimentacaoEstagio(p_novoEstagio, p_IdCliente, p_IdItem: Integer; p_Obs: String);
  end;
//-----------------------------------------------------------------------------------------------
var frmPedido: TfrmPedido;
//-----------------------------------------------------------------------------------------------
implementation {$R *.DFM}
//-----------------------------------------------------------------------------------------------
uses UTabTele, UInicial, UFuncoes, ULicenca;
//-----------------------------------------------------------------------------------------------
//-- Mostra valor atual da variavel
function TfrmPedido.mostrarClienteVemDaJanelaDeClientes: Bool;
begin
  Result := clienteVemDaJanelaDeClientes;
end;
//-----------------------------------------------------------------------------------------------
//-- Altera valor da variavel
procedure TfrmPedido.alterarClienteVemDaJanelaDeClientes(pvalor : Bool);
begin
  clienteVemDaJanelaDeClientes := pValor
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.inicializarPedidos();
begin
	try
		//-- Limpar campos do cliente
		edtCodigo.Clear();
		edtContador.Clear();
		edtNome.Clear();
		edtLogradouro.Clear();
		edtNumero.Clear();
		edtComplemento.Clear();
		edtDataUltimoPedido.Clear();
		edtBairro.Clear();
		edtCidade.Clear();
		edtReferencia.Clear();
		edtObs1.Clear();
		edtObs2.Clear();

		//-- Abre grade de movimentação com itens do cliente TEMPORARIO '-1'
		atualizarGradeMovimentacao(-1);

		//-- Reinicia o pedido
		lcbProdutoGrupo.KeyValue := -1; //-- Retorna grupo de produtos para posicao inicial
		if not (GUARDADADOSTEMPPEDI) then executarQuery(qryTemporaria,'Delete From PedidoMovimentacao');
		atualizarGrades();
		atualizarGradePedidosAbertos();
		capturarProxNPed();
		edtCodigo.SetFocus;
	except
		MessageDlg('Erro na rotina de inicialização de pedido!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.FormShow(Sender: TObject);
begin
	try
		labCodigo.Caption := '&'+CAMPOCODIGOCLIENTE;
		Width := FInicial.ClientWidth-4;
		Height := FInicial.ClientHeight-24; //-- 20 do statusbar
		//-- Prepara para impressao da totalizacao
		reTotalizacao := TRichEdit.Create(Self);
		reTotalizacao.Visible    := false;
		reTotalizacao.Width      := 345;
		reTotalizacao.ScrollBars := ssVertical;
		reTotalizacao.Parent     := Self;

		if (MOSTRAGRADEPEDIABERTOS) then begin
			mitPedidosAbertos.Click(); //-- O estado inicial é false, portanto vai pra true
			atualizarGradePedidosAbertos();
		end;
		if (MOSTRALISTAGEMDEPRODUTOS) then begin
			mitListagemDeProdutos.Click(); //-- O estado inicial é false, portanto vai pra true
		end;
		if (MOSTRADESCRICAO) then begin
			mitDescricao.Click(); //-- O estado inicial é false, portanto vai pra true
		end;
		if not (USATOTALIZAR) then begin
			btTotalizar.Visible := false;
			sm1TotalizarPedido.Enabled := false;
		end;
		inicializarPedidos();
	except
		MessageDlg('Erro ao abrir a janela de pedidos! [202]', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.TelefoneKeyPress(Sender: TObject; var Key: Char);
begin
	try
		if not (key in['0'..'9',#8,#13]) then key:=#0;
		if Key = #13 then begin
			ECodigo.SetFocus;
			processarCliente();
		end;
	except
		MessageDlg('Erro na alternação de campo!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.edtCodigoEnter(Sender: TObject);
begin
	if (lcbProdutoGrupo.KeyValue = -1) then btnCancelarFiltros.Click();
	if (edtCodigo.Text = '') then edtCodigo.Text := '';
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.MostraCampos;
begin
	try
		sbCamposClientes.Visible := True;
	except
		MessageDlg('Erro na rotina de apresentação dos campos de consulta!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.OcultaCampos;
begin
	try
		sbCamposClientes.Visible := False;
	except
		MessageDlg('Erro na rotina de ocultamento dos campos de consulta!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.FormCreate(Sender: TObject);
begin
	//-- Grupo de cliente padrão
	idClienteGrupo := 1;

	try

		//-- Carrega variaveis do banco de dados
		TRAVADIGI := FTabTele.retornarVariavelBool('TRAVADIGI','0');
		MOSTRAJANELAOBSERVACOES := FTabTele.retornarVariavelBool('MOSTRAJANELAOBSERVACOES','0');
		GUARDADADOSTEMPPEDI := FTabTele.retornarVariavelBool('GUARDADADOSTEMPPEDI','1');
		MOSTRAGRADEPEDIABERTOS := FTabTele.retornarVariavelBool('MOSTRAGRADEPEDIABERTOS','1');
		MOSTRALISTAGEMDEPRODUTOS := FTabTele.retornarVariavelBool('MOSTRALISTAGEMDEPRODUTOS','1');
		MOSTRADESCRICAO := FTabTele.retornarVariavelBool('MOSTRADESCRICAO','1');
		USATOTALIZAR := FTabTele.retornarVariavelBool('USATOTALIZAR','1');
		IMPRIMEVLITEM := FTabTele.retornarVariavelBool('IMPRIMEVLITEM','0');
		MOSTRAVALORESNOIMPRIMIR := FTabTele.retornarVariavelBool('MOSTRAVALORESNOIMPRIMIR','1');
		IMPRIMEESPECIAL := FTabTele.retornarVariavelBool('IMPRIMEESPECIAL','0');
		CADASTRACLIENTEAUTO := FTabTele.retornarVariavelBool('CADASTRACLIENTEAUTO','0');
		RESUMIRCABECALHONOIMPRIMIR := FTabTele.retornarVariavelBool('RESUMIRCABECALHONOIMPRIMIR','0');
		MOSTRARODAPENOIMPRIMIR := FTabTele.retornarVariavelBool('MOSTRARODAPENOIMPRIMIR','1');
		VISUALIZARPEDIDO := FTabTele.retornarVariavelBool('VISUALIZARPEDIDO','1');
		CONFIMPPEDI := FTabTele.retornarVariavelBool('CONFIMPPEDI','1');
		CAMPOCODIGOCLIENTE := FTabTele.retornarVariavel('CAMPOCODIGOCLIENTE','Fone');
		NOMEEMPRESA := FTabTele.retornarVariavel('NomeEmpresa','EMPRESA');
		NUMINICIALCUPOM := FTabTele.retornarVariavel('NumInicialCupom','1');
		HORAVIRADA := FTabTele.retornarVariavel('HoraVirada','04:00');
		RELLINHA1 := FTabTele.retornarVariavel('RelLinha1','RelLinha1');
		RELLINHA2 := FTabTele.retornarVariavel('RelLinha2','RelLinha2');
		RELLINHA3 := FTabTele.retornarVariavel('RelLinha3','RelLinha3');
		TAXASERVICO := FTabTele.retornarVariavelFloat('TaxaServico',0);
		MSGREL := FTabTele.retornarVariavel('MsgRel','Agradecemos a preferência!');
		NULINHASBRANCO := FTabTele.retornarVariavel('NuLinhasBranco','10');
		ACESSOUSUARIO01 := FTabTele.retornarVariavel('ACESSOUSUARIO01','Gerente');
		ACESSOSENHA01 := FTabTele.retornarSenhaDecriptografada(FTabTele.retornarVariavel('ACESSOSENHA01',FTabTele.retornarVarSenhaCriptPadrao()));


		Caption := Application.Title+' - '+NOMEEMPRESA+' - Controle de Pedido';
	except
		MessageDlg('Erro ao criar janela de pedidos!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.edtProcuraNomeKeyPress(Sender: TObject; var Key: Char);
begin
	try
		if Key = #13 then ECodigo.SetFocus
	except
		MessageDlg('Erro ao focar próximo campo!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//-- Se FFinPedi estiver ativo não deixa fechar
	if not MessageDlg('Há um pedido pendente, já totalizado. Deseja cancelar e sair?', mtWarning, [mbYes, mbNo], 0) = mrYes then Abort();
	FunDB.CommitDireto(FTabTele.DBCommerce);
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.BtUltPedidoClick(Sender: TObject);
var sql : string;
begin
	sql := 'SELECT IdCliente FROM Pedido WHERE IdCliente = '+IntToStr(retornarCliente());
	if verificarExistenciaDeRegistro(qryTemporaria,sql) then begin
		FrmPedidoUltimo.alterarIdCliente(retornarCliente());
		FrmPedidoUltimo.ShowModal;
		atualizarGradePedidosAbertos();
		atualizarGrades();
	end else begin
		MessageDlg('Cliente não possui pedidos gravados!', mtInformation, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.BtFinalizarPedidoClick(Sender: TObject);
begin
	try
		if (Length(edtCodigo.Text) = 0) then begin
			MessageDlg('Selecione um Cliente!', mtInformation, [mbOk], 0);
			Exit;
		end;

		if qryPedidoMovimentacao.RecordCount > 0 then begin
			FrmPedidoFinalizacao.ShowModal;
			capturarProxNPed();
			if not (frmLicenca.retornarRegistro(false)) then frmLicenca.mostrarMsgPedidoDeRegistro();
		end else begin
			MessageDlg('É necessário escolher algum produto para compor o pedido!', mtInformation, [mbOk], 0);
			MostraCampos;
			Exit;
		end;
	except
		MessageDlg('Erro ao finalizar pedido!', mtInformation, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.eCodigoEnter(Sender: TObject);
begin
	if (ECodigo.Text = 'Código') then
		ECodigo.Text := '';
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.eCodigoExit(Sender: TObject);
begin
	if (ECodigo.Text = '') then
		ECodigo.Text := 'Código';
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.eCodigoKeyPress(Sender: TObject; var Key: Char);
begin
	if Key = #13 then begin
		if (eCodigo.Text <> '') then begin
			inserirItemPedido(eCodigo.Text);
			eCodigo.Text := '';
		end;
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.SMCampoCodigoClick(Sender: TObject);
begin
  ECodigo.SetFocus;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.mitSelecionarPedidoMovimentacaoClick(Sender: TObject);
begin
	dbgPedidoMovimentacao.SetFocus;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.dbgListagemDeProdutosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var inputStr: String;
begin
	try
		if (qryPedidoMovimentacao.FieldByName('IdEstagio').AsInteger = 13) then
		begin
			MessageDlg('O item não pode ser excluído!', mtInformation, [mbOk], 0);
		end
		else
		begin
			if (key = 46) then
			begin //-- Delete?
				if MessageDlg('Deseja cancelar o item selecionado?', mtWarning, [mbYes, mbNo], 0) = mrYes then
				begin

                                        if (mostrarJaneladeAcesso(
                                        'Item de pedido',
                                        ACESSOUSUARIO01,
                                        ACESSOSENHA01
                                        )) then begin
//					inputStr := '';
//					if (InputQuery('Motivo do cancelamento do item', 'Motivo', inputStr)) then
//					begin
//						if (Length(inputStr) >= 4) then begin
//							alterarPedidoMovimentacaoEstagio(-1,FrmPedido.retornarCliente(),qryPedidoMovimentacao.FieldByName('Contador').AsInteger,inputStr); //-1=Cancelado

							// Registrar evento ao deletar item
							//FunDB.iniciarQuery(qryTemporaria);
							//qryTemporaria.SQL.Add(
							//	'SELECT '+
							//	'  R_RETORNO '+
							//	'FROM '+
							//	'  INSERIR_EVENTOOPERADOR(:CDTIPOEVENTOOP,:OBS) '
							//);
							//qryTemporaria.ParamByName('CDTIPOEVENTOOP').AsInteger := 5; // Item de pedido excluido
							//qryTemporaria.ParamByName('OBS').AsString :=
							//	'Produto:'+qryPedidoMovimentacao.FieldByName('Nome').AsString+'; '+
							//	'Motivo:'+inputStr;
							//qryTemporaria.Open();


							FTabTele.iaePedidoMovimentacao.Query[ukDelete].ParamByName('OLD_CONTADOR').AsInteger := qryPedidoMovimentacao.FieldByName('Contador').AsInteger;
							FTabTele.iaePedidoMovimentacao.Query[ukDelete].ExecSQL();
							FunDB.CommitDireto(FTabTele.DBCommerce);
							FunDB.atualizarQuery(qryPedidoMovimentacao);
							if (mostraGradePediAbertos) then atualizarGradePedidosAbertos();
							atualizarGrades();
							abort; //-- Aborta o delete do grid
						//end else begin
						//	MessageDlg('É necessário detalhar melhor os motivos.', mtInformation, [mbOk], 0);
						//end;
				  end;
				end;
			end;
		end;
	except
		abort;
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.SMGrupoClick(Sender: TObject);
begin
  lcbProdutoGrupo.SetFocus;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.SMAlterarDadosClick(Sender: TObject);
begin
	if (edtCodigo.Text <> '') then begin
		alterarClienteVemDaJanelaDeClientes(true);
		Finicial.abrirJanelaDeCliente(edtCodigo.Text,false,0);
	end else begin
		MessageDlg('É necessario selecionar um cliente para alterar seus dados', mtInformation, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.dbgPedidoMovimentacaoDblClick(Sender: TObject);
begin
	smCadastrarObservacaoClick(nil);
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.smCadastrarObservacaoClick(Sender: TObject);
begin
	if qryPedidoMovimentacao.RecordCount > 0 then begin
		FrmObservacao.ShowModal();
		atualizarGrades();
	end else begin
		MessageDlg('Não há itens de pedido para este cliente!', mtInformation, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
//-- Capturar próx Nº de pedido para mostrar na tela
procedure TfrmPedido.capturarProxNPed();
var dataBancoDeDados	: TDateTime;
begin
	//-- Buscar data do banco de dados
	abrirQuery(qryTemporaria,'SELECT CURRENT_TIMESTAMP AS DATABANCO FROM RDB$DATABASE');
	dataBancoDeDados := qryTemporaria.FieldByName('DATABANCO').AsDateTime;

	//-- Capturar novo numero do pedido
	abrirQuery(qryTemporaria,'SELECT NUMEROPEDIDO FROM Pedido WHERE CONTADOR = '+IntToStr(FTabTele.buscarMaxContadorDBTele('Pedido')-1));
	labProxPedido.Caption := 'NºPed.: '+criarNrPedidoComVirada(dataBancoDeDados,qryTemporaria.FieldByName('NUMEROPEDIDO').AsString,NUMINICIALCUPOM,HORAVIRADA);
end;
//-----------------------------------------------------------------------------------------------
//-- Verifica se o numero de telefone contém entre 6 e 8 caracteres
function TfrmPedido.verificarFormatoTelefone(p_Telefone:string):boolean;
var min: byte;
	 max: byte;
begin
  min := 6;
  max := 8;
  if (TRAVADIGI) then begin
	 if (Length(p_Telefone) >= min) and (Length(p_Telefone) <= max) then begin
		Result := True;
	 end else begin
		MessageDlg('Deve ser digitado entre '+IntToStr(min)+' e '+IntToStr(max)+' caracteres!', mtInformation, [mbOk], 0);
		Result := False;
	 end;
  end else begin
    Result := True;
  end;
end;
//-----------------------------------------------------------------------------------------------
//-- Atualiza grades de produtos e pedidos
procedure TfrmPedido.atualizarGrades();
begin
	if (mostraGradePediAbertos) then begin
		FunDB.atualizarQuery(qryPedidoMovimentacao);
		if (retornarCliente() <> -1) then
			labTotalPedido.Caption := 'Total: '+FloatToStrF(FTabTele.retornarValorTotalDoPedido(StrToInt(edtContador.Text)),ffCurrency,10,2)
		else
			labTotalPedido.Caption := 'Total: '+FloatToStrF(0,ffCurrency,10,2);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.btTotalizarClick(Sender: TObject);
var	temp		: Integer;
		vlTotal	: Real;
		vlTxServ	: Real;
		inputStr : String;
		valorDiv : String;
		strTxServ: String;
		tempRelLinha1: String;
		tempRelLinha2: String;
		tempRelLinha3: String;
		ImpressaoPedi	: ImpPedi;
		dataBancoDeDados	: TDateTime;
begin
	tempRelLinha1 := '';
	tempRelLinha2 := '';
	tempRelLinha3 := '';
	if (USATOTALIZAR) then begin
		if (qryPedidoMovimentacao.RecordCount > 0) then begin

			// Altera estagio para impedir deleção futura de itens
			alterarPedidoMovimentacaoEstagio(13,FrmPedido.retornarCliente(),-1,''); //13=Pedido Totalizado

			//-- Buscar data do banco de dados
			abrirQuery(qryTemporaria,'SELECT CURRENT_TIMESTAMP AS DATABANCO FROM RDB$DATABASE');
			dataBancoDeDados := qryTemporaria.FieldByName('DATABANCO').AsDateTime;

			ImpressaoPedi := ImpPedi.criarInstancia;
			ImpressaoPedi.setarRePrev(@reTotalizacao);

			//-- Inicio do Rel de 40 colunas
			ImpressaoPedi.setarRichPadrao();
			ImpressaoPedi.setarRichPara40Colunas();
			ImpressaoPedi.limparTexto();
			tempRelLinha1 := RELLINHA1;
			if not (RESUMIRCABECALHONOIMPRIMIR) then begin
				tempRelLinha2 := RELLINHA2;
				tempRelLinha3 := RELLINHA3;
			end;
			ImpressaoPedi.imprimirCabecalho(tempRelLinha1,tempRelLinha2,tempRelLinha3,false);
			ImpressaoPedi.imprimirDataHoraNPedido(DateToStr(dataBancoDeDados),TimeToStr(dataBancoDeDados),'');
			if (FunDB.verificarExistenciaDeRegistro(qryTemporaria,'SELECT Fone1, Nome, Logradouro, Numero, Complemento, Bairro, Cidade, Referencia'+
			'	FROM Cliente Where Contador = '+IntToStr(FrmPedido.retornarCliente()))) then begin
				impressaoPedi.escreverDadosCliente40Colunas (
					CAMPOCODIGOCLIENTE,
					qryTemporaria.FieldByName('Fone1').AsString,
					qryTemporaria.FieldByName('Nome').AsString,
					qryTemporaria.FieldByName('Logradouro').AsString,
					qryTemporaria.FieldByName('Numero').AsString,
					qryTemporaria.FieldByName('Bairro').AsString,
					qryTemporaria.FieldByName('Complemento').AsString,
					qryTemporaria.FieldByName('Referencia').AsString
				);
			end else begin
				Exit;
			end;
			ImpressaoPedi.escreverRotuloDeItens40Colunas(IMPRIMEVLITEM);
			vlTotal := 0;
			qryPedidoMovimentacao.First();
			while not qryPedidoMovimentacao.Eof do begin
				//-- Case dos pedaços
				if (qryPedidoMovimentacao.FieldByName('QtPedaco').AsInteger = 1) then begin
					abrirQuery(qryTemporaria,'Select Nome, Codigo from Produto Where Contador = '+qryPedidoMovimentacao.FieldByName('IdPedaco1').AsString);
					ImpressaoPedi.imprimirItemPedido(
						qryPedidoMovimentacao.FieldByName('Quantidade').AsString,
						qryTemporaria.FieldByName('Nome').AsString,
						qryTemporaria.FieldByName('Codigo').AsString,
//						qryPedidoMovimentacao.FieldByName('VlPedaco1').AsFloat,
//						qryPedidoMovimentacao.FieldByName('VlPedaco1').AsFloat*qryPedidoMovimentacao.FieldByName('Quantidade').AsFloat,
						//-- Usa valorunitario que terá maior ou valor médio de acordo com a configuração
						qryPedidoMovimentacao.FieldByName('ValorUnitario').AsFloat,
						qryPedidoMovimentacao.FieldByName('ValorUnitario').AsFloat*qryPedidoMovimentacao.FieldByName('Quantidade').AsFloat,
						IMPRIMEVLITEM
					);
//					vlTotal := vlTotal+qryPedidoMovimentacao.FieldByName('VlPedaco1').AsFloat*qryPedidoMovimentacao.FieldByName('Quantidade').AsFloat;
					vlTotal := vlTotal+qryPedidoMovimentacao.FieldByName('ValorUnitario').AsFloat*qryPedidoMovimentacao.FieldByName('Quantidade').AsFloat;
				end else begin
					for temp:=1 to qryPedidoMovimentacao.FieldByName('QtPedaco').AsInteger do begin
						abrirQuery(qryTemporaria,'Select Nome, Codigo from Produto Where Contador = '+qryPedidoMovimentacao.FieldByName('IdPedaco'+IntToStr(temp)).AsString);
						ImpressaoPedi.imprimirItemPedido(
							qryPedidoMovimentacao.FieldByName('Quantidade').AsString+'/'+qryPedidoMovimentacao.FieldByName('QtPedaco').AsString,
							qryTemporaria.FieldByName('Nome').AsString,
							qryTemporaria.FieldByName('Codigo').AsString,
//							qryPedidoMovimentacao.FieldByName('VlPedaco'+IntToStr(temp)).AsFloat,
//							qryPedidoMovimentacao.FieldByName('VlPedaco'+IntToStr(temp)).AsFloat*qryPedidoMovimentacao.FieldByName('Quantidade').AsFloat/qryPedidoMovimentacao.FieldByName('QtPedaco').AsInteger,
							//-- Usa valorunitario que terá maior ou valor médio de acordo com a configuração
							qryPedidoMovimentacao.FieldByName('ValorUnitario').AsFloat,
							qryPedidoMovimentacao.FieldByName('ValorUnitario').AsFloat*qryPedidoMovimentacao.FieldByName('Quantidade').AsFloat/qryPedidoMovimentacao.FieldByName('QtPedaco').AsInteger,
							IMPRIMEVLITEM
						);
//						vlTotal := vlTotal+qryPedidoMovimentacao.FieldByName('VlPedaco'+IntToStr(temp)).AsFloat*qryPedidoMovimentacao.FieldByName('Quantidade').AsFloat/qryPedidoMovimentacao.FieldByName('QtPedaco').AsInteger;
						vlTotal := vlTotal+qryPedidoMovimentacao.FieldByName('ValorUnitario').AsFloat*qryPedidoMovimentacao.FieldByName('Quantidade').AsFloat/qryPedidoMovimentacao.FieldByName('QtPedaco').AsInteger;
					end;
				end;
				qryPedidoMovimentacao.Next();
				if not(qryPedidoMovimentacao.Eof) then ImpressaoPedi.imprimirSeparador40Item();
			end;

			if (MOSTRAVALORESNOIMPRIMIR) then begin
				ImpressaoPedi.imprimirSeparador40Secundario();
				vlTxServ := TAXASERVICO;
				strTxServ := EscreveD(FloatToStr(vlTxServ),4);
				if (vlTxServ <> 0) then begin
					ImpressaoPedi.escreverLinha40ColE('Sub-Total . . . . . . . .: R$ '+EscreveN(vlTotal,10,2));
					ImpressaoPedi.escreverLinha40ColE('Acrescimo de '+strTxServ+'%. . . .: R$ '+EscreveN((vlTotal/vlTxServ),10,2));
					ImpressaoPedi.escreverLinha40ColE('Total . . . . . . . . . .: R$ '+EscreveN(vlTotal+(vlTotal/vlTxServ),10,2));
				end else begin
					ImpressaoPedi.escreverLinha40ColE('Total . . . . . . . . . .: R$ '+EscreveN(vlTotal,10,2));
				end;
			end;

			if (MOSTRAVALORESNOIMPRIMIR) then begin
				inputStr := '1';
				if (InputQuery('Dividir a conta', 'Quantidade de partes', inputStr)) then begin
					if (StrToInt(inputStr) > 1) then begin
						//-- Previne divisão por zero
						if (vlTxServ > 0) then begin
							valorDiv := FunGeral.retornarStringMonetaria((vlTotal+(vlTotal/vlTxServ))/StrToInt(inputStr));
						end else begin
							valorDiv := FunGeral.retornarStringMonetaria(vlTotal/StrToInt(inputStr));
						end;
						ImpressaoPedi.imprimirSeparador40Secundario();
						ImpressaoPedi.escreverLinha40ColE('Valor Dividido ('+inputStr+'). . . .: R$ '+EscreveN(StrToFloat(valorDiv),10,2));
					end;
				end;
			end;

			if (MOSTRARODAPENOIMPRIMIR) then begin
				ImpressaoPedi.escreverRodape40Colunas(MSGREL);
			end;
			ImpressaoPedi.imprimirLinhaEmBrancoEspecial(StrToInt(NULINHASBRANCO),IMPRIMEESPECIAL);
			ImpressaoPedi.configurarFonte();
			if (IMPRIMEESPECIAL) then ImpressaoPedi.transformarSelecoesEmNegrito();
			ImpressaoPedi.irParaInicio();
			if (VISUALIZARPEDIDO) then impressaoPedi.mostrarPrevisao();
			ImpressaoPedi.enviarParaImpressora(CONFIMPPEDI,IMPRIMEESPECIAL,StrToInt(NULINHASBRANCO));

			ImpressaoPedi.destruirInstancia();
		end else begin
			MessageDlg('Não há itens de pedido para este cliente!', mtError, [mbOk], 0);
		end;
	end else begin
		ImpressaoPedi.destruirInstancia();
		MessageDlg('Esta função foi desabilitada pelo administrador!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.sgPedidosAbertosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  edtCodigo.Text := sgPedidosAbertos.Cells[ACol,ARow];
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.sgPedidosAbertosDblClick(Sender: TObject);
begin
  processarCliente();
  eCodigo.SetFocus();
end;
//-----------------------------------------------------------------------------------------------
//-- Atualiza grade de pedidos em aberto
procedure TfrmPedido.atualizarGradePedidosAbertos();
var x : byte;
    y : byte;
    i : byte;
    j : byte;
    temp : String;
    troc : bool;
begin
  //-- Limpar campos
  for x := 0 to sgPedidosAbertos.RowCount-1 do begin
    for y := 0 to sgPedidosAbertos.ColCount-1 do sgPedidosAbertos.Cells[y,x] := '';
  end;
  x := 0;
  y := 0;
  abrirQuery(qryTemporaria,'Select Distinct Cliente.Fone1 from PedidoMovimentacao,Cliente Where PedidoMovimentacao.IdCliente = Cliente.Contador');
  while not qryTemporaria.Eof do begin
    sgPedidosAbertos.Cells[y,x] := qryTemporaria.FieldByName('Fone1').AsString;
    Inc(y);
	 if (y >= sgPedidosAbertos.ColCount) then begin
      y := 0;
      if (x < sgPedidosAbertos.RowCount) then Inc(x);
	 end;
	 qryTemporaria.Next();
  end;
  //-- Ordenar
  for x := sgPedidosAbertos.RowCount-1 downto 0 do begin
	 for y := sgPedidosAbertos.ColCount-1 downto 0 do begin
		troc := true; //-- So para entrar no laco
		while troc do begin
        troc := false;
		  for i := 0 to sgPedidosAbertos.RowCount-1 do begin
			 for j := 0 to sgPedidosAbertos.ColCount-1 do begin
            if (sgPedidosAbertos.Cells[y,x] <> '') and (sgPedidosAbertos.Cells[j,i] > sgPedidosAbertos.Cells[y,x]) and (x*(sgPedidosAbertos.ColCount)+y > i*(sgPedidosAbertos.ColCount)+j) then begin
              temp := sgPedidosAbertos.Cells[j,i];
				  sgPedidosAbertos.Cells[j,i] := sgPedidosAbertos.Cells[y,x];
              sgPedidosAbertos.Cells[y,x] := temp;
              troc := true;//-- Trocou
            end;
			 end;
        end;
		end;
    end;
  end;
end;
//-----------------------------------------------------------------------------------------------
//-- Retorna o Codigo (Telefone/Comanda/Mesa) digitado
function TfrmPedido.retornarCodigoDigitado: string;
begin
  result := CodigoDigitado;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.smRemanejarPedidoClick(Sender: TObject);
var InputString : String;
	 cdCliente : integer;
begin
	if (Length(edtCodigo.Text) = 0) then begin
		MessageDlg('Selecione um Cliente', mtInformation, [mbOk], 0);
	end else begin
	 if (verificarExistenciaDeRegistro(qryTemporaria,'SELECT Contador FROM cliente Where Fone1 = '+FunGeral.retornarStringSQL(edtCodigo.Text))) then begin
		cdCliente   := qryTemporaria.FieldByName('Contador').AsInteger;
		InputString := FunGeral.retornarStringSQL(CAMPOCODIGOCLIENTE);
		if (InputQuery('Remanejar pedido', InputString, InputString)) then begin
			FunDB.iniciarQuery(qryTemporaria);
			qryTemporaria.SQL.Add('SELECT Contador FROM cliente Where Fone1 = :fone OR Fone2 = :fone OR Fone3 = :fone');
			qryTemporaria.ParamByName('fone').AsString := InputString;
			qryTemporaria.Open();
			if (qryTemporaria.Eof <> qryTemporaria.Bof) then begin
				executarQuery(
					qryTemporaria,
					'UPDATE PedidoMovimentacao SET idcliente = '+qryTemporaria.FieldByName('Contador').AsString+' WHERE idCliente = '+IntToStr(cdCliente)
				);
				MessageDlg('O pedido foi remanejado com sucesso!', mtInformation, [mbOk], 0);
				inicializarPedidos();
			end else begin
				MessageDlg('Cliente não foi encontrado!', mtInformation, [mbOk], 0);
			end;
		end;
	 end else begin
		MessageDlg('Operação cancelada!', mtInformation, [mbOk], 0);
	 end;
  end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.SMIniciarPedidoClick(Sender: TObject);
begin
	inicializarPedidos();
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.exibirPainel(Sender: TObject);
var	tmp: String;
begin
	mitDescricao.Checked := not mitDescricao.Checked;
	panDescricao.Visible := mitDescricao.Checked;
	if (mitDescricao.Checked) then tmp := '1' else tmp := '0';
	FTabTele.alterarVariavel('mostraDescricao',tmp);
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.mitListagemDeProdutosClick(Sender: TObject);
begin
	mitListagemDeProdutos.Checked := not mitListagemDeProdutos.Checked;
	panListagemDeProdutos.Visible := mitListagemDeProdutos.Checked;
	if (mitListagemDeProdutos.Checked) then begin
		if not(qryProdutoGrupo.Active) then qryProdutoGrupo.Open() else qryProdutoGrupo.Close();
		filtrarProdutos();
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.mitPedidosAbertosClick(Sender: TObject);
var tmp: String;
begin
	mitPedidosAbertos.Checked := not mitPedidosAbertos.Checked;
	panPedidosAbertos.Visible := mitPedidosAbertos.Checked;
	if (mitPedidosAbertos.Checked) then tmp := '1' else tmp := '0';
	FTabTele.alterarVariavel('mostraGradePediAbertos',tmp);
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.filtrarProdutos();
begin
	FunDB.iniciarQuery(qryProduto);
	qryProduto.SQL.Add(
		'SELECT '+
		'	PRODUTO.NOME, '+
		'	PRODUTO.CODIGO, '+
		'	CAST(PRODUTO.VALOR AS NUMERIC(8,2)) AS VALOR, '+
		'	CLIENTEGRUPO.NOME AS NOMECLIENTEGRUPO, '+
		'	PRODUTOGRUPO.NOME AS NOMEPRODUTOGRUPO, '+
		'	PRODUTO.INGREDIENTES, '+
		'	PRODUTO.IDPRODUTOGRUPO, '+
		'	PRODUTO.CONTADOR '+
		'FROM '+
		'	PRODUTO '+
		'LEFT JOIN CLIENTEGRUPO ON PRODUTO.IDCLIENTEGRUPO = CLIENTEGRUPO.CONTADOR '+
		'LEFT JOIN PRODUTOGRUPO ON PRODUTO.IDPRODUTOGRUPO = PRODUTOGRUPO.CONTADOR '+
		'WHERE '+
		'  IDCLIENTEGRUPO = :CLIENTEGRUPO '
	);
	if (lcbProdutoGrupo.KeyValue <> '-1')AND(lcbProdutoGrupo.KeyValue <> NULL) then begin
		qryProduto.SQL.Add('AND	PRODUTO.IDPRODUTOGRUPO = :PRODUTOGRUPO');
		qryProduto.ParamByName('PRODUTOGRUPO').AsString := String(lcbProdutoGrupo.KeyValue);
	end;
	qryProduto.SQL.Add('	ORDER BY PRODUTO.CODIGO');
	qryProduto.ParamByName('CLIENTEGRUPO').AsInteger := idClienteGrupo;
	qryProduto.Open();
	atualizarGrades();
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.lcbProdutoGrupoClick(Sender: TObject);
begin
	filtrarProdutos();//-- O padrão é 1
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.btnCancelarFiltrosClick(Sender: TObject);
begin
	lcbProdutoGrupo.KeyValue := '-1';
	filtrarProdutos();//-- O padrão é 1
end;
//-----------------------------------------------------------------------------------------------
function TfrmPedido.retornarCliente():Integer;
begin
	if (edtContador.Text = '') then result := -1 else result := StrToInt(edtContador.Text);
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.qryPedidoMovimentacaoBeforeInsert(DataSet: TDataSet);
begin
	if (dbgPedidoMovimentacao.Focused) then Abort();
end;
//-----------------------------------------------------------------------------------------------
function TfrmPedido.retornarContadorDePedidoMovimentacao():Integer;
begin
	result := qryPedidoMovimentacao.FieldByName('Contador').AsInteger;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.dbgListagemDeProdutosCellClick(Column: TColumn);
var
	gridcoord : TGridCoord;
begin
	carregarCampoIngredientes();
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.dbgListagemDeProdutosKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
	carregarCampoIngredientes();
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.processarCliente();
begin
	try
		CodigoDigitado := edtCodigo.Text;
		if (CodigoDigitado <> '') then begin
			if not (verificarFormatoTelefone(CodigoDigitado)) then begin
				edtCodigo.SetFocus;
				Exit;
			end;
		end else begin
			edtCodigo.SetFocus();
			Exit;
		end;
		// Procura por Telefone
		if (verificarExistenciaDeRegistro(
			qryTemporaria,
			'SELECT Contador, Fone1, Nome, Logradouro, Numero, Complemento, Bairro, Cidade, Referencia, DataUltimoPedido, Obs1, Obs2, IDCLIENTEGRUPO'+
				'	FROM Cliente Where '+
				'	Fone1 = '+FunGeral.retornarStringSQL(CodigoDigitado)+' OR '+
				'	Fone2 = '+FunGeral.retornarStringSQL(CodigoDigitado)+' OR '+
				'	Fone3 = '+FunGeral.retornarStringSQL(CodigoDigitado)+' '
		)) then begin
			//-- Carregando atributos do cliente
			CodigoDigitado := qryTemporaria.FieldByName('Fone1').AsString;
			idClienteGrupo := qryTemporaria.FieldByName('IDCLIENTEGRUPO').AsInteger;

			FunDB.atualizarCampos(TWinControl(sbCamposClientes),c_Carrega,ukInsert,qryTemporaria);//-- Enviando ukInsert apenas para evitar erro

			//-- Remaneja produtos do cliente TEMPORARIO
			if (FunDB.verificarExistenciaDeRegistro(FTabTele.qTele,'SELECT * FROM PEDIDOMOVIMENTACAO WHERE IDCLIENTE = -1')) then begin
				FunDB.executarQuery(FTabTele.qTele,'UPDATE PEDIDOMOVIMENTACAO SET IDCLIENTE = '+qryTemporaria.FieldByName('Contador').AsString+' WHERE IDCLIENTE = -1');
				MessageDlg('Os produtos que estavam em movimentação para o cliente TEMPORARIO foram remanejados!', mtInformation, [mbOk], 0);
			end;

			//-- Mostra grade de movimentação com itens do cliente selecionado
			atualizarGradeMovimentacao(qryTemporaria.FieldByName('Contador').AsInteger);

			MostraCampos();
			atualizarGrades();
			filtrarProdutos();
			eCodigo.SetFocus();
		end else begin
			if Length(CodigoDigitado) > 0 then begin
				if (CADASTRACLIENTEAUTO) then begin
					try
						FunDB.iniciarQuery(qryTemporaria);
						qryTemporaria.SQL.Add('INSERT INTO CLIENTE (CONTADOR,NOME,FONE1,DATACADASTRO,IDCLIENTEGRUPO) VALUES (:CONTADOR,:NOME,:FONE1,CURRENT_TIMESTAMP,:IDCLIENTEGRUPO)');
						qryTemporaria.ParamByName('CONTADOR').AsInteger			:= FTabTele.buscarMaxContadorDBTele('TCadClie');
						qryTemporaria.ParamByName('NOME').AsString				:= 'Cadastro automático';
						qryTemporaria.ParamByName('FONE1').AsString				:= CodigoDigitado;
						qryTemporaria.ParamByName('IDCLIENTEGRUPO').AsInteger	:= 1;
						qryTemporaria.ExecSQL();
						FunDB.commitDireto(FTabTele.DBCommerce);
						processarCliente();
					except
						MessageDlg('Erro no cadastro automático!', mtError, [mbOk], 0);
					end;
				end else begin
					// Inclui Cliente ja repassando para FTabClie o Telefone digitado
					edtCodigo.SetFocus();
					FInicial.abrirJanelaDeCliente(edtCodigo.Text,true,0);
				end;
			end
			else
			begin
				//-- Se o código é inválido, continua focando no campo código
				edtCodigo.SetFocus();
			end;
		end;
	except
		MessageDlg('Erro na procura do telefone!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.FormActivate(Sender: TObject);
begin
	if (mostrarClienteVemDaJanelaDeClientes()) then begin
		processarCliente();
		alterarClienteVemDaJanelaDeClientes(false);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.dbgPedidoMovimentacaoDragDrop(Sender, Source: TObject; X, Y: Integer);
var	cod: array[0..3] of String;
		i : Integer;
begin
//	dbgListagemDeProdutos.DragMode := dmManual;
  if Source = dbgListagemDeProdutos then begin
	 dbgListagemDeProdutos.EndDrag(True); // finaliza o processo
//	for i:=0 to 3 do cod[i] := '-1';
//	if (Source = dbgListagemDeProdutos) then begin
//		if (dbgListagemDeProdutos.SelectedRows.Count <= 4)
//			and (dbgListagemDeProdutos.SelectedRows.Count > 0) then
		begin
//			with dbgListagemDeProdutos.DataSource.DataSet do begin
//				for i:=0 to dbgListagemDeProdutos.SelectedRows.Count-1 do begin
//					GotoBookmark(pointer(dbgListagemDeProdutos.SelectedRows.Items[i]));
//					cod[i] := FieldByName('CODIGO').AsString;
//				end;
//			end;


			cod[0] := dbgListagemDeProdutos.Fields[1].AsString;

			incluirItemPedido(
				1,//dbgListagemDeProdutos.SelectedRows.Count,
				retornarCliente(),
				cod[0],
				cod[1],
				cod[2],
				cod[3],
				'','','',''
			);
		end;
		if (mostraGradePediAbertos) then frmPedido.atualizarGradePedidosAbertos();
		atualizarGrades();
	end;

	//-- Deseleciona itens da grade de produtos
	dbgListagemDeProdutos.SelectedIndex := -1;
	dbgListagemDeProdutos.Refresh();
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.dbgPedidoMovimentacaoDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
	if (Source = dbgListagemDeProdutos) then begin
		Accept := true;
	end else begin
		Accept := false;
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.carregarCampoIngredientes();
begin
	edtDescricao.Text := qryProduto.FieldByName('INGREDIENTES').AsString;
end;
//-----------------------------------------------------------------------------------------------
function TfrmPedido.incluirItemPedido(pQtPedaco, p_ContadorCliente: Integer; pPedaco1, pPedaco2, pPedaco3, pPedaco4, p_ObsPedaco1, p_ObsPedaco2, p_ObsPedaco3, p_ObsPedaco4: String): Integer;
var itemAtivo: Integer;
begin
	itemAtivo := FTabTele.incluirItemPedido(pQtPedaco, p_ContadorCliente, pPedaco1, pPedaco2, pPedaco3, pPedaco4, p_ObsPedaco1, p_ObsPedaco2, p_ObsPedaco3, p_ObsPedaco4);

	FunDB.atualizarQuery(qryPedidoMovimentacao);
	qryPedidoMovimentacao.Locate('Contador',itemAtivo,[loCaseInsensitive]);

	if (MOSTRAJANELAOBSERVACOES) then smCadastrarObservacaoClick(nil);

	result := itemAtivo;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.alterarCampoTelefone(p_Telefone: String);
begin
	edtCodigo.Text := p_Telefone;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.mitZerarPontuacaoClick(Sender: TObject);
begin
	if MessageDlg('Esta opção irá zerar a pontuação do cliente. Deseja proceguir?', mtWarning, [mbYes, mbNo], 0) = mrYes then begin
		FTabTele.alterarPontuacaoDoCliente(FrmPedido.retornarCliente(), 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.atualizarGradeMovimentacao(p_idCliente: Integer);
begin
	qryPedidoMovimentacao.Close();
	qryPedidoMovimentacao.ParamByName('IdCliente').AsInteger := p_idCliente;
	qryPedidoMovimentacao.Open();
end;
//-----------------------------------------------------------------------------------------------
//-- Retorna variável mostraGradePediAbertos
function TfrmPedido.retornarMostraGradePediAbertos: bool;
begin
  result := mostraGradePediAbertos;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.mitLancarClick(Sender: TObject);
begin
	if (ECodigo.Text = 'Código') then
		ECodigo.Text := '';

	if (eCodigo.Text = '') then begin
		eCodigo.Text := eCodigo.Text + qryProduto.FieldByName('CODIGO').AsString;
	end else begin
		eCodigo.Text := eCodigo.Text + '/' + qryProduto.FieldByName('CODIGO').AsString;
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.mitInserirItemClick(Sender: TObject);
begin
	inserirItemPedido(eCodigo.Text);
	ECodigo.Text := 'Código';
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.inserirItemPedido(codigo: String);
var linha  : string;
	 QtPedidos,
	 QtPedacos,
	 Qtde,
	 countPedidos,
	 countPedacos : byte;
	 //-- Composição: São até 10 produtos onde
	 //-- 0=string digitada, 1=cod.1, 2=cod.2, 3=cod.3, 4=cod.4, 5=qtPedacos, 6=qtde
	 Pedaco : array[1..10,0..6] of string;
begin
	try
		//-- Variavel linha recebe o texto digitado
//		Linha := ECodigo.Text;
		Linha := codigo; 
		//-- Dependendo da quantidade de '+' que houver é a qt de itens do pedido
		QtPedidos := ContaSubStr( linha,'+') + 1;
		if (QtPedidos > 1) then begin
			for countPedidos:=1 to QtPedidos do begin
				if (countPedidos<QtPedidos) then Pedaco[countPedidos,0] := SubStrAnt(Linha,'+') else Pedaco[countPedidos,0] := Linha;
				Linha := SubStrPos(Linha,'+');
			end;
		end else begin
			Pedaco[1,0] := Linha;
		end;
		for countPedidos:=1 to QtPedidos do begin
			QtPedacos := ContaSubStr( Pedaco[countPedidos,0],'/') + 1;
			Pedaco[countPedidos,5] := InttoStr(QtPedacos);
			if QtPedacos = 1 then begin
				if Pos('*',Pedaco[countPedidos,0]) > 0 then begin
					Pedaco[countPedidos,1] := SubStrAnt(Pedaco[countPedidos,0],'*');
					Pedaco[countPedidos,6] := SubStrPos(Pedaco[countPedidos,0],'*');
				end else begin
					Pedaco[countPedidos,1] := Pedaco[countPedidos,0];
					Pedaco[countPedidos,6] := '1';
				end;
			end else begin
				for countPedacos:=1 to QtPedacos do begin
					if countPedacos<QtPedacos then begin
						if Pos('*',Pedaco[countPedidos,0]) > 0 then begin
							Pedaco[countPedidos,6] := SubStrPos(Pedaco[countPedidos,0],'*');
							Pedaco[countPedidos,6] := SubStrAnt(Pedaco[countPedidos,6],'/');
							Pedaco[countPedidos,countPedacos] := SubStrAnt(Pedaco[countPedidos,0],'*');
						end else begin
							Pedaco[countPedidos,countPedacos] := SubStrAnt(Pedaco[countPedidos,0],'/');
							Pedaco[countPedidos,6] := '1';
						end;
					end else begin
						if Pos('*',Pedaco[countPedidos,0]) > 0 then begin
							Pedaco[countPedidos,6] := SubStrPos(Pedaco[countPedidos,0],'*');
							Pedaco[countPedidos,countPedacos] := SubStrAnt(Pedaco[countPedidos,0],'*');
						end else begin
							Pedaco[countPedidos,countPedacos] := Pedaco[countPedidos,0];
							Pedaco[countPedidos,6] := '1';
						end;
					end;
					Pedaco[countPedidos,0] := SubStrPos(Pedaco[countPedidos,0],'/');
				end;
			end;
		end;
		//-- lançamentos
		for countPedidos:=1 to QtPedidos do	begin
			case StrtoInt(Pedaco[countPedidos,5]) of
				1: for Qtde:=1 to StrToInt(Pedaco[countPedidos,6]) do if (incluirItemPedido(1,retornarCliente(),Pedaco[countPedidos,1],'-1','-1','-1','','','','') = -1) then Exit;
				2: if (incluirItemPedido(2,retornarCliente(),Pedaco[countPedidos,1],Pedaco[countPedidos,2],'-1','-1','','','','') = -1) then Exit;
				3: if (incluirItemPedido(3,retornarCliente(),Pedaco[countPedidos,1],Pedaco[countPedidos,2],Pedaco[countPedidos,3],'-1','','','','') = -1) then Exit;
				4: if(incluirItemPedido(4,retornarCliente(),Pedaco[countPedidos,1],Pedaco[countPedidos,2],Pedaco[countPedidos,3],Pedaco[countPedidos,4],'','','','') = -1) then Exit;
			end;
			if (mostraGradePediAbertos) then
				frmPedido.atualizarGradePedidosAbertos();
			atualizarGrades();
		end;
//		ECodigo.Text := '';
	except
		MessageDlg('Erro na inclusão de Itens!', mtInformation, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.btnBuscarClienteClick(Sender: TObject);
begin
	inicializarPedidos();
	alterarClienteVemDaJanelaDeClientes(true);
	Finicial.abrirJanelaDeCliente(edtCodigo.Text,false,1);
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.alterarPedidoMovimentacaoEstagio(p_novoEstagio, p_IdCliente, p_IdItem: Integer; p_Obs: String);
begin
	FunDB.iniciarQuery(qryTemporaria);
	qryTemporaria.SQL.Add(
		'UPDATE PEDIDOMOVIMENTACAO '+
		'SET IDESTAGIO = :ESTAGIO '
	);
	if (p_IdItem <> -1) then begin
	qryTemporaria.SQL.Add(
		', OBSGERAL = :OBS '
	);
	end;
	qryTemporaria.SQL.Add(
		'WHERE PEDIDOMOVIMENTACAO.IDCLIENTE = :IDCLIENTE '
	);
	if (p_IdItem <> -1) then begin
		qryTemporaria.SQL.Add(' AND PEDIDOMOVIMENTACAO.CONTADOR = :IdItem ');
		qryTemporaria.ParamByName('IdItem').AsInteger := p_IdItem;
		qryTemporaria.ParamByName('Obs').AsString := p_Obs;
	end;
	qryTemporaria.ParamByName('ESTAGIO').AsInteger := p_novoEstagio;
	qryTemporaria.ParamByName('IDCLIENTE').AsInteger := p_IdCliente;
	qryTemporaria.ExecSQL();

	FunDB.CommitDireto(FTabTele.DBCommerce);
	FunDB.atualizarQuery(qryPedidoMovimentacao);
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedido.dbgListagemDeProdutosDblClick(Sender: TObject);
begin
	inserirItemPedido(qryProduto.FieldByName('CODIGO').AsString);
end;

procedure TfrmPedido.dbgListagemDeProdutosMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
	if ssLeft in shift then
		dbgListagemDeProdutos.beginDrag(true)
end;

end.
//-----------------------------------------------------------------------------------------------
//   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM
//-----------------------------------------------------------------------------------------------
