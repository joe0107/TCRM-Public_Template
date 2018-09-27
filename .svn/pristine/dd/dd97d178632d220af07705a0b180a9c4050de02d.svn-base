inherited fmcDLL_Base110: TfmcDLL_Base110
  Left = 105
  Top = 159
  Width = 734
  Height = 478
  Caption = ''
  OnKeyDown = nil
  PixelsPerInch = 96
  TextHeight = 16
  inherited plControl: TRzPanel
    Width = 726
    inherited btnFirst: TRzToolbarButton
      OnClick = btnFirstClick
    end
    inherited btnPrior: TRzToolbarButton
      OnClick = btnPriorClick
    end
    inherited btnNext: TRzToolbarButton
      OnClick = btnNextClick
    end
    inherited btnLast: TRzToolbarButton
      OnClick = btnLastClick
    end
    inherited btnDel: TRzToolbarButton
      OnClick = btnDelClick
    end
    inherited btnRefresh: TRzToolbarButton
      OnClick = btnRefreshClick
    end
  end
  inherited plShowMessage: TRzPanel
    Width = 726
  end
  inherited pFormPageControl: TRzPageControl
    Width = 726
    Height = 386
    FixedDimension = 0
    inherited pPageSheet1: TRzTabSheet
      inherited plEdit: TRzPanel
        Left = 308
        Width = 418
        Height = 386
      end
      object cgdView: TcxGrid
        Left = 0
        Top = 0
        Width = 308
        Height = 386
        Align = alLeft
        BevelOuter = bvNone
        BorderStyle = cxcbsNone
        TabOrder = 1
        object cxGrid1DBTableView1: TcxGridDBTableView
          DataController.DataSource = dsMaster
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          Filtering.CustomizeDialog = False
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.GroupByBox = False
          OptionsView.NewItemRowInfoText = 'Click here to add a new row'
          Styles.StyleSheet = dmPubController.GridTableViewStyleSheetDevExpress
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = cxGrid1DBTableView1
        end
      end
    end
  end
  inherited acdsMaster: TAstaClientDataSet
    FastFields = ()
    FMultiTable = ()
    UpdateMethod = umManual
  end
  inherited dsMaster: TDataSource
    Top = 36
  end
  inherited ADOMaster: TBetterADODataSet
    StoreDefs = True
  end
end
