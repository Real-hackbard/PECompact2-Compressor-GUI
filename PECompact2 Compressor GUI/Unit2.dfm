object Form2: TForm2
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Information'
  ClientHeight = 158
  ClientWidth = 272
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 15
  object StatusBar1: TStatusBar
    Left = 0
    Top = 139
    Width = 272
    Height = 19
    Panels = <
      item
        Text = 'File :'
        Width = 35
      end
      item
        Width = 50
      end>
    ExplicitLeft = 176
    ExplicitTop = 360
    ExplicitWidth = 0
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 272
    Height = 139
    Align = alClient
    BorderStyle = bsNone
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
    ExplicitWidth = 265
    ExplicitHeight = 200
  end
end
