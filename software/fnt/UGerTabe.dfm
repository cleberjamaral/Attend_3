object FGerTabe: TFGerTabe
  Left = 262
  Top = 168
  Width = 640
  Height = 480
  Caption = 'Gerente de Tabelas'
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgcGerente: TPageControl
    Left = 0
    Top = 0
    Width = 633
    Height = 454
    ActivePage = tshData
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object tshData: TTabSheet
      Caption = 'Dados'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 625
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object cbxTabela: TComboBox
          Left = 0
          Top = 8
          Width = 265
          Height = 21
          Color = 16772332
          ItemHeight = 13
          TabOrder = 0
          Text = 'Selecione um Tabela'
          OnChange = cbxTabelaChange
        end
        object btnSave: TBitBtn
          Left = 505
          Top = 8
          Width = 113
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Salvar Alterações'
          TabOrder = 1
          OnClick = btnSaveClick
        end
      end
      object dbgTabela: TDBGrid
        Left = 0
        Top = 40
        Width = 625
        Height = 385
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = dsTabela
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
    object tshSQL: TTabSheet
      Caption = 'Comando SQL'
      ImageIndex = 1
      object memSQL: TMemo
        Left = 8
        Top = 8
        Width = 489
        Height = 153
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object btnOpen: TBitBtn
        Left = 504
        Top = 128
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Abrir'
        TabOrder = 1
        OnClick = btnOpenClick
      end
      object btnExecute: TBitBtn
        Left = 504
        Top = 24
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Executar'
        TabOrder = 2
        OnClick = btnExecuteClick
      end
      object DBGrid1: TDBGrid
        Left = 8
        Top = 168
        Width = 569
        Height = 217
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = dscTemp
        TabOrder = 3
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
  end
  object tTabela: TTable
    CachedUpdates = True
    DatabaseName = 'DBCommerce'
    Left = 33
    Top = 97
  end
  object dsTabela: TDataSource
    DataSet = tTabela
    Left = 33
    Top = 129
  end
  object qryTemp: TQuery
    DatabaseName = 'DBCommerce'
    Left = 332
    Top = 96
  end
  object dscTemp: TDataSource
    DataSet = qryTemp
    Left = 332
    Top = 128
  end
end
