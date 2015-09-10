{------------------------------------------------------------------------------------------------
                       O C E A N O   T E C N O L O G I A
                        M A R    D E    S O L U Ç Õ E S
-------------------------------------------------------------------------------------------------
  1 Criação
    1.1 Data - Hora.: 20/01/2000 12h
    1.2 Local.......: Escritorio Pessoal - Coqueiros
  2 Autoria
    2.1 Analise.....: Cássio Lacerda
    2.2 Programação.: Cássio Lacerda
  3 Descrição
    3.1 Projeto.....: Geral
    3.2 Classe......: Funcoes Gerais
    3.3 Comentário..: Faz como variaveis globais no sistema as funçoes
          declaradas dentro da Unit
-------------------------------------------------------------------------------------------------
  1 Atualização
    1.1 Data - Hora.: 23/08/2000 09h
	 1.2 Local.......: Escritório Central - Florianopolis
  2 Autoria
    2.1 Programação.: Cleber Jorge Amaral
  3 Descrição
    3.3 Comentário..: Adicao de funcoes
-------------------------------------------------------------------------------------------------
  1 Atualização
	 1.1 Data - Hora.: 17/05/2001 14h
    1.2 Local.......: Escritório Central - Florianopolis
  2 Autoria
    2.1 Programação.: Marco de Oliveira Vivan
  3 Descrição
	 3.3 Comentário..: Adicao de funcoes
-------------------------------------------------------------------------------------------------
  1 Atualização
    1.1 Data - Hora.: 01/11/2001 10:00
    1.2 Local.......: Escritório Central - Florianopolis
  2 Autoria
    2.1 Programação.: Iomani Engelmann Gomes
  3 Descrição
    3.3 Comentário..: adiciçao dos métodos verificarHota e incrementar minutos;
------------------------------------------------------------------------------------------------}
unit UFuncoes;
//-----------------------------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------------------------
uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	Db, DBTables, StdCtrls, DBIProcs, Mask, DBCtrls, Dblogdlg;
//-----------------------------------------------------------------------------------------------
type
	TFFuncoes = class(TForm)
		qVerifica: TQuery;
		PD: TPrintDialog;
		procedure FormCreate(Sender: TObject);
	public
		procedure atualizarTabela(p_Tabela:TTable);
		procedure commitDireto(var pt_DB : TDatabase);
		procedure iniciarTransacao(var pt_DB : TDatabase);
		procedure finalizarTransacao(var pt_DB : TDatabase);
	end;
//-----------------------------------------------------------------------------------------------
//	procedure Aviso(pmsg : string );
	procedure DefineCor(Modulo : string );
	Procedure Commit( pTabela: TTable );
	procedure Inspetor(pmsg: string);
	procedure enquadraJanela(pForm : TForm);
	procedure tentarAbrirBanco( pDB:TDataBAse; pMsg,pErro:String);
	procedure tentarAbrirTabela( pTab:TTable; pMsg,pErro:String);
	procedure tentarFecharBanco( pDB:TDataBAse; pMsg,pErro:String);
	procedure tentarFecharTabela(pTabela: TTable; pMsg, pErro:String);
	procedure AbrirFormFilho(pNomeForm: String; var Reference);
	procedure deletarRegistro(pQuery: TQuery; pTabela, pContador : string; pPergunta: Boolean);
	procedure atualizarQuery(pQuery: TQuery);
	procedure iniciarQuery(pQuery: TQuery);
	procedure executarQuery(pQuery: TQuery;pSQL : string);
	procedure abrirQuery(pQuery: TQuery;pSQL : string);
	function Encrypt(const InString:string; StartKey,MultKey,AddKey:Integer): string;
	function Decrypt(const InString:string; StartKey,MultKey,AddKey:Integer): string;
	function GetModulo (pModulo: TForm): String;
	function AbreJanela(pmodulo: TForm; perro: string): bool;
	function CentralizaTela_640x480(Formulario: TForm): bool;
	function CentralizaTela_800x600(Formulario: TForm): bool;
