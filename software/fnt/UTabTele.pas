{------------------------------------------------------------------------------------------------

              O C E A N O   -    M A R    D E    S O L U Ç Õ E S

-------------------------------------------------------------------------------------------------
                                I N I C I O
-------------------------------------------------------------------------------------------------
Criação      : 11/10/2001 02:00:00
Local        : Escritório, Florianópolis
Autor(es)    : Cleber J. Amaral
Descrição    :
Comentário   :
-------------------------------------------------------------------------------------------------
Atualização  : 24/10/2001 09:30:00
Autor(es)    : Iomani Engelmann Gomes
Comentário   : Atualizaçao de eventos das tabelas
-------------------------------------------------------------------------------------------------}
unit UTabTele;
//-----------------------------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------------------------
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, DBTables,
  DB, UFunDB, UFunGeral;
//-----------------------------------------------------------------------------------------------
type
	TFTabTele = class(TDataModule)
    DBCommerce: TDatabase;
		qTele: TQuery;
		qryProduto: TQuery;
		iaeCadProd: TUpdateSQL;
		qryItePedi: TQuery;
		iaeItePedi: TUpdateSQL;
		qTeleOpen: TQuery;
		qryVariavel: TQuery;
		iaeVariavel: TUpdateSQL;
		qryProdutoGrupo: TQuery;
		iaeProdutoGrupo: TUpdateSQL;
		qryClienteGrupo: TQuery;
		iaeClienteGrupo: TUpdateSQL;
		qryCliente: TQuery;
		iaeCliente: TUpdateSQL;
		qryPedidoMovimentacao: TQuery;
		iaePedidoMovimentacao: TUpdateSQL;
		qryPedido: TQuery;
		iaePedido: TUpdateSQL;
		qryPedidoItem: TQuery;
		iaePedidoItem: TUpdateSQL;
		qryEntregador: TQuery;
		iaeEntregador: TUpdateSQL;
		procedure TabelasCreate(Sender: TObject);
		procedure TabelasDestroy(Sender: TObject);
	public
		function retornarVarMarcaEmpresa:string;
		function retornarVarNomeEmpresa():string;
		function retornarVarEmailEmpresa():string;
		function retornarVarWebSiteEmpresa():string;
		function retornarVarSmtpEmpresa():string;
		function retornarVarFoneEmpresa():string;
		function retornarVarSenhaCriptPadrao():string;
		function buscarMaxContadorDBTele( pTabela : String ): Integer;
		function incluirItemPedido(pQtPedaco, p_ContadorCliente: Integer; pPedaco1, pPedaco2, pPedaco3, pPedaco4, p_ObsPedaco1, p_ObsPedaco2, p_ObsPedaco3, p_ObsPedaco4: String): Integer;
		procedure salvarItemDePedido(p_Operacao: TUpdateKind; p_CdContador,p_CdCliente,p_QtPedaco,p_CdPedaco1,p_CdPedaco2,p_CdPedaco3,p_CdPedaco4,p_QtProduto:Integer;p_VlPedaco1,p_VlPedaco2,p_VlPedaco3,p_VlPedaco4,p_ValorUnitario:real;p_Obs1,p_Obs2,p_Obs3,p_Obs4,p_NomeProduto:String);
		function retornarNomeAbreviado(p_CdProduto:integer):string;
		procedure incluirGrClPadrao();
		procedure incluirFormaPagamento();
		procedure salvarProduto(p_Operacao: TUpdateKind; p_Contador,p_CdGrupo,p_CdGrCl:Integer;p_Codigo,p_Nome,p_Ingredientes,p_Abreviacao:String;p_Valor:real);
		function retornarValorTotalDoPedido(p_CdCliente: Integer): Real;
		function retornarVariavel(p_Variavel, p_ValorPadrao: String): String;
		function alterarVariavel(p_Variavel, p_NovoValor: String): Integer;
		function retornarVariavelBool(p_Variavel, p_ValorPadrao : String): Boolean;
		function retornarVariavelFloat(p_Variavel: String; p_ValorPadrao: Real): Real;
		function retornarVariavelInt(p_Variavel: String; p_ValorPadrao: Integer): Integer;
		function retParamIndexStr(p_Parametro: String): String;
		procedure escreverTextos(pt_Parent: TWinControl);
		procedure alterarPontuacaoDoCliente(p_IdCliente: Integer; p_Pontos: Integer);
		function retornarPontuacaoDoCliente(p_IdCliente: Integer):Integer;
		function retornarPontuacaoDePedidoMovimentacao(p_IdCliente: Integer): Integer;
		procedure salvarPreferenciaDoCliente(p_Obs: String; p_IdCliente: Integer);
		function retornarPreferenciaDoCliente(p_IdCliente: Integer): String;
		procedure gravarDadosDoPedido(
			p_Contador,p_idCliente,p_idFormaPag,p_idAtendente,p_numerosDias,p_idEntregador : Integer;
			p_vlTotal,p_vlAcrescimo,p_vlTaxa,p_vlPago :Real;
			p_nrPedido,p_Obs :String; p_hrEntrega :TDateTime
		);
		procedure atualizaDataUltimoPedido(p_idCliente : Integer);
		procedure verificaSeOperadorTemAcesso();
		function retornarSenhaCriptografada(p_senha : String): String;
		function retornarSenhaDecriptografada(p_senha : String): String;
		procedure aplicarConfiguracaoPadrao();
		function limparBase_Pedidos(p_dataIni, p_dataFim: TDateTime): Integer;
		procedure cadastrarClienteTemporario();
		procedure atualizaBancoDeDados();

	private
		{ Private declarations }
		FunDB					: TFunDB;
		FunGeral				: TFunGeral;
		senhaCriptPadrao	: String;
		NUMERODIASHISTORICO : Integer;
		AGRUPARITENSIGUAIS : Bool;
		USAVALORMEDIO : Bool;
		USAVENDEDOR : Bool;
		ACESSOUSUARIO01 : String;
		ACESSOSENHA01 : String;
		HORAVIRADA : String;
		DDDPADRAO : String;
		VERSAODB : String;

	end;
//-----------------------------------------------------------------------------------------------
var
	FTabTele     : TFTabTele;
	//-- Variaveis Globais
	const marcaEmpresa   = '.:.Softiza.:.';
	const nomeEmpresa    = 'Softiza - Soluções Otimizadas';
	const emailEmpresa   = 'contato@softiza.com.br';
	const webSiteEmpresa = 'http://www.softiza.com.br';
	const foneEmpresa		= '(48) 8426-9006';
	const smtpEmpresa    = 'mail.softiza.com.br';
	const senhaPadrao    = '1234';
