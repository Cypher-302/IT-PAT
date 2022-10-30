unit uAddTournament;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDBDisplay, DBCtrls, DateUtils, pngimage, ExtCtrls, ComCtrls,
  StdCtrls, Mask;
type
  TfrmAddTournament = class(TForm)
    imgBackground: TImage;
    edtP1id: TDBEdit;
    edtP1Score: TDBEdit;
    edtP2id: TDBEdit;
    edtP2Score: TDBEdit;
    imgSignUp: TImage;
    procedure imgSignUpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function validation(P1_id,P2_id,P1_score,P2_score : String): Boolean;
  end;

var
  frmAddTournament: TfrmAddTournament;

implementation
uses uDM2022;
{$R *.dfm}
function TfrmAddTournament.validation(P1_id, P2_id, P1_score,
  P2_score: String): Boolean;
  var i,id1,id2 : Integer;
begin
result := FALSE;
if not(TryStrToInt(P1_id,id1) AND TryStrToInt(P2_id,id2) AND TryStrToInt(P1_score,i) AND TryStrToInt(P2_score,i))
 then MessageDlg('Inputed ID/s or Score/s are not numbers!',mtWarning,[mbOk],0)
 else with DM2022 do
  if not((tblPlayers.Locate('id',id1,[]) = TRUE) AND (tblPlayers.Locate('id',id2,[]) = TRUE))
   then MessageDlg('Inputed ID/s do not exist in Members database!',mtWarning,[mbOk],0)
   else result := TRUE;
end;

procedure TfrmAddTournament.imgSignUpClick(Sender: TObject);
begin
if validation(edtP1id.Text,edtP2id.Text,edtP1Score.Text,edtP2Score.Text) = TRUE
 then self.Close;

end;


end.