//	function Pergunta(pmsg : string ) : Bool;
	function EscreveD(s:string; Tamanho: integer): string;
	function EscreveE(s:string; Tamanho: integer): string;
	function EscreveC(s:string; Tamanho: integer): string;
	function EscreveP(s:string; Tamanho: integer): string;
	function EscreveN(n:real; Tamanho: integer; Decimal:integer ):String;
	function Space(N: integer): string;
	function DifDias(DataVenc: TDateTime; DataAtual: TDateTime): String;
	function DifNumDias(DataVenc: TDateTime; DataAtual: TDateTime): String;
	function CriaCabecalho( pNome: string ) : string;
	function Dia( Data: TDateTime ): string;
	function Mes( Data: TDateTime ): string;
	function MesExtenso( Data: TDateTime ): string;
	function Ano( Data: TDateTime ): string;
	function Ano2( Data: TDateTime ): string;
	function DiadaSemana( Data: TDateTime ): string;
	function MesAno( Data: TDateTime ): string;
	function UltimoDiaDoMes( MesAno: string ): string;
	function MMDDAA( Data: string ): string;
	function DDMMAA( pData: string ): string;
	function MMDDAAAA( pData: TDate ): string;
	function Zeros( Dados: string ): string;
	function StrZero(N: longint; Tamanho: integer): string;
	function Repl(C: string; Tamanho: integer): string;
	function BuscaTamanhodoLookUp ( pTabela : TTable; pCampo : string ) : Integer;
	function BuscaConteudodoLookUp( pTabela : TTable; pCampo : string ) : string;
	function BuscaTipodoLookUp ( pTabela : TTable; pCampo : string ) : TFieldType;
	function IncZeros( Dados: string; Tamanho: integer): string;
	function AllTrim( Dados: string ): string;
	function SubStrAnt( st, si : string ) : string;
	function SubStrPos( st, si : string ) : string;
	function SubStrOk( st, si : string ) : bool;
	function ContaSubStr( st, si : string ) : byte;
	function DiferencaSegundos(HoraInicial,HoraFinal,DataInicial,DataFinal:TDateTime):Integer;
	function DiferencaMinutos(HoraInicial, HoraFinal, DataInicial, DataFinal: TDateTime): integer;
	function DiferencaData(DataInicial, DataFinal: TDateTime): integer;
	function Localizar(pTabela : TTable; pIndice,pStr, pErro : string ; pMsg : Bool): bool;
	function FloatToInt(Numero:real):Integer;
	function IntToFloat(Numero:Integer):Real;
	function verificarData(pData: String):Boolean;
	function verificarHora(pHora: String):Boolean;
	function IncrementarMinutos( pHora: TDateTime; pMinutos : Integer):String;
	function comTresCasas( pvalor : string ) : string;
	function iif( pCondi : boolean ;  pbloco1, pbloco2 : string ) : string;
	function criarNrPedido(pNrPedido:string):String;
	function criarNrPedidoComVirada(pDataAtual:TDateTime;pNrPedido:string;p_NumInicialCupom:string;p_HoraVirada:string):String;

	//-----------------------------------------------------------------------------------------------
	//-- kass - Funções de Manipulação de Tabelas
	function irparaoprimeiropegistro( pTabela : TTable ) : bool;
	function irparaoproximoregistro( pTabela : TTable ) : bool;
	function irparaoregistroanterior( pTabela : TTable ) : bool;
	function irparaoultimoregistro( pTabela : TTable ) : bool;
	function buscarMaxContador(pQuery : TQuery; pTabela : String): integer;
	function incluirumregistro( pTabela : TTable ) : bool;
	function salvarumregistro( pTabela : TTable ) : bool;
	function ininicaraexclusao : bool;
	function excluirumregistro( pTabela : TTable ) : bool;
	function fecharjanela( pForm : TForm; pTabela : TTable) : bool;
	function salvarTabela(pTabela:TTable): boolean;
	function verificarcampo( pCampo:string; pEdit: TDBEdit): bool;
	function verificarExistenciaDeRegistro(pQuery: TQuery;pSQL : string): boolean;
	function mostrarJaneladeAcesso(pDataBase, pUsuario, pSenha: String): boolean;
	function converter4HexToInt(t: string): integer;
	function fazerPeriodo(pDtInicial,pDtFinal,pHoraVidada,pCampoData,pCampoHora : string):string;
//-----------------------------------------------------------------------------------------------
var
  FFuncoes        : TFFuncoes;
  VgAlterarPedido : Bool;
  VgForm   : TForm;
  VgString : String;    // kass - to usando esta unit na passagem do somente meio
  VgTabela : TTable;
  VgProcura: Bool;
  VgReg    : Variant;
  CorFixa  : TColor;
  pTab     : TTable;
const
  StartKey	  = 981;  	{Start default key}
  MultKey	  = 12674;	{Mult default key}
  AddKey	  = 35891;	{Add default key}
//-----------------------------------------------------------------------------------------------
implementation {$R *.DFM}
//-----------------------------------------------------------------------------------------------
procedure TFFuncoes.FormCreate(Sender: TObject);
begin
  try
//    Application.OnException         := NInspetor1.WriteException;
    VgAlterarPedido                 := False;
  except
//    NInspetor1.WriteMessage('Erro na criação de funções! [F01-2]');
  end;
end;
//-----------------------------------------------------------------------------------------------
//-- Pega o nome do modulo e retorna o caption
function GetModulo(pModulo: TForm): String;
var hifem : Integer;
begin
  try
    hifem  := Pos(' - ', pModulo.Caption);
    result := Copy(pModulo.Caption, 0, hifem);
  except
    Inspetor('Erro na função GetModulo! [F04]');
  end;
end;
//-----------------------------------------------------------------------------------------------
//-- Abre a janela validadando o usuário
function AbreJanela( pmodulo: TForm; perro: string): bool;
begin
  try
    pmodulo.show;
    result := true;
  except
//    FFuncoes.NInspetor1.WriteMessage('Erro ao abrir a janela ' + pErro + ' !');
    result := false;
  end;
end;
//-----------------------------------------------------------------------------------------------
//-- Mostra mensagem de Inspeção e grava em log
procedure Inspetor( pmsg: string);
begin
//  FFuncoes.NInspetor1.WriteMessage(pMsg);
end;
//-----------------------------------------------------------------------------------------------
//-- Centraliza a tela caso resolução seja 640 x 480
function CentralizaTela_640x480(Formulario: TForm): bool;
begin
  try
    if (Screen.Width = 640) and (Screen.Height = 480) then begin
      Formulario.Height := 488;
      Formulario.Width  := 648;
      Formulario.Top    := -4;
      Formulario.Left   := -4;
    end
    else begin
      Formulario.Height := 488;
      Formulario.Width  := 648;
      Formulario.Top    := (Screen.Height - Formulario.Height) div 2;
		Formulario.Left   := (Screen.Width - Formulario.Width) div 2;
    end;
    result := true;
  except
    MessageDlg('Erro ao ajustar tamanho da janela para a corrente resolução! [F05]', mtError, [mbOk], 0);
    result := false;
  end;
end;
//-----------------------------------------------------------------------------------------------
//-- Centraliza a Janela se a resolução fo 800 X 600
function CentralizaTela_800x600(Formulario: TForm): bool;
begin
 try
    if (Screen.Width = 800) and (Screen.Height = 600) then begin
      Formulario.Height := 608;
      Formulario.Width  := 808;
      Formulario.Top    := -4;
      Formulario.Left   := -4;
    end
    else begin
		Formulario.Height := 608;
      Formulario.Width  := 808;
      Formulario.Top    := (Screen.Height - Formulario.Height) div 2;
      Formulario.Left   := (Screen.Width - Formulario.Width) div 2;
    end;
    result := true;
  except
    MessageDlg('Erro ao ajustar tamanho da janela para a corrente resolução! [F06]', mtError, [mbOk], 0);
    result := false;
  end;
