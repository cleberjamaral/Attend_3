{------------------------------------------------------------------------------------------------

				  O C E A N O   -    M A R    D E    S O L U Ç Õ E S

-------------------------------------------------------------------------------------------------
										  I N I C I O
-------------------------------------------------------------------------------------------------
Criação      : 22/02/2000 11:06:17
Local        : Escritório, Florianópolis
Autor(es)    : Cleber J. Amaral,
					Iomani Engelmann Gomes
Descrição    : Formulario inicial da aplicação
Comentário   :
-------------------------------------------------------------------------------------------------
Atualização  : 24/10/2001 14:45:00
Autor(es)    : Iomani Engelmann Gomes
Comentário   : Funcoes em sql para pesquisar dados do cliente
------------------------------------------------------------------------------------------------}
unit UPedidoUltimo;
//-----------------------------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------------------------
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, DB, DBTables, StdCtrls, ExtCtrls,
  Mask, ToolEdit, Buttons, ComCtrls, CurrEdit, Menus, UImpPedi, UFunDB, UFunGeral, UTabTele;
//-----------------------------------------------------------------------------------------------
type
  TfrmPedidoUltimo = class(TForm)
	 panItensPedido: TPanel;
	 PD: TPrintDialog;
    MainMenu1: TMainMenu;
    MUltimoPedido: TMenuItem;
    SMCopiarPedido: TMenuItem;
    SMImprimirPedido: TMenuItem;
    dsItePedi: TDataSource;
    SMPedidoAnterior: TMenuItem;
    SMProximoPedido: TMenuItem;
    SMExcluirPedido: TMenuItem;
	 DBGrid2: TDBGrid;
    MFechar: TMenuItem;
    panBotoes: TPanel;
	 panDadosPedido: TPanel;
    labAtendente: TLabel;
    edtVendedor: TEdit;
    labAcrescimo: TLabel;
    labTaxaDeEntrega: TLabel;
    labVlPago: TLabel;
    labVlTotal: TLabel;
	 LabHoraPrevisao: TLabel;
    edtObs: TEdit;
    labObs: TLabel;
    edtDias: TEdit;
    edtForma: TEdit;
    labFormaPagamento: TLabel;
	 panCliente: TPanel;
    labNome: TLabel;
    edtNome: TEdit;
    edtTelefone: TEdit;
    labCodigo: TLabel;
    labDataPedido: TLabel;
    Label3: TLabel;
	 Fechar1: TMenuItem;
	 btnCopiar: TBitBtn;
    btnImprimir: TBitBtn;
    btnExcluir: TBitBtn;
    edtDataPedido: TDateTimePicker;
    edtAcrescimo: TEdit;
    edtTaxaDeEntrega: TEdit;
    edtVlPago: TEdit;
	 edtVlTotal: TEdit;
	 edtHoraPedido: TDateTimePicker;
	 edtHoraPrevista: TDateTimePicker;
    qryItePedi: TQuery;
    qryTemp: TQuery;
    edtNumeroPedido: TEdit;
    labNumeroPedido: TLabel;
	 procedure FormShow(Sender: TObject);
	 procedure BtCopiarClick(Sender: TObject);
	 procedure BtImprimirClick(Sender: TObject);
	 procedure ImprimeRel40Colunas;
	 procedure BtAnteriorClick(Sender: TObject);
	 procedure BtProximoClick(Sender: TObject);
	 procedure BtExcluirClick(Sender: TObject);
	 procedure FormClose(Sender: TObject; var Action: TCloseAction);
	 procedure Fechar1Click(Sender: TObject);
	 procedure FormCreate(Sender: TObject);
  private
	 { Private declarations }
	 NOMEEMPRESA : String;
	 CAMPOCODIGOCLIENTE : String;
	 PEDIRSENHAAOREIMPRIMIR : Bool;
	 ACESSOUSUARIO01 : String;
	 ACESSOSENHA01 : STring;
	 RELLINHA1 : String;
	 RELLINHA2 : String;
	 RELLINHA3 : STring;
	 IMPRIMEVLITEM : Bool;
	 USAVENDEDOR : Bool;
	 MSGREL : String;
	 CONTROLABRINDE : Bool;
  protected
	  { Protected declarations }
		FunDB: TFunDB;
		FunGeral: TFunGeral;
		nrCdPedidos,
		contadorCdPedidos : integer;
		listaDeCdPedidos  : TStringList;
		DtPedido,
		HrPedido          : TDateTime;
		idCliente			: integer;
  public
	 { Public declarations }
	 procedure pesquisarDadosDoCliente;
	 procedure pesquisarCodigoPedidos;
	 procedure pesquisarItemsPedido(qualCdPedido:string);
	 procedure alterarIdCliente(p_IdCliente: integer);
  end;
