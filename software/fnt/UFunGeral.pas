//-- Funcoes de uso geral sem vinculo com B.D. ou outras dependencias

unit UFunGeral;

interface

uses
Sysutils,	//-- Format
Dblogdlg,	//-- LoginDialog
Dialogs;		//-- MessageDlg

type
	TFunGeral = class
	public
		{ Public declarations }
		function retornarStringMonetaria(p_Valor: Real):String;
		function Space(N: integer): string;
		function EscreveE(s:string; Tamanho: integer): string;
		function EscreveN (n: Real; Tamanho: Integer; Decimal: Integer ): String;
		function EscreveD(s:string; Tamanho:integer): string;
		function mostrarJaneladeAcesso(pDataBase, pUsuario, pSenha: String): boolean;
		function Encrypt(const InString:string; StartKey,MultKey,AddKey:Integer): String;
		function Decrypt(const InString:string; StartKey,MultKey,AddKey:Integer): String;
		function retornarStringSQL(p_String: String): String;
		function fazerPeriodo(p_CampoData,p_HoraVirada: String; p_DataIni,p_DataFim: TDateTime):String;
		function DiferencaData(DataInicial:TDateTime; DataFinal:TDateTime): integer;
		function DiferencaMinutos(HoraInicial,HoraFinal,DataInicial,DataFinal:TDateTime):Integer;
		function testarSeEhInteiro(p_Variavel: String):Boolean;
	end;

implementation

//-- Retorna em formato string um valor monetário (ponto flutuante c/ 2 casas decimanis)
function TFunGeral.retornarStringMonetaria(p_Valor: Real):String;
var	str: String;
begin
	try
		str := Format('%8.2n', [p_Valor]);
	except
		str := Format('%8.2n', [0]);
		MessageDlg('Valor do tipo monetário inválido!', mtError, [mbOk], 0);
	end;
	result := str;
end;

//--Escreve n espaços em brando do tipo spacebar
function TFunGeral.Space(N: integer): string;
var
  I    : integer;
  Dados: string;
begin
  Dados := '';
  for I := 1 to N do begin
    Dados := Dados + ' ';
//    Application.ProcessMessages;
  end;
  Space := Dados;
end;

//-- Alinha uma string a esquerda
function TFunGeral.EscreveE(s:string; Tamanho:integer): string;
var Pos  : integer;
begin
 if length(s) > Tamanho then Pos := Tamanho else Pos := length (s);
 EscreveE := Copy(s,1,Tamanho) + Space(Tamanho-Pos);
end;

function TFunGeral.EscreveN (n: Real; Tamanho: Integer; Decimal: Integer ): String;
var
 StrNumero, StrResultado : string;
 i                       : integer;
begin
 StrNumero      := FloatToStrF( n, ffNumber, 15, Decimal );
 StrResultado   := '';
 For i := 1 to ( Tamanho - Length( StrNumero ) ) do StrResultado  := StrResultado + ' ';
 EscreveN := StrResultado + StrNumero;
end;

//-- Alinha uma string a direita
function TFunGeral.EscreveD(s:string; Tamanho:integer): string;
var Pos  : integer;
begin
  if length(s) > Tamanho then Pos := Tamanho else Pos := length (s);
  EscreveD := Space(Tamanho-Pos) + Copy(s,1,Tamanho);
end;

//-- mostra janela para controle de acesso - barney 190302
function TFunGeral.mostrarJaneladeAcesso(pDataBase, pUsuario, pSenha: String): boolean;
var pass : string;
begin
  try
	 pass := '';
	 LoginDialog(pDataBase,pUsuario,pass);
	 if Uppercase(pass) = Uppercase(pSenha) then result := true else result := false;
  except
	 MessageDlg('Erro no controle de acesso!', mtError, [mbOk], 0);
	 result := false;
  end;
end;

{$R-}
{$Q-}
//-- Funcao de decriptografia simples  //Standard Encryption algorithm - Copied from Borland
function TFunGeral.Encrypt(const InString:string; StartKey,MultKey,AddKey:Integer): string;
var
  I : Byte;
begin
  Result := '';
  for I := 1 to Length(InString) do
  begin
	 Result := Result + CHAR(Byte(InString[I]) xor (StartKey shr 8));
	 StartKey := (Byte(Result[I]) + StartKey) * MultKey + AddKey;
  end;
end;