end;
//-----------------------------------------------------------------------------------------------
{ Funcao removida - Cleber - 31/01/2009
//-- Aviso tipo "ok" ao usuário
procedure Aviso( pmsg : string );
begin
  FFuncoes.Mensagem.Alerta( pmsg );
end;
}
//-----------------------------------------------------------------------------------------------
{ Funcao removida - cleber - 31/01/09
//-- Aviso de pergunta sim ou não ao usuário
function Pergunta( pmsg : string ) : Bool;
begin
	if (MessageDlg(pmsg, mtConfirmation	, [mbYes, mbNo], 0) = mrYes) then Result := true else Result := false;
end;
}
//-----------------------------------------------------------------------------------------------
//-- Alinha uma string a direita
function EscreveD(s:string; Tamanho:integer): string;
var Pos  : integer;
begin
  if length(s) > Tamanho then Pos := Tamanho else Pos := length (s);
  EscreveD := Space(Tamanho-Pos) + Copy(s,1,Tamanho);
end;
//-----------------------------------------------------------------------------------------------
//-- Alinha uma string a esquerda
function EscreveE(s:string; Tamanho:integer): string;
var Pos  : integer;
begin
 if length(s) > Tamanho then Pos := Tamanho else Pos := length (s);
 EscreveE := Copy(s,1,Tamanho) + Space(Tamanho-Pos);
end;
//-----------------------------------------------------------------------------------------------
//-- Centraliza uma string de tamanho x, se o tamanho exceder x a string é escrita
//-- Alinhada pela esquerda
function EscreveC(s:string; Tamanho:integer): string;
var Pos  : integer;
begin
 Pos := (Tamanho - length ( S ) ) div 2;
 EscreveC := space( pos ) + s;
end;
//-----------------------------------------------------------------------------------------------
//-- [K] Escreve String Alinhada a Esquerda Com Pontos
function EscreveP(s:string; Tamanho:integer): string;
var
 StrPar : string;
 Pos  : integer;
begin
 if length(s) > Tamanho then Pos := Tamanho else Pos := length (s);
 StrPar :=  s + Repl('.',Tamanho-Pos-1);
 EscreveP := StrPar + ':';
end;
//-----------------------------------------------------------------------------------------------
//-- Escreve um número em formato de moeda c/ n de tamanho total e n de casas decimais
function EscreveN (n: Real; Tamanho: Integer; Decimal: Integer ): String;
var
 StrNumero, StrResultado : string;
 i                       : integer;
begin
 StrNumero      := FloatToStrF( n, ffNumber, 15, Decimal );
 StrResultado   := '';
 For i := 1 to ( Tamanho - Length( StrNumero ) ) do
  StrResultado  := StrResultado + ' ';
 EscreveN := StrResultado + StrNumero;
end;
//-----------------------------------------------------------------------------------------------
//--Escreve n espaços em brando do tipo spacebar
function Space(N: integer): string;
var
  I    : integer;
  Dados: string;
begin
  Dados := '';
  for I := 1 to N do
  begin
    Dados := Dados + ' ';
    Application.ProcessMessages;
  end;
  Space := Dados;
end;
//-----------------------------------------------------------------------------------------------
//--Retorna a diferenca de dias entre duas datas
function DifDias(DataVenc:TDateTime; DataAtual:TDateTime): String;
Var Data: TDateTime;
    dia, mes, ano: Word;
begin
  if DataAtual < DataVenc then begin
     Result := 'A data atual não pode ser menor que a data inicial';
  end
  else begin
    Data := DataAtual - DataVenc;
    DecodeDate( Data, ano, mes, dia);
    Result := Copy(FloatToStr(Data),1,Pos('.',FloatToStr(Data))-1);
  end;
end;
//-----------------------------------------------------------------------------------------------
//--Retorna a diferenca de dias entre duas datas
function DifNumDias(DataVenc:TDateTime; DataAtual:TDateTime): String;
Var Data: TDateTime;
    dia, mes, ano: Word;
begin
  Data := DataAtual - DataVenc;
  DecodeDate( Data, ano, mes, dia);
  Result := Copy(FloatToStr(Data),1,Pos('.',FloatToStr(Data))-1);
end;
//-----------------------------------------------------------------------------------------------
//-- Em construção
//-- Define a cor de contraste;
procedure DefineCor( Modulo : string );
begin
  if Modulo = 'China'    then CorFixa := $00007F00; // Verde
  if Modulo = 'Pizza'    then CorFixa := $001D25DA; // vermelho
  if Modulo = 'Agua'     then CorFixa := $00E09800; // Azul
  if Modulo = 'Gas'      then CorFixa := $00AC7873; // Chumbo
  if Modulo = 'Lavacao'  then CorFixa := $00AC7873; // Chumbo
end;
//-----------------------------------------------------------------------------------------------
//-- da espacamento entre os caracteres ex.: ABC >>> A B C .
function CriaCabecalho(pNome: string) : string;
var i: integer;
    r,
    s : string;
begin
  for I := 1 to length(pNome) do begin
    r := copy(pNome,I,1);
    s := s+r+' ';
    Application.ProcessMessages;
  end;
  Result := s;
end;
//-----------------------------------------------------------------------------------------------
//-- Escreve n zeros a esquerda
Function StrZero(N: longint; Tamanho: integer): string;
var
  Conteudo: string;
  Diferenca: longint;
begin
  Conteudo := IntToStr( N );
  Diferenca := Tamanho - Length( Conteudo );
  if Diferenca > 0 then
    Conteudo := Repl( '0', Diferenca ) + Conteudo;
  StrZero := Conteudo;
end;
//-----------------------------------------------------------------------------------------------
Function Repl(C: string; Tamanho: integer): string;
var
  Conteudo: string;
  Contar: integer;
begin
  Conteudo := '';
  for Contar := 1 to Tamanho do
  begin
    Conteudo := Conteudo + C;
	 Application.ProcessMessages;
  end;
  Repl := Conteudo;
end;
//-----------------------------------------------------------------------------------------------
Function BuscaTamanhodoLookUp ( pTabela : TTable; pCampo : string ) : Integer; {Busca o Tamanho do Campo Bu}
begin
  Result := pTabela.FieldByName( 'Bu' + Copy(pCampo,3,length(pCampo)) ).Size;
