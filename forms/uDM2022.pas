unit uDM2022;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TDM2022 = class(TDataModule)
    con: TADOConnection;
    tblPlayers: TADOTable;
    dbsPlayers: TDataSource;
    dbsGames: TDataSource;
    tblGames: TADOTable;
    qry: TADOQuery;
    dbsSQL: TDataSource;
    tblGenders: TADOTable;
    dbsGenders: TDataSource;
    tblShirtSizes: TADOTable;
    dbsShirtSizes: TDataSource;
    procedure conBeforeConnect(Sender: TObject);
    procedure tblGamesAfterOpen(DataSet: TDataSet);
    procedure tblPlayersAfterOpen(DataSet: TDataSet);
    procedure tblPlayersAfterScroll(DataSet: TDataSet);
    procedure tblGamesAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM2022: TDM2022;
  log: TextFile;

implementation

{$R *.dfm}

procedure TDM2022.conBeforeConnect(Sender: TObject); //writes to log before connection to the database is made
begin
AssignFile(log, 'log.txt');
    Rewrite(log);
    Writeln(log, 'Connecting');
CloseFile(log);
end;

procedure TDM2022.tblGamesAfterOpen(DataSet: TDataSet); //writes to log tblGames is opened
begin
AssignFile(log, 'log.txt');
    Rewrite(log);
    Writeln(log, 'Opened Database connection - table Games');
CloseFile(log);
end;

procedure TDM2022.tblPlayersAfterOpen(DataSet: TDataSet); //writes to log tblPlayers is opened
begin
AssignFile(log, 'log.txt');
    Rewrite(log);
    Writeln(log, 'Opened Database connection - table Players');
CloseFile(log);
end;

procedure TDM2022.tblPlayersAfterScroll(DataSet: TDataSet); //writes to log textfile when record pointer movement is detected
begin                                                       //in tblPlayers
AssignFile(log, 'log.txt');
    Append(log);
    Writeln(log, 'Scrolling Players: '+IntToStr(tblPlayers.RecNo)+'of '+ IntToStr(tblPlayers.Recordset.RecordCount ));
CloseFile(log);
end;

procedure TDM2022.tblGamesAfterScroll(DataSet: TDataSet); //writes to log textfile when record pointer movement is detected
begin                                                     //in tblGames
AssignFile(log, 'log.txt');
    Append(log);
    Writeln(log, 'Scrolling Games: '+IntToStr(tblPlayers.RecNo)+' of '+ IntToStr(tblPlayers.Recordset.RecordCount ));
CloseFile(log);
end;

end.
