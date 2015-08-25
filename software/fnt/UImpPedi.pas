{------------------------------------------------------------------------------------------------

              O C E A N O   -    M A R    D E    S O L U Ç Õ E S

-------------------------------------------------------------------------------------------------
                                I N I C I O
-------------------------------------------------------------------------------------------------
Criação      : 27/12/2001 15:00
Local        : Escritório, Florianópolis
Autor(es)    : Cleber Amaral
               Iomani Engelmann Gomes
Descrição    : Classe genérica pra impressao de pedido
Comentário   :

-------------------------------------------------------------------------------------------------
Atualização  : 27/12/2001 18:00
Autor(es)    : Iomani Engelmann Gomes
Comentário   : Alteraçao da classe para passagem de parametros

-------------------------------------------------------------------------------------------------}
unit UImpPedi;
//-----------------------------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------------------------
uses
comctrls{p/ RichEdit},
UFuncoes,
Sysutils{p/ DateToStr},
graphics,{p/ font Style}
Db,
Printers, {p/ impressao canvas}
Dialogs, {p/ MessageDlg}
Forms,
StdCtrls, {p/ TCustomGrid.ScrollBars}
DBTables,
UPrevisaoImp,
UFunGeral;
//-----------------------------------------------------------------------------------------------
type ImpPedi = class
	private
	protected
		rePrevisao	: ^TRichEdit;
		//  FrmPrev			:	TFrmPrevisaoImp;
		FrmPrev		: TForm;
		rePadrao		: TRichEdit;
		inicioSel,
		fimSel     : integer; //-- p/ configuração de style do texto
		ini: array[1..10] of Integer;
		fim: array[1..10] of Integer;
		sql : string;
		FunGeral	:TFunGeral;
	public
		//--Construtores
		constructor criarInstancia();
		destructor destruirInstancia();
		procedure escreverDadosCliente40Colunas(pCampo,pFone,pNome,pLogradouro,pNumero,pBairro,pComplemento,pReferencia:string);
		procedure escreverRotuloDeItens40Colunas(pImprimirValorItem:boolean);
		procedure escreverRodape40Colunas(pMsgRel:string);
		procedure escreverCabecalho80Colunas(pRelLinha1,pRelLinha2,pRelLinha3,pNrPedido:string);
		procedure escreverRodape80Colunas(pFone,pNome,pLogradouro,pNumero,pBairro,pComplemento,pReferencia,pMinutos,pHoraEntrega,pMsgRel:string);
		procedure escreverCabecalho40Colunas(pRelLinha1,pRelLinha2,pRelLinha3:string;segVia:boolean);
		procedure imprimirCabecalho(r1,r2,r3:Variant;segVia:boolean);
		procedure setarRePrev(pRePrev : Pointer);
		procedure trasformarEmNegrito(pInicio, pFim : Integer);
		procedure selecionarTexto(pIndice, pValor : Integer; pInicio : boolean);
		procedure limparSelecoes();
		procedure transformarSelecoesEmNegrito();
		procedure escreverVendedor40colunas(pVendedor:string;pUsaVendedor:Boolean);
		procedure escreverLinha40ColVerif(pMsgVerif,pMsg:string);
		procedure escreverLinha40ColC(pMsg:string);
		procedure escreverLinha40ColE(pMsg:string);
		procedure imprimirObsDoCliente(pMsg:string);
		procedure imprimirFormaPagamento(pMsg, pDias:string; pQuery : TQuery);
		procedure imprimirHorarioPrevisao(pMsg:string;pMin:Integer);
		procedure imprimirDataHoraNPedido(pData,pHora,pNPedido:string);
		procedure imprimirDataHoraNPedidoSemTraco(pData,pHora,pNPedido:string);
		procedure imprimirItemPedido(pQt,pNome,pCodigo:string;pValorUnit,pValorTotal:Real;pImpValor:boolean);
		procedure chamarImprimirItemPedido(pQueryTemp,pQueryItem:TQuery;pImpVl:boolean);
		procedure imprimirLinhaEmBranco(pNLinhas: Byte);
		procedure imprimirLinhaEmBrancoEspecial(pNLinhas: Byte; pImprimeEspecial: boolean);
		procedure imprimirSeparador40Principal();
		procedure imprimirSeparador40Secundario();
		procedure imprimirSeparador40Item();
		procedure configurarFonte();
		procedure irParaInicio();
		function enviarParaImpressora(pConfirma,pImprimeEspecial:Boolean;pNuLinhaEmBranco:integer): boolean;
		procedure imprimirLinhasdoMemo(pImprimeEspecial : boolean; pNuLinhaEmBranco: integer);
		procedure limparTexto();
		procedure setarRichPadrao();
		procedure setarRichPara40Colunas();
		procedure mostrarPrevisao();
		function retornarTamanhoTexto():integer;
		procedure PressionarBotaoNoPrevisao(Sender: TObject; var Key: Char);
		procedure imprimirLinhaOrdEsquerda(pTexto:string);
	end;
