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
    function inputValidation(): Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEdit: TfrmEdit;

implementation
uses uRegistration, uLogin, uHome;
{$R *.dfm}

function TfrmEdit.inputValidation: Boolean;  //uses uRegistration to run input validation on all fields inputted
var age: Integer;                            //in this form, also obtains user age for use in DoBCheck
begin
with frmRegistration do BEGIN
  age:= GetAge(dtpBirth.DateTime, Today);
  if nameCheck(edtFirstName.Text, edtLastName.Text) AND
  emailCheck(edtEmail.Text) AND
  phoneCheck(edtPhone.Text) AND
  DoBCheck(dtpBirth.Date, age) AND
  shirtSizeCheck() AND
  genderCheck() AND
  passwordCheck(edtPassword.Text) then
   result := TRUE
  else
   result := FALSE;
END;
end;

procedure TfrmEdit.imgSubmitChangesClick(Sender: TObject);  //if validation passes, a message asking for
begin                                                       //confirmation of changes is displayed, if yes
  if inputValidation()                                      //is selected, the form closes and the changes are commited
   then if messageDlg('Are you satisfied with the changes made and wish to proceed?',
        mtConfirmation,[mbYes,mbNo],0) = mrYes then self.Close;

end;

end.