end;
//-----------------------------------------------------------------------------------------------
Function BuscaConteudodoLookUp( pTabela : TTable; pCampo : string ) : string; {Busca o Conteudo do Campo Bu}
begin
  Result := pTabela.FieldByName( 'Bu' + Copy(pCampo,3,length(pCampo)) ).Text;
end;
//-----------------------------------------------------------------------------------------------
Function BuscaTipodoLookUp    ( pTabela : TTable; pCampo : string ) : TFieldType; {Busca o tipo do Campo Bu}
begin
  Result := pTabela.FieldByName( 'Bu' + Copy(pCampo,3,length(pCampo)) ).DataType;
end;
//-----------------------------------------------------------------------------------------------
Function MMDDAA( Data: string ): string;
var sDia, sMes, sAno: string;
begin
  sDia := Copy( Data, 1, 2 );
  sMes := Copy( Data, 4, 2 );
  sAno := Copy( Data, 7, 4 );
  if sDia + sMes + sAno = '        ' then
    MMDDAA := '        '
  else
    MMDDAA := sMes + '/' + sDia + '/' + sAno;
end;
//-----------------------------------------------------------------------------------------------
//-- Retorna data no formato diadia/mesmes/anoano (ano com 2 caracteres) barney 150302
function DDMMAA( pData: string ): string;
var sDia, sMes, sAno: string;
begin
  sDia := Copy(pData,1,2);
  sMes := Copy(pData,4,2);
  sAno := Copy(pData,9,2);
  if sDia+sMes+sAno = '      ' then result := '      ' else result := sDia+'/'+sMes+'/'+sAno;
end;
//-----------------------------------------------------------------------------------------------
//-- Retorna data no formato mesmes/diadia/anoanoanoano - barney 040502
function MMDDAAAA( pData: TDate ): string;
begin
  result := formatDateTime('dd/mm/yyyy', pData );
end;
//-----------------------------------------------------------------------------------------------
Function UltimoDiaDoMes( MesAno: string ): string;
var
  sMes: string;
  sAno: string;
begin
  sMes := Copy( MesAno, 1, 2 );
  sAno := Copy( MesAno, 4, 2 );
  if Pos( sMes, '01 03 05 07 08 10 12' ) > 0 then
    UltimoDiaDoMes := '31'
  else
    if sMes <> '02' then
      UltimoDiaDoMes := '30'
	 else
      if ( StrToInt( sAno ) mod 4 ) = 0 then
        UltimoDiaDoMes := '29'
      else
        UltimoDiaDoMes := '28';
end;
//-----------------------------------------------------------------------------------------------
Function Dia( Data: TDateTime ): string;
var
  sAno, sMes, sDia: Word;
begin
  DecodeDate( Data, sAno, sMes, sDia );
  Dia := StrZero( sDia, 2 );
end;
//-----------------------------------------------------------------------------------------------
//-- Retorna o dia da semana em formato string
Function DiadaSemana( Data: TDateTime ): string;
var DiadaSemana : byte;
begin
  try
	 DiaDaSemana := DayOfWeek( Data );
    case DiaDaSemana of
      1: Result := 'Domingo';
      2: Result := 'Segunda';
      3: Result := 'Treça';
      4: Result := 'Quarta';
      5: Result := 'Quinta';
      6: Result := 'Sexta';
      7: Result := 'Sábado';
    end;
  except
    MessageDlg('Erro na Data!', mtError, [mbOk], 0);
  end;
end;
//-----------------------------------------------------------------------------------------------
Function Mes( Data: TDateTime ): string;
var
  sAno, sMes, sDia: Word;
begin
  DecodeDate(Data, sAno,sMes,sDia);
  Result := StrZero( sMes, 2 );
end;
//-----------------------------------------------------------------------------------------------
Function MesExtenso( Data: TDateTime ): string; { Retorna o Mes de uma data }
begin
  if Mes(Data) = '01' then MesExtenso := 'Janeiro';
  if Mes(Data) = '02' then MesExtenso := 'Fevereiro';
  if Mes(Data) = '03' then MesExtenso := 'Março';
  if Mes(Data) = '04' then MesExtenso := 'Abril';
  if Mes(Data) = '05' then MesExtenso := 'Maio';
  if Mes(Data) = '06' then MesExtenso := 'Junho';
  if Mes(Data) = '07' then MesExtenso := 'Julho';
  if Mes(Data) = '08' then MesExtenso := 'Agosto';
  if Mes(Data) = '09' then MesExtenso := 'Setembro';
  if Mes(Data) = '10' then MesExtenso := 'Outubro';
  if Mes(Data) = '11' then MesExtenso := 'Novembro';
  if Mes(Data) = '12' then MesExtenso := 'Dezembro';
end;
//-----------------------------------------------------------------------------------------------
Function Ano( Data: TDateTime ): string;
var
  sAno, sMes, sDia: Word;
begin
  DecodeDate( Data, sAno, sMes, sDia );
//  Ano := Copy( StrZero( sAno, 4 ), 3, 2 );
  Ano := StrZero( sAno, 4 );
end;
//-----------------------------------------------------------------------------------------------
Function Ano2( Data: TDateTime ): string;
var
  sAno, sMes, sDia: Word;
begin
  DecodeDate( Data, sAno, sMes, sDia );
  Ano2 := Copy( StrZero( sAno, 4 ), 3, 2 );
end;
//-----------------------------------------------------------------------------------------------
Function MesAno( Data: TDateTime ): string;
var
  sAno, sMes, sDia: Word;
begin
  DecodeDate( Data, sAno, sMes, sDia );
  MesAno := StrZero( sMes, 2 ) + '/' + Copy( StrZero( sAno, 4 ), 3, 2 );
end;
//-----------------------------------------------------------------------------------------------
Function Zeros( Dados: string ): string;
begin
  if Dados <> Space( Length( Dados ) ) then
     Dados := StrZero( StrToInt( AllTrim( Dados ) ), Length( Dados ) );
  Zeros := Dados;
end;
//-----------------------------------------------------------------------------------------------
Function IncZeros( Dados: string; Tamanho: integer): string;
var
  Diferenca: longint;
