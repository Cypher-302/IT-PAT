object frmRegistration: TfrmRegistration
  Left = 0
  Top = 0
  Caption = 'Student Registration'
  ClientHeight = 143
  ClientWidth = 757
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object gbRegistration: TGroupBox
    Left = 0
    Top = 0
    Width = 757
    Height = 145
    Align = alTop
    Caption = ' Player Info '
    Color = clBtnFace
    ParentBackground = False
    ParentColor = False
    TabOrder = 0
    object Label1: TLabel
      Left = 17
      Top = 18
      Width = 82
      Height = 19
      Caption = 'First Name:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 19
      Top = 43
      Width = 80
      Height = 19
      Caption = 'Last Name:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 279
      Top = 18
      Width = 57
      Height = 19
      Caption = 'Gender:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 264
      Top = 43
      Width = 72
      Height = 19
      Caption = 'Shirt Size:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 296
      Top = 65
      Width = 39
      Height = 19
      Caption = 'Birth:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 525
      Top = 18
      Width = 50
      Height = 19
      BiDiMode = bdLeftToRight
      Caption = 'Phone:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
    end
    object Label8: TLabel
      Left = 531
      Top = 41
      Width = 45
      Height = 19
      Caption = 'Email:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object pnlQ1: TPanel
      Left = 567
      Top = 15
      Width = 188
      Height = 128
      Align = alRight
      TabOrder = 1
    end
    object btnValidate: TButton
      Left = 19
      Top = 68
      Width = 239
      Height = 37
      Caption = 'Validate'
      TabOrder = 2
    end
    object btnOkay: TBitBtn
      Left = 522
      Top = 71
      Width = 107
      Height = 33
      Caption = 'OK'
      Default = True
      DoubleBuffered = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      ModalResult = 1
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 3
    end
    object btnCancel: TBitBtn
      Left = 635
      Top = 71
      Width = 109
      Height = 33
      DoubleBuffered = True
      Kind = bkCancel
      ParentDoubleBuffered = False
      TabOrder = 4
    end
    object edtFirstName: TDBEdit
      Left = 105
      Top = 18
      Width = 152
      Height = 24
      DataField = 'first_name'
      DataSource = DM2022.dbsPlayers
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object edtLastName: TDBEdit
      Left = 105
      Top = 41
      Width = 152
      Height = 24
      DataField = 'last_name'
      DataSource = DM2022.dbsPlayers
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object edtPhone: TDBEdit
      Left = 592
      Top = 18
      Width = 152
      Height = 24
      DataField = 'phone'
      DataSource = DM2022.dbsPlayers
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object edtEmail: TDBEdit
      Left = 592
      Top = 41
      Width = 152
      Height = 24
      DataField = 'email'
      DataSource = DM2022.dbsPlayers
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 342
      Top = 17
      Width = 152
      Height = 24
      DataField = 'gender'
      DataSource = DM2022.dbsPlayers
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      KeyField = 'Type'
      ListField = 'Type'
      ListSource = DM2022.dbsGenders
      ParentFont = False
      TabOrder = 9
    end
    object edtBirth: TDBEdit
      Left = 342
      Top = 65
      Width = 152
      Height = 24
      DataField = 'birth'
      DataSource = DM2022.dbsPlayers
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
    end
    object dtpBirth: TDateTimePicker
      Left = 341
      Top = 87
      Width = 152
      Height = 24
      Date = 44823.501372824060000000
      Time = 44823.501372824060000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object cboShirtSizes: TDBLookupComboBox
      Left = 342
      Top = 43
      Width = 151
      Height = 21
      DataField = 'shirt_size'
      DataSource = DM2022.dbsPlayers
      KeyField = 'sizes'
      ListField = 'sizes'
      ListSource = DM2022.dbsShirtSizes
      TabOrder = 11
    end
  end
end
