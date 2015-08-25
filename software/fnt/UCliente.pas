unit UCliente;
//-----------------------------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------------------------
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, Grids, DBGrids, ImgList, DBTables, Db, UTabTele, Menus,
  StdCtrls, UFunDB, DBCtrls, Buttons, ExtCtrls, UImpPedi, URelatorio, UFunGeral,
  UPedido;
//-----------------------------------------------------------------------------------------------
type
	TfrmCliente = class(TForm)
		pgcFile: TPageControl;
		tshConsult: TTabSheet;
		tshEdit: TTabSheet;
		dbgProduto: TDBGrid;
		ToolBar1: TToolBar;
		ToolButton1: TToolButton;
		btnNew: TToolButton;
		btnFirst: TToolButton;
		btnPrior: TToolButton;
		btnNext: TToolButton;
		ImageList1: TImageList;
		dsqDefault: TDataSource;
		MainMenu1: TMainMenu;
		mitCliente: TMenuItem;
		mitFirst: TMenuItem;
		mitPrior: TMenuItem;
		mitNext: TMenuItem;
		mitLast: TMenuItem;
		btnLast: TToolButton;
		btnSave: TToolButton;
		scbEdit: TScrollBox;
		mitNew: TMenuItem;
		mitDelete: TMenuItem;
		ToolButton2: TToolButton;
		btnRefresh: TToolButton;
		N1: TMenuItem;
		mitRefresh: TMenuItem;
		qryTemporaria: TQuery;
		mitSave: TMenuItem;
		N2: TMenuItem;
		ToolButton3: TToolButton;
		ToolButton4: TToolButton;
		tbtDelete: TToolButton;
		N3: TMenuItem;
		dtsProdutoGrupo: TDataSource;
		dtsClienteGrupo: TDataSource;
		pgcDados: TPageControl;
		tshPrincipal: TTabSheet;
		tshAdicional: TTabSheet;
		edtCEP: TEdit;
		labCEP: TLabel;
		dtpDataNascimento: TDateTimePicker;
		labDataNascimento: TLabel;
		dtpDataCadastro: TDateTimePicker;
		Label1: TLabel;
		dtpDataUltimoPedido: TDateTimePicker;
		labDataUltimoPedido: TLabel;
		edtObs2: TEdit;
		labObs2: TLabel;
		edtDDD: TEdit;
		labDDD: TLabel;
		edtFone2: TEdit;
		labFone2: TLabel;
		edtFone3: TEdit;
		labFone3: TLabel;
		edtNome: TEdit;
		labNome: TLabel;
		edtLogradouro: TEdit;
		labLogradouro: TLabel;
		edtNumero: TEdit;
		labNumero: TLabel;
		edtCidade: TEdit;
		labCidade: TLabel;
		edtReferencia: TEdit;
		labReferencia: TLabel;
		edtBairro: TEdit;
		labBairro: TLabel;
		edtComplemento: TEdit;
		labComplemento: TLabel;
		edtObs1: TEdit;
		labObs1: TLabel;
		panEditTop: TPanel;
		btnEditClienteGrupo: TBitBtn;
		lcbIdClienteGrupo: TDBLookupComboBox;
		labClienteGrupo: TLabel;
		edtFone1: TEdit;
		labFone1: TLabel;
		ToolButton6: TToolButton;
		tbtImprimir: TToolButton;
		edtEMail: TEdit;
		labEMail: TLabel;
		ToolButton8: TToolButton;
		tbtImprimirTodos: TToolButton;
		FindDialog1: TFindDialog;
		N4: TMenuItem;
		mitImprimir: TMenuItem;
		mitImprimirTodos: TMenuItem;
		tbtFechar: TToolButton;
		tbtCancelarFiltros: TToolButton;
		mitCancelarFiltros: TMenuItem;
		N5: TMenuItem;
		mitFechar: TMenuItem;
		tbtBusca: TToolButton;
		popBusca: TPopupMenu;
		mi1BuscaCodigo: TMenuItem;
		mitBuscaCodigo: TMenuItem;
		mitBusca: TMenuItem;
		mitBuscaNome: TMenuItem;
		mitBuscaEndereco: TMenuItem;
		mi1BuscaNome: TMenuItem;
		mi1BuscaEndereco: TMenuItem;
		edtPontuacao: TEdit;
		labPontuacao: TLabel;
    tbtPedido: TToolButton;
    mitIniciarPedidoparaocliente: TMenuItem;
		procedure FormCreate(Sender: TObject);
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		procedure mitFirstClick(Sender: TObject);
		procedure mitDeleteClick(Sender: TObject);
		procedure FormShow(Sender: TObject);
		procedure dbgProdutoDblClick(Sender: TObject);
		procedure mitRefreshClick(Sender: TObject);
		procedure mitNewClick(Sender: TObject);
		procedure mitSaveClick(Sender: TObject);
		procedure tbtImprimirClick(Sender: TObject);
		procedure buscarCliente(Sender: TObject);
		procedure edtFone1KeyPress(Sender: TObject; var Key: Char);
		procedure btnProcurarCodigoClick(Sender: TObject);
		procedure tbtFecharClick(Sender: TObject);
		procedure edtReferenciaKeyPress(Sender: TObject; var Key: Char);
		procedure tbtImprimirTodosClick(Sender: TObject);
		procedure tbtPedidoClick(Sender: TObject);
    procedure btnEditClienteGrupoClick(Sender: TObject);
	protected
		FunDB: TFunDB;
		FunGeral: TFunGeral;
	private
		{ Private declarations }
		ImpressaoPedi    : ImpPedi;
	public
		{ Public declarations }
		procedure setarCliente(p_Codigo: String; p_Inclui: Bool; p_TipoBusca: Integer);
	end;
