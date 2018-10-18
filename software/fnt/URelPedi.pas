{------------------------------------------------------------------------------------------------

              O C E A N O   -    M A R    D E    S O L U Ç Õ E S

-------------------------------------------------------------------------------------------------
                                I N I C I O
-------------------------------------------------------------------------------------------------
Criação      : 22/02/2000 11:06:17
Local        : Escritório, Florianópolis
Autor(es)    : Cleber Amaral
               Iomani Engelmann Gomes
Descrição    : Formulario de relatório do sistema
Comentário   : Faz os relatorios do sistema e manda para qrprinter
-------------------------------------------------------------------------------------------------
Atualização  : 28/11/2001 14:00
Autor(es)    : Iomani Engelmann Gomes
Comentário   : Nova funçao para calculo do periodos (para hora de virada)
-------------------------------------------------------------------------------------------------}
unit URelPedi;
//-----------------------------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------------------------
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  DBTables, DB, qrprntr, Mask, Grids, DBGrids, Menus, URelatorio, ComCtrls, Buttons, UFunGeral,
  DBCtrls;
//-----------------------------------------------------------------------------------------------
type
  TfrmRelatorio = class(TForm)
  PLeft: TPanel;
  Panel5: TPanel;
  MainMenu1: TMainMenu;
  SMImprimir: TMenuItem;
  PTop: TPanel;
  qRelatorio: TQuery;
  SMN1: TMenuItem;
  SMConfigurarImpressora: TMenuItem;
  PSD: TPrinterSetupDialog;
  Fechar1: TMenuItem;
  Fechar2: TMenuItem;
  LRel: TLabel;
  Panel1: TPanel;
  Panel2: TPanel;
  gbPeriodo: TGroupBox;
  cbPeriodo: TComboBox;
  LDtInicial: TLabel;
  LDtFinal: TLabel;
  gbCliente: TGroupBox;
  gbEntregador: TGroupBox;
  edtCodigo: TEdit;
  pcRelatorio: TPageControl;
  tshGeral: TTabSheet;
  tshTele: TTabSheet;
  tshComanda: TTabSheet;
  lbxGeral: TListBox;
  lbxTele: TListBox;
  lbComanda: TListBox;
  dtpDataInicial: TDateTimePicker;
  dtpDataFinal: TDateTimePicker;
  btnImprimir: TBitBtn;
  dblcEntregador: TDBLookupComboBox;
  dsqEntregador: TDataSource;
  procedure FormCreate(Sender: TObject);
  procedure btnImprimirClick(Sender: TObject);
  procedure lbxGeralClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
  procedure SMConfigurarImpressoraClick(Sender: TObject);
  procedure cbPeriodoChange(Sender: TObject);
  procedure FormClose(Sender: TObject; var Action: TCloseAction);
  procedure Fechar2Click(Sender: TObject);
  procedure lbxTeleClick(Sender: TObject);
  procedure lbComandaClick(Sender: TObject);
  procedure FormDestroy(Sender: TObject);
  private
	 { Private declarations }
		sql		: string;
		FunGeral	: TFunGeral;
		SomaTaxaDeEntregaNoCaixa: bool;
		FrmPrev		: TForm;
  protected
	 { Protected declarations }
	 mRelatorio     : Relatorio;
	 horaVirada       : string;
  public
		{ Public declarations }
		procedure PedidosNoPeriodo;
		procedure ClientesAtivosNoPeriodo;
		procedure ClientesInativosNoPeriodo;
		procedure VendaPeriodo;
		procedure VendaPeriodoGrupo;
		procedure ExpedidosPeriodo;
		procedure ComissaoPeriodo;
		procedure TotalComissaoPeriodo;
		procedure testarDataInieDataFim(pIni,pFim:string);
		procedure escreverTotais(pTotalPeriodo,pAcrescimo,p_Desconto,pTaxaEntrega:Real;pQuery:TQuery);
		procedure calcularTotais(pTotalPeriodo:Real;pPeriodo:string;pQuery:TQuery);
		procedure gerarRelatorioComissaoDoEntregador(p_CdEntregador: integer);
		procedure gerarRelatorioVendasGrupo();
		procedure comandasNoPeriodo;
		procedure fechamentoComFormasDePagamento;
		procedure comandasNoPeriodo_iniciarIntervalo(var pt_totalInter,pt_totalAcres:Real;var pt_comandaIni,pt_comandaTmp:string);
		procedure comandasNoPeriodo_imprimirIntervalo(var pt_totalInter,pt_totalAcres:Real;var pt_comandaIni,pt_comandaTmp:string);
		procedure historicoDoCliente;
		procedure mostrarCampos(p_Entregador, p_Cliente: boolean);
  end;
//-----------------------------------------------------------------------------------------------
var frmRelatorio: TfrmRelatorio;
//-----------------------------------------------------------------------------------------------
implementation {$R *.DFM}
//-----------------------------------------------------------------------------------------------
uses UFuncoes, UTabTele;
//-----------------------------------------------------------------------------------------------
procedure TfrmRelatorio.btnImprimirClick(Sender: TObject);
begin
  case pcRelatorio.ActivePageIndex of
	 0:begin
		case lbxGeral.ItemIndex of
		  0: VendaPeriodo;
		  1: VendaPeriodoGrupo;
		  2: PedidosNoPeriodo;
		  3: ClientesAtivosNoPeriodo;
		  4: ClientesInativosNoPeriodo;
		  5: historicoDoCliente;
		  6: fechamentoComFormasDePagamento;
      else
		  MessageDlg('Selecione um tipo de relatório!', mtInformation, [mbOk], 0);
		end;
	 end;
	 1:
	 begin
		case lbxTele.ItemIndex of
		  0: ExpedidosPeriodo;
		  1: ComissaoPeriodo;
		  2: TotalComissaoPeriodo;
		else
		  MessageDlg('Selecione um tipo de relatório!', mtInformation, [mbOk], 0);
		end;
    end;
    2:
    begin
      case lbComanda.ItemIndex of
		  0: comandasNoPeriodo;
      else
		  MessageDlg('Selecione um tipo de relatório!', mtInformation, [mbOk], 0);
		end;
    end;
  else
    MessageDlg('Selecione um tipo de relatório!', mtInformation, [mbOk], 0);
  end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmRelatorio.VendaPeriodo;
var sql : String;
	 TotalPeriodo : Real;
	 periodo:	String;