begin
  if Dados <> '' then begin
    Diferenca := Tamanho - Length( Dados );
    if Diferenca > 0 then
      Dados := Repl( '0', Diferenca ) + Dados;
  end;
  Result := Dados;
end;
//-----------------------------------------------------------------------------------------------
//-- [k] Tira todos os espaços em branco de uma string
function AllTrim( Dados: string ): string;
var Contar: integer;
begin
  Dados := Trim( Dados );
  for Contar := 1 to Length( Dados ) do
  begin
    if Copy( Dados, Contar, 1 ) <> ' ' then Break;
    Dados := Copy( Dados, Contar + 1, Length( Dados ) - 1 );
    Application.ProcessMessages;
  end;
  AllTrim := Dados;
end;
//-----------------------------------------------------------------------------------------------
// essa é a antiga definição - procedure Commit(DataSet: TDataSet); //-- Kass - - Simula o COMMIT do Clipper
//-- Baixar os dados alterados da memória p/ o HD
// Pelo q entendi o commit não é suportado por sql - logo deve ser usado ttable
// e nao dataset genérico - lembro q isso era suportado pelo delphi 2
Procedure Commit( pTabela: TTable ); //-- Barney - What is a man? [090502]
begin
  try
    pTabela.UpdateCursorPos;
	 Check(DBISaveChanges(pTabela.Handle));
    pTabela.CursorPosChanged;
  except
  raise
  end;
end;
//-----------------------------------------------------------------------------------------------
//-- Kass - st : string com texto completo - si : caracter a procurar "String Síimbolo"
//-- Retorna a Sub String Anterior
function SubStrAnt( st, si : string ) : string;
begin
  if Pos( si, st ) > 0 then
    result := copy ( st, 0,Pos(si,st)-1)
  else
    result := '';
end;
//-----------------------------------------------------------------------------------------------
//-- Kass - st : string com texto completo - si : caracter a procurar "String Síimbolo"
//-- Retorna a Sub String Posterior
function SubStrPos( st, si : string ) : string;
begin
  if Pos( si, st ) > 0 then
    result := copy(st,Pos(si,st)+1,Length(st)-Pos(si,st))
  else
    result := '';
end;
//-----------------------------------------------------------------------------------------------
//-- Kass - st : string com texto completo - si : caracter a procurar "String Simbolo"
//-- Retorna Verdadeiro se existir
function SubStrOk( st, si : string ) : bool; // Retorna Verdadeiro se existe o caracter
begin
  if Pos( si, st ) > 0 then
    result := True
  else
    result := False;
end;
//-----------------------------------------------------------------------------------------------
//-- Kass - st : string com texto completo - si : caracter a procurar "String Simbolo"
//-- Quantidade de Caracter Existente
function ContaSubStr( st, si : string ) : byte;
var i, q: byte;
begin
  q := 0;
  for i:= 0 to length(st) do
    if st[i] = si then
      inc(q);
  result := q;
end;
//-----------------------------------------------------------------------------------------------
//-- Kass - pTabela   : Tabela a procurar,
//          pIndice   : Indice a ordenar a procura
//          pStr      : String a ser procurada
//          pErro     : Mensagem de Erro caso não encontrado
//          Resultado : Retorna verdadeiro ou falso
//--        Função    : Localizar um registro
function Localizar(pTabela : TTable; pIndice, pStr, pErro : string ; pMsg : Bool): bool;
var IndexAnt : string;
begin
  IndexAnt := pTabela.IndexName;
  pTabela.IndexName := pIndice;
  if pTabela.FindKey([pStr]) then begin
    pTabela.IndexName := IndexAnt;
    result := true; end
  else begin
    if pMsg then MessageDlg(pErro + ' não foi encontrado!', mtError, [mbOk], 0);
    pTabela.IndexName := IndexAnt;
    result := false;
  end;
end;
//-----------------------------------------------------------------------------------------------
//-- Retorna a diferença entre dois horarios de duas datas, o retorno sera em numero de minutos
function DiferencaMinutos(HoraInicial,HoraFinal,DataInicial,DataFinal:TDateTime):Integer;
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
//-- Retorna a diferenca de dias entre duas datas, o retorno sera em numero de dias
function DiferencaData(DataInicial:TDateTime; DataFinal:TDateTime): integer;
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
function FloatToInt(Numero:real):Integer; // Transforma de Real para Inteiro}
begin
  result := StrToInt(FloatToStr(Numero));
end;
//-----------------------------------------------------------------------------------------------
function InttoFloat(Numero:Integer):Real; // Transforma de Inteiro para Real;
begin
  result := StrToFloat(IntToStr(Numero));
end;
//-----------------------------------------------------------------------------------------------
//-- Enquadra janela com windowssatate e posicao do form
procedure enquadraJanela(pForm : TForm);
begin
  pForm.windowState := wsNormal;
  pForm.left := 0;
  pForm.top  := 0;
end;
//-----------------------------------------------------------------------------------------------
//-- Verifica se a data é valida
function verificarData(pData: String):Boolean;
var  DataTest : TDateTime;
begin
  try
    DataTest := StrToDate(pData);
    Result := True;
  except
    Result := False;
  end;
end;
//-----------------------------------------------------------------------------------------------
//-- Verifica se a hora é valida [barney - 120402]
function verificarHora(pHora: String):Boolean;
var  HoraTeste : TDateTime;
begin
  try
    HoraTeste := StrToTime(pHora);
    Result := True;
  except
    Result := False;
  end;
end;
//-----------------------------------------------------------------------------------------------
function IncrementarMinutos( pHora: TDateTime; pMinutos : Integer):String;
var
  tempo: TDateTime;
  hour, min, sec, mSec : Word;
begin
  DecodeTime(pHora, hour, min, sec, mSec);
  min := min + pMinutos;
  hour := hour + (min div 60);
  if hour > 23 then hour := hour - 24;
  tempo := EncodeTime(hour, min mod 60, sec, mSec);
  result := TimeToStr(tempo);
end;
//-----------------------------------------------------------------------------------------------
//-- Retorna a diferença entre dois horarios de duas datas, o retorno sera em numero de segundos
function DiferencaSegundos(HoraInicial,HoraFinal,DataInicial,DataFinal:TDateTime):Integer;
var
  DifData : Integer;
  HourI,
  MinI,
  SecI,
  MSecI,
  HourF,
  MinF,
  SecF,
  MSecF : Word;