//-----------------------------------------------------------------------------------------------
var	frmCliente: TfrmCliente;
//-- Variaveis
		incluindo: bool;
		alterandoDePedidos: bool;
		const c_Limpa =	0;
		const c_Grava =	1;
		const c_Carrega =	2;
		var qryDefault: TQuery;
//-----------------------------------------------------------------------------------------------
implementation

uses UClienteGrupo; {$R *.DFM}
//-----------------------------------------------------------------------------------------------
procedure TfrmCliente.FormCreate(Sender: TObject);
begin
	FunDB := TFunDB.criarInstancia();
	qryDefault := TQuery(dsqDefault.DataSet);
	if not (qryDefault.Active) then qryDefault.Open();
	qryTemporaria.DatabaseName := qryDefault.DatabaseName;
	Self.Caption := Copy(qryDefault.Name,4,Length(qryDefault.Name)-1);
//	Self.Caption := FTabTele.retParamIndexStr(Copy(Self.Name,4,Length(Self.Name)));
	pgcDados.ActivePage := tshPrincipal;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	FunDB.destruirInstancia();
	Release();// Quando usado Free ocorre access violation ao retornar para pedidos
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmCliente.mitFirstClick(Sender: TObject);
begin
	incluindo := false;
	if ((Sender = mitPrior)or(Sender = btnPrior)) then	qryDefault.Prior();
	if ((Sender = mitFirst)or(Sender = btnFirst)) then	qryDefault.First();
	if ((Sender = mitNext)or(Sender = btnNext)) then	qryDefault.Next();
	if ((Sender = mitLast)or(Sender = btnLast)) then	qryDefault.Last();
	FunDB.atualizarCampos(TWinControl(scbEdit),c_Carrega,ukInsert,qryDefault);//-- Enviando ukInsert apenas para evitar erro
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmCliente.mitDeleteClick(Sender: TObject);
begin
	if not FunGeral.mostrarJaneladeAcesso(
		FTabTele.retornarVariavel('NomeEmpresa','EMPRESA'),
		FTabTele.retornarVariavel('acessoUsuario01','Gerente'),
		FTabTele.retornarSenhaDecriptografada(
			FTabTele.retornarVariavel('acessoSenha01',FTabTele.retornarVarSenhaCriptPadrao())
		)
	)then Exit;

	if (MessageDlg('Deseja excluir o registro?', mtWarning, [mbYes, mbNo], 0) = mrYes) then begin
		FunDB.registrar(TWinControl(scbEdit),ukDelete,qryDefault);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmCliente.FormShow(Sender: TObject);
