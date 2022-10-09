unit uRegistration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, DBCtrls, StdCtrls, Mask, Buttons, ExtCtrls, uDM2022,
  pngimage;

type
  TfrmRegistration = class(TForm)
    imgRegistration: TImage;
    edtFirstName: TDBEdit;
    edtLastName: TDBEdit;
    cboGenders: TDBLookupComboBox;
    cboShirtSizes: TDBLookupComboBox;
    edtPhone: TDBEdit;
    edtEmail: TDBEdit;
    dtpBirth: TDateTimePicker;
    edtBirth: TDBEdit;
    edtPassword: TEdit;
    imgSignUp: TImage;
    btnValidate: TButton;
    procedure FormCreate(Sender: TObject);
    procedure imgSignUpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRegistration: TfrmRegistration;

implementation

{$R *.dfm}

procedure TfrmRegistration.FormCreate(Sender: TObject);
begin
   SetWindowRgn(cboGenders.Handle, CreateRectRgn(2,2,cboGenders.Width - 2,cboGenders.Height - 2), True);
   SetWindowRgn(cboShirtSizes.Handle, CreateRectRgn(2,2,cboShirtSizes.Width - 2,cboShirtSizes.Height - 2), True);
   SetWindowRgn(dtpBirth.Handle, CreateRectRgn(2,2,dtpBirth.Width - 2,dtpBirth.Height - 2), True);
end;

procedure TfrmRegistration.imgSignUpClick(Sender: TObject);
begin

showMessage('works');
end;

end.