//-----------------------------------------------------------------------------------------------
implementation
//-----------------------------------------------------------------------------------------------
constructor ImpPedi.criarInstancia;
begin
	FrmPrev := TForm.Create(nil);
	rePadrao := TRichEdit.Create(FrmPrev);
	rePadrao.Parent := FrmPrev;
	rePadrao.Width      := 345;
	rePadrao.ScrollBars := ssVertical;
	rePadrao.ReadOnly := true;
	setarRichPadrao();
	configurarFonte();
end;
//-----------------------------------------------------------------------------------------------
procedure ImpPedi.PressionarBotaoNoPrevisao(Sender: TObject; var Key: Char);
begin
	 if (Key = #27) or (Key = #13) then FrmPrev.Close();
end;
//-----------------------------------------------------------------------------------------------
destructor ImpPedi.destruirInstancia();
begin
	rePadrao.Free();
	FrmPrev.Free();
end;
//-----------------------------------------------------------------------------------------------
//-- Alterar richEdit
procedure ImpPedi.setarRePrev(pRePrev : Pointer);
begin
  rePrevisao := pRePrev;
end;
//-----------------------------------------------------------------------------------------------
//-- Escreve dados do cliente 40 colunas
procedure ImpPedi.escreverDadosCliente40Colunas(pCampo, pFone, pNome, pLogradouro, pNumero, pBairro, pComplemento, pReferencia:string);
begin
  rePrevisao.Lines.Add('- - - - - - - - - - - - - - - - - - - - ');
  rePrevisao.Lines.Add(EscreveE(pCampo,7)+': '+EscreveE(pFone,31));
  if (pNome <> '') then rePrevisao.Lines.Add(EscreveE('Nome   : '+pNome,40));
  if (pLogradouro <> '') then escreverLinha40ColE('Logra. : '+pLogradouro);
  if (pNumero <> '') then rePrevisao.Lines.Add(EscreveE('Nº     : '+pNumero,40));
  if (pComplemento <> '') then escreverLinha40ColE('Comple.: '+pComplemento);
  if (pBairro <> '') then rePrevisao.Lines.Add(EscreveE('Bairro : '+pBairro,40));
  if (pReferencia <> '') then escreverLinha40ColE('Refer. : '+pReferencia);
end;
//-----------------------------------------------------------------------------------------------
//-- Escreve no TexFile cabeçalho em 80 colunas
procedure ImpPedi.escreverCabecalho80Colunas(pRelLinha1,pRelLinha2,pRelLinha3,pNrPedido:string);
begin
//Centraliza  12345678901234567890123456789012345678901234567890123456789012345678901234567890
  rePrevisao.Lines.Add('================================================================================');
  if pRelLinha1 <> '' then rePrevisao.Lines.Add(EscreveC(pRelLinha1,80));
  if pRelLinha2 <> '' then rePrevisao.Lines.Add(EscreveC(pRelLinha2,80));
  if pRelLinha3 <> '' then rePrevisao.Lines.Add(EscreveC(pRelLinha3,80));
  rePrevisao.Lines.Add('--------------------------------------------------------------------------------');
  rePrevisao.Lines.Add('              Data: '+DateToStr(Date)+'  Hora: '+TimeToStr(Time)+'   Ped. Nº: '+pNrPedido );
  rePrevisao.Lines.Add('--------------------------------------------------------------------------------');
  rePrevisao.Lines.Add('It. Qt.: Código:    Nome:                                Vl. Unit.: Valor total:');
  rePrevisao.Lines.Add('--------------------------------------------------------------------------------');
end;
//-----------------------------------------------------------------------------------------------
//-- Escreve no TexFile rodape com info do cliente em 40 colunas
procedure ImpPedi.escreverRodape40Colunas(pMsgRel:string);
begin
  imprimirSeparador40Secundario();
  escreverLinha40ColVerif(pMsgRel,pMsgRel);
end;
//-----------------------------------------------------------------------------------------------
//-- Escreve no TexFile rótulo dos item em 40 col
procedure ImpPedi.escreverRotuloDeItens40Colunas(pImprimirValorItem:boolean);
begin
  imprimirSeparador40Secundario();
  if (pImprimirValorItem) then begin
	 rePrevisao.Lines.Add(EscreveE('Qt.',3)+Space(1)+EscreveE('Nome',18)+Space(1)+EscreveD('Unidade',8)+Space(1)+EscreveD('Valor',8));
  end
  else begin
	 rePrevisao.Lines.Add(EscreveE('Cód. ',5)+Space(1)+EscreveE('Nome',21)+Space(1)+EscreveE('Qt.',3)+Space(1)+EscreveD('Valor',8));
  end;
  imprimirSeparador40Secundario();
end;
//-----------------------------------------------------------------------------------------------
//-- Escreve no TexFile cabeçalho em 40 colunas
procedure ImpPedi.escreverCabecalho40Colunas(pRelLinha1,pRelLinha2,pRelLinha3:string;segVia:boolean);
begin
	if (segVia) then
		rePrevisao.Lines.Add('------------ Segunda Via ---------------')
	else
		imprimirSeparador40Principal();
	escreverLinha40ColC(pRelLinha1);
	escreverLinha40ColC(pRelLinha2);
	escreverLinha40ColC(pRelLinha3);
end;
//-----------------------------------------------------------------------------------------------
//-- trata strings de cabeçalho e imprime
procedure ImpPedi.imprimirCabecalho(r1,r2,r3:Variant;segVia:boolean);
var RelLinha1,
    RelLinha2,
	 RelLinha3 : string;
begin
  if r1 = null then RelLinha1 := '' else RelLinha1 := r1;
  if r2 = null then RelLinha2 := '' else RelLinha2 := r2;
  if r3 = null then RelLinha3 := '' else RelLinha3 := r3;
  escreverCabecalho40Colunas (RelLinha1, RelLinha2, RelLinha3, segVia);
end;
//-----------------------------------------------------------------------------------------------
//-- Escreve no TexFile rodape com info do cliente em 80 colunas
procedure ImpPedi.escreverRodape80Colunas(pFone,pNome,pLogradouro,pNumero,pBairro,
														pComplemento,pReferencia,pMinutos,pHoraEntrega,pMsgRel:string);
begin
  rePrevisao.Lines.Add('--------------------------------------------------------------------------------');
  rePrevisao.Lines.Add(EscreveE('Fone  : '+pFone+Space(2)+'Nome : '+pNome,80));
  rePrevisao.Lines.Add(EscreveE('Logra.: '+pLogradouro,65)+Space(1)+'Nº'+EscreveD(pNumero,5)); //Linha = 80char
  rePrevisao.Lines.Add(EscreveE('Bairro: '+pBairro,20)+Space(1)+'Comple.: '+pComplemento);
  rePrevisao.Lines.Add('Refer.: '+pReferencia);
  rePrevisao.Lines.Add('--------------------------------------------------------------------------------');
  if (pMinutos<>'') then begin
	 rePrevisao.Lines.Add('Hora prevista para Entrega: '+pHoraEntrega);
	 rePrevisao.Lines.Add('--------------------------------------------------------------------------------');
  end;
  if pMsgRel <> '' then rePrevisao.Lines.Add(EscreveC(pMsgRel,80));
  rePrevisao.Lines.Add('================================================================================');
end;
//-----------------------------------------------------------------------------------------------
//-- Atraves de um texto selecionado transforma em negrito
procedure ImpPedi.trasformarEmNegrito(pInicio, pFim : Integer);
begin
  rePrevisao.SelStart  := pInicio;
  rePrevisao.SelLength := pFim-pInicio;
  rePrevisao.SelAttributes.Style := [fsBold];
end;
//-----------------------------------------------------------------------------------------------
//-- Utiliza variaveis para fazer uma seleção para posteior negrito
procedure ImpPedi.selecionarTexto(pIndice, pValor : Integer; pInicio : boolean);
begin
  if (pInicio) then
  begin
    ini[pIndice] := pValor;
  end
  else
  begin
    fim[pIndice] := pValor;
  end;
end;
//-----------------------------------------------------------------------------------------------
//-- Limpa seleções de texto
procedure ImpPedi.limparSelecoes();
var i : Integer;
begin
  for i:=1 to 7 do begin
	 ini[i] := 0;
	 fim[i] := 0;
  end;
end;
//-----------------------------------------------------------------------------------------------
//-- Transformar selecoes em negrito
procedure ImpPedi.transformarSelecoesEmNegrito();
var i : Integer;
begin
  for i:=1 to 7 do begin
	 trasformarEmNegrito(ini[i], fim[i]);
  end;
end;
//-----------------------------------------------------------------------------------------------
//-- Escreve nome do vendedor em 40 colunas
procedure ImpPedi.escreverVendedor40colunas(pVendedor:string; pUsaVendedor:Boolean);
begin
  if pUsaVendedor then begin
	 //-- Essa verificação ja é feita na chamada do btfinalizar
	 if (pVendedor <> '') then begin
		imprimirSeparador40Secundario();
		rePrevisao.Lines.Add('Vendedor: '+pVendedor);
	 end;
  end;
end;
//-----------------------------------------------------------------------------------------------
//-- Escreve texto qualquer, se a msg verif nao for nula, fazendo quebra de linha se necessario
procedure ImpPedi.escreverLinha40ColVerif(pMsgVerif,pMsg:string);
var i   : integer;
	 msg : string;
begin
  if (length(pMsgVerif) > 0) then begin
	 msg := pMsg;
	 if (length(pMsg) <= 40) then begin
		rePrevisao.Lines.Add(escreveE(msg,40))
	 end
	 else begin
		for i := 1 to ((length(pMsg) div 40) + 1) do begin
		  rePrevisao.Lines.Add(escreveE(msg,40));
		  delete(msg,1,40);
		end;
	 end;
  end;
end;
//-----------------------------------------------------------------------------------------------
//-- Escreve texto, se a msg nao for nula (Centralizado)
procedure ImpPedi.escreverLinha40ColC(pMsg:string);
begin
  if (length(pMsg) > 0) then rePrevisao.Lines.Add(escreveC(pmsg,40))
end;

//-----------------------------------------------------------------------------------------------
//-- Escreve texto, se a msg nao for nula (Justificado pela esquerda)
procedure ImpPedi.escreverLinha40ColE(pMsg:string);
var iLe : integer;
    msg : string;
begin
  if (length(pMsg) > 0) then begin
    msg := pMsg;
	 iLe := length(pMsg);
    while (iLe > 0) do
    begin
      iLe := iLe-40; 
      rePrevisao.Lines.Add(escreveE(msg,40));
      delete(msg,1,40);
    end;
  end;
end;
//-----------------------------------------------------------------------------------------------
//-- Imprime Obs do cliente
procedure ImpPedi.imprimirObsDoCliente(pMsg:string);
begin
	if pMsg <> '' then begin
		imprimirSeparador40Secundario();
		selecionarTexto(2,Length(rePrevisao.Text),true);
		escreverLinha40ColVerif(pMsg,'Observação: '+pMsg);
		selecionarTexto(2,Length(rePrevisao.Text),false);
	end;
end;
//-----------------------------------------------------------------------------------------------
//-- Imprime Forma de pagamento
procedure ImpPedi.imprimirFormaPagamento(pMsg, pDias:string; pQuery : TQuery);
begin
//-- Forma de pagamento
  sql := ('Select Nome from FormaPagamento where contador = '+FunGeral.retornarStringSQL(pMsg));
  abrirQuery(pQuery,sql);
//-- Impressao Forma de pagamento
  selecionarTexto(3,Length(rePrevisao.Text),true);
  rePrevisao.Lines.Add('Form. pag.: '+EscreveE(pQuery.FieldByName('Nome').AsString,11)+'('+EscreveE(pDias,3)+')');
  selecionarTexto(3,Length(rePrevisao.Text),false);
end;
//-----------------------------------------------------------------------------------------------
//-- Imprime Horário Previsão de entrega
procedure ImpPedi.imprimirHorarioPrevisao(pMsg:string;pMin:Integer);
begin
	if (pMin > 0) then begin
		imprimirSeparador40Secundario();
		selecionarTexto(6,Length(rePrevisao.Text),true);
		rePrevisao.Lines.Add('Hora prevista para entrega: '+EscreveE(pMsg,5));
		selecionarTexto(6,Length(rePrevisao.Text),false);
	end;
end;
//-----------------------------------------------------------------------------------------------
//-- Imprime Data hora e NºPedido
procedure ImpPedi.imprimirDataHoraNPedido(pData,pHora,pNPedido:string);
begin
	imprimirSeparador40Secundario();
	imprimirDataHoraNPedidoSemTraco(pData,pHora,pNPedido);
end;
//-----------------------------------------------------------------------------------------------
//-- Imprime Data hora e NºPedido
procedure ImpPedi.imprimirDataHoraNPedidoSemTraco(pData,pHora,pNPedido:string);
begin
  selecionarTexto(7,Length(rePrevisao.Text),true);
  rePrevisao.Lines.Add('Dt: '+pData+' Hr: '+pHora+' Nº: '+pNPedido);
  selecionarTexto(7,Length(rePrevisao.Text),false);
end;
//-----------------------------------------------------------------------------------------------
//-- Imprime Item de pedido
procedure ImpPedi.imprimirItemPedido(pQt,pNome,pCodigo:string;pValorUnit,pValorTotal:Real;pImpValor:boolean);
begin
  if (pImpValor) then begin
	 rePrevisao.Lines.Add(EscreveE(pQt,3)+Space(1)+EscreveE(pNome,18)+Space(1)+EscreveN(pValorUnit,8,2)+Space(1)+EscreveN(pValorTotal,8,2));
  end else begin
	 rePrevisao.Lines.Add(EscreveE(pCodigo,5)+Space(1)+EscreveE(pNome,21)+Space(1)+EscreveE(pQt,3)+Space(1)+EscreveN(pValorTotal,8,2));
  end;
end;
//-----------------------------------------------------------------------------------------------
//-- Chama a funcao de impressao de item de pedido
procedure ImpPedi.chamarImprimirItemPedido(pQueryTemp,pQueryItem:TQuery;pImpVl:boolean);
var quantProduto : string;
	 valorProduto : Real;
	 valorTotal : Real;
	 qtProduto : integer;
	 qtPedaco : integer;
	 cdProduto : integer;
begin
	qtProduto    := pQueryItem.FieldByName('QtProduto').AsInteger;
	qtPedaco     := pQueryItem.FieldByName('QtPedaco').AsInteger;
	valorProduto := pQueryItem.FieldByName('VlProduto').AsFloat;
	valorTotal   := pQueryItem.FieldByName('iteTotal').AsFloat;
	cdProduto    := pQueryItem.FieldByName('idProduto').AsInteger;
	abrirQuery(pQueryTemp,'Select Nome, Codigo from PRODUTO where contador = '+IntToStr(cdProduto));
	if (qtPedaco > 1) then quantProduto := IntToStr(qtProduto)+'/'+IntToStr(qtPedaco) else quantProduto := IntToStr(qtProduto);
	imprimirItemPedido (
		quantProduto,
		pQueryTemp.FieldByName('Nome').AsString,
		pQueryTemp.FieldByName('Codigo').AsString,
		valorProduto,
		valorTotal,
		pImpVl
	);
end;
//-----------------------------------------------------------------------------------------------
//-- Imprime espaçamento final do relatório
procedure ImpPedi.imprimirLinhaEmBranco(pNLinhas: Byte);
var i: Byte;
begin
	imprimirSeparador40Principal();
	for i := 0 to (pNLinhas - 1) do begin
		rePrevisao.Lines.Add('.'); //-- Linhas em Branco
	end;
end;
//-----------------------------------------------------------------------------------------------
//-- Imprime espaçamento final do relatório dependendo da variavel imprimeespecial
procedure ImpPedi.imprimirLinhaEmBrancoEspecial(pNLinhas: Byte;pImprimeEspecial: boolean);
begin
	if not pImprimeEspecial then begin
		imprimirSeparador40Principal();
	end else begin
		imprimirLinhaEmBranco(pNLinhas);
	end;
end;
//-----------------------------------------------------------------------------------------------
//-- Imprime espaçador principal de itens (mais fechado)
procedure ImpPedi.imprimirSeparador40Principal();
begin
	rePrevisao.Lines.Add('----------------------------------------');
end;
//-----------------------------------------------------------------------------------------------
//-- Imprime espaçador principal de itens (menos fechado)
procedure ImpPedi.imprimirSeparador40Secundario();
begin
	rePrevisao.Lines.Add('- - - - - - - - - - - - - - - - - - - - ');
end;
//-----------------------------------------------------------------------------------------------
//-- Imprime espaçador de item de pedido
procedure ImpPedi.imprimirSeparador40Item();
begin
	rePrevisao.Lines.Add('- - - - - - - -');
end;
//-----------------------------------------------------------------------------------------------
//-- Configura fonte em que será impresso o ralatório
procedure ImpPedi.configurarFonte();
begin
  rePrevisao.Font.Name := 'Courier New';
  rePrevisao.Font.Size := -13;
end;
//-----------------------------------------------------------------------------------------------
//-- Vai para o inicio do relatório
procedure ImpPedi.irParaInicio();
begin
  rePrevisao.SelStart  := 0;
  rePrevisao.SelLength := 0; //-- vai p/ inicio
end;
//-----------------------------------------------------------------------------------------------
//-- Enviar para impressora conteúdo do richtext
function ImpPedi.enviarParaImpressora(pConfirma,pImprimeEspecial:Boolean;pNuLinhaEmBranco:integer): boolean;
begin
	if (pConfirma) then begin //-- Se foi configurado para confirmar impressao
		if FFuncoes.PD.execute then begin
			imprimirLinhasdoMemo(pImprimeEspecial,pNuLinhaEmBranco);
			result := true;
		end else begin
			result := false;
		end;
	end else begin
		imprimirLinhasdoMemo(pImprimeEspecial,pNuLinhaEmBranco);
		result := true;
	end;
end;
//-----------------------------------------------------------------------------------------------
//-- Imprime linhas atraves do CanvasTextOut do texto do MEMO
procedure ImpPedi.imprimirLinhasdoMemo(pImprimeEspecial : boolean; pNuLinhaEmBranco: integer);
var i,
    y : integer;
begin
  try
    Printer.BeginDoc;
    Printer.Canvas.Font.Name := rePrevisao.Font.Name;
    Printer.Canvas.Font.Size := rePrevisao.Font.Size;
	 y := 0;
    for i := 0 to (rePrevisao.Lines.Count - 1) do begin
      Printer.Canvas.Textout(0,y,rePrevisao.Lines[I]);
		Inc(y,Abs(Printer.Canvas.Font.Height));
    end;
	 if not pImprimeEspecial then begin
      //-- Linhas em Branco
      for i := 0 to (pNuLinhaEmBranco - 1) do begin
        Printer.Canvas.TextOut(0,Y,' ');
		  Inc(Y,Abs(Printer.Canvas.Font.Height));
      end; //-- Linhas em Branco
    end;
    Printer.EndDoc;
  except
    MessageDlg('Erro ao imprimir linhas do relatório!', mtError, [mbOk], 0);
  end;
end;
//-----------------------------------------------------------------------------------------------
//-- Limpar RichEdit
procedure ImpPedi.limparTexto();
begin
  rePrevisao.Clear();
  irParaInicio();
end;
//-----------------------------------------------------------------------------------------------
//-- Setar richEdit Padrão
procedure ImpPedi.setarRichPadrao();
begin
	setarRePrev(@rePadrao);
end;
//-----------------------------------------------------------------------------------------------
//-- Setar richEdit para tamanho de visualização de texto 40 colunas
procedure ImpPedi.setarRichPara40Colunas();
const altCaixaTexto = 400;
const larCaixaTexto = 345;
begin
//	FrmPrev.setarPara40Colunas();
	FrmPrev.Width := larCaixaTexto+9+10; //-- 20 para dar espaço nas bordas caso seja winXP
	FrmPrev.Height := altCaixaTexto+27+20; //-- 20 para dar espaço nas bordas caso seja winXP
	FrmPrev.BorderIcons := [biSystemMenu];
	rePrevisao.Left := 5;
	rePrevisao.Top := 5;
	rePrevisao.BorderStyle := bsNone;
	rePrevisao.Visible := true;
	rePrevisao.Width := larCaixaTexto;
	rePrevisao.Height := altCaixaTexto;
	rePrevisao.ScrollBars := ssVertical;
end;
//-----------------------------------------------------------------------------------------------
//-- Mostra janela com previsão de impressçao
procedure ImpPedi.mostrarPrevisao();
begin
	FrmPrev.Position	:= poScreenCenter;
	rePrevisao.Parent	:= FrmPrev;
	rePrevisao.OnKeyPress := PressionarBotaoNoPrevisao;
	FrmPrev.ShowModal();
end;
//-----------------------------------------------------------------------------------------------
//-- Retorna tamanho do texo em rePrevisao
function ImpPedi.retornarTamanhoTexto():integer;
begin
	result := Length(rePrevisao.Text);
end;
//-----------------------------------------------------------------------------------------------
//-- Imprime Linha ordenada pelo lado esquerdo
procedure ImpPedi.imprimirLinhaOrdEsquerda(pTexto:string);
begin
	rePrevisao.Lines.Add(pTexto);
end;
//-----------------------------------------------------------------------------------------------
end.
//-----------------------------------------------------------------------------------------------
//   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM
//-----------------------------------------------------------------------------------------------
