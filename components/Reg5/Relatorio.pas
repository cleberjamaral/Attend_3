//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//
//                               O C E A N O
//            N A V E G E    N E S T E    M A R    S O L U Ç Õ E S
//
//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//                                I N I C I O
//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
// Criação      : 22/06/2001 11:00
// Local        : Escritório, Florianópolis
// Descrição    : Componente de Relatório
//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//                                HISTÓRICO
//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

// Data        : 22/06/2001
// Atualização : Criação

// Data        :
// Atualização :

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

unit Relatorio;

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

interface

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, DB, Printers, ComCtrls, ExtCtrls;

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

type

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

  TTipo             = (tiGRAFICO, tiTXT, tiHTM, tiRTF, tiDOC, tiXLS);
  TColunas          = (co20, co30, co40, co60, co80, co130);
  TLinhaEvent       = procedure( Sender : TComponent; var StString: string) of object;

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

  TORelatorio = class(TComponent)

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

  private

    FOnLinha  : TLinhaEvent;  //-- Evento que busca o conteúdo da linha
    FTipo     : TTipo;        //-- FTipo = Tipo de Relatório
    FColunas  : TColunas;     //-- FColunas = Colunas do Relatório
    FPag      : Byte;         //-- FPag = Página Atual do Relatório
    FRod      : Integer;      //-- FRod = Linha Rodapé do relatório
    FLin      : Integer;      //-- FLin = Linha Atual
    FCol      : Integer;      //-- FCol = Coluna Atual
    FTam      : Integer;      //-- FTam = Tamanho da ( largura ) da fonte
    FAlt      : Integer;      //-- FAlt = Altura da fonte
    FCof      : Integer;      //-- FCof = Coluna Final do Relatório
    FCoi      : Integer;      //-- FCoi = Coluna Inicial do Relatório
    FQue      : TQuery;       //-- FQue = Query  do Relatório
    FTab      : TTable;       //-- FTab = Tabela do Relatório
//    FTit      : string;       //-- FTit = Título do Relatório
//    FFil      : string;       //-- FFil = Título do Filtro
    FIni      : bool;         //-- Ini = Inicio de Página
    FQuery    : Bool;         //-- Utilizar Query
//    FCampo    : array[0..20] of Integer; // Campos a serem impressos
    FRodape   : Bool;         //-- Imprime ou não um Ródapé totalizador
    FStRodape : string;       //-- String do Rodapé
    FStSubRoda: string;       //-- Sub Rodapé por página
    FPath     : string;       //-- Caminho para os arquivos salvos
    FHTM      : Textfile;     //-- Header de Impressão em HTM
    FTXT      : TextFile;     //-- Header de Impressão em TXT
    FRTF      : TextFile;     //-- Header de Impressão em RTF
    FDOC      : TextFile;     //-- Header de Impressão em DOC
    FXLS      : TextFile;     //-- Header de Impressão em XLS
    FTP       : TextFile;     //-- Header de Impressão para Impressora
    FTamFonte : byte;         //-- Tamanho da fonte;
