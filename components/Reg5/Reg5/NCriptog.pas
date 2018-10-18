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

unit NCriptog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TNCriptog = class(TComponent)

  function Encrypt(const Entrada: string; Inicio, Multip, Adicio: Integer): string;
  function Decrypt(const Entrada: string; Inicio, Multip, Adicio: Integer): string;
  private
    { Private declarations }
     FNumInic : Integer;
  FNumMult : Integer;
  FNumSoma : Integer;
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    function Codifica(Entrada: string): string;
    function Decodifica(Entrada: string): string;
  published
    { Published declarations }
    property NumeroInicio  : Integer read FNumInic  write FNumInic default 97531;
    property Multiplicador : Integer read FNumMult  write FNumMult default 86420;
    property Somador       : Integer read FNumSoma  write FNumSoma default 96385;
  end;

procedure Register;

implementation


{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

procedure Register;
begin
  RegisterComponents('Nts', [TNCriptog]);
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

constructor TNCriptog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  { valores padrão }
  FNumInic := 97531;
  FNumMult := 86420;
  FNumSoma := 96385;
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

{$R-} {$Q-}
function TNCriptog.Encrypt(const Entrada: string; Inicio, Multip, Adicio: Integer): string;
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

function TNCriptog.Decrypt(const Entrada: string; Inicio, Multip, Adicio: Integer): string;
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

function TNCriptog.Codifica(Entrada: string): string;
begin
  Result := Encrypt(Entrada,FNumInic,FNumMult,FNumSoma);
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

function TNCriptog.Decodifica(Entrada: string): string;
begin
  Result := Decrypt(Entrada,FNumInic,FNumMult,FNumSoma);
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

end.
