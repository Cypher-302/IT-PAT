unit uForgotPassword;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDBDisplay, DBCtrls, DateUtils, pngimage, ExtCtrls, ComCtrls,
  StdCtrls, Mask;

type
  TfrmForgotPassword = class(TForm)
    imgBackground: TImage;
    imgSignUp: TImage;
    edtEmail: TEdit;
    procedure imgSignUpClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmForgotPassword: TfrmForgotPassword;

implementation
uses uHome, uDM2022;
{$R *.dfm}

procedure TfrmForgotPassword.FormActivate(Sender: TObject);
begin
edtEmail.Text := frmHome.userEmail;
end;

procedure TfrmForgotPassword.imgSignUpClick(Sender: TObject);
begin
if DM2022.tblPlayers.Locate('email',edtEmail.Text,[]) = TRUE then BEGIN
 frmHome.userEmail:= edtEmail.Text;
 frmHome.logChange('requests a password change!');
 messageDlg('A message has been sent to the admin.',mtInformation,[mbOk],0);
END
else messageDlg('Email entered does not exist in the database'+#13+
'Please check your entered Email for typos or register a new account.'
,mtWarning,[mbOk],0);
end;

end.