//    FTamRisco : byte;         //-- Tamanho do Risco;
    FStNome   : string;  //-- Nome do relatório
    FStTitu   : string;  //-- Título do relatório
    FStCabe   : string;  //-- Cabecalho do relatório
    FStFilt   : string;  //-- String do Título do filtro
    FStSub    : string;  //-- String do primeiro subtítulo
    FVisu     : Bool;  //-- Visualiza o Relatório antes de imprimir
    FPrev     : TForm;  //-- Formulário de Visualização do Relatório
    FM        : TRichEdit; //-- RichEdit  do Formulário de
    FT        : TPanel;
    FRetorno  : string;
    FstEmpresa : string; //-- String com o nome da empresa;    
    procedure Inicia_Variaveis; //-- Inicializa as Variáveis
    procedure Linha(pLin: Integer); //-- Linha do relatório
    procedure Coluna(pCol: Integer); //-- Coluna do relatório
    procedure Pula_Linha; // Pula uma linha
    procedure Inicia_Relatorio; //-- Comandos de Inicializaçao
    procedure Finaliza_Relatorio; //-- Comandos de Finalização
    procedure Visualiza_Relatorio; //-- Comandos de Visualização
    procedure Fim_de_Pagina(pTotaIs: string); // Rotina de Fim de Página
    procedure Imprime_Relatorio; //-- Comandos de Impressão
    procedure Inicio_da_Tabela(pTabela: TTable); //-- Seta Tabela para o Inicio
    procedure Inicio_da_Query(pQuery: TQuery);   //-- Seta Query para o Inicio
    procedure Fim_de_Tabela(pTabela : TTable; pRodape : string); //-- Imprime Finalização para a Tabela
    procedure Fim_de_Query(pQuery : TQuery; pRodape : string); //-- Imprime Finalização para a Query
    procedure Centra(pCi, L:Integer; sTexto:String; pCf: integer); //-- Imprime o Texto centralizado
    procedure Risca(pCoi, pCof, pLin: Integer ); // Imprime um Risco
    procedure Cabecalho(pNome, pTitulo, pCabe, pFiltro, pSub : string ); // Imprime o Cabeçalio
    procedure Escreve(pConteudo : string ); //-- Escreve uma expressão na coluna atual
    procedure Fonte( pFonte : string ); //-- Define a fonte do relatório
    procedure SetaColuna( Valor : TColunas );
    function  StrZero(N: longint; Tamanho: integer): string; //-- Coloca zeros a esquerda
    function Repl(C: string; Tamanho: integer): string; //-- Replica um caracter
    procedure Imprime_linha; // Imprime a linha
//    function  Fim_da_Tabela( pTabela : TTable ) : bool;
//    function  Fim_da_Query( pQuery : TQuery )  : bool;
    procedure Escreve_SubRodape(pTotaIs: string); // Imprime o sub Rodapé

  protected

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Executa   : Bool;
  published
    property Tipo       : TTipo       read FTipo      write FTipo;
    property Colunas    : TColunas    read FColunas   write SetaColuna;
    property Query      : Bool        read FQuery     write FQuery;
    property Rodape     : Bool        read FRodape    write FRodape;
    property StRodape   : String      read FStRodape  write FStRodape;
    property StSubRoda  : String      read FStSubRoda write FStSubRoda;
    property Path       : string      read FPath      write FPath;
    property TamFonte   : byte        read FTamFonte  write FTamFonte;
    property TamRisco   : byte        read FTamFonte  write FTamFonte;
    property Nome       : string      read FStNome    write FStNome;
    property Titulo     : string      read FStTitu    write FStTitu;
    property StCabecalho: string      read FStCabe    write FStCabe;
    property Filtro     : string      read FStFilt    write FStFilt;
    property SubTitulo  : string      read FStSub     write FStSub;
    property NomeTabela : TTable      read FTab       write FTab;
    property NomeQuery  : TQuery      read FQue       write FQue;
    property Visualiza  : Bool        read FVisu      write FVisu;
    property ColInicial : Integer     read FCoi       write FCoi;
    property LinFinal   : Integer     read FRod       write FRod;
    property StEmpresa  : string      read FStEmpresa write FStEmpresa;
    property OnLinha    : TLinhaEvent read FOnLinha   write FOnLinha;
  end;

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

procedure Register;

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

implementation

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

constructor TORelatorio.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

    FPrev             := TForm.create(self);
    FPrev.Caption     := 'Visualização do Relatório';
    FPrev.Font.Color  := clWindowText;
    FPrev.Font.Height := -11;
    FPrev.Font.Name   := 'MS Sans Serif';
    FPrev.Font.Style  := [];
    FPrev.Width       := 999;
    FPrev.Height      := 706;

    FT                := TPanel.create(FPrev);
    FT.Left           := 0;
    FT.Top            := 0;
    FT.Width          := 991;
    FT.Height         := 41;
    FT.Align          := alTop;
    FT.TabOrder       := 0;
    FT.Parent         := FPrev;
    FT.BevelOuter     := bvNone;


    FM                := TRichEdit.create(FPrev);
    FM.Left           := 0;
    FM.Top            := 41;
    FM.Width          := 991;
    FM.Height         := 638;
    FM.Align          := alClient;
    FM.TabOrder       := 1;
    FM.Parent         := FPrev;
    FM.BorderStyle    := bsNone;
    FM.Ctl3D          := False;
    FM.ParentCtl3D    := False;
    FM.Font.Color     := clBlack;
    FM.Font.Height    := -16;
    FM.Font.Name      := 'Courier New';
    FM.Font.Style     := [];
    FM.HideScrollBars := False;
