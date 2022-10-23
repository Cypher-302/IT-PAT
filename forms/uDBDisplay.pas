unit uDBDisplay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  DBGrids, pngimage, ExtCtrls, StdCtrls, Grids, jpeg, CheckLst, Dialogs,
  uDM2022, uLogin, Menus, uRegistration, DB, ADODB;

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
    btnDelete1000: TButton;
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
//    procedure QuickSort(var A: array of Integer; iLo, iHi: Integer);
    procedure FitGrid(Grid: TDBGrid);
    procedure refresh();
    procedure btnDelete1000Click(Sender: TObject);

  private
    { Private declarations }
  public
  procedure dbgDisplayDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  var slcColor : TColor;
  end;

var
  frmDBDisplay: TfrmDBDisplay;

  selectedDB: TADOTable;

  dbColor: TColor;

implementation
uses uEdit;

{$R *.dfm}

procedure TfrmDBDisplay.btnFirstClick(Sender: TObject);
begin
  selectedDB.First;
end;

procedure TfrmDBDisplay.btnLastClick(Sender: TObject);
begin
  selectedDB.Last;
end;

procedure TfrmDBDisplay.btnNextClick(Sender: TObject);
begin
  selectedDB.Next;
end;

procedure TfrmDBDisplay.btnPriorClick(Sender: TObject);
begin
  selectedDB.Prior;
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

procedure TfrmDBDisplay.clkDeleteClick(Sender: TObject);
begin
  case messageDlg('Are you sure that you want to delete this record?',
    mtConfirmation, [mbYes, mbNo], 0) of
    mrYes:
      selectedDB.Delete;
    mrNo:
      messageDlg('Record deletion cancelled.', mtInformation, [mbOk], 0);
  end;
end;

procedure TfrmDBDisplay.clkEditClick(Sender: TObject);
begin
  try
    selectedDB.Insert;

    frmEdit.ShowModal;

    selectedDB.Post;
  except
    messageDlg('Unable to insert new registration', mtWarning, [mbOk], 0);
  end;
end;

procedure TfrmDBDisplay.clkInsertClick(Sender: TObject);
begin
  try
    selectedDB.Insert;
    frmRegistration.ShowModal;
    selectedDB.Post;
  except
    messageDlg('Unable to insert new registration', mtWarning, [mbOk], 0);
  end;
end;

procedure TfrmDBDisplay.dbgDisplayDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var iLoop : Integer;
begin
if self.Enabled = TRUE then begin

updateCol;
for iLoop := 0 to dbgDisplay.Columns.Count - 1 do
  begin
    with dbgDisplay do
    with Canvas do
    begin
      Brush.Color := slcColor;
    end;
  end;
dbgDisplay.DefaultDrawColumnCell(Rect, DataCol, Column, State);
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
  slcColor := HexToTColor('9584FF');
  refresh();

end;

{
procedure TForm1.DBGrid1DrawColumnCell
 (Sender: TObject; const Rect: TRect;
 DataCol: Integer; Column: TColumn;
 State: TGridDrawState);
begin
if Table1.FieldByName('Salary').AsCurrency>36000 then DBGrid1.Canvas.Brush.Color:=clWhite;
DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;
}

{procedure TfrmDBDisplay.QuickSort(var A: array of Integer; iLo, iHi: Integer);
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
end;}

procedure TfrmDBDisplay.updateCol();
var iLoop, colWidth, columnsAMT : Integer;
begin
  colWidth := 0;

  if dbgDisplay.DataSource = DM2022.dbsPlayers then
    begin
      selectedDB := DM2022.tblPlayers;
      columnsAMT := dbgDisplay.Columns.Count - 1;
      dbgDisplay.Columns[columnsAMT].Visible := FALSE;
    end
  else if dbgDisplay.DataSource = DM2022.dbsGames then
    begin
    selectedDB := DM2022.tblGames;
    columnsAMT := dbgDisplay.Columns.Count - 1;
    end;

  for iLoop := 0 to columnsAMT do
    dbgDisplay.Columns[iLoop].Color := dbColor;

  for iLoop := 0 to columnsAMT do
    colWidth := colWidth + dbgDisplay.Columns[iLoop].Width;

  dbgDisplay.Width := colWidth + 38;
end;

procedure TfrmDBDisplay.rdDisplayClick(Sender: TObject);
var
  columnsAMT, iLoop: Integer;
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

procedure TfrmDBDisplay.refresh;
begin
  rdDisplay.ItemIndex := 0;
  FitGrid(dbgDisplay);
  updateCol();
  {rdDisplay.ItemIndex := 1;
  FitGrid(dbgDisplay);}
  //showmessage('Refreshed!');
end;

end.
