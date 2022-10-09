unit uDBDisplay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  DBGrids, pngimage, ExtCtrls, StdCtrls, Grids, jpeg, CheckLst, Dialogs, uDM2022, uLogin, Menus, uRegistration;

type
  TfrmDBDisplay = class(TForm)
    imgBackground: TImage;
    dbgMembers: TDBGrid;
    dbgGames: TDBGrid;
    btnFirst: TButton;
    btnPrior: TButton;
    btnNext: TButton;
    btnLast: TButton;
    rdDisplay: TRadioGroup;
    popupDBGrids: TPopupMenu;
    clkInsert: TMenuItem;
    clkEdit: TMenuItem;
    clkDelete: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure rdDisplayClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
    procedure btnFirstClick(Sender: TObject);
    procedure btnLastClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure clkInsertClick(Sender: TObject);
    procedure clkEditClick(Sender: TObject);
    procedure clkDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDBDisplay : TfrmDBDisplay;

  dbGamesEn, dbMembersEn : Boolean;
  selectTBL : String;

  dbColor : TColor;

implementation

{$R *.dfm}

procedure TfrmDBDisplay.btnFirstClick(Sender: TObject);
begin
    if dbGamesEn
      then DM2022.tblGames.First
    else if dbMembersEn
      then DM2022.tblPlayers.First
    else messageDlg('Please select a table to display', mtInformation, [mbOK], 0);
end;

procedure TfrmDBDisplay.btnInsertClick(Sender: TObject);
begin
frmLogin.ShowModal;
end;

procedure TfrmDBDisplay.btnLastClick(Sender: TObject);
begin
    if dbGamesEn
      then DM2022.tblGames.Last
    else if dbMembersEn
      then DM2022.tblPlayers.Last
    else messageDlg('Please select a table to display', mtInformation, [mbOK], 0);
end;

procedure TfrmDBDisplay.btnNextClick(Sender: TObject);
begin

//  DM2022.tblPlayers.;
{    if dbGamesEn
      then DM2022.tblGames.Next
    else if dbMembersEn
      then DM2022.tblPlayers.Next
    else messageDlg('Please select a table to display', mtInformation, [mbOK], 0);  }
end;

procedure TfrmDBDisplay.btnPriorClick(Sender: TObject);
begin
    if dbGamesEn
      then DM2022.tblGames.Prior
    else if dbMembersEn
      then DM2022.tblPlayers.Prior
    else messageDlg('Please select a table to display', mtInformation, [mbOK], 0);
end;

procedure TfrmDBDisplay.clkDeleteClick(Sender: TObject);
begin
//e
end;

procedure TfrmDBDisplay.clkEditClick(Sender: TObject);
begin
//e
end;

procedure TfrmDBDisplay.clkInsertClick(Sender: TObject);
begin
try
DM2022.tblPlayers.Insert;

frmRegistration.ShowModal;

DM2022.tblPlayers.Post;
except
  messageDlg('Unable to insert new registration',mtWarning,[mbOk],0);
end;
end;

function HexToTColor(sColor : string) : TColor;
begin
   Result :=
     RGB(
       StrToInt('$'+Copy(sColor, 1, 2)),
       StrToInt('$'+Copy(sColor, 3, 2)),
       StrToInt('$'+Copy(sColor, 5, 2))
     ) ;
end;

//-------------------------------------------------------

procedure TfrmDBDisplay.FormActivate(Sender: TObject);
var iLoop : Integer;
begin

dbColor := HexToTColor('B6D6CC');
dbgMembers.Columns[8].Visible := FALSE;
for iLoop := 0 to 7 do dbgMembers.Columns[iLoop].Color := dbColor;
for iLoop := 0 to 5 do dbgGames.Columns[iLoop].Color := dbColor;

dbgMembers.Visible := False;
dbgGames.Visible := False;
dbMembersEn := False;
dbGamesEn := False;

end;

procedure TfrmDBDisplay.rdDisplayClick(Sender: TObject);
begin
  if (rdDisplay.ItemIndex = 0)
    then begin
      dbgMembers.Visible := True;
      selectTBL := 'tblMembers';
        end
  else if ((rdDisplay.ItemIndex = 0) = FALSE)
    then begin
      dbgMembers.Visible := False;
      dbMembersEn := False;
        end;

  if (rdDisplay.ItemIndex = 1)
    then begin
      dbgGames.Visible := True;
      dbGamesEn := True;
        end
  else if ((rdDisplay.ItemIndex = 1) = FALSE)
    then begin
      dbgGames.Visible := False;
      dbGamesEn := False;
        end;

end;

end.
