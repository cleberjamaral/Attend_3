{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

                 O C E A N O   -    M A R    S O L U Ç Õ E S

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
                                I N I C I O
= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
Criação      : 10/11/2000 15:00
Local        : Escritório, Florianópolis
Autores      : Cleber J. Amaral
Descrição    : Componente Pergunta
Comentário   : O Componente TNInspetor utiliza o componente NMensagem para gerar
               um aviso em uma janela de diálogo. Também permite registrar em um
               arquivo texto cujo nome é configurável sobre uma propriedade
               publicada.
= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
Atualização  :
Autores      :
Comentário   : 
= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

unit NInspetor;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

interface

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  NMensagem;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

type
  TNInspetor = class(TNMensagem)
  private
    { Private declarations }
    FTextFile  : string;
    FUserName  : string;
    FShowExcep : Boolean;
    FFormu     : string;
    FPrograma  : string;
    FCliente   : string;
    FModulo    : string;
    procedure SetTextFile(value: string);
    procedure SetUserName(value: string);
    procedure SetShowExcep(value: Boolean);
  protected
    { Protected declarations }
    constructor Create(aOwner: TComponent); override;
    destructor  Destroy; override;
  public
    { Public declarations }
    //-- Escrevendo a mensagem de exceção no arquivo texto
    procedure WriteException(Sender: TObject; E: Exception);
    //--  Escrevendo uma mensagem qualquer no arquivo texto
    procedure WriteMessage(pMsg: String);
  published
    { Published declarations }
    property ArqTexto      : string       read FTextFile  write SetTextFile;
    property Cliente       : string       read FCliente   write FCliente;
    property Excecao       : Boolean      read FShowExcep write SetShowExcep default True;
    property Formu         : string       read FFormu     write FFormu;
    property Modulo        : string       read FModulo    write FModulo;
    property Programa      : string       read FPrograma  write FPrograma;
    property Usuario       : string       read FUserName  write SetUserName;
  end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

var  Msg : String;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

implementation

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

procedure Register;
begin
  RegisterComponents('Nts', [TNInspetor]);
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

//-- Criando o componente
constructor TNInspetor.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  Excecao := true;
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

//-- Setando arquivo texto
procedure TNInspetor.SetTextFile(value: string);
begin
  if FTextFile <> value then FTextFile := value;
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

//-- Setando usuário
procedure TNInspetor.SetUserName(value: string);
begin
  if FUserName <> value then FUserName := value;
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

procedure TNInspetor.SetShowExcep(value: boolean);
begin
  if FShowExcep <> value then FShowExcep := value;
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

//-- Escrevendo a mensagem de exceção no arquivo texto
procedure TNInspetor.WriteException(Sender: TObject; E: Exception);
var TF: TextFile;
begin
  Msg := '';
  Msg := E.Message;
  AssignFile(TF,FTextFile);                        {Assossiando a variável com o arquivo texto}
  if FileExists( FTextFile ) then Append(tF)       {Iniciando a inclusão no arquivo}
  else Rewrite( TF );                              {Caso não exista é criado}
  WriteLn(TF,'Cliente  : ' + FCliente );           {Escreve o cliente proprietário}
  WriteLn(TF,'Usuário  : ' + FUserName);           {Escreve o nome do usuário}
  WriteLn(TF,'Data     : ' + DateTimeToStr(Now));  {Escreve horário}
  WriteLn(TF,'Erro     : ' + E.Message);           {Escreve a mensagem de erro}
  WriteLn(TF,'Programa : ' + FPrograma );          {Escreve o programa em execução}
  WriteLn(TF,'Módulo   : ' + FModulo );            {Escreve o módulo em execução}
  WriteLn(TF,'Form     : ' + FFormu );             {Escreve o form em execução}
  Writeln(Tf,'');                                  {Adiciona uma linha em branco}
  CloseFile(TF);                                   {Fecha arquivo}
//  if FShowExcep then application.ShowException(E); {Mostra a exceção}
  Alerta(Msg);
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

//--  Escrevendo uma mensagem qualquer no arquivo texto
procedure TNInspetor.WriteMessage(pMsg: String);
var TF: TextFile;
begin
  Msg := '';
  Msg := pMsg;
  AssignFile(TF,FTextFile);                        {Assossiando a variável com o arquivo texto}
  if FileExists( FTextFile ) then Append(tF)       {Iniciando a inclusão no arquivo}
  else Rewrite( TF );                              {Caso não exista é criado}
  WriteLn(TF,'Cliente  : ' + FCliente );           {Escreve o cliente proprietário}
  WriteLn(TF,'Usuário  : ' + FUserName);           {Escreve o nome do usuário}
  WriteLn(TF,'Data     : ' + DateTimeToStr(Now));  {Escreve horário}
  WriteLn(TF,'Mensagem : ' + pMsg);                {Escreve a mensagem de erro manual}
  WriteLn(TF,'Programa : ' + FPrograma );          {Escreve o programa em execução}
  WriteLn(TF,'Módulo   : ' + FModulo );            {Escreve o módulo em execução}
  WriteLn(TF,'Form     : ' + FFormu );             {Escreve o form em execução}
  Writeln(Tf,'');                                  {Adiciona uma linha em branco}
  CloseFile(TF);                                   {Fecha arquivo}
  Alerta(Msg);
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

destructor TNInspetor.Destroy;
begin
  inherited Destroy;
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

end.