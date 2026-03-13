object frmCliente: TfrmCliente
  Left = 1093
  Top = 257
  Width = 562
  Height = 386
  Caption = 'Cliente'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDefault
  ShowHint = True
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgcFile: TPageControl
    Left = 0
    Top = 41
    Width = 546
    Height = 287
    ActivePage = tshEdit
    Align = alClient
    TabOrder = 1
    object tshConsult: TTabSheet
      Caption = '&Consulta'
      object dbgProduto: TDBGrid
        Left = 0
        Top = 0
        Width = 492
        Height = 239
        Hint = 
          'Consulta de Registros, 2 cliques na grade abre o cadastro no reg' +
          'istro selecionado'
        Align = alClient
        DataSource = dsqDefault
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = dbgProdutoDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'FONE1'
            Title.Caption = 'Fone1'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME'
            Title.Caption = 'Nome'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOMEGRUPOCLIENTE'
            Title.Caption = 'Grupo de Cliente'
            Width = 90
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DDD'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FONE2'
            Title.Caption = 'Fone2'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FONE3'
            Title.Caption = 'Fone3'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'LOGRADOURO'
            Title.Caption = 'Logradouro'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NUMERO'
            Title.Caption = 'Número'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COMPLEMENTO'
            Title.Caption = 'Complemento'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BAIRRO'
            Title.Caption = 'Bairro'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CIDADE'
            Title.Caption = 'Cidade'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CEP'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'REFERENCIA'
            Title.Caption = 'Ponto de referência'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'OBS1'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'OBS2'
            Width = 200
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'DATANASCIMENTO'
            Title.Alignment = taCenter
            Title.Caption = 'Nascimento'
            Width = 80
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'DATACADASTRO'
            Title.Alignment = taCenter
            Title.Caption = 'Cadastro'
            Width = 80
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'DATAULTIMOPEDIDO'
            Title.Alignment = taCenter
            Title.Caption = 'Ultimo Pedido'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMAIL'
            Title.Caption = 'e-mail'
            Width = 200
            Visible = True
          end>
      end
    end
    object tshEdit: TTabSheet
      Caption = '&Arquivo'
      ImageIndex = 1
      object scbEdit: TScrollBox
        Left = 0
        Top = 0
        Width = 538
        Height = 259
        Align = alClient
        TabOrder = 0
        object pgcDados: TPageControl
          Left = 0
          Top = 41
          Width = 534
          Height = 214
          ActivePage = tshPrincipal
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object tshPrincipal: TTabSheet
            Hint = 'Dados Principais do Cliente'
            Caption = '&Principal'
            object labDDD: TLabel
              Left = 502
              Top = 0
              Width = 24
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'DDD'
            end
            object labFone2: TLabel
              Left = 494
              Top = 40
              Width = 36
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Fone2'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object labFone3: TLabel
              Left = 494
              Top = 80
              Width = 36
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Fone3'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object labNome: TLabel
              Left = 0
              Top = 0
              Width = 33
              Height = 13
              Caption = 'Nome'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object labLogradouro: TLabel
              Left = 0
              Top = 40
              Width = 65
              Height = 13
              Caption = 'Logradouro'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object labNumero: TLabel
              Left = 168
              Top = 40
              Width = 17
              Height = 13
              Caption = 'No'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object labCidade: TLabel
              Left = 96
              Top = 80
              Width = 40
              Height = 13
              Caption = 'Cidade'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object labReferencia: TLabel
              Left = 192
              Top = 80
              Width = 118
              Height = 13
              Caption = 'Ponto de Referência'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object labBairro: TLabel
              Left = 0
              Top = 80
              Width = 34
              Height = 13
              Caption = 'Bairro'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object labComplemento: TLabel
              Left = 224
              Top = 40
              Width = 76
              Height = 13
              Caption = 'Complemento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object labPontuacao: TLabel
              Left = 0
              Top = 120
              Width = 52
              Height = 13
              Caption = 'Pontuação'
            end
            object edtDDD: TEdit
              Left = 502
              Top = 16
              Width = 25
              Height = 21
              Anchors = [akTop, akRight]
              Color = 15066597
              TabOrder = 7
              OnKeyPress = edtFone1KeyPress
            end
            object edtFone2: TEdit
              Left = 440
              Top = 56
              Width = 87
              Height = 21
              Anchors = [akTop, akRight]
              Color = 15066597
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 8
              OnKeyPress = edtFone1KeyPress
            end
            object edtFone3: TEdit
              Left = 440
              Top = 96
              Width = 86
              Height = 21
              Anchors = [akTop, akRight]
              Color = 15066597
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 9
              OnKeyPress = edtFone1KeyPress
            end
            object edtNome: TEdit
              Left = 0
              Top = 16
              Width = 431
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              OnKeyPress = edtFone1KeyPress
            end
            object edtLogradouro: TEdit
              Left = 0
              Top = 56
              Width = 161
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              OnKeyPress = edtFone1KeyPress
            end
            object edtNumero: TEdit
              Left = 168
              Top = 56
              Width = 49
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
              OnKeyPress = edtFone1KeyPress
            end
            object edtCidade: TEdit
              Left = 96
              Top = 96
              Width = 89
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 5
              OnKeyPress = edtFone1KeyPress
            end
            object edtReferencia: TEdit
              Left = 192
              Top = 96
              Width = 239
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 6
              OnKeyPress = edtReferenciaKeyPress
            end
            object edtBairro: TEdit
              Left = 0
              Top = 96
              Width = 89
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 4
              OnKeyPress = edtFone1KeyPress
            end
            object edtComplemento: TEdit
              Left = 224
              Top = 56
              Width = 207
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 3
              OnKeyPress = edtFone1KeyPress
            end
            object edtPontuacao: TEdit
              Left = 0
              Top = 136
              Width = 111
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 10
              OnKeyPress = edtReferenciaKeyPress
            end
          end
          object tshAdicional: TTabSheet
            Hint = 'Dados Adicionais do Cliente'
            Caption = 'A&dicional'
            ImageIndex = 1
            object labCEP: TLabel
              Left = 0
              Top = 0
              Width = 21
              Height = 13
              Caption = 'CEP'
            end
            object labDataNascimento: TLabel
              Left = 435
              Top = 0
              Width = 97
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Data de Nascimento'
            end
            object Label1: TLabel
              Left = 449
              Top = 40
              Width = 83
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Data do Cadastro'
            end
            object labDataUltimoPedido: TLabel
              Left = 441
              Top = 80
              Width = 91
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Data Ultimo Pedido'
            end
            object labObs2: TLabel
              Left = 0
              Top = 80
              Width = 168
              Height = 13
              Caption = 'Observações (não serão impressas)'
            end
            object labObs1: TLabel
              Left = 0
              Top = 40
              Width = 158
              Height = 13
              Caption = 'Observações (Preferências)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object labEMail: TLabel
              Left = 96
              Top = 0
              Width = 27
              Height = 13
              Caption = 'e-mail'
            end
            object edtCEP: TEdit
              Left = 0
              Top = 16
              Width = 89
              Height = 21
              Color = 15066597
              TabOrder = 0
              OnKeyPress = edtFone1KeyPress
            end
            object dtpDataNascimento: TDateTimePicker
              Left = 435
              Top = 16
              Width = 97
              Height = 21
              Anchors = [akTop, akRight]
              CalAlignment = dtaLeft
              Date = 38738.6224460995
              Time = 38738.6224460995
              Color = 15066597
              DateFormat = dfShort
              DateMode = dmComboBox
              Kind = dtkDate
              ParseInput = False
              TabOrder = 4
              OnKeyPress = edtFone1KeyPress
            end
            object dtpDataCadastro: TDateTimePicker
              Left = 435
              Top = 56
              Width = 97
              Height = 21
              Anchors = [akTop, akRight]
              CalAlignment = dtaLeft
              Date = 38738.6224460995
              Time = 38738.6224460995
              Color = 15066597
              DateFormat = dfShort
              DateMode = dmComboBox
              Kind = dtkDate
              ParseInput = False
              TabOrder = 5
              OnKeyPress = edtFone1KeyPress
            end
            object dtpDataUltimoPedido: TDateTimePicker
              Left = 435
              Top = 96
              Width = 97
              Height = 21
              Anchors = [akTop, akRight]
              CalAlignment = dtaLeft
              Date = 38738.6224460995
              Time = 38738.6224460995
              Color = 15066597
              DateFormat = dfShort
              DateMode = dmComboBox
              Kind = dtkDate
              ParseInput = False
              TabOrder = 6
              OnKeyPress = edtFone1KeyPress
            end
            object edtObs2: TEdit
              Left = 0
              Top = 96
              Width = 412
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              Color = 15066597
              TabOrder = 3
              OnKeyPress = edtFone1KeyPress
            end
            object edtObs1: TEdit
              Left = 0
              Top = 56
              Width = 412
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
              OnKeyPress = edtFone1KeyPress
            end
            object edtEMail: TEdit
              Left = 96
              Top = 16
              Width = 316
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              Color = 15066597
              TabOrder = 1
              OnKeyPress = edtFone1KeyPress
            end
          end
        end
        object panEditTop: TPanel
          Left = 0
          Top = 0
          Width = 534
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object labClienteGrupo: TLabel
            Left = 387
            Top = 0
            Width = 84
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Grupo de Clientes'
          end
          object labFone1: TLabel
            Left = 8
            Top = 0
            Width = 36
            Height = 13
            Caption = 'Fone1'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lcbIdClienteGrupo: TDBLookupComboBox
            Left = 387
            Top = 16
            Width = 121
            Height = 21
            Hint = 
              'Grupo de Cliente, para trabalhar com tabelas de preços diferenci' +
              'adas'
            Anchors = [akTop, akRight]
            KeyField = 'CONTADOR'
            ListField = 'NOME'
            ListSource = dtsClienteGrupo
            TabOrder = 2
            OnKeyPress = edtFone1KeyPress
          end
          object edtFone1: TEdit
            Left = 8
            Top = 16
            Width = 97
            Height = 21
            Hint = 'Código Principal'
            Color = 8454143
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            OnKeyPress = edtFone1KeyPress
          end
          object btnEditClienteGrupo: TBitBtn
            Left = 515
            Top = 16
            Width = 25
            Height = 25
            Hint = 'Alterar Grupo de Clientes'
            Anchors = [akTop, akRight]
            TabOrder = 0
            OnClick = btnEditClienteGrupoClick
            Glyph.Data = {
              CE070000424DCE07000000000000360000002800000024000000120000000100
              18000000000098070000C40E0000C40E0000000000000000000080FF0080FF00
              80FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF
              0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080
              FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF00
              80FF0080FF0000000000000080FF0080FF0080FF0080FF0080FF0080FF0080FF
              0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080
              FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF00
              80FF0080FF0080FF0080FF0080FF0080FF0000000000000080FF0080FF0080FF
              0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080
              FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF00
              80FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF000000
              0000000080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080
              FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF00
              80FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF
              0080FF0080FF0080FF0000000000000000000080FF0080FF0080FF0080FF0000
              000000000000000080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF00
              80FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF
              0080FF0080FF0080FF0080FF0080FF0080FF0080FF0000000000000080FF0080
              FF0000000000000000000080FF0080FF0080FF0080FF0080FF0080FF0080FF00
              80FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF
              0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080
              FF0000000000000000000000000000000000000000000080FF0080FF0080FF00
              80FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF
              0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080
              FF0080FF0080FF0080FF0080FF0000000000000000000000000080FF0080FF00
              80FF0000000000000080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF
              0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080
              FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF00000000000000
              80FF0080FF0080FF0080FF0080FF0000808040808000000000000080FF0080FF
              0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080
              FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF00
              80FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF004080
              8000808000FFFF408080C0C0C000808000808000000080FF0080FF0080FF0080
              FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF00
              80FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF
              0080FF0080FF0080FF0080FF0040808000808000FFFFFFFFFFC0C0C000808000
              808000000000000080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF00
              80FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF
              0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0040808000
              FFFF00FFFFFFFFFFC0C0C000808000808080000080FF0080FF0080FF0080FF00
              80FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF
              0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080
              FF0080FF0080FF0080FF0000808040808000FFFF00FFFF008080008080000000
              80FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF
              0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080
              FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF00408080008080
              FFFFFF00000000000000000080FF0080FF0080FF0080FF0080FF0080FF0080FF
              0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080
              FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF00
              80FF0080FF0080FF0040808000808000000000000000000080FF0080FF0080FF
              0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080
              FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF00
              80FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF00000000FFFFFF0000
              0000000080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080
              FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF00
              80FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF
              0080FF0080FF00000000FFFFFF80000080FF0080FF0080FF0080FF0080FF0080
              FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF00
              80FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF
              0080FF0080FF0080FF0080FF0080FF0080FF00000000000000FF000080FF0080
              FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF0080FF00
              80FF0080FF0080FF0080FF0080FF0080FF00}
            NumGlyphs = 2
          end
        end
      end
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 546
    Height = 41
    ButtonHeight = 34
    ButtonWidth = 31
    Caption = 'ToolBar1'
    Images = ImageList1
    TabOrder = 0
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Width = 8
      Caption = 'ToolButton1'
      Style = tbsSeparator
    end
    object btnNew: TToolButton
      Left = 8
      Top = 2
      Hint = 'Novo Registro'
      Caption = 'btnNew'
      ImageIndex = 0
      OnClick = mitNewClick
    end
    object ToolButton3: TToolButton
      Left = 39
      Top = 2
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 7
      Style = tbsSeparator
    end
    object btnFirst: TToolButton
      Left = 47
      Top = 2
      Hint = 'Primeiro Registro'
      Caption = 'btnFirst'
      ImageIndex = 1
      OnClick = mitFirstClick
    end
    object btnPrior: TToolButton
      Left = 78
      Top = 2
      Hint = 'Registro Anterior'
      Caption = 'btnPrior'
      ImageIndex = 2
      OnClick = mitFirstClick
    end
    object btnNext: TToolButton
      Left = 109
      Top = 2
      Hint = 'Próximo Registro'
      Caption = 'btnNext'
      ImageIndex = 3
      OnClick = mitFirstClick
    end
    object btnLast: TToolButton
      Left = 140
      Top = 2
      Hint = 'Último Registro'
      Caption = 'btnLast'
      ImageIndex = 4
      OnClick = mitFirstClick
    end
    object ToolButton4: TToolButton
      Left = 171
      Top = 2
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 7
      Style = tbsSeparator
    end
    object btnSave: TToolButton
      Left = 179
      Top = 2
      Hint = 'Salvar Registro'
      Caption = 'btnSave'
      ImageIndex = 5
      OnClick = mitSaveClick
    end
    object tbtDelete: TToolButton
      Left = 210
      Top = 2
      Hint = 'Excluir Registro'
      Caption = 'tbtDelete'
      ImageIndex = 6
      OnClick = mitDeleteClick
    end
    object ToolButton2: TToolButton
      Left = 241
      Top = 2
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 18
      Style = tbsSeparator
    end
    object btnRefresh: TToolButton
      Left = 249
      Top = 2
      Hint = 'Atualizar Consulta'
      Caption = 'btnRefresh'
      ImageIndex = 7
      OnClick = mitRefreshClick
    end
    object tbtBusca: TToolButton
      Left = 280
      Top = 2
      Hint = 'Buscar por Código, Nome ou Endereço'
      Caption = 'tbtBusca'
      DropdownMenu = popBusca
      ImageIndex = 10
      Style = tbsDropDown
    end
    object tbtCancelarFiltros: TToolButton
      Left = 326
      Top = 2
      Hint = 'Limpa os filtros de busca mostrando todos os registros'
      Caption = 'tbtCancelarFiltros'
      ImageIndex = 11
      OnClick = buscarCliente
    end
    object tbtPedido: TToolButton
      Left = 357
      Top = 2
      Hint = 'Fazer pedido para o cliente selecionado'
      Caption = 'tbtPedido'
      ImageIndex = 13
      OnClick = tbtPedidoClick
    end
    object ToolButton6: TToolButton
      Left = 388
      Top = 2
      Width = 8
      Caption = 'ToolButton6'
      ImageIndex = 8
      Style = tbsSeparator
    end
    object tbtImprimir: TToolButton
      Left = 396
      Top = 2
      Hint = 'Imprimir Registro Corrente'
      Caption = 'tbtImprimir'
      ImageIndex = 8
      OnClick = tbtImprimirClick
    end
    object tbtImprimirTodos: TToolButton
      Left = 427
      Top = 2
      Hint = 'Imprimir Lista de Registros'
      Caption = 'tbtImprimirTodos'
      ImageIndex = 9
      OnClick = tbtImprimirTodosClick
    end
    object ToolButton8: TToolButton
      Left = 458
      Top = 2
      Width = 8
      Caption = 'ToolButton8'
      ImageIndex = 9
      Style = tbsSeparator
    end
    object tbtFechar: TToolButton
      Left = 466
      Top = 2
      Hint = 'Fechar janela'
      Caption = 'tbtFechar'
      ImageIndex = 12
      OnClick = tbtFecharClick
    end
  end
  object ImageList1: TImageList
    Height = 28
    Width = 24
    Left = 65528
    Top = 104
    Bitmap = {
      494C01010E001300040018001C00FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000600000008C0000000100180000000000809D
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      007F787FC0C0C0C0C0C0808080C0C0C0808080C0C0C0C0C0C0808080C0C0C080
      8080C0C0C0C0C0C0808080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008000000000000000
      0000000000000080FFFF80FFFF00000000325000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000D4F0FF0000008000000000
      0000000000000080FFFF80FFFF80FFFF00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FFBFB8BFBFB8BFBFB8BF0000FF808080C0C0C0C0
      C0C00000FF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF0000000000D4F0FF0000008000
      0000000000000000000080FFFF80FFFF80FFFF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF7F787F0000FFBFB8BF0000FF8080800000FFC0
      C0C00000FF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FF0000000000F0FBFF0000000000000000
      00B1C7FFB1C7FF8EABFF00000080FFFF80FFFF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF7F787F0000FFBFB8BF0000FF8080800000FFC0
      C0C00000FF000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF0000000000D4F0FFF0FBFF000000B1C7FFB1C7
      FFB1C7FFB1C7FF8EABFF8EABFF00000080FFFF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF7F787F0000FFBFB8BF0000FF8080800000FFC0
      C0C00000FF000000000000000000000000000000000000000000000000000000
      000000000000000000FF0000000000D4F0FF000000000000B1C7FFB1C7FF0000
      00000000B1C7FF8EABFF8EABFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007F787F0000FF0000FF0000FF0000FF0000FF0000FF00
      00FF0000FF000000000000000000000000000000000000000000000000000000
      000000000000000000000000D4F0FF000000F0FBFF000000B1C7FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FF0000FF0000FF0000FF0000FF0000FF00
      00FF0000FF000000000000000000000000000000000000000000000000000000
      000000000000000000D4F0FF000000F0FBFFF0FBFF0000000000000000000080
      0000800000800000800000800000800000800000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007F787F0000FF0000FF0000FF0000FF0000FF0000FF00
      00FF0000FF000000000000000000000000000000000000000000000000000000
      000000000000000000000000F0FBFFF0FBFFF0FBFF000000000000B1C7FFB1C7
      FFB1C7FFB1C7FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF808080C0C0C0C0C0C00000FF808080C0C0C0C0
      C0C00000FF000000000000000000000000000000000000000000000000000000
      000000000000000000F0FBFFF0FBFF000000F0FBFFF0FBFF0000000000000000
      00000000000000000000D4F0FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF8080800000FFC0C0C00000FF8080800000FFC0
      C0C00000FF000000000000000000000000000000000000000000000000000000
      000000000000000000FFFFFFF0FBFFF0FBFF000000F0FBFFF0FBFFF0FBFFF0FB
      FFF0FBFFF0FBFFF0FBFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF8080800000FFC0C0C00000FF8080800000FFC0
      C0C00000FF000000000000000000000000000000000000000000000000000000
      000000000000000000000000FFFFFFF0FBFFF0FBFF000000F0FBFFFFFFFFF0FB
      FFF0FBFFF0FBFF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF8080800000FFC0C0C00000FF8080800000FFC0
      C0C00000FF000000000000000000000000000000000000000000000000000000
      000000000000000000FFFFFF000000FFFFFFF0FBFFFFFFFF000000F0FBFFF0FB
      FFF0FBFF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF8080800000FFC0C0C00000FF8080800000FFC0
      C0C00000FF000000000000000000000000000000000000000000000000000000
      000000000000000000FFFFFFF0FBFF000000FFFFFFFFFFFFF0FBFFF0FBFFF0FB
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF00
      00FF0000FF000000000000000000000000000000000000000000000000000000
      000000000000000000FFFFFFF0FBFFF0FBFF000000FFFFFFF0FBFFF0FBFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FFFFFFF0FBFFFFFFFFF0FBFFF0FBFF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFFFFFFFFFFF0FBFF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000CFC8CFA098
      9FA0989F00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000FF8000FFFF00800000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000CFC8CFCFC8CFBFB8BFA098
      9F90909090909080808000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000FFFF00FF8000800000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000D0D0D0CFC8CFCFC8CFBFB8BFBFB8BFA098
      9F90909090909090909080808080808000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000007F7F7F7F
      7F7F000000000000800000FF8000FFFF00800000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000CFC8CFA0989FA0989F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000808080CFC8CFCFC8CFBFB8BFBFB8BFF0F0F09090
      90A0989F90909080808080808070707080808000000000000000000000000000
      000000000000000000000000000000000000000000000000FF0000FF0000FF00
      00FF0000FF0000FF0000FF000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00007F00
      007F7F7F7F000000800000FFFF00FF80008000000000FF7F7F7F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CFC8CFCFC8CFBFB8BFA0989F90909090909080808000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000808080BFB8BFBFB8BFF0F0F0F0F0F0CFC8CFCFC8
      CFCFC8CF90909090909080808080808070707000000000000000000000000000
      000000000000000000000000000000000000000000FF0000FF0000FF0000FF00
      00FF0000FF0000FF0000FF000000000080000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00007F00
      007F00007F7F7F7F800000FF8000FFFF000000FF00007F00007F7F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000D0D0D0CFC8CFCFC8CFBFB8BFBFB8BFA0989F90909090909090909080
      8080808080000000000000000000000000000000000000000000000000000000
      000000000000000000000000808080F0F0F0F0F0F0D0D0D0D0D0D00000FF2F00
      CFCFC8CFCFC8CFBFB8BF80808080808080808000000000000000000000000000
      0000000000000000000000000000000000000000008000008000008000008000
      0080000080000080000080000000000080000080000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00007F00
      007F00007F00007F7F7F7FFFFF000000FF00007F00007F00007F00007F7F7F7F
      0000000000000000000000000000000000000000000000000000000000000000
      00808080CFC8CFCFC8CFBFB8BFBFB8BFF0F0F0909090A0989F90909080808080
      8080707070808080000000000000000000000000000000000000000000000000
      000000000000000000000000808080DFD8DFDFD8DF00F800009060CFC8CFCFC8
      CFD0D0D0707070808080000000BFB8BF70707000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000080000080000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      007F00007F00007F00007F7F7F7F00007F00007F00007F00007F00007F7F7F7F
      0000000000000000000000000000000000000000000000000000000000000000
      00808080BFB8BFBFB8BFF0F0F0F0F0F0CFC8CFCFC8CFCFC8CF90909090909080
      8080808080707070000000000000000000000000000000000000000000000000
      000000000000000000000000808080808080F0F0F0DFD8DFD0D0D0D0D0D08080
      80707070BFB8BFBFB8BF000000BFB8BF70707070707000000000000000000000
      00000000000000000000000000000000000000007F7F7F000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF0000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF00007F00007F00007F00007F00007F00007F00007F00007F7F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      00808080F0F0F0F0F0F0D0D0D0D0D0D00000FF2F00CFCFC8CFCFC8CFBFB8BF80
      8080808080808080000000000000000000000000000000000000000000000000
      000000000000000000000000FFFFFF000000808080808080F0F0F0707070BFB8
      BFBFB8BFDFD8DFDFE0DFDFD8DF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000080
      00000000FF00007F00007F00007F00007F00007F00007F7F7F7F800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00808080DFD8DFDFD8DF00F800009060CFC8CFCFC8CFD0D0D070707080808000
      0000BFB8BF707070000000000000000000000000000000000000000000000000
      000000000000000000000000FFFFFF000000FFFFFF000000808080808080D0D0
      D0DFD8DFE0E8E0E0E8E0EFE8EFDFD8DF00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFFFFFFFF
      7F7F7F000000000000000000000000BFBFBFBFBFBFFFFFFF0000000000000000
      00000000000000000000000000000000000000000000000000000000800000FF
      8000FFFF0000007F00007F00007F00007F00007F7F7F7FFF8000FFFF00800000
      0000000000000000000000000000000000000000000000000000000000000000
      00808080808080F0F0F0DFD8DFD0D0D0D0D0D0808080707070BFB8BFBFB8BF00
      0000BFB8BF707070707070000000000000000000000000000000000000000000
      000000000000000000000000FFFFFF000000FFFFFF000000FFFFFFFFFFFF8080
      80DFE0DFE0E8E0EFE8EFF0F0F0F0F0F0DFD8DF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFFFFFFF0000000000000000
      00000000000000000000000000000000000000000000000000800000FF8000FF
      FF00FF80000000FF00007F00007F00007F00007F7F7F7FFFFF00FF8000FFFF00
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000808080808080F0F0F0707070BFB8BFBFB8BFDFD8DFDFE0DFDF
      D8DF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FFFFFF000000FFFFFF000000FFFFFFFFFFFFFFFF
      FF808080EFE8EFEFE8EFF0F0F080808080808000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FFFFFF0000000000000000
      00000000000000000000000000000000000000000000000000800000FFFF00FF
      80000000FF00007F00007F00007F00007F00007F7F7F7FFF8000FFFF00FF8000
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000808080808080D0D0D0DFD8DFE0E8E0E0E8E0EF
      E8EFDFD8DF000000000000000000000000000000000000000000000000000000
      000000000000000000000000FFFFFF000000FFFFFF0000000000000000000000
      0000000080808080808080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF0000000000000000
      00000000000000000000000000000000000000000000000000800000FFFF0000
      00FF00007F00007F00007F7F7F7F00007F00007F00007F7F7F7FFF8000FFFF00
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000808080DFE0DFE0E8E0EFE8EFF0
      F0F0F0F0F0DFD8DF000000000000000000000000000000000000000000000000
      000000000000000000000000FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FFFFFF000000000000000000FFFFFFFFFFFF0000000000000000000000000000
      000000000000000000000000000000000000000000000000008000000000FF00
      007F00007F00007F7F7F7FFFFF000000FF00007F00007F00007F7F7F7FFF8000
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000808080EFE8EFEFE8EFF0
      F0F0808080808080000000000000000000000000000000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      000000000000000000000000000000000000000000000000008000000000FF00
      007F00007F7F7F7FFF8000FFFF00FF80000000FF00007F00007F00007F7F7F7F
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000080808080808080
      8080000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FFFFFFFFFFFF7F7F7F0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000800000FFFF0000
      00FF00007FFF8000FFFF00FF8000FFFF00FF80000000FF00007F00007F00007F
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000800000FF8000FF
      FF00FF8000FFFF00FF8000FFFF00FF8000FFFF00FF80000000FF00007F0000FF
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000008000008000008000008000008000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF0000FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008000008000000000000000008000008000008000008000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF0000FF0000FF000000
      0000000000000000000000000000FF0000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008000000000000000000000000000000000008000008000008000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF0000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF0000FF0000FF0000FF
      0000000000000000000000FF0000FF0000FF0000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008000000000000000000000000000000000008000008000008000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF0000FF0000FF0000FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF0000FF0000FF
      0000FF0000000000FF0000FF0000FF0000FF0000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008000008000008000008000008000008000
      0080000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF0000FF0000FF0000FF0000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF0000FF
      0000FF0000FF0000FF0000FF0000FF0000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000008000008000008000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000FF0000FF0000000000FF0000FF0000FF0000FF
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000FF0000FF0000FF0000FF0000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000008000008000008000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000FF0000000000000000000000FF0000FF0000FF
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000FF0000FF0000FF0000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF0000FF
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000FF0000FF0000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000FF0000FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000FF0000FF0000FF0000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000008000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000FF0000FF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF0000FF
      0000FF0000000000FF0000FF0000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000800000
      8000008000008000008000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF0000FF0000FF0000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF0000FF0000FF
      0000000000000000000000FF0000FF0000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000800000
      8000008000008000008000008000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000FF0000FF0000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF0000FF000000
      0000000000000000000000000000FF0000FF0000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000008000008000000000000000000000000000000000008000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF0000FF0000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000000000000000000000FF0000FF0000FF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000008000008000000000000000000000000000000000008000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008000008000008000008000000000000000008000008000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000008000008000008000008000008000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      000000000000000000000000FFFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFF00FFFF00000000000000000000000000FFFF00FFFF00000000000000
      000000000000FFFF00FFFF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FFFF00000000000000000000000000000000000000000000000000
      000000000000FFFF000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00FFFF00FFFF00000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00000000FFFF00FFFF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFF00FFFF00000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00000000FFFF00FFFF00FFFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFF00FFFF00FFFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFF00FFFF00FFFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFF00FFFF00FFFF00000000000000000000
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFF00FFFF00FFFF00000000000000000000
      FFFF00FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FFFF00000000000000000000000000000000000000000000000000
      000000FFFF00FFFF000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFF00FFFF00000000000000000000000000FFFF00FFFF00000000000000
      000000000000FFFF00FFFF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000FFFF00000000000000000000
      000000000000000000000000FFFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      28000000600000008C0000000100010000000000900600000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FFFFFFFFFFFF000000000000FFFFFFFFFFFF000000000000FFFFFFFFFFFF0000
      00000000F8001FF8001F000000000000F7FFEFF7FFEF000000000000EFFFF7EF
      FFF7000000000000E80017EF8E17000000000000E80017EF0617000000000000
      EE0077EE0017000000000000EE0077EC0017000000000000EE0077E800170000
      00000000EE0077E80017000000000000EE0077E80017000000000000EE0077E8
      0017000000000000EE0077E80037000000000000EE0077E80037000000000000
      EE0077E80037000000000000EE0077E800F7000000000000EE0077E801F70000
      00000000EE0077E803F7000000000000EE0077E807F7000000000000EE0077E8
      0FF7000000000000EFFFF7EC1FF7000000000000F7FFEFF7FFEF000000000000
      F8001FF8001F000000000000FFFFFFFFFFFF000000000000FFFFFFFFFFFF0000
      00000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8001FF8001FF8001FF8001F
      F7FFEFF7E3EFF7FFEFF7FFEFEFFFF7EF80F7EFFFF7EFC3F7EFFFF7EE0017EFFF
      F7EFC3F7EFC7F7EC0007EE01F7ECC3F7EF01F7EC0007EC00F7E840F7EC0077EC
      0007E80077E80077E80017E80007E80037E80037E80017E80007E80017EC0037
      E80017E80007E80017EE0077E80017E80017EC0017EE0077E80017E80017EE00
      17EC0037E80017E80007EF0017E80017EE0077E80017EF8017E80017EF8037E8
      0017EF8017E80017EFE017E80077EF8017E80017EFF037E80077EF8077E80017
      EFF8F7E801F7EF8077E80017EFFFF7E801F7EFC7F7E80017EFFFF7EFFFF7EFFF
      F7EFFFF7F7FFEFF7FFEFF7FFEFF7FFEFF8001FF8001FF8001FF8001FFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFF8001FF8001FF8001FF8001FF7FFEFF7FFEFF7FFEFF7FFEFEFFFF7EF
      FFF7EFFFF7EFFFF7EFFFF7EFFFF7ECFFF7EF81F7EFFFF7EFFFF7E87CF7EF30F7
      EFFFF7EF3FF7E83877EF7C77EFFFF7EE1FF7E81037EF7C77EBF7F7EC0FF7EC00
      37EFF017E8F1F7EC07F7EE0077EFF837EC3877E803F7EF00F7EFFC77EF0E17E8
      83F7EF01F7EFFEF7EF0E17EDC1F7EF81F7EF7FF7EC3877EFE0F7EF01F7EE3FF7
      E8F1F7EFF077EE00F7EC1FF7EBF7F7EFF837EC1077E80FF7EFFFF7EFFC17EC38
      37EE3EF7EFFFF7EFFE17EE3C17EE3EF7EFFFF7EFFF37EF7E37EF0CF7EFFFF7EF
      FFF7EFFF77EF81F7EFFFF7EFFFF7EFFFF7EFFFF7F7FFEFF7FFEFF7FFEFF7FFEF
      F8001FF8001FF8001FF8001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8001FF8001FF8001FF8001F
      F7FFEFF7FFEFF7FFEFF7FFEFEFFFF7EFFFF7EFFFF7EFFFF7EFF7E7EFFFF7EFFF
      F7EFFFF7E9E797EFFFF7EFFFF7EFFFF7EC0037EFFFF7EFFFF7EFFFF7EE0077EF
      FFF7EFFFF7EFFFF7EE0077EFEFD7EFFDF7EFBFF7EE0077EF8F17EFF1F7EF8FF7
      EE0077EE1C37EFC3F7EFC3F7E00017E870F7EF0FF7EFF0F7E80007E870F7EF0F
      F7EFF0F7EE0077EE1C37EFC3F7EFC3F7EE06F7EF8F17EFF1F7EF8FF7EE04F7EF
      EFD7EFFDF7EFBFF7EE0277EFFFF7EFFFF7EFFFF7EC0737EFFFF7EFFFF7EFFFF7
      E9E797EFFFF7EFFFF7EFFFF7E7EFE7EFFFF7EFFFF7EFFFF7EFFFF7EFFFF7EFFF
      F7EFFFF7F7FFEFF7FFEFF7FFEFF7FFEFF8001FF8001FF8001FF8001FFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      00000000000000000000000000000000000000000000}
  end
  object dsqDefault: TDataSource
    DataSet = FTabTele.qryCliente
    Left = 65528
    Top = 136
  end
  object MainMenu1: TMainMenu
    Images = ImageList1
    Left = 65528
    Top = 72
    object mitCliente: TMenuItem
      Caption = 'Cliente'
      GroupIndex = 1
      object mitNew: TMenuItem
        Caption = 'Novo'
        ImageIndex = 0
        ShortCut = 16429
        OnClick = mitNewClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object mitFirst: TMenuItem
        Caption = 'Primeiro'
        ImageIndex = 1
        ShortCut = 16420
        OnClick = mitFirstClick
      end
      object mitPrior: TMenuItem
        Caption = 'Anterior'
        ImageIndex = 2
        ShortCut = 16418
        OnClick = mitFirstClick
      end
      object mitNext: TMenuItem
        Caption = 'Próximo'
        ImageIndex = 3
        ShortCut = 16417
        OnClick = mitFirstClick
      end
      object mitLast: TMenuItem
        Caption = 'Último'
        ImageIndex = 4
        ShortCut = 16419
        OnClick = mitFirstClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object mitSave: TMenuItem
        Caption = 'Salvar'
        ImageIndex = 5
        ShortCut = 16467
        OnClick = mitSaveClick
      end
      object mitDelete: TMenuItem
        Caption = 'Excluir'
        ImageIndex = 6
        ShortCut = 16430
        OnClick = mitDeleteClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mitRefresh: TMenuItem
        Caption = 'Refresh'
        ImageIndex = 7
        ShortCut = 116
        OnClick = mitRefreshClick
      end
      object mitBusca: TMenuItem
        Caption = 'Busca'
        ImageIndex = 10
        object mitBuscaCodigo: TMenuItem
          Caption = 'Código'
          OnClick = btnProcurarCodigoClick
        end
        object mitBuscaNome: TMenuItem
          Caption = 'Nome'
          OnClick = btnProcurarCodigoClick
        end
        object mitBuscaEndereco: TMenuItem
          Caption = 'Endereço'
          OnClick = btnProcurarCodigoClick
        end
      end
      object mitCancelarFiltros: TMenuItem
        Caption = 'Cancelar Filtros'
        ImageIndex = 11
        OnClick = buscarCliente
      end
      object mitIniciarPedidoparaocliente: TMenuItem
        Caption = 'Iniciar Pedido para o cliente'
        ImageIndex = 13
        OnClick = tbtPedidoClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object mitImprimir: TMenuItem
        Caption = '&Imprimir'
        ImageIndex = 8
        ShortCut = 16464
        OnClick = tbtImprimirClick
      end
      object mitImprimirTodos: TMenuItem
        Caption = 'Imprimir &Todos'
        ImageIndex = 9
        OnClick = tbtImprimirTodosClick
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object mitFechar: TMenuItem
        Caption = 'Fechar'
        ImageIndex = 12
        ShortCut = 27
        OnClick = tbtFecharClick
      end
    end
  end
  object qryTemporaria: TQuery
    Left = 65528
    Top = 168
  end
  object dtsProdutoGrupo: TDataSource
    DataSet = FTabTele.qryProdutoGrupo
    Left = 65528
    Top = 232
  end
  object dtsClienteGrupo: TDataSource
    DataSet = FTabTele.qryClienteGrupo
    Left = 65528
    Top = 200
  end
  object FindDialog1: TFindDialog
    Ctl3D = False
    FindText = 'Telefone'
    Options = [frHideMatchCase, frHideWholeWord, frHideUpDown, frDisableMatchCase, frDisableUpDown, frDisableWholeWord]
    OnFind = buscarCliente
    Left = 65528
    Top = 264
  end
  object popBusca: TPopupMenu
    Left = 24
    Top = 264
    object mi1BuscaCodigo: TMenuItem
      Caption = 'Código'
      OnClick = btnProcurarCodigoClick
    end
    object mi1BuscaNome: TMenuItem
      Caption = 'Nome'
      OnClick = btnProcurarCodigoClick
    end
    object mi1BuscaEndereco: TMenuItem
      Caption = 'Endereço'
      OnClick = btnProcurarCodigoClick
    end
  end
end
