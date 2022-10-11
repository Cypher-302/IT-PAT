unit uLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls, Mask, DBCtrls, uDM2022;

type
  TfrmLogin = class(TForm)
    imgLoginbtn: TImage;
    imgLogin: TImage;
    imgbtnLogin: TImage;
    chkAdmin: TCheckBox;
    edtEmail: TEdit;
    edtPassword: TEdit;
    procedure chkAdminClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure imgbtnLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    isAdmin: Boolean;
  end;

var
  frmLogin: TfrmLogin;
  isAdminSlc: Boolean;

implementation

uses uRegistration, uHome;
{$R *.dfm}

procedure TfrmLogin.chkAdminClick(Sender: TObject);
begin
  if (chkAdmin.Checked) then
  BEGIN
    isAdminSlc := TRUE;
    edtEmail.Text := 'Enter Admin password in the correct field to continue';
    edtEmail.ReadOnly := TRUE;
    edtEmail.Enabled := FALSE;
    edtPassword.Clear;
    edtPassword.Color := clHighlight;
    edtPassword.SetFocus;
  END
  else if not(chkAdmin.Checked) then
  BEGIN
    isAdminSlc := FALSE;
    edtEmail.Clear;
    edtEmail.ReadOnly := FALSE;
    edtEmail.Enabled := TRUE;
    edtPassword.Clear;
    edtPassword.Color := clWindow;
    edtEmail.SetFocus;
  END;

end;

procedure TfrmLogin.FormActivate(Sender: TObject);
begin
  isAdminSlc := FALSE;
  isAdmin := FALSE;
end;

procedure TfrmLogin.imgbtnLoginClick(Sender: TObject);
var
  DBPass: String;
begin
  if (isAdminSlc = TRUE) AND (edtPassword.Text = 'admin') then
  begin
    messageDlg('Welcome admin.', mtInformation, [mbOk], 0);
    isAdmin := TRUE;
    frmHome.isValid := TRUE;
    Self.Close;
    frmRegistration.Close;
  end
  else if (isAdminSlc = TRUE) AND NOT(edtPassword.Text = 'admin') then
    messageDlg('Password is incorrect!',mtWarning,[mbOk],0);

  if not(isAdminSlc) AND (DM2022.tblPlayers.Locate('email', edtEmail.Text,[]) = TRUE) then
  BEGIN
    DBPass := edtPassword.Text;
    if (DM2022.tblPlayers.Locate('password', DBPass, []) = TRUE) then
    begin
      messageDlg('Welcome ' + DM2022.tblPlayers['first_name'] + '!',mtInformation, [mbOk], 0);
      frmHome.isValid := TRUE;
      frmHome.userEmail := DM2022.tblPlayers['email'];
      Self.Close;
      frmRegistration.Close;
    end
    else
      messageDlg('Password is incorrect!',mtWarning,[mbOk],0);
  END
  else if not(isAdminSlc) AND (DM2022.tblPlayers.Locate('email',edtEmail.Text, []) = FALSE) then
    messageDlg('Email was not found!',mtWarning,[mbOk],0);

end;

end.
