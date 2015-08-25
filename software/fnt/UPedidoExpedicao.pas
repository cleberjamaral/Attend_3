{------------------------------------------------------------------------------------------------

				  O C E A N O   -    M A R    D E    S O L U Ç Õ E S

-------------------------------------------------------------------------------------------------
										  I N I C I O
-------------------------------------------------------------------------------------------------
Criação      : 11/10/2001 02:00:00
Local        : Escritório, Florianópolis
Autor(es)    : Cleber J. Amaral
Descrição    : Cadastro de expedição
Comentário   : Controle das expediçoes por entregador
-------------------------------------------------------------------------------------------------
Atualização  : 22/10/2001 15:45
Autor(es)    : Iomani Engelmann Gomes
Comentário   : Rotina de volta de expediçao e cadastro de items de expedicao
------------------------------------------------------------------------------------------------}
unit UPedidoExpedicao;
//-----------------------------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------------------------
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, Menus, Mask, ToolEdit, StdCtrls, ExtCtrls,
  Grids, DBGrids, DBTables, DB, Buttons, ComCtrls, UFunGeral, UFunDB;
//-----------------------------------------------------------------------------------------------
type
  TfrmPedidoExpedicao = class(TForm)
    PLogo: TPanel;
    PCampos: TPanel;
    MainMenu1: TMainMenu;
    MExpedicao: TMenuItem;
    qryPedidoNaoExpedido: TQuery;
    MOculto: TMenuItem;
    SMGradedepedidos: TMenuItem;
    dsqPedidoNaoExpedido: TDataSource;
    Panel4: TPanel;
    LPedido: TLabel;
    Panel9: TPanel;
    Label12: TLabel;
    Fechar1: TMenuItem;
    sm1ComissaodoEntregador: TMenuItem;
    dbgPedido: TDBGrid;
    lcbEntregador: TDBLookupComboBox;
    Panel1: TPanel;
    dbgPedidoDoEntregador: TDBGrid;
	 Panel7: TPanel;
    LPedidoExpedido: TLabel;
    qryEntregador: TQuery;
    dsqEntregador: TDataSource;
    qryPedidoDoEntregador: TQuery;
    dsqPedidoDoEntregador: TDataSource;
    dtpData: TDateTimePicker;
    PopupMenu1: TPopupMenu;
    mitLancar: TMenuItem;
    qryTemporaria: TQuery;
    PopupMenu2: TPopupMenu;
    mitVoltar: TMenuItem;
    edtPesquisaPedido: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
	 procedure dblcEntregadorKeyPress(Sender: TObject; var Key: Char);
	 procedure FormClose(Sender: TObject; var Action: TCloseAction);
	 procedure Fechar1Click(Sender: TObject);
    procedure sm1ComissaodoEntregadorClick(Sender: TObject);
    procedure lcbEntregadorClick(Sender: TObject);
    procedure mitLancarClick(Sender: TObject);
  private
	 { Private declarations }
  protected
	 { Protected declarations }
	 contadorExpedicao : integer;
	 FunDB: TFunDB;
	 FunGeral: TFunGeral;
  public
	 { Public declarations }
	 //--Procedimentos
	 //--Faz a pesquisa para mostrar as expediçoes por entregador selecionado
	 procedure mostrarExpedicoesEntregador();
	 procedure lancarExpedicao(p_Contador: Integer);
  end;
//-----------------------------------------------------------------------------------------------
var frmPedidoExpedicao: TfrmPedidoExpedicao;
//-----------------------------------------------------------------------------------------------
implementation {$R *.DFM}
//-----------------------------------------------------------------------------------------------
uses UTabTele, UFuncoes, UInicial;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoExpedicao.FormCreate(Sender: TObject);
begin
  Caption := Application.Title+' - '+FTabTele.retornarVariavel('NomeEmpresa','Empresa')+' - Controle do expedição';
end;

procedure TfrmPedidoExpedicao.FormShow(Sender: TObject);
begin
	enquadraJanela(self);
	if not (qryPedidoNaoExpedido.Active) then qryPedidoNaoExpedido.Open();
	if not (qryEntregador.Active) then qryEntregador.Open();
	mostrarExpedicoesEntregador();
	if (Time() < StrToTime(FTabTele.retornarVariavel('HoraVirada','04:00'))) then dtpData.Date := Date()-1 else dtpData.Date := Date();
end;

procedure TfrmPedidoExpedicao.dblcEntregadorKeyPress(Sender: TObject; var Key: Char);
var	sql : string;
		hoje : TDateTime;
