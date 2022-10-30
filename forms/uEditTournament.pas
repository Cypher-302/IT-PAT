unit uEditTournament;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, DateUtils, pngimage, ExtCtrls, ComCtrls, StdCtrls, Mask;

type
  TfrmEditTournament = class(TForm)
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
  end;

var
  frmEditTournament: TfrmEditTournament;

implementation
uses uAddTournament, uDM2022, uDBDisplay;

{$R *.dfm}

procedure TfrmEditTournament.imgSignUpClick(Sender: TObject); //if validation (from AddTournament) passes, a message asking for
begin                                                         //confirmation of changes is displayed, if yes is selected, the form closes and the changes are commited
 if frmAddTournament.validation(edtP1id.Text,edtP2id.Text,edtP1Score.Text,edtP2Score.Text) = TRUE
  then if messageDlg('Are you satisfied with the changes made and wish to proceed?',
  mtConfirmation,[mbYes,mbNo],0) = mrYes then self.Close;
 end;

end.
