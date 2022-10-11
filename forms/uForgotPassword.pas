unit uForgotPassword;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDBDisplay, DBCtrls, DateUtils, pngimage, ExtCtrls, ComCtrls,
  StdCtrls, Mask;

type
  TfrmForgotPassword = class(TForm)
    imgBackground: TImage;
    edtPlayer1ID: TDBEdit;
    imgSignUp: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmForgotPassword: TfrmForgotPassword;

implementation

{$R *.dfm}

end.
