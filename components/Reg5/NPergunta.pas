{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

                 O C E A N O   -    M A R    S O L U Ç Õ E S

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
                                I N I C I O
= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
Criação      : 20/01/2001 11:06:17
Local        : Escritório, Florianópolis
Autores      : Cássio Lacerda
Descrição    : Componente Pergunta
Comentário   : O Componente TNPergunta gera uma janela de questionamento com os
               Botões sim e não, as respostas podem ser manipuladas de três maneiras:
               1 - Resultado da função pergunta ( true, false).
               ( tenho que terminar esta )
               2 - Pelos eventos (OnButtonSClik, OnButtonNClic ).
               3 - Pela propriedade Resposta.
               Sendo a resposta afirmativa ou negativa respectivamente.
= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
Atualização  : 13/08/2001 15:15
Autores      : Cleber J. Amaral
Comentário   : Refeito o recurso NPERGUNTA.RES quanto as suas imagens e cores
= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

unit NPergunta;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

interface

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

uses
  Windows, Classes, Forms, Buttons, StdCtrls, Graphics;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

type
  TNPergunta = class(TComponent)
  private
    Janela     : TForm;
    BtS        : TBitBtn;
    BtN        : TBitBtn;
    FBtSClick  : TNotifyEvent;
    FBtNClick  : TNotifyEvent;
    Mensagem   : TLabel;
    FResposta  : Bool;
    procedure BtSClick(Sender: TObject);
    procedure BtNClick(Sender: TObject);
  public
    function Pergunta(pMsg: String) : bool;
    constructor Create(aOwner: TComponent); override;
    destructor  Destroy; override;
  published
    property OnButtonSClick : TNotifyEvent read FBtSClick   write FBtSClick;
    property OnButtonNClick : TNotifyEvent read FBtNClick   write FBtNClick;
    property Resposta       : bool         read FResposta   write FResposta;
  end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

implementation {$R NPERGUNTA.RES}

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

var Msg: String;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

//  Criando
constructor TNPergunta.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  Janela    := TForm.Create(Self);
  Mensagem  := TLabel.Create(Janela);
  BtS       := TBitBtn.Create(Janela);
  BtN       := TBitBtn.Create(Janela);
  FResposta := False;
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

//  Escrevendo uma mensagem qualquer no arquivo texto
function TNPergunta.Pergunta(pMsg: String) : bool;
begin
  Msg := '';
  Msg := pMsg + '?';
  //  Set da janela
  Janela.Color       := clWhite;
  Janela.BorderStyle := bsToolWindow;
  Janela.Position    := poScreenCenter;
  Janela.Caption     := 'Pergunta';
  Janela.Height      := 125;
  //  set da mensagem
  Mensagem.Visible    := False;
  Mensagem.Enabled    := True;
  Mensagem.Parent     := Janela;
  Mensagem.Font.Name  := 'MS Sans Serif';
  Mensagem.Font.Size  := 10;
  Mensagem.Font.Color := clRed;
  Mensagem.Font.Style := [fsBold];
  Mensagem.Alignment  := taLeftJustify;
  Mensagem.color      := clwhite;
  Mensagem.Caption    := Msg;
  Mensagem.AutoSize   := True;
  Mensagem.Top        := 0;
  Mensagem.Left       := 0;
  Janela.Width        := Mensagem.Width + 20;
  if Janela.Width < 250 then begin // 250 é largura mínima
    Janela.Width       := 250;
    Mensagem.Top       := 25;
    Mensagem.Left      := (Janela.Width div 2) - (Mensagem.Width div 2);
    Mensagem.Visible   := True;
  end
  else begin
    Mensagem.Top       := 25;
    Mensagem.Left      := 10;
    Mensagem.Visible   := True;
  end;
  //  set do botão sim
  BtS.Visible      := True;
  BtS.Enabled      := True;
  BtS.NumGlyphs    := 1;
  BtS.Parent       := Janela;
  BtS.Default      := True;
  BtS.Font.Name    := 'MS Sans Serif';
  BtS.Font.Size    := 6;
  BtS.Caption      := '';
  BtS.Top          := 60;
  BtS.Left         := (Janela.Width div 2) - 93 - 2; // METADE DA JANELA - ELE - 2 DE ESPAÇO
  BtS.Height       := 25;
  BtS.Width        := 93;
  BtS.Glyph.Handle := LoadBitMap(HInstance, 'MSGBtS');
  //  set do botão não
  BtN.Visible      := True;
  BtN.Enabled      := True;
  BtN.NumGlyphs    := 1;
  BtN.Parent       := Janela;
  BtN.Default      := True;
  BtN.Font.Name    := 'MS Sans Serif';
  BtN.Font.Size    := 6;
  BtN.Caption      := '';
  BtN.Top          := 60;
  BtN.Left         := (Janela.Width div 2) + 2; // METADE DA JANELA + ESPAÇO
  BtN.Height       := 25;
  BtN.Width        := 93;
  BtN.Glyph.Handle := LoadBitMap(HInstance, 'MSGBtN');
  //  Bloco de ajuste da caixa de mensagens (78 caracteres 24 linhas)
  while Length(Msg) > 1 do begin
    if Pos(#13,Msg) > 1 then begin
      Janela.Height := Janela.Height + 16;
      BtS.Top      := BtS.Top + 16;
      BtN.Top      := BtN.Top + 16;
      Delete(Msg, 1, Pos(#13,Msg));
    end
    else
      Delete(Msg,1,Length(Msg));
  end;
  if Mensagem.Height > Screen.Height then begin
    Janela.Height   := Screen.Height;
    BtS.Top        := Janela.Height - 65;
    BtN.Top        := Janela.Height - 65;
    Mensagem.Height := Janela.Height;
    Mensagem.Height := BtS.top - 50;
  end;
  if Janela.Width  > Screen.Width then begin
    Janela.Width := Screen.Width;
    BtS.Left         := (Janela.Width div 2) - 93 - 2;
    BtN.Left         := (Janela.Width div 2) + 2;
  end;
  //  Mostra janela
  BtS.OnClick := BtSClick;
  BtN.OnClick := BtNClick;
  Janela.ShowModal;
  result := FResposta;
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

procedure TNPergunta.BtSClick(Sender: TObject);
begin
  if Sender = BtS then
    if Assigned(BtS) then begin
      FResposta := True;
      Janela.Close;
    end;
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

procedure TNPergunta.BtNClick(Sender: TObject);
begin
  if Sender = BtN then
    if Assigned(BtN) then begin
      FResposta := False;
      Janela.Close;
    end;
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

destructor TNPergunta.Destroy;
begin
  Janela.Destroy;
  inherited Destroy;
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

initialization

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

end.


