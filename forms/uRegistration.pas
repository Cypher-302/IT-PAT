unit uRegistration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, DBCtrls, StdCtrls, Mask, Buttons, ExtCtrls, uDM2022,
  uLogin, DateUtils, pngimage;

type
  TfrmRegistration = class(TForm)
    imgRegistration: TImage;
    edtFirstName: TDBEdit;
    edtLastName: TDBEdit;
    cboGenders: TDBLookupComboBox;
    cboShirtSizes: TDBLookupComboBox;
    edtPhone: TDBEdit;
    edtEmail: TDBEdit;
    dtpBirth: TDateTimePicker;
    imgSignUp: TImage;
    imgLoginLink: TImage;
    edtPassword: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure imgLoginLinkClick(Sender: TObject);
    procedure imgSignUpClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    function nameCheck(firstName, LastName : String): Boolean;
    function emailCheck(email : String): Boolean;
    function phoneCheck(phoneNum : String): Boolean;
    function DoBCheck(DoB: TDate; var age: Integer): Boolean;
    function shirtSizeCheck(): Boolean;
    function genderCheck(): Boolean;
    function passwordCheck(password : String): Boolean;
    function inputValidation(): Boolean;
    function isLetters(name : String): Boolean;
    function GetAge(const BirthDate, CurrentDate: TDateTime): Integer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRegistration: TfrmRegistration;

implementation
uses uHome;

{$R *.dfm}

function TfrmRegistration.isLetters(name : String): Boolean;
var iLoop: Integer;
begin
result:= TRUE;
  for iLoop := 1 to length(name) do
  begin
    name[iLoop] := Upcase(name[iLoop]);
    if not(name[iLoop] in ['A' .. 'Z']) then result := FALSE
  end;
end;

function TfrmRegistration.nameCheck(firstName, lastName: String): Boolean;
begin
result := FALSE;
   if (Length(firstName) > 3) AND (isLetters(firstName)) then begin       // in ['a' .. 'z', 'A' .. 'Z']
    result := TRUE;
    edtFirstName.Color := clWindow;
   end
  else BEGIN
    edtFirstName.Color := clRed;
    result := FALSE;
    messageDlg('First name must be over 3 letters, and contain only letters!',mtWarning,[mbOk],0);
  END;

  if (Length(lastName) > 3) AND (isLetters(lastName)) then begin
    result := TRUE;
    edtLastName.Color := clWindow;
  end
  else BEGIN
    edtLastName.Color := clRed;
    result := FALSE;
    messageDlg('Last name must be over 3 letters, and contain only letters!',mtWarning,[mbOk],0);
  END;
end;

function TfrmRegistration.emailCheck(email: String): Boolean;
begin
result := FALSE;
   if (POS('@', email) >0) AND (POS('.', email) > 0) then begin
    result := TRUE;
    edtEmail.Color := clWindow;
   end
   else
    edtEmail.Color := clRed;
end;

function TfrmRegistration.phoneCheck(phoneNum: String): Boolean;
begin
result := FALSE;
  if (Length(phoneNum) > 9) AND (phoneNum[4] = '-') AND (phoneNum[8] = '-') then begin
    result := TRUE;
    edtPhone.Color := clWindow;
  end
  else begin
    edtPhone.Color := clRed;
    messageDlg('Format of phone number: 123-456-7890',mtWarning,[mbOk],0);
  end;
end;

function TfrmRegistration.GetAge(const BirthDate, CurrentDate: TDateTime): Integer;
var
    y1, m1, d1: Word; //DoB
    y2, m2, d2: Word; //today
begin
    Result := 0;
    if CurrentDate < BirthDate then Exit;
    DecodeDate(BirthDate, y1, m1, d1);
    DecodeDate(CurrentDate, y2, m2, d2);

    //Fudge someone born on the leap-day to Feb 28th of the same year
    if ((m1=2) AND (d1=29)) AND (not IsLeapYear(y2)) then d1 := 28;

    Result := y2-y1; //rough count of years

    //Take away a year if the month/day is before their birth month/day
    if (m2 < m1) OR ((m2=m1) AND (d2<d1)) then Dec(Result);
end;

function TfrmRegistration.DoBCheck(DoB: TDate; var age: Integer): Boolean;
begin
result := FALSE;
  if (DoB > today) OR (age > 130) then begin
   dtpBirth.Color := clRed;
   messageDlg('Please select a valid date of birth!',mtWarning,[mbOk],0);
  end
  else begin
  dtpBirth.Color := clWindow;
  result := TRUE;
  end;
end;

function TfrmRegistration.shirtSizeCheck(): Boolean;
begin
result := FALSE;
  if cboShirtSizes.ListFieldIndex = -1 then begin
   cboShirtSizes.Color := clRed;
   messageDlg('Please select a shirt size!',mtWarning,[mbOk],0);
  end
  else begin
   cboShirtSizes.Color := clWindow;
   result := TRUE;
  end;
end;

function TfrmRegistration.genderCheck(): Boolean;
begin
result := FALSE;
  if cboGenders.ListFieldIndex = -1 then begin
   cboGenders.Color := clRed;
   messageDlg('Please select a gender!',mtWarning,[mbOk],0);
  end
  else begin
  cboGenders.Color := clWindow;
  result := TRUE;
  end;
end;

function TfrmRegistration.passwordCheck(password: String): Boolean;
begin
result := FALSE;
  if Length(edtPassword.Text) <= 5 then
    messageDlg('Password cannot be less than 5 characters (letters/numbers/symbols)!',mtWarning,[mbOk],0)
  else if Length(edtPassword.Text) > 24 then
    messageDlg('Password cannot exceed 24 characters (letters/numbers/symbols)!',mtWarning,[mbOk],0)
  else
    result := TRUE;
end;

procedure TfrmRegistration.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if frmHome.isValid = FALSE then

    case MessageDlg
      ('You are required to login/register before accessing home!' + #13 + 'Are you sure you want to exit?', mtConfirmation, [mbOk, mbCancel], 0) of
      mrOk:
        Application.Terminate;
      mrCancel:
        CanClose := FALSE;
    end;
end;

procedure TfrmRegistration.FormCreate(Sender: TObject);
begin
  SetWindowRgn(cboGenders.Handle, CreateRectRgn(2, 2, cboGenders.Width - 2,
      cboGenders.Height - 2), True);
  SetWindowRgn(cboShirtSizes.Handle,
    CreateRectRgn(2, 2, cboShirtSizes.Width - 2, cboShirtSizes.Height - 2),
    True);
  SetWindowRgn(dtpBirth.Handle, CreateRectRgn(2, 2, dtpBirth.Width - 2,
      dtpBirth.Height - 2), True);
end;

procedure TfrmRegistration.imgLoginLinkClick(Sender: TObject);
begin
  frmLogin.ShowModal;
end;

procedure TfrmRegistration.imgSignUpClick(Sender: TObject);
begin

if inputValidation then
   BEGIN
    DM2022.tblPlayers['birth'] := DateToStr(dtpBirth.Date);
    frmHome.isValid := TRUE;
    frmHome.userEmail := edtEmail.Text;
    MessageDlg('Welcome '+edtFirstName.Text+'!', mtInformation, [mbOk], 0);
    Self.Close;
   END
  else case MessageDlg('An error has occured!', mtWarning, [mbOk,mbAbort], 0) of
  mrAbort:
   Application.Terminate;
  end;

end;

function TfrmRegistration.inputValidation: Boolean;
var age: Integer;
begin
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
end;


end.
