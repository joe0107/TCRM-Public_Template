inherited fmcDLL_Base140: TfmcDLL_Base140
  Caption = 'fmcDLL_Base140'
  PixelsPerInch = 96
  TextHeight = 16
  inherited plControl: TRzPanel
    inherited btnQuery: TRzToolbarButton
      Left = 53
      Width = 45
      Height = 31
    end
    inherited btnFirst: TRzToolbarButton
      Left = 143
      Width = 45
      Height = 31
      OnClick = btnFirstClick
    end
    inherited btnPrior: TRzToolbarButton
      Left = 188
      Width = 45
      Height = 31
      OnClick = btnPriorClick
    end
    inherited btnNext: TRzToolbarButton
      Left = 233
      Width = 45
      Height = 31
      OnClick = btnNextClick
    end
    inherited btnLast: TRzToolbarButton
      Left = 278
      Width = 45
      Height = 31
      OnClick = btnLastClick
    end
    inherited btnAdd: TRzToolbarButton
      Left = 323
      Width = 45
      Height = 31
    end
    inherited btnDel: TRzToolbarButton
      Left = 368
      Width = 45
      Height = 31
      OnClick = btnDelClick
    end
    inherited btnModify: TRzToolbarButton
      Left = 413
      Width = 45
      Height = 31
    end
    inherited btnSave: TRzToolbarButton
      Left = 458
      Width = 45
      Height = 31
    end
    inherited btnCancel: TRzToolbarButton
      Left = 503
      Width = 45
      Height = 31
    end
    inherited btnRefresh: TRzToolbarButton
      Left = 98
      Width = 45
      Height = 31
      OnClick = btnRefreshClick
    end
    inherited btnPreview: TRzToolbarButton
      Left = 548
      Width = 45
      Height = 31
    end
    inherited btnImp: TRzToolbarButton
      Left = 593
      Width = 45
      Height = 31
    end
  end
  inherited plShowMessage: TRzPanel
    Height = 25
    object RzBmpButton1: TRzBmpButton [0]
      Left = 4
      Top = 3
      Width = 85
      Height = 19
      Bitmaps.TransparentColor = clOlive
      Color = 15002091
      ButtonBorder = bbSingle
      Caption = '&V '#20999#25563#39023#31034
      Font.Charset = CHINESEBIG5_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = #32048#26126#39636
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = RzBmpButton1Click
    end
    inherited btnChangeViewPage: TRzBmpButton
      Left = 11
      Top = -11
      Width = 0
      Height = 0
      TabOrder = 1
    end
  end
  inherited pFormPageControl: TRzPageControl
    Top = 59
    Height = 347
    FixedDimension = 0
    inherited pPageSheet1: TRzTabSheet
      inherited plEdit: TRzPanel
        Height = 347
        object FormPageControl: TRzPageControl
          Left = 0
          Top = 0
          Width = 729
          Height = 347
          ActivePage = FormPage1
          Align = alClient
          Color = 16119543
          FlatColor = 10263441
          HotTrackColor = 3983359
          HotTrackColorType = htctActual
          ParentColor = False
          ShowCardFrame = False
          ShowFocusRect = False
          ShowFullFrame = False
          ShowShadow = False
          TabColors.HighlightBar = 3983359
          TabIndex = 0
          TabOrder = 0
          TabStop = False
          FixedDimension = 22
          object FormPage1: TRzTabSheet
            Color = 16119543
            Caption = #28165#21934
            object cgdView: TcxGrid
              Left = 0
              Top = 0
              Width = 729
              Height = 325
              Align = alClient
              TabOrder = 0
              object cgdViewDBBandedTableView1: TcxGridDBBandedTableView
                OnDblClick = cgdViewDBBandedTableView1DblClick
                DataController.Filter.Criteria = {FFFFFFFF0000000000}
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <>
                DataController.Summary.SummaryGroups = <>
                NavigatorButtons.ConfirmDelete = False
                OptionsView.GridLines = glHorizontal
                OptionsView.NewItemRowInfoText = 'Click here to add a new row'
                OptionsView.BandHeaders = False
                OptionsView.FixedBandSeparatorColor = clCream
                OptionsView.FixedBandSeparatorWidth = 1
                Styles.StyleSheet = dmPubController.GridBandedTableViewStyleSheetDevExpress
                Bands = <
                  item
                  end>
              end
              object cgdViewLevel1: TcxGridLevel
                GridView = cgdViewDBBandedTableView1
              end
            end
          end
          object FormPage2: TRzTabSheet
            Color = 16119543
            Caption = #20839#23481
          end
        end
      end
    end
  end
  inherited acdsMaster: TAstaClientDataSet
    Left = 137
    FastFields = ()
    FMultiTable = ()
    UpdateMethod = umManual
  end
  inherited dsMaster: TDataSource
    Left = 165
  end
  inherited ADOMaster: TBetterADODataSet
    StoreDefs = True
  end
end