begin
  DecodeTime(HoraInicial, HourI, MinI, SecI, MSecI);
  DecodeTime(HoraFinal, HourF, MinF, SecF, MSecF);
  DifData := DiferencaData(DataInicial, DataFinal);
  if DifData > 0 then
    Result := ((DifData-1)*86400) + ((23-HourI)*3600) + ((59-MinI)*60) + (60-SecI) + (HourF*3600) + (MinF*60) + (SecF)
  else begin
    if DifData = 0 then begin
      if HourI = HourF then
        Result := ((MinF*60) + SecF) - ((MinI*60) + SecI)
      else
        Result := ((((HourF-HourI)-1)*3600) + ((59-MinI)*60) + (60-SecI) +(MinF*60) + (SecF));
    end
    else
      Result := -1; // -1 sera o codigo de erro da diferenca
  end;
end;

//-----------------------------------------------------------------------------------------------
// transforma um valor em uma string com 3 casas decimais, idependente do valor
function comTresCasas( pvalor : string ) : string;
var vl : string;
begin
  vl := pvalor ;
  if not SubStrOk( vl, '.' ) then
    vl := vl + '.000'
  else
    if SubStrOk( vl, '.00' ) then
      vl := vl + '0';
    result := vl;
end;
//-----------------------------------------------------------------------------------------------
function iif( pCondi : boolean ;  pbloco1, pbloco2 : string ) : string; //-- Resumo do comando IF ELSE ENDIF
begin
//creat
  if pCondi then result :=  pbloco1 else result := pbloco2;
{
  if pCondi then
	 &pBolco1
  else
	 &pBoloc2;
}
end;
//-----------------------------------------------------------------------------------------------
function irparaoprimeiropegistro( pTabela : TTable ) : bool;
begin
  result := false;
  try
    if pTabela.State in [dsinsert, dsedit] then pTabela.Cancel;
    pTabela.First;
    result := true;
  except
    MessageDlg('Erro ao navegar para o primeiro registro!', mtError, [mbOk], 0);
  end;
end;
//-----------------------------------------------------------------------------------------------
function irParaoRegistroAnterior( pTabela : TTable ) : bool;
begin
  result := false;
  try
	 if pTabela.State in [dsinsert, dsedit] then
		pTabela.Cancel;
	 pTabela.Prior;
    result := true;
  except
    MessageDlg('Erro ao navegar para o registro anterior!', mtError, [mbOk], 0);
  end;
end;

//-----------------------------------------------------------------------------------------------

function irparaoproximoregistro( pTabela : TTable ) : bool;
begin
  result := false;
  try
    if pTabela.State in [dsinsert, dsedit] then
      pTabela.Cancel;
    pTabela.next;
    result := true;
  except
    MessageDlg('Erro ao navegar para o próxima registro!', mtError, [mbOk], 0);
  end;
end;

//-----------------------------------------------------------------------------------------------

function irparaoultimoregistro( pTabela : TTable ) : bool;
begin
  result := false;
  try
    if pTabela.State in [dsinsert, dsedit] then
      pTabela.Cancel;
    pTabela.last;
    result := true;
  except
    MessageDlg('Erro ao navegar para o último registro!', mtError, [mbOk], 0);
  end;
end;

//-----------------------------------------------------------------------------------------------

function incluirumregistro(pTabela : TTable): bool;
begin
  result := false;
  if pTabela.State in [dsInsert,dsEdit] then begin
    MessageDlg('O banco de dados já está em modo de inclusão,'+#13+
      'ou está em modo de edição, nesse caso, grave antes![309-1]', mtInformation, [mbOk], 0);
    Exit;
  end;
  try
    pTabela.Append;
    result := true;
  except
    MessageDlg('Erro ao incluir registro!', mtError, [mbOk], 0);
  end;
end;

//-----------------------------------------------------------------------------------------------
//-- Retorna o valor maximo + 1 do contador da tabela
function buscarMaxContador(pQuery : TQuery; pTabela : String): integer;
var sql : string;
begin
  sql := 'SELECT '+
         '  max(contador) as maxContador '+
         'FROM '+
			pTabela;
  abrirQuery(pQuery,sql);
  result := pQuery.fieldByName('maxContador').asInteger+1
end;
//-----------------------------------------------------------------------------------------------
//-- post e commit na tabela sem mansagem --barney 130602
function salvarTabela(pTabela:TTable): boolean;
begin
  try
    pTabela.Post;
    Commit(pTabela);
    result := true;
  except
    MessageDlg('Erro ao salvar os dados!', mtError, [mbOk], 0);
    result := false;
  end;
end;
//-----------------------------------------------------------------------------------------------
function salvarUmRegistro(pTabela:TTable): bool;
begin
  result := false;
  try
    if pTabela.State in [dsInsert,dsEdit] then begin
      try
        pTabela.Post;
        Commit(pTabela);
        MessageDlg('Os dados foram gravados com sucesso!', mtInformation, [mbOk], 0);
        result := true;
      except
        MessageDlg('Erro ao gravar registro!', mtError, [mbOk], 0);
      end;
    end;
  except
    MessageDlg('Erro ao gravar dados!', mtError, [mbOk], 0);
  end;
end;
//-----------------------------------------------------------------------------------------------
function ininicaraExclusao: bool;
begin
	result := (MessageDlg('Deseja excluir o registro permanentemente?', mtWarning, [mbYes, mbNo], 0) = mrYes);
end;
//-----------------------------------------------------------------------------------------------
function excluirumregistro( pTabela : TTable ) : bool;
begin
  result := false;
  try
    pTabela.Delete;
    result := true;
  except
    MessageDlg('Erro na tentativa se excluir registro!', mtError, [mbOk], 0);
  end;
end;
//-----------------------------------------------------------------------------------------------
function fecharjanela( pForm : TForm; pTabela : TTable) : bool;
begin
  try
    if pTabela.State in [dsinsert,dsedit] then pTabela.Cancel;
    Commit(pTabela);
    pForm.Release;
    result := true;
  except
    result := false;
  end;