begin
	mitFirstClick(mitFirst);
	pgcFile.ActivePage := tshConsult;
	FTabTele.escreverTextos(Self);
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmCliente.dbgProdutoDblClick(Sender: TObject);
begin
	pgcFile.ActivePage := tshEdit;
	FunDB.atualizarCampos(TWinControl(scbEdit),c_Carrega,ukInsert,qryDefault);//-- Enviando ukInsert apenas para evitar erro
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmCliente.mitRefreshClick(Sender: TObject);
begin
	FunDB.executarRefresh(TWinControl(scbEdit),qryDefault);
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmCliente.mitNewClick(Sender: TObject);
begin
	pgcFile.ActivePage := tshEdit;
	FunDB.atualizarCampos(TWinControl(scbEdit),c_Limpa,ukInsert,qryDefault);//-- Enviando ukInsert apenas para evitar erro

	//-- Campos que não foram corretamente preenchidos em atualizarCampos
	edtCidade.Text := FTabTele.retornarVariavel('CidadePadrao','FLORIANÓPOLIS');
	lcbIdClienteGrupo.KeyValue := '1';
	dtpDataUltimoPedido.Date := 0;

	edtFone1.SetFocus();
	incluindo := true;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmCliente.mitSaveClick(Sender: TObject);
begin
	if (qryDefault.RecordCount = 0) then incluindo := true;
	if (incluindo) then begin
		FunDB.registrar(TWinControl(scbEdit),ukInsert,qryDefault);
	end else begin
		FunDB.registrar(TWinControl(scbEdit),ukModify,qryDefault);
	end;
	incluindo := false;
	if (alterandoDePedidos) then Close();
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmCliente.tbtImprimirClick(Sender: TObject);
var mPrevisao: TRichEdit;
begin
	ImpressaoPedi := ImpPedi.criarInstancia;
	ImpressaoPedi.setarRichPadrao();
	ImpressaoPedi.setarRichPara40Colunas();
	ImpressaoPedi.limparTexto();
	ImpressaoPedi.imprimirCabecalho(FTabTele.retornarVariavel('RelLinha1','RelLinha1'),FTabTele.retornarVariavel('RelLinha2','RelLinha2'),FTabTele.retornarVariavel('RelLinha3','RelLinha3'),false);
	ImpressaoPedi.imprimirSeparador40Secundario();
	ImpressaoPedi.escreverLinha40ColC('D A D O S   D O   C L I E N T E');
	ImpressaoPedi.imprimirSeparador40Secundario();
	ImpressaoPedi.escreverLinha40ColE('Dt: '+DateToStr(Date)+' Hr: '+TimeToStr(Time));
	ImpressaoPedi.escreverDadosCliente40Colunas(
		FTabTele.retornarVariavel('campoCodigoCliente','Fone'),
		qryDefault.FieldByName('Fone1').AsString,
		qryDefault.FieldByName('Nome').AsString,
		qryDefault.FieldByName('Logradouro').AsString,
		qryDefault.FieldByName('Numero').AsString,
		qryDefault.FieldByName('Bairro').AsString,
		qryDefault.FieldByName('Complemento').AsString,
		qryDefault.FieldByName('Referencia').AsString
	);
	ImpressaoPedi.imprimirLinhaEmBrancoEspecial(StrToInt(FTabTele.retornarVariavel('NuLinhasBranco','10')),FTabTele.retornarVariavelBool('ImprimeEspecial','false'));
	ImpressaoPedi.irParaInicio();
	if (FTabTele.retornarVariavelBool('VisualizarPedido','true')) then impressaoPedi.mostrarPrevisao();
	ImpressaoPedi.enviarParaImpressora(FTabTele.retornarVariavelBool('ConfImpPedi','true'),FTabTele.retornarVariavelBool('ImprimeEspecial','false'),StrToInt(FTabTele.retornarVariavel('NuLinhasBranco','10')));
	ImpressaoPedi.destruirInstancia();
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmCliente.buscarCliente(Sender: TObject);
var str: String;
begin
	str := '';
	if (Sender = tbtCancelarFiltros)or(Sender = mitCancelarFiltros) then begin
		qryDefault.ParamByName('BUSCAFONE').AsString	:= '%';
		qryDefault.ParamByName('BUSCANOME').AsString := '%';
		qryDefault.ParamByName('BUSCAENDERECO').AsString := '%';
	end;
	if (Sender = FindDialog1)and(FindDialog1.Tag = 1) then begin