//    FM.ScrollBars     := ssBoth;
    FRod := 56;
end;


//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

destructor TORelatorio.Destroy;
begin
  FPrev   := nil;
  FT      := nil;
  FM      := nil;
  inherited Destroy;
end;

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//-- Registra o Componente
procedure Register;
begin
  RegisterComponents('Oceano', [TORelatorio]);
end;

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//-- Verifica o Fim da Tabela
{
function TORelatorio.Fim_da_Tabela( pTabela : TTable )  : bool;
begin
 if pTabela.Eof then
   Result := True
 else
   Result := False;
end;
}
//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//-- Verifica o Fim da Query
{
function TORelatorio.Fim_da_Query( pQuery : TQuery ): Bool;
begin
 if pQuery.Eof then
   Result := True
 else
   Result := False;
end;
}
//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//-- Seta a Tabela para o Início
procedure TORelatorio.Inicio_da_Tabela( pTabela : TTable );
begin
  if not pTabela.Active then pTabela.Open; 
  pTabela.First;
end;

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//-- Seta a Query para o Início
procedure TORelatorio.Inicio_da_Query( pQuery : TQuery );
begin
  if not pQuery.Active then pQuery.Open; 
  pQuery.First;
end;

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//-- Inicia Relatório
procedure TORelatorio.Inicia_Relatorio;
var pathenome : string;
begin

  case FTipo of
    tiGRAFICO :
    begin
//        QRPrinter.Cleanup;    // Finalização do Relatório
//        QRPrinter.BeginDoc;  // Inicio do Relatório
//        QRPrinter.Title := FStNome;
      end;
    tiTXT :
    begin
      PatheNome := FPath+FStNome;
      FTam := 1;
      FAlt := 1;
      AssignFile (FTXT, PatheNome+'.txt' );
      Rewrite (FTXT);
    end;
    tiHTM :
    begin
      PatheNome := FPath+FStNome;
      FTam := 1;
      FAlt := 1;

      AssignFile (FHTM, PatheNome+'.htm' );
      Rewrite (FHTM);
    end;
    tiRTF :
    begin
      PatheNome := FPath+FStNome;
    end;
    tiDOC :
    begin
      PatheNome := FPath+FStNome;
    end;
    tiXLS :
    begin
      PatheNome := FPath+FStNome;
    end;
 end;
end;

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//-- Finaliza Relatório
procedure TORelatorio.Finaliza_Relatorio;
begin

  case FTipo of
//    tiGRAFICO :  QRPrinter.EndDoc;    // Finalização do Relatório
    tiTXT     :  CloseFile (FTXT);
    tiHTM     :  CloseFile (FHTM);
    tiRTF     :  CloseFile (FRTF);
    tiDOC     :  CloseFile (FDOC);
    tiXLS     :  CloseFile (FXLS);
  end;

  if not FQuery then begin
    if FTab.Active then FTab.Close;
  end
  else begin
    if FQue.Active then FQue.Close;
  end;  

end;

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//-- Visualiza Relatório
procedure TORelatorio.Visualiza_Relatorio;
var vis, PatheNome : string;
begin
  case FTipo of
//    tiGRAFICO : QRPrinter.Preview;
    tiTXT :
    begin
      PatheNome := FPath+FStNome+'.txt';
      FM.Lines.LoadFromFile(PatheNome);
      FPrev.show;
    end;

    tiHTM : vis := '';
    tiRTF : vis := '';
    tiDOC : vis := '';
    tiXLS : vis := '';
  end;
end;


//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//-- Visualiza Relatório
procedure TORelatorio.Imprime_Relatorio;
var imp : string;
begin

  case FTipo of