//-----------------------------------------------------------------------------------------------
var
  frmPedidoUltimo: TfrmPedidoUltimo;
//-----------------------------------------------------------------------------------------------
implementation

uses UPedido; {$R *.DFM}
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoUltimo.FormShow(Sender: TObject);
begin
  Caption := Application.Title+' - '+NOMEEMPRESA+' - Último pedido do cliente';
  listaDeCdPedidos := TStringList.Create;
  pesquisarDadosDoCliente;
  pesquisarCodigoPedidos;
  if (nrCdPedidos>0) then begin
    pesquisarItemsPedido(listaDeCdPedidos.Strings[contadorCdPedidos-1])
  end
  else begin
    MessageDlg('Cliente não possui pedidos gravados! Esta janela será fechada.', mtInformation, [mbOk], 0);
    Close();
  end;
  labCodigo.Caption := CAMPOCODIGOCLIENTE;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoUltimo.BtCopiarClick(Sender: TObject);
var cdProduto1 : string;
	 cdProduto2 : string;
	 cdProduto3 : string;
	 obsProduto1: string;
	 obsProduto2: string;
	 obsProduto3: string;
begin
	try
		qryItePedi.first;
		while not(qryItePedi.Eof) do	begin
		case qryItePedi.fieldbyName('qtPedaco').asInteger of
		  1: FTabTele.incluirItemPedido(1,IdCliente,qryItePedi.fieldbyName('Codigo').AsString,'-1','-1','-1',qryItePedi.fieldbyName('iteObs').AsString,'','','');
		  2: begin
			 cdProduto1 := qryItePedi.fieldbyName('Codigo').AsString;
			 obsProduto1:= qryItePedi.fieldbyName('iteObs').AsString;
			 qryItePedi.Next;
			 FTabTele.incluirItemPedido(2,IdCliente,cdProduto1,qryItePedi.fieldbyName('Codigo').AsString,'-1','-1',obsProduto1,qryItePedi.fieldbyName('iteObs').AsString,'','');
		  end;
		  3: begin
			 cdProduto1 := qryItePedi.fieldbyName('IdProduto').AsString;
			 obsProduto1:= qryItePedi.fieldbyName('iteObs').AsString;
			 qryItePedi.Next;
			 cdProduto2 := qryItePedi.fieldbyName('IdProduto').AsString;
			 obsProduto2:= qryItePedi.fieldbyName('iteObs').AsString;
			 qryItePedi.Next;
			 FTabTele.incluirItemPedido(3,IdCliente,cdProduto1,cdProduto2,qryItePedi.fieldbyName('Codigo').AsString,'-1',obsProduto1,obsProduto2,qryItePedi.fieldbyName('iteObs').AsString,'');
		  end;
		  4: begin
			 cdProduto1 := qryItePedi.fieldbyName('Codigo').AsString;
			 obsProduto1:= qryItePedi.fieldbyName('iteObs').AsString;
			 qryItePedi.Next;
			 cdProduto2 := qryItePedi.fieldbyName('Codigo').AsString;
			 obsProduto2:= qryItePedi.fieldbyName('iteObs').AsString;
			 qryItePedi.Next;
			 cdProduto3 := qryItePedi.fieldbyName('Codigo').AsString;
			 obsProduto3:= qryItePedi.fieldbyName('iteObs').AsString;
			 qryItePedi.Next;
			 FTabTele.incluirItemPedido(4,IdCliente,cdProduto1,cdProduto2,cdProduto3,qryItePedi.fieldbyName('Codigo').AsString,obsProduto1,obsProduto2,obsProduto3,qryItePedi.fieldbyName('iteObs').AsString);
		  end;
		end;
		qryItePedi.Next;
	 end;
	 Close;
  except
	 MessageDlg('Erro na rotina de cópia de pedido!', mtInformation, [mbOk], 0);
  end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoUltimo.BtImprimirClick(Sender: TObject);
