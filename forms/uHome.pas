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

uses uDBDisplay, uRegistration, uLogin, uDM2022;

procedure TfrmHome.btnChangelogClick(Sender: TObject); //makes redOut visible and then,
var sLine : String;                                    //outputs the changelog tf to redOut
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

procedure TfrmHome.FormActivate(Sender: TObject);     //shows the registration form upon activation of the Home form,
begin                                                 //given that the user has not logged in yet
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

procedure TfrmHome.logChange(input: String);      //allows the user to write to the changelog tf
var tf: TextFile;                                 //from anywhere in the program, changelog tf
    userID: Integer;                              //keeps track of all changes made to the database
begin                                             //and the user that made the changes
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