end;
//-----------------------------------------------------------------------------------------------
//-- Cria codigo do pedido
function criarNrPedido(pNrPedido:string):String;
var nPed : String;
begin
  nPed := pNrPedido;
  if Copy(nPed,5,2) = Copy(DateToStr(now),1,2) then begin
    nPed := IntToStr(StrToInt(Copy(nPed,1,3))+1);
    case Length(nPed) of
      1 : nPed := ('00'+nPed);
      2 : nPed := ('0' +nPed);
      4 : nPed := ('001');
    end;
    result := (nPed+'/'+Copy(DateToStr(now),1,2));
  end else result := '001'+'/'+Copy(DateToStr(now),1,2);
end;
//-----------------------------------------------------------------------------------------------
//-- Cria novo Nº pedido levando em consideração a hora de virada
function criarNrPedidoComVirada(pDataAtual:TDateTime;pNrPedido:string;p_NumInicialCupom:string;p_HoraVirada:string):String;
var	nPed     : String;
		cont     : byte;
		diaAtual : TDateTime;
begin
	if (StrToTime(p_HoraVirada) > (pDataAtual-int(pDataAtual))) then
		diaAtual := int(pDataAtual)-1
	else
		diaAtual := int(pDataAtual);
	nPed := pNrPedido;
	if Copy(nPed,5,2) = Copy(DateToStr(diaAtual),1,2) then begin
		nPed := IntToStr(StrToInt(Copy(nPed,1,3))+1);
	end else begin
		nPed := p_NumInicialCupom;
	end;
	for cont := Length(nPed) to 2 do nPed := '0'+nPed;
	result := (nPed+'/'+Copy(DateToStr(diaAtual),1,2));
