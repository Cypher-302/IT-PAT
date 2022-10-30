unit uHome;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls, ComCtrls;

type
  TfrmHome = class(TForm)
    imgHome: TImage;
    btnChangelog: TImage;
    btnViewDB: TImage;
    redOut: TRichEdit;
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
    procedure logChange(input:String);
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
var sLine : String;
    tf    : TextFile;
begin
 redOut.Visible := TRUE;
 redOut.Clear;
 AssignFile(tf, '.\reports\changelog.txt');
 Reset(tf);
 while not eof(tf) do begin
  Readln(tf, sLine);
  redOut.Lines.Add(sLine);
 end;
 CloseFile(tf);
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

procedure TfrmHome.logChange(input: String);
var tf: TextFile;
    userID: Integer;
begin
AssignFile(tf, '.\reports\changelog.txt');
Append(tf);
if DM2022.tblPlayers.Locate('email',userEmail,[]) = TRUE then
 BEGIN
  DM2022.tblPlayers.Locate('email',userEmail,[]);
  userID:= DM2022.tblPlayers['ID'];
  Writeln(tf, 'User: '+IntToStr(userID)+' '+input);
 END
 else Writeln(tf, 'Admin: '+input);
 CloseFile(tf);
end;

end.
