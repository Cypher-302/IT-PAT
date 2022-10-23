unit uDM2022;

interface

uses
  SysUtils, Classes, DB, ADODB, Dialogs;

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
    procedure dbsGamesDataChange(Sender: TObject; Field: TField);
    procedure dbsPlayersDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM2022: TDM2022;

implementation
uses uDBDisplay;

{$R *.dfm}

procedure TDM2022.dbsGamesDataChange(Sender: TObject; Field: TField);
begin
frmDBDisplay.dbgDisplayDrawColumnCell;
//showMessage('hi Game');
end;


procedure TDM2022.dbsPlayersDataChange(Sender: TObject; Field: TField);
begin
frmDBDisplay.dbgDisplayDrawColumnCell;
//showMessage('hi Player');
end;

end.
