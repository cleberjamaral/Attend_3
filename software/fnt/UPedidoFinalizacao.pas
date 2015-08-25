{------------------------------------------------------------------------------------------------

              O C E A N O   -    M A R    D E    S O L U Ç Õ E S

-------------------------------------------------------------------------------------------------
                                I N I C I O
-------------------------------------------------------------------------------------------------
Criação      : 20/01/2000 12:00
Local        : Escritório, Florianópolis
Autor(es)    : Cleber Amaral
               Iomani Engelmann Gomes
Descrição    : Finalizaçao do pedido
Comentário   : Faz a finalizaçao do pedido, podento lançar os dados para o módulo caixa
					faz  a impressão do pedido qdo solicadata em 40 ou 80 colunas
-------------------------------------------------------------------------------------------------
Atualização  : 01/11/2001 10:00
Autor(es)    : Iomani Engelmann Gomes
Comentário   : implementação dos métodos para prever tempo de entrega
-------------------------------------------------------------------------------------------------}
unit UPedidoFinalizacao;
//-----------------------------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------------------------
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DBCtrls, Buttons, ToolEdit, Menus, DB, DBTables, Grids,
  DBGrids, ComCtrls, Printers, ToolWin, ClipBrd, ImgList, UImpPedi, Spin, UFunDB, Mask, UFunGeral;
//-----------------------------------------------------------------------------------------------
type
  TfrmPedidoFinalizacao = class(TForm)
	 PD: TPrintDialog;
    Menu: TMainMenu;
    mitAlterar: TMenuItem;
    MOculto: TMenuItem;
    mitFinalizar: TMenuItem;
    SMPercetual: TMenuItem;
    mitImprimir: TMenuItem;
    PBarraInferior: TPanel;
	 smMinEntrega: TMenuItem;
	 ToolbarImages: TImageList;
    qryFormaPagamento: TQuery;
    mFechar: TMenuItem;
    mitFechar: TMenuItem;
    smFechar2: TMenuItem;
	 btnFinalizar: TBitBtn;
    btnAlterar: TBitBtn;
	 btnImprimir: TBitBtn;
    panPreferencias: TPanel;
	 LPreferencias: TLabel;
    edtObs: TEdit;
    panVendedor: TPanel;
    LVendedor: TLabel;
    dblcVendedor: TDBLookupComboBox;
    panTempo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    meHoraEntrega: TMaskEdit;
    panTaxaDeEntrega: TPanel;
    LTotProdutos: TLabel;
	 LTaxaEntrega: TLabel;
    PTotais: TPanel;
    labTotal: TLabel;
    LDesconto: TLabel;
    LSubTotal: TLabel;
	 Panel2: TPanel;
	 LPercent: TLabel;
    Label4: TLabel;
	 Label5: TLabel;
	 PformPag: TPanel;
    LFormaPag: TLabel;
    PChequepre: TPanel;
	 LDias: TLabel;
    PTroco: TPanel;
    LParaQuanto: TLabel;
    LTroco: TLabel;
    lcbFormaPagamento: TDBLookupComboBox;
    dsqFormaPagamento: TDataSource;
    speMinutos: TSpinEdit;
    speAcrescimoPercentual: TSpinEdit;
    speDescontoPercentual: TSpinEdit;
    edtProdutos: TEdit;
    edtTaxaDeEntrega: TEdit;
    qryTemporaria: TQuery;
    qryTempItemPedi: TQuery;
    btnSalvarPreferencia: TBitBtn;
    mitSalvarPreferencias: TMenuItem;
    N1: TMenuItem;
	 edtSubTotal: TEdit;
	 edtAcrescimo: TEdit;
	 edtTotal: TEdit;
	 edtValorPago: TEdit;
	 edtTroco: TEdit;
	 speDias: TSpinEdit;
	 mitDividirConta: TMenuItem;
	 procedure FormShow(Sender: TObject);
	 procedure ceValorPagoEnter(Sender: TObject);
	 procedure FormClose(Sender: TObject; var Action: TCloseAction);
	 procedure btnAlterarClick(Sender: TObject);
	 procedure FormCreate(Sender: TObject);
	 procedure btnFinalizarClick(Sender: TObject);
	 procedure SMPercetualClick(Sender: TObject);
	 procedure edtObsKeyPress(Sender: TObject; var Key: Char);
	 procedure btnImprimirClick(Sender: TObject);
	 procedure meHoraEntregaExit(Sender: TObject);
	 procedure smMinEntregaClick(Sender: TObject);
	 procedure FormDestroy(Sender: TObject);
	 procedure speMinutosExit(Sender: TObject);
	 procedure btnSalvarPreferenciaClick(Sender: TObject);
	 procedure speMinutosKeyDown(Sender: TObject; var Key: Word;
		Shift: TShiftState);
	 procedure mitFecharClick(Sender: TObject);
	 procedure edtAcrescimoExit(Sender: TObject);
	 procedure lcbFormaPagamentoClick(Sender: TObject);
	 procedure edtTaxaDeEntregaKeyPress(Sender: TObject; var Key: Char);
	 procedure mitDividirContaClick(Sender: TObject);
