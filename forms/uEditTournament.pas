unit uEditTournament;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDBDisplay, DBCtrls, DateUtils, pngimage, ExtCtrls, ComCtrls,
  StdCtrls, Mask;

type
  TfrmEditTournament = class(TForm)
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
  frmEditTournament: TfrmEditTournament;

implementation

{$R *.dfm}

end.
