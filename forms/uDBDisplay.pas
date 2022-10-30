unit uDBDisplay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  DBGrids, pngimage, ExtCtrls, StdCtrls, Grids, jpeg, CheckLst, Dialogs,
  Menus, uRegistration, DB, ADODB, DBCtrls;

type
  TfrmDBDisplay = class(TForm)
    imgBackground: TImage;
    dbgDisplay: TDBGrid;
    btnFirst: TButton;
    btnPrior: TButton;
    btnNext: TButton;
    btnLast: TButton;
    rdDisplay: TRadioGroup;
    popupDBGrids: TPopupMenu;
    clkInsert: TMenuItem;
    clkEdit: TMenuItem;
    clkDelete: TMenuItem;
    btnSort: TButton;
    btnSearch: TButton;
    cmbFilter: TComboBox;
    btnRefresh: TButton;
    btnPodium: TImage;
    Button2: TButton;
    Button1: TButton;
    procedure FormActivate(Sender: TObject);
    procedure rdDisplayClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
    procedure btnFirstClick(Sender: TObject);
    procedure btnLastClick(Sender: TObject);
    procedure clkInsertClick(Sender: TObject);
    procedure clkEditClick(Sender: TObject);
    procedure clkDeleteClick(Sender: TObject);
    procedure updateCol();
    procedure FitGrid(Grid: TDBGrid);
    procedure refresh(dbgDS: TDataSource);
    procedure btnDelete1000Click(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure cmbFilterChange(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnPodiumClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    function accessToRecord():Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
    sSQL : String;
    procedure runSQL(sSQL: String);
    procedure Tabs;
  end;

var
  frmDBDisplay: TfrmDBDisplay;
//  DataSrc : TDataSource;
  selectedDB: TADOTable;
  dbColor: TColor;
  columnsAMT: Integer;

implementation
uses uEdit, uAddTournament, uEditTournament, uDM2022, uLogin, uHome;

{$R *.dfm}
 //   sSQL := '';       self.runSQL(sSQL);
procedure TfrmDBDisplay.runSQL(sSQL: String);
begin
  DM2022.qry.SQL.Clear;
  DM2022.qry.SQL.ADD(sSQL);
  DM2022.qry.Open;
  Tabs();
end;

procedure TfrmDBDisplay.Tabs;
begin
  refresh(DM2022.dbsSQL);
end;

procedure TfrmDBDisplay.btnFirstClick(Sender: TObject);
begin
  if dbgDisplay.DataSource = DM2022.dbsSQL then
  DM2022.qry.First
  else selectedDB.First;
end;

procedure TfrmDBDisplay.btnLastClick(Sender: TObject);
begin
  if dbgDisplay.DataSource = DM2022.dbsSQL then
  DM2022.qry.Last
  else selectedDB.Last;
end;

procedure TfrmDBDisplay.btnNextClick(Sender: TObject);
begin
  if dbgDisplay.DataSource = DM2022.dbsSQL then
  DM2022.qry.Next
  else selectedDB.Next;
end;

procedure TfrmDBDisplay.btnPriorClick(Sender: TObject);
begin
  if dbgDisplay.DataSource = DM2022.dbsSQL then
  DM2022.qry.Prior
  else selectedDB.Prior;
end;

procedure TfrmDBDisplay.btnPodiumClick(Sender: TObject);
var winner_score: Array of Integer;
    winner_name : Array of String;
    iLoop, iLoop2       : Integer;
    len, iTemp: Integer;
    sTemp : String;
begin
iLoop := 1;

while not DM2022.tblGames.Eof do with DM2022 do
 if tblGames.Locate ('id',iLoop,[]) = TRUE then
 BEGIN
  tblGames.Edit;
   if tblGames['winner'] = null then
   if tblGames['player1_score'] > tblGames['player2_score']
    THEN tblGames['winner'] := 'player1_id'
    ELSE
     if tblGames['player1_score'] < tblGames['player2_score']
      then tblGames['winner'] := 'player2_id'
      else tblGames['winner'] := 'Draw';
  tblGames.Post;
  tblGames.Next;
  INC(iLoop);
 END
 else INC(iLoop);


 with frmDBDisplay do begin

   sSQL := 'SELECT TOP 3 *' +
           ' FROM (SELECT players.ID,players.first_name, players.last_name, Count(games.winner) AS Wins' +
           ' FROM players' +
           ' INNER JOIN games ON players.ID = games.player1_id' +
           ' WHERE ((games.[winner]) LIKE "player1_id")' +
           ' GROUP BY players.ID,players.first_name, players.last_name' +
           ' UNION' +
           ' SELECT players.ID,players.first_name, players.last_name, Count(games.winner) AS Wins' +
           ' FROM players' +
           ' INNER JOIN games ON players.ID = games.player2_id' +
           ' WHERE ((games.[winner]) LIKE "player2_id")' +
           ' GROUP BY players.ID,players.first_name, players.last_name' +
           ' ORDER BY Wins DESC)  AS T;';
   runSQL(sSQL);

 end;

end;

procedure TfrmDBDisplay.btnRefreshClick(Sender: TObject);
begin
rdDisplayClick(rdDisplay);
end;

procedure TfrmDBDisplay.btnSearchClick(Sender: TObject);
var sFind : String;
begin
  sFind := QuotedStr(InputBox('First name','Enter search below: ','Babita'));
  sSQL := 'SELECT * FROM players WHERE first_name LIKE '+sFind;
  self.runSQL(sSQL);
end;

procedure TfrmDBDisplay.Button1Click(Sender: TObject);
begin
btnPodiumClick(Sender);
end;

procedure TfrmDBDisplay.Button2Click(Sender: TObject);
var tf: TextFile;
    iLoop: Integer;
    selectedDS : TDataSet;
    aLine: String;
begin
  AssignFile(tf, '.\reports\report2.txt');
  ReWrite(tf);
  selectedDS := dbgDisplay.DataSource.DataSet;
  //DM2022.qry.SaveToFile('.\reports\report2.txt',pfXML);
  //while not DM2022.qry.eof do
  //writeln(tf, DM2022.qry.
  //writeln(tf, DM2022.dbsSQL.ToString);
        while not selectedDS.Eof do
      begin
        for iLoop := 0 to dbgDisplay.Columns.Count - 1 do
        begin
          if Assigned(dbgDisplay.Columns[iLoop].Field) then
          begin
            aLine := dbgDisplay.Columns[iLoop].Field.FieldName+#9;
          end;
        end;
        writeln(tf, aLine);
        selectedDS.Next;
      end;
  CloseFile(tf);
end;

procedure TfrmDBDisplay.cmbFilterChange(Sender: TObject);
var sFind, sField, sTable : String;
begin
  sField := cmbFilter.Items[cmbFilter.ItemIndex];
  sFind := QuotedStr(InputBox('Filter','Enter filter item for: '+sField,''));

  if selectedDB = DM2022.tblGames then sTable := 'games'
  else sTable := 'players';

  sSQL := 'SELECT * FROM '+sTable+' WHERE '+sField+' LIKE '+sFind;
  self.runSQL(sSQL);
end;

procedure TfrmDBDisplay.btnDelete1000Click(Sender: TObject);
var
  id: Integer;
begin
  DM2022.tblPlayers.Last;
  id := DM2022.tblPlayers['ID'];

  while (id > 1000) do
  begin
    DM2022.tblPlayers.Delete;
    showMessage('Deleted record with ID: ' + IntToStr(id));

    DM2022.tblPlayers.Last;
    id := DM2022.tblPlayers['ID'];
  end;
end;

function TfrmDBDisplay.accessToRecord: Boolean;
var email, email2: String;
begin
result := FALSE;
 if frmLogin.isAdmin then result := TRUE;

 if dbgDisplay.DataSource = DM2022.dbsPlayers
  then if selectedDB['email'] = frmHome.userEmail
   then result := TRUE;

 if dbgDisplay.DataSource = DM2022.dbsGames then
  begin
   DM2022.tblPlayers.Locate('ID', selectedDB['player1_id'],[]);
   email := DM2022.tblPlayers['email'];
   DM2022.tblPlayers.Locate('ID', selectedDB['player2_id'],[]);
   email2 := DM2022.tblPlayers['email'];
   if (frmHome.userEmail = email) OR (frmHome.userEmail = email2)
    then result := TRUE;
  end;
end;

procedure TfrmDBDisplay.clkDeleteClick(Sender: TObject);
begin
 if not(accessToRecord) then messageDlg('In order to delete records:'+#13+
 'The selected record must be yours, or'+#13+'You must be logged in as an Admin'
 , mtInformation, [mbOk], 0)
 else
  case messageDlg('Are you sure that you want to delete this record?',
    mtConfirmation, [mbYes, mbNo], 0) of
    mrYes: begin
            selectedDB.Delete;
            messageDlg('Record deleted.', mtInformation, [mbOk], 0);
           end;
    mrNo:
      messageDlg('Record deletion cancelled.', mtInformation, [mbOk], 0);
  end;
end;

procedure TfrmDBDisplay.clkEditClick(Sender: TObject);

begin
 if not(accessToRecord) then messageDlg('In order to edit records:'+#13+
 'The selected record must be yours, or'+#13+'You must be logged in as an Admin'
 , mtInformation, [mbOk], 0)
 else
  try
    selectedDB.Edit;
     if dbgDisplay.DataSource = DM2022.dbsGames
      then frmEditTournament.ShowModal
      else frmEdit.ShowModal;
    selectedDB.Post;
    //changelog - Insert
  except
    messageDlg('Unable to insert new registration', mtWarning, [mbOk], 0);
  end;
end;

procedure TfrmDBDisplay.clkInsertClick(Sender: TObject);
begin
if not frmLogin.isAdmin then messageDlg('You need to be logged in as an admin to insert!',mtWarning, [mbOk], 0)
else
  try
    selectedDB.Insert;
    if selectedDB = DM2022.tblPlayers
     then frmRegistration.ShowModal
     else frmAddTournament.ShowModal;
    selectedDB.Post;
  except
    messageDlg('Unable to insert new registration!'+#13+
    'Please ensure that you have either the members or players database selected.',
    mtWarning, [mbOk], 0);
  end;
end;

function HexToTColor(sColor: string): TColor;
begin
  Result := RGB(StrToInt('$' + Copy(sColor, 1, 2)),
    StrToInt('$' + Copy(sColor, 3, 2)), StrToInt('$' + Copy(sColor, 5, 2)));
end;

// -------------------------------------------------------

procedure TfrmDBDisplay.FitGrid(Grid: TDBGrid);
const pixSpc = 5;
var
  selectedDS: TDataSet;
  currentPOS: TBookmark;
  iLoop: Integer;
  width: Integer;
  arrCol: Array of Integer;
begin
  selectedDS := Grid.DataSource.DataSet;
  if Assigned(selectedDS) then
  begin
    selectedDS.DisableControls;
    currentPOS := selectedDS.GetBookmark;
    try
      selectedDS.First;
      SetLength(arrCol, Grid.Columns.Count);
      while not selectedDS.Eof do
      begin
        for iLoop := 0 to Grid.Columns.Count - 1 do
        begin
          if Assigned(Grid.Columns[iLoop].Field) then
          begin
            width:=  Grid.Canvas.TextWidth(selectedDS.FieldByName(Grid.Columns[iLoop].Field.FieldName).DisplayText);
            if arrCol[iLoop] < width  then
               arrCol[iLoop] := width;
          end;
        end;
        selectedDS.Next;
      end;

	    selectedDS.GotoBookmark(currentPOS);
      for iLoop:= 0 to Grid.Columns.Count - 1 do
        if arrCol[iLoop] < Grid.Canvas.TextWidth(Grid.Columns[iLoop].Field.FieldName) then
         Grid.Columns[iLoop].Width := Grid.Canvas.TextWidth(Grid.Columns[iLoop].Field.FieldName) + pixSpc
        else
         Grid.Columns[iLoop].Width := arrCol[iLoop] + pixSpc;

    finally
      selectedDS.FreeBookmark(currentPOS);
      selectedDS.EnableControls;
    end;
  end;
end;

procedure TfrmDBDisplay.FormActivate(Sender: TObject);
begin

  dbColor := HexToTColor('B6D6CC');
  refresh(DM2022.dbsPlayers);

end;

procedure TfrmDBDisplay.updateCol();
var iLoop, colWidth : Integer;
begin

  if dbgDisplay.DataSource = DM2022.dbsPlayers then selectedDB := DM2022.tblPlayers
  else if dbgDisplay.DataSource = DM2022.dbsGames then selectedDB := DM2022.tblGames;
 // else if dbgDisplay.DataSource = DM2022.dbsSQL then selectedDB := DM2022.dbsSQL;


  columnsAMT := dbgDisplay.Columns.Count - 1;

  if columnsAMT = 8 then dbgDisplay.Columns[columnsAMT].Visible := FALSE;

  cmbFilter.Items.Clear;
  for iLoop := 0 to columnsAMT do BEGIN
    dbgDisplay.Columns[iLoop].Color := dbColor;
    colWidth := colWidth + dbgDisplay.Columns[iLoop].Width; //finds total width of all columns
    if not(dbgDisplay.Columns[iLoop].Field.FieldName = 'password') then
     cmbFilter.Items.Add(dbgDisplay.Columns[iLoop].Field.FieldName);
  END;
  dbgDisplay.Width := colWidth + 38;
end;

procedure TfrmDBDisplay.rdDisplayClick(Sender: TObject);
begin

  if (rdDisplay.ItemIndex = 0) then
  begin
    dbgDisplay.DataSource := DM2022.dbsPlayers;
    updateCol();
  end;

  if (rdDisplay.ItemIndex = 1) then
  begin
    dbgDisplay.DataSource := DM2022.dbsGames;
    updateCol();
  end;

end;

procedure TfrmDBDisplay.refresh(dbgDS : TDataSource);
begin
  dbgDisplay.DataSource := dbgDS;
  FitGrid(dbgDisplay);
  updateCol();
end;

end.
