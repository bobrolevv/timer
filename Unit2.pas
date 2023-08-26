unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
  Label1.Font.Size:=Form2.Width div 6;
  Label1.Top:= Form2.Height div 2 - Round(Label1.Height / 1.6);
  Label1.Left:= Form2.Width div 2 - Label1.Width div 2;
  Form2.Constraints.MinHeight:= Label1.Height;
end;

end.
