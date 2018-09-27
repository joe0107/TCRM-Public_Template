inherited fmcDLL_Base130: TfmcDLL_Base130
  Left = 247
  Width = 695
  Height = 453
  Caption = 'fmcDLL_Base130'
  PixelsPerInch = 96
  TextHeight = 16
  inherited plControl: TRzPanel
    Width = 687
    inherited btnQuery: TRzToolbarButton
      Width = 0
      Visible = False
    end
    inherited btnFirst: TRzToolbarButton
      Left = 106
      Width = 0
      Visible = False
    end
    inherited btnPrior: TRzToolbarButton
      Left = 158
      Width = 0
      Visible = False
    end
    inherited btnNext: TRzToolbarButton
      Left = 209
      Width = 0
      Visible = False
    end
    inherited btnLast: TRzToolbarButton
      Left = 261
      Width = 0
      Visible = False
    end
    inherited btnAdd: TRzToolbarButton
      Left = 100
    end
    inherited btnDel: TRzToolbarButton
      Left = 152
      OnClick = btnDelClick
    end
    inherited btnModify: TRzToolbarButton
      Left = 204
    end
    inherited btnSave: TRzToolbarButton
      Left = 256
    end
    inherited btnCancel: TRzToolbarButton
      Left = 308
    end
    inherited btnRefresh: TRzToolbarButton
      Left = 48
    end
    inherited btnPreview: TRzToolbarButton
      Left = 360
    end
    inherited btnImp: TRzToolbarButton
      Left = 412
    end
  end
  inherited plShowMessage: TRzPanel
    Width = 687
  end
  inherited pFormPageControl: TRzPageControl
    Width = 687
    Height = 361
    FixedDimension = 0
    inherited pPageSheet1: TRzTabSheet
      inherited plEdit: TRzPanel
        Left = 267
        Width = 420
        Height = 361
      end
      object cTreeView: TdxDBTreeView
        Left = 0
        Top = 0
        Width = 267
        Height = 361
        ImeName = #20013#25991' ('#32321#39636') - '#26032#27880#38899
        ShowNodeHint = True
        DataSource = dsMaster
        SeparatedSt = '/'
        RaiseOnError = True
        ReadOnly = True
        Indent = 19
        Align = alLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = #32048#26126#39636
        Font.Style = []
        Color = 15451300
        ParentColor = False
        Options = [trDBCanDelete, trDBConfirmDelete, trCanDBNavigate, trSmartRecordCopy, trCheckHasChildren]
        SelectedIndex = -1
        TabOrder = 1
        TabStop = False
        ParentFont = False
      end
    end
  end
  inherited acdsMaster: TAstaClientDataSet
    FastFields = ()
    FMultiTable = ()
    UpdateMethod = umManual
  end
  inherited ADOMaster: TBetterADODataSet
    StoreDefs = True
  end
end
