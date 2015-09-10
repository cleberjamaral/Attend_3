{------------------------------------------------------------------------------------------------

				  O C E A N O   -    M A R    D E    S O L U Ç Õ E S

-------------------------------------------------------------------------------------------------
										  I N I C I O
-------------------------------------------------------------------------------------------------
Criação      : DD/MM/AAAA HH:MM
Local        : Escritório, Florianópolis
Autor(es)    : Nome do responsável
Descrição    : Breve descrição
Comentário   : Principais características
-------------------------------------------------------------------------------------------------
Atualização  : 08/11/2001 18:45:00
Autor(es)    : Iomani Engelmann Gomes
Comentário   : Inclusao do formulario no projeto Tele2
-------------------------------------------------------------------------------------------------}
unit UObservacao;
//-----------------------------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------------------------
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DB, DBTables, DBCtrls, Mask, Menus, UFunDB,
  Spin, Buttons;
//-----------------------------------------------------------------------------------------------
type
	TfrmObservacao = class(TForm)
		panCentral: TPanel;
		panParametros: TPanel;
		Label15: TLabel;
    labQuantidade: TLabel;
		Label14: TLabel;
		panPedaco4: TPanel;
		Label20: TLabel;
		Label24: TLabel;
		panPedaco3: TPanel;
		Label23: TLabel;
		Label19: TLabel;
		panPedaco2: TPanel;
		labPedaco1: TLabel;
		Label18: TLabel;
		panPedaco1: TPanel;
		Label21: TLabel;
		Label17: TLabel;
		Label2: TLabel;
		MainMenu1: TMainMenu;
		Item1: TMenuItem;
		mitSalvareFechar: TMenuItem;
		N1: TMenuItem;
		mitFechar: TMenuItem;
		qryTemporaria: TQuery;
		edtObs1: TEdit;
		edtObs2: TEdit;
		edtObs3: TEdit;
		edtObs4: TEdit;
		edtQtPedaco: TEdit;
		edtNome: TEdit;
		edtValorUnitario: TEdit;
		edtPedaco1: TEdit;
		edtPedaco2: TEdit;
		edtPedaco3: TEdit;
		edtPedaco4: TEdit;
    edtQuantidade: TSpinEdit;
    btnCancelar: TBitBtn;
    btnOK: TBitBtn;
		procedure FormShow(Sender: TObject);
		procedure mitFecharClick(Sender: TObject);
		procedure mitSalvareFecharClick(Sender: TObject);
		procedure FormCreate(Sender: TObject);
		procedure edtObs1KeyPress(Sender: TObject; var Key: Char);
    procedure edtQuantidadeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnOKClick(Sender: TObject);
	private
		{ Private declarations }
		FunDB: TFunDB;
		procedure configurarJanela();
	public
		{ Public declarations }
	end;
//-----------------------------------------------------------------------------------------------
var	frmObservacao: TfrmObservacao;
		OriginalHeight		: Integer;
//-----------------------------------------------------------------------------------------------
implementation {$R *.DFM}
//-----------------------------------------------------------------------------------------------
uses UTabTele, UPedido;
//-----------------------------------------------------------------------------------------------
procedure TfrmObservacao.FormShow(Sender: TObject);
var	idProduto2: Integer;
		idProduto3: Integer;
		idProduto4: Integer;
