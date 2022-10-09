unit Login;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons;

type
  TUserDlg = class(TForm)
    Label1: TLabel;
    Password: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    Label2: TLabel;
    Username: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UserDlg: TUserDlg;
    frmLogin: TUserDlg;

implementation

{$R *.dfm}

end.