//-- Como o campo Fone tem 8 caracteres, ocorre erro de sql se ultrapassar este limite com '%'
//		if (Length(FindDialog1.FindText)<7) then str := '%';
//		str := str + FindDialog1.FindText;
//		if (Length(FindDialog1.FindText)<8) then str := str + '%';
		//-- No caso do código não deve-se buscar clientes com código parcial devido "alterar cliente" da janela de pedidos
		str := FindDialog1.FindText;
		qryDefault.ParamByName('BUSCAFONE').AsString := str;
		qryDefault.ParamByName('BUSCANOME').AsString := '%';
		qryDefault.ParamByName('BUSCAENDERECO').AsString := '%';
		FindDialog1.CloseDialog;
	end;
	if (Sender = FindDialog1)and(FindDialog1.Tag = 2) then begin
		qryDefault.ParamByName('BUSCANOME').AsString := '%'+FindDialog1.FindText+'%';
		qryDefault.ParamByName('BUSCAFONE').AsString := '%';
		qryDefault.ParamByName('BUSCAENDERECO').AsString := '%';
		FindDialog1.CloseDialog;
	end;
	if (Sender = FindDialog1)and(FindDialog1.Tag = 3) then begin
		qryDefault.ParamByName('BUSCAFONE').AsString := '%';
		qryDefault.ParamByName('BUSCANOME').AsString := '%';
		qryDefault.ParamByName('BUSCAENDERECO').AsString := '%'+FindDialog1.FindText+'%';
		FindDialog1.CloseDialog;
	end;
	FunDB.AtualizarQuery(qryDefault);
	FunDB.atualizarCampos(TWinControl(scbEdit),c_Carrega,ukInsert,qryDefault);//-- Enviando ukInsert apenas para evitar erro
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmCliente.setarCliente(p_Codigo: String; p_Inclui: Bool; p_TipoBusca: Integer);
begin
	if (p_TipoBusca = 0) then //-- Não não é para realizar uma busca de cliente então preparar para alterar dados
	begin
		//-- Verificar
		//-- Se vem do menu principal -> Abre para consulta de usuários
		//-- Se não há registros -> Abre para cadastro de novo
		//-- Se vem do cadastro de pedidos -> Abre no cliente selecionado
		alterandoDePedidos := true;
		pgcFile.ActivePage := tshEdit;
		if (p_Inclui) then begin
			btnNew.Click();
			edtFone1.Text := p_Codigo;
		end else begin
			FindDialog1.FindText := p_Codigo;
			FindDialog1.Tag := 1;
			buscarCliente(FindDialog1);
		end;
		edtNome.SetFocus;
	end
	else //-- Se for uma busca (por enquanto apenas de nome) abre na janela de consulta e prepara finddialog
	begin
		alterandoDePedidos := true;
		pgcFile.ActivePage := tshConsult;
		btnProcurarCodigoClick(mi1BuscaNome);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmCliente.edtFone1KeyPress(Sender: TObject; var Key: Char);
begin
  try
	 if Key = #13 then begin
		SelectNext(Sender as tWinControl, True, True );
		Key := #0;
	 end;
  except
	 MessageDlg('Erro ao focar próximo campo!', mtError, [mbOk], 0);
  end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmCliente.btnProcurarCodigoClick(Sender: TObject);
