{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

					  O C E A N O   -    M A R    S O L U Ç Õ E S

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
										  I N I C I O
= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
Criação      : 22/02/2000 11:06:17
Local        : Escritório, Florianópolis
Descrição    :
Comentário   :
= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
Data        :
Atualização :
= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}
unit UProdutoGrupoManipulacao;
//-----------------------------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------------------------
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables, Grids, DBGrids, Menus, Mask, ToolEdit, StdCtrls, ExtCtrls,
  Buttons, DBCtrls, CurrEdit, UTabTele, UFunDB, RXCtrls;
//-----------------------------------------------------------------------------------------------
type
  TfrmProdutoGrupoManipulacao = class(TForm)
	 MainMenu1: TMainMenu;
	 dscOrigem: TDataSource;
	 dscDestino: TDataSource;
	 Grupo1: TMenuItem;
	 CopiarProdutos1: TMenuItem;
	 MOculto: TMenuItem;
	 SMFocarCampoOrigem: TMenuItem;
	 SMFocarCampoDestino: TMenuItem;
    dbgOrigem: TDBGrid;
    dbgDestino: TDBGrid;
	 Label3: TLabel;
	 Label4: TLabel;
	 BtCopiarProdutos: TBitBtn;
	 gbOpcoes: TGroupBox;
	 gbValor: TGroupBox;
	 Label5: TLabel;
	 EPercent: TEdit;
	 CEValor: TCurrencyEdit;
	 gbCodigo: TGroupBox;
    labRotuloGrupo: TLabel;
	 lcbGrupoDestino: TDBLookupComboBox;
	 Label10: TLabel;
	 Label2: TLabel;
	 lcbGrupoOrigem: TDBLookupComboBox;
	 Label12: TLabel;
	 Label9: TLabel;
	 qryOrigem: TQuery;
	 qryDestino: TQuery;
	 btnRefresh: TBitBtn;
	 dscGrupoOrigem: TDataSource;
	 dscGrupoDestino: TDataSource;
	 qryTemp: TQuery;
    Label1: TLabel;
    lcbGrupoCliente: TDBLookupComboBox;
    dscGrupoCliente: TDataSource;
    mitFocarCampoGrupoCliente: TMenuItem;
    Label6: TLabel;
    Panel2: TPanel;
    rdbDecrescimo: TRadioButton;
    rdbAcrescimo: TRadioButton;
    rdbPercentual: TRadioButton;
    rdbValor: TRadioButton;
    rdgExiste: TRadioGroup;
    edtRotuloGrupo: TEdit;
    rbtInicio: TRadioButton;
    RadioButton1: TRadioButton;
	 procedure FormCreate(Sender: TObject);
	 procedure FormShow(Sender: TObject);
	 procedure BtCopiarProdutosClick(Sender: TObject);
	 procedure EPercentKeyPress(Sender: TObject; var Key: Char);
	 procedure SMFocarCampoOrigemClick(Sender: TObject);
	 procedure SMFocarCampoDestinoClick(Sender: TObject);
	 procedure btnRefreshClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mitFocarCampoGrupoClienteClick(Sender: TObject);
  private
	 { Private declarations }
	 FunDB: TFunDB;
  public
	 { Public declarations }
  end;
//-----------------------------------------------------------------------------------------------
var frmProdutoGrupoManipulacao: TfrmProdutoGrupoManipulacao;
//-----------------------------------------------------------------------------------------------
implementation {$R *.DFM}
//-----------------------------------------------------------------------------------------------
uses UFuncoes, UInicial;
//-----------------------------------------------------------------------------------------------
procedure TfrmProdutoGrupoManipulacao.FormCreate(Sender: TObject);
begin
	Caption := Application.Title+' - '+FTabTele.retornarVariavel('NomeEmpresa','Empresa')+' - Manipulação de Grupo de Produtos';
end;
//----------------------------------------------------------------------------------------------------------------
procedure TfrmProdutoGrupoManipulacao.FormShow(Sender: TObject);
begin
	try
		rdbValor.Checked := true;
		rdbAcrescimo.Checked := true;
		rdgExiste.ItemIndex := 0;
		lcbGrupoOrigem.SetFocus;
		lcbGrupoCliente.KeyValue := '1';
	except
		Inspetor('Erro ao abrir janela![40D]');
	end;
end;
//----------------------------------------------------------------------------------------------------------------
procedure TfrmProdutoGrupoManipulacao.BtCopiarProdutosClick(Sender: TObject);
var novoValor: real;
	 contador : Integer;
	 novoCodigo: String;