begin
	try
		FunDB.abrirQuery(
			qryTemporaria,
			'SELECT OBS1, OBS2, OBS3, OBS4, IDPEDACO1, IDPEDACO2, IDPEDACO3, IDPEDACO4, QTPEDACO, '+
			'QUANTIDADE, NOME, CAST(VALORUNITARIO AS NUMERIC(8,2)) AS VALORUNITARIO FROM PEDIDOMOVIMENTACAO '+
			'WHERE CONTADOR = '+IntToStr(FrmPedido.retornarContadorDePedidoMovimentacao())
		);
		edtObs1.Text := qryTemporaria.FieldByName('OBS1').AsString;
		edtObs2.Text := qryTemporaria.FieldByName('OBS2').AsString;
		edtObs3.Text := qryTemporaria.FieldByName('OBS3').AsString;
		edtObs4.Text := qryTemporaria.FieldByName('OBS4').AsString;
		edtQtPedaco.Text := qryTemporaria.FieldByName('QTPEDACO').AsString;
		edtNome.Text := qryTemporaria.FieldByName('NOME').AsString;
		edtQuantidade.Text := qryTemporaria.FieldByName('QUANTIDADE').AsString;
		edtValorUnitario.Text := qryTemporaria.FieldByName('VALORUNITARIO').AsString;
		idProduto2 := qryTemporaria.FieldByName('IDPEDACO2').AsInteger;
		idProduto3 := qryTemporaria.FieldByName('IDPEDACO3').AsInteger;
		idProduto4 := qryTemporaria.FieldByName('IDPEDACO4').AsInteger;

		FunDB.abrirQuery(qryTemporaria,'SELECT NOME FROM PRODUTO WHERE CONTADOR = '+qryTemporaria.FieldByName('IDPEDACO1').AsString);
		edtPedaco1.Text := qryTemporaria.FieldByName('NOME').AsString;
		FunDB.abrirQuery(qryTemporaria,'SELECT NOME FROM PRODUTO WHERE CONTADOR = '+IntToStr(idProduto2));
		edtPedaco2.Text := qryTemporaria.FieldByName('NOME').AsString;
		FunDB.abrirQuery(qryTemporaria,'SELECT NOME FROM PRODUTO WHERE CONTADOR = '+IntToStr(idProduto3));
		edtPedaco3.Text := qryTemporaria.FieldByName('NOME').AsString;
		FunDB.abrirQuery(qryTemporaria,'SELECT NOME FROM PRODUTO WHERE CONTADOR = '+IntToStr(idProduto4));
		edtPedaco4.Text := qryTemporaria.FieldByName('NOME').AsString;

		configurarJanela();
		if panPedaco1.Visible then edtObs1.SetFocus;
	except
		MessageDlg('Erro ao carregar campos!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmObservacao.mitFecharClick(Sender: TObject);
begin
  Close();
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmObservacao.mitSalvareFecharClick(Sender: TObject);
begin
	try
		FunDB.iniciarQuery(qryTemporaria);
		qryTemporaria.SQL.Add(
			'update PEDIDOMOVIMENTACAO set OBS1 = :OBS1, OBS2 = :OBS2, OBS3 = :OBS3, '+
			'OBS4 = :OBS4, QUANTIDADE = :QUANTIDADE where CONTADOR = :OLD_CONTADOR'
			);
		qryTemporaria.ParamByName('OLD_CONTADOR').AsInteger := FrmPedido.retornarContadorDePedidoMovimentacao();
		qryTemporaria.ParamByName('OBS1').AsString := edtObs1.Text;
		qryTemporaria.ParamByName('OBS2').AsString := edtObs2.Text;
		qryTemporaria.ParamByName('OBS3').AsString := edtObs3.Text;
		qryTemporaria.ParamByName('OBS4').AsString := edtObs4.Text;
		qryTemporaria.ParamByName('QUANTIDADE').AsString := edtQuantidade.Text;
		qryTemporaria.ExecSQL();
		FunDB.CommitDireto(FTabTele.DBCommerce);
		mitFechar.Click();
	except
		MessageDlg('Erro ao salvar Observações!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmObservacao.FormCreate(Sender: TObject);
begin
	OriginalHeight := Height;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmObservacao.configurarJanela();
begin
	try
		panPedaco4.Visible := false;
		panPedaco3.Visible := false;
		panPedaco2.Visible := false;
		panPedaco1.Visible := false;
		case StrToInt(edtQtPedaco.Text) of
			1:panPedaco1.Visible := true;
			2:begin
				panPedaco1.Visible := true;
				panPedaco2.Visible := true;
			end;
			3:begin
				panPedaco1.Visible := true;
				panPedaco2.Visible := true;
				panPedaco3.Visible := true;
			end;
			4:begin
				panPedaco1.Visible := true;
				panPedaco2.Visible := true;
				panPedaco3.Visible := true;
				panPedaco4.Visible := true;
			end;
		end;
//		if not (panPedaco1.Visible) then Height := OriginalHeight - panPedaco1.Height;
//		if not (panPedaco2.Visible) then Height := OriginalHeight - panPedaco1.Height*2;
//		if not (panPedaco3.Visible) then Height := OriginalHeight - panPedaco1.Height*3;
//		if not (panPedaco4.Visible) then Height := OriginalHeight - panPedaco1.Height*4;
	except
		MessageDlg('Erro ao configurar janela!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmObservacao.edtObs1KeyPress(Sender: TObject; var Key: Char);
begin
	try
		if Key = #13 then begin
			SelectNext(Sender as tWinControl, True, True );
			Key := #0;
//			if (Sender = edtObs1) and not (panPedaco2.Visible) then mitSalvareFechar.Click();
//			if (Sender = edtObs2) and not (panPedaco3.Visible) then mitSalvareFechar.Click();
//			if (Sender = edtObs3) and not (panPedaco4.Visible) then mitSalvareFechar.Click();
//			if (Sender = edtObs4) then mitSalvareFechar.Click();
		end;
	except
		MessageDlg('Erro ao focar próximo campo!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmObservacao.edtQuantidadeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
	if Key = VK_RETURN then begin
		SelectNext(Sender as tWinControl, True, True );
	end;
end;

procedure TfrmObservacao.btnOKClick(Sender: TObject);
begin
	mitSalvareFechar.Click();
end;

end.
//-----------------------------------------------------------------------------------------------
//   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM
//-----------------------------------------------------------------------------------------------