//-----------------------------------------------------------------------------------------------
implementation {$R *.DFM}
//-----------------------------------------------------------------------------------------------
uses UFuncoes;
//-----------------------------------------------------------------------------------------------
//-- retornar valor da variavel
function TFTabTele.retornarVarMarcaEmpresa():string;
begin
  result := marcaEmpresa;
end;
//-----------------------------------------------------------------------------------------------
//-- retornar valor da variavel
function TFTabTele.retornarVarNomeEmpresa():string;
begin
  result := nomeEmpresa;
end;
//-----------------------------------------------------------------------------------------------
//-- retornar valor da variavel
function TFTabTele.retornarVarEmailEmpresa():string;
begin
  result := emailEmpresa;
end;
//-----------------------------------------------------------------------------------------------
//-- retornar valor da variavel
function TFTabTele.retornarVarWebSiteEmpresa():string;
begin
  result := webSiteEmpresa;
end;
//-----------------------------------------------------------------------------------------------
//-- retornar valor da variavel
function TFTabTele.retornarVarSmtpEmpresa():string;
begin
  result := smtpEmpresa;
end;
//-----------------------------------------------------------------------------------------------
//-- retornar valor da variavel
function TFTabTele.retornarVarFoneEmpresa():string;
begin
  result := foneEmpresa;
end;
//-----------------------------------------------------------------------------------------------
//-- retornar valor da variavel
function TFTabTele.retornarVarSenhaCriptPadrao():string;
begin
  result := senhaCriptPadrao;
end;
//-----------------------------------------------------------------------------------------------
procedure TFTabTele.TabelasCreate(Sender: TObject);
var	dataBancoDeDados	: TDateTime;
		tst	: String;
begin
	try
		NUMERODIASHISTORICO := retornarVariavelInt('NumeroDiasHistorico',0);
		AGRUPARITENSIGUAIS := FTabTele.retornarVariavelBool('AGRUPARITENSIGUAIS','0');
		USAVALORMEDIO := FTabTele.retornarVariavelBool('USAVALORMEDIO','1');
		USAVENDEDOR := FTabTele.retornarVariavelBool('USAVENDEDOR','0');
		ACESSOUSUARIO01 := FTabTele.retornarVariavel('ACESSOUSUARIO01','Gerente');
		ACESSOSENHA01 := FTabTele.retornarSenhaDecriptografada(FTabTele.retornarVariavel('ACESSOSENHA01',FTabTele.retornarVarSenhaCriptPadrao()));
		HORAVIRADA := FTabTele.retornarVariavel('HORAVIRADA','04:00');
		DDDPADRAO := FTabTele.retornarVariavel('DDDPADRAO','48');
		VERSAODB := retornarVariavel('VERSAODB','1.0');

		//-- Buscar data do banco de dados
		abrirQuery(qTele,'SELECT CURRENT_TIMESTAMP AS DATABANCO FROM RDB$DATABASE');
		dataBancoDeDados := qTele.FieldByName('DATABANCO').AsDateTime;

		senhaCriptPadrao := retornarSenhaCriptografada(senhaPadrao);
		incluirGrClPadrao();
		incluirFormaPagamento();
		if not (DBCommerce.Connected) then DBCommerce.Open();

		atualizaBancoDeDados();

		//-- Apaga pedidos antigos do histórico
		if (NUMERODIASHISTORICO > 0) then begin
			if (limparBase_Pedidos(0, int(dataBancoDeDados)-NUMERODIASHISTORICO) <> 0) then begin
				MessageDlg('Erro ao excluir itens de pedido!', mtError, [mbOk], 0);
			end;
		end;

		if not (qryProdutoGrupo.Active) then qryProdutoGrupo.Open();
		if not (qryClienteGrupo.Active) then qryClienteGrupo.Open();
		if not (qryEntregador.Active) then qryEntregador.Open();
	except
		MessageDlg('Erro ao abrir base "Commerce"! [T01]', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFTabTele.TabelasDestroy(Sender: TObject);
begin
	if (DBCommerce.Connected) then DBCommerce.Close();
end;
//-----------------------------------------------------------------------------------------------
//-- Retorna MaxValor do contador + 1 do database Tele
function TFTabTele.buscarMaxContadorDBTele( pTabela : String ): Integer;
begin
  abrirQuery(qTele,'SELECT max(contador) AS maxContador from '+pTabela);
  Result := qTele.fieldByName('MaxContador').asInteger+1;
end;
//-----------------------------------------------------------------------------------------------
//-- Funcao de inclusao ou atualizacao de itens sem possibilidade de adicionar detalhes (obs, etc.)
//Result -1: Produto não encontrado
function TFTabTele.incluirItemPedido(pQtPedaco, p_ContadorCliente: Integer; pPedaco1, pPedaco2, pPedaco3, pPedaco4, p_ObsPedaco1, p_ObsPedaco2, p_ObsPedaco3, p_ObsPedaco4: String): Integer;
var	valorMaior	: real;
		valorMedio	: real;
		cdContador	: integer;
		cont			: byte;
		nmPedaco1	: string;
		cdPedaco		: array[1..4] of integer;
		vlPedaco		: array[1..4] of real;
		cdGrPr		: integer;
		clienteGrupo	: integer;
		sql		 		: String;
begin
	valorMaior := 0; valorMedio := 0;
	for cont := 1 to 4 do cdPedaco[cont] := -1;
	FunDB.atualizarQuery(FTabTele.qryPedidoMovimentacao);
	cdContador := BuscarMaxContador(FTabTele.qTele,'PedidoMovimentacao');

	//-- Capturando Grupo do cliente
	FunDB.iniciarQuery(FTabTele.qTele);
	sql := 'Select IDCLIENTEGRUPO From Cliente Where Contador = :Contador';
	FTabTele.qTele.SQL.Add(sql);
	FTabTele.qTele.ParamByName('Contador').AsInteger := p_ContadorCliente;
	FTabTele.qTele.Open();
	if (FTabTele.qTele.Eof <> FTabTele.qTele.Bof) then begin
		clienteGrupo := FTabTele.qTele.FieldByName('IDCLIENTEGRUPO').AsInteger;
	end;

	//-- Pocessando Pedaço 1 de 4
	if ((pPedaco1 <> '-1')and(pQtPedaco > 0)) then begin
		sql := 'Select Contador, Nome, Valor, IDPRODUTOGRUPO From Produto '+
			'Where UPPER(Codigo) = UPPER('+FunGeral.retornarStringSQL(pPedaco1)+') '+
			'AND IDCLIENTEGRUPO = '+IntToStr(clienteGrupo);
		if (verificarExistenciaDeRegistro(FTabTele.qTele,sql)) then begin
			cdPedaco[1]  := FTabTele.qTele.FieldByName('Contador').AsInteger;
			vlPedaco[1]  := FTabTele.qTele.FieldByName('Valor').AsFloat;
			nmPedaco1    := FTabTele.qTele.FieldByName('Nome').AsString;
			cdGrPr       := FTabTele.qTele.FieldByName('IDPRODUTOGRUPO').AsInteger;
			if (vlPedaco[1] > valorMaior) then valorMaior := vlPedaco[1];
			valorMedio := valorMedio + vlPedaco[1];
		end else begin
			MessageDlg('Erro na inclusão de itens - Produto não encontrado!', mtError, [mbOk], 0);
			Result := -1;
			Exit;
		end;
	end else begin
		//-- É obrigatório ter o primeiro pedaço
		MessageDlg('Erro na inclusão de itens - Pedaço 1 incorreto!', mtError, [mbOk], 0);
		Result := -1;
		Exit;
	end;

	//-- Pocessando Pedaço 2 de 4
	if ((pPedaco2 <> '-1')and(pQtPedaco > 1)) then begin
		sql := 'Select Contador, Nome, Valor, IDPRODUTOGRUPO From Produto '+
			'Where UPPER(Codigo) = UPPER('+FunGeral.retornarStringSQL(pPedaco2)+') '+
			'AND IDCLIENTEGRUPO = '+IntToStr(clienteGrupo);
		if (verificarExistenciaDeRegistro(FTabTele.qTele,sql)) then begin
			cdPedaco[2]  := FTabTele.qTele.FieldByName('Contador').AsInteger;
			vlPedaco[2]  := FTabTele.qTele.FieldByName('Valor').AsFloat;
			if (cdGrPr <> FTabTele.qTele.FieldByName('IDPRODUTOGRUPO').AsInteger) then	begin
				MessageDlg('O produto deve ser composto por partes de um mesmo grupo.', mtInformation, [mbOk], 0);
				Result := -1;
				Exit;
			end;
			if (vlPedaco[2] > valorMaior) then valorMaior := vlPedaco[2];
			valorMedio := valorMedio + vlPedaco[2];
		end else begin
			MessageDlg('Erro na inclusão de itens - Pedaço 2 incorreto', mtError, [mbOk], 0);
			Result := -1;
			Exit;
		end;
	end;

	//-- Pocessando Pedaço 3 de 4
	if ((pPedaco3 <> '-1')and(pQtPedaco > 2)) then begin
		sql := 'Select Contador, Nome, Valor, IDPRODUTOGRUPO From Produto '+
			'Where UPPER(Codigo) = UPPER('+FunGeral.retornarStringSQL(pPedaco3)+') '+
			'AND IDCLIENTEGRUPO = '+IntToStr(clienteGrupo);
		if (verificarExistenciaDeRegistro(FTabTele.qTele,sql)) then begin
			cdPedaco[3]  := FTabTele.qTele.FieldByName('Contador').AsInteger;
			vlPedaco[3]  := FTabTele.qTele.FieldByName('Valor').AsFloat;
			if (cdGrPr <> FTabTele.qTele.FieldByName('IDPRODUTOGRUPO').AsInteger) then	begin
				MessageDlg('O produto deve ser composto por partes de um mesmo grupo.', mtInformation, [mbOk], 0);
				Result := -1;
				Exit;
			end;
			if (vlPedaco[3] > valorMaior) then valorMaior := vlPedaco[3];
			valorMedio := valorMedio + vlPedaco[3];
		end else begin
			MessageDlg('Erro na inclusão de itens - Pedaço 3 incorreto', mtError, [mbOk], 0);
			Result := -1;
			Exit;
		end;
	end;

	//-- Pocessando Pedaço 4 de 4
	if ((pPedaco4 <> '-1')and(pQtPedaco > 3)) then begin
		sql := 'Select Contador, Nome, Valor, IDPRODUTOGRUPO From Produto '+
			'Where UPPER(Codigo) = UPPER('+FunGeral.retornarStringSQL(pPedaco4)+') '+
			'AND IDCLIENTEGRUPO = '+IntToStr(clienteGrupo);
		if (verificarExistenciaDeRegistro(FTabTele.qTele,sql)) then begin
			cdPedaco[4]  := FTabTele.qTele.FieldByName('Contador').AsInteger;
			vlPedaco[4]  := FTabTele.qTele.FieldByName('Valor').AsFloat;
			if (cdGrPr <> FTabTele.qTele.FieldByName('IDPRODUTOGRUPO').AsInteger) then	begin
				MessageDlg('O produto deve ser composto por partes de um mesmo grupo.', mtInformation, [mbOk], 0);
				Result := -1;
				Exit;
			end;
			if (vlPedaco[4] > valorMaior) then valorMaior := vlPedaco[4];
			valorMedio := valorMedio + vlPedaco[4];
		end else begin
			MessageDlg('Erro na inclusão de itens - Pedaço 4 incorreto', mtError, [mbOk], 0);
			Result := -1;
			Exit;
		end;
	end;

	sql := 'Select Contador, IdCliente, QtPedaco, IdPedaco1, VlPedaco1, Obs1, '+
		'IdPedaco2, VlPedaco2, Obs2, IdPedaco3, VlPedaco3, Obs3,  IdPedaco4, VlPedaco4, '+
		'Obs4, Quantidade, Nome, ValorUnitario From PedidoMovimentacao '+
		'Where IdPedaco1 = '+IntToStr(cdPedaco[1])+' AND IdPedaco2 = '+IntToStr(cdPedaco[2])+
		' AND IdPedaco3 = '+IntToStr(cdPedaco[3])+' AND IdPedaco4 = '+IntToStr(cdPedaco[4])+
		' AND IdCliente = '+IntToStr(p_ContadorCliente);
	//-- A abertura da query deve ficar por último na lógica OR pois está é processada primeiro, assim é preciso abrir a query antes
	if not (AGRUPARITENSIGUAIS) or not(verificarExistenciaDeRegistro(FTabTele.qTele,sql)) then begin
		if (USAVALORMEDIO) then valorMedio := valorMedio/pQtPedaco else valorMedio := valorMaior;
		salvarItemDePedido(
			ukInsert,
			cdContador,
			p_ContadorCliente,
			pQtPedaco,
			cdPedaco[1],
			cdPedaco[2],
			cdPedaco[3],
			cdPedaco[4],
			1,
			vlPedaco[1],
			vlPedaco[2],
			vlPedaco[3],
			vlPedaco[4],
			valorMedio,
			p_ObsPedaco1,
			p_ObsPedaco2,
			p_ObsPedaco3,
			p_ObsPedaco4,
			nmPedaco1
		);
	end else begin
		cdContador := FTabTele.qTele.FieldByName('Contador').AsInteger;
		salvarItemDePedido(
			ukModify,
			cdContador,
			FTabTele.qTele.FieldByName('IdCliente').AsInteger,
			FTabTele.qTele.FieldByName('QtPedaco').AsInteger,
			FTabTele.qTele.FieldByName('IdPedaco1').AsInteger,
			FTabTele.qTele.FieldByName('IdPedaco2').AsInteger,
			FTabTele.qTele.FieldByName('IdPedaco3').AsInteger,
			FTabTele.qTele.FieldByName('IdPedaco4').AsInteger,
			FTabTele.qTele.FieldByName('Quantidade').AsInteger+1,
			FTabTele.qTele.FieldByName('VlPedaco1').AsFloat,
			FTabTele.qTele.FieldByName('VlPedaco2').AsFloat,
			FTabTele.qTele.FieldByName('VlPedaco3').AsFloat,
			FTabTele.qTele.FieldByName('VlPedaco4').AsFloat,
			FTabTele.qTele.FieldByName('ValorUnitario').AsFloat,
			FTabTele.qTele.FieldByName('Obs1').AsString,
			FTabTele.qTele.FieldByName('Obs2').AsString,
			FTabTele.qTele.FieldByName('Obs3').AsString,
			FTabTele.qTele.FieldByName('Obs4').AsString,
			FTabTele.qTele.FieldByName('Nome').AsString
		);
	end;
	result := cdContador;
end;
//-----------------------------------------------------------------------------------------------
//-- Salva na tabela um novo item (inclusão ou alteração)
procedure TFTabTele.salvarItemDePedido(p_Operacao: TUpdateKind; p_CdContador,p_CdCliente,p_QtPedaco,p_CdPedaco1,p_CdPedaco2,p_CdPedaco3,p_CdPedaco4,p_QtProduto:Integer;p_VlPedaco1,p_VlPedaco2,p_VlPedaco3,p_VlPedaco4,p_ValorUnitario:real;p_Obs1,p_Obs2,p_Obs3,p_Obs4,p_NomeProduto:String);
var nmPedaco1: string;
	 codiProd1: string;
	 codiProd2: string;
	 codiProd3: string;
	 codiProd4: string;
begin
	if (p_Operacao = ukModify) then  FTabTele.iaePedidoMovimentacao.Query[p_Operacao].ParamByName('OLD_Contador').AsInteger := p_CdContador;
	FTabTele.iaePedidoMovimentacao.Query[p_Operacao].ParamByName('Contador').AsInteger  := p_CdContador;
	FTabTele.iaePedidoMovimentacao.Query[p_Operacao].ParamByName('IdCliente').AsInteger := p_CdCliente;
	FTabTele.iaePedidoMovimentacao.Query[p_Operacao].ParamByName('IdAtendente').AsInteger := 0;
	FTabTele.iaePedidoMovimentacao.Query[p_Operacao].ParamByName('QtPedaco').AsInteger  := p_QtPedaco;
	FTabTele.iaePedidoMovimentacao.Query[p_Operacao].ParamByName('IdPedaco1').AsInteger := p_CdPedaco1;
	FTabTele.iaePedidoMovimentacao.Query[p_Operacao].ParamByName('VlPedaco1').AsFloat   := p_VlPedaco1;
	FTabTele.iaePedidoMovimentacao.Query[p_Operacao].ParamByName('Obs1').AsString       := p_Obs1;
	FTabTele.iaePedidoMovimentacao.Query[p_Operacao].ParamByName('IdPedaco2').AsInteger := p_CdPedaco2;
	FTabTele.iaePedidoMovimentacao.Query[p_Operacao].ParamByName('VlPedaco2').AsFloat   := p_VlPedaco2;
	FTabTele.iaePedidoMovimentacao.Query[p_Operacao].ParamByName('Obs2').AsString       := p_Obs2;
	FTabTele.iaePedidoMovimentacao.Query[p_Operacao].ParamByName('IdPedaco3').AsInteger := p_CdPedaco3;
	FTabTele.iaePedidoMovimentacao.Query[p_Operacao].ParamByName('VlPedaco3').AsFloat   := p_VlPedaco3;
	FTabTele.iaePedidoMovimentacao.Query[p_Operacao].ParamByName('Obs3').AsString       := p_Obs3;
	FTabTele.iaePedidoMovimentacao.Query[p_Operacao].ParamByName('IdPedaco4').AsInteger := p_CdPedaco4;
	FTabTele.iaePedidoMovimentacao.Query[p_Operacao].ParamByName('VlPedaco4').AsFloat   := p_VlPedaco4;
	FTabTele.iaePedidoMovimentacao.Query[p_Operacao].ParamByName('Obs4').AsString       := p_Obs4;
	if (p_Operacao = ukInsert) then begin
		if (p_QtPedaco > 1) then begin
			codiProd1 := retornarNomeAbreviado(p_CdPedaco1);
			codiProd2 := retornarNomeAbreviado(p_CdPedaco2);
			codiProd3 := retornarNomeAbreviado(p_CdPedaco3);
			codiProd4 := retornarNomeAbreviado(p_CdPedaco4);
			case (p_QtPedaco) of
				2: nmPedaco1  := Copy(codiProd1+'/'+codiProd2,0,(Length(codiProd1)+Length(codiProd2)+p_QtPedaco-1));
				3: nmPedaco1  := Copy(codiProd1+'/'+codiProd2+'/'+codiProd3,0,(Length(codiProd1)+Length(codiProd2)+Length(codiProd3)+p_QtPedaco-1));
				4: nmPedaco1  := Copy(codiProd1+'/'+codiProd2+'/'+codiProd3+'/'+codiProd4,0,(Length(codiProd1)+Length(codiProd2)+Length(codiProd3)+Length(codiProd4)+p_QtPedaco-1));
			end;
		end else begin
			nmPedaco1 := p_NomeProduto;
		end;
	end else begin
		//-- Se for modificação recebe o mesmo nome dado anteriormente
		nmPedaco1 := p_NomeProduto;
	end;
	FTabTele.iaePedidoMovimentacao.Query[p_Operacao].ParamByName('Nome').AsString        	:= nmPedaco1;
	FTabTele.iaePedidoMovimentacao.Query[p_Operacao].ParamByName('Quantidade').AsInteger 	:= p_QtProduto;
	FTabTele.iaePedidoMovimentacao.Query[p_Operacao].ParamByName('IdEstado').AsInteger 		:= 0;
	FTabTele.iaePedidoMovimentacao.Query[p_Operacao].ParamByName('ValorUnitario').AsFloat	:= p_ValorUnitario;
	FTabTele.iaePedidoMovimentacao.Query[p_Operacao].ExecSQL();
	//  atualizarQuery(FTabTele.qryPedidoMovimentacao);
	FunDB.CommitDireto(FTabTele.DBCommerce);
end;
//-----------------------------------------------------------------------------------------------
function TFTabTele.retornarNomeAbreviado(p_CdProduto:integer):string;
var 	sql: String;
begin
	sql := 'Select Codigo, Abreviacao From Produto Where Contador = '+IntToStr(p_CdProduto);
	if (verificarExistenciaDeRegistro(FTabTele.qTele,sql)) then begin
		if (qTele.FieldByName('Abreviacao').AsString <> '') then
			result := qTele.FieldByName('Abreviacao').AsString
		else
			result := qTele.FieldByName('Codigo').AsString
	end else result := 'ERRO!';
end;
//-----------------------------------------------------------------------------------------------
//-- Inclui grupo de clientes padrão
procedure TFTabTele.incluirGrClPadrao();
begin
	if not (verificarExistenciaDeRegistro(FTabTele.qTele,'SELECT Contador FROM ClienteGrupo WHERE Contador = 1')) then begin
		FunDB.iniciarTransacao(DBCommerce);
		executarQuery(FTabTele.qTele,'insert into ClienteGrupo (Contador, Nome) values (1,'+FunGeral.retornarStringSQL('Clientes')+')');
		FunDB.finalizarTransacao(DBCommerce);
	end;
end;
//-----------------------------------------------------------------------------------------------
//-- Inclui Formas de pagamento padrão
procedure TFTabTele.incluirFormaPagamento();
begin
	abrirQuery(FTabTele.qTele,'SELECT COUNT(Contador) AS cont FROM FormaPagamento');
	if (FTabTele.qTele.FieldByName('cont').AsInteger < 5) then begin
		executarQuery(FTabTele.qTele,'DELETE FROM FormaPagamento');
		FunDB.iniciarTransacao(DBCommerce);
		executarQuery(FTabTele.qTele,'insert into FormaPagamento (Contador, Nome, IdEstado, Troco) values (1,'+FunGeral.retornarStringSQL('Dinheiro')+',1,1)');
		executarQuery(FTabTele.qTele,'insert into FormaPagamento (Contador, Nome, IdEstado, Troco) values (2,'+FunGeral.retornarStringSQL('Cheque')+',1,0)');
		executarQuery(FTabTele.qTele,'insert into FormaPagamento (Contador, Nome, IdEstado, Troco) values (3,'+FunGeral.retornarStringSQL('Cheque-pré')+',1,0)');
		executarQuery(FTabTele.qTele,'insert into FormaPagamento (Contador, Nome, IdEstado, Troco) values (4,'+FunGeral.retornarStringSQL('Cartão')+',1,0)');
		executarQuery(FTabTele.qTele,'insert into FormaPagamento (Contador, Nome, IdEstado, Troco) values (5,'+FunGeral.retornarStringSQL('Ticket')+',1,0)');
		FunDB.finalizarTransacao(DBCommerce);
	end;
end;
//-----------------------------------------------------------------------------------------------
//-- Salva na tabela um novo item (inclusão ou alteração)
procedure TFTabTele.salvarProduto(p_Operacao: TUpdateKind; p_Contador,p_CdGrupo,p_CdGrCl:Integer;p_Codigo,p_Nome,p_Ingredientes,p_Abreviacao:String;p_Valor:real);
begin
  if (p_Operacao = ukModify) then  FTabTele.iaeCadProd.Query[p_Operacao].ParamByName('OLD_Contador').AsInteger := p_Contador;
  FTabTele.iaeCadProd.Query[p_Operacao].ParamByName('Contador').AsInteger    := p_Contador;
  FTabTele.iaeCadProd.Query[p_Operacao].ParamByName('Codigo').AsString       := p_Codigo;
  FTabTele.iaeCadProd.Query[p_Operacao].ParamByName('CdGrupo').AsInteger     := p_CdGrupo;
  FTabTele.iaeCadProd.Query[p_Operacao].ParamByName('Nome').AsString         := p_Nome;
  FTabTele.iaeCadProd.Query[p_Operacao].ParamByName('Valor').AsFloat         := p_Valor;
  FTabTele.iaeCadProd.Query[p_Operacao].ParamByName('Ingredientes').AsString := p_Ingredientes;
  FTabTele.iaeCadProd.Query[p_Operacao].ParamByName('Abreviacao').AsString   := p_Abreviacao;
  FTabTele.iaeCadProd.Query[p_Operacao].ParamByName('CdGrCl').AsInteger      := p_CdGrCl;
  FTabTele.iaeCadProd.Query[p_Operacao].ExecSQL();
  atualizarQuery(FTabTele.qryProduto);
end;
//-----------------------------------------------------------------------------------------------
//-- Retorna o valor total do pedido em movimentação de um cliente
function TFTabTele.retornarValorTotalDoPedido(p_CdCliente: Integer): Real;
begin
	abrirQuery(FTabTele.qTele,'SELECT SUM(ValorUnitario*Quantidade) AS VLTOTAL FROM PedidoMovimentacao WHERE IdCliente = '+IntToStr(p_CdCliente));
	result := FTabTele.qTele.FieldByName('VLTOTAL').AsFloat;
end;
//-----------------------------------------------------------------------------------------------
function TFTabTele.retornarVariavel(p_Variavel, p_ValorPadrao: String): String;
begin
  result := FunDB.retornarVariavel(FTabTele.qryVariavel,FTabTele.qTele,FTabTele.iaeVariavel,p_Variavel,p_ValorPadrao);
end;
//-----------------------------------------------------------------------------------------------
function TFTabTele.alterarVariavel(p_Variavel, p_NovoValor: String): Integer;
begin
  result := FunDB.alterarVariavel(FTabTele.qryVariavel,FTabTele.qTele,FTabTele.iaeVariavel,p_Variavel,p_NovoValor);
end;
//-----------------------------------------------------------------------------------------------
//-- Devolve o valor booleano de uma variavel
function TFTabTele.retornarVariavelBool(p_Variavel, p_ValorPadrao : String): Boolean;
begin
	Result := false;
	if (FunGeral.testarSeEhInteiro(retornarVariavel(p_Variavel,p_ValorPadrao))) then
	begin
		Result := (StrToInt(retornarVariavel(p_Variavel,p_ValorPadrao)) = 1);
	end
	else
	begin
		Result := (UpperCase(retornarVariavel(p_Variavel,p_ValorPadrao)) = 'TRUE');
	end;
end;
//-----------------------------------------------------------------------------------------------
//-- Devolve o valor float de uma variavel
function TFTabTele.retornarVariavelFloat(p_Variavel: String; p_ValorPadrao: Real): Real;
begin
  result := FunDB.retornarVariavelFloat(FTabTele.qryVariavel,FTabTele.qTele,FTabTele.iaeVariavel,p_Variavel,p_ValorPadrao);
end;
//-----------------------------------------------------------------------------------------------
//-- Devolve o valor inteiro de uma variavel
function TFTabTele.retornarVariavelInt(p_Variavel: String; p_ValorPadrao: Integer): Integer;
begin
  result := FunDB.retornarVariavelInt(FTabTele.qryVariavel,FTabTele.qTele,FTabTele.iaeVariavel,p_Variavel,p_ValorPadrao);
end;
//-----------------------------------------------------------------------------------------------
function TFTabTele.retParamIndexStr(p_Parametro: String): String;
begin
//  return FLanguageManager->retParamIndexStr(pParametro);
end;
//-----------------------------------------------------------------------------------------------
procedure TFTabTele.escreverTextos(pt_Parent: TWinControl);
begin
//	FLanguageManager.escreverTextos(pt_Parent);
end;
//---------------------------------------------------------------------------
procedure TFTabTele.alterarPontuacaoDoCliente(p_IdCliente: Integer; p_Pontos: Integer);
begin
	try
		//-- Atualiza campo de pontuacao do cliente
		FunDB.iniciarQuery(qTele);
		qTele.SQL.Add(
		  'UPDATE CLIENTE SET PONTUACAO = :PONTOS '+
		  'WHERE CONTADOR = :CLIENTE '
		);
		qTele.ParamByName('PONTOS').AsInteger := p_Pontos;
		qTele.ParamByName('CLIENTE').AsInteger := p_IdCliente;
		qTele.ExecSQL();
	except
		MessageDlg('Erro ao zerar pontuação do cliente', mtInformation, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
function TFTabTele.retornarPontuacaoDoCliente(p_IdCliente: Integer):Integer;
begin
	//-- Busca Saldo do cliente
	FunDB.iniciarQuery(qTele);
	qTele.SQL.Add(
	  'SELECT PONTUACAO FROM CLIENTE WHERE CONTADOR = :CLIENTE '
	);
	qTele.ParamByName('CLIENTE').AsInteger := p_IdCliente;
	qTele.Open();
	result := qTele.FieldByName('PONTUACAO').AsInteger;
end;
//-----------------------------------------------------------------------------------------------
function TFTabTele.retornarPontuacaoDePedidoMovimentacao(p_IdCliente: Integer): Integer;
begin
	//-- Busca quantos pontos tem neste pedido
	// PRODUTOGRUPO.PONTUACAO*(PEDIDOITEM.QTPRODUTO/PEDIDOITEM.QTPEDACO) Divide pelo qt pedaco para garantir
	// Que considerará metades, terços, etc. além de considerar quantos itens comprou
	FunDB.iniciarQuery(qTele);
	qTele.SQL.Add(
		'SELECT SUM(PRODUTOGRUPO.PONTUACAO*PEDIDOMOVIMENTACAO.QUANTIDADE) AS PONTOS '+
		'FROM PEDIDOMOVIMENTACAO, PRODUTO, PRODUTOGRUPO '+
		'WHERE IDCLIENTE = :CLIENTE '+
		'AND PEDIDOMOVIMENTACAO.IDPEDACO1 = PRODUTO.CONTADOR '+
		'AND PRODUTO.IDPRODUTOGRUPO = PRODUTOGRUPO.CONTADOR '
	);
	qTele.ParamByName('CLIENTE').AsInteger := p_IdCliente;
	qTele.Open();
	Result := qTele.FieldByName('PONTOS').AsInteger;
end;
//-----------------------------------------------------------------------------------------------
procedure TFTabTele.salvarPreferenciaDoCliente(p_Obs: String; p_IdCliente: Integer);
begin
	FunDB.executarQuery(qTele,
		'UPDATE CLIENTE SET OBS1 = '+FunGeral.retornarStringSQL(p_Obs)+
		' WHERE CONTADOR = '+IntToStr(p_IdCliente)
	);
	FunDB.commitDireto(FTabTele.DBCommerce);
end;
//-----------------------------------------------------------------------------------------------
function TFTabTele.retornarPreferenciaDoCliente(p_IdCliente: Integer): String;
begin
	FunDB.abrirQuery(qTele,'SELECT OBS1 FROM CLIENTE WHERE CONTADOR = '+IntToStr(p_IdCliente));
	Result := qTele.FieldByName('OBS1').AsString;
end;
//-----------------------------------------------------------------------------------------------
//-- Grava em CadPedi os campos referentes ao pedido
procedure TFTabTele.gravarDadosDoPedido(
	p_Contador,p_idCliente,p_idFormaPag,p_idAtendente,p_numerosDias,p_idEntregador : Integer;
	p_vlTotal,p_vlAcrescimo,p_vlTaxa,p_vlPago :Real;
	p_nrPedido,p_Obs :String; p_hrEntrega :TDateTime
);
var contadorVendedor: Integer;
begin
	if not (USAVENDEDOR) then begin
		contadorVendedor := -1;
	end else begin
		contadorVendedor := p_idAtendente;
	end;
	iaePedido.Query[ukInsert].ParamByName('CONTADOR').AsInteger				:= p_Contador;
	iaePedido.Query[ukInsert].ParamByName('IDCLIENTE').AsInteger			:= p_idCliente;
	iaePedido.Query[ukInsert].ParamByName('VLTOTAL').AsFloat					:= p_vlTotal;
	iaePedido.Query[ukInsert].ParamByName('VLACRESCIMO').AsFloat			:= p_vlAcrescimo;
	iaePedido.Query[ukInsert].ParamByName('VLTAXA').AsFloat					:= p_vlTaxa;
	iaePedido.Query[ukInsert].ParamByName('VLPAGO').AsFloat					:= p_vlPago;
	iaePedido.Query[ukInsert].ParamByName('NUMEROPEDIDO').AsString			:= p_nrPedido;
	iaePedido.Query[ukInsert].ParamByName('IDFORMAPAGAMENTO').AsInteger	:= p_idFormaPag;
	iaePedido.Query[ukInsert].ParamByName('OBS').AsString						:= p_Obs;
	iaePedido.Query[ukInsert].ParamByName('IDATENDENTE').AsInteger			:= contadorVendedor;
	iaePedido.Query[ukInsert].ParamByName('NUMERODIAS').AsInteger	  		:= p_numerosDias;
	iaePedido.Query[ukInsert].ParamByName('HORAPREVISTA').AsDateTime	 	:= p_hrEntrega;
	iaePedido.Query[ukInsert].ParamByName('IDENTREGADOR').AsInteger		:= p_idEntregador;
	iaePedido.Query[ukInsert].ExecSQL();
end;
//-----------------------------------------------------------------------------------------------
procedure TFTabTele.atualizaDataUltimoPedido(p_idCliente : Integer);
begin
	//-- Atualiza a data do último pedido feito pelo cliente é importante q FinPedi esteja Active p/ o post não ser Abortado
	try
		FunDB.iniciarQuery(qTele);
		qTele.SQL.Add('UPDATE Cliente SET DataUltimoPedido = CURRENT_TIMESTAMP WHERE Contador = :idCliente');
		qTele.ParamByName('idCliente').AsInteger := p_idCliente;
		qTele.ExecSQL();
	except
		MessageDlg('Erro ao atualizar último pedido do cliente!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFTabTele.verificaSeOperadorTemAcesso();
var pass : string;
begin
{
  try
	 pass := '';
	 if (LoginDialog(pDataBase,pUsuario,pass)) then begin end;
	 if Uppercase(pass) = Uppercase(pSenha) then result := true else result := false;
}
	if (
		mostrarJaneladeAcesso(
			'soft',
			ACESSOUSUARIO01,
			ACESSOSENHA01
		)
	) then begin
	end;
end;
//-----------------------------------------------------------------------------------------------
function TFTabTele.retornarSenhaCriptografada(p_senha : String): String;
begin
	Result := FunGeral.Encrypt(p_senha,981,12674,35891);
end;
//-----------------------------------------------------------------------------------------------
function TFTabTele.retornarSenhaDecriptografada(p_senha : String): String;
begin
	Result := FunGeral.Decrypt(p_senha,981,12674,35891);
end;
//-----------------------------------------------------------------------------------------------
{
procedure TFTabTele.cadastrarClienteGrupo(p_Operacao: TUpdateKind);
begin
	try
		if (p_Operacao = ukInsert) then begin
			FunDB.registrarGrupoPeloNome(ukInsert,FTabTele.qryClienteGrupo);
		end else begin
			if (p_Operacao = ukModify) then
				FunDB.registrarGrupoPeloNome(ukModify,FTabTele.qryClienteGrupo);
			if (p_Operacao = ukDelete) then begin
				if (MessageDlg('Deseja excluir o registro?', mtWarning, [mbYes, mbNo], 0) = mrYes) then begin
					//-- Verifica relacionamentos
					FunDB.registrarGrupoPeloNome(ukDelete,FTabTele.qryClienteGrupo);
//					end else begin
//						MessageDlg('Este registro não pode ser excluído por ter vínculos ativos!', mtInformation, [mbOk], 0);
//					end;
				end;
			end;
		end;
	except
		MessageDlg('Erro na operação!', mtError, [mbOk], 0);
	end;
end;
}
//-----------------------------------------------------------------------------------------------
procedure TFTabTele.aplicarConfiguracaoPadrao();
begin
	 ShortDateFormat    := 'dd/mm/yyyy';
	 DecimalSeparator   := '.';
	 ThousandSeparator  := ',';
	 CurrencyDecimals   := 2;
end;
//-----------------------------------------------------------------------------------------------
function TFTabTele.limparBase_Pedidos(p_dataIni, p_dataFim: TDateTime): Integer;
var 	sql					: String;
begin
	FunDB.iniciarTransacao(DBCommerce);

	//-- Apagar Itens de pedido
	sql := 'DELETE FROM PedidoItem WHERE IdPedido IN (SELECT Contador FROM Pedido Where ('+
		FunGeral.fazerPeriodo(
			'PEDIDO.DATAPEDIDO',
			HORAVIRADA,
			p_dataIni,
			p_dataFim)
		+') )';
	try
		executarQuery(qTele,sql);
	except
		FunDB.cancelarTransacao(DBCommerce);
		Result := -1;
		Exit;
	end;

	//-- Apagar Pedidos
	sql := 'Delete from Pedido where ('+
		FunGeral.fazerPeriodo(
			'PEDIDO.DATAPEDIDO',
			HORAVIRADA,
			p_dataIni,
			p_dataFim)
		+')';
	try
		executarQuery(qTele,sql);

		FunDB.finalizarTransacao(DBCommerce);

		Result := 0;
	except
		FunDB.cancelarTransacao(DBCommerce);
		Result := -1;
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFTabTele.cadastrarClienteTemporario();
begin
	if not (verificarExistenciaDeRegistro(qTele,'SELECT Fone1 FROM Cliente Where Fone1 = '+FunGeral.retornarStringSQL('000000'))) then begin
		FunDB.iniciarQuery(qTele);
		qTele.SQL.Add('insert into CLIENTE (CONTADOR, IDCLIENTEGRUPO, DDD, FONE1, NOME, DATACADASTRO) values (:CONTADOR, :IDCLIENTEGRUPO, :DDD, :FONE1, :NOME, CURRENT_TIMESTAMP)');
		qTele.ParamByName('Contador').AsInteger			:= -1;
		qTele.ParamByName('Nome').AsString					:= '          T E M P O R A R I O';
		qTele.ParamByName('DDD').AsString					:= DDDPADRAO;
		qTele.ParamByName('Fone1').AsString					:= '000000';
		qTele.ParamByName('IDCLIENTEGRUPO').AsInteger   := 1;

		FunDB.iniciarTransacao(DBCommerce);
		qTele.ExecSQL();
		FunDB.finalizarTransacao(DBCommerce);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFTabTele.atualizaBancoDeDados();
begin
	try
		//-- Se o banco de dados está na primeira versão então cria:
		if (VERSAODB = '1.0') then begin
			FunDB.iniciarTransacao(DBCommerce);
			//-- Primeiro verifica se já existe o campo
			FunDB.executarQuery(qTele,'ALTER TABLE PRODUTOGRUPO ADD PONTUACAO INTEGER');
			FunDB.executarQuery(qTele,'ALTER TABLE CLIENTE ADD PONTUACAO INTEGER');

			alterarVariavel('VersaoDB','1.1');
			VERSAODB := '1.1';

			FunDB.finalizarTransacao(DBCommerce);
		end;

		if (VERSAODB = '1.1') then begin
			FunDB.iniciarTransacao(DBCommerce);
			FunDB.executarQuery(qTele,'INSERT INTO ENTREGADOR (CONTADOR, NOME, EMPRESA, COMISSAO, DTCADASTRO)'+
				'SELECT 0, ''Balcao'', ''Cadastro Automatico'', 0, CURRENT_TIMESTAMP FROM RDB$DATABASE WHERE NOT EXISTS ('+
				'SELECT CONTADOR FROM ENTREGADOR WHERE CONTADOR = 0)');
			FunDB.executarQuery(qTele,'INSERT INTO ENTREGADOR (CONTADOR, NOME, EMPRESA, COMISSAO, DTCADASTRO)'+
				'SELECT 1, ''Salao'', ''Cadastro Automatico'', 0, CURRENT_TIMESTAMP FROM RDB$DATABASE WHERE NOT EXISTS ('+
				'SELECT CONTADOR FROM ENTREGADOR WHERE CONTADOR = 1)');
			FunDB.executarQuery(qTele,'CREATE EXCEPTION REGISTRO_PROTEGIDO ''Este registro não pode ser alterado ou removido!''');
			FunDB.executarQuery(qTele,'CREATE TRIGGER "ENTREGADOR_BEFORE_UPDATE" FOR "ENTREGADOR" '+#13+
				'ACTIVE BEFORE UPDATE POSITION 0 '+#13+
				'AS '+#13+
				'BEGIN '+#13+
				'  IF ((NEW.CONTADOR = 0) OR (NEW.CONTADOR = 1)) THEN BEGIN '+#13+
				'	 EXCEPTION REGISTRO_PROTEGIDO; '+#13+
				'  END '+#13+
				'END ');
			FunDB.executarQuery(qTele,'CREATE TRIGGER "ENTREGADOR_BEFORE_DELETE" FOR "ENTREGADOR" '+#13+
				'ACTIVE BEFORE DELETE POSITION 0 '+#13+
				'AS '+#13+
				'BEGIN '+#13+
				'  IF ((OLD.CONTADOR = 0) OR (OLD.CONTADOR = 1)) THEN BEGIN '+#13+
				'	 EXCEPTION REGISTRO_PROTEGIDO; '+#13+
				'  END '+#13+
				'END ');
			FunDB.executarQuery(qTele,'DELETE FROM CLIENTE WHERE NOME = ''          T E M P O R A R I O''');
			FunDB.executarQuery(qTele,'INSERT INTO CLIENTE (CONTADOR, NOME, DDD, FONE1, FONE2, LOGRADOURO, DATACADASTRO, IDCLIENTEGRUPO)'+
				'SELECT -1, ''_TEMPORARIO'', ''00'', ''000000'', ''00000000'', ''CADASTRO AUTOMATICO'', CURRENT_TIMESTAMP, 1 FROM RDB$DATABASE WHERE NOT EXISTS ('+
				'SELECT CONTADOR FROM CLIENTE WHERE CONTADOR = -1)');
			FunDB.executarQuery(qTele,'CREATE TRIGGER "CLIENTE_BEFORE_UPDATE" FOR "CLIENTE" '+#13+
				'ACTIVE BEFORE UPDATE POSITION 0 '+#13+
				'AS '+#13+
				'BEGIN '+#13+
				'  IF (NEW.CONTADOR = -1) THEN BEGIN '+#13+
				'	 EXCEPTION REGISTRO_PROTEGIDO; '+#13+
				'  END '+#13+
				'END ');
			FunDB.executarQuery(qTele,'CREATE TRIGGER "CLIENTE_BEFORE_DELETE" FOR "CLIENTE" '+#13+
				'ACTIVE BEFORE DELETE POSITION 0 '+#13+
				'AS '+#13+
				'BEGIN '+#13+
				'  IF (OLD.CONTADOR = -1) THEN BEGIN '+#13+
				'	 EXCEPTION REGISTRO_PROTEGIDO; '+#13+
				'  END '+#13+
				'END ');

			alterarVariavel('VersaoDB','1.2');
			VERSAODB := '1.2';

			FunDB.finalizarTransacao(DBCommerce);

		if (VERSAODB = '1.2') then begin
			FunDB.iniciarTransacao(DBCommerce);
			//-- Primeiro verifica se já existe o campo
			FunDB.executarQuery(qTele,'ALTER TABLE PRODUTO ADD VALORUNIT NUMERIC(10,4)');

			VERSAODB := '1.3';
			alterarVariavel('VersaoDB',VERSAODB);

			FunDB.finalizarTransacao(DBCommerce);
		end;


;

		end;
	except
		FunDB.cancelarTransacao(DBCommerce);
		MessageDlg('Erro ao atualizar o banco de dados', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
end.
//-----------------------------------------------------------------------------------------------
//   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM
//-----------------------------------------------------------------------------------------------
