unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, Grids, DBGrids, ComCtrls, pngimage,
  Math, DB, ADODB, DateUtils, OleCtrls, SHDocVw, Menus,
  ImgList, ToolWin, Buttons, Mask, DBCtrls, uRegistration, uDM2022, uDBDisplay;

type
  TfrmMain = class(TForm)
    pgcQuestions: TPageControl;
    tbsQ2_2: TTabSheet;                   //SHOULD NOT EXIST, NOT USED IN PROGRAM, PROGRAM ERRORS AND CRASHES IF uMAIN DOES NOT EXIST
    tbsQ2_1: TTabSheet;                   //I HAVE GIVEN UP TRYING, I HAVE SIMPLY LEFT IT HERE.
    gbRegistration: TGroupBox;            //AGAIN. IT IS NOT USED. IT SIMPLY HAS TO BE HERE FOR THE PROGRAM TO RUN.
    gbQueries: TGroupBox;
    Label4: TLabel;
    redOutput: TRichEdit;
    gbMain: TGroupBox;
    GroupBox3: TGroupBox;
    dbgMembers: TDBGrid;
    dbgSQL: TDBGrid;
    cboShirtSize: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    dtpBirth: TDateTimePicker;
    Label7: TLabel;
    Label8: TLabel;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Login1: TMenuItem;
    Login2: TMenuItem;
    Logout1: TMenuItem;
    Exit1: TMenuItem;
    ADo1: TMenuItem;
    SQLEvents1: TMenuItem;
    Help1: TMenuItem;
    Insert1: TMenuItem;
    Edit1: TMenuItem;
    Delete1: TMenuItem;
    Sort1: TMenuItem;
    Search1: TMenuItem;
    SQLSelection1: TMenuItem;
    SQLFilter1: TMenuItem;
    SQLTotal1: TMenuItem;
    SQLMean1: TMenuItem;
    tbsQ2_3: TTabSheet;
    WebBrowser1: TWebBrowser;
    gbReports: TGroupBox;
    Button2: TButton;
    cboReport: TComboBox;
    pnlQ1: TPanel;
    btnFirst: TButton;
    btnPrior: TButton;
    btnNext: TButton;
    btnLast: TButton;
    btnDBRestore: TButton;
    Navigate1: TMenuItem;
    First1: TMenuItem;
    Prior1: TMenuItem;
    Next1: TMenuItem;
    Last1: TMenuItem;
    btnValidate: TButton;
    Online1: TMenuItem;
    SQLfromTextfile1: TMenuItem;
    OpenDialog1: TOpenDialog;
    redSQL: TRichEdit;
    Button3: TButton;
    ExecuteSQLStatement1: TMenuItem;
    Reports1: TMenuItem;
    N10Report11: TMenuItem;
    N11Report21: TMenuItem;
    N12HTMLReport1: TMenuItem;
    ToolBar1: TToolBar;
    icons32: TImageList;
    actionUSEREvents: TToolButton;
    actionADOEvents: TToolButton;
    actionSQLEvents: TToolButton;
    actionReportEvents: TToolButton;
    btnOkay: TBitBtn;
    btnCancel: TBitBtn;
    edtFirstName: TDBEdit;
    edtLastName: TDBEdit;
    edtPhone: TDBEdit;
    edtEmail: TDBEdit;
    GroupBox4: TGroupBox;
    dbgGames: TDBGrid;
    dbsGames: TDataSource;
    adoDBPlayers: TADODataSet;
    popupPlayers: TPopupMenu;
    Delete2: TMenuItem;
    Insert2: TMenuItem;
    Edit2: TMenuItem;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    DBLookupComboBox1: TDBLookupComboBox;
    edtBirth: TDBEdit;
    tbsQ1_1: TTabSheet;
    Image1: TImage;
    imgRegister: TImage;
    btnUpdate: TButton;
    Image2: TImage;
    imgLogin: TImage;
    Image3: TImage;
    Image4: TImage;
    imgUpdate: TImage;
    btnDelete: TButton;
    btnDBDisplay: TButton;
    btnHome: TButton;
    procedure btnDBRestoreClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Tabs;
    procedure FormatTabs;
    procedure btnQ2_1_4Click(Sender: TObject);
    procedure btnQ2_2_1Click(Sender: TObject);
    procedure btnQ2_2_2Click(Sender: TObject);
    procedure btnQ2_1_7Click(Sender: TObject);
    procedure btnQ2_1_5Click(Sender: TObject);
    procedure btnQ2_1_6Click(Sender: TObject);
    procedure btnQ2_1_8Click(Sender: TObject);
    procedure btnQ2_1_9Click(Sender: TObject);
    procedure Online1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure SQLfromTextfile1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ExecuteSQLStatement1Click(Sender: TObject);
    procedure btnFirstClick(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnLastClick(Sender: TObject);
    procedure btnQ2_1_1Click(Sender: TObject);
    procedure btnQ2_1_2Click(Sender: TObject);
    procedure btnQ2_1_3Click(Sender: TObject);
    procedure Login2Click(Sender: TObject);
    procedure Logout1Click(Sender: TObject);
    procedure actionADOEventsClick(Sender: TObject);
    procedure actionSQLEventsClick(Sender: TObject);
    procedure actionReportEventsClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dbsGamesDataChange(Sender: TObject; Field: TField);
    procedure dbgMembersCellClick(Column: TColumn);
    procedure dbgMembersMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure dbgMembersKeyPress(Sender: TObject; var Key: Char);
    procedure adoDBPlayersAfterScroll(DataSet: TDataSet);
    procedure Insert2Click(Sender: TObject);
    procedure Edit2Click(Sender: TObject);
    procedure Delete2Click(Sender: TObject);
    procedure btnOkayClick(Sender: TObject);
    procedure btnValidateClick(Sender: TObject);
    procedure dtpBirthExit(Sender: TObject);
    procedure dtpBirthCloseUp(Sender: TObject);
    procedure imgRegisterClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure imgUpdateClick(Sender: TObject);
    procedure imgLoginClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnDBDisplayClick(Sender: TObject);

  private
  var
    sSQL: string;

  public
    { Public declarations }

    function isValidEmail(data: String): Boolean;
    function isValidPhone(data: String): Boolean;
    procedure applyFilter();
    procedure enableLogin(usertype: Integer);
    procedure sqlExecuteStatement;
    procedure runSQL(sSQL: String);

  end;

var
  frmMain: TfrmMain;

implementation

Uses uLogin;

const
  help_online = 'https://github.com/GrahamPearl/INFT11/wiki';

procedure TfrmMain.Online1Click(Sender: TObject);
begin
  WebBrowser1.Navigate(help_online);
end;

procedure TfrmMain.runSQL(sSQL: String);
begin
  DM2022.qry.SQL.Clear;
  DM2022.qry.SQL.ADD(sSQL);
  DM2022.qry.Open;
  Tabs();
end;

procedure TfrmMain.sqlExecuteStatement;
var
  sSQL: String;
  iLoop: Integer;
begin
  sSQL := '';
  for iLoop := 0 to redSQL.Lines.Count - 1 do
    sSQL := sSQL + ' ' + redSQL.Lines[iLoop];
  self.runSQL(sSQL);
end;

procedure TfrmMain.SQLfromTextfile1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    redSQL.Lines.LoadFromFile(OpenDialog1.FileName);
end;

procedure TfrmMain.Tabs;
begin

   //dbgSQL.Columns[0].Width := 150;
  // dbgSQL.Columns[1].Width := 150;

end;

procedure TfrmMain.actionADOEventsClick(Sender: TObject);
begin
  self.pgcQuestions.ActivePageIndex := 0;
end;

procedure TfrmMain.actionSQLEventsClick(Sender: TObject);
begin
  self.pgcQuestions.ActivePageIndex := 1;
end;

procedure TfrmMain.adoDBPlayersAfterScroll(DataSet: TDataSet);
begin
  self.applyFilter;
end;

procedure TfrmMain.applyFilter;
var
  playerID: String;
begin
  playerID := DM2022.tblPlayers.FieldByName('ID').AsString;
  DM2022.tblGames.Filtered := False;
  DM2022.tblGames.Filter := 'player1_id = ' + playerID + ' OR player2_id = ' +
    playerID;
  DM2022.tblGames.Filtered := True;
end;

procedure TfrmMain.actionReportEventsClick(Sender: TObject);
begin
  self.pgcQuestions.ActivePageIndex := 2;
end;

// ==========================Question 2.1=======================================

procedure TfrmMain.btnFirstClick(Sender: TObject);
begin
  // Question 1.1
  DM2022.tblPlayers.First;
end;

procedure TfrmMain.btnLastClick(Sender: TObject);
begin
  // Question 1.4
  DM2022.tblPlayers.Last;
end;

procedure TfrmMain.btnNextClick(Sender: TObject);
begin
  // Question 1.3
  DM2022.tblPlayers.Next;
end;

procedure TfrmMain.btnPriorClick(Sender: TObject);
begin
  // Question 1.2
  DM2022.tblPlayers.Prior;
end;

procedure TfrmMain.btnQ2_1_1Click(Sender: TObject);
begin
  // Question 2.1.1

end;

procedure TfrmMain.btnQ2_1_2Click(Sender: TObject);
begin
  // Question 2.1.2

end;

procedure TfrmMain.btnQ2_1_3Click(Sender: TObject);
begin
  // Question 2.1.3

end;

procedure TfrmMain.btnQ2_1_4Click(Sender: TObject);
begin
  // Question 2.1.4

  self.runSQL('');
end;

procedure TfrmMain.btnQ2_1_5Click(Sender: TObject);
begin
  self.runSQL('');
end;

procedure TfrmMain.btnQ2_1_6Click(Sender: TObject);
begin
  self.runSQL('');
end;

procedure TfrmMain.btnQ2_1_7Click(Sender: TObject);
begin
  self.runSQL('');

end;

procedure TfrmMain.btnQ2_1_8Click(Sender: TObject);
begin
  self.runSQL('');
end;

procedure TfrmMain.btnQ2_1_9Click(Sender: TObject);
var
  iLoop: Integer;
  aLine: String;
  tf: Textfile;
begin
  self.runSQL('SELECT * FROM players');

  AssignFile(tf, 'report.txt');
  Rewrite(tf);

  DM2022.qry.First;
  While NOT DM2022.qry.Eof Do
  Begin
    aLine := 'Name : ' + DM2022.qry['last_name'];
    WriteLN(tf, aLine);
    DM2022.qry.Next;
  End;

  CloseFile(tf);
  showMessage('Report Generated');
end;

procedure TfrmMain.btnQ2_2_1Click(Sender: TObject);
begin
  self.runSQL('');
end;

procedure TfrmMain.btnQ2_2_2Click(Sender: TObject);
begin
  self.runSQL('');
end;

procedure TfrmMain.btnUpdateClick(Sender: TObject);
begin

end;

// uses DateUtils;
procedure TfrmMain.btnValidateClick(Sender: TObject);
begin
  IF Length(edtFirstName.text) > 3 then
    edtFirstName.Color := clWindow
  else
    edtFirstName.Color := clHighlight;

  IF Length(edtLastName.text) > 3 then
    edtLastName.Color := clWindow
  else
    edtLastName.Color := clHighlight;

  IF (Length(edtPhone.text) > 9) AND (edtPhone.text[4] = '-') AND
    (edtPhone.text[8] = '-') then
    edtPhone.Color := clWindow
  else
    edtPhone.Color := clHighlight;

  // if (POS('@', edtEmail.Text) >0)
  // then edtEmail.Colour := clWindow;
  // else edtEmail.Colour := clHighlight;

  IF (dtpBirth.Date > today) then
    showMessage('Date is in the future - please check');

end;

function TfrmMain.isValidEmail(data: String): Boolean;
begin
  result := True;
end;

function TfrmMain.isValidPhone(data: String): Boolean;
begin
  result := True;
end;

procedure TfrmMain.Login2Click(Sender: TObject);
begin
  frmLogin.ShowModal;
  if (frmLogin.edtEmail.text = 'Admin') AND
    (frmLogin.edtPassword.text = '12345') then
    enableLogin(1)
  else if (frmLogin.edtEmail.text = 'User') then
    enableLogin(0)
  else
    enableLogin(-1);
end;

procedure TfrmMain.enableLogin(usertype: Integer);
begin
  self.ADo1.Enabled := (usertype = 0);
  self.SQLEvents1.Enabled := (usertype = 1);
  self.Reports1.Enabled := (usertype = 1);
  self.gbMain.Enabled := (usertype = 1);
  self.gbRegistration.Enabled := (usertype = 1);
  self.gbQueries.Enabled := (usertype = 1);

  self.actionADOEvents.Enabled := (usertype = 0);
  self.actionSQLEvents.Enabled := (usertype = 1);
  self.actionReportEvents.Enabled := (usertype = 1);

  case usertype of
    - 1:
      pgcQuestions.ActivePageIndex := 2;
    0:
      pgcQuestions.ActivePageIndex := 0;
    1:
      pgcQuestions.ActivePageIndex := 1;
  end;

end;

procedure TfrmMain.Logout1Click(Sender: TObject);
begin
  enableLogin(-1);
end;

procedure TfrmMain.Button3Click(Sender: TObject);
begin
  sqlExecuteStatement;
end;

procedure TfrmMain.dbgMembersCellClick(Column: TColumn);
begin
  self.applyFilter;
end;

procedure TfrmMain.dbgMembersKeyPress(Sender: TObject; var Key: Char);
begin
  self.applyFilter;
end;

procedure TfrmMain.dbgMembersMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
  self.applyFilter;
end;
{$R *.dfm}
// =================================Question 2.2==============================================
{$REGION}

procedure TfrmMain.FormActivate(Sender: TObject);
begin
  // enableLogin(-1);
end;

procedure TfrmMain.FormatTabs;
begin
  redOutput.Lines.Clear;
  redOutput.Paragraph.TabCount := 2;
  redOutput.Paragraph.Tab[0] := 100;
  redOutput.Paragraph.Tab[1] := 150;
  redOutput.Paragraph.Tab[2] := 20;

  redOutput.Lines.ADD('First Name' + #9 + 'Last Name' + #9 + 'Age Group' + #9 +
      'Gender');

  redOutput.Lines.ADD('');

end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  // PROVIDED CODE - DO NOT MODIFY!
end;

procedure TfrmMain.imgLoginClick(Sender: TObject);
begin
  frmLogin.ShowModal;
end;

procedure TfrmMain.imgRegisterClick(Sender: TObject);
begin
  try
    DM2022.tblPlayers.Insert;

    frmRegistration.ShowModal;

    DM2022.tblPlayers.Post;
  except // put finally to display even when no error
    messageDlg('Unable to insert new registration', mtWarning, [mbOk], 0);
    // or mtInformation
  end;
end;

procedure TfrmMain.imgUpdateClick(Sender: TObject);
begin
  try
    DM2022.tblPlayers.Edit;

    frmRegistration.ShowModal;

    DM2022.tblPlayers.Post;
  except // put finally to display even when no error
    messageDlg('Unable to update record', mtWarning, [mbOk], 0);
    // or mtInformation
  end;
end;

procedure TfrmMain.Insert2Click(Sender: TObject);
begin
  DM2022.tblPlayers.Insert;
end;

procedure TfrmMain.dbsGamesDataChange(Sender: TObject; Field: TField);
begin
  try

  except

  end;
end;

procedure TfrmMain.Delete2Click(Sender: TObject);
begin
  IF messageDlg('Are you sure you want to delete this record?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
    DM2022.tblPlayers.Delete;
end;

procedure TfrmMain.dtpBirthCloseUp(Sender: TObject);
begin
  self.edtBirth.text := DateToStr(self.dtpBirth.Date);
end;

procedure TfrmMain.dtpBirthExit(Sender: TObject);
begin
  self.edtBirth.text := DateToStr(self.dtpBirth.Date);
end;

procedure TfrmMain.btnOkayClick(Sender: TObject);
begin
  DM2022.tblPlayers.Post;
end;

procedure TfrmMain.Edit2Click(Sender: TObject);
begin
  DM2022.tblPlayers.Edit;
end;

procedure TfrmMain.ExecuteSQLStatement1Click(Sender: TObject);
begin
  sqlExecuteStatement;
end;

procedure TfrmMain.Exit1Click(Sender: TObject);
begin
  if messageDlg('Are you sure you want to exit', mtConfirmation, [mbYes, mbNo],
    0) = mrYes then
    Application.Terminate;
end;

procedure TfrmMain.btnDBDisplayClick(Sender: TObject);
begin
  frmDBDisplay.ShowModal;
end;

procedure TfrmMain.btnDBRestoreClick(Sender: TObject);
begin
  // PROVIDED CODE - DO NOT MODIFY!
  if messageDlg('Are you sure you want to restore', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  BEGIN
    DM2022.con.Close();

    DM2022.tblPlayers.Close();
    DM2022.tblGames.Close();

    DeleteFile('tournament.mdb');
    CopyFile('BackupDB.mdb', 'tournament.mdb', False);

    DM2022.tblPlayers.Open();

    showMessage('Database restored!');
  END;
end;

procedure TfrmMain.btnDeleteClick(Sender: TObject);
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
{$ENDREGION}

end.
