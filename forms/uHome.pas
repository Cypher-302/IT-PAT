unit uHome;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls;

type
  TfrmHome = class(TForm)
    imgHome: TImage;
    btnChangelog: TImage;
    btnViewDB: TImage;
    procedure btnViewDBClick(Sender: TObject);
    procedure btnChangelogClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure QuickSort(var A: array of Integer; iLo, iHi: Integer);
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

uses uDBDisplay, uMain, uRegistration, uLogin, uDM2022;

procedure TfrmHome.QuickSort(var A: array of Integer; iLo, iHi: Integer);
 var
   Lo, Hi, Pivot, T: Integer;
 begin
   Lo := iLo;
   Hi := iHi;
   Pivot := A[(Lo + Hi) div 2];
   repeat
     while A[Lo] < Pivot do Inc(Lo);
     while A[Hi] > Pivot do Dec(Hi);
     if Lo <= Hi then
     begin
       T := A[Lo];
       A[Lo] := A[Hi];
       A[Hi] := T;
       Inc(Lo);
       Dec(Hi);
     end;
   until Lo > Hi;
   if Hi > iLo then QuickSort(A, iLo, Hi);
   if Lo < iHi then QuickSort(A, Lo, iHi);
end;

procedure TfrmHome.btnChangelogClick(Sender: TObject);
begin
  // opens changelog
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
  if not(frmLogin.isAdmin) then btnChangelog.Visible := False;

end;

procedure TfrmHome.FormCreate(Sender: TObject);
begin
isValid := FALSE;
end;

end.