end;
//-----------------------------------------------------------------------------------------------
procedure tentarAbrirBanco(pDB: TDataBAse; pMsg, pErro: String);
begin
	try
		if not pDb.Connected then pDB.Connected := True;
	except
		MessageDlg('Erro ao abrir banco de dados ['+ pMsg +']! ['+pErro+']', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure tentarFecharBanco( pDB:TDataBAse; pMsg,pErro:String);
begin
	try
		if pDb.Connected then pDB.Connected := False;
	except
		MessageDlg('Erro ao fechar banco de dados ['+ pMsg +']! ['+pErro+']', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure tentarAbrirTabela( pTab:TTable; pMsg, pErro:String);
begin
  try
    if not pTab.Active then pTab.Open;
  except
    MessageDlg('Erro ao abrir a tabela '+pTab.Name+'. ('+pMsg+')! ['+pErro+']', mtError, [mbOk], 0);
  end;
end;
//-----------------------------------------------------------------------------------------------
//-- Tenta fechar uma tabela
procedure tentarFecharTabela(pTabela: TTable; pMsg, pErro:String);
begin
  try
    if pTabela.Active then pTabela.Close;
  except
	 MessageDlg('Erro ao fechar a tabela '+pTabela.Name+'. ('+pMsg+')! ['+pErro+']', mtError, [mbOk], 0);
  end;
end;
//-----------------------------------------------------------------------------------------------
//-- Inicia uma query p/ inserção do código SQL - Barney - 300102
procedure iniciarQuery(pQuery: TQuery);
begin
	pQuery.close;
	pQuery.SQL.Clear;
end;
//-----------------------------------------------------------------------------------------------
//-- Executar uma query - Barney - 070202
procedure executarQuery(pQuery: TQuery;pSQL : string);
begin
	iniciarQuery(pQuery);
	pQuery.SQL.add(pSQL);
	pQuery.ExecSQL();
end;
//-----------------------------------------------------------------------------------------------
//-- Abre uma query e vai p/ o primeiro registro- Barney - 070202
procedure abrirQuery(pQuery: TQuery;pSQL : string);
begin
	iniciarQuery(pQuery);
	pQuery.SQL.Add(pSQL);
	pQuery.Open();
	pQuery.First();
end;
//-----------------------------------------------------------------------------------------------
//-- Verifica se há registro valido na consulta
//-- ATENÇÃO - não utilize funções agregadas de SQL como SUM e semelhantes
//-- Esse tipo de função altera o formato de retorno do SQL
function verificarExistenciaDeRegistro(pQuery: TQuery;pSQL : string): boolean;
begin
  abrirQuery(pQuery,pSQL);
  if (pQuery.EOF = pQuery.BOF) then result := False else result := True;
end;
//-----------------------------------------------------------------------------------------------
//-- Verifica se já existe informação com este conteudo, travando a inclusão -- kass - 060202
function verificarcampo(pCampo:string; pEdit:TDBEdit):bool;
begin
  iniciarQuery( FFuncoes.qverifica );
  FFuncoes.qverifica.sql.add('select '+pcampo+' from tcadprod where '+pcampo+'=:xpar');
  FFuncoes.qverifica.ParamByName('xpar').AsString := pEdit.Text;
  FFuncoes.qverifica.open;
  if FFuncoes.qverifica.bof=FFuncoes.qverifica.eof then
    result := true
  else begin
    MessageDlg('Já existe registro com o campo ' + pCampo + ' !', mtInformation, [mbOk], 0);
    result := false;
  end;
end;
//-----------------------------------------------------------------------------------------------
//-- Abre ou cria form filho
procedure AbrirFormFilho(pNomeForm: String; var Reference);
begin
{
  iClass.ClassName := 'T'+pNomeForm;
  if not verificarSeFormEstaAberto(pNomeForm) then begin
    Application.createForm(iClass, Reference);
  end
  else
    Reference.show;
}
end;

//-----------------------------------------------------------------------------------------------
//-- Ordena grade do tipo Wwdbgrid - barney 080102
procedure deletarRegistro(pQuery: TQuery; pTabela, pContador : string; pPergunta: Boolean);
var sql : string;
begin
  try
    sql := (
      'DELETE FROM  '+
      '  '+pTabela+' '+
      'WHERE  '+
      '  Contador = '+pContador
    );
	 if pPergunta then begin
		if (MessageDlg('Deseja excluir o registro selecionado?', mtWarning, [mbYes, mbNo], 0) = mrYes) then begin
		  executarQuery(pQuery,sql);
      end;
    end
    else begin
      executarQuery(pQuery,sql);
    end;
  except
    MessageDlg('Erro ao excluir registro!', mtError, [mbOk], 0);
  end;
end;

//-----------------------------------------------------------------------------------------------
//-- Refesh em query - barney 180302
procedure atualizarQuery(pQuery: TQuery);
begin
  try
    pQuery.Close;
    pQuery.Open;
  except
    MessageDlg('Erro ao atualizar conteúdo da consulta!', mtError, [mbOk], 0);
  end;
end;

//-----------------------------------------------------------------------------------------------
//-- mostra janela para controle de acesso - barney 190302
function mostrarJaneladeAcesso(pDataBase, pUsuario, pSenha: String): boolean;
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
//-----------------------------------------------------------------------------------------------
{$R-}
{$Q-}
//-- Funcao de decriptografia simples  //Standard Encryption algorithm - Copied from Borland
function Encrypt(const InString:string; StartKey,MultKey,AddKey:Integer): string;
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
//-----------------------------------------------------------------------------------------------
//-- Funcao de decriptografia simples  //Standard Encryption algorithm - Copied from Borland
function Decrypt(const InString:string; StartKey,MultKey,AddKey:Integer): string;
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
//-----------------------------------------------------------------------------------------------
//-- Converte até 4 número hexa (ex.: 0x5B, 0x00) em um único inteiro longo
function converter4HexToInt(t: string): integer;
var c: integer;
    cont:integer;
    i: integer;
    a: integer;
    d: integer;
begin
  c := 0;
  t := UpperCase(t);
  a := Length(t);
  if (a>8) then begin
    result := 0;
    Exit;
  end;
  for cont:=a downto 1 do
  begin
    i := Ord(t[cont]);
    if((i >= 48)and(i <= 57)) then
    begin
      i:=i-48
    end
    else
    begin
      if((i >=65)and(i <= 70)) then begin
        i:=i-65+10;
		end
      else
      begin
        result := 0;
        Exit;
		end;
	 end;
	 d := (a-cont)*4;
	 c := c or (i SHL d);
  end;
  result := c;
end;
//-----------------------------------------------------------------------------------------------
//-- Prepara um periodo relevando datas e hora de virada
function fazerPeriodo(pDtInicial,pDtFinal,pHoraVidada,pCampoData,pCampoHora : string):string;
var
	 dataInicial   : string;
	 dataInicial2  : string;
	 dataFinal     : string;
	 dataFinal2    : string;
	 periodo       : string;
	 periodo2      : string;
	 periodoNormal : string;
begin
  periodo:='';
  periodo2:='';
  periodoNormal:='';
  dataInicial :=FormatDateTime('mm/dd/yyyy',strToDate(pDtInicial)+1);
  dataInicial2:=FormatDateTime('mm/dd/yyyy',strToDate(pDtInicial));
  dataFinal2  :=FormatDateTime('mm/dd/yyyy',strToDate(pDtFinal)+1);
  dataFinal   :=FormatDateTime('mm/dd/yyyy',strToDate(pDtFinal));
  if (pHoraVidada<>'00:00:00') then
  begin
	 //-- Primeiro Periodo
	 periodo  := ' ('+pCampoData+' = "'+DataInicial2+'" ';
	 if (pCampoHora <> '') then periodo := periodo+' AND '+pCampoHora+' >= "'+pHoraVidada+'"';
	 periodo  := periodo+') OR ';
	 //-- Ultimo Periodo
	 periodo2 := ' ('+pCampoData+' = "'+DataFinal2+'" ';
	 if (pCampoHora <> '') then periodo2 := periodo2+' AND '+pCampoHora+' <= "'+pHoraVidada+'" ';
	 periodo2 := periodo2+')';
	 if (strToDate(pDtFinal)-strToDate(pDtInicial)>0) then
	 begin
		//-- Periodo central
		periodoNormal :=' ('+pCampoData+' >= "'+DataInicial+'" AND '+pCampoData+' <= "'+DataFinal+'" ) OR ';
	 end
	 else
	 begin
		//-- Mesmo dia
		if (strToDate(pDtFinal)-strToDate(pDtInicial)=0) then periodoNormal:='' else MessageDlg('Digite um intervalo em valores crescentes de data', mtInformation, [mbOk], 0);
	 end;
  end
  else
  begin
	 if (strToDate(pDtFinal)-strToDate(pDtInicial)>=0) then
	 begin
		periodoNormal:='   ('+pCampoData+' >= "'+dataInicial2+'" '+
							'AND '+
							'    '+pCampoData+' <= "'+DataFinal+'" )';
	 end
	 else
	 begin
		MessageDlg('Digite um intervalo em valores crescentes de data!', mtInformation, [mbOk], 0);
	 end;
  end;
  result := periodo+periodoNormal+periodo2;
end;
//-----------------------------------------------------------------------------------------------
procedure TFFuncoes.atualizarTabela(p_Tabela:TTable);
begin
	p_Tabela.Close();
	p_Tabela.Open();
end;
//-----------------------------------------------------------------------------------------------
procedure TFFuncoes.commitDireto(var pt_DB : TDatabase);
begin
	pt_DB.StartTransaction();
	try
		pt_DB.Commit(); // on success, commit the changes;
	 except
		pt_DB.Rollback(); // on failure, undo the changes
	end;
end;
//----------------------------------------------------------------------------
procedure TFFuncoes.iniciarTransacao(var pt_DB : TDatabase);
begin
	pt_DB.StartTransaction();
end;
//----------------------------------------------------------------------------
procedure TFFuncoes.finalizarTransacao(var pt_DB : TDatabase);
begin
	try
		pt_DB.Commit(); // on success, commit the changes;
	 except
		pt_DB.Rollback(); // on failure, undo the changes
	end;
end;
//-----------------------------------------------------------------------------------------------
end.
//-----------------------------------------------------------------------------------------------
//   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM
//-----------------------------------------------------------------------------------------------