begin
	if (StrToInt(lcbGrupoDestino.KeyValue) < 1) or (StrToInt(lcbGrupoOrigem.KeyValue) < 1)  then begin
		MessageDlg('E necessário selecionar um grupo de origem e de destino!', mtWarning, [mbOk], 0);
		Exit;
	end;
	if not (qryOrigem.Active) then begin
		MessageDlg('É necessário abrir a tabela de origem!', mtWarning, [mbOk], 0);
		Exit;
	end;

	if not (
		MessageDlg('Os registros da tabela de origem serão inseridos'+#13+'na tabela de destino caso não exista um registro com mesmo nome.'+#13+'Confirma a operação?', mtWarning, [mbYes, mbNo], 0) = mrYes)
	then Exit;

//-- Inicio da copia
	FunDB.iniciarTransacao(FTabTele.DBCommerce);
	qryOrigem.First();
	while not qryOrigem.Eof do begin
		//-- Decide como será feito com campo valor
		if (rdbAcrescimo.Checked) then begin
			if (rdbValor.Checked) then
				novoValor := qryOrigem.FieldByName('Valor').AsFloat + CEValor.Value
			else
				novoValor := qryOrigem.FieldByName('Valor').AsFloat + (qryOrigem.FieldByName('Valor').AsFloat*StrToInt(EPercent.Text)/100);
		end else begin
			if (rdbValor.Checked) then
				novoValor := qryOrigem.FieldByName('Valor').AsFloat - CEValor.Value
			else
				novoValor := qryOrigem.FieldByName('Valor').AsFloat - (qryOrigem.FieldByName('Valor').AsFloat*StrToInt(EPercent.Text)/100);
		end;

		//-- Se não existe produto com este nome
		FunDB.iniciarQuery(qryTemp);

		qryTemp.SQL.Add(
			'SELECT CONTADOR FROM PRODUTO WHERE NOME = :NOME AND IDCLIENTEGRUPO = :CLIENTEGRUPO '+
			'AND IDPRODUTOGRUPO = :PRODUTOGRUPO '
		);
		qryTemp.ParamByName('NOME').AsString := qryOrigem.FieldByName('NOME').AsString;
		qryTemp.ParamByName('CLIENTEGRUPO').AsInteger := qryOrigem.FieldByName('IDCLIENTEGRUPO').AsInteger;
		qryTemp.ParamByName('PRODUTOGRUPO').AsInteger :=lcbGrupoDestino.KeyValue;
		qryTemp.Open();

		contador := qryTemp.FieldByName('CONTADOR').AsInteger;
		if (qryTemp.Bof = qryTemp.Eof) then begin //-- Se não há registro, cria
			FunDB.iniciarQuery(qryTemp);
			qryTemp.SQL.Add(
				'INSERT INTO PRODUTO '+
				'(CONTADOR,IDPRODUTOGRUPO,IDCLIENTEGRUPO,CODIGO,NOME,INGREDIENTES,ABREVIACAO,VALOR) '+
				'VALUES '+
				'(:CONTADOR,:IDPRODUTOGRUPO,:IDCLIENTEGRUPO,:CODIGO,:NOME,:INGREDIENTES,:ABREVIACAO,:VALOR) '
			);
			qryTemp.ParamByName('CONTADOR').AsInteger := FTabTele.buscarMaxContadorDBTele('PRODUTO');
			qryTemp.ParamByName('IDPRODUTOGRUPO').AsInteger := lcbGrupoDestino.KeyValue;
			qryTemp.ParamByName('IDCLIENTEGRUPO').AsInteger := qryOrigem.FieldByName('IDCLIENTEGRUPO').AsInteger;

			//-- Compor o código
			if (rbtInicio.Checked) then begin
				novoCodigo :=
					edtRotuloGrupo.Text+
					Copy(qryOrigem.FieldByName('CODIGO').AsString,2,Length(qryOrigem.FieldByName('CODIGO').AsString)-1);
			end else begin
				novoCodigo :=
					Copy(qryOrigem.FieldByName('CODIGO').AsString,1,Length(qryOrigem.FieldByName('CODIGO').AsString)-1)+
					edtRotuloGrupo.Text;
			end;
//			novoCodigo := qryOrigem.FieldByName('CODIGO').AsString;
			qryTemp.ParamByName('CODIGO').AsString := novoCodigo;
//			qryTemp.ParamByName('CODIGO').AsString := qryOrigem.FieldByName('CODIGO').AsString;

			qryTemp.ParamByName('NOME').AsString := qryOrigem.FieldByName('NOME').AsString;
			qryTemp.ParamByName('INGREDIENTES').AsString := qryOrigem.FieldByName('INGREDIENTES').AsString;
			qryTemp.ParamByName('ABREVIACAO').AsString := qryOrigem.FieldByName('ABREVIACAO').AsString;
			qryTemp.ParamByName('VALOR').AsFloat := novoValor;
			qryTemp.ExecSQL();
		end else begin
			if (
				(rdgExiste.ItemIndex = 1) and (MessageDlg('Deseja alterar o valor de'+#13+qryOrigem.FieldByName('NOME').AsString+'?', mtWarning, [mbYes, mbNo], 0) = mrYes)
				) or (rdgExiste.ItemIndex = 2) then
			begin
				FunDB.iniciarQuery(qryTemp);
				qryTemp.SQL.Add(
					'UPDATE PRODUTO '+
					'SET VALOR = :VALOR '+
					'WHERE CONTADOR = :CONTADOR'
				);
				qryTemp.ParamByName('VALOR').AsFloat := novoValor;
				qryTemp.ParamByName('CONTADOR').AsInteger := contador;
				qryTemp.ExecSQL();
			end;
		end;
		qryOrigem.Next();
	end;
	FunDB.finalizarTransacao(FTabTele.DBCommerce);
	btnRefresh.Click();
end;
//----------------------------------------------------------------------------------------------------------------
procedure TfrmProdutoGrupoManipulacao.EPercentKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in['0'..'9',#8,#13]) then key:=#0;
end;
//----------------------------------------------------------------------------------------------------------------
procedure TfrmProdutoGrupoManipulacao.SMFocarCampoOrigemClick(Sender: TObject);
begin
  lcbGrupoOrigem.SetFocus;
end;
//----------------------------------------------------------------------------------------------------------------
procedure TfrmProdutoGrupoManipulacao.SMFocarCampoDestinoClick(Sender: TObject);
begin
  lcbGrupoDestino.SetFocus;
end;
//----------------------------------------------------------------------------------------------------------------
procedure TfrmProdutoGrupoManipulacao.btnRefreshClick(Sender: TObject);
begin
	if (VarType(lcbGrupoOrigem.KeyValue) = varNull) or
		(VarType(lcbGrupoCliente.KeyValue) = varNull) or
		(VarType(lcbGrupoDestino.KeyValue) = varNull) then
	begin
		MessageDlg('É necessários preencher campos de grupo.', mtInformation, [mbOk], 0);
		Exit;
	end;

	//-- Abre tabela de Origem para consulta
	qryOrigem.Close();
	qryOrigem.SQL.Clear();
	qryOrigem.SQL.Add(
		'SELECT '+
		'	NOME, '+
		'	CAST(PRODUTO.VALOR AS NUMERIC(8,2)) AS VALOR, '+
		'	CODIGO, '+
		'  IDCLIENTEGRUPO, '+
		'  INGREDIENTES, '+
		'	ABREVIACAO '+
		'FROM '+
		'	PRODUTO '+
		'WHERE '+
		'  IDPRODUTOGRUPO = :IDGRUPO '+
		'AND '+
		'  IDCLIENTEGRUPO = :IDGRUPOCLIENTE '+
		'ORDER BY CODIGO ASC'
	);
	qryOrigem.ParamByName('IDGRUPO').AsString := lcbGrupoOrigem.KeyValue;
	qryOrigem.ParamByName('IDGRUPOCLIENTE').AsString := lcbGrupoCliente.KeyValue;
	qryOrigem.Open();

	//-- Abre tabela de Origem para consulta
	qryDestino.Close();
	qryDestino.SQL.Clear();
	qryDestino.SQL.Add(
		'SELECT '+
		'	NOME, '+
		'	CAST(PRODUTO.VALOR AS NUMERIC(8,2)) AS VALOR, '+
		'	CODIGO, '+
		'	ABREVIACAO '+
		'FROM '+
		'	PRODUTO '+
		'WHERE '+
		'  IDPRODUTOGRUPO = :IDGRUPO '+
		'AND '+
		'  IDCLIENTEGRUPO = :IDGRUPOCLIENTE '+
		'ORDER BY CODIGO ASC'
	);
	qryDestino.ParamByName('IDGRUPO').AsString := lcbGrupoDestino.KeyValue;
	qryDestino.ParamByName('IDGRUPOCLIENTE').AsString := lcbGrupoCliente.KeyValue;
	qryDestino.Open();
end;
//----------------------------------------------------------------------------------------------------------------
procedure TfrmProdutoGrupoManipulacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Release();
end;
//----------------------------------------------------------------------------------------------------------------
procedure TfrmProdutoGrupoManipulacao.mitFocarCampoGrupoClienteClick(Sender: TObject);
begin
	lcbGrupoCliente.SetFocus;
end;
//----------------------------------------------------------------------------------------------------------------
end.
//----------------------------------------------------------------------------------------------------------------