//    tiGRAFICO : QRPrinter.Print;
    tiTXT :
    begin
      AssignPrn(FTP);
      Rewrite(FTP);
      WriteLn(FTP, 'conteúdo');
      CloseFile(FTP);
    end;
    tiHTM :
    begin
      imp := '';
    end;
    tiRTF :
    begin
      imp := '';
    end;
    tiDOC :
    begin
      imp := '';
    end;
    tiXLS :
    begin
      imp := '';
    end;
  end;

end;

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//-- Inicia Variaveis;
procedure TORelatorio.Inicia_Variaveis;
begin
  FLin      := 00;
  FCol      := 00;
  FTam      := 00;
  FAlt      := 00;
  FPag      := 01;
  FIni      := True;
end;

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//-- Coluna = Coluna pcol + coluna inicial
procedure TORelatorio.Coluna( pCol : Integer );
begin
  case FTipo of
    tiGRAFICO : FCol := pCol * FTam;
    tiTXT : begin  Write(FTXT,Repl(' ', pCol-FCol)); FCol := pCol; end;
    tiHTM : FCol := pCol + FCoi;
    tiRTF : FCol := pCol + FCoi;
    tiDOC : FCol := pCol + FCoi;
    tiXLS : FCol := pCol + FCoi;
  end;

end;

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//-- Linha = Coluna pcol + coluna inicial
procedure TORelatorio.Linha( pLin : integer );
begin

  case FTipo of
    tiGRAFICO : Inc(FLin,pLin);
    tiTXT :
    begin
      Inc(FLin,pLin);
      Coluna(0);
      WriteLn(FTXT,'');
    end;
    tiHTM : FLin := FLin + pLin;
    tiRTF : FLin := FLin + pLin;
    tiDOC : FLin := FLin + pLin;
    tiXLS : FLin := FLin + pLin;
  end;

end;


//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//-- Pula linha
procedure TORelatorio.Pula_Linha;
begin
  Linha(1);
  Coluna(FCoi);
end;

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//-- Fonte do Texto
procedure TORelatorio.Fonte( pFonte : string );
var NmFonte : string;
begin


  case FTipo of
    tiGRAFICO :
    begin
      if pFonte = 'Negrito' then
//        QRPrinter.Canvas.Font.Style := [fsBold]
      else
//        QRPrinter.Canvas.Font.Style := [];
    end;
    tiTXT : NmFonte := '';
    tiHTM : NmFonte := '';
    tiRTF : NmFonte := '';
    tiDOC : NmFonte := '';
    tiXLS : NmFonte := '';
  end;

end;

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//-- Escreve no Relatório
procedure TORelatorio.Escreve( pConteudo : string );
begin

  case FTipo of
    tiGRAFICO :
    begin
//      QRPrinter.Canvas.TextOut( FCol, FLin*FAlt, pConteudo );
    end;
    tiTXT :
    begin
      Write(FTXT, pConteudo);
      FCol := FCol + Length( pConteudo );
    end;
    tiHTM :   Write(FHTM, pConteudo);
    tiRTF :   Write(FRTF, pConteudo);
    tiDOC :   Write(FDOC, pConteudo);
    tiXLS :   Write(FXLS, pConteudo);
  end;


end;

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//-- Cabeçalio do Relatório
procedure TORelatorio.Cabecalho( pNome, pTitulo, pCabe, pFiltro, pSub : string);
begin

  case FTipo of
    tiGRAFICO :
    begin
      if FIni then begin
//        QRPrinter.Title := pNome;
//        QRPrinter.Canvas.Font.Name := 'Courier New' ;
//        QRPrinter.Canvas.Font.Size := FTamFonte;
//        FTam := QRPrinter.Canvas.TextWidth('M');
//        FAlt := QRPrinter.Canvas.TextHeight('M');
        Risca(FCoi, FCof, FLin);
        Pula_Linha;
        Fonte( 'Negrito' );
        Coluna(FCoi);
        Escreve( DateToStr( Date ) ); //-- Data
