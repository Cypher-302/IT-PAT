unit uRegistration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, DBCtrls, StdCtrls, Mask, Buttons, ExtCtrls, uDM2022;

type
  TfrmRegistration = class(TForm)
    gbRegistration: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    pnlQ1: TPanel;
    btnValidate: TButton;
    btnOkay: TBitBtn;
    btnCancel: TBitBtn;
    edtFirstName: TDBEdit;
    edtLastName: TDBEdit;
    edtPhone: TDBEdit;
    edtEmail: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    edtBirth: TDBEdit;
    dtpBirth: TDateTimePicker;
    cboShirtSizes: TDBLookupComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRegistration: TfrmRegistration;

implementation

{$R *.dfm}

end.