begin
	try
		if lcbEntregador.KeyValue <> NULL then begin
			if Key = #13 then begin
				//-- Se já passou da meia noite assume a data atual como "Ontem"
				//-- pois todas as rotinas levam em consideração a hora de virada              
				if (Time() < StrToTime(FTabTele.retornarVariavel('HoraVirada','04:00'))) then hoje := Date()-1 else hoje := Date();
				//-- Caso o número do pedido seja digitado por completo (ex.: 027/10, não precisa de tratamento
				//-- Porém, também pode ser digitado apenas o contador que varia de 1 a 999
				case (Length(edtPesquisaPedido.Text)) of
					1: edtPesquisaPedido.Text := '00'+edtPesquisaPedido.Text+'/'+Copy(DateToStr(hoje),1,2);
					2: edtPesquisaPedido.Text := '0'+edtPesquisaPedido.Text+'/'+Copy(DateToStr(hoje),1,2);
					3: edtPesquisaPedido.Text := edtPesquisaPedido.Text+'/'+Copy(DateToStr(hoje),1,2);
				end;
				//-- Consulta se o número digitado corresponde a um pedido válido e não entregue
				sql:= (
					'SELECT '+
					'  PEDIDO.CONTADOR '+
					'FROM '+
					'  PEDIDO '+
					'WHERE '+
					'  PEDIDO.NUMEROPEDIDO = '+FunGeral.retornarStringSQL(edtPesquisaPedido.Text)+' '+
					'AND '+
					'  PEDIDO.IDENTREGADOR = -1 '
				);
				abrirQuery(qryPedidoDoEntregador,sql);
				if (qryPedidoDoEntregador.RecordCount = 1) then begin
					lancarExpedicao(qryPedidoDoEntregador.FieldByName('CONTADOR').AsInteger);
					edtPesquisaPedido.Clear();
				end;
				if (qryPedidoDoEntregador.RecordCount > 1) then MessageDlg('Há mais de um pedido com este código, operação cancelada!', mtInformation, [mbOk], 0);
				if (qryPedidoDoEntregador.RecordCount < 1) then MessageDlg('Pedido não encontrado!', mtInformation, [mbOk], 0);
				FunDB.atualizarQuery(qryPedidoNaoExpedido);
				mostrarExpedicoesEntregador();
			end;
		end;
	except
		MessageDlg('Erro ao focar próximo campo!', mtError, [mbOk], 0);
	end;
end;

procedure TfrmPedidoExpedicao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release();
end;

procedure TfrmPedidoExpedicao.mostrarExpedicoesEntregador();
var sql : string;
begin
	if lcbEntregador.KeyValue <> NULL then begin
		sql:= (
			'SELECT '+
			'  PEDIDO.CONTADOR,  '+
			'  PEDIDO.NUMEROPEDIDO,  '+
			'  PEDIDO.DATAPEDIDO,  '+
			'  PEDIDO.DATAENTREGA,  '+
			'  CLIENTE.NOME AS NOMECLIENTE '+
			'FROM '+
			'  PEDIDO, '+
			'  CLIENTE  '+
			'WHERE '+
			'  PEDIDO.IDENTREGADOR = '+FunGeral.retornarStringSQL(lcbEntregador.KeyValue)+' '+
			'AND '+
			'  CLIENTE.CONTADOR = PEDIDO.IDCLIENTE '+
			'AND '+
			FunGeral.fazerPeriodo('DATAENTREGA',FTabTele.retornarVariavel('HoraVirada','04:00'),dtpData.Date,dtpData.Date)
		);
		abrirQuery(qryPedidoDoEntregador,sql);
	end;
end;

procedure TfrmPedidoExpedicao.Fechar1Click(Sender: TObject);
begin
  Close();
end;

procedure TfrmPedidoExpedicao.sm1ComissaodoEntregadorClick(Sender: TObject);
begin
  FInicial.chamarRelatorioComissaoDoEntregador(StrToInt(lcbEntregador.KeyValue));
end;

procedure TfrmPedidoExpedicao.lcbEntregadorClick(Sender: TObject);
begin
	mostrarExpedicoesEntregador();
end;

procedure TfrmPedidoExpedicao.mitLancarClick(Sender: TObject);
var	i : integer;
		str : string;
begin
	if lcbEntregador.KeyValue <> NULL then begin
		if (Sender = mitLancar) then begin
			for i := 0 to dbgPedido.SelectedRows.Count-1 do begin
				dbgPedido.DataSource.DataSet.GotoBookmark(pointer(dbgPedido.SelectedRows.Items[i]));
				lancarExpedicao(qryPedidoNaoExpedido.FieldByName('CONTADOR').AsInteger);
			end;
		end;
		if (Sender = mitVoltar) then begin
			if (mostrarJaneladeAcesso(
				'',
				FTabTele.retornarVariavel('acessoUsuario01','Gerente'),
				FTabTele.retornarSenhaDecriptografada(FTabTele.retornarVariavel('acessoSenha01',FTabTele.retornarVarSenhaCriptPadrao()))
			)) then begin
				FunDB.executarQuery(qryTemporaria,'UPDATE PEDIDO SET IDENTREGADOR = -1 WHERE CONTADOR = '+qryPedidoDoEntregador.FieldByName('CONTADOR').AsString);
			end;
		end;
	end;
	FunDB.atualizarQuery(qryPedidoNaoExpedido);
	mostrarExpedicoesEntregador();
end;

procedure TfrmPedidoExpedicao.lancarExpedicao(p_Contador: Integer);
begin
	FunDB.iniciarQuery(qryTemporaria);
	qryTemporaria.SQL.Add('UPDATE PEDIDO SET IDENTREGADOR = :ENTREGADOR, DATAENTREGA = :DATA WHERE CONTADOR = :CONTADOR');
	qryTemporaria.ParamByName('ENTREGADOR').AsInteger 	:= lcbEntregador.KeyValue;
	if (Time() < StrToTime(FTabTele.retornarVariavel('HoraVirada','04:00'))) then begin
		qryTemporaria.ParamByName('DATA').AsDateTime 		:= dtpData.Date+1+Time();
	end else begin
		qryTemporaria.ParamByName('DATA').AsDateTime 		:= dtpData.Date+Time();
	end;
	qryTemporaria.ParamByName('CONTADOR').AsInteger 	:= p_Contador;
	qryTemporaria.ExecSQL;
end;

end.
//-----------------------------------------------------------------------------------------------
//   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM
//-----------------------------------------------------------------------------------------------