begin
	if (PEDIRSENHAAOREIMPRIMIR) then begin
		if not FunGeral.mostrarJaneladeAcesso(
			NOMEEMPRESA,
			ACESSOUSUARIO01,
			ACESSOSENHA01
		)then Exit;
	end;

	HrPedido := edtHoraPedido.Time;
	DtPedido := edtDataPedido.Date;
	ImprimeRel40colunas;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoUltimo.ImprimeRel40Colunas;
var	temp,
		contPed			: Integer;
		flag				: boolean;
		ImpressaoPedi	: ImpPedi;
		saldo				: Integer;
		nome_e_codigo	: String;
begin
//-- Inicio do Rel de 40 colunas
	try
		ImpressaoPedi := ImpPedi.criarInstancia;

		ImpressaoPedi.setarRichPadrao();
		ImpressaoPedi.setarRichPara40Colunas();
		impressaoPedi.limparTexto();
		ImpressaoPedi.imprimirCabecalho(RELLINHA1,RELLINHA2,RELLINHA3,true);
		ImpressaoPedi.imprimirDataHoraNPedido(DateToStr(edtDataPedido.Date),TimeToStr(edtHoraPedido.Time),qryItePedi.fieldbyName('NUMEROPEDIDO').text);
		if (FunDB.verificarExistenciaDeRegistro(qryTemp,'SELECT Fone1, Nome, Logradouro, Numero, Complemento, Bairro, Cidade, Referencia'+
			'	FROM Cliente Where Contador = '+IntToStr(IdCliente))) then
		begin
			nome_e_codigo := qryTemp.FieldByName('Fone1').AsString+' '+qryTemp.FieldByName('Nome').AsString;
			impressaoPedi.escreverDadosCliente40Colunas (
				CAMPOCODIGOCLIENTE,
				qryTemp.FieldByName('Fone1').AsString,
				qryTemp.FieldByName('Nome').AsString,
				qryTemp.FieldByName('Logradouro').AsString,
				qryTemp.FieldByName('Numero').AsString,
				qryTemp.FieldByName('Bairro').AsString,
				qryTemp.FieldByName('Complemento').AsString,
				qryTemp.FieldByName('Referencia').AsString
			);
		end else begin
			Exit;
		end;
		ImpressaoPedi.escreverRotuloDeItens40Colunas(IMPRIMEVLITEM);
		qryItePedi.First();
		flag   := true;
		while not(qryItePedi.EOF) do begin
			if flag then ContPed := qryItePedi.FieldbyName('qtPedaco').value;
			if ((contPed>=1) and (flag=true)) then begin
				contPed  := contPed-1;
				flag     := false;
			end else begin
				flag    := false;
				contPed := contPed-1;
			end;

			ImpressaoPedi.chamarImprimirItemPedido(qryTemp,qryItePedi,IMPRIMEVLITEM);
			ImpressaoPedi.escreverLinha40ColVerif(qryItePedi.fieldbyName('iteObs').Text,'Obs: '+ qryItePedi.fieldbyName('iteObs').Text);
			qryItePedi.next;
			if contPed = 0 then begin
				flag := true;
				if not(qryItePedi.Eof) then ImpressaoPedi.imprimirSeparador40Item();
			end;
		end;
		ImpressaoPedi.imprimirObsDoCliente(edtObs.Text);
		ImpressaoPedi.imprimirSeparador40Secundario();
		ImpressaoPedi.escreverLinha40ColE('Form. pag.: '+FunGeral.EscreveE(edtForma.text,11)+'('+FunGeral.EscreveE(qryItePedi.fieldByName('numeroDias').asString,3)+')');
		ImpressaoPedi.escreverLinha40ColE('Vl. Bruto : R$ '+FunGeral.EscreveN(qryItePedi.fieldByName('vlTotal').asFloat-qryItePedi.fieldByName('vlTaxa').asFloat-qryItePedi.fieldByName('vlAcrescimo').asFloat,10,2));
		if qryItePedi.fieldByName('vlTaxa').asFloat <> 0 then ImpressaoPedi.escreverLinha40ColE('Taxa entr.: R$ '+FunGeral.EscreveN(qryItePedi.fieldByName('vlTaxa').asFloat,10,2));
		if qryItePedi.fieldByName('vlAcrescimo').asFloat <> 0 then ImpressaoPedi.escreverLinha40ColE('Desconto  : R$ '+FunGeral.EscreveN(qryItePedi.fieldByName('vlAcrescimo').asFloat,10,2));

		ImpressaoPedi.escreverLinha40ColE('Total     : R$ '+FunGeral.EscreveN(qryItePedi.fieldByName('vlTotal').asFloat,10,2));
		ImpressaoPedi.escreverLinha40ColE('Vl. pago  : R$ '+FunGeral.EscreveN(qryItePedi.fieldByName('vlPago').asFloat,10,2));
		ImpressaoPedi.escreverLinha40ColE('Troco     : R$ '+FunGeral.EscreveN(qryItePedi.fieldByName('vlPago').asFloat-qryItePedi.fieldByName('vlTotal').asFloat,10,2));
		//-- Total do pedido e forma com cheque-pré
		ImpressaoPedi.escreverVendedor40colunas(edtVendedor.text,USAVENDEDOR);
		if (TimeToStr(edtHoraPrevista.Time) <> '00:00:00') then temp := 1 else temp := 0;
		ImpressaoPedi.imprimirHorarioPrevisao(TimeToStr(edtHoraPrevista.Time),temp);
		ImpressaoPedi.escreverRodape40Colunas(MSGREL);
		//-- Controla brindes
		saldo := FTabTele.retornarPontuacaoDoCliente(FrmPedido.retornarCliente());
		if (CONTROLABRINDE) then begin
			//-- Imprime saldo e nova pontuação
			impressaoPedi.imprimirSeparador40Principal();
			impressaoPedi.escreverLinha40ColE(' ');
			impressaoPedi.imprimirSeparador40Principal();
			impressaoPedi.imprimirDataHoraNPedidoSemTraco(DateToStr(edtDataPedido.Date),TimeToStr(edtHoraPedido.Time),qryItePedi.fieldbyName('NUMEROPEDIDO').text);
			impressaoPedi.escreverLinha40ColE('Cliente: '+nome_e_codigo);
			impressaoPedi.escreverLinha40ColE('Saldo Acumulado: '+IntToStr(saldo));
		end;
		ImpressaoPedi.imprimirLinhaEmBrancoEspecial(StrToInt(FTabTele.retornarVariavel('NuLinhasBranco','10')),FTabTele.retornarVariavelBool('ImprimeEspecial','false'));
		ImpressaoPedi.configurarFonte();
		ImpressaoPedi.transformarSelecoesEmNegrito();
		ImpressaoPedi.irParaInicio();
		if (FTabTele.retornarVariavelBool('VisualizarPedido','true')) then impressaoPedi.mostrarPrevisao();
		ImpressaoPedi.enviarParaImpressora(FTabTele.retornarVariavelBool('ConfImpPedi','true'),FTabTele.retornarVariavelBool('ImprimeEspecial','false'),StrToInt(FTabTele.retornarVariavel('NuLinhasBranco','10')));

		ImpressaoPedi.destruirInstancia();
	except
		ImpressaoPedi.destruirInstancia();
		MessageDlg('Erro ao imprimir pedido!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoUltimo.BtAnteriorClick(Sender: TObject);
begin
  if (contadorCdPedidos > 1) then begin
	 contadorCdPedidos := contadorCdPedidos-1;
	 pesquisarItemsPedido(listaDeCdPedidos[contadorCdPedidos-1]);
  end
  else begin
	 MessageDlg('Não há pedido anterior a este.', mtInformation, [mbOk], 0);
  end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoUltimo.BtProximoClick(Sender: TObject);
begin
  if (contadorCdPedidos <  nrCdPedidos) then begin
	 contadorCdPedidos:=contadorCdPedidos+1;
	 pesquisarItemsPedido(listaDeCdPedidos[contadorCdPedidos-1]);
  end
  else begin
	 MessageDlg('Não há pedido após este.', mtInformation, [mbOk], 0);
  end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoUltimo.BtExcluirClick(Sender: TObject);
var idPedido: String;
begin
	if FunGeral.mostrarJaneladeAcesso(
		NOMEEMPRESA,
		ACESSOUSUARIO01,
		ACESSOSENHA01
	)then begin
		if MessageDlg('Deseja excluir o pedido permanentemente?', mtWarning, [mbYes, mbNo], 0) = mrYes then begin
			idPedido := qryItePedi.FieldByName('Contador').AsString;
			FunDB.iniciarTransacao(FTabTele.DBCommerce);
			FunDB.executarQuery(qryItePedi,'Delete from PedidoItem where IdPedido = '+idPedido);
			FunDB.executarQuery(qryItePedi,'Delete from Pedido where Contador = '+idPedido);
			FunDB.finalizarTransacao(FTabTele.DBCommerce);
			FormShow(nil);
		end;
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoUltimo.pesquisarItemsPedido(qualCdPedido:string);
var sql : string;
begin
	sql:=
		'SELECT '+
		' Pedido.Contador, '+
		' Pedido.DataPedido, '+
		' Pedido.NumeroPedido, '+
		' Pedido.obs, '+
		' Pedido.IdAtendente, '+
		' CAST(Pedido.vlPago AS NUMERIC(8,2)) AS VlPago, '+
		' CAST(Pedido.vlTotal AS NUMERIC(8,2)) AS vlTotal, '+
		' CAST(Pedido.vlTaxa AS NUMERIC(8,2)) AS vlTaxa, '+
		' CAST(Pedido.vlAcrescimo AS NUMERIC(8,2)) AS vlAcrescimo, '+
		' Pedido.IDFORMAPAGAMENTO, '+
		' Pedido.HoraPrevista, '+
		' Pedido.NumeroDias, '+
		' PedidoItem.qtPedaco, '+
		' PedidoItem.qtProduto, '+
		' CAST(PedidoItem.vlTotal AS NUMERIC(8,2)) AS iteTotal, '+
		' CAST(PedidoItem.vlProduto AS NUMERIC(8,2)) AS vlProduto, '+
		' PedidoItem.obs as iteObs,'+
		' PedidoItem.IdProduto, '+
		' Produto.nome, '+
		' Produto.codigo, '+
		' Produto.IdProdutoGrupo, '+
//		' Atendente.Nome as NomeVend, '+
		' FormaPagamento.Nome as NomeForma '+
		'FROM '+
		' Pedido, '+
		' Produto, '+
		' PedidoItem, '+
		' FormaPagamento '+
//		' LEFT JOIN Atendente ON Pedido.IdAtendente = Atendente.CONTADOR '+
		'WHERE '+
		' Pedido.contador = '+qualCdPedido +
		'AND '+
		' Pedido.contador = PedidoItem.IdPedido '+
		'AND '+
		' PedidoItem.IdProduto = Produto.contador '+
		'AND '+
		' Pedido.IdFormaPagamento = FormaPagamento.Contador ';
	FunDB.abrirQuery(qryItePedi,sql);
	//-- Carrega campos
	edtObs.text					:= qryItePedi.FieldByName('obs').AsString;
	edtAcrescimo.Text			:= FunGeral.retornarStringMonetaria(qryItePedi.FieldByName('vlAcrescimo').AsFloat);
	edtTaxaDeEntrega.text	:= FunGeral.retornarStringMonetaria(qryItePedi.FieldByName('vlTaxa').AsFloat);
	edtVlPago.Text				:= FunGeral.retornarStringMonetaria(qryItePedi.FieldByName('vlPago').AsFloat);
	edtVlTotal.Text      	:= FunGeral.retornarStringMonetaria(qryItePedi.FieldByName('vlTotal').AsFloat);
	edtDataPedido.Date		:= qryItePedi.FieldByName('dataPedido').AsDateTime;
	edtHoraPedido.Time		:= qryItePedi.FieldByName('dataPedido').AsDateTime;
	edtHoraPrevista.Time		:= qryItePedi.FieldByName('HoraPrevista').AsDateTime;
	edtDias.text				:= qryItePedi.FieldByName('NumeroDias').AsString;
	edtForma.text				:= qryItePedi.FieldByName('NomeForma').AsString;
	edtNumeroPedido.text		:= qryItePedi.FieldByName('NumeroPedido').AsString;


	sql:=
		'SELECT '+
		' Pedido.Contador, '+
		' Pedido.IdAtendente, '+
		' Atendente.Nome as NomeVend '+
		'FROM '+
		' Pedido '+
		' LEFT JOIN Atendente ON Pedido.IdAtendente = Atendente.CONTADOR '+
		'WHERE '+
		' Pedido.contador = '+qualCdPedido;
	FunDB.abrirQuery(qryTemp,sql);
	if qryTemp.fieldByName('IdAtendente').asInteger > 0 then
		edtVendedor.text := qryTemp.fieldByName('NomeVend').asString
	else
		edtVendedor.Clear();
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoUltimo.pesquisarDadosDoCliente;
var sql : string;
begin
	sql:=	'SELECT '+
			'  Pedido.DataPedido, '+
			'  Cliente.Nome As NomeClie, '+
			'  Cliente.Fone1 '+
			'FROM '+
			'  Cliente, '+
			'  Pedido  '+
			'WHERE '+
			'  Cliente.Contador = Pedido.IdCliente '+
			'AND '+
			'  Pedido.Contador = (SELECT '+
				' max(Pedido.contador) '+
				'FROM '+
				' Pedido '+
				'WHERE '+
				' Pedido.IdCliente = '+IntToStr(idCliente)+')';
	FunDB.abrirQuery(qryItePedi,sql);
	edtNome.text			:= qryItePedi.FieldByName('NomeClie').AsString;
	edtTelefone.text		:= qryItePedi.FieldByName('Fone1').AsString;
	edtDataPedido.Date	:= qryItePedi.FieldByName('dataPedido').AsDateTime;
	edtHoraPedido.Time	:= qryItePedi.FieldByName('dataPedido').AsDateTime;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoUltimo.pesquisarCodigoPedidos;
var sql : string;
begin
  sql := 'SELECT '+
			'  Contador '+
			'FROM '+
			'  Pedido '+
			'WHERE '+
			'  IdCliente = '+intToStr(idCliente)+' '+
			'ORDER BY '+
			'	Contador ASC ';
  FunDB.abrirQuery(qryItePedi,sql);
  nrCdPedidos := 0;
  while not (qryItePedi.Eof) do begin
	 listaDeCdPedidos.Add(qryItePedi.FieldByName('Contador').asString);
	 nrCdPedidos := nrCdPedidos+1;
	 qryItePedi.next;
  end;
  contadorCdPedidos := nrCdPedidos;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoUltimo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  listaDeCdPedidos.Clear();
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoUltimo.Fechar1Click(Sender: TObject);
begin
  Close();
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoUltimo.alterarIdCliente(p_IdCliente: integer);
begin
	idCliente := p_IdCliente;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoUltimo.FormCreate(Sender: TObject);
begin
	NOMEEMPRESA := FTabTele.retornarVariavel('NOMEEMPRESA','EMPRESA');
	CAMPOCODIGOCLIENTE := FTabTele.retornarVariavel('CAMPOCODIGOCLIENTE','Fone');
	PEDIRSENHAAOREIMPRIMIR := FTabTele.retornarVariavelBool('PEDIRSENHAAOREIMPRIMIR','0');
	ACESSOUSUARIO01 := FTabTele.retornarVariavel('ACESSOUSUARIO01','Gerente');
	ACESSOSENHA01 := FTabTele.retornarSenhaDecriptografada(FTabTele.retornarVariavel('acessoSenha01',FTabTele.retornarVarSenhaCriptPadrao()));
	RELLINHA1 := FTabTele.retornarVariavel('RelLinha1','RelLinha1');
	RELLINHA2 := FTabTele.retornarVariavel('RelLinha2','RelLinha2');
	RELLINHA3 := FTabTele.retornarVariavel('RelLinha3','RelLinha3');
	IMPRIMEVLITEM := FTabTele.retornarVariavelBool('ImprimeVlItem','0');
	USAVENDEDOR := FTabTele.retornarVariavelBool('UsaVendedor','0');
	MSGREL := FTabTele.retornarVariavel('MsgRel','Agradecemos a preferência!');
	CONTROLABRINDE := FTabTele.retornarVariavelBool('controlaBrinde','0');

end;

end.
//-----------------------------------------------------------------------------------------------
//   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM
//-----------------------------------------------------------------------------------------------

