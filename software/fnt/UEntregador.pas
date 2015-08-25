unit UEntregador;
//-----------------------------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------------------------
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, Grids, DBGrids, ImgList, DBTables, Db, UTabTele, Menus,
  StdCtrls, UFunDB, DBCtrls, Buttons, UFunGeral, URelatorio;
//-----------------------------------------------------------------------------------------------
type
	TfrmEntregador = class(TForm)
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
		dsqDefault: TDataSource;
		MainMenu1: TMainMenu;
		mitProduto: TMenuItem;
		mitFirst: TMenuItem;
		mitPrior: TMenuItem;
		mitNext: TMenuItem;
		mitLast: TMenuItem;
		btnLast: TToolButton;
		btnSave: TToolButton;
		scbEdit: TScrollBox;
    edtNome: TEdit;
    labNome: TLabel;
		mitNew: TMenuItem;
		mitDelete: TMenuItem;
	 ToolButton2: TToolButton;
	 btnRefresh: TToolButton;
	 N1: TMenuItem;
	 mitRefresh: TMenuItem;
	 qryTemporaria: TQuery;
    mitSave: TMenuItem;
    N2: TMenuItem;
    edtEmpresa: TEdit;
    labEmpresa: TLabel;
    edtComissao: TEdit;
    labComissao: TLabel;
	 ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    N3: TMenuItem;
    ImageList1: TImageList;
    tbtBusca: TToolButton;
    tbtCancelarFiltros: TToolButton;
    ToolButton8: TToolButton;
    tbtImprimir: TToolButton;
    tbtImprimirTodos: TToolButton;
    ToolButton11: TToolButton;
    tbtFechar: TToolButton;
    popBusca: TPopupMenu;
    mi1BuscaNome: TMenuItem;
    mitBusca: TMenuItem;
    mitCancelarFiltros: TMenuItem;
    N4: TMenuItem;
    mitImprimir: TMenuItem;
    mitImprimirTodos: TMenuItem;
    N5: TMenuItem;
    mitFechar: TMenuItem;
    mitBuscaCodigo: TMenuItem;
    mitBuscaNome: TMenuItem;
    FindDialog1: TFindDialog;
    labDtCadastro: TLabel;
    dtpDtCadastro: TDateTimePicker;
		procedure FormCreate(Sender: TObject);
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		procedure mitFirstClick(Sender: TObject);
		procedure mitDeleteClick(Sender: TObject);
		procedure FormShow(Sender: TObject);
	 procedure dbgProdutoDblClick(Sender: TObject);
	 procedure mitRefreshClick(Sender: TObject);
    procedure mitNewClick(Sender: TObject);
	 procedure mitSaveClick(Sender: TObject);
    procedure edtNomeKeyPress(Sender: TObject; var Key: Char);
    procedure mi1BuscaCodigoClick(Sender: TObject);
    procedure tbtCancelarFiltrosClick(Sender: TObject);
    procedure tbtImprimirTodosClick(Sender: TObject);
    procedure tbtFecharClick(Sender: TObject);
	protected
		FunDB: TFunDB;
		FunGeral				: TFunGeral;
	private
		{ Private declarations }
	public
		{ Public declarations }
	end;
//-----------------------------------------------------------------------------------------------
var
	frmEntregador: TfrmEntregador;
//-- Variaveis
	incluindo : bool;
	const c_Limpa =	0;
	const c_Grava =	1;
	const c_Carrega =	2;
	var qryDefault: TQuery;
//-----------------------------------------------------------------------------------------------
implementation {$R *.DFM}
//-----------------------------------------------------------------------------------------------
procedure TfrmEntregador.FormCreate(Sender: TObject);
begin
	FunDB := TFunDB.criarInstancia();
	qryDefault := TQuery(dsqDefault.DataSet);
	if not (qryDefault.Active) then qryDefault.Open();
	qryTemporaria.DatabaseName := qryDefault.DatabaseName;
	Self.Caption := Copy(qryDefault.Name,4,Length(qryDefault.Name)-1);
//	Self.Caption := FTabTele.retParamIndexStr(Copy(Self.Name,4,Length(Self.Name)));
end;

procedure TfrmEntregador.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	FunDB.destruirInstancia();
	Release();
end;

procedure TfrmEntregador.mitFirstClick(Sender: TObject);
begin
	incluindo := false;
	if ((Sender = mitPrior)or(Sender = btnPrior)) then	qryDefault.Prior();
	if ((Sender = mitFirst)or(Sender = btnFirst)) then	qryDefault.First();
	if ((Sender = mitNext)or(Sender = btnNext)) then	qryDefault.Next();
	if ((Sender = mitLast)or(Sender = btnLast)) then	qryDefault.Last();
	FunDB.atualizarCampos(TWinControl(scbEdit),c_Carrega,ukInsert,qryDefault);//-- Enviando ukInsert apenas para evitar erro
   edtComissao.Text := FunGeral.retornarStringMonetaria(StrToFloat(edtComissao.Text));
end;

