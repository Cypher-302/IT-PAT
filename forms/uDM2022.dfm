object DM2022: TDM2022
  OldCreateOrder = False
  Height = 346
  Width = 540
  object con: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=./data/tournament.m' +
      'db;Mode=ReadWrite;Persist Security Info=False;Jet OLEDB:Database' +
      ' password=;'
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 40
    Top = 24
  end
  object tblPlayers: TADOTable
    Active = True
    Connection = con
    CursorType = ctStatic
    TableName = 'players'
    Left = 136
    Top = 24
  end
  object dbsPlayers: TDataSource
    DataSet = tblPlayers
    OnDataChange = dbsPlayersDataChange
    Left = 216
    Top = 24
  end
  object dbsGames: TDataSource
    DataSet = tblGames
    OnDataChange = dbsGamesDataChange
    Left = 216
    Top = 88
  end
  object tblGames: TADOTable
    Active = True
    Connection = con
    CursorType = ctStatic
    TableName = 'games'
    Left = 136
    Top = 88
  end
  object qry: TADOQuery
    Connection = con
    Parameters = <>
    Left = 304
    Top = 32
  end
  object dbsSQL: TDataSource
    DataSet = qry
    Left = 384
    Top = 24
  end
  object tblGenders: TADOTable
    Active = True
    Connection = con
    CursorType = ctStatic
    TableName = 'Genders'
    Left = 136
    Top = 160
  end
  object dbsGenders: TDataSource
    DataSet = tblGenders
    Left = 216
    Top = 160
  end
  object tblShirtSizes: TADOTable
    Active = True
    Connection = con
    CursorType = ctStatic
    TableName = 'shirtSizes'
    Left = 136
    Top = 216
  end
  object dbsShirtSizes: TDataSource
    DataSet = tblShirtSizes
    Left = 216
    Top = 216
  end
end
