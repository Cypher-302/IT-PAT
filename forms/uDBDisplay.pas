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
    procedure FormActivate(Sender: TObject);
    procedure rdDisplayClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
    procedure btnFirstClick(Sender: TObject);
    procedure btnLastClick(Sender: TObject);
    procedure clkInsertClick(Sender: TObject);
    procedure clkEditClick(Sender: TObject);
    procedure clkDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDBDisplay: TfrmDBDisplay;

  selectedDB: TADOTable;

  dbColor: TColor;

implementation

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

procedure TfrmDBDisplay.clkDeleteClick(Sender: TObject);
begin
  case messageDlg('Are you sure that you want to delete this record?', mtConfirmation, [mbYes, mbNo], 0) of
  mrYes: showmessage('deleted');
  mrNo:  showmessage('cancelled');
  end;
end;

procedure TfrmDBDisplay.clkEditClick(Sender: TObject);
begin
  try
    selectedDB.Insert;

    frmRegistration.ShowModal;

    selectedDB.Post;
  except
    messageDlg('Unable to insert new registration', mtWarning, [mbOK], 0);
  end;
end;

procedure TfrmDBDisplay.clkInsertClick(Sender: TObject);
begin
  try
    selectedDB.Insert;

    frmRegistration.ShowModal;

    selectedDB.Post;
  except
    messageDlg('Unable to insert new registration', mtWarning, [mbOK], 0);
  end;
end;

function HexToTColor(sColor: string): TColor;
begin
  Result := RGB(StrToInt('$' + Copy(sColor, 1, 2)),
    StrToInt('$' + Copy(sColor, 3, 2)), StrToInt('$' + Copy(sColor, 5, 2)));
end;

// -------------------------------------------------------

procedure TfrmDBDisplay.FormActivate(Sender: TObject);
begin

  dbColor := HexToTColor('B6D6CC');
  rdDisplay.ItemIndex := 0;

end;

procedure TfrmDBDisplay.rdDisplayClick(Sender: TObject);
var   columnsAMT, iLoop : Integer;
begin

  if (rdDisplay.ItemIndex = 0) then
  begin
    dbgDisplay.DataSource := DM2022.dbsPlayers;
    selectedDB := DM2022.tblPlayers;
    columnsAMT := dbgDisplay.Columns.Count -1;
    dbgDisplay.Columns[columnsAMT].Visible := FALSE;
  end;

  if (rdDisplay.ItemIndex = 1) then
  begin
    dbgDisplay.DataSource := DM2022.dbsGames;
    selectedDB := DM2022.tblGames;
    columnsAMT := dbgDisplay.Columns.Count -1;
  end;

  for iLoop := 0 to columnsAMT do dbgDisplay.Columns[iLoop].Color := dbColor;

end;

end.
