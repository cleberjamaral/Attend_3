unit UProduto;
//-----------------------------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------------------------
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, Grids, DBGrids, ImgList, DBTables, Db, UTabTele, Menus,
  StdCtrls, UFunDB, DBCtrls, Buttons, UFunGeral, URelatorio;
//-----------------------------------------------------------------------------------------------
type
	TfrmProduto = class(TForm)
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
		labClienteGrupo: TLabel;
		labProdutoGrupo: TLabel;
		edtCodigo: TEdit;
		labCodigo: TLabel;
		edtValor: TEdit;
		labValor: TLabel;
		edtIngredientes: TEdit;
		labAbreviacao: TLabel;
		labIngredientes: TLabel;
		edtAbreviacao: TEdit;
		ToolButton3: TToolButton;
		ToolButton4: TToolButton;
		ToolButton5: TToolButton;
		N3: TMenuItem;
		lcbIdClienteGrupo: TDBLookupComboBox;
		dtsProdutoGrupo: TDataSource;
		btnEditClienteGrupo: TBitBtn;
		lcbIdProdutoGrupo: TDBLookupComboBox;
		dtsClienteGrupo: TDataSource;
		btnEditProdutoGrupo: TBitBtn;
		ImageList1: TImageList;
		tbtBusca: TToolButton;
		tbtCancelarFiltros: TToolButton;
		ToolButton8: TToolButton;
		tbtImprimir: TToolButton;
		tbtImprimirTodos: TToolButton;
		ToolButton11: TToolButton;
		tbtFechar: TToolButton;
		popBusca: TPopupMenu;
		mi1BuscaCodigo: TMenuItem;
		mi1BuscaNome: TMenuItem;
		FindDialog1: TFindDialog;
		mitBusca: TMenuItem;
		mitCancelarFiltros: TMenuItem;
		N4: TMenuItem;
		mitImprimir: TMenuItem;
		mitImprimirTodos: TMenuItem;
		N5: TMenuItem;
		mitFechar: TMenuItem;
		mitBuscaCodigo: TMenuItem;
		mitBuscaNome: TMenuItem;
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
    procedure btnEditClienteGrupoClick(Sender: TObject);
    procedure btnEditProdutoGrupoClick(Sender: TObject);
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
	frmProduto: TfrmProduto;
//-- Variaveis
	incluindo : bool;
	atualizarGrade : bool;
	const c_Limpa =	0;
	const c_Grava =	1;
	const c_Carrega =	2;
	var qryDefault: TQuery;
//-----------------------------------------------------------------------------------------------
implementation

uses UClienteGrupo, UProdutoGrupo; {$R *.DFM}
//-----------------------------------------------------------------------------------------------
procedure TfrmProduto.FormCreate(Sender: TObject);
begin
	FunDB := TFunDB.criarInstancia();
	qryDefault := TQuery(dsqDefault.DataSet);
	if not (qryDefault.Active) then qryDefault.Open();
	qryTemporaria.DatabaseName := qryDefault.DatabaseName;
	Self.Caption := Copy(qryDefault.Name,4,Length(qryDefault.Name)-1);
//	Self.Caption := FTabTele.retParamIndexStr(Copy(Self.Name,4,Length(Self.Name)));
end;

procedure TfrmProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//	atualizarGrade
	FunDB.destruirInstancia();
	Release();
end;

procedure TfrmProduto.mitFirstClick(Sender: TObject);
begin
	incluindo := false;
	if ((Sender = mitPrior)or(Sender = btnPrior)) then	qryDefault.Prior();
	if ((Sender = mitFirst)or(Sender = btnFirst)) then	qryDefault.First();
	if ((Sender = mitNext)or(Sender = btnNext)) then	qryDefault.Next();
	if ((Sender = mitLast)or(Sender = btnLast)) then	qryDefault.Last();
	FunDB.atualizarCampos(TWinControl(scbEdit),c_Carrega,ukInsert,qryDefault);//-- Enviando ukInsert apenas para evitar erro
   if (edtValor.Text <> '') then edtValor.Text := FunGeral.retornarStringMonetaria(StrToFloat(edtValor.Text));
end;

