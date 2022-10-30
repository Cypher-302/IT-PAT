unit uLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls, Mask, DBCtrls;

type
  TFrmLogin = class(TForm)
    imgLoginbtn: TImage;
    edtPassword: TDBEdit;
    edtEmail: TDBEdit;
    imgLogin: TImage;
    imgbtnLogin: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TFrmLogin;

implementation

{$R *.dfm}

end.
