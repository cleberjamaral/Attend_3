unit UClienteGrupoManipulacao;
//----------------------------------------------------------------------------------------------------------------
interface
//----------------------------------------------------------------------------------------------------------------
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables, Mask, ToolEdit, StdCtrls, Grids, DBGrids, ExtCtrls,
  Menus, CurrEdit, DBCtrls, UFunDB, Buttons;
//----------------------------------------------------------------------------------------------------------------
type
	TfrmClienteGrupoManipulacao = class(TForm)
		MainMenu1: TMainMenu;
		Grupo1: TMenuItem;
		CopiarProdutos1: TMenuItem;
		MOculto: TMenuItem;
		SMFocarCampoOrigem: TMenuItem;
		SMFocarCampoDestino: TMenuItem;
		Label3: TLabel;
		Label4: TLabel;
		Label10: TLabel;
		Label2: TLabel;
		Label12: TLabel;
		Label9: TLabel;
		dbgOrigem: TDBGrid;
		dbgDestino: TDBGrid;
		BtCopiarProdutos: TBitBtn;
		gbOpcoes: TGroupBox;
		gbValor: TGroupBox;
		Label5: TLabel;
		EPercent: TEdit;
		CEValor: TCurrencyEdit;
		gbCodigo: TGroupBox;
		labExemplo: TLabel;
		meCodigo: TMaskEdit;
		lcbGrupoDestino: TDBLookupComboBox;
		lcbGrupoOrigem: TDBLookupComboBox;
		btnRefresh: TBitBtn;
		dscOrigem: TDataSource;
		dscDestino: TDataSource;
		qryOrigem: TQuery;
		qryDestino: TQuery;
		dscGrupoOrigem: TDataSource;
		dscGrupoDestino: TDataSource;
		qryTemp: TQuery;
		rdbPercentual: TRadioButton;
		rdbValor: TRadioButton;
		Panel2: TPanel;
		rdbDecrescimo: TRadioButton;
		rdbAcrescimo: TRadioButton;
		rdgExiste: TRadioGroup;
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		procedure FormCreate(Sender: TObject);
		procedure FormShow(Sender: TObject);
		procedure btnRefreshClick(Sender: TObject);
		procedure BtCopiarProdutosClick(Sender: TObject);
	private
		{ Private declarations }
		FunDB: TFunDB;
	public
		{ Public declarations }
	end;
//----------------------------------------------------------------------------------------------------------------
var frmClienteGrupoManipulacao: TfrmClienteGrupoManipulacao;
//----------------------------------------------------------------------------------------------------------------
implementation {$R *.DFM}
//----------------------------------------------------------------------------------------------------------------
uses UTabTele, UFuncoes;
//----------------------------------------------------------------------------------------------------------------
procedure TfrmClienteGrupoManipulacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
	Self.Release();
end;
//----------------------------------------------------------------------------------------------------------------
procedure TfrmClienteGrupoManipulacao.FormCreate(Sender: TObject);
begin
	Self.Caption := Application.Title+' - '+FTabTele.retornarVariavel('NomeEmpresa','Empresa')+' - Manipulação de Grupo de Clientes';
end;
//----------------------------------------------------------------------------------------------------------------
procedure TfrmClienteGrupoManipulacao.FormShow(Sender: TObject);
begin
	rdbValor.Checked := true;
	rdbAcrescimo.Checked := true;
	rdgExiste.ItemIndex := 0;
	lcbGrupoOrigem.SetFocus();
end;
//----------------------------------------------------------------------------------------------------------------
procedure TfrmClienteGrupoManipulacao.btnRefreshClick(Sender: TObject);
begin
	if (VarType(lcbGrupoOrigem.KeyValue) = varNull) or
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
		'  IDPRODUTOGRUPO, '+
		'  INGREDIENTES, '+
		'	ABREVIACAO '+
		'FROM '+
		'	PRODUTO '+
		'WHERE '+
		'  IDCLIENTEGRUPO = :IDGRUPO '+
		'ORDER BY CODIGO ASC'
	);
	qryOrigem.ParamByName('IDGRUPO').AsString := lcbGrupoOrigem.KeyValue;
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
		'  IDCLIENTEGRUPO = :IDGRUPO '+
		'ORDER BY CODIGO ASC'
	);
	qryDestino.ParamByName('IDGRUPO').AsString := lcbGrupoDestino.KeyValue;
	qryDestino.Open();
end;
//----------------------------------------------------------------------------------------------------------------
procedure TfrmClienteGrupoManipulacao.BtCopiarProdutosClick(Sender: TObject);
var novoValor: real;
	 contador : Integer;
begin
	btnRefresh.Click();

	if (StrToInt(lcbGrupoDestino.KeyValue) < 1) or (StrToInt(lcbGrupoOrigem.KeyValue) < 1)  then begin
		MessageDlg('E necessário selecionar um grupo de origem e de destino!', mtWarning, [mbOk], 0);
		Exit;
	end;

	if not (qryOrigem.Active) then begin
		MessageDlg('É necessário abrir a tabela de origem!', mtWarning, [mbOk], 0);
		Exit;
	end;

	if not (
		MessageDlg(
			'Os registros da tabela de origem serão inseridos'+#13+
			'na tabela de destino caso não exista um registro com mesmo nome.'+#13+
			'Confirma a operação?', mtWarning, [mbYes, mbNo], 0) = mrYes)
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
		qryTemp.ParamByName('CLIENTEGRUPO').AsInteger := lcbGrupoDestino.KeyValue;
		qryTemp.ParamByName('PRODUTOGRUPO').AsInteger := qryOrigem.FieldByName('IDPRODUTOGRUPO').AsInteger;
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
			qryTemp.ParamByName('IDPRODUTOGRUPO').AsInteger := qryOrigem.FieldByName('IDPRODUTOGRUPO').AsInteger;
			qryTemp.ParamByName('IDCLIENTEGRUPO').AsInteger :=lcbGrupoDestino.KeyValue;
			qryTemp.ParamByName('CODIGO').AsString := qryOrigem.FieldByName('CODIGO').AsString;
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
end.
//----------------------------------------------------------------------------------------------------------------
//   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM
//----------------------------------------------------------------------------------------------------------------
