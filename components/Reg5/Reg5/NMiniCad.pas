{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

Autor        : Cássio Lacerda
Nódulo       : NMiniCad.pas
Criação      : 03/06/99 23:31
Descrição    : Componente para Relacionamente o e Inclusão
Comentário   : Este componente é derivado do TRxDbLookupCombBox
               Possui um Botão estra que Abre o Form Referente a
               Inclusão da informação em si

 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

unit NMiniCad;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, ExtCtrls, StdCtrls,  
  Controls, Forms, Dialogs, RxLookup, Buttons, RXCtrls, Grids, DBGrids;
type


  TNMiniCad = class(TRxDBLookupCombo)
  private
    FBtnCad    : TRxSpeedButton;
    FBtnClick  : TNotifyEvent;
    FBtnHint   : string;
    FValor     : LongInt;
    FAutoCad   : Bool;
    FDescricao : string;
    Janela     : TForm;
    PBarra     : TPanel;
    PCentro    : TPanel;
    PDireita   : TPanel;
    PEsquerda  : TPanel;
    PTopo      : TPanel;
    PFechar    : TPanel;
    LAssinatura: TLabel;
    BtFechar   : TRxSpeedButton;
    DBG        : TDBGrid;

    procedure BtnClick(Sender: TObject);
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure AbreCadastro(Sender: TObject);
    procedure CriaBotao;
    function  GetValor    : LongInt;
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property BtnHint       : string       read FBtnHint   write FBtnHint;
    property Valor         : LongInt      read GetValor   write FValor;
    property OnButtonClick : TNotifyEvent read FBtnClick  write FBtnClick;
    property AutoCad       : bool         read FAutoCad   write FAutoCad;
    property Descricao     : string       read FDescricao write FDescricao;
  end;

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

implementation

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

procedure TNMiniCad.CriaBotao;
begin
  FBtnCad.Visible      := True;
  FBtnCad.Enabled      := True;
  FBtnCad.NumGlyphs    := 1;
  FBtnCad.Parent       := Self;
  FBtnCad.Font.Name    := 'Arial Black';
  FBtnCad.Font.Size    := 10;
  FBtnCad.Font.Height  := 10;  
  FBtnCad.Font.Color   := clBlack;
  FBtnCad.Font.Style   := [fsBold];
  FBtnCad.Caption      := '+';
  FBtnCad.OnClick      := BtnClick;
  FBtnCad.Flat         := False;
  FBtnCad.Hint         := 'Cadastro de ' + FDescricao;
  FBtnCad.ShowHint     := True;
end;

constructor TNMiniCad.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBtnCad              := TRxSpeedButton.Create(Self);
  CriaBotao;
  //  Set da janela
  Janela               := TForm.Create(Self);
  PBarra               := TPanel.Create(Janela);
  PFechar              := TPanel.Create(PBarra);
  BtFechar             := TRxSpeedButton.Create(PFechar);
  LAssinatura          := TLabel.Create(PBarra);
  PCentro              := TPanel.Create(Janela);
  PDireita             := TPanel.Create(Janela);
  PEsquerda            := TPanel.Create(Janela);
  PTopo                := TPanel.Create(Janela);
  DBG                  := TDBGrid.Create(PCentro);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

function TNMiniCad.GetValor: LongInt;
begin
  try
    Result := StrToInt ( Value );
  except
    Result := 1;
  end;
end;

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

procedure TNMiniCad.BtnClick(Sender: TObject);
begin
  if Sender = FBtnCad then begin
    if not FAutoCad then begin
      if Assigned(FBtnClick) then
        FBtnClick(Self)
    end
    else begin
      AbreCadastro(nil);
    end;
  end;
end;

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

procedure TNMiniCad.AbreCadastro(Sender: TObject);
begin
//  Janela.Position      := poScreenCenter;
  Janela.Left          := Left;
  Janela.Top           := Top;
  Janela.Width         := 286;
  Janela.Height        := 243;
  Janela.BorderStyle   := bsNone; //bsToolWindow;
  Janela.Color         := clWhite;
  Janela.Font.Color    := clWindowText;
  Janela.Font.Height   := -11;
  Janela.Font.Name     := 'MS Sans Serif';
  Janela.Font.Style    := [];
  Janela.PixelsPerInch := 96;
  Janela.Caption       := 'Cadastro de ' + FDescricao;

  PBarra.Visible       := True;
  PBarra.Enabled       := True;
  PBarra.Parent        := Janela;
  PBarra.Left          := 0;
  PBarra.Height        := 31;
  PBarra.Align         := alBottom;
  PBarra.BevelOuter    := bvNone;
  PBarra.Color         := clWhite;
  PBarra.TabOrder      := 0;

  PDireita.Visible      := True;
  PDireita.Enabled      := True;
  PDireita.Parent       := Janela;
  PDireita.Align        := alRight;
  PDireita.BevelOuter   := bvNone;
  PDireita.Color        := clWhite;
  PDireita.Width        := 5;

  PEsquerda.Visible     := True;
  PEsquerda.Enabled     := True;
  PEsquerda.Parent      := Janela;
  PEsquerda.Align       := alLeft;
  PEsquerda.BevelOuter  := bvNone;
  PEsquerda.Color       := clWhite;
  PEsquerda.Width       := 5;

  PTopo.Visible         := True;
  PTopo.Enabled         := True;
  PTopo.Parent          := Janela;
  PTopo.Align           := altop;
  PTopo.BevelOuter      := bvNone;
  PTopo.Color           := clWhite;
  PTopo.Height          := 5;

  PCentro.Visible      := True;
  PCentro.Enabled      := True;
  PCentro.Parent       := Janela;
  PCentro.Align        := alClient;
  PCentro.BevelOuter   := bvNone;
  PCentro.Color        := clWhite;
  PCentro.TabOrder     := 1;

  LAssinatura.Visible    := True;
  LAssinatura.Enabled    := True;
  LAssinatura.Parent     := PBarra;
  LAssinatura.Font.Color := clNavy;
  LAssinatura.Font.Size  := 7;
  LAssinatura.Font.Name  := 'Arial';
  LAssinatura.Font.Style := [];
  LAssinatura.Alignment  := taLeftJustify;
  LAssinatura.ParentFont := False;
  LAssinatura.Caption    := '© GlobalSky';
  LAssinatura.AutoSize   := True;
  LAssinatura.Left       := 2;
  LAssinatura.Top        := 17;
  LAssinatura.Height     := 12;

  PFechar.Visible    := True;
  PFechar.Enabled    := True;
  PFechar.Parent     := PBarra;
  PFechar.Width      := 114;
  PFechar.Align      := alRight;
  PFechar.BevelOuter := bvNone;
  PFechar.Color      := clWhite;
  PFechar.TabOrder   := 1;

  BtFechar.Visible     := True;
  BtFechar.Enabled     := True;
  BtFechar.Parent      := PFechar;
  BtFechar.Left        := 19;
  BtFechar.Top         := 4;
  BtFechar.Width       := 95;
  BtFechar.Height      := 23;
  BtFechar.DragCursor  := crDefault;
  BtFechar.Flat        := True;
  BtFechar.Spacing     := 0;
  BtFechar.Transparent := True;
  //BtFechar.OnClick = BtFecharClick;

  DBG.Visible          := True;
  DBG.Enabled          := True;
  DBG.Parent           := PCentro;
  DBG.Align            := alClient;
  DBG.Color            := clWhite;
  DBG.Ctl3D            := False;
  DBG.FixedColor       := 14784512;
  DBG.Font.Color       := clBlack;
  DBG.Font.Height      := -13;
  DBG.Font.Name        := 'MS Sans Serif';
  DBG.Font.Style       := [];
  DBG.Options          := [dgEditing, dgTitles, dgColumnResize, dgRowLines, dgTabs, dgCancelOnExit];
  DBG.ParentCtl3D      := False;
  DBG.ParentFont       := False;
  DBG.TabOrder         := 2;
  DBG.TitleFont.Color  := clWhite;
  DBG.TitleFont.Height := -13;
  DBG.TitleFont.Name   := 'MS Sans Serif';
  DBG.TitleFont.Style  := [fsBold];
  Janela.ShowModal;
end;

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

procedure TNMiniCad.WMSize(var Message: TWMSize);
begin
  inherited;
  if FBtnCad <> nil then
  begin
    FBtnCad.SetBounds       ( width-34, 1   ,     16, Height-3 );
    FBtnCad.Hint  := FBtnHint;
  end;
end;

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

destructor TNMiniCad.Destroy;
begin
  FBtnCad := nil;
  inherited Destroy;
end;

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

end.


