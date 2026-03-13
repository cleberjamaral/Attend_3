object frmMensagemLicenca: TfrmMensagemLicenca
  Left = 400
  Top = 307
  Width = 330
  Height = 148
  BorderIcons = [biSystemMenu]
  Caption = 'Mensagem Licença'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object memMensagem: TMemo
    Left = 16
    Top = 8
    Width = 289
    Height = 49
    Color = clBtnFace
    Ctl3D = False
    Lines.Strings = (
      'Seu aplicativo não está registrado, é ilegal utilizá-lo sem '
      'possuir uma licença. No menu "Ajuda" sub-menu "Licença" '
      'há instruções de como registrar sua cópia.')
    ParentCtl3D = False
    ReadOnly = True
    TabOrder = 0
  end
  object btnRegistrarDepois: TBitBtn
    Left = 80
    Top = 72
    Width = 161
    Height = 25
    Caption = 'Registrar Depois'
    Enabled = False
    TabOrder = 1
    OnClick = btnRegistrarDepoisClick
  end
  object timLicenca: TTimer
    OnTimer = timLicencaTimer
    Left = 16
    Top = 64
  end
end
