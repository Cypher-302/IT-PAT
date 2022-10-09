object UserDlg: TUserDlg
  Left = 245
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Login Dialog'
  ClientHeight = 128
  ClientWidth = 233
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 54
    Width = 79
    Height = 13
    Caption = 'Enter password:'
  end
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 80
    Height = 13
    Caption = 'Enter username:'
  end
  object Password: TEdit
    Left = 8
    Top = 72
    Width = 217
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
    Text = '12345'
  end
  object OKBtn: TButton
    Left = 70
    Top = 99
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object CancelBtn: TButton
    Left = 150
    Top = 99
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object Username: TEdit
    Left = 8
    Top = 27
    Width = 217
    Height = 21
    TabOrder = 3
    Text = 'Admin'
  end
end