begin
	try
		mRelatorio.iniciarVariaveis;
		testarDataInieDataFim(DateToStr(dtpDataInicial.Date),DateToStr(dtpDataFinal.Date));
		mRelatorio.iniciarRelatorio;
		mRelatorio.incluirNovaPagina;
		periodo := '';
		periodo := FunGeral.fazerPeriodo('Pedido.DataPedido',FTabTele.retornarVariavel('HoraVirada','04:00'),dtpDataInicial.Date,dtpDataFinal.Date);
		sql:= (
			'SELECT '+
			'  Produto.Codigo, '+
			'  Produto.Nome, '+
			'  SUM( '+
			'		cast(PedidoItem.QtProduto as float)/ '+
			'		cast(PedidoItem.qtPedaco as float) '+
			'		) AS QtItem, '+
			'  SUM(PedidoItem.VlTotal) as total, '+
			'  PedidoItem.VlProduto '+
			'FROM '+
			'  PedidoItem,'+
			'  Pedido,'+
			'  Produto '+
			'WHERE '+
			'( '+periodo+' ) '+
			'AND '+
			'  Pedido.contador = PedidoItem.IdPedido '+
			'AND '+
			'  Produto.Contador = PedidoItem.IdProduto '+
			'GROUP BY '+
			'  Produto.codigo,'+
			'  Produto.Nome, '+
			'  PedidoItem.VlProduto '
		);
		mRelatorio.alterarRTitulo(
			EscreveE('Código',10)+Space(1)+
			EscreveE('Nome do produto',30)+Space(1)+
			EscreveD('Quantid.',8)+Space(1)+
			EscreveD('Preço Unit.',12)+Space(1)+
			EscreveD('Preço Total',12));
		mRelatorio.alterarRFiltro('Período de '+DateToStr(dtpDataInicial.Date)+' a '+DateToStr(dtpDataFinal.Date));
		if not (verificarExistenciaDeRegistro(qRelatorio,sql)) then begin
			MessageDlg('Nenhum dado encontrado para o relatório com esses parâmetros.', mtInformation, [mbOk], 0);
			mRelatorio.finalizarRelatorio;
			mRelatorio.limparBuffer;
			Exit;
		end;
		TotalPeriodo := 0;
		while not qRelatorio.Eof do begin
			mRelatorio.colocarCabecalho(lbxGeral.Items[lbxGeral.ItemIndex], Uppercase(FTabTele.retornarVariavel('NomeEmpresa','EMPRESA')));
			mRelatorio.escrever(
				EscreveE(qRelatorio.fieldByName('codigo').asString,10)+Space(1)+
				EscreveE(qRelatorio.fieldByName('nome').asString,30)+Space(1)+
				EscreveN((qRelatorio.fieldByName('qtItem').AsFloat),8,2)+Space(1)+
				EscreveN(qRelatorio.fieldByName('VlProduto').AsFloat,12,2)+Space(1)+
				EscreveN(qRelatorio.fieldByName('total').AsFloat,12,2));
			mRelatorio.pularLinha;
			TotalPeriodo := TotalPeriodo + qRelatorio.fieldByName('total').asFloat;
			qRelatorio.Next;
			mRelatorio.finalizarPagina;
		end;
		mRelatorio.pularLinha;
		calcularTotais(TotalPeriodo,periodo,qRelatorio);
		mRelatorio.finalizarRelatorio;
		mRelatorio.visualizarRelatorio;
		mRelatorio.limparBuffer;
	except
		mRelatorio.finalizarRelatorio;
		mRelatorio.limparBuffer;
		MessageDlg('Erro ao gerar relatório!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmRelatorio.ExpedidosPeriodo;
var	sql       : string;
		periodo   : string;
begin
	try
		if (VarType(dblcEntregador.KeyValue) = varNull) then begin
			MessageDlg('É necessário selecionar um entregador!', mtInformation, [mbOk], 0);
			Exit;
		end;
		mRelatorio.iniciarVariaveis;
		testarDataInieDataFim(DateToStr(dtpDataInicial.Date),DateToStr(dtpDataFinal.Date));
		mRelatorio.iniciarRelatorio;
		mRelatorio.incluirNovaPagina;
		mRelatorio.alterarRTitulo(
			EscreveE('Pedido',16)+Space(1)+
			EscreveE('Entrega',16)+Space(1)+
			EscreveE(FTabTele.retornarVariavel('campoCodigoCliente','Fone'),8)+Space(1)+
			EscreveE('Nome do Cliente',30)
		);
		mRelatorio.alterarRFiltro('Período de '+DateToStr(dtpDataInicial.Date)+' a '+DateToStr(dtpDataFinal.Date));

		periodo := '';
		periodo := FunGeral.fazerPeriodo('Pedido.DATAENTREGA',FTabTele.retornarVariavel('HoraVirada','04:00'),dtpDataInicial.Date,dtpDataFinal.Date);

		sql := 'SELECT '+
				'  PEDIDO.DATAPEDIDO, '+
				'  PEDIDO.DATAENTREGA, '+
				'  CLIENTE.fone1, '+
				'  CLIENTE.Nome '+
				'FROM '+
				'  PEDIDO, '+
				'  CLIENTE '+
				'WHERE '+
				'( '+periodo+' ) '+
				'AND '+
				'  PEDIDO.IDENTREGADOR = '+FunGeral.retornarStringSQL(dblcEntregador.KeyValue)+' '+
				'AND '+
				'  PEDIDO.IDCLIENTE = CLIENTE.CONTADOR ';
		if not (verificarExistenciaDeRegistro(qRelatorio,sql)) then	begin
			MessageDlg('Nenhum dado encontrado para o relatório com esses parâmetros.', mtInformation, [mbOk], 0);
			mRelatorio.finalizarRelatorio;
			mRelatorio.limparBuffer;
			Exit;
		end;
		while not qRelatorio.Eof do begin
			mRelatorio.colocarCabecalhoEntregador(lbxTele.Items[lbxTele.ItemIndex], Uppercase(FTabTele.retornarVariavel('NomeEmpresa','EMPRESA')), dblcEntregador.text );
			mRelatorio.escrever(
				EscreveE(qRelatorio.fieldByName('DATAPEDIDO').Text,16)+Space(1)+
				EscreveE(qRelatorio.fieldByName('DATAENTREGA').Text,16)+Space(1)+
				EscreveE(qRelatorio.fieldByName('Fone1').Text,8)+Space(1)+
				EscreveE(qRelatorio.fieldByName('Nome').Text,30)
			);
			mRelatorio.pularLinha;
			qRelatorio.Next;
			mRelatorio.finalizarPagina;
		end;
		mRelatorio.finalizarArquivoQuery(qRelatorio,' - Quantidade de Entregas: '+IntToStr(qRelatorio.recordCount));
		mRelatorio.finalizarRelatorio;
		mRelatorio.visualizarRelatorio;
		mRelatorio.limparBuffer;
	except
		mRelatorio.finalizarRelatorio;
		mRelatorio.limparBuffer;
		MessageDlg('Erro ao gerar relatório!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmRelatorio.ComissaoPeriodo;
var	TotalVenda,
		comissao,
		totalComissao,
		TotalTaxa,
		totalLiquido  : Real;
		sql,
		tSaida,
		tChegada,
		dtSaida,
		dtChegada     : String;
		periodo:	String;
begin
	if (VarType(dblcEntregador.KeyValue) = varNull) then begin
		MessageDlg('É necessário selecionar um entregador!', mtInformation, [mbOk], 0);
		Exit;
	end;
	mRelatorio.iniciarVariaveis;
	testarDataInieDataFim(DateToStr(dtpDataInicial.Date),DateToStr(dtpDataFinal.Date));
	mRelatorio.iniciarRelatorio;
	mRelatorio.incluirNovaPagina;
	sql := 'SELECT '+
			 '  comissao '+
			 'FROM '+
			 '  Entregador '+
			 'WHERE '+
			 '  contador = '+IntToStr(dblcEntregador.KeyValue);
	abrirQuery(qRelatorio,sql);
	comissao:= qRelatorio.fieldByName('comissao').asFloat/100;
	mRelatorio.alterarRTitulo(
		EscreveE('Dt.Entrega',16)+Space(1)+
		EscreveE('NºPed.',6)+Space(1)+
		EscreveE(FTabTele.retornarVariavel('campoCodigoCliente','EMPRESA'),8)+Space(1)+
		EscreveE('Nome do Cliente',24)+Space(1)+
		EscreveD('Taxa',6)+Space(1)+
		EscreveD('Total (R$)',10)
	);
	mRelatorio.alterarRFiltro('Período de '+DateToStr(dtpDataInicial.Date)+' a '+DateToStr(dtpDataFinal.Date));
	periodo := FunGeral.fazerPeriodo('Pedido.DATAENTREGA',FTabTele.retornarVariavel('HoraVirada','04:00'),dtpDataInicial.Date,dtpDataFinal.Date);
	//-- Seleciona as entregas para o entregador selecionado
	sql := 'SELECT '+
			 '  PEDIDO.DATAPEDIDO, '+
			 '  PEDIDO.DATAENTREGA, '+
			 '  PEDIDO.NUMEROPEDIDO, '+
			 '  PEDIDO.vlTaxa, '+
			 '  PEDIDO.vlTotal, '+
			 '  CLIENTE.fone1, '+
			 '  CLIENTE.Nome '+
			 'FROM '+
			 '  PEDIDO, '+
			 '  CLIENTE '+
			 'WHERE '+
			 '( '+periodo+' ) '+
			 'AND '+
			 '  PEDIDO.IDENTREGADOR = '+FunGeral.retornarStringSQL(dblcEntregador.KeyValue)+' '+
			 'AND '+
			 '  PEDIDO.IDCLIENTE = CLIENTE.CONTADOR ';
	if not (verificarExistenciaDeRegistro(qRelatorio,sql)) then begin
		MessageDlg('Nenhum dado encontrado para o relatório com esses parâmetros.', mtInformation, [mbOk], 0);
		mRelatorio.finalizarRelatorio;
		mRelatorio.limparBuffer;
		Exit;
	end;
	totalVenda:=0;
	totalTaxa := 0;
	while not(qRelatorio.Eof) do begin
		  mRelatorio.colocarCabecalhoEntregador(lbxTele.Items[lbxTele.ItemIndex], Uppercase(FTabTele.retornarVariavel('NomeEmpresa','EMPRESA')), dblcEntregador.text);
		  mRelatorio.escrever(EscreveE(qRelatorio.fieldByName('DATAENTREGA').asString,16)+Space(1)+
									 EscreveE(qRelatorio.fieldByName('NUMEROPEDIDO').asString,6)+Space(1)+
									 EscreveE(qRelatorio.fieldByName('Fone1').asString,8)+Space(1)+
									 EscreveE(qRelatorio.fieldByName('Nome').asString,24)+Space(1)+
									 EscreveN(qRelatorio.fieldByName('vlTaxa').asFloat,6,2)+Space(1)+
									 EscreveN(qRelatorio.fieldByName('vlTotal').asFloat,10,2));
		 mRelatorio.pularLinha;
		 totalVenda :=  totalVenda + qRelatorio.fieldByName('vlTotal').asFloat;
		 totalTaxa  := totalTaxa + qRelatorio.fieldByName('vlTaxa').asFloat;
		 qRelatorio.next;
		 mRelatorio.finalizarPagina;
		end;
	 mRelatorio.pularLinha;
	 mRelatorio.finalizarPagina;
	 qRelatorio.next;
	 totalComissao := comissao*TotalVenda;
	 totalLiquido  := totalVenda-totalComissao-TotalTaxa;
	 mRelatorio.finalizarPagina;
	 mRelatorio.escrever(space(15)+'Quantidade de pedidos'+EscreveD(IntToStr(qRelatorio.RecordCount),40));
	 mRelatorio.pularLinha;
	 mRelatorio.pularLinha;
	 mRelatorio.escrever(space(25)+'Total Venda'+EscreveD(EscreveN(totalVenda,10,2),40));
	 mRelatorio.pularLinha;
	 mRelatorio.escrever(space(22)+'Total Comissao'+EscreveD(EscreveN(totalComissao,10,2),40));
	 mRelatorio.pularLinha;
	 mRelatorio.escrever(space(26)+'Total Taxa'+EscreveD(EscreveN(TotalTaxa,10,2),40));
	 mRelatorio.pularLinha;
	 if (totalComissao <> 0)and(TotalTaxa <> 0) then
	 begin
		mRelatorio.pularLinha;
		mRelatorio.escrever(space(15)+'Total Taxa + Comissão'+EscreveD(EscreveN(TotalTaxa+totalComissao,10,2),40));
		mRelatorio.pularLinha;
	 end;
	 mRelatorio.finalizarArquivoQuery(qRelatorio,Space(3)+'Total Líquido (Produtos-Comissão-Taxa):'+EscreveN((totalLiquido),10,2));
	 mRelatorio.finalizarRelatorio;
	 mRelatorio.visualizarRelatorio;
	 mRelatorio.limparBuffer;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmRelatorio.TotalComissaoPeriodo;
var	TotalVenda,
		totalComissao,
		TotalTaxa,
		totalLiquido  : Real;
		sql,
		tSaida,
		tChegada,
		dtSaida,
		dtChegada     : String;
		periodo:	String;
begin
	mRelatorio.iniciarVariaveis;
	testarDataInieDataFim(DateToStr(dtpDataInicial.Date),DateToStr(dtpDataFinal.Date));
	mRelatorio.iniciarRelatorio;
	mRelatorio.incluirNovaPagina;
	mRelatorio.alterarRTitulo(
		EscreveE('Entregador',20)+Space(1)+
		EscreveE('Dt.Entrega',16)+Space(1)+
		EscreveE('NºPed.',6)+Space(1)+
		EscreveD('Taxa',6)+Space(1)+
		EscreveD('Comissao',10)+Space(1)+
		EscreveD('Total (R$)',10)
	);
	mRelatorio.alterarRFiltro( 'Período de '+DateToStr(dtpDataInicial.Date)+' a '+DateToStr(dtpDataFinal.Date));
	periodo := FunGeral.fazerPeriodo('Pedido.DataPedido',FTabTele.retornarVariavel('HoraVirada','04:00'),dtpDataInicial.Date,dtpDataFinal.Date);
	//-- Seleciona as entregas para o entregador selecionado
	sql :=
		'SELECT '+
		'  PEDIDO.DATAPEDIDO, '+
		'  PEDIDO.DATAENTREGA, '+
		'  PEDIDO.NUMEROPEDIDO, '+
		'  ENTREGADOR.NOME, '+
		'  PEDIDO.vlTaxa, '+
		'  PEDIDO.vlTotal, '+
		'  (PEDIDO.vlTotal * ENTREGADOR.COMISSAO/100) AS TotalEntregador '+
		'FROM '+
		'  PEDIDO, '+
		'  ENTREGADOR '+
		'WHERE '+
		'( '+periodo+' ) '+
		'AND '+
		'  PEDIDO.IDENTREGADOR = ENTREGADOR.CONTADOR ';
	if not (verificarExistenciaDeRegistro(qRelatorio,sql)) then begin
		MessageDlg('Nenhum dado encontrado para o relatório com esses parâmetros.', mtInformation, [mbOk], 0);
		mRelatorio.finalizarRelatorio;
		mRelatorio.limparBuffer;
		Exit;
	end;
	totalVenda:=0;
	totalTaxa := 0;
	totalComissao:=0;
	while not(qRelatorio.Eof) do begin
		mRelatorio.colocarCabecalho(lbxTele.Items[lbxTele.ItemIndex], Uppercase(FTabTele.retornarVariavel('NomeEmpresa','Empresa')));
		mRelatorio.escrever(
			EscreveE(qRelatorio.fieldByName('NOME').asString,20)+Space(1)+
			EscreveE(qRelatorio.fieldByName('DATAENTREGA').asString,16)+Space(1)+
			EscreveE(qRelatorio.fieldByName('NUMEROPEDIDO').asString,6)+Space(1)+
			EscreveN(qRelatorio.fieldByName('vlTaxa').asFloat,6,2)+Space(1)+
			EscreveN(qRelatorio.fieldByName('TotalEntregador').asFloat,10,2)+Space(1)+
			EscreveN(qRelatorio.fieldByName('vlTotal').asFloat,10,2)
		);
		mRelatorio.pularLinha;
		totalVenda			:= totalVenda + qRelatorio.fieldByName('vlTotal').AsFloat;
		totalTaxa			:= totalTaxa + qRelatorio.fieldByName('vlTaxa').AsFloat;
		totalComissao		:= totalComissao + qRelatorio.fieldByName('TotalEntregador').AsFloat;
		qRelatorio.next;
		mRelatorio.finalizarPagina;
	end;
	mRelatorio.pularLinha;
	mRelatorio.finalizarPagina;
	qRelatorio.next;
	totalLiquido  := totalVenda-totalComissao-TotalTaxa;
	mRelatorio.finalizarPagina;
	mRelatorio.escrever(space(15)+'Quantidade de pedidos'+EscreveD(IntToStr(qRelatorio.RecordCount),40));
	mRelatorio.pularLinha;
	mRelatorio.pularLinha;
	mRelatorio.escrever(space(25)+'Total Venda'+EscreveD(EscreveN(totalVenda,10,2),40));
	mRelatorio.pularLinha;
	mRelatorio.escrever(space(22)+'Total Comissao'+EscreveD(EscreveN(totalComissao,10,2),40));
	mRelatorio.pularLinha;
	mRelatorio.escrever(space(26)+'Total Taxa'+EscreveD(EscreveN(TotalTaxa,10,2),40));
	mRelatorio.pularLinha;
	if (totalComissao <> 0)and(TotalTaxa <> 0) then begin
		mRelatorio.pularLinha;
		mRelatorio.escrever(space(15)+'Total Taxa + Comissão'+EscreveD(EscreveN(TotalTaxa+totalComissao,10,2),40));
		mRelatorio.pularLinha;
	end;
	mRelatorio.finalizarArquivoQuery(qRelatorio,Space(3)+'Total Líquido (Produtos-Comissão-Taxa):'+EscreveN((totalLiquido),10,2));
	mRelatorio.finalizarRelatorio;
	mRelatorio.visualizarRelatorio;
	mRelatorio.limparBuffer;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmRelatorio.FormCreate(Sender: TObject);
begin
	Caption := Application.Title+' - '+FTabTele.retornarVariavel('NomeEmpresa','EMPRESA')+' - Relatório Administrativo';
	mRelatorio := Relatorio.Create;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmRelatorio.lbxGeralClick(Sender: TObject);
begin
  case lbxGeral.ItemIndex of
	 0: mostrarCampos(false,false);
	 1: mostrarCampos(false,false);
	 2: mostrarCampos(false,false);
	 3: mostrarCampos(false,false);
	 4: mostrarCampos(false,false);
	 5: mostrarCampos(false,true);
  else
	 mostrarCampos(false,false);
  end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmRelatorio.FormShow(Sender: TObject);
begin
	pcRelatorio.ActivePageIndex := 0;
	lbxGeral.SetFocus;
	gbEntregador.Visible := false;
	cbPeriodo.ItemIndex := 0;
	cbPeriodoChange(nil);
	SomaTaxaDeEntregaNoCaixa := FTabTele.retornarVariavelBool('SomaTaxaDeEntregaNoCaixa','true');
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmRelatorio.VendaPeriodoGrupo;
var sql : String;
	 TotalPeriodo : Real;
	 periodo:	String;
begin
	try
		mRelatorio.iniciarVariaveis;
		periodo:='';
		testarDataInieDataFim(DateToStr(dtpDataInicial.Date),DateToStr(dtpDataFinal.Date));
		mRelatorio.iniciarRelatorio;
		mRelatorio.incluirNovaPagina;
		periodo := FunGeral.fazerPeriodo('Pedido.DataPedido',FTabTele.retornarVariavel('HoraVirada','04:00'),dtpDataInicial.Date,dtpDataFinal.Date);
		sql := (
			'SELECT '+
			'  ProdutoGrupo.Nome, '+
			'  SUM( '+
			'		cast(PedidoItem.QtProduto as float)/ '+
			'		cast(PedidoItem.qtPedaco as float) '+
			'		) AS QtGrup, '+
			'  SUM(PedidoItem.VlTotal) AS TotGrup '+
			'FROM '+
			'  Pedido, '+
			'  Produto, '+
			'  ProdutoGrupo, '+
			'  PedidoItem '+
			'WHERE '+
			'('+periodo+') '+
			'AND '+
			'  Produto.IdProdutoGrupo = ProdutoGrupo.Contador '+
			'AND '+
			' Pedido.contador = PedidoItem.IdPedido '+
			'AND '+
			'  PedidoItem.IdProduto = Produto.Contador '+
			'GROUP BY '+
			'  ProdutoGrupo.Nome, '+
			'  Produto.IdProdutoGrupo '
		);
		mRelatorio.alterarRTitulo(
			EscreveE('Nome do Grupo',53)+SPace(1)+
			EscreveD('Qt.',6)+SPace(1)+
			EscreveD('Valor total',14)
		);
		mRelatorio.alterarRFiltro('Período de '+DateToStr(dtpDataInicial.Date)+' a '+DateToStr(dtpDataFinal.Date));
		if not verificarExistenciaDeRegistro(qRelatorio,sql) then begin
			MessageDlg('Nenhum dado encontrado para o relatório com esses parâmetros.', mtInformation, [mbOk], 0);
			mRelatorio.finalizarRelatorio;
			mRelatorio.limparBuffer;
			Exit;
		end;
		TotalPeriodo := 0;
		while not qRelatorio.Eof do begin
			mRelatorio.colocarCabecalho(lbxGeral.Items[lbxGeral.ItemIndex], Uppercase(FTabTele.retornarVariavel('NomeEmpresa','EMPRESA')));
			mRelatorio.escrever(EscreveE(qRelatorio.FieldByName('Nome').asString,53)+Space(1)+
									  EscreveN(qRelatorio.FieldByName('QtGrup').asFloat,6,2)+Space(1)+
									  EscreveN(qRelatorio.FieldByName('TotGrup').asFloat,14,2));
			mRelatorio.pularLinha;
			TotalPeriodo := TotalPeriodo + qRelatorio.FieldByName('TotGrup').asFloat;
			qRelatorio.Next;
			mRelatorio.finalizarPagina;
		end;
		mRelatorio.pularLinha;
		calcularTotais(TotalPeriodo,periodo,qRelatorio);
		mRelatorio.finalizarRelatorio;
		mRelatorio.visualizarRelatorio;
		mRelatorio.limparBuffer;
	except
		mRelatorio.finalizarRelatorio;
		mRelatorio.limparBuffer;
		MessageDlg('Erro ao gerar relatório!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmRelatorio.PedidosNoPeriodo;
var 	sql: 			String;
		periodo:		String;
		TotalGeral:	Real;
begin
	mRelatorio.iniciarVariaveis;
	testarDataInieDataFim(DateToStr(dtpDataInicial.Date),DateToStr(dtpDataFinal.Date));
	mRelatorio.iniciarRelatorio;
	mRelatorio.incluirNovaPagina;
	periodo := FunGeral.fazerPeriodo('Pedido.DataPedido',FTabTele.retornarVariavel('HoraVirada','04:00'),dtpDataInicial.Date,dtpDataFinal.Date);
	mRelatorio.alterarRTitulo(
		escreveE('NºPed.',6)+Space(1)+
		escreveE('Data',5)+Space(1)+
		escreveE('Hora',5)+Space(1)+
		escreveE(FTabTele.retornarVariavel('campoCodigoCliente','Fone'),8)+Space(1)+
		escreveE('Nome do Cliente',28)+Space(1)+
		escreveE('Vl Acres.',10)+Space(1)+
		escreveE('Vl Total',10)
	);
	mRelatorio.alterarRFiltro('Período de '+DateToStr(dtpDataInicial.Date)+' a '+DateToStr(dtpDataFinal.Date));
	sql := (
		'SELECT '+
		' Pedido.DataPedido, ' +
		' Pedido.NumeroPedido, ' +
		' Cliente.Fone1, ' +
		' Cliente.Nome, '+
		' Pedido.VlAcrescimo, ' +
		' Pedido.VlTaxa, ' +
		' Pedido.VlTotal ' +
		'FROM '+
		' Cliente, '+
		' Pedido '+
		'WHERE '+
		'(  '+periodo+' ) '+
		'AND ' +
		' Pedido.IdCliente = Cliente.Contador '+
		'ORDER BY '+
		' Pedido.DataPedido DESC'
	);
	TotalGeral:=0;
	if not (verificarExistenciaDeRegistro(qRelatorio,sql)) then begin
		MessageDlg('Nenhum dado encontrado para o relatório com esses parâmetros.', mtInformation, [mbOk], 0);
		mRelatorio.finalizarRelatorio;
		mRelatorio.limparBuffer;
		Exit;
	end;
	while not(qRelatorio.eof) do begin
		mRelatorio.colocarCabecalho(lbxGeral.Items[lbxGeral.ItemIndex], Uppercase(FTabTele.retornarVariavel('NomeEmpresa','Empresa')));
		mRelatorio.escrever(
		  EscreveE(qRelatorio.fieldByName('NumeroPedido').AsString,6)+Space(1)+
		  EscreveE(DateToStr(qRelatorio.fieldByName('DataPedido').AsDateTime),5)+Space(1)+
		  EscreveE(TimeToStr(qRelatorio.fieldByName('DataPedido').AsDateTime),5)+Space(1)+
		  EscreveE(qRelatorio.fieldByName('Fone1').AsString,8)+Space(1)+
		  EscreveE(qRelatorio.fieldByName('Nome').AsString,28)+Space(1)+
		  EscreveN(qRelatorio.fieldByName('VlAcrescimo').AsFloat,9,2)+Space(1)+
		  EscreveN(qRelatorio.fieldByName('VlTotal').AsFloat,9,2)
		);
		//-- É subtraido agora pois depois em cacultarTotais será somado novamente
		TotalGeral:=TotalGeral+qRelatorio.fieldByName('VlTotal').AsFloat-qRelatorio.fieldByName('VlAcrescimo').AsFloat-qRelatorio.fieldByName('VlTaxa').AsFloat;
		mRelatorio.pularLinha;
		qRelatorio.next;
		mRelatorio.finalizarPagina;
	 end;
	 mRelatorio.pularLinha;
	 calcularTotais(TotalGeral,periodo,qRelatorio);
	 mRelatorio.finalizarRelatorio;
	 mRelatorio.visualizarRelatorio;
	 mRelatorio.limparBuffer;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmRelatorio.ClientesInativosNoPeriodo;
var 	sql:	string;
		periodo:	String;
begin
	try
		mRelatorio.iniciarVariaveis;
		testarDataInieDataFim(DateToStr(dtpDataInicial.Date),DateToStr(dtpDataFinal.Date));
		mRelatorio.iniciarRelatorio;
		mRelatorio.incluirNovaPagina;
		periodo:='';
		periodo := FunGeral.fazerPeriodo('Cliente.DATAULTIMOPEDIDO',FTabTele.retornarVariavel('HoraVirada','04:00'),dtpDataInicial.Date,dtpDataFinal.Date);
		mRelatorio.alterarRTitulo(
			EscreveE(FTabTele.retornarVariavel('campoCodigoCliente','Fone'),8)+Space(1)+
			EscreveE('Nome do Cliente',40)+Space(1)+
			EscreveE('Bairro',10)+Space(1)+
			EscreveE('Dt Ult.Pedido',16)
		);
		mRelatorio.alterarRFiltro('Período de '+DateToStr(dtpDataInicial.Date)+' a '+DateToStr(dtpDataFinal.Date));

		sql:= 'SELECT '+
			' CLIENTE.Fone1, '+
			' CLIENTE.Nome, '+
			' CLIENTE.Bairro, '+
			' CLIENTE.DATAULTIMOPEDIDO '+
			'FROM '+
			' CLIENTE '+
			'WHERE '+
			'not (  '+periodo+' ) '+
			'OR '+
			' CLIENTE.DATAULTIMOPEDIDO is NULL '+
			'ORDER BY '+
			' Upper(Bairro) ASC, DATAULTIMOPEDIDO desc';
		if not (verificarExistenciaDeRegistro(qRelatorio,sql)) then begin
			MessageDlg('Nenhum dado encontrado para o relatório com esses parâmetros.', mtInformation, [mbOk], 0);
			mRelatorio.finalizarRelatorio;
			mRelatorio.limparBuffer;
			Exit;
		end;
		while not(qRelatorio.eof) do begin
			mRelatorio.colocarCabecalho(lbxGeral.Items[lbxGeral.ItemIndex], Uppercase(FTabTele.retornarVariavel('NomeEmpresa','Empresa')));
			mRelatorio.escrever(
				EscreveE(qRelatorio.fieldByName('fone1').asString,8)+Space(1)+
				EscreveE(qRelatorio.fieldByName('nome').asString,40)+Space(1)+
				EscreveE(qRelatorio.fieldByName('Bairro').asString,10)+Space(1)+
				EscreveE(qRelatorio.fieldByName('DATAULTIMOPEDIDO').asString,16)
			);
			mRelatorio.pularLinha;
			qRelatorio.next;
			mRelatorio.finalizarPagina;
		end;
		mRelatorio.finalizarPagina;
		mRelatorio.finalizarArquivoGeral(space(20)+'Quantidade '+IntToStr(qRelatorio.recordCount));
		mRelatorio.finalizarRelatorio;
		mRelatorio.visualizarRelatorio;
		mRelatorio.limparBuffer;
	except
		mRelatorio.finalizarRelatorio;
		mRelatorio.limparBuffer;
		MessageDlg('Erro ao gerar relatório!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmRelatorio.SMConfigurarImpressoraClick(Sender: TObject);
begin
  PSD.Execute;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmRelatorio.cbPeriodoChange(Sender: TObject);
var hoje: TDateTime;
begin
  if (Time() < StrToTime(FTabTele.retornarVariavel('HoraVirada','04:00'))) then hoje := Now()-1 else hoje := Now();
  case CBPeriodo.ItemIndex of
  0: begin
		dtpDataInicial.Date := hoje;
		dtpDataFinal.Date := hoje;
	 end;
  1: begin
		dtpDataInicial.Date := hoje-1;
		dtpDataFinal.Date := hoje-1;
	 end;
  2: begin
		dtpDataInicial.Date := hoje-7;
		dtpDataFinal.Date := hoje;
	 end;
  3: begin
		dtpDataInicial.Date := hoje-14;
		dtpDataFinal.Date := hoje-7;
	 end;
  4: begin
		dtpDataInicial.Date := hoje-28;
		dtpDataFinal.Date := hoje;
		while Copy(DateToStr(dtpDataFinal.Date),1,2) <> Copy(DateToStr(dtpDataInicial.Date),1,2) do dtpDataInicial.Date := dtpDataInicial.Date-1;
	 end;
  5: begin
		dtpDataInicial.Date := hoje-28;
		dtpDataFinal.Date := hoje;
		while Copy(DateToStr(dtpDataFinal.Date),1,2) <> Copy(DateToStr(dtpDataInicial.Date),1,2) do dtpDataInicial.Date := dtpDataInicial.Date-1;
		dtpDataFinal.Date := dtpDataInicial.Date;
		dtpDataInicial.Date := dtpDataInicial.Date-28;
		while Copy(DateToStr(dtpDataFinal.Date),1,2) <> Copy(DateToStr(dtpDataInicial.Date),1,2) do dtpDataInicial.Date := dtpDataInicial.Date-1;
	 end;
  6: begin
		dtpDataInicial.Date := hoje-365;
		dtpDataFinal.Date := hoje;
	 end;
  7: begin
		dtpDataInicial.Date := hoje-730;
		dtpDataFinal.Date := hoje-365;
	 end;
  end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmRelatorio.ClientesAtivosNoPeriodo;
var 	sql:	String;
		periodo:	String;
begin
	try
		mRelatorio.iniciarVariaveis;
		testarDataInieDataFim(DateToStr(dtpDataInicial.Date),DateToStr(dtpDataFinal.Date));
		mRelatorio.iniciarRelatorio;
		mRelatorio.incluirNovaPagina;
		periodo:='';
		periodo := FunGeral.fazerPeriodo('Cliente.DATAULTIMOPEDIDO',FTabTele.retornarVariavel('HoraVirada','04:00'),dtpDataInicial.Date,dtpDataFinal.Date);
		mRelatorio.alterarRTitulo(
			EscreveE(FTabTele.retornarVariavel('campoCodigoCliente','Fone'),8)+Space(1)+
			EscreveE('Nome do Cliente',40)+Space(1)+
			EscreveE('Bairro',10)+Space(1)+
			EscreveE('Dt Ult.Pedido',16)
		);
		mRelatorio.alterarRFiltro('Período de '+DateToStr(dtpDataInicial.Date)+' a '+DateToStr(dtpDataFinal.Date));

		sql:= 'SELECT '+
			' Cliente.Fone1, '+
			' Cliente.Nome, '+
			' Cliente.Bairro, '+
			' Cliente.DATAULTIMOPEDIDO '+
			'FROM '+
			' Cliente '+
			'WHERE '+
			'(  '+periodo+' ) '+
			'ORDER BY '+
			' Upper(Bairro) ASC, DATAULTIMOPEDIDO desc';
		if not (verificarExistenciaDeRegistro(qRelatorio,sql)) then begin
			MessageDlg('Nenhum dado encontrado para o relatório com esses parâmetros.', mtInformation, [mbOk], 0);
			mRelatorio.finalizarRelatorio;
			mRelatorio.limparBuffer;
			Exit;
		end;
		while not(qRelatorio.eof) do begin
			mRelatorio.colocarCabecalho(lbxGeral.Items[lbxGeral.ItemIndex], Uppercase(FTabTele.retornarVariavel('NomeEmpresa','Empresa')));
			mRelatorio.escrever(
				EscreveE(qRelatorio.fieldByName('fone1').asString,8)+Space(1)+
				EscreveE(qRelatorio.fieldByName('nome').asString,40)+Space(1)+
				EscreveE(qRelatorio.fieldByName('BAIRRO').asString,10)+Space(1)+
				EscreveE(qRelatorio.fieldByName('DATAULTIMOPEDIDO').asString,16)
			);
			mRelatorio.pularLinha;
			qRelatorio.next;
			mRelatorio.finalizarPagina;
		end;
		mRelatorio.finalizarPagina;
		mRelatorio.finalizarArquivoGeral(space(20)+'Quantidade '+IntToStr(qRelatorio.recordCount));
		mRelatorio.finalizarRelatorio;
		mRelatorio.visualizarRelatorio;
		mRelatorio.limparBuffer;
	except
		mRelatorio.finalizarRelatorio;
		mRelatorio.limparBuffer;
		MessageDlg('Erro ao gerar relatório!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmRelatorio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//-- Esta janela deve ser criada junto com a aplicação para permitir que relatórios
// sejam acessados de fora
//	Release;
//	mRelatorio.free
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmRelatorio.Fechar2Click(Sender: TObject);
begin
  Close();
end;
//-----------------------------------------------------------------------------------------------
//-- Trata os campos de data inicio e data fim
procedure TfrmRelatorio.testarDataInieDataFim(pIni,pFim:string);
begin
	if not verificarData(pIni) or not verificarData(pFim) then begin
		MessageDlg('Selecione o período corretamente para retirada do relatório.', mtInformation, [mbOk], 0);
		Abort;
	end;
end;
//-----------------------------------------------------------------------------------------------
//-- Escreve totais no final do relatório
procedure TfrmRelatorio.escreverTotais(pTotalPeriodo,pAcrescimo,p_Desconto,pTaxaEntrega:Real;pQuery:TQuery);
var totalGeral : Real;
begin
	TotalGeral := 0;
	if (pTotalPeriodo <> 0) then begin
		mRelatorio.escrever('Total do período                                                :'+EscreveN(pTotalPeriodo,11,2));
		mRelatorio.pularLinha;
		TotalGeral := TotalGeral + pTotalPeriodo;
	end;
	if (pAcrescimo <> 0) then begin
		mRelatorio.escrever('Total de Acréscimos                                             :'+EscreveN(pAcrescimo,11,2));
		mRelatorio.PularLinha;
		TotalGeral := TotalGeral + pAcrescimo;
	end;
	if (p_Desconto <> 0) then begin
		mRelatorio.escrever('Total de Descontos                                              :'+EscreveN(p_Desconto,11,2));
		mRelatorio.PularLinha;
		TotalGeral := TotalGeral + p_Desconto;
	end;
	if ((pTotalPeriodo <> 0) and (pAcrescimo <> 0)) then begin
		mRelatorio.escrever('Sub-Total                                                       :'+EscreveN((TotalGeral),11,2));
		mRelatorio.pularLinha;
	end;
	mRelatorio.pularLinha;
	if (pTaxaEntrega <> 0) then begin
		mRelatorio.escrever('Total de Taxa de entrega                                        :'+EscreveN(pTaxaEntrega,11,2));
		mRelatorio.pularLinha;
		if (SomaTaxaDeEntregaNoCaixa) then TotalGeral := TotalGeral + pTaxaEntrega;
	end;
	if (pQuery.RecordCount > 0) then begin
		mRelatorio.pularLinha;
		mRelatorio.escrever('Quantidade de itens na consulta                                 :'+EscreveN(pQuery.RecordCount,11,0));
		mRelatorio.pularLinha;
	end;
	mRelatorio.finalizarPagina;
	if (SomaTaxaDeEntregaNoCaixa) then
		mRelatorio.finalizarArquivoQuery(pQuery,' Total (Prod. + Acrésc. + Taxas): R$  '+EscreveN(TotalGeral,14,2))
	else
		mRelatorio.finalizarArquivoQuery(pQuery,' Total (Produtos + Acréscimos)  : R$  '+EscreveN(TotalGeral,14,2));
end;
//-----------------------------------------------------------------------------------------------
//-- calcula totais
procedure TfrmRelatorio.calcularTotais(pTotalPeriodo:Real;pPeriodo:string;pQuery:TQuery);
begin
	sql := (
		'SELECT '+
		'  (SELECT SUM(Pedido.vlAcrescimo) FROM Pedido WHERE Pedido.vlAcrescimo > 0 AND ( '+pPeriodo+' )) AS TotAcrescimo , '+
		'  (SELECT SUM(Pedido.vlAcrescimo) FROM Pedido WHERE Pedido.vlAcrescimo < 0 AND ( '+pPeriodo+' )) AS TotDesconto, '+
		'  SUM(Pedido.vlTaxa) AS TotTaxa '+
		'FROM '+
		'  Pedido '+
		'WHERE '+
		'( '+pPeriodo+' ) '
	);
	abrirQuery(FTabTele.qTele,sql);
	escreverTotais(
		pTotalPeriodo,
		FTabTele.qTele.fieldByName('TotAcrescimo').AsFloat,
		FTabTele.qTele.fieldByName('TotDesconto').AsFloat,
		FTabTele.qTele.fieldByName('TotTaxa').AsFloat,
		pQuery
	);
end;
//-----------------------------------------------------------------------------------------------
//-- Gera RElatorio Comissao do Entregador
procedure TfrmRelatorio.gerarRelatorioComissaoDoEntregador(p_CdEntregador: integer);
begin
	dblcEntregador.KeyValue	:= IntToStr(p_CdEntregador);
	cbPeriodo.ItemIndex		:= 0;
	cbPeriodo.OnChange(nil);
	pcRelatorio.ActivePage	:= tshTele;
	lbxTele.ItemIndex			:= 1;
	btnImprimir.Click();
end;
//-----------------------------------------------------------------------------------------------
//-- Gera Relatorio Vendas por grupo
procedure TfrmRelatorio.gerarRelatorioVendasGrupo();
begin
	cbPeriodo.ItemIndex		:= 0;
	cbPeriodo.OnChange(nil);
	pcRelatorio.ActivePage	:= tshGeral;
	lbxGeral.ItemIndex			:= 1;
	btnImprimir.Click();
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmRelatorio.lbxTeleClick(Sender: TObject);
begin
  case lbxTele.ItemIndex of
	 0: mostrarCampos(true,false);
	 1: mostrarCampos(true,false);
	 2: mostrarCampos(false,false);
  else
    mostrarCampos(false,false);
  end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmRelatorio.lbComandaClick(Sender: TObject);
begin
  case lbxTele.ItemIndex of
	 0: mostrarCampos(false,false);
  else
	 mostrarCampos(false,false);
  end;
end;
//-----------------------------------------------------------------------------------------------
//-- Relatório de intervalo de comandas no período
procedure TfrmRelatorio.comandasNoPeriodo;
var sql : string;
	 TotalGeral : Real;
	 totalInter : Real;
	 totalAcres : Real;
	 comandaIni : string;
	 comandaTmp : string;
	 periodo:		String;
begin
	mRelatorio.iniciarVariaveis;
	testarDataInieDataFim(DateToStr(dtpDataInicial.Date),DateToStr(dtpDataFinal.Date));
	mRelatorio.iniciarRelatorio;
	mRelatorio.incluirNovaPagina;
	mRelatorio.alterarRTitulo(
		escreveE(FTabTele.retornarVariavel('campoCodigoCliente','Fone'),8)+Space(1)+
		escreveE('',28)+Space(1)+
		escreveE('NºPed.',6)+Space(1)+
		escreveE('Data',11)+Space(1)+
		escreveE('Vl Acres.',10)+Space(1)+
		escreveE('Vl Total',10)
	);
	mRelatorio.alterarRFiltro('Período de '+DateToStr(dtpDataInicial.Date)+' a '+DateToStr(dtpDataFinal.Date));
	periodo := FunGeral.fazerPeriodo('Pedido.DataPedido',FTabTele.retornarVariavel('HoraVirada','04:00'),dtpDataInicial.Date,dtpDataFinal.Date);
	sql := (
		'SELECT '+
		' PEDIDO.DataPedido, ' +
		' PEDIDO.NumeroPedido, ' +
		' CLIENTE.Fone1, ' +
		' PEDIDO.VlAcrescimo, ' +
		' PEDIDO.VlTaxa, ' +
		' PEDIDO.VlTotal ' +
		'FROM '+
		' CLIENTE, '+
		' PEDIDO '+
		'WHERE '+
		'(  '+periodo+' ) '+
		'AND ' +
		' PEDIDO.IdCliente=CLIENTE.contador '+
		'ORDER BY '+
		' CLIENTE.Fone1 ASC'
	 );
	 TotalGeral:=0;
	 if not (verificarExistenciaDeRegistro(qRelatorio,sql)) then
	 begin
		MessageDlg('Nenhum dado encontrado para o relatório com esses parâmetros.', mtInformation, [mbOk], 0);
		mRelatorio.finalizarRelatorio;
		mRelatorio.limparBuffer;
		Exit;
	 end;
	 comandaIni := '';
	 totalInter := 0;
	 totalAcres := 0;
	 while not(qRelatorio.eof) do begin
		mRelatorio.colocarCabecalho(lbComanda.Items[lbComanda.ItemIndex], Uppercase(FTabTele.retornarVariavel('NomeEmpresa','Empresa')));
		if (comandaIni = '') then begin
		  comandasNoPeriodo_iniciarIntervalo(totalInter,totalAcres,comandaIni,comandaTmp);
		end else begin
		  //-- Se for igual escreve duplicado!
		  if (StrToInt(comandaTmp) = qRelatorio.fieldByName('Fone1').AsInteger) then begin
			 mRelatorio.escrever
			 (
				EscreveE(qRelatorio.fieldByName('Fone1').asString,8)+Space(1)+
				EscreveE('Duplicado!',28)+Space(1)+
				EscreveE(qRelatorio.fieldByName('NumeroPedido').asString,6)+Space(1)+
				EscreveE(qRelatorio.fieldByName('DataPedido').asString,11)+Space(1)+
				EscreveN(qRelatorio.fieldByName('VlAcrescimo').AsFloat,9,2)+Space(1)+
				EscreveN(qRelatorio.fieldByName('VlTotal').AsFloat,9,2)
			 );
			 mRelatorio.pularLinha;
		  end else begin
			 if ((StrToInt(comandaTmp)+1) <> qRelatorio.fieldByName('Fone1').AsInteger) then begin
						comandasNoPeriodo_imprimirIntervalo(totalInter,totalAcres,comandaIni,comandaTmp);
				mRelatorio.pularLinha;
				mRelatorio.pularLinha;
				comandasNoPeriodo_iniciarIntervalo(totalInter,totalAcres,comandaIni,comandaTmp);
			 end else begin
						comandaTmp := qRelatorio.fieldByName('Fone1').AsString;
						totalInter := totalInter+qRelatorio.fieldByName('VlTotal').AsFloat;
				totalAcres := totalAcres+qRelatorio.fieldByName('VlAcrescimo').AsFloat-qRelatorio.fieldByName('VlTaxa').AsFloat;
			 end;
		  end;
		end;
		comandasNoPeriodo_imprimirIntervalo(totalInter,totalAcres,comandaIni,comandaTmp);
		//-- É subtraido agora pois depois em cacultarTotais será somado novamente
		TotalGeral:=TotalGeral+qRelatorio.fieldByName('VlTotal').AsFloat-qRelatorio.fieldByName('VlAcrescimo').AsFloat-qRelatorio.fieldByName('VlTaxa').AsFloat;
		qRelatorio.next;
		mRelatorio.finalizarPagina;
	 end;
	 mRelatorio.pularLinha;
	 mRelatorio.pularLinha;
	 calcularTotais(TotalGeral,periodo,qRelatorio);
	 mRelatorio.finalizarRelatorio;
	 mRelatorio.visualizarRelatorio;
	 mRelatorio.limparBuffer;
end;

//-- Relatório de intervalo de comandas no período
procedure TfrmRelatorio.fechamentoComFormasDePagamento;
var sql : string;
	 TotalGeral : Real;
	 totalInter : Real;
	 totalAcres : Real;
	 comandaIni : string;
	 comandaTmp : string;
	 periodo:		String;
begin
	mRelatorio.iniciarVariaveis;
	testarDataInieDataFim(DateToStr(dtpDataInicial.Date),DateToStr(dtpDataFinal.Date));
	mRelatorio.iniciarRelatorio;
	mRelatorio.incluirNovaPagina;
	mRelatorio.alterarRTitulo(
		escreveE('Forma de pagamento',20)+Space(1)+
		escreveE('Vl Acres.',10)+Space(1)+
		escreveE('Vl Taxa.',10)+Space(1)+
		escreveE('Vl Total',10)
	);
	mRelatorio.alterarRFiltro('Período de '+DateToStr(dtpDataInicial.Date)+' a '+DateToStr(dtpDataFinal.Date));
	periodo := FunGeral.fazerPeriodo('Pedido.DataPedido',FTabTele.retornarVariavel('HoraVirada','04:00'),dtpDataInicial.Date,dtpDataFinal.Date);
	sql := (
		'SELECT '+
		'  FORMAPAGAMENTO.nome, '+
		'  sum(PEDIDO.VlAcrescimo) as vlacr, '+
		'  sum(PEDIDO.VlTaxa) as vltax, '+
		'  sum(PEDIDO.VlTotal) as vltot '+
		'FROM '+
		'  PEDIDO, '+
		'  FORMAPAGAMENTO '+
		'WHERE '+
		'(  '+periodo+' ) '+
		'AND ' +
		'  FORMAPAGAMENTO.contador = PEDIDO.IDFORMAPAGAMENTO '+
		'GROUP BY '+
		'  FORMAPAGAMENTO.nome '
	 );
	 TotalGeral:=0;
	 if not (verificarExistenciaDeRegistro(qRelatorio,sql)) then
	 begin
		MessageDlg('Nenhum dado encontrado para o relatório com esses parâmetros.', mtInformation, [mbOk], 0);
		mRelatorio.finalizarRelatorio;
		mRelatorio.limparBuffer;
		Exit;
	 end;
	 comandaIni := '';
	 totalInter := 0;
	 totalAcres := 0;
	while not(qRelatorio.eof) do begin
		mRelatorio.colocarCabecalho(lbxGeral.Items[lbxGeral.ItemIndex], Uppercase(FTabTele.retornarVariavel('NomeEmpresa','Empresa')));
		mRelatorio.escrever(
		  EscreveE(qRelatorio.fieldByName('nome').asString,20)+Space(1)+
		  EscreveN(qRelatorio.fieldByName('vlacr').AsFloat,9,2)+Space(1)+
		  EscreveN(qRelatorio.fieldByName('vltax').AsFloat,9,2)+Space(1)+
		  EscreveN(qRelatorio.fieldByName('vltot').AsFloat,9,2)
		);
		//-- É subtraido agora pois depois em cacultarTotais será somado novamente
		TotalGeral:=TotalGeral+qRelatorio.fieldByName('VlTot').AsFloat-qRelatorio.fieldByName('VlAcr').AsFloat-qRelatorio.fieldByName('VlTax').AsFloat;
		mRelatorio.pularLinha;
		qRelatorio.next;
		mRelatorio.finalizarPagina;
	 end;
	 mRelatorio.pularLinha;
	 mRelatorio.pularLinha;
	 calcularTotais(TotalGeral,periodo,qRelatorio);
	 mRelatorio.finalizarRelatorio;
	 mRelatorio.visualizarRelatorio;
	 mRelatorio.limparBuffer;
end;

//-----------------------------------------------------------------------------------------------
//-- iniciar Intevalo do relatorio "comandasNoPeriodo"
procedure TfrmRelatorio.comandasNoPeriodo_iniciarIntervalo(var pt_totalInter,pt_totalAcres:Real;var pt_comandaIni,pt_comandaTmp:string);
begin
  pt_comandaIni := qRelatorio.fieldByName('Fone1').asString;
  pt_comandaTmp := pt_comandaIni;
  pt_totalInter := qRelatorio.fieldByName('VlTotal').AsFloat;
  pt_totalAcres := qRelatorio.fieldByName('VlAcrescimo').AsFloat-qRelatorio.fieldByName('VlTaxa').AsFloat;
  if (qRelatorio.RecNo = qRelatorio.RecordCount) then comandasNoPeriodo_imprimirIntervalo(pt_totalInter,pt_totalAcres,pt_comandaIni,pt_comandaTmp);
end;
//-----------------------------------------------------------------------------------------------
//-- iniciar Intevalo do relatorio "comandasNoPeriodo"
procedure TfrmRelatorio.comandasNoPeriodo_imprimirIntervalo(var pt_totalInter,pt_totalAcres:Real;var pt_comandaIni,pt_comandaTmp:string);
begin
  mRelatorio.escrever
  (
    EscreveE('De',2)+Space(1)+
    EscreveE(pt_comandaIni,8)+Space(1)+
    EscreveE('a',1)+Space(1)+
    EscreveE(pt_comandaTmp,8)+Space(1)+
    EscreveE('',33)+Space(1)+
    EscreveN(pt_totalAcres,9,2)+Space(1)+
    EscreveN(pt_totalInter,9,2)
  );
end;
//-----------------------------------------------------------------------------------------------
//-- Relatorio de historico do cliente
procedure TfrmRelatorio.historicoDoCliente;
var sql : string;
    TotalGeral : Real;
    TotalTaxa : Real;
	 TotalAcres : Real;
	 TotalDesc : Real;
	 periodo:	String;
begin
	mRelatorio.iniciarVariaveis;
	testarDataInieDataFim(DateToStr(dtpDataInicial.Date),DateToStr(dtpDataFinal.Date));
	mRelatorio.iniciarRelatorio;
	mRelatorio.incluirNovaPagina;
	mRelatorio.alterarRTitulo(
		escreveE('NºPed.',6)+Space(1)+
		escreveE('Data',5)+Space(1)+
		escreveE('Hora',5)+Space(1)+
		escreveE(FTabTele.retornarVariavel('campoCodigoCliente','Fone'),8)+Space(1)+
		escreveE('Nome do Cliente',28)+Space(1)+
		escreveE('Vl Acres.',10)+Space(1)+
		escreveE('Vl Total',10)
	);
	periodo := FunGeral.fazerPeriodo('Pedido.DataPedido',FTabTele.retornarVariavel('HoraVirada','04:00'),dtpDataInicial.Date,dtpDataFinal.Date);
	mRelatorio.alterarRFiltro('Período de '+DateToStr(dtpDataInicial.Date)+' a '+DateToStr(dtpDataFinal.Date));
	sql := (
		'SELECT '+
		' Pedido.DataPedido, ' +
		' Pedido.NumeroPedido, ' +
		' Cliente.Fone1, ' +
		' Cliente.Nome, '+
		' Cliente.DataUltimoPedido, '+
		' Pedido.VlAcrescimo, ' +
		' Pedido.VlTaxa, ' +
		' Pedido.VlTotal ' +
		'FROM '+
		' Cliente, '+
		' Pedido '+
		'WHERE '+
		'(  '+periodo+' ) '+
		'AND ' +
		' Pedido.IdCliente=Cliente.contador '+
		'AND ' +
		'( Cliente.Fone1= '+FunGeral.retornarStringSQL(edtCodigo.Text)+' OR Cliente.Fone2= '+FunGeral.retornarStringSQL(edtCodigo.Text)+' OR Cliente.Fone3= '+FunGeral.retornarStringSQL(edtCodigo.Text)+')'+
		'ORDER BY '+
		' Pedido.DataPedido DESC'
	);
	TotalGeral := 0;
	TotalAcres := 0;
	TotalTaxa  := 0;
	if not (verificarExistenciaDeRegistro(qRelatorio,sql)) then begin
		MessageDlg('Nenhum dado encontrado para o relatório com esses parâmetros.', mtInformation, [mbOk], 0);
		mRelatorio.finalizarRelatorio;
		mRelatorio.limparBuffer;
		Exit;
	 end;
	 while not(qRelatorio.eof) do begin
		mRelatorio.colocarCabecalho(lbxGeral.Items[lbxGeral.ItemIndex], Uppercase(FTabTele.retornarVariavel('NomeEmpresa','Fone')));
		mRelatorio.escrever
      (
		  EscreveE(qRelatorio.fieldByName('NumeroPedido').AsString,6)+Space(1)+
		  EscreveE(DateToStr(qRelatorio.fieldByName('DataPedido').AsDateTime),5)+Space(1)+
		  EscreveE(TimeToStr(qRelatorio.fieldByName('DataPedido').AsDateTime),5)+Space(1)+
		  EscreveE(qRelatorio.fieldByName('Fone1').AsString,8)+Space(1)+
		  EscreveE(qRelatorio.fieldByName('Nome').AsString,28)+Space(1)+
		  EscreveN(qRelatorio.fieldByName('VlAcrescimo').AsFloat,9,2)+Space(1)+
		  EscreveN(qRelatorio.fieldByName('VlTotal').AsFloat,9,2)
		);
		//-- É subtraido agora pois depois em cacultarTotais será somado novamente
		TotalGeral := TotalGeral+qRelatorio.fieldByName('VlTotal').AsFloat-qRelatorio.fieldByName('VlAcrescimo').AsFloat-qRelatorio.fieldByName('VlTaxa').AsFloat;
		if (qRelatorio.fieldByName('VlAcrescimo').AsFloat > 0) then begin
			TotalAcres := TotalAcres+qRelatorio.fieldByName('VlAcrescimo').AsFloat;
		end else begin
			TotalDesc := TotalDesc+qRelatorio.fieldByName('VlAcrescimo').AsFloat;
		end;
		TotalTaxa  := TotalTaxa+qRelatorio.fieldByName('VlTaxa').AsFloat;
		mRelatorio.pularLinha;
		qRelatorio.next;
		mRelatorio.finalizarPagina;
	 end;
	 mRelatorio.pularLinha;
	 escreverTotais(TotalGeral,TotalAcres,TotalDesc,TotalTaxa,qRelatorio);
	 mRelatorio.finalizarRelatorio;
	 mRelatorio.visualizarRelatorio;
	 mRelatorio.limparBuffer;
end;
//-----------------------------------------------------------------------------------------------
//-- mostrar campos
procedure TfrmRelatorio.mostrarCampos(p_Entregador, p_Cliente: boolean);
begin
  gbEntregador.Visible := p_Entregador;
  gbCliente.Visible    := p_Cliente;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmRelatorio.FormDestroy(Sender: TObject);
begin
	mRelatorio.Free();
end;

end.
//-----------------------------------------------------------------------------------------------
//   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM
//-----------------------------------------------------------------------------------------------

