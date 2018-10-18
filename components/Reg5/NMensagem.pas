{------------------------------------------------------------------------------------------------

              O C E A N O   -    M A R    D E    S O L U � � E S

-------------------------------------------------------------------------------------------------
                                I N I C I O
-------------------------------------------------------------------------------------------------
Cria��o      : 10/11/2001 15:00
Local        : Escrit�rio, Florian�polis
Autor(es)    : Cleber J. Amaral e C�ssio Lacerda
Descri��o    : Componente Pergunta
Coment�rio   : O Componente TNMensagem gera uma janela de aviso com um bot�o de
               OK p/ certificar o alerta ao usu�rio
-------------------------------------------------------------------------------------------------
Atualiza��o  : 13/08/2001 15:00
Autor(es)    : Cleber J. Amaral
Coment�rio   : Refeito o recurso NMENSAGEM.RES quanto as suas imagens e cores
-------------------------------------------------------------------------------------------------}

unit NMensagem;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

interface

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

uses Windows, Classes, Forms, Buttons, StdCtrls, Graphics;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

type
  TNMensagem = class(TComponent)
  private
    { Private declarations }
    Janela     : TForm;
    BtOK       : TBitBtn;
//    FBtClick   : TNotifyEvent;
    Mensagem   : TLabel;
    procedure BtClick(Sender: TObject);
//    property OnButtonClick : TNotifyEvent read FBtClick   write FBtClick;
  protected
    { Protected declarations }
    constructor Create(aOwner: TComponent); override;
    destructor  Destroy; override;
  public
    { Public declarations }
    //-- Print de uma mensagem na tela
    procedure Alerta(pMsg: String);
  published
    { Published declarations }
  end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

{$R NMENSAGEM.RES}

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

implementation

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

var Msg: String;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

//-- Criando o componente
constructor TNMensagem.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  Janela    := TForm.Create(Self);
  Mensagem  := TLabel.Create(Janela);
  BtOK      := TBitBtn.Create(Janela);
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

//-- Print de uma mensagem na tela
procedure TNMensagem.Alerta(pMsg: String);
begin
  Msg := '';
  Msg := pMsg;
  //  Set da janela
  Janela.Color       := clWhite;
  Janela.BorderStyle := bsToolWindow;
  Janela.Position    := poScreenCenter;
  Janela.Caption     := 'Mensagem';
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
  if Janela.Width < 250 then begin // 250 � largura m�nima
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
  //  set do bot�o
  BtOK.Visible      := True;
  BtOK.Enabled      := True;
  BtOK.NumGlyphs    := 1;
  BtOK.Parent       := Janela;
  BtOK.Default      := True;
  BtOK.Font.Name    := 'MS Sans Serif';
  BtOK.Font.Size    := 6;
  BtOK.Caption      := '';
  BtOK.Top          := 60;
  BtOK.Left         := (Janela.Width div 2) - 46;
  BtOK.Height       := 25;
  BtOK.Width        := 93;
  BtOK.Glyph.Handle := LoadBitMap(HInstance, 'MSGBTOK');
  //  Bloco de ajuste da caixa de mensagens (78 caracteres 24 linhas)
  while Length(Msg) > 1 do begin
    if Pos(#13,Msg) > 1 then begin
      Janela.Height := Janela.Height + 16;
      BtOK.Top      := BtOK.Top + 16;
      Delete(Msg, 1, Pos(#13,Msg));
    end
    else
      Delete(Msg,1,Length(Msg));
  end;
  if Mensagem.Height > Screen.Height then begin
    Janela.Height   := Screen.Height;
    BtOK.Top        := Janela.Height - 65;
    Mensagem.Height := Janela.Height;
    Mensagem.Height := BtOK.top - 50;
  end;
  if Janela.Width  > Screen.Width then begin
    Janela.Width := Screen.Width;
    BtOK.Left    := (Janela.Width div 2) - 46;
  end;
  //  Mostra janela
  BtOK.OnClick := BtClick;
  Janela.ShowModal;
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

//-- Ao clicar no bot�o
procedure TNMensagem.BtClick(Sender: TObject);
begin
  if Sender = BtOK then if Assigned(BtOK) then Janela.Close;
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

destructor TNMensagem.Destroy;
begin
  Janela.Destroy;
  inherited Destroy;
end;

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

initialization

{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

end.

