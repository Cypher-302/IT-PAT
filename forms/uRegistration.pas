unit uRegistration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, DBCtrls, StdCtrls, Mask, Buttons, ExtCtrls, uDM2022, uLogin,
  pngimage;

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
    edtBirth: TDBEdit;
    edtPassword: TEdit;
    imgSignUp: TImage;
    imgLoginLink: TImage;
    procedure FormCreate(Sender: TObject);
    procedure imgLoginLinkClick(Sender: TObject);
    procedure imgSignUpClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    isValid : Boolean;
  end;

var
  frmRegistration: TfrmRegistration;

implementation

{$R *.dfm}

procedure TfrmRegistration.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (frmLogin.isAdmin = FALSE) AND (frmLogin.isUser = FALSE) AND (isValid = FALSE) then

  case MessageDlg('You are required to login/register before accessing home!' + #13 +
      'Are you sure you want to exit?', mtConfirmation, [mbOk, mbCancel], 0) of
    mrOk:
      Application.Terminate;
    mrCancel:
      CanClose := FALSE;
  end;
end;

procedure TfrmRegistration.FormCreate(Sender: TObject);
begin
   SetWindowRgn(cboGenders.Handle, CreateRectRgn(2,2,cboGenders.Width - 2,cboGenders.Height - 2), True);
   SetWindowRgn(cboShirtSizes.Handle, CreateRectRgn(2,2,cboShirtSizes.Width - 2,cboShirtSizes.Height - 2), True);
   SetWindowRgn(dtpBirth.Handle, CreateRectRgn(2,2,dtpBirth.Width - 2,dtpBirth.Height - 2), True);

   isValid := FALSE;
end;

procedure TfrmRegistration.imgLoginLinkClick(Sender: TObject);
begin
frmLogin.ShowModal;
end;

procedure TfrmRegistration.imgSignUpClick(Sender: TObject);
begin
isValid := TRUE;
showMessage('works');
end;

end.
