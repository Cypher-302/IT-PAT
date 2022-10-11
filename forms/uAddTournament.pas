unit uAddTournament;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDBDisplay, DBCtrls, DateUtils, pngimage, ExtCtrls, ComCtrls,
  StdCtrls, Mask;
type
  TfrmAddTournament = class(TForm)
    imgBackground: TImage;
    edtPlayer1ID: TDBEdit;
    edtLastName: TDBEdit;
    edtPlayer2ID: TDBEdit;
    edtPhone: TDBEdit;
    imgSignUp: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAddTournament: TfrmAddTournament;

implementation

{$R *.dfm}

end.
