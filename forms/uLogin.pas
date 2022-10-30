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

uses uRegistration, uHome, uForgotPassword;
{$R *.dfm}

procedure TfrmLogin.chkAdminClick(Sender: TObject); //checks if the admin checkbox is selected,
begin                                               //then does the relevant processing
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

procedure TfrmLogin.FormActivate(Sender: TObject);    //assigns variable default values
begin
  isAdminSlc := FALSE;
  isAdmin := FALSE;
end;

procedure TfrmLogin.imgbtnLoginClick(Sender: TObject);         //detects if the user has entered the right password,
begin                                                          //if they have selected that they are an admin
  if (isAdminSlc = TRUE) AND (edtPassword.Text = 'admin') then //also checks if the inputted email and password exist and match,
  begin                                                        //if they have not specified that they are an admin
    messageDlg('Welcome admin.', mtInformation, [mbOk], 0);    //displays relevant error messages, and updates global variables
    isAdmin := TRUE;                                           //to show whether the user is an Admin/ if they are a user, their email
    frmHome.isValid := TRUE;
    Self.Close;
    frmRegistration.Close;
  end
  else if (isAdminSlc = TRUE) AND NOT(edtPassword.Text = 'admin') then
    messageDlg('Password is incorrect!',mtWarning,[mbOk],0);

  if not(isAdminSlc) AND (DM2022.tblPlayers.Locate('email', edtEmail.Text,[]) = TRUE) then begin
  DM2022.tblPlayers.Locate('email', edtEmail.Text,[]);
  BEGIN
    if (edtPassword.Text = DM2022.tblPlayers['password']) then
    begin
      messageDlg('Welcome ' + DM2022.tblPlayers['first_name'] + '!',mtInformation, [mbOk], 0);
      frmHome.isValid := TRUE;
      frmHome.userEmail := DM2022.tblPlayers['email'];
      Self.Close;
      frmRegistration.Close;
    end
    else begin
      messageDlg('Password is incorrect!',mtWarning,[mbOk],0);
      case messageDlg('Do you want to reset your password?',mtInformation,[mbYes,mbNo],0) of
      mrYes: BEGIN
              frmHome.userEmail := edtEmail.Text;
              frmForgotPassword.showModal;
             END;
      end;
    end;
  END
  end
  else if not(isAdminSlc) AND (DM2022.tblPlayers.Locate('email',edtEmail.Text, []) = FALSE) then
    messageDlg('Email was not found!',mtWarning,[mbOk],0);

end;

end.
