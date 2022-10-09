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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM2022: TDM2022;

implementation

{$R *.dfm}

end.
