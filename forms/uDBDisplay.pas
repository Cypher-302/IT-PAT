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
    cmbFilter: TComboBox;
    btnRefresh: TButton;
    btnReport: TButton;
    btnPodium: TButton;
    cmbSort: TComboBox;
    cmbSearch: TComboBox;
    btnLoadSQL: TButton;
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
    procedure cmbFilterChange(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnReportClick(Sender: TObject);
    procedure btnPodiumClick(Sender: TObject);
    function accessToRecord():Boolean;
    procedure cmbSortChange(Sender: TObject);
    procedure cmbSearchChange(Sender: TObject);
    procedure btnLoadSQLClick(Sender: TObject);
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
  selectedDB: TADOTable;  //holds the current TADOTable that refers to the datasource displaying in dbgDisplay
  dbColor: TColor;        //NOTE: selectedDB only holds the TADOTable for tblPlayers/tblGames, not the result of qry
  columnsAMT: Integer;

implementation
uses uEdit, uAddTournament, uEditTournament, uDM2022, uLogin, uHome;

{$R *.dfm}

procedure TfrmDBDisplay.runSQL(sSQL: String);   //adds the SQL string to the TADOQuery (qry) in DM2022
begin                                           //runs the SQL, then calls procedure Tabs()
  DM2022.qry.SQL.Clear;
  DM2022.qry.SQL.ADD(sSQL);
  DM2022.qry.Open;
  Tabs();
end;

procedure TfrmDBDisplay.Tabs;                 //updates the dbgDisplay with the result of the SQL
begin
  refresh(DM2022.dbsSQL);
end;

procedure TfrmDBDisplay.btnFirstClick(Sender: TObject); //navigates to the first entry in either qry, tblPlayers or tblGames
begin                                                   //depending on the current datasource displaying in dbgDisplay
  if dbgDisplay.DataSource = DM2022.dbsSQL then
  DM2022.qry.First
  else selectedDB.First;
end;

procedure TfrmDBDisplay.btnLastClick(Sender: TObject); //navigates to the last entry in either qry, tblPlayers or tblGames
begin                                                  //depending on the current datasource displaying in dbgDisplay
  if dbgDisplay.DataSource = DM2022.dbsSQL then
  DM2022.qry.Last
  else selectedDB.Last;
end;

procedure TfrmDBDisplay.btnLoadSQLClick(Sender: TObject);     //loads an SQL command from the relevant filename of a textfile
var sLine,sTotal,fileName,FilePath: String;                   //present in the reports folder
    tf: TextFile;                                             //then runs that SQL command and throws an error if there is one
begin                                                         //displays message upon completion of running SQL if there is no error
fileName:= InputBox('File Name','Enter the name of the file: ','SQL.txt');
filePath:= '.\reports\'+fileName;
if not FileExists(filePath) then begin messageDlg('The path: '+filePath+
' does not point to a file.'+#13+'Ensure that your file is in the "reports" folder'
+' and that you have typed the file name correctly',mtWarning,[mbOk],0);
Exit;
end
 else AssignFile(tf,filePath);
  Reset(tf);
  while not eof(tf) do BEGIN
   Readln(tf, sLine);
   sTotal:= sTotal + sLine + ' ';
  END;
try
 sSQL:= sTotal;
 runSQL(sSQL);
  messageDlg('Ran SQL from file.',mtInformation,[mbOk],0);
except
 messageDlg('Error when running SQL, please check '+fileName+' for errors/typos!',
 mtWarning,[mbOk],0);
end;
end;

procedure TfrmDBDisplay.btnNextClick(Sender: TObject);//navigates to the next entry in either qry, tblPlayers or tblGames
begin                                                 //depending on the current datasource displaying in dbgDisplay
  if dbgDisplay.DataSource = DM2022.dbsSQL then
  DM2022.qry.Next
  else selectedDB.Next;
end;

procedure TfrmDBDisplay.btnPriorClick(Sender: TObject);//navigates to the previous entry in either qry, tblPlayers or tblGames
begin                                                  //depending on the current datasource displaying in dbgDisplay
  if dbgDisplay.DataSource = DM2022.dbsSQL then
  DM2022.qry.Prior
  else selectedDB.Prior;
end;

procedure TfrmDBDisplay.btnRefreshClick(Sender: TObject); //refreshes the data displayed in dbgDisplay
begin
rdDisplayClick(rdDisplay);
end;

procedure TfrmDBDisplay.btnPodiumClick(Sender: TObject);  //checks if there are records with an empty winner slot
var winner_score: Array of Integer;                       //in table "games", if there are, it fills that with the winner/"Draw"
    winner_name : Array of String;                        //then runs SQL to display the TOP 3 POSITIONS (podium positions)
    iLoop, iLoop2       : Integer;                        // with their name, id and amount of wins
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

procedure TfrmDBDisplay.btnReportClick(Sender: TObject);       //writes the current data displayed in dbgDisplay
var tf: TextFile;                                              //it does not matter if the data is a result of a query or
    iLoop: Integer;                                            //directly from the database, as it takes the fieldnames from
    isFiltered: Boolean;                                       //the name of each column
    sLine,sHeader,sItem: String;                               //this is then run through a loop to write every column and row
begin                                                          //presently displayed in dbgDisplay to the textfile
  isFiltered := FALSE;                                         //accounts for columns that contain integers or dates
  AssignFile(tf, '.\reports\report2.txt');                     //adds extra tab spacing in the case of "Male" being displayed
  ReWrite(tf);                                                 //to improve readablity of the textfile.
  for iLoop := 0 to cmbFilter.Items.Count                      //A heading, containing all present columns, is written to the textfile
   do sHeader := sHeader+cmbFilter.Items[iLoop]+#9;            //before every other line.
                                                               //displays a message upon confirmation
Writeln(tf,sHeader);
 if dbgDisplay.DataSource = DM2022.dbsSQL then isFiltered := TRUE;

with DM2022 do begin
 if isFiltered
  then BEGIN
   qry.First;
   while not qry.Eof do
    begin
     for iLoop := 0 to cmbFilter.Items.Count-1 do
      BEGIN
       sItem := cmbFilter.Items[iLoop];
       if (sItem = 'ID') OR (sItem = 'id') OR (sItem = 'player1_id') OR
       (sItem = 'player2_id') OR (sItem = 'player1_score') OR
       (sItem = 'player2_score') OR (sItem = 'Wins')
        then sLine := sLine + IntToStr(qry[sItem]) + #9
        else if (sItem = 'birth')
         then sLine := sLine + DateToStr(qry[sItem]) + #9
        else if (sItem = 'gender') AND (qry[sItem] = 'Male')
         then sLine := sLine + qry[sItem] + #9 + #9
        else sLine := sLine + qry[sItem] + #9;
      END;
   WriteLn(tf, sLine);
   sLine:= '';
   qry.Next;
  end;
  END
  else BEGIN
   selectedDB.First;
   while not selectedDB.Eof do
    begin
     for iLoop := 0 to cmbFilter.Items.Count-1 do
      BEGIN
       sItem := cmbFilter.Items[iLoop];
       if (sItem = 'ID') OR (sItem = 'id') OR (sItem = 'player1_id') OR
       (sItem = 'player2_id') OR (sItem = 'player1_score') OR
       (sItem = 'player2_score')
        then sLine := sLine + IntToStr(selectedDB[sItem]) + #9
        else if (sItem = 'birth')
         then sLine := sLine + DateToStr(selectedDB[sItem]) + #9
        else if (sItem = 'gender') AND (selectedDB[sItem] = 'Male')
         then sLine := sLine + selectedDB[sItem] + #9 + #9
        else sLine := sLine + selectedDB[sItem] + #9;
       END;
     WriteLn(tf, sLine);
     sLine:= '';
     selectedDB.Next;
    end;
  END;
end;
  messageDlg('Succesfully wrote to TextFile.',mtInformation,[mbOk],0);
  CloseFile(tf);
end;

procedure TfrmDBDisplay.cmbFilterChange(Sender: TObject);   //allows the user to filter for any text within any column
var sFind, sField, sTable : String;                         //in the displayed table of the database (tblGames/tblPlayers)
begin                                                       //done through a combobox selection and inputbox
  sField := cmbFilter.Items[cmbFilter.ItemIndex];
  sFind := QuotedStr(InputBox('Filter','Enter filter item for: '+sField,''));

  if selectedDB = DM2022.tblGames then sTable := 'games'
  else sTable := 'players';

  sSQL := 'SELECT * FROM '+sTable+' WHERE '+sField+' LIKE '+sFind;
  self.runSQL(sSQL);
end;

procedure TfrmDBDisplay.cmbSearchChange(Sender: TObject); //allows the user to search for any text within any column
var sFind, sField, sTable : String;                       //in the displayed table of the database (tblGames/tblPlayers)
begin                                                     //done through a combobox selection and inputbox
  sField := cmbSearch.Items[cmbSearch.ItemIndex];
  sFind := QuotedStr(InputBox('Search','Enter search item for: '+sField,''));

  if selectedDB = DM2022.tblGames then sTable := 'games'
  else sTable := 'players';

  sSQL := 'SELECT * FROM '+sTable+' WHERE '+sField+' LIKE '+sFind;
  self.runSQL(sSQL);
end;

procedure TfrmDBDisplay.cmbSortChange(Sender: TObject); //allows the user to choose to sort by Ascending or Descending
var sType, sTable, sField : String;                     //for any column in the displayed table of the database (tbllGames/tblPlayers)
begin                                                   //done through a combobox selection and inputbox
  sField := cmbSort.Items[cmbSort.ItemIndex];
  sType := InputBox('Sorting','Do you want to sort by Ascending or Descending: ','Ascending');

  if sType = 'Ascending'
   then sType := 'ASC'
  else if sType = 'Descending'
   then sType := 'DESC'
  else begin
   messageDlg('Please input either "Ascending" or "Descending"',mtWarning,[mbOk],0);
   Exit;
  end;

  if selectedDB = DM2022.tblGames
   then sTable := 'games'
   else sTable := 'players';

  sSQL := 'SELECT * FROM '+sTable+' ORDER BY '+sField +' '+ sType;
  self.runSQL(sSQL);
end;

function TfrmDBDisplay.accessToRecord: Boolean;      //checks if the user is allowed to edit the current record
var email, email2: String;                           //(if Admin, then allowed) (if userEmail matches the ID being edited, then allowed)
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

procedure TfrmDBDisplay.clkDeleteClick(Sender: TObject);  //allows the user to delete a record in the currently displayed table,
begin                                                     //given that they are authorised to, and confirm deletion
 if not(accessToRecord) then messageDlg('In order to delete records:'+#13+
 'The selected record must be yours, or'+#13+'You must be logged in as an Admin'
 , mtInformation, [mbOk], 0)
 else
  case messageDlg('Are you sure that you want to delete this record?',
    mtConfirmation, [mbYes, mbNo], 0) of
    mrYes: begin
            selectedDB.Delete;
            messageDlg('Record deleted.', mtInformation, [mbOk], 0);
            if selectedDB = DM2022.tblPlayers
             then frmHome.logChange('Deleted record in tblPlayers.')   //writes to the changelog upon deletion
             else if selectedDB = DM2022.tblGames
              then frmHome.logChange('Deleted record in tblGames.');
           end;
    mrNo:
      messageDlg('Record deletion cancelled.', mtInformation, [mbOk], 0);
  end;
end;

procedure TfrmDBDisplay.clkEditClick(Sender: TObject);  //allows the user to edit a record in the currently displayed table,
                                                        //given that they are authorised to, and confirm deletion
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

    if selectedDB = DM2022.tblPlayers
     then frmHome.logChange('Edited record in tblPlayers.')     //writes to the changelog upon deletion
    else if selectedDB = DM2022.tblGames
     then frmHome.logChange('Edited record in tblGames.');
  except
    messageDlg('Unable to insert new registration', mtWarning, [mbOk], 0);
  end;
end;

procedure TfrmDBDisplay.clkInsertClick(Sender: TObject);   //allows the user to edit a record in the currently displayed table,
begin                                                      //given that they are an admin
if not frmLogin.isAdmin then messageDlg('You need to be logged in as an admin to insert!',mtWarning, [mbOk], 0)
else
  try
    selectedDB.Insert;
    if selectedDB = DM2022.tblPlayers
     then frmRegistration.ShowModal
     else frmAddTournament.ShowModal;
    selectedDB.Post;

    if selectedDB = DM2022.tblPlayers
     then frmHome.logChange('Inserted record into tblPlayers.')     //writes to the changelog upon deletion
    else if selectedDB = DM2022.tblGames
     then frmHome.logChange('Inserted record into tblGames.');
  except
    messageDlg('Unable to insert new registration!'+#13+
    'Please ensure that you have either the members or players database selected.',
    mtWarning, [mbOk], 0);
  end;
end;

function HexToTColor(sColor: string): TColor;         //takes input of RGB colour, transforms into delphi recoignised colour
begin
  Result := RGB(StrToInt('$' + Copy(sColor, 1, 2)),
    StrToInt('$' + Copy(sColor, 3, 2)), StrToInt('$' + Copy(sColor, 5, 2)));
end;

// -------------------------------------------------------

procedure TfrmDBDisplay.FitGrid(Grid: TDBGrid);  //fits each column to the minimum needed pixels, described in arrays writeup of PAT Phase 1
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

procedure TfrmDBDisplay.FormActivate(Sender: TObject);  //refreshes the Display and gets the colour used for the fields of dbgDisplay
begin

  dbColor := HexToTColor('B6D6CC');
  refresh(DM2022.dbsPlayers);

end;

procedure TfrmDBDisplay.updateCol(); //assigns selectedDB, depending on the datasource of dbgDisplay
var iLoop, colWidth : Integer;
begin

  if dbgDisplay.DataSource = DM2022.dbsPlayers then selectedDB := DM2022.tblPlayers
  else if dbgDisplay.DataSource = DM2022.dbsGames then selectedDB := DM2022.tblGames;

  columnsAMT := dbgDisplay.Columns.Count - 1;   //finds the amount of columns present

  if columnsAMT = 8 then dbgDisplay.Columns[columnsAMT].Visible := FALSE; //ensures that the password column is not displayed along
                                                                          //with the other columns
  cmbFilter.Items.Clear;
  cmbSort.Items.Clear;   //clears all items in comboboxes for filter, sort and search
  cmbSearch.Items.Clear;
  for iLoop := 0 to columnsAMT do BEGIN
    dbgDisplay.Columns[iLoop].Color := dbColor;  //sets the colour of each column
    colWidth := colWidth + dbgDisplay.Columns[iLoop].Width; //finds total width of all columns
    if not(dbgDisplay.Columns[iLoop].Field.FieldName = 'password') then begin
     cmbFilter.Items.Add(dbgDisplay.Columns[iLoop].Field.FieldName);
     cmbSort.Items.Add(dbgDisplay.Columns[iLoop].Field.FieldName);     //adds each column to the Items of filter, sort and search
     cmbSearch.Items.Add(dbgDisplay.Columns[iLoop].Field.FieldName);   //given that it is not the password column
    end;
  END;
  dbgDisplay.Width := colWidth + 38;    //sets the width of the Display to the total width of all columns, and a set amount
end;                                    //in order to account for cutoff of the last column in the display

procedure TfrmDBDisplay.rdDisplayClick(Sender: TObject);
begin

  if (rdDisplay.ItemIndex = 0) then                 //assigns the datasource, dependant on the radiobutton clicked
  begin                                             //then a calls procedure updateCol()
    dbgDisplay.DataSource := DM2022.dbsPlayers;
    updateCol();
  end;

  if (rdDisplay.ItemIndex = 1) then
  begin
    dbgDisplay.DataSource := DM2022.dbsGames;
    updateCol();
  end;

end;

procedure TfrmDBDisplay.refresh(dbgDS : TDataSource);  //assigns the datasource, based on the input recieved
begin                                                  //calls procedure FitGrid and updateCol
  dbgDisplay.DataSource := dbgDS;
  FitGrid(dbgDisplay);
  updateCol();
end;

end.
