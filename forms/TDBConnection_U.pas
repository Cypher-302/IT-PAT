unit TDBConnection_U;

interface

uses
  DB, ADODB, Classes, SysUtils;

type
  TDBConnection = class(TObject)
  public
    class procedure DBConnect(var connection: TADOConnection;
      owner: TComponent);
  end;

implementation

{ TDBConnection }

class procedure TDBConnection.DBConnect(var connection: TADOConnection;
  owner: TComponent);
var tf  : TextFile;
   connect : String;
begin
  if FileExists('login.txt') then
  begin
     AssignFile(tf,'login.txt');
     Reset(tf);
    ReadLn(tf,connect);
    Close(tf);
    connection.ConnectionString :=
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Church.mdb;' +
      'Mode=ReadWrite;Persist Security Info=False;Jet OLEDB:Database password=mock2020';
  end
  else
    connection.ConnectionString :=
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Church.mdb;' +
      'Mode=ReadWrite;Persist Security Info=False;Jet OLEDB:Database password=mock2020';

  connection.LoginPrompt := False;
  connection.Connected := True;

end;

end.