begin
	if (Sender = mitBuscaCodigo)or(Sender = mi1BuscaCodigo) then begin
		FindDialog1.FindText := labFone1.Caption;
		FindDialog1.Tag := 1;
	end;
	if (Sender = mitBuscaNome)or(Sender = mi1BuscaNome) then begin
		FindDialog1.FindText := 'Nome';
		FindDialog1.Tag := 2;
	end;
	if (Sender = mitBuscaEndereco)or(Sender = mi1BuscaEndereco) then begin
		FindDialog1.FindText := 'Endereço';
		FindDialog1.Tag := 3;
	end;
	FindDialog1.Execute;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmCliente.tbtFecharClick(Sender: TObject);
begin
	//-- Se a janela de busca estiver aberta, primeiro fecha ela, depois a janela
	if (FindDialog1.Handle <> 0) then FindDialog1.CloseDialog else Close();
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmCliente.edtReferenciaKeyPress(Sender: TObject;
  var Key: Char);
begin
  try
	 if Key = #13 then begin
		if MessageDlg('Deseja salvar as alterações e sair?', mtConfirmation	, [mbYes,mbNo], 0) = mrYes then begin
			mitSave.Click();
		end else begin
			SelectNext(Sender as tWinControl, True, True );
			Key := #0;
		end;
	 end;
  except
	 MessageDlg('Erro ao focar campo de observações do cliente!', mtError, [mbOk], 0);
  end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmCliente.tbtImprimirTodosClick(Sender: TObject);
var     mRelatorio     : Relatorio;
begin
	try
		mRelatorio := Relatorio.Create;
		mRelatorio.iniciarVariaveis;
		mRelatorio.iniciarRelatorio;
		mRelatorio.incluirNovaPagina;
		mRelatorio.alterarRTitulo(
			FunGeral.EscreveE(labFone1.Caption,8)+FunGeral.Space(1)+
			FunGeral.EscreveE('Nome',30)+FunGeral.Space(1)+
			FunGeral.EscreveE('Bairro',20)+FunGeral.Space(1)+
			FunGeral.EscreveE('Cidade',12)
		);
		mRelatorio.alterarRFiltro('Listagem de Produtos');
		qryDefault.DisableControls();
		qryDefault.First();
		while not (qryDefault.Eof) do begin
			mRelatorio.colocarCabecalho('teste', Uppercase(FTabTele.retornarVariavel('NomeEmpresa','EMPRESA')));
			mRelatorio.escrever(
				FunGeral.EscreveE(qryDefault.fieldByName('Fone1').AsString,8)+FunGeral.Space(1)+
				FunGeral.EscreveE(qryDefault.fieldByName('Nome').AsString,30)+FunGeral.Space(1)+
				FunGeral.EscreveE(qryDefault.fieldByName('Bairro').AsString,20)+FunGeral.Space(1)+
				FunGeral.EscreveE(qryDefault.fieldByName('Cidade').AsString,12)
			);
			mRelatorio.pularLinha;
			qryDefault.Next();
			mRelatorio.finalizarPagina;
		end;
		mRelatorio.pularLinha;
		mRelatorio.finalizarArquivoQuery(qryDefault,FunGeral.Space(3)+'Quantidade: '+IntToStr(qryDefault.RecordCount));
		mRelatorio.finalizarRelatorio;
		mRelatorio.visualizarRelatorio;
		mRelatorio.limparBuffer;
		mRelatorio.Free();
		qryDefault.EnableControls();
	except
		mRelatorio.finalizarRelatorio;
		mRelatorio.limparBuffer;
		mRelatorio.Free();
		qryDefault.EnableControls();
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmCliente.tbtPedidoClick(Sender: TObject);
begin
	frmPedido.alterarClienteVemDaJanelaDeClientes(true);
	frmPedido.alterarCampoTelefone(edtFone1.Text);
	Close();
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmCliente.btnEditClienteGrupoClick(Sender: TObject);
begin
	frmClienteGrupo.ShowModal();	
end;

end.
//-----------------------------------------------------------------------------------------------
//   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM
//-----------------------------------------------------------------------------------------------