//-----------------------------------------------------------------------------------------------
  private
	 { Private declarations }
		alterandoEstilo : bool;
		ordemItensPedido: Integer;
		procedure calcularTotal();
//-----------------------------------------------------------------------------------------------
  protected
	 { Protected declarations }
		FunDB					: TFunDB;
		FunGeral				: TFunGeral;
		CdPedido,
		contadorVendedor  : integer;
		nrPedido          : String;
		updating          : Boolean;
		ImpressaoPedi     		: ImpPedi;
		alterandoPedido   		: Boolean;
		imprimirGrupoDoProduto	: Boolean;
		OriginalHeight				: Integer;
		numeroCopiasImpressao	: Integer;

//-----------------------------------------------------------------------------------------------
  public
	 { Public declarations }
	 function forncerContadorVendedor:integer;
	 function ImprimeRel40colunas: boolean;
	 procedure alterarContadorVendedor(qualContadorVendedor : integer);
	 procedure cadastrarItemPedidoNoHistorico(p_Qtde, p_CdPedido, p_CdPedaco, p_QtPedaco: Integer; p_VlProduto: real; p_Obs: String);
	 procedure habilitarBotaoImprimir(p_Habilita: bool);
	 procedure habilitarBotaoAlterar(p_Habilita: bool);
	 procedure habilitarBotaoFinalizar(p_Habilita: bool);
  end;
//-----------------------------------------------------------------------------------------------
var frmPedidoFinalizacao     : TfrmPedidoFinalizacao;
//-----------------------------------------------------------------------------------------------
implementation {$R *.DFM}
//-----------------------------------------------------------------------------------------------
uses UPedido, UInicial, UTabTele, UFuncoes;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoFinalizacao.alterarContadorVendedor(qualContadorVendedor : integer);
begin
  contadorVendedor := qualContadorVendedor;
end;
//-----------------------------------------------------------------------------------------------
function TfrmPedidoFinalizacao.forncerContadorVendedor:integer;
begin
  result := contadorVendedor;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoFinalizacao.FormShow(Sender: TObject);
var	ValorTotal	: Real;
		novoSaldo	: Integer;
		premio		: Integer;
begin
	try
		//-- Impede que se imprima sem criar o cumpom antes
		habilitarBotaoImprimir(false);

		//-- Para garantir uso de ponto e vírgula nos valores
		FTabTele.aplicarConfiguracaoPadrao();

		//-- atualiza previsão de entrega
		speMinutosExit(nil);

		//-- Resize da previsão para posição original
		alterandoEstilo         := False;
		meHoraEntrega.refresh;
		//--
		contadorVendedor        := FInicial.fornecerContadorVendedorAtivo;
		dblcVendedor.KeyValue      := intToStr(contadorVendedor);
		if (FTabTele.retornarVariavel('UsaVendedor','false') = 'false') then begin
			panVendedor.Visible := false;
			Height := OriginalHeight - panVendedor.Height;
		end;
		if (FTabTele.retornarVariavel('ocultarCamposTele','false') = 'true') then begin
			panPreferencias.Visible  := false;
			panTempo.Visible         := false;
			panTaxaDeEntrega.Visible := false;
			Height := Height - (panPreferencias.Height+panTempo.Height+panTaxaDeEntrega.Height);
		end;
		//-- TCadProd é usado para visualizacao dos itens selecionados essa operacao é feita apenas nesse formulario por isso é aberta somente aqui.
		alterandoPedido         := False;
