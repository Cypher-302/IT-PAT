program example;

uses
  Forms,

  uMain in 'forms\uMain.pas' {frmMain},
  uLogin in 'forms\uLogin.pas' {frmLogin},
  uDM2022 in 'forms\uDM2022.pas' {DM2022: TDataModule},
  uRegistration in 'forms\uRegistration.pas' {frmRegistration},
  uDBDisplay in 'forms\uDBDisplay.pas' {frmDBDisplay},
  uHome in 'forms\uHome.pas' {frmHome};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmHome, frmHome);
  Application.CreateForm(TfrmQuestion2, frmQuestion2);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TDM2022, DM2022);
  Application.CreateForm(TfrmRegistration, frmRegistration);
  Application.CreateForm(TfrmDBDisplay, frmDBDisplay);
  Application.Run;
end.
