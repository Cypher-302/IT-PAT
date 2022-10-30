program example;

uses
  Forms,
  uLogin in 'forms\uLogin.pas' {frmLogin},
  uDM2022 in 'forms\uDM2022.pas' {DM2022: TDataModule},
  uRegistration in 'forms\uRegistration.pas' {frmRegistration},
  uDBDisplay in 'forms\uDBDisplay.pas' {frmDBDisplay},
  uHome in 'forms\uHome.pas' {frmHome},
  uEdit in 'forms\uEdit.pas' {frmEdit},
  uEditTournament in 'forms\uEditTournament.pas' {frmEditTournament},
  uAddTournament in 'forms\uAddTournament.pas' {frmAddTournament},
  uMain in 'forms\uMain.pas' {frmAddTournament - not used in project,
   but if I try remove it, everything breaks.},
  uForgotPassword in 'forms\uForgotPassword.pas' {frmForgotPassword};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Tournament';
  Application.CreateForm(TfrmHome, frmHome);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TDM2022, DM2022);
  Application.CreateForm(TfrmRegistration, frmRegistration);
  Application.CreateForm(TfrmDBDisplay, frmDBDisplay);
  Application.CreateForm(TfrmEdit, frmEdit);
  Application.CreateForm(TfrmEditTournament, frmEditTournament);
  Application.CreateForm(TfrmAddTournament, frmAddTournament);
  Application.CreateForm(TfrmForgotPassword, frmForgotPassword);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
