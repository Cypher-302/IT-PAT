unit uHome;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls;

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

procedure TfrmHome.btnPodiumClick(Sender: TObject);
var winner_score: Array of Integer;
    winner_name : Array of String;
    iLoop       : Integer;
begin
iLoop := 0;
DM2022.tblGames.First;
 while not eof(DM2022.tblGames) do BEGIN
  if DM2022.tblGames['winner'] = '' then
   if DM2022.tblGames['player1_score'] > DM2022.tblGames['player2_score']
    THEN DM2022.tblGames['winner'] := DM2022.tblGames['player1_id']
    ELSE
     if DM2022.tblGames['player1_score'] < DM2022.tblGames['player2_score']
      then DM2022.tblGames['winner'] := DM2022.tblGames['player2_id']
      else DM2022.tblGames['winner'] := 'Draw';

  if DM2022.tblGames['winner'] = 'draw' then
  begin
    winner_name[iLoop] := DM2022.tblGames['player1_id'];
    winner_score[iLoop] := winner_score[iLoop] + 0.5;
    INC(iLoop);                                                //SEARCH FOR MULTIPLE OCCURENCES
    winner_name[iLoop] := DM2022.tblGames['player2_id'];
    winner_score[iLoop] := winner_score[iLoop] + 0.5;
  end
  else begin
    winner_name[iLoop] := DM2022.tblGames['winner'];
    winner_score[iLoop] := winner_score[iLoop] + 1;
  end;

DM2022.tblGames.Next;
INC(iLoop);
 END;

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
