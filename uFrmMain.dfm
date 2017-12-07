object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Treser Server'
  ClientHeight = 180
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object mmo1: TMemo
    Left = 8
    Top = 8
    Width = 265
    Height = 129
    Lines.Strings = (
      'mmo1')
    TabOrder = 0
  end
  object btnStart: TButton
    Left = 8
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = btnStartClick
  end
  object btnStop: TButton
    Left = 89
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 2
    OnClick = btnStopClick
  end
  object btnExit: TButton
    Left = 364
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Exit'
    TabOrder = 3
    OnClick = btnExitClick
  end
  object tcpsrvr1: TTcpServer
    LocalHost = 'localhost'
    LocalPort = '7777'
    OnAccept = tcpsrvr1Accept
    Left = 272
    Top = 56
  end
end
