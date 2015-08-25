unit UProdutoGrupo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, ComCtrls, ToolWin, Db, DBTables, ImgList, Menus,
  UFunDB, UFunGeral;

type
  TfrmProdutoGrupo = class(TForm)
    MainMenu1: TMainMenu;
    mitCliente: TMenuItem;
    mitNew: TMenuItem;
    N2: TMenuItem;
    mitSave: TMenuItem;
    mitDelete: TMenuItem;
    N1: TMenuItem;
    mitRefresh: TMenuItem;
    N5: TMenuItem;
    mitFechar: TMenuItem;
	 ImageList1: TImageList;
    dsqDefault: TDataSource;
    qryTemporaria: TQuery;
    FindDialog1: TFindDialog;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    btnNew: TToolButton;
    ToolButton3: TToolButton;
    btnSave: TToolButton;
    tbtDelete: TToolButton;
    ToolButton2: TToolButton;
    btnRefresh: TToolButton;
    ToolButton6: TToolButton;
    tbtFechar: TToolButton;
    pgcFile: TPageControl;
    tshConsult: TTabSheet;
    dbgProduto: TDBGrid;
    tshEdit: TTabSheet;
    scbEdit: TScrollBox;
    labNome: TLabel;
	 edtNome: TEdit;
    edtPontuacao: TEdit;
    lanPontuacao: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure mitDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgProdutoDblClick(Sender: TObject);
    procedure mitRefreshClick(Sender: TObject);
    procedure mitNewClick(Sender: TObject);
    procedure mitSaveClick(Sender: TObject);
    procedure edtNomeKeyPress(Sender: TObject; var Key: Char);
    procedure mitFecharClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
	 { Private declarations }
		FunDB: TFunDB;
		FunGeral: TFunGeral;
  public
	 { Public declarations }
  end;

var
  frmProdutoGrupo: TfrmProdutoGrupo;
//-- Variaveis
		incluindo: bool;
		alterandoDePedidos: bool;
		const c_Limpa =	0;
		const c_Grava =	1;
		const c_Carrega =	2;
		var qryDefault: TQuery;

implementation

uses UTabTele;

{$R *.DFM}

procedure TfrmProdutoGrupo.FormCreate(Sender: TObject);
begin
	FunDB := TFunDB.criarInstancia();
	qryDefault := TQuery(dsqDefault.DataSet);
	if not (qryDefault.Active) then qryDefault.Open();
	qryTemporaria.DatabaseName := qryDefault.DatabaseName;
	Self.Caption := Copy(qryDefault.Name,4,Length(qryDefault.Name)-1);
//	Self.Caption := FTabTele.retParamIndexStr(Copy(Self.Name,4,Length(Self.Name)));
end;

procedure TfrmProdutoGrupo.mitDeleteClick(Sender: TObject);
begin
	if (MessageDlg('Deseja excluir o registro?', mtWarning, [mbYes, mbNo], 0) = mrYes) then begin
		FunDB.registrar(TWinControl(scbEdit),ukDelete,qryDefault);
	end;
end;

procedure TfrmProdutoGrupo.FormShow(Sender: TObject);
begin
//	mitFirstClick(mitFirst);
	pgcFile.ActivePage := tshConsult;
	FTabTele.escreverTextos(Self);
end;

procedure TfrmProdutoGrupo.dbgProdutoDblClick(Sender: TObject);
begin
	pgcFile.ActivePage := tshEdit;
	FunDB.atualizarCampos(TWinControl(scbEdit),c_Carrega,ukInsert,qryDefault);//-- Enviando ukInsert apenas para evitar erro
end;

procedure TfrmProdutoGrupo.mitRefreshClick(Sender: TObject);
begin
	FunDB.executarRefresh(TWinControl(scbEdit),qryDefault);
end;

procedure TfrmProdutoGrupo.mitNewClick(Sender: TObject);
begin
	pgcFile.ActivePage := tshEdit;
	FunDB.atualizarCampos(TWinControl(scbEdit),c_Limpa,ukInsert,qryDefault);//-- Enviando ukInsert apenas para evitar erro

	edtNome.SetFocus();
	incluindo := true;
end;

procedure TfrmProdutoGrupo.mitSaveClick(Sender: TObject);
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

procedure TfrmProdutoGrupo.edtNomeKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmProdutoGrupo.mitFecharClick(Sender: TObject);
begin
	//-- Se a janela de busca estiver aberta, primeiro fecha ela, depois a janela
	if (FindDialog1.Handle <> 0) then FindDialog1.CloseDialog else Close();
end;

procedure TfrmProdutoGrupo.FormDestroy(Sender: TObject);
begin
	FunDB.destruirInstancia();
	Release();// Quando usado Free ocorre access violation ao retornar para pedidos
end;

end.
