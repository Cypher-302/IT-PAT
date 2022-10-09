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
  end;

var
  frmLogin: TfrmLogin;
  isAdmin, isAdminLocal : Boolean;

implementation

{$R *.dfm}

procedure TfrmLogin.chkAdminClick(Sender: TObject);
begin
if (chkAdmin.Checked)
 then
    BEGIN
      isAdminLocal := TRUE;
      edtEmail.Text := 'Enter Admin password in the correct field to continue';
      edtEmail.ReadOnly := TRUE;
      edtEmail.Enabled := FALSE;
      edtPassword.Clear;
      edtPassword.Color := clRed;
      edtPassword.SetFocus;
    END
 else if not(chkAdmin.Checked)
  then
    BEGIN
      isAdminLocal := FALSE;
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
isAdminLocal := FALSE;
end;

procedure TfrmLogin.imgbtnLoginClick(Sender: TObject);
var DBPass : String;
begin
  if (isAdminLocal = TRUE) AND (edtPassword.Text = 'admin') then showMessage('Thou ist an ADMIN!');
  if not(isAdminLocal) AND (DM2022.tblPlayers.Locate('email',edtEmail.Text,[]) = TRUE) then
    BEGIN
      DBPass := DM2022.tblPlayers['Password'];
      if (DBPass = edtPassword.Text) then showMessage('Welcome' + DM2022.tblPlayers['first_name'] +'!');

    END;

end;

end.