//        Centra( FCoi, FLin, QRPrinter.Title, FCof ); //-- Título
        Coluna( FCoi + FCof - 8 );
        Escreve( TimeToStr( Time ) ); //-- Horário
        Pula_Linha;
        Centra( FCoi, FLin, pTitulo, FCof ); //-- Empresa
        Pula_Linha;
        Risca( FCoi, FCof, FLin);
        Pula_Linha;
        if pSub <> '' then begin
          Centra( FCoi, FLin, pSub, FCof ); //-- SubTítulo
          Pula_Linha;
        end;
        Centra( FCoi, FLin, pFiltro, FCof ); //-- Filtro
        Pula_Linha;
        Risca( FCoi, FCof, FLin);
        Pula_Linha;
        Escreve( pCabe ); //-- Cabeçalho;
        Pula_Linha;
        Risca( FCoi, FCof, FLin );
        Pula_Linha;
        Fonte( 'Normal' );
        FIni := False;
      end;
    end;
    tiTXT :
    begin

      if FIni then begin

        Risca( FCoi, FCof, FLin );
        Inc( FLin, FAlt div 2);
        Fonte( 'Negrito' );
        Escreve( DateToStr( Date ) ); //-- Data
        Centra( FCoi, FLin, pTitulo, FCof ); //-- Empresa
        Coluna(FCof-8);
        Escreve( TimeToStr( Time ) ); //-- Horário
        Pula_Linha;
//        Centra( FCoi, FLin, QRPrinter.Title, FCof ); //-- Título
        Pula_Linha;

        Risca( FCoi, FCof, FLin);

        Inc(FLin, FAlt div 2);
        if pSub <> '' then begin
          Escreve(pSub);
          Pula_Linha;
        end;
        Centra( FCoi, FLin, pFiltro, FCof ); //-- Filtro
        Pula_Linha;

        Risca( FCoi, FCof, FLin );

        Inc( FLin, FAlt div 2 );
        Escreve( pCabe ); //-- Cabeçalho;
        Pula_Linha;

        Risca( FCoi, FCof, FLin );

        Pula_Linha;
        Fonte( 'Normal' );
        FIni := False;
      end;
    end;
    tiHTM : Escreve( pCabe ); //-- Cabeçalho;
    tiRTF : Escreve( pCabe ); //-- Cabeçalho;
    tiDOC : Escreve( pCabe ); //-- Cabeçalho;
    tiXLS : Escreve( pCabe ); //-- Cabeçalho;
  end;



end;

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//-- Imprime o Fim da Página
procedure TORelatorio.Fim_de_Pagina(pTotais: string);
begin
  if FLin >= FRod then begin
    Escreve_SubRodape(FStSubRoda);  //-- A cada final de página
    FPag := FPag + 1;
    FLin := 0;
    FIni := True;
    if FTipo = tiGRAFICO  then
//      QRPrinter.NewPage;
  end;
end;

{= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

procedure TORelatorio.Fim_de_Query( pQuery : TQuery; pRodape : string );
begin
  if pQuery.Eof then begin
    Pula_Linha;
    Risca(FCoi, FCof, FLin);
    Fonte('Negrito');
    Pula_Linha;
    Escreve(pRodape);
    Fonte('Normal');
    Pula_Linha;
    Escreve_SubRodape(FStSubRoda);
    Pula_Linha;
    Risca(FCoi, FCof, FLin);
  end;
end;

{= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

procedure TORelatorio.Fim_de_Tabela( pTabela : TTable; pRodape : string );
begin
  //-- Fim de Arquivo
  if pTabela.Eof then begin
    Escreve_SubRodape(FStSubRoda);
    Pula_Linha;
    Risca(FCoi, FCof, FLin);
    Pula_Linha;
    Fonte('Negrito');
    Escreve(pRodape);
    Fonte('Normal');
    Pula_Linha;
    Risca(FCoi, FCof, FLin);
  end;
end;

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//-- Imprime um risco no relatório
procedure TORelatorio.Risca(pCoi, pCof, pLin : Integer);
begin
  case FTipo of
    tiGRAFICO :
    begin
//      QRPrinter.Canvas.MoveTo( (FTam*pCoi), pLin*FAlt );
//      QRPrinter.Canvas.Pen.Width := FTamRisco;
//      QRPrinter.Canvas.LineTo( (FTam*pCoi)+(FTam*pCof), pLin*FAlt );
    end;
    tiTXT :
    begin
      Coluna(pCoi);
      Escreve( Repl('-',pCof-pCoi) );
      Pula_Linha;
    end;
    tiHTM :
    begin
      Coluna(pCoi);
      Repl('-',pCof-pCoi);
    end;
    tiRTF : Coluna(pCoi);
    tiDOC : Coluna(pCoi);
    tiXLS : Coluna(pCoi);
  end;
end;


//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//-- Imprime um texto centralizado
Procedure TORelatorio.Centra(pCi,L:Integer; sTexto:String; pCf: integer );
var po : Integer;
begin
  po := ((pCf - pCi) div 2)-(length(stexto) div 2);

  case FTipo of
    tiGRAFICO :
    begin
      Coluna( (FCoi div 2) + PCi + po);
      Escreve( sTexto);
    end;
    tiTXT : Write(FTXT, Repl(' ',po) + sTexto);
    tiHTM : Write(FTXT, Repl(' ',po) + sTexto);
    tiRTF : Write(FTXT, Repl(' ',po) + sTexto);
    tiDOC : Write(FTXT, Repl(' ',po) + sTexto);
    tiXLS : Write(FTXT, Repl(' ',po) + sTexto);
  end;
end;

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//-- Escreve n zeros a esquerda
function TORelatorio.StrZero(N: longint; Tamanho: integer): string;
var
  Conteudo: string;
  Diferenca: longint;
begin
  Conteudo := IntToStr( N );
  Diferenca := Tamanho - Length( Conteudo );
  if Diferenca > 0 then begin
    Conteudo := Repl( '0', Diferenca ) + Conteudo;
  end;
  result := Conteudo;
end;


//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//--Replica um carecter
function TORelatorio.Repl(C: string; Tamanho: integer): string;
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


//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//-- Define a quantidade de Colunas
Procedure TORelatorio.SetaColuna(Valor : TColunas);
begin
  if Valor = co20  then FCof := 20;
  if Valor = co30  then FCof := 30;
  if Valor = co40  then FCof := 40;
  if Valor = co60  then FCof := 60;
  if Valor = co80  then FCof := 78;
  if Valor = co130 then FCof := 128;
  FColunas := Valor;
end;

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//--Executa o Relatório

function  TORelatorio.Executa : Bool;
begin

  Inicia_Variaveis;
  Inicia_Relatorio;
  if FQuery then begin

    Inicio_da_Query(FQue);
    while not FQue.Eof do begin
      Cabecalho(FStEmpresa, FstTitu, FStCabe, FStFilt, FStSub);
      Imprime_linha;
      Pula_Linha;
      FQue.Next;
      Fim_de_Pagina(FStSubRoda);  // termina a página
    end;
    Fim_de_Query(FQue,FStRodape);

  end
  else begin

   Inicio_da_Tabela(FTab);
    while not FTab.Eof do begin
      Cabecalho(FStEmpresa, FstTitu, FStCabe, FStFilt, FStSub);
      Imprime_linha;
      Pula_Linha;
      FTab.Next;
      Fim_de_Pagina(FStSubRoda);
    end;
    Fim_de_Tabela(FTab,FStRodape);


  end;
  Finaliza_Relatorio;

  if FVisu then
    Visualiza_Relatorio
  else
    Imprime_Relatorio;

  result := true;
end;




//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//--Imprime o Miolo do Relatório a linha a visualizar

Procedure TORelatorio.Imprime_linha;
begin
  if Assigned(FOnLinha) then
    FOnLinha(Self, FRetorno);
  Escreve(FRetorno);
end;

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

procedure TORelatorio.Escreve_SubRodape(pTotaIs: string); // Imprime o sub Rodapé
begin
    Coluna( 0 );
    Risca (FCoi, FCof, FLin);
    Pula_Linha;
    Fonte('Negrito');
    if FRodape then begin
      Escreve(pTotais);
      Pula_Linha;
    end;
    Centra( FCoi, FLin, StrZero(FPag,3), FCof );
    Fonte('Normal');
    Pula_Linha;
    Risca ( FCoi, FCof, FLin);
end;

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =


end.