//-- Ao mostrar o form é limpo o memo de previsao com esse arquivo texto sem caracteres gravados
		PChequepre.Visible          := false;

		speDescontoPercentual.Value	:= 0;
		speAcrescimoPercentual.Value	:= Trunc(FTabTele.retornarVariavelFloat('TaxaServico',0));
		lcbFormaPagamento.KeyValue		:= 1;
		speDias.Value						:= 0;
		//-- calcula total
		ValorTotal					:= FTabTele.retornarValorTotalDoPedido(FrmPedido.retornarCliente());
		edtObs.Text					:= FTabTele.retornarPreferenciaDoCliente(FrmPedido.retornarCliente());
		edtProdutos.Text			:= FunGeral.retornarStringMonetaria(ValorTotal);
		edtValorPago.Text			:= FunGeral.retornarStringMonetaria(ValorTotal);
		if (FTabTele.retornarVariavelBool('zerarTaxaDeEntrega','false')) then begin
			edtTaxaDeEntrega.Text	:= FunGeral.retornarStringMonetaria(0);
		end else begin
			if (edtTaxaDeEntrega.Text = '') then edtTaxaDeEntrega.Text	:= FunGeral.retornarStringMonetaria(0);
		end;
		edtSubTotal.Text			:= FunGeral.retornarStringMonetaria(StrToFloat(edtProdutos.Text) + StrToFloat(edtTaxaDeEntrega.Text));
		edtTotal.Text				:= FunGeral.retornarStringMonetaria(StrToFloat(edtSubTotal.Text));
		edtTroco.Text				:= FunGeral.retornarStringMonetaria(0);
		edtAcrescimo.Text			:= FunGeral.retornarStringMonetaria(0);

		edtAcrescimoExit(speAcrescimoPercentual);

		edtObs.SetFocus();

		//	ordemItensPedido = 0 = Ordem de inserção dos itens na tabela
		//	ordemItensPedido = 1 = Ordenado por grupo de produtos ASC
		ordemItensPedido := FTabTele.retornarVariavelInt('ordemItensPedido',0);

		//-- Controla brindes
		if (FTabTele.retornarVariavel('controlaBrinde','false') = 'true') then begin
			//-- Busca Saldo do cliente
			premio := 0;
			novoSaldo :=
				FTabTele.retornarPontuacaoDoCliente(FrmPedido.retornarCliente())+
				FTabTele.retornarPontuacaoDePedidoMovimentacao(FrmPedido.retornarCliente());
			if (novoSaldo >= FTabTele.retornarVariavelFloat('pontuacaoPremio1',30)) then premio := 1;
			if (novoSaldo >= FTabTele.retornarVariavelFloat('pontuacaoPremio2',50)) then premio := 2;
			if (novoSaldo >= FTabTele.retornarVariavelFloat('pontuacaoPremio3',100)) then premio := 3;
			if (premio > 0) then begin
				if (
					MessageDlg(
						'O cliente atingiu '+IntToStr(novoSaldo)+' pontos.'+
						#13+'Foi alcançada pontuação necessário para ganhar o prêmio '+IntToStr(premio)+'.'+
						#13+'Deseja que o saldo do cliente seja zerado?',
						mtConfirmation, [mbYes, mbNo], 0) = mrYes
					) then
				begin
					FTabTele.alterarPontuacaoDoCliente(FrmPedido.retornarCliente(), 0);
				end;
			end;
		end;

		habilitarBotaoFinalizar(true); //-- Inicia desabilitado, só habilita no final do show

		numeroCopiasImpressao := FTabTele.retornarVariavelInt('numeroCopiasImpressao',1);
	except
		MessageDlg('Erro ao abrir a janela de confirmação de pedidos!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoFinalizacao.ceValorPagoEnter(Sender: TObject);
begin
  try
	 edtTroco.Text := '0';
  except
	 MessageDlg('Erro ao focar botão de finalização do pedido!', mtError, [mbOk], 0);
  end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoFinalizacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	try
		if not alterandoPedido then begin
			habilitarBotaoFinalizar(true);
			habilitarBotaoAlterar(true);
			frmPedido.inicializarPedidos;
			frmPedido.Show;
			FInicial.alterarContadorVendedorAtivo(contadorVendedor);
		end;
	except
		MessageDlg('Erro ao fechar janela!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoFinalizacao.btnAlterarClick(Sender: TObject);
begin
  try
	 frmPedido.processarCliente();
	 alterandoPedido := True;
	 Close;
  except
		MessageDlg('Erro na tentativa de alterar pedido!', mtError, [mbOk], 0);
  end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoFinalizacao.FormCreate(Sender: TObject);
begin
	try
		habilitarBotaoFinalizar(false); //-- Inicia desabilitado, só habilita no final do show
		Caption := Application.Title+' - '+FTabTele.retornarVariavel('NomeEmpresa','EMPRESA')+' - Confirmação do pedido';
		OriginalHeight := Height;
		impressaoPedi := ImpPedi.criarInstancia;
		qryFormaPagamento.Open(); // Abre tabela de form pag
		imprimirGrupoDoProduto := FTabTele.retornarVariavelBool('ImprimirGrupoDoProduto','true');
	except
		MessageDlg('Erro ao criar janela de confirmação do pedido!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoFinalizacao.btnFinalizarClick(Sender: TObject);
var mostraGradePediAbertos	: bool;
begin
	mostraGradePediAbertos := FrmPedido.retornarMostraGradePediAbertos;

	//-- Para garantir que o foco fique na janela de conf. impressão
	edtObs.SetFocus();

	//-- Será habilitado no evento onClose do form
	habilitarBotaoFinalizar(false);
	habilitarBotaoAlterar(false);

	//-- Verificações iniciais
	//-- Processa o vendedor
	if (FTabTele.retornarVariavel('UsaVendedor','false') = 'true') then begin
		if (dblcVendedor.KeyValue<>'') then begin
			contadorVendedor:=strToInt(dblcVendedor.KeyValue);
		end else begin
			MessageDlg('É necessário selecionar um vendedor!', mtInformation, [mbOk], 0);
			if (dblcVendedor.Visible) then dblcVendedor.SetFocus;
			exit;
		end;
	end else begin
		contadorVendedor:=0;
	end;
	//-- Finaliza o pedido
	calcularTotal();
	speMinutosExit(nil); //-- calcula previsao de entrega

	alterandoPedido := False;

	FTabTele.atualizaDataUltimoPedido(FrmPedido.retornarCliente());

	//-- Fecha FinPedi caso apertado botao OK do impressao, caso contrário permite que seja impresso através do botão IMPRIMIR
	if (ImprimeRel40colunas) then Close else habilitarBotaoImprimir(true);

	if (mostraGradePediAbertos) then frmPedido.atualizarGradePedidosAbertos();

end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoFinalizacao.SMPercetualClick(Sender: TObject);
begin
  if speAcrescimoPercentual.Focused then speDescontoPercentual.SetFocus() else speAcrescimoPercentual.SetFocus();
end;
//-----------------------------------------------------------------------------------------------
//-- Retorna true se for fapa fechar janela de finpedi
function TfrmPedidoFinalizacao.ImprimeRel40colunas: boolean;
var	MsgFinalRel		: string;
		cont				: Integer;
		pontos			: Integer;
		saldo				: Integer;
		nome_e_codigo	: String;
		RelLinha1		: String;
		RelLinha2		: String;
		RelLinha3		: String;
		dataBancoDeDados	: TDateTime;
		sqlItensPedi	: String;
		copiasImpress  : Integer;
		qtRealDeItem	: Real;
begin
	RelLinha1 := '';
	RelLinha2 := '';
	RelLinha3 := '';

	//-- Buscar data do banco de dados
	abrirQuery(qryTemporaria,'SELECT CURRENT_TIMESTAMP AS DATABANCO FROM RDB$DATABASE');
	dataBancoDeDados := qryTemporaria.FieldByName('DATABANCO').AsDateTime;

	//-- Inicio do Rel de 40 colunas
	try
		//-- Gerar NrPedido
		ImpressaoPedi.setarRichPadrao();
		CdPedido := FTabTele.buscarMaxContadorDBTele('Pedido');
		FunDB.abrirQuery(qryTemporaria,'SELECT NUMEROPEDIDO FROM Pedido WHERE CONTADOR = '+IntToStr(CdPedido-1));
		nrPedido := criarNrPedidoComVirada(dataBancoDeDados,qryTemporaria.FieldByName('NUMEROPEDIDO').AsString,FTabTele.retornarVariavel('NumInicialCupom','1'),FTabTele.retornarVariavel('HoraVirada','04:00'));

		//-- Iniciar Registro e impressão do pedido
		impressaoPedi.setarRichPara40Colunas();
		impressaoPedi.limparTexto();
		RelLinha1 := FTabTele.retornarVariavel('RelLinha1','RelLinha1');
		if not (FTabTele.retornarVariavelBool('ResumirCabecalhoNoFinalizar','false')) then begin
			RelLinha2 := FTabTele.retornarVariavel('RelLinha2','RelLinha2');
			RelLinha3 := FTabTele.retornarVariavel('RelLinha3','RelLinha3');
		end;
		impressaoPedi.imprimirCabecalho(RelLinha1,RelLinha2,RelLinha3,false);
		impressaoPedi.imprimirDataHoraNPedido(DateToStr(dataBancoDeDados),TimeToStr(dataBancoDeDados),nrPedido);
		if (FunDB.verificarExistenciaDeRegistro(qryTemporaria,'SELECT Fone1, Nome, Logradouro, Numero, Complemento, Bairro, Cidade, Referencia'+
		'	FROM Cliente Where Contador = '+IntToStr(FrmPedido.retornarCliente()))) then begin
			nome_e_codigo := qryTemporaria.FieldByName('Fone1').AsString+' '+qryTemporaria.FieldByName('Nome').AsString;
			impressaoPedi.escreverDadosCliente40Colunas (
				FTabTele.retornarVariavel('campoCodigoCliente','Telefone'),
				qryTemporaria.FieldByName('Fone1').AsString,
				qryTemporaria.FieldByName('Nome').AsString,
				qryTemporaria.FieldByName('Logradouro').AsString,
				qryTemporaria.FieldByName('Numero').AsString,
				qryTemporaria.FieldByName('Bairro').AsString,
				qryTemporaria.FieldByName('Complemento').AsString,
				qryTemporaria.FieldByName('Referencia').AsString
			);
		end else begin
			result := false;
			Exit;
		end;
		impressaoPedi.escreverRotuloDeItens40Colunas(FTabTele.retornarVariavelBool('ImprimeVlItem','false'));
		impressaoPedi.selecionarTexto(1,impressaoPedi.retornarTamanhoTexto(),true);

		if (ordemItensPedido = 1) then begin
			sqlItensPedi :=
				'SELECT PedidoMovimentacao.*, ProdutoGrupo.Nome '+
				'FROM PedidoMovimentacao, Produto, ProdutoGrupo WHERE IdCliente = '+
				IntToStr(FrmPedido.retornarCliente())+
				' AND ProdutoGrupo.Contador = Produto.idProdutoGrupo AND '+
				'PedidoMovimentacao.idPedaco1 = Produto.Contador ORDER BY ProdutoGrupo.Nome ASC ';
		end else begin
			sqlItensPedi := 'SELECT PedidoMovimentacao.* FROM PedidoMovimentacao WHERE IdCliente = '
				+IntToStr(FrmPedido.retornarCliente())+' ORDER BY PedidoMovimentacao.Contador ASC';
		end;

		if FunDB.verificarExistenciaDeRegistro(qryTempItemPedi,sqlItensPedi) then begin
			FunDB.iniciarTransacao(FTabTele.DBCommerce);

			//-- deve ficar depois da impressao do observação
			FTabTele.gravarDadosDoPedido(
				cdPedido,FrmPedido.retornarCliente(),lcbFormaPagamento.KeyValue,0,speDias.Value,-1,
				StrToFloat(edtTotal.Text),StrToFloat(edtAcrescimo.Text),StrToFloat(edtTaxaDeEntrega.Text),
				StrToFloat(edtValorPago.Text),
				nrPedido,edtObs.Text,StrToTime(meHoraEntrega.text)
			);

			//-- Imprime todos os itens de pedido
			while not qryTempItemPedi.Eof do begin
				if (imprimirGrupoDoProduto) then begin
					FunDB.abrirQuery(qryTemporaria,
						'SELECT PRODUTOGRUPO.NOME FROM PRODUTOGRUPO, PRODUTO '+
						'WHERE PRODUTOGRUPO.CONTADOR = PRODUTO.IDPRODUTOGRUPO AND PRODUTO.CONTADOR = '+
						qryTempItemPedi.FieldByName('IdPedaco1').AsString
					);
					ImpressaoPedi.imprimirLinhaOrdEsquerda(qryTemporaria.FieldByName('NOME').AsString);
				end;

				//-- Imprime cada item pedaço por pedaço
				for cont := 1 to (qryTempItemPedi.FieldByName('QtPedaco').AsInteger) do begin

					cadastrarItemPedidoNoHistorico(
						qryTempItemPedi.FieldByName('Quantidade').AsInteger,
						CdPedido,
						qryTempItemPedi.FieldByName('IdPedaco'+IntToStr(cont)).AsInteger,
						qryTempItemPedi.FieldByName('QtPedaco').AsInteger,
//						qryTempItemPedi.FieldByName('VlPedaco'+IntToStr(cont)).AsFloat,
						qryTempItemPedi.FieldByName('ValorUnitario').AsFloat,
						qryTempItemPedi.FieldByName('Obs'+IntToStr(cont)).AsString
						);

					//-- Baixa do estoque
					qtRealDeItem := qryTempItemPedi.FieldByName('Quantidade').AsInteger / qryTempItemPedi.FieldByName('QtPedaco').AsInteger;
					FunDB.executarQuery(qryTemporaria,
						'EXECUTE PROCEDURE BAIXA_DE_PRODUTO('+
						FloatToStr(qtRealDeItem)+
						','+
						qryTempItemPedi.FieldByName('IdPedaco'+IntToStr(cont)).AsString+
						')'
					);

				end;
				qryTempItemPedi.Next();

				//-- Imprimir separador
				if not(qryTempItemPedi.Eof) then ImpressaoPedi.imprimirSeparador40Item();

			end;

			//-- Controla brindes
			if (FTabTele.retornarVariavel('controlaBrinde','false') = 'true') then begin
				//-- Atualiza campo de pontuacao do usuario
				pontos := FTabTele.retornarPontuacaoDePedidoMovimentacao(FrmPedido.retornarCliente());
				saldo := FTabTele.retornarPontuacaoDoCliente(FrmPedido.retornarCliente());
				FTabTele.alterarPontuacaoDoCliente(FrmPedido.retornarCliente(), pontos+saldo);
			end;

			executarQuery(qryTemporaria,'DELETE FROM PedidoMovimentacao WHERE IdCliente = '+IntToStr(FrmPedido.retornarCliente()));

			FunDB.finalizarTransacao(FTabTele.DBCommerce);
		end else begin
			MessageDlg('Erro! Nenhum item de pedido encontrado!', mtError, [mbOk], 0);
		end;
		impressaoPedi.selecionarTexto(1,impressaoPedi.retornarTamanhoTexto(),false);
		impressaoPedi.imprimirObsDoCliente(edtObs.Text);
		if (FTabTele.retornarVariavelBool('MostraValoresNoFinalizar','true')) then begin
			impressaoPedi.imprimirSeparador40Secundario();
			impressaoPedi.imprimirFormaPagamento(lcbFormaPagamento.KeyValue,speDias.Text,qryTemporaria);
			//-- Valores
			impressaoPedi.escreverLinha40ColE('Sub-Total : R$ '+EscreveN(StrToFloat(edtProdutos.Text),10,2));
			if StrToFloat(edtTaxaDeEntrega.Text) <> 0 then impressaoPedi.escreverLinha40ColE('Taxa entr.: R$ '+EscreveN(StrToFloat(edtTaxaDeEntrega.Text),10,2));
			if StrToFloat(edtAcrescimo.Text) < 0 then impressaoPedi.escreverLinha40ColE('Desconto  : R$ '+EscreveN(StrToFloat(edtAcrescimo.Text),10,2)+'  '+speDescontoPercentual.Text+'%');
			if StrToFloat(edtAcrescimo.Text) > 0 then impressaoPedi.escreverLinha40ColE('Acrescimo : R$ '+EscreveN(StrToFloat(edtAcrescimo.Text),10,2)+'  '+speAcrescimoPercentual.Text+'%');
			//-- Impressao do total **Negrito
			impressaoPedi.selecionarTexto(4,impressaoPedi.retornarTamanhoTexto(),true);
			impressaoPedi.escreverLinha40ColE('Total     : R$ '+EscreveN(StrToFloat(edtTotal.Text),10,2));
			impressaoPedi.selecionarTexto(4,impressaoPedi.retornarTamanhoTexto(),false);
			//-- Valor pago
			impressaoPedi.escreverLinha40ColE('Vl. pago  : R$ '+EscreveN(StrToFloat(edtValorPago.Text),10,2));
			//-- Impressao do troco **Negrito
			impressaoPedi.selecionarTexto(5,impressaoPedi.retornarTamanhoTexto(),true);
			impressaoPedi.escreverLinha40ColE('Troco     : R$ '+EscreveN(StrToFloat(edtTroco.Text),10,2));
			impressaoPedi.selecionarTexto(5,impressaoPedi.retornarTamanhoTexto(),false);
		end;
		//-- Verifica se esta configurado p/ imprimir vendedor
		impressaoPedi.escreverVendedor40colunas(dblcVendedor.Text,FTabTele.retornarVariavelBool('UsaVendedor','false'));
		//-- Hora de previsao
		impressaoPedi.imprimirHorarioPrevisao(meHoraEntrega.Text,FloatToInt(StrToInt(speMinutos.Text)));
		//-- Rodape
		if (FTabTele.retornarVariavelBool('MostraRodapeNoFinalizar','true')) then begin
			if FTabTele.retornarVariavel('MsgRel','Agradecemos a preferência!') = null then MsgFinalRel := '' else MsgFinalRel := FTabTele.retornarVariavel('MsgRel','Agradecemos a preferência!');
			impressaoPedi.escreverRodape40Colunas(MsgFinalRel);
		end;
		//-- Controla brindes
		if (FTabTele.retornarVariavel('controlaBrinde','false') = 'true') then begin
			//-- Imprime saldo e nova pontuação
			impressaoPedi.imprimirSeparador40Principal();
			impressaoPedi.escreverLinha40ColE(' ');
			impressaoPedi.imprimirSeparador40Principal();
			impressaoPedi.imprimirDataHoraNPedidoSemTraco(DateToStr(dataBancoDeDados),TimeToStr(dataBancoDeDados),nrPedido);
			impressaoPedi.escreverLinha40ColE('Cliente: '+nome_e_codigo);
			impressaoPedi.escreverLinha40ColE('Pontos : '+IntToStr(pontos)+' Saldo Acumulado: '+IntToStr(pontos+saldo));
		end;
		//-- Finalização
		ImpressaoPedi.imprimirLinhaEmBrancoEspecial(StrToInt(FTabTele.retornarVariavel('NuLinhasBranco','10')),FTabTele.retornarVariavelBool('ImprimeEspecial','false'));
		if (FTabTele.retornarVariavelBool('ImprimeEspecial','false')) then impressaoPedi.transformarSelecoesEmNegrito();
		ImpressaoPedi.irParaInicio();
		//-- Resize da previsão para impressoras 40 colunas
		if (FTabTele.retornarVariavelBool('VisualizarPedido','true')) then impressaoPedi.mostrarPrevisao();

		if (ImpressaoPedi.enviarParaImpressora(FTabTele.retornarVariavelBool('ConfImpPedi','true'),FTabTele.retornarVariavelBool('ImprimeEspecial','false'),StrToInt(FTabTele.retornarVariavel('NuLinhasBranco','10')))) then begin

			//-- Se foi configurado para imprimir mais cópias o programa imprime sem abrir a janela de confirmação
			copiasImpress := 1; 
			while copiasImpress < numeroCopiasImpressao do
			begin
				Inc(copiasImpress);
				ImpressaoPedi.enviarParaImpressora(false,FTabTele.retornarVariavelBool('ImprimeEspecial','false'),StrToInt(FTabTele.retornarVariavel('NuLinhasBranco','10')));
			end;

			result := true;
		end else begin
			result := false;
		end;

	except
		FunDB.cancelarTransacao(FTabTele.DBCommerce);
		MessageDlg('Erro ao gravar itens de pedido!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoFinalizacao.edtObsKeyPress(Sender: TObject; var Key: Char);
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
procedure TfrmPedidoFinalizacao.btnImprimirClick(Sender: TObject);
begin
	if not btnFinalizar.Enabled then begin
		ImpressaoPedi.enviarParaImpressora(FTabTele.retornarVariavelBool('ConfImpPedi','true'),FTabTele.retornarVariavelBool('ImprimeEspecial','false'),StrToInt(FTabTele.retornarVariavel('NuLinhasBranco','10')));
	end else begin
		MessageDlg('Para imprimir é necessário já ter finalizado o pedido!', mtInformation, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
//-- Inclui item de pedido em ItePedi
procedure TfrmPedidoFinalizacao.cadastrarItemPedidoNoHistorico(p_Qtde, p_CdPedido, p_CdPedaco, p_QtPedaco: Integer; p_VlProduto: real; p_Obs: String);
var	quantProduto : string;
		vlTotProduto : real;
begin
	vlTotProduto := p_VlProduto*(p_Qtde/p_QtPedaco);
	FTabTele.iaePedidoItem.Query[ukInsert].ParamByName('Contador').AsInteger  := FTabTele.buscarMaxContadorDBTele('PedidoItem');
	FTabTele.iaePedidoItem.Query[ukInsert].ParamByName('IdPedido').AsInteger  := p_CdPedido;
	FTabTele.iaePedidoItem.Query[ukInsert].ParamByName('IdProduto').AsInteger := p_CdPedaco;
	FTabTele.iaePedidoItem.Query[ukInsert].ParamByName('QtProduto').AsInteger := p_Qtde;
	FTabTele.iaePedidoItem.Query[ukInsert].ParamByName('QtPedaco').AsInteger  := p_QtPedaco;
	FTabTele.iaePedidoItem.Query[ukInsert].ParamByName('VlProduto').AsFloat   := p_VlProduto;
	FTabTele.iaePedidoItem.Query[ukInsert].ParamByName('VlTotal').AsFloat     := vlTotProduto;
	FTabTele.iaePedidoItem.Query[ukInsert].ParamByName('Obs').AsString        := p_Obs;
	FTabTele.iaePedidoItem.Query[ukInsert].ExecSQL();
	abrirQuery(qryTemporaria,'Select Nome, Codigo from Produto where contador = '+IntToStr(p_CdPedaco));
	if (p_QtPedaco > 1) then
		quantProduto := IntToStr(p_Qtde)+'/'+IntToStr(p_QtPedaco)
	else
		quantProduto := IntToStr(p_Qtde);
	impressaoPedi.imprimirItemPedido(
		quantProduto,
		qryTemporaria.FieldByName('Nome').AsString,
		qryTemporaria.FieldByName('Codigo').AsString,
		p_VlProduto,
		vlTotProduto,
		FTabTele.retornarVariavelBool('ImprimeVlItem','false')
  );
	impressaoPedi.escreverLinha40ColVerif(p_Obs,'Obs: '+p_Obs);
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoFinalizacao.meHoraEntregaExit(Sender: TObject);
begin
  if verificarHora(meHoraEntrega.text) then speMinutos.Text := IntToStr(FunGeral.DiferencaMinutos(now,StrToTime(meHoraEntrega.text),StrTodate('01/01/01'),StrTodate('01/01/01')));
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoFinalizacao.smMinEntregaClick(Sender: TObject);
begin
  speMinutos.SetFocus;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoFinalizacao.calcularTotal();
var percent: real;
begin
	try
		edtSubTotal.Text	:= FunGeral.retornarStringMonetaria(StrToFloat(edtProdutos.Text)+StrToFloat(edtTaxaDeEntrega.Text));
		edtTotal.Text		:= FunGeral.retornarStringMonetaria(StrToFloat(edtProdutos.Text)+StrToFloat(edtTaxaDeEntrega.Text)+StrToFloat(edtAcrescimo.Text));
		//-- Se o valor pago já foi alterado para um valor superior então não mexe
		if (StrToFloat(edtValorPago.Text) <= StrToFloat(edtTotal.Text)) then edtValorPago.Text := FunGeral.retornarStringMonetaria(StrToFloat(edtTotal.Text));
		edtTroco.Text		:= FunGeral.retornarStringMonetaria(StrToFloat(edtValorPago.Text)-StrToFloat(edtTotal.Text));
		if StrToFloat(edtTroco.Text) < 0 then begin
			edtValorPago.Text := edtTotal.Text;
			MessageDlg('O valor digitado é menor que o valor do pedido'+#13+'Foi assumido como valor pago o valor total da venda.', mtInformation, [mbOk], 0);
			edtTroco.Text := '0';
		end;
		if (StrToFloat(edtSubTotal.Text) <> 0) then
			percent := (StrToFloat(edtAcrescimo.Text)/StrToFloat(edtSubTotal.Text))*100
		else
			percent := 0;
		//-- Atualiza campos de acrescimo e desconto em percentual
		if (StrToFloat(edtAcrescimo.Text) < 0) then begin
			speAcrescimoPercentual.Value := 0;
			speDescontoPercentual.Value := Round(percent);
		end else begin
			speDescontoPercentual.Value := 0;
			speAcrescimoPercentual.Value := Round(percent);
		end;
	except
		MessageDlg('Erro ao calcular total!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoFinalizacao.FormDestroy(Sender: TObject);
begin
	ImpressaoPedi.destruirInstancia();
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoFinalizacao.speMinutosExit(Sender: TObject);
begin
  if (speMinutos.Value < 1) then meHoraEntrega.Text := '00:00' else meHoraEntrega.Text := Copy(IncrementarMinutos(now,speMinutos.Value),1,5);
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoFinalizacao.btnSalvarPreferenciaClick(Sender: TObject);
begin
	FTabTele.salvarPreferenciaDoCliente(edtObs.Text,FrmPedido.retornarCliente());
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoFinalizacao.speMinutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  try
	 if Key = Word(#13) then begin
		SelectNext(Sender as tWinControl, True, True );
		Key := Word(#0);
	 end;
  except
	 MessageDlg('Erro ao focar próximo campo!', mtError, [mbOk], 0);
  end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoFinalizacao.mitFecharClick(Sender: TObject);
begin
	Close();
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoFinalizacao.edtAcrescimoExit(Sender: TObject);
var tmpEdit: TEdit;
begin
	//-- Atualiza o campo de vldesconto qdo sair do cmp de percentual
	if (Sender = speDescontoPercentual)or(Sender = speAcrescimoPercentual) then begin
		edtAcrescimo.Text := FunGeral.retornarStringMonetaria(-((StrToFloat(edtSubTotal.Text) * (StrToFloat(speDescontoPercentual.Text)-StrToCurr(speAcrescimoPercentual.Text))) / 100));
		edtTotal.Text := FunGeral.retornarStringMonetaria(StrToFloat(edtProdutos.Text)+StrToFloat(edtTaxaDeEntrega.Text)+StrToFloat(edtAcrescimo.Text));
	end;
	if (Sender.ClassNameIs('TEdit')) then begin
		tmpEdit := TEdit(Sender);
		if (tmpEdit.Text = '') then tmpEdit.Text := FunGeral.retornarStringMonetaria(0);
		tmpEdit.Text := FunGeral.retornarStringMonetaria(StrToFloat(tmpEdit.Text));
		if (Sender = edtValorPago)and(FTabTele.retornarVariavel('calculaDescAcres','false') = 'true') then edtAcrescimo.Text := FunGeral.retornarStringMonetaria(StrToFloat(edtValorPago.Text)-StrToFloat(edtSubTotal.Text));
	end;
	calcularTotal();
//	if (Sender = edtValorPago)and(speAcrescimoPercentual.Value > 15) then edtAcrescimo.Text := FunGeral.retornarStringMonetaria(StrToFloat(edtValorPago.Text)-StrToFloat(edtSubTotal.Text));
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoFinalizacao.lcbFormaPagamentoClick(Sender: TObject);
begin
	if (lcbFormaPagamento.KeyValue = 3) then begin
		PChequepre.Visible := True;
	end else begin
		PChequepre.Visible := False;
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoFinalizacao.edtTaxaDeEntregaKeyPress(Sender: TObject;
  var Key: Char);
begin
  try
	 if not (key in['0'..'9', #8, #13,'.',',','-']) then key := #0;
	 if Key = ',' then Key := '.';
	 if Key = #13 then begin
		SelectNext(Sender as tWinControl, True, True );
		Key := #0;
	 end;
  except
	 MessageDlg('Erro ao focar próximo campo!', mtError, [mbOk], 0);
  end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoFinalizacao.habilitarBotaoImprimir(p_Habilita: bool);
begin
	btnImprimir.Enabled := p_Habilita;
	mitImprimir.Enabled := p_Habilita;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoFinalizacao.habilitarBotaoAlterar(p_Habilita: bool);
begin
	btnAlterar.Enabled := p_Habilita;
	mitAlterar.Enabled := p_Habilita;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoFinalizacao.habilitarBotaoFinalizar(p_Habilita: bool);
begin
	btnFinalizar.Enabled := p_Habilita;
	mitFinalizar.Enabled := p_Habilita;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmPedidoFinalizacao.mitDividirContaClick(Sender: TObject);
var 	inputStr : String;
		valorDiv : String;
begin
	inputStr := '1';
	if (InputQuery('Dividir a conta', 'Quantidade de partes', inputStr)) then begin
		valorDiv := FunGeral.retornarStringMonetaria(StrToFloat(edtTotal.Text)/StrToInt(inputStr));
		MessageDlg(
			'A conta de R$ '+FunGeral.retornarStringMonetaria(StrToFloat(edtTotal.Text))+
			' dividida em '+inputStr+' partes fica em:'+#13+
			'R$ '+valorDiv,
			mtInformation, [mbOk], 0
		);
	end;
end;

end.
//-----------------------------------------------------------------------------------------------
//   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM
//-----------------------------------------------------------------------------------------------

