unit uHome;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls, uDM2022;

type
  TfrmHome = class(TForm)
    imgHome: TImage;
    btnChangelog: TImage;
    btnPodium: TImage;
    btnViewDB: TImage;
    procedure btnViewDBClick(Sender: TObject);
    procedure btnPodiumClick(Sender: TObject);
    procedure btnChangelogClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    isValid : Boolean;
    userEmail : String;
  end;

var
  frmHome: TfrmHome;

implementation

{$R *.dfm}

uses uDBDisplay, uMain, uRegistration, uLogin;

procedure TfrmHome.btnChangelogClick(Sender: TObject);
begin
  // opens changelog
end;

procedure TfrmHome.btnPodiumClick(Sender: TObject);
begin
  // display Podium Positions
end;

procedure TfrmHome.btnViewDBClick(Sender: TObject);
begin
  frmDBDisplay.ShowModal;
end;

procedure TfrmHome.FormActivate(Sender: TObject);
begin
  if not(isValid) then
  try
    DM2022.tblPlayers.Insert;

    frmRegistration.ShowModal;

    if isValid then DM2022.tblPlayers.Post;
  except
     if not(isValid) then messageDlg('Unable to insert new registration', mtWarning, [mbOk], 0);
  end;
end;

procedure TfrmHome.FormCreate(Sender: TObject);
begin
isValid := FALSE;
end;

end.