procedure TfrmProduto.mitDeleteClick(Sender: TObject);
begin
	if (MessageDlg('Deseja excluir o registro?', mtWarning, [mbYes, mbNo], 0) = mrYes) then begin
		if not (FunDB.verificarExistenciaDeRegistro(qryTemporaria,'SELECT CONTADOR FROM PEDIDOITEM WHERE IDPEDIDO = '+qryDefault.FieldByName('Contador').AsString)) then begin
			FunDB.registrar(TWinControl(scbEdit),ukDelete,qryDefault);
		end else begin
			MessageDlg('Este registro não pode ser excluído por ter vínculos ativos!', mtInformation, [mbOk], 0);
		end;
	end;
end;

procedure TfrmProduto.FormShow(Sender: TObject);
begin
	mitFirstClick(mitFirst);
	pgcFile.ActivePage := tshConsult;
	FTabTele.escreverTextos(Self);
end;

procedure TfrmProduto.dbgProdutoDblClick(Sender: TObject);
begin
	pgcFile.ActivePage := tshEdit;
	FunDB.atualizarCampos(TWinControl(scbEdit),c_Carrega,ukInsert,qryDefault);//-- Enviando ukInsert apenas para evitar erro
end;

procedure TfrmProduto.mitRefreshClick(Sender: TObject);
begin
	FunDB.executarRefresh(TWinControl(scbEdit),qryDefault);
end;

procedure TfrmProduto.mitNewClick(Sender: TObject);
begin
	pgcFile.ActivePage := tshEdit;
	edtNome.SetFocus();
	FunDB.atualizarCampos(TWinControl(scbEdit),c_Limpa,ukInsert,qryDefault);//-- Enviando ukInsert apenas para evitar erro
	lcbIdClienteGrupo.KeyValue := '1';
	incluindo := true;
end;

procedure TfrmProduto.mitSaveClick(Sender: TObject);
begin
	atualizarGrade := true;

	if (incluindo) then begin
		FunDB.registrar(TWinControl(scbEdit),ukInsert,qryDefault);
	end else begin
		FunDB.registrar(TWinControl(scbEdit),ukModify,qryDefault);
	end;
	
	incluindo := false;
end;

procedure TfrmProduto.edtNomeKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmProduto.mi1BuscaCodigoClick(Sender: TObject);
begin
	if (Sender = mitBuscaCodigo)or(Sender = mi1BuscaCodigo) then begin
		FindDialog1.FindText := 'Código';
		FindDialog1.Tag := 1;
	end;
	if (Sender = mitBuscaNome)or(Sender = mi1BuscaNome) then begin
		FindDialog1.FindText := 'Nome';
		FindDialog1.Tag := 2;
	end;
	FindDialog1.Execute;
end;

procedure TfrmProduto.tbtCancelarFiltrosClick(Sender: TObject);
var str: String;
begin
	str := '';
	if (Sender = tbtCancelarFiltros)or(Sender = mitCancelarFiltros) then begin
		qryDefault.ParamByName('BUSCANOME').AsString := '%';
		qryDefault.ParamByName('BUSCACODIGO').AsString := '%';
	end;
	if (Sender = FindDialog1)and(FindDialog1.Tag = 1) then begin
		qryDefault.ParamByName('BUSCACODIGO').AsString := '%'+FindDialog1.FindText+'%';
		qryDefault.ParamByName('BUSCANOME').AsString := '%';
		FindDialog1.CloseDialog;
	end;
	if (Sender = FindDialog1)and(FindDialog1.Tag = 2) then begin
		qryDefault.ParamByName('BUSCANOME').AsString := '%'+FindDialog1.FindText+'%';
		qryDefault.ParamByName('BUSCACODIGO').AsString := '%';
		FindDialog1.CloseDialog;
	end;
	FunDB.AtualizarQuery(qryDefault);
	FunDB.atualizarCampos(TWinControl(scbEdit),c_Carrega,ukInsert,qryDefault);//-- Enviando ukInsert apenas para evitar erro
end;

procedure TfrmProduto.tbtImprimirTodosClick(Sender: TObject);
var     mRelatorio     : Relatorio;
begin
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

procedure TfrmProduto.tbtFecharClick(Sender: TObject);
begin
	//-- Se a janela de busca estiver aberta, primeiro fecha ela, depois a janela
	if (FindDialog1.Handle <> 0) then FindDialog1.CloseDialog else Close();
end;

procedure TfrmProduto.btnEditClienteGrupoClick(Sender: TObject);
begin
	frmClienteGrupo.ShowModal();
end;

procedure TfrmProduto.btnEditProdutoGrupoClick(Sender: TObject);
begin
	frmProdutoGrupo.ShowModal();
end;

end.
//-----------------------------------------------------------------------------------------------
//   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM
//-----------------------------------------------------------------------------------------------

