object fmTemplate: TfmTemplate
  Left = 409
  Top = 172
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = #22577#34920#31684#26412#31649#29702
  ClientHeight = 308
  ClientWidth = 491
  Color = 16579836
  Ctl3D = False
  Font.Charset = CHINESEBIG5_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #24494#36575#27491#40657#39636
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 19
  object RzPanel1: TRzPanel
    Left = 0
    Top = 0
    Width = 491
    Height = 270
    Align = alClient
    BorderOuter = fsNone
    ParentColor = True
    TabOrder = 0
    object cxDBMemo1: TRzDBMemo
      Left = 0
      Top = 203
      Width = 491
      Height = 67
      Align = alBottom
      DataField = 'TempMark'
      DataSource = dsTemplate
      Font.Charset = CHINESEBIG5_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = #24494#36575#27491#40657#39636
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object RzDBGrid1: TRzDBGrid
      Left = 0
      Top = 0
      Width = 491
      Height = 203
      Align = alClient
      DataSource = dsTemplate
      DefaultDrawing = True
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = CHINESEBIG5_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -15
      TitleFont.Name = #24494#36575#27491#40657#39636
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'TempName'
          Width = 377
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DefaultReport_V'
          Visible = True
        end>
    end
  end
  object RzPanel2: TRzPanel
    Left = 0
    Top = 270
    Width = 491
    Height = 38
    Align = alBottom
    BorderOuter = fsNone
    TabOrder = 1
    object btnSelect: TRzToolbarButton
      Left = 325
      Top = 4
      Width = 80
      Height = 29
      Hint = 'Post'
      Caption = #36984#29992'(&O)'
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000330B0000330B00000001000000010000000000003300
        00006600000099000000CC000000FF0000000033000033330000663300009933
        0000CC330000FF33000000660000336600006666000099660000CC660000FF66
        000000990000339900006699000099990000CC990000FF99000000CC000033CC
        000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
        0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
        330000333300333333006633330099333300CC333300FF333300006633003366
        33006666330099663300CC663300FF6633000099330033993300669933009999
        3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
        330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
        66006600660099006600CC006600FF0066000033660033336600663366009933
        6600CC336600FF33660000666600336666006666660099666600CC666600FF66
        660000996600339966006699660099996600CC996600FF99660000CC660033CC
        660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
        6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
        990000339900333399006633990099339900CC339900FF339900006699003366
        99006666990099669900CC669900FF6699000099990033999900669999009999
        9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
        990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
        CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
        CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
        CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
        CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
        CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
        FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
        FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
        FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
        FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
        000000808000800000008000800080800000C0C0C00080808000191919004C4C
        4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
        6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E80909
        E8E8E8E8E8E8E8E8E8E8E8E8E8E88181E8E8E8E8E8E8E8E8E8E8E8E8E8091010
        09E8E8E8E8E8E8E8E8E8E8E8E881ACAC81E8E8E8E8E8E8E8E8E8E8E809101010
        1009E8E8E8E8E8E8E8E8E8E881ACACACAC81E8E8E8E8E8E8E8E8E80910101010
        101009E8E8E8E8E8E8E8E881ACACACACACAC81E8E8E8E8E8E8E8E80910100909
        10101009E8E8E8E8E8E8E881ACAC8181ACACAC81E8E8E8E8E8E8E8091009E8E8
        0910101009E8E8E8E8E8E881AC81E8E881ACACAC81E8E8E8E8E8E80909E8E8E8
        E80910101009E8E8E8E8E88181E8E8E8E881ACACAC81E8E8E8E8E8E8E8E8E8E8
        E8E80910101009E8E8E8E8E8E8E8E8E8E8E881ACACAC81E8E8E8E8E8E8E8E8E8
        E8E8E80910101009E8E8E8E8E8E8E8E8E8E8E881ACACAC81E8E8E8E8E8E8E8E8
        E8E8E8E809101009E8E8E8E8E8E8E8E8E8E8E8E881ACAC81E8E8E8E8E8E8E8E8
        E8E8E8E8E8091009E8E8E8E8E8E8E8E8E8E8E8E8E881AC81E8E8E8E8E8E8E8E8
        E8E8E8E8E8E80909E8E8E8E8E8E8E8E8E8E8E8E8E8E88181E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
      NumGlyphs = 2
      Spacing = 2
      OnClick = btnSelectClick
      HotNumGlyphs = 0
    end
    object btnCancel: TRzToolbarButton
      Left = 408
      Top = 4
      Width = 80
      Height = 29
      Hint = 'Cancel'
      Caption = #21462#28040'(&C)'
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000330B0000330B00000001000000010000000000003300
        00006600000099000000CC000000FF0000000033000033330000663300009933
        0000CC330000FF33000000660000336600006666000099660000CC660000FF66
        000000990000339900006699000099990000CC990000FF99000000CC000033CC
        000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
        0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
        330000333300333333006633330099333300CC333300FF333300006633003366
        33006666330099663300CC663300FF6633000099330033993300669933009999
        3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
        330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
        66006600660099006600CC006600FF0066000033660033336600663366009933
        6600CC336600FF33660000666600336666006666660099666600CC666600FF66
        660000996600339966006699660099996600CC996600FF99660000CC660033CC
        660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
        6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
        990000339900333399006633990099339900CC339900FF339900006699003366
        99006666990099669900CC669900FF6699000099990033999900669999009999
        9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
        990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
        CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
        CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
        CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
        CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
        CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
        FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
        FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
        FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
        FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
        000000808000800000008000800080800000C0C0C00080808000191919004C4C
        4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
        6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E809090909E8
        E8E8E8E809090909E8E8E881818181E8E8E8E8E881818181E8E8E80910101009
        E8E8E80910101009E8E8E881ACACAC81E8E8E881ACACAC81E8E8E8E809101010
        09E80910101009E8E8E8E8E881ACACAC81E881ACACAC81E8E8E8E8E8E8091010
        100910101009E8E8E8E8E8E8E881ACACAC81ACACAC81E8E8E8E8E8E8E8E80910
        1010101009E8E8E8E8E8E8E8E8E881ACACACACAC81E8E8E8E8E8E8E8E8E8E809
        10101009E8E8E8E8E8E8E8E8E8E8E881ACACAC81E8E8E8E8E8E8E8E8E8E80910
        1010101009E8E8E8E8E8E8E8E8E881ACACACACAC81E8E8E8E8E8E8E8E8091010
        100910101009E8E8E8E8E8E8E881ACACAC81ACACAC81E8E8E8E8E8E809101010
        09E80910101009E8E8E8E8E881ACACAC81E881ACACAC81E8E8E8E80910101009
        E8E8E80910101009E8E8E881ACACAC81E8E8E881ACACAC81E8E8E809090909E8
        E8E8E8E809090909E8E8E881818181E8E8E8E8E881818181E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
      NumGlyphs = 2
      Spacing = 2
      OnClick = btnCancelClick
      HotNumGlyphs = 0
    end
    object btnLoad: TRzToolbarButton
      Left = 3
      Top = 4
      Width = 105
      Height = 29
      Hint = 'Open'
      Caption = #36617#20837#31684#26412'(&L)'
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000430B0000430B00000001000000010000000000003300
        00006600000099000000CC000000FF0000000033000033330000663300009933
        0000CC330000FF33000000660000336600006666000099660000CC660000FF66
        000000990000339900006699000099990000CC990000FF99000000CC000033CC
        000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
        0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
        330000333300333333006633330099333300CC333300FF333300006633003366
        33006666330099663300CC663300FF6633000099330033993300669933009999
        3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
        330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
        66006600660099006600CC006600FF0066000033660033336600663366009933
        6600CC336600FF33660000666600336666006666660099666600CC666600FF66
        660000996600339966006699660099996600CC996600FF99660000CC660033CC
        660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
        6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
        990000339900333399006633990099339900CC339900FF339900006699003366
        99006666990099669900CC669900FF6699000099990033999900669999009999
        9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
        990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
        CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
        CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
        CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
        CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
        CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
        FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
        FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
        FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
        FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
        000000808000800000008000800080800000C0C0C00080808000191919004C4C
        4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
        6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8A378787878
        787878787878AAE8E8E8E88181818181818181818181ACE8E8E8A3A3D5CECECE
        CECECECECEA378E8E8E88181E3ACACACACACACACAC8181E8E8E8A3A3CED5D5D5
        D5D5D5D5D5CE78A3E8E88181ACE3E3E3E3E3E3E3E3AC8181E8E8A3A3CED5D5D5
        D5D5D5D5D5CEAA78E8E88181ACE3E3E3E3E3E3E3E3ACAC81E8E8A3CEA3D5D5D5
        D5D5D5D5D5CED578A3E881AC81E3E3E3E3E3E3E3E3ACE38181E8A3CEAAAAD5D5
        D5D5D5D5D5CED5AA78E881ACACACE3E3E3E3E3E3E3ACE3AC81E8A3D5CEA3D6D6
        D6D6D6D6D6D5D6D678E881E3AC81E3E3E3E3E3E3E3E3E3E381E8A3D5D5CEA3A3
        A3A3A3A3A3A3A3A3CEE881E3E3AC81818181818181818181ACE8A3D6D5D5D5D5
        D6D6D6D6D678E8E8E8E881E3E3E3E3E3E3E3E3E3E381E8E8E8E8E8A3D6D6D6D6
        A3A3A3A3A3E8E8E8E8E8E881E3E3E3E38181818181E8E8E8E8E8E8E8A3A3A3A3
        E8E8E8E8E8E8E8090909E8E881818181E8E8E8E8E8E8E8818181E8E8E8E8E8E8
        E8E8E8E8E8E8E8E80909E8E8E8E8E8E8E8E8E8E8E8E8E8E88181E8E8E8E8E8E8
        E8E8E809E8E8E809E809E8E8E8E8E8E8E8E8E881E8E8E881E881E8E8E8E8E8E8
        E8E8E8E8090909E8E8E8E8E8E8E8E8E8E8E8E8E8818181E8E8E8}
      NumGlyphs = 2
      Spacing = 2
      OnClick = btnLoadClick
      HotNumGlyphs = 0
    end
    object btnDelete: TRzToolbarButton
      Left = 111
      Top = 4
      Width = 105
      Height = 29
      Hint = 'Delete'
      Caption = #21034#38500#31684#26412'(&D)'
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000630E0000630E00000001000000010000000000003300
        00006600000099000000CC000000FF0000000033000033330000663300009933
        0000CC330000FF33000000660000336600006666000099660000CC660000FF66
        000000990000339900006699000099990000CC990000FF99000000CC000033CC
        000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
        0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
        330000333300333333006633330099333300CC333300FF333300006633003366
        33006666330099663300CC663300FF6633000099330033993300669933009999
        3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
        330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
        66006600660099006600CC006600FF0066000033660033336600663366009933
        6600CC336600FF33660000666600336666006666660099666600CC666600FF66
        660000996600339966006699660099996600CC996600FF99660000CC660033CC
        660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
        6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
        990000339900333399006633990099339900CC339900FF339900006699003366
        99006666990099669900CC669900FF6699000099990033999900669999009999
        9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
        990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
        CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
        CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
        CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
        CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
        CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
        FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
        FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
        FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
        FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
        000000808000800000008000800080800000C0C0C00080808000191919004C4C
        4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
        6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E86CE8E8
        E8E8E8E8E8E8E8E8B4E8E8E8E881E8E8E8E8E8E8E8E8E8E8ACE8E8E897B46CE8
        E8E8E8E8E8E8E8E8E8E8E8E881AC81E8E8E8E8E8E8E8E8E8E8E8E8E897C7B46C
        E8E8E8E8E8E8E8B4E8E8E8E881E3AC81E8E8E8E8E8E8E8ACE8E8E8E8E897C090
        E8E8E8E8E8E8B4E8E8E8E8E8E881E381E8E8E8E8E8E8ACE8E8E8E8E8E8E890B4
        6CE8E8E8E8B46CE8E8E8E8E8E8E881AC81E8E8E8E8AC81E8E8E8E8E8E8E8E890
        B46CE8E8B46CE8E8E8E8E8E8E8E8E881AC81E8E8AC81E8E8E8E8E8E8E8E8E8E8
        90B46CB46CE8E8E8E8E8E8E8E8E8E8E881AC81AC81E8E8E8E8E8E8E8E8E8E8E8
        E890B46CE8E8E8E8E8E8E8E8E8E8E8E8E881AC81E8E8E8E8E8E8E8E8E8E8E8E8
        90B46C906CE8E8E8E8E8E8E8E8E8E8E881AC818181E8E8E8E8E8E8E8E8E8E890
        B46CE8E8906CE8E8E8E8E8E8E8E8E881AC81E8E88181E8E8E8E8E8E8E890B4B4
        6CE8E8E8E8906CE8E8E8E8E8E881ACAC81E8E8E8E88181E8E8E8E8E890C7B46C
        E8E8E8E8E8E8906CE8E8E8E881E3AC81E8E8E8E8E8E88181E8E8E8E87A907AE8
        E8E8E8E8E8E8E8E890E8E8E8AC81ACE8E8E8E8E8E8E8E8E881E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
      NumGlyphs = 2
      Spacing = 2
      OnClick = btnDeleteClick
      HotNumGlyphs = 0
    end
    object btnSetDefault: TRzToolbarButton
      Left = 218
      Top = 4
      Width = 105
      Height = 29
      Hint = 'Properties'
      Caption = #35373#25104#38928#35373'(&S)'
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000930E0000930E00000001000000010000000000003300
        00006600000099000000CC000000FF0000000033000033330000663300009933
        0000CC330000FF33000000660000336600006666000099660000CC660000FF66
        000000990000339900006699000099990000CC990000FF99000000CC000033CC
        000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
        0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
        330000333300333333006633330099333300CC333300FF333300006633003366
        33006666330099663300CC663300FF6633000099330033993300669933009999
        3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
        330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
        66006600660099006600CC006600FF0066000033660033336600663366009933
        6600CC336600FF33660000666600336666006666660099666600CC666600FF66
        660000996600339966006699660099996600CC996600FF99660000CC660033CC
        660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
        6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
        990000339900333399006633990099339900CC339900FF339900006699003366
        99006666990099669900CC669900FF6699000099990033999900669999009999
        9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
        990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
        CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
        CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
        CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
        CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
        CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
        FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
        FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
        FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
        FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
        000000808000800000008000800080800000C0C0C00080808000191919004C4C
        4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
        6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E85E5E5E5E
        5E5E5E5E5E5E5E5EE8E8E8E8818181818181818181818181E8E8E8E85ED7D7D7
        D7D7D7D7D7D7D75EE8E8E8E881ACACACACACACACACACAC81E8E8E8E85ED7D7D7
        09D7D7D7D7D7D75EE8E8E8E881ACACAC81ACACACACACAC81E8E8E8E85ED7D709
        0909D7D7D7D7D75EE8E8E8E881ACAC818181ACACACACAC81E8E8E8E85ED70909
        090909D7D7D7D75EE8E8E8E881AC8181818181ACACACAC81E8E8E8E85ED70909
        D7090909D7D7D75EE8E8E8E881AC8181AC818181ACACAC81E8E8E8E85ED709D7
        D7D7090909D7D75EE8E8E8E881AC81ACACAC818181ACAC81E8E8E8E85ED7D7D7
        D7D7D70909D7D75EE8E8E8E881ACACACACACAC8181ACAC81E8E8E8E85ED7D7D7
        D7D7D7D709D7D75EE8E8E8E881ACACACACACACAC81ACAC81E8E8E8E85ED7D7D7
        D7D7D7D7D7D7D75EE8E8E8E881ACACACACACACACACACAC81E8E8E8E85ED7D7D7
        D7D7D7D75E5E5E5EE8E8E8E881ACACACACACACAC81818181E8E8E8E85ED7D7D7
        D7D7D7D75EE35EE8E8E8E8E881ACACACACACACAC81AC81E8E8E8E8E85ED7D7D7
        D7D7D7D75E5EE8E8E8E8E8E881ACACACACACACAC8181E8E8E8E8E8E85E5E5E5E
        5E5E5E5E5EE8E8E8E8E8E8E8818181818181818181E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
      NumGlyphs = 2
      Spacing = 2
      OnClick = btnSetDefaultClick
      HotNumGlyphs = 0
    end
  end
  object tbTemplate: TDBISAMTable
    AutoDisplayLabels = False
    CopyOnAppend = False
    OnCalcFields = tbTemplateCalcFields
    EngineVersion = '3.26'
    IndexFieldNames = 'ReportID;GroupID;TempName'
    TableName = 'TemplateMan'
    Left = 375
    Top = 143
    object tbTemplateTempName: TStringField
      DisplayLabel = #31684#26412#21517#31281
      FieldName = 'TempName'
      Origin = 'MTemplate.TempName'
      Required = True
      Size = 60
    end
    object tbTemplateReportID: TStringField
      DisplayLabel = #22577#34920#20195#34399
      FieldName = 'ReportID'
      Origin = 'MTemplate.ReportID'
      Required = True
    end
    object tbTemplateGroupID: TStringField
      DisplayLabel = #32676#32068#20195#34399
      FieldName = 'GroupID'
      Origin = 'MTemplate.GroupID'
      Required = True
      Size = 10
    end
    object tbTemplateTempMark: TStringField
      DisplayLabel = #31684#26412#35498#26126
      FieldName = 'TempMark'
      Origin = 'MTemplate.TempMark'
      Size = 60
    end
    object tbTemplateReportFile: TBlobField
      DisplayLabel = #31684#26412#27284#26696
      FieldName = 'ReportFile'
      Origin = 'MTemplate.ReportFile'
    end
    object tbTemplateSysFlag: TIntegerField
      DisplayLabel = #31995#32113#31684#26412
      FieldName = 'SysFlag'
      Origin = 'MTemplate.SysFlag'
    end
    object tbTemplateBaseMap: TIntegerField
      DisplayLabel = #21015#21360#24213#22294
      FieldName = 'BaseMap'
      Origin = 'MTemplate.BaseMap'
    end
    object tbTemplateDefaultReport: TBooleanField
      DisplayLabel = #20839#23450#31684#26412
      FieldName = 'DefaultReport'
      Origin = 'MTemplate.DefaultReport'
    end
    object tbTemplateTempDefault: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'TempDefault'
      Calculated = True
    end
    object tbTemplateDefaultReport_V: TStringField
      DisplayLabel = #20839#23450#31684#26412
      FieldKind = fkCalculated
      FieldName = 'DefaultReport_V'
      Size = 1
      Calculated = True
    end
  end
  object dsTemplate: TDataSource
    AutoEdit = False
    DataSet = tbTemplate
    Left = 345
    Top = 143
  end
  object dbpTemplate: TppDBPipeline
    DataSource = dsTemplate
    UserName = 'dbpTemplate'
    Left = 317
    Top = 142
    object dbpTemplateppField1: TppField
      FieldAlias = 'TempName'
      FieldName = 'TempName'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object dbpTemplateppField2: TppField
      FieldAlias = 'ReportID'
      FieldName = 'ReportID'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object dbpTemplateppField3: TppField
      FieldAlias = 'GroupID'
      FieldName = 'GroupID'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object dbpTemplateppField4: TppField
      FieldAlias = 'TempMark'
      FieldName = 'TempMark'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object dbpTemplateppField5: TppField
      FieldAlias = 'ReportFile'
      FieldName = 'ReportFile'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object dbpTemplateppField6: TppField
      FieldAlias = 'SysFlag'
      FieldName = 'SysFlag'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object dbpTemplateppField7: TppField
      FieldAlias = 'BaseMap'
      FieldName = 'BaseMap'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object dbpTemplateppField8: TppField
      FieldAlias = 'DefaultReport'
      FieldName = 'DefaultReport'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
  end
end