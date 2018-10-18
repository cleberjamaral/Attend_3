{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

                 O C E A N O   -    M A R    S O L U Ç Õ E S

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
                                I N I C I O
= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
Autor        : Equipe Oceano Tecnologia
Local        : Escritório, Florianópolis
Data         : 25/10/2000
Versão       :  1.0
Descrição    : Codifica e decodifica frases
Comentário   : Baseado nas funções Encrypt e Decrypt desenvolvidas pela Borland
               Exceção:
                 Basta que por exemplo na criação do formulário principal seja declarado:
                 Application.OnException := Inspetor1.WriteException;
                 bloco de tratamento de erro:
                 Para blocos do tipo (try..exception..end) o erro pode ser tratado
                 através da chamada: Inspetor1.WriteMessage('Mensagem de erro!');
= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

unit OExpira;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DsgnIntf, Registry;

type
  TOExpira = class(TComponent)
  private
    FMax         : Integer;
    FAlert       : Boolean;
    FAutoSave    : Boolean;
    FInteiro     : Integer;
    FOnUsedAll   : TNotifyEvent;
    FUsed        : String;
    FKey         : string;
    FSection     : string;
    FMessageText : string;
    FStopExecute : boolean;
    procedure SetMax(Value: integer);
    procedure SetAlert(Value: Boolean);
  protected
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ResetCounter;
    procedure LockCounter;
    function Load         : boolean;
    function Save         : boolean;
    property TimesUsed    : String       read FUsed;
  published
    property AlertMessage : Boolean      read FAlert       write SetAlert;
    property AutoSave     : boolean      read FAutoSave    write FAutoSave;
    property MessageText  : string       read FMessageText write FMessageText;
    property Max          : integer      read FMax         write SetMax;
    property OnUsedAll    : TNotifyEvent read FOnUsedAll   write FOnUsedAll;
    property SaveKey      : string       read FKey         write FKey;
    property SaveSection  : string       read FSection     write FSection;
    property StopExecute  : boolean      read FStopExecute write FStopExecute;
{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}
    function Encrypt(const Entrada: string; Inicio, Multip, Adicio: Integer): string;
    function Decrypt(const Entrada: string; Inicio, Multip, Adicio: Integer): string;
    function Codifica(Entrada: string): string;
    function Decodifica(Entrada: string): string;

  end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

const
  DEF_MAX          = 50;
  DEF_AUTOSAVE     = True;
  DEF_AUTOLOAD     = True;
  DEF_ALERTMESSAGE = True;
  DEF_MESSAGETEXT  = 'Sua licença expirou!';
  DEF_KEY          = '\SystemInfoControl\';
  DEF_SECTION      = 'SystemInfo';
  DEF_STOPEXECUTE  = True;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

procedure Register;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

implementation

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

constructor TOExpira.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMax         := DEF_MAX;
  FAlert       := DEF_ALERTMESSAGE;
  FMessageText := DEF_MESSAGETEXT;
  FKey         := DEF_KEY;
  FSection     := DEF_SECTION;
  FAutoSave    := DEF_AUTOSAVE;
  FStopExecute := DEF_STOPEXECUTE;
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

destructor TOExpira.Destroy;
begin
  if not(csDesigning in ComponentState) then if FAutoSave then Save;
  inherited Destroy;
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

procedure Register;
begin
  RegisterComponents('Oceano', [TOExpira]);
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

procedure TOExpira.SetMax(Value: Integer);
begin
  FMax := Value;
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

procedure TOExpira.SetAlert(Value: boolean);
begin
  FAlert := Value;
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

procedure TOExpira.Loaded;
begin
  inherited Loaded;
  if not(csDesigning in ComponentState) then if not(Load) then exit;
  if (FInteiro = -1) or (FInteiro = 0) then exit;
  if FInteiro > FMax then begin
    if FAlert then begin
      Beep;
      ShowMessage(FMessageText);
    end;
    if Assigned(FOnUsedAll) then FOnUsedAll(Self);
    if FStopExecute then Halt;
  end;
  FInteiro := FInteiro + 1;
  if FAutoSave then Save;
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

function TOExpira.Load: boolean;
var
  p: TRegIniFile;
begin
  Result:= False;
  if (FKey = '') or (FSection = '') then exit;
  p := TRegIniFile.Create(FKey);
  try
    //-- Carrega string criptografada
    FUsed    := P.ReadString(FSection, 'SystemInfo', '1');
    FInteiro := StrToInt(FUsed);
//    FInteiro := StrToInt(Decodifica(FUsed));
    Result   := True;
  finally
    P.Free;
  end;
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

function TOExpira.Save: boolean;
var
  p: TRegIniFile;
begin
  Result:= False;
  if (FKey = '') or (FSection = '') then exit;
  p:= TRegIniFile.Create(FKey);
  try
    p.EraseSection(FSection);
    FUsed    := IntToStr(FInteiro);
//    FUsed    := Codifica(IntToStr(FInteiro));
    p.writeString(FSection, 'SystemInfo', FUsed);
    Result   := True;
  finally
    p.Free;
  end;
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

procedure TOExpira.ResetCounter;
begin
  FInteiro := 1;
  if FAutoSave then Save;
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

procedure TOExpira.LockCounter;
begin
  FInteiro := -1;
  if FAutoSave then Save;
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

//-- Inserção de funcoes de criptografia p/ gravação do código
//-- Falta fazer a escrita no registro em string

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

{$R-} {$Q-}
function TOExpira.Encrypt(const Entrada: string; Inicio, Multip, Adicio: Integer): string;
var
  I : Byte;
begin
  Result := '';
  for I := 1 to Length(Entrada) do
  begin
    Result := Result + CHAR(Byte(Entrada[I]) xor (Inicio shr 8));
    Inicio := (Byte(Result[I]) + Inicio) * Multip + Adicio;
  end;
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

function TOExpira.Decrypt(const Entrada: string; Inicio, Multip, Adicio: Integer): string;
var
  I : Byte;
begin
  Result := '';
  for I := 1 to Length(Entrada) do
  begin
    Result := Result + CHAR(Byte(Entrada[I]) xor (Inicio shr 8));
    Inicio := (Byte(Entrada[I]) + Inicio) * Multip + Adicio;
  end;
end;
{$R+} {$Q+}

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

function TOExpira.Codifica(Entrada: string): string;
begin
  Result := Encrypt(Entrada,741258,852369,852147);
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

function TOExpira.Decodifica(Entrada: string): string;
begin
  Result := Decrypt(Entrada,741258,852369,852147);
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

end.