//-- Funcao de decriptografia simples  //Standard Encryption algorithm - Copied from Borland
function TFunGeral.Decrypt(const InString:string; StartKey,MultKey,AddKey:Integer): string;
var
  I : Byte;
begin
  Result := '';
  for I := 1 to Length(InString) do
  begin
	 Result := Result + CHAR(Byte(InString[I]) xor (StartKey shr 8));
	 StartKey := (Byte(InString[I]) + StartKey) * MultKey + AddKey;
  end;
end;
{$R+}
{$Q+}

function TFunGeral.retornarStringSQL(p_String: String): String;
begin
	result := ''''+p_String+'''';
end;

function TFunGeral.fazerPeriodo(p_CampoData,p_HoraVirada: String; p_DataIni,p_DataFim: TDateTime):String;
var	dataInicial2	:String;
		dataFinal2		:String;
		periodo			:String;
begin
	dataInicial2:=FormatDateTime('mm/dd/yyyy',p_DataIni);
	dataFinal2  :=FormatDateTime('mm/dd/yyyy',p_DataFim+1);
	if (p_HoraVirada <> NULL) then begin
		//-- Primeiro Periodo
		periodo	:= ' ('+p_CampoData+' >= '+retornarStringSQL(DataInicial2+' '+p_HoraVirada)+' ';
		periodo	:= periodo+') AND ';
		//-- Ultimo Periodo
		periodo	:= periodo+' ('+p_CampoData+' <= '+retornarStringSQL(DataFinal2+' '+p_HoraVirada)+' ';
		periodo	:= periodo+')';

		result:=periodo;
	end else begin
		if ((p_DataFim-p_DataIni)>=0) then begin
			periodo:=' ('+p_CampoData+' >= '+retornarStringSQL(DataInicial2)+' AND '+p_CampoData+' <= '+retornarStringSQL(DataFinal2)+' )';
			result:=periodo
		end else begin
			MessageDlg('Digite um intervalo em valores crescentes de data', mtInformation, [mbOk], 0);
			result:='ERRO!';
		end;
	end;
end;

//-----------------------------------------------------------------------------------------------
//-- Retorna a diferenca de dias entre duas datas, o retorno sera em numero de dias
function TFunGeral.DiferencaData(DataInicial:TDateTime; DataFinal:TDateTime): integer;
var Data: TDateTime;
	 dia,
	 mes,
	 ano: Word;
begin
  if Int(DataFinal) < Int(DataInicial) then begin
	 Result := -1; // -1 será o código de erro da diferença
  end
  else begin
	 Data := Int(DataFinal) - Int(DataInicial);
	 DecodeDate( Data, ano, mes, dia);
	 Result := StrToInt(FloatToStr(Data));
  end;
end;

//-----------------------------------------------------------------------------------------------
//-- Retorna a diferença entre dois horarios de duas datas, o retorno sera em numero de minutos
function TFunGeral.DiferencaMinutos(HoraInicial,HoraFinal,DataInicial,DataFinal:TDateTime):Integer;
var
  DifData : Integer;
  HourI, MinI, SecI, MSecI,
  HourF, MinF, SecF, MSecF : Word;
begin
  DecodeTime(HoraInicial, HourI, MinI, SecI, MSecI);
  DecodeTime(HoraFinal, HourF, MinF, SecF, MSecF);
  DifData := DiferencaData(DataInicial, DataFinal);
  if DifData > 0 then
	 Result := ((DifData - 1) * 1440) + ((23 - HourI)*60) + (60 - MinI) + (HourF * 60) + (MinF)
  else begin
	 if DifData = 0 then begin
		if HourI = HourF then
		  Result := MinF - MinI
		else
		  Result := (((HourF-HourI)-1)*60)+(60-MinI)+MinF;
	 end
	 else
		Result := -1; // -1 sera o codigo de erro da diferenca
  end;
end;

//-----------------------------------------------------------------------------------------------

//-- Retorna true se for um número inteiro
function TFunGeral.testarSeEhInteiro(p_Variavel: String): Boolean;
//var	v: Variant;
begin
	try
	  StrToInt(p_Variavel);
	  Result := True;
	except
	  On EConvertError do Result := False;
	  else
		 Result := True;
	end;
{
	try
		v := p_Variavel;
		if (VarType(v) = varInteger) then
			result := true
		else
			result := false;
	except
		result := false;
	end;
}
end;

//-----------------------------------------------------------------------------------------------

end.
//-----------------------------------------------------------------------------------------------
//   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM
//-----------------------------------------------------------------------------------------------

