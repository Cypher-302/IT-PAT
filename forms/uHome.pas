unit uHome;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, uDBDisplay, uMain, StdCtrls, uLogin;

type
  TfrmHome = class(TForm)
    imgHome: TImage;
    btnChangelog: TImage;
    btnPodium: TImage;
    btnViewDB: TImage;
    Button1: TButton;
    Button2: TButton;
    procedure btnViewDBClick(Sender: TObject);
    procedure btnPodiumClick(Sender: TObject);
    procedure btnChangelogClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHome: TfrmHome;

implementation

{$R *.dfm}

procedure TfrmHome.btnChangelogClick(Sender: TObject);
begin
//opens changelog
end;

procedure TfrmHome.btnPodiumClick(Sender: TObject);
begin
//display Podium Positions
end;

procedure TfrmHome.btnViewDBClick(Sender: TObject);
begin
  frmDBDisplay.ShowModal;
end;

procedure TfrmHome.Button1Click(Sender: TObject);
begin
frmQuestion2.ShowModal;
end;

procedure TfrmHome.Button2Click(Sender: TObject);
begin
//frmHome.Enabled := FALSE;

end;

procedure TfrmHome.FormActivate(Sender: TObject);
begin
 frmLogin.ShowModal;
end;

end.
