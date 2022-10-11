unit uEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDBDisplay, DBCtrls, DateUtils, pngimage, ExtCtrls, ComCtrls,
  StdCtrls, Mask;

type
  TfrmEdit = class(TForm)
    edtFirstName: TDBEdit;
    edtLastName: TDBEdit;
    edtEmail: TDBEdit;
    edtPhone: TDBEdit;
    edtPassword: TDBEdit;
    cboGenders: TDBLookupComboBox;
    cboShirtSizes: TDBLookupComboBox;
    dtpBirth: TDateTimePicker;
    imgSubmitChanges: TImage;
    procedure imgSubmitChangesClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure fillFields();
  private
    { Private declarations }
  public
    { Public declarations }
    isValidEdit : Boolean;
  end;

var
  frmEdit: TfrmEdit;

implementation
uses uRegistration, uLogin, uHome;
{$R *.dfm}

procedure TfrmEdit.fillFields;
begin
  edtFirstName.Text := 'e';
  edtEmail.Text := frmHome.userEmail;
end;

procedure TfrmEdit.FormActivate(Sender: TObject);
begin
  isValidEdit := FALSE;
  fillFields();
end;

procedure TfrmEdit.imgSubmitChangesClick(Sender: TObject);
begin
  if frmRegistration.inputValidation() then showMessage('passed!');


end;

end.
