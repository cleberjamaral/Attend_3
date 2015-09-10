object frmLicenca: TfrmLicenca
  Left = 299
  Top = 167
  Width = 501
  Height = 379
  Caption = 'Licença'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pcEnviar: TPageControl
    Left = 0
    Top = 145
    Width = 493
    Height = 126
    ActivePage = tsEnviar
    Align = alClient
    TabOrder = 0
    object tsEnviar: TTabSheet
      Caption = 'Enviar dados'
      object rgOpcao: TRadioGroup
        Left = 8
        Top = 8
        Width = 185
        Height = 57
        Caption = ' Opção '
        Items.Strings = (
          'Apenas enviar dados'
          'Prorrogar prazo DEMO')
        TabOrder = 0
      end
      object btEnviar: TBitBtn
        Left = 248
        Top = 24
        Width = 161
        Height = 25
        Caption = 'Enviar'
        TabOrder = 1
        OnClick = btEnviarClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333FFFFFFFFFFFFFFF000000000000
          000077777777777777770FFFFFFFFFFFFFF07F3333FFF33333370FFFF777FFFF
          FFF07F333777333333370FFFFFFFFFFFFFF07F3333FFFFFF33370FFFF777777F
          FFF07F33377777733FF70FFFFFFFFFFF99907F3FFF33333377770F777FFFFFFF
          9CA07F77733333337F370FFFFFFFFFFF9A907FFFFFFFFFFF7FF7000000000000
          0000777777777777777733333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
      end
    end
    object tsIntrucoes: TTabSheet
      Caption = 'Intruções'
      ImageIndex = 2
      object mmInstrucoes: TMemo
        Left = 0
        Top = 0
        Width = 485
        Height = 117
        Align = alClient
        Ctl3D = False
        ParentCtl3D = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object Mensagem: TTabSheet
      Caption = 'Mensagem'
      ImageIndex = 3
      object mmMensagem: TMemo
        Left = 0
        Top = 0
        Width = 485
        Height = 117
        Align = alClient
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object tsStatus: TTabSheet
      Caption = 'Status'
      ImageIndex = 1
      object mmStatus: TMemo
        Left = 0
        Top = 0
        Width = 485
        Height = 117
        Align = alClient
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 271
    Width = 493
    Height = 62
    Align = alBottom
    Caption = 'Panel1'
    TabOrder = 1
    object gbChave: TGroupBox
      Left = 1
      Top = 1
      Width = 491
      Height = 60
      Align = alClient
      Caption = ' Chave de Licença '
      TabOrder = 0
      object meLicenca: TMaskEdit
        Left = 64
        Top = 22
        Width = 145
        Height = 20
        CharCase = ecUpperCase
        Ctl3D = False
        EditMask = 'AAAA-AAAA-AAAA-AAAA;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 19
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        Text = '    -    -    -    '
      end
      object btRegistrar: TBitBtn
        Left = 232
        Top = 24
        Width = 121
        Height = 25
        Caption = 'Registrar'
        TabOrder = 1
        OnClick = btRegistrarClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500000000055
          555557777777775F55550FFFFFFFFF0555557F5555555F7FFF5F0FEEEEEE0000
          05007F555555777775770FFFFFF0BFBFB00E7F5F5557FFF557770F0EEEE000FB
          FB0E7F75FF57775555770FF00F0FBFBFBF0E7F57757FFFF555770FE0B00000FB
          FB0E7F575777775555770FFF0FBFBFBFBF0E7F5575FFFFFFF5770FEEE0000000
          FB0E7F555777777755770FFFFF0B00BFB0007F55557577FFF7770FEEEEE0B000
          05557F555557577775550FFFFFFF0B0555557FF5F5F57575F55500F0F0F0F0B0
          555577F7F7F7F7F75F5550707070700B055557F7F7F7F7757FF5507070707050
          9055575757575757775505050505055505557575757575557555}
        NumGlyphs = 2
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 493
    Height = 145
    Align = alTop
    Caption = 'Panel2'
    TabOrder = 2
    object gbProprietario: TGroupBox
      Left = 1
      Top = 1
      Width = 491
      Height = 143
      Align = alClient
      Caption = 'Proprietário'
      TabOrder = 0
      object labEmpresa: TLabel
        Left = 160
        Top = 16
        Width = 48
        Height = 13
        Caption = 'Empresa *'
      end
      object labNomeProprietario: TLabel
        Left = 8
        Top = 16
        Width = 35
        Height = 13
        Caption = 'Nome *'
      end
      object labDDD: TLabel
        Left = 160
        Top = 56
        Width = 31
        Height = 13
        Caption = 'DDD *'
      end
      object labTelefones: TLabel
        Left = 200
        Top = 56
        Width = 54
        Height = 13
        Caption = 'Telefones *'
      end
      object Label1: TLabel
        Left = 8
        Top = 96
        Width = 28
        Height = 13
        Caption = 'E-mail'
      end
      object labWebSite: TLabel
        Left = 192
        Top = 96
        Width = 44
        Height = 13
        Caption = 'Web-Site'
      end
      object Label2: TLabel
        Left = 304
        Top = 16
        Width = 28
        Height = 13
        Caption = 'CEP *'
      end
      object Label3: TLabel
        Left = 376
        Top = 16
        Width = 19
        Height = 13
        Caption = 'Nº *'
      end
      object edtEmpresa: TEdit
        Left = 160
        Top = 32
        Width = 137
        Height = 19
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 1
        OnKeyPress = edtNomeKeyPress
      end
      object edtNome: TEdit
        Left = 8
        Top = 32
        Width = 145
        Height = 19
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
        OnKeyPress = edtNomeKeyPress
      end
      object edtDDD: TEdit
        Left = 160
        Top = 72
        Width = 33
        Height = 19
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 4
        OnKeyPress = edtNomeKeyPress
      end
      object edtTelefone1: TEdit
        Left = 200
        Top = 72
        Width = 65
        Height = 19
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 5
        OnKeyPress = edtNomeKeyPress
      end
      object edtTelefone2: TEdit
        Left = 272
        Top = 72
        Width = 65
        Height = 19
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 6
        OnKeyPress = edtNomeKeyPress
      end
      object edtTelefone3: TEdit
        Left = 344
        Top = 72
        Width = 65
        Height = 19
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 7
        OnKeyPress = edtNomeKeyPress
      end
      object edtEMail: TEdit
        Left = 8
        Top = 112
        Width = 169
        Height = 19
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 8
        OnKeyPress = edtNomeKeyPress
      end
      object edtWebSite: TEdit
        Left = 192
        Top = 112
        Width = 217
        Height = 19
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 9
        Text = 'http://'
        OnKeyPress = edtNomeKeyPress
      end
      object meCEP: TMaskEdit
        Left = 304
        Top = 32
        Width = 65
        Height = 19
        Ctl3D = False
        EditMask = '00000-000;1;_'
        MaxLength = 9
        ParentCtl3D = False
        TabOrder = 2
        Text = '     -   '
        OnKeyPress = edtNomeKeyPress
      end
      object edtNumero: TEdit
        Left = 376
        Top = 32
        Width = 33
        Height = 19
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 3
        OnKeyPress = edtNomeKeyPress
      end
    end
  end
  object NMSMTP1: TNMSMTP
    Host = 'mail.otsoft.com.br'
    Port = 25
    ReportLevel = 0
    OnStatus = NMSMTP1Status
    EncodeType = uuMime
    ClearParams = False
    SubType = mtPlain
    Charset = 'ANSI_CHARSET'
    OnSuccess = NMSMTP1Success
    Left = 449
    Top = 96
  end
  object MainMenu1: TMainMenu
    Left = 212
    Top = 225
    object mitLicenca: TMenuItem
      Caption = 'Licença'
      object mitFechar: TMenuItem
        Caption = 'Fechar'
        ShortCut = 27
        OnClick = mitFecharClick
      end
    end
  end
end