procedure TfrmEntregador.mitDeleteClick(Sender: TObject);
begin
	if (MessageDlg('Deseja excluir o registro?', mtWarning, [mbYes, mbNo], 0) = mrYes) then begin
		if not (FunDB.verificarExistenciaDeRegistro(qryTemporaria,'SELECT CONTADOR FROM PEDIDOITEM WHERE IDPEDIDO = '+qryDefault.FieldByName('Contador').AsString)) then begin
			FunDB.registrar(TWinControl(scbEdit),ukDelete,qryDefault);
		end else begin
			MessageDlg('Este registro não pode ser excluído por ter vínculos ativos!', mtInformation, [mbOk], 0);
		end;
	end;
end;

procedure TfrmEntregador.FormShow(Sender: TObject);
begin
	mitFirstClick(mitFirst);
	pgcFile.ActivePage := tshConsult;
	FTabTele.escreverTextos(Self);
end;

procedure TfrmEntregador.dbgProdutoDblClick(Sender: TObject);
begin
	pgcFile.ActivePage := tshEdit;
	FunDB.atualizarCampos(TWinControl(scbEdit),c_Carrega,ukInsert,qryDefault);//-- Enviando ukInsert apenas para evitar erro
end;

procedure TfrmEntregador.mitRefreshClick(Sender: TObject);
begin
	FunDB.executarRefresh(TWinControl(scbEdit),qryDefault);
end;

procedure TfrmEntregador.mitNewClick(Sender: TObject);
begin
	pgcFile.ActivePage := tshEdit;
	edtNome.SetFocus();
	FunDB.atualizarCampos(TWinControl(scbEdit),c_Limpa,ukInsert,qryDefault);//-- Enviando ukInsert apenas para evitar erro
	incluindo := true;
end;

procedure TfrmEntregador.mitSaveClick(Sender: TObject);
begin
	if (incluindo) then begin
		FunDB.registrar(TWinControl(scbEdit),ukInsert,qryDefault);
	end else begin
		FunDB.registrar(TWinControl(scbEdit),ukModify,qryDefault);
	end;
	incluindo := false;
end;

procedure TfrmEntregador.edtNomeKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmEntregador.mi1BuscaCodigoClick(Sender: TObject);
begin
	if (Sender = mitBuscaNome)or(Sender = mi1BuscaNome) then begin
		FindDialog1.FindText := 'Nome';
		FindDialog1.Tag := 2;
	end;
	FindDialog1.Execute;
end;

procedure TfrmEntregador.tbtCancelarFiltrosClick(Sender: TObject);
var str: String;
begin
	str := '';
	if (Sender = tbtCancelarFiltros)or(Sender = mitCancelarFiltros) then begin
		qryDefault.ParamByName('BUSCANOME').AsString := '%';
	end;
	if (Sender = FindDialog1)and(FindDialog1.Tag = 1) then begin
		qryDefault.ParamByName('BUSCANOME').AsString := '%'+FindDialog1.FindText+'%';
		FindDialog1.CloseDialog;
	end;
	FunDB.AtualizarQuery(qryDefault);
	FunDB.atualizarCampos(TWinControl(scbEdit),c_Carrega,ukInsert,qryDefault);//-- Enviando ukInsert apenas para evitar erro
end;

procedure TfrmEntregador.tbtImprimirTodosClick(Sender: TObject);
var     mRelatorio     : Relatorio;
begin
	Exit;
	try
		mRelatorio := Relatorio.Create;
		mRelatorio.iniciarVariaveis;
		mRelatorio.iniciarRelatorio;
		mRelatorio.incluirNovaPagina;
		mRelatorio.alterarRTitulo(
			FunGeral.EscreveE('Código',10)+FunGeral.Space(1)+
			FunGeral.EscreveE('Nome',30)+FunGeral.Space(1)+
			FunGeral.EscreveD('Valor',8)+FunGeral.Space(1)+
			FunGeral.EscreveD('Gr. Produto',12)+FunGeral.Space(1)+
			FunGeral.EscreveD('Gr. Cliente',12)
		);
		mRelatorio.alterarRFiltro('Listagem de Produtos');
		qryDefault.First();
		while not (qryDefault.Eof) do begin
			mRelatorio.colocarCabecalho('teste', Uppercase(FTabTele.retornarVariavel('NomeEmpresa','EMPRESA')));
			mRelatorio.escrever(
				FunGeral.EscreveE(qryDefault.fieldByName('Codigo').AsString,10)+FunGeral.Space(1)+
				FunGeral.EscreveE(qryDefault.fieldByName('Nome').AsString,30)+FunGeral.Space(1)+
				FunGeral.EscreveN(qryDefault.fieldByName('Valor').AsFloat,8,2)+FunGeral.Space(1)+
				FunGeral.EscreveE(qryDefault.fieldByName('NOMECLIENTEGRUPO').AsString,12)+FunGeral.Space(1)+
				FunGeral.EscreveE(qryDefault.fieldByName('NOMEPRODUTOGRUPO').AsString,12)
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
	except
		mRelatorio.finalizarRelatorio;
		mRelatorio.limparBuffer;
		mRelatorio.Free();
	end;
end;

procedure TfrmEntregador.tbtFecharClick(Sender: TObject);
begin
	//-- Se a janela de busca estiver aberta, primeiro fecha ela, depois a janela
	if (FindDialog1.Handle <> 0) then FindDialog1.CloseDialog else Close();
end;

end.
//-----------------------------------------------------------------------------------------------
//   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM
//-----------------------------------------------------------------------------------------------

