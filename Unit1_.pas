unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, IniFiles;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Panel2: TPanel;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    Panel3: TPanel;
    TrackBar4: TTrackBar;
    TrackBar5: TTrackBar;
    TrackBar6: TTrackBar;
    Panel4: TPanel;
    TrackBar7: TTrackBar;
    TrackBar8: TTrackBar;
    TrackBar9: TTrackBar;
    TrackBar10: TTrackBar;
    RadioGroup1: TRadioGroup;
    Label1: TLabel;
    Timer1: TTimer;
    Timer2: TTimer;
    TrackBar3: TTrackBar;
    Label2: TLabel;
    Timer3: TTimer;
    Timer4: TTimer;
    TrackBar11: TTrackBar;
    TrackBar12: TTrackBar;
    TrackBar13: TTrackBar;
    Label3: TLabel;
    Label4: TLabel;
    TrackBar14: TTrackBar;
    Label5: TLabel;
    Timer5: TTimer;
    Timer6: TTimer;
    Label6: TLabel;
    procedure Timer6Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Panel3Click(Sender: TObject);
    procedure Timer5Timer(Sender: TObject);  //������ ��������� �������
    procedure Timer4Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure TrackBar14Change(Sender: TObject);
    procedure TrackBar13Change(Sender: TObject);
    procedure TrackBar12Change(Sender: TObject);
    procedure TrackBar11Change(Sender: TObject);
    procedure TrackBar10Change(Sender: TObject);
    procedure TrackBar9Change(Sender: TObject);
    procedure TrackBar8Change(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure TrackBar5Change(Sender: TObject);
    procedure TrackBar6Change(Sender: TObject);
    procedure TrackBar7Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Time2, Time3, Time4, Time4_1 : TDateTime;
  IniFile: TIniFile;
  pathIni: String;
//Time2 - ������, Time3 - ��������,
//Time4 - ������ - ������, Time4_1 - ������ - �����
  {r_pm0,} r_pm1, {r_tab0,} r_tab1, i, i1, i_timer6: Integer;
  //r_pm0 - ������� �������� ������� � ���������;
//r_pm1 - ������� ������� ������� � ���������;
//i1 - ������� ������� � ������;
//i_timer6 - ������� ������� ��������� ������� "�����/����"
implementation

uses Unit2;

{$R *.dfm}

//�������� �����
procedure TForm1.FormCreate(Sender: TObject);
begin
  pathIni:= extractfilepath(application.ExeName)+'MyIni.ini'; //���������� ���� � ini
  IniFile:=TIniFile.Create(pathIni); //�������������� ���� ini
  r_pm1:= 0;
  i_timer6:= 0;
  Time3:= StrToTime('00:00:00');
  Panel2.Align:= alBottom;
  Panel3.Align:= alBottom;
  Panel4.Align:= alBottom;
  Panel2.Caption:= '';
  Panel3.Caption:= '';
  Panel4.Caption:= '';
  //����������� ������ ������
  TrackBar1.Top:= 5;
  TrackBar2.Top:= 5;
  TrackBar3.Top:= 5;
  TrackBar4.Top:= 5;
  TrackBar5.Top:= 5;
  TrackBar6.Top:= 5;
  TrackBar7.Top:= 5;
  TrackBar8.Top:= 5;
  TrackBar9.Top:= 5;
  TrackBar10.Top:= 5;
  TrackBar11.Top:= 5;
  TrackBar12.Top:= 5;
  TrackBar13.Top:= 5;
  TrackBar14.Top:= 5;
  //����������� ������ ����� �������� �������
  TrackBar1.Left:= (Button1.Width div 2 - TrackBar1.Width - 20);
  TrackBar2.Left:= TrackBar1.Left + TrackBar2.Width + 10;
  TrackBar3.Left:= TrackBar2.Left + TrackBar2.Width + 10;;
  //����������� ������ ����� �������� ��������
  TrackBar4.Left:= (Button1.Width div 2 - TrackBar4.Width - 65);
  TrackBar5.Left:= TrackBar4.Left + TrackBar5.Width + 10;
  TrackBar6.Left:= TrackBar5.Left + TrackBar6.Width + 10;
  TrackBar7.Left:= TrackBar6.Left + TrackBar6.Width + 50;
  //����������� ������ ����� �������� ������
  TrackBar8.Left:= (Button1.Width div 2 - TrackBar7.Width - 150);
  TrackBar9.Left:= TrackBar8.Left + TrackBar9.Width + 10;
  TrackBar10.Left:= TrackBar9.Left + TrackBar10.Width + 10;
  TrackBar11.Left:= TrackBar10.Left + TrackBar11.Width + 50;
  TrackBar12.Left:= TrackBar11.Left + TrackBar12.Width + 10;
  TrackBar13.Left:= TrackBar12.Left + TrackBar13.Width + 10;
  TrackBar14.Left:= TrackBar13.Left + TrackBar14.Width + 40;
  //����������� �������1 (�������� ������, ���� � �.�.)
  Label1.Font.Size:= Form1.Width div 7;
  Label1.Left:= Form1.width div 2 - label1.width div 2;
  Label1.Top:= Label1.Height div 30;
  //����������� �������2 (������ � ���������)
  Label2.Font.Size:= Form1.Width div 15;
  Label2.Left:= Form1.width div 2 - label2.width div 2;
  Label2.Top:= Label1.Top + Label1.Height - (Label1.Height div 7);
  //����������� �������3 (��� ������ � ������)
  Label3.Font.Size:= Form1.Width div 10;
  Label3.Left:= Form1.width div 2 - label3.width div 2;
  Label3.Top:= Label1.Top + Label1.Height - (Label1.Height div 7);
  //����������� �������4 (������ � ������)
  Label4.Font.Size:= Form1.Width div 15;
  Label4.Left:= Form1.width div 2 - label4.width div 2;
  Label4.Top:= Label3.Top + Label3.Height - (Label3.Height div 7);
  //����������� �������5 (�������� ������)
  Label5.Font.Size:= Form1.Width div 5;
  Label5.Left:= Form1.width div 2 - label5.width div 2;
  Label5.Top:= Label1.Top;
  Form1.Constraints.MinHeight:= Label1.Height + 100;
  //��������� �������� �������� �� MyIni.ini
  if FileExists(pathIni) then //��������� ���� �� ���� INI
    begin
      TrackBar1.Position:=IniFile.ReadInteger('Form info','TrackBar1.Position',0);
      TrackBar2.Position:=IniFile.ReadInteger('Form info','TrackBar2.Position',0);
      TrackBar3.Position:=IniFile.ReadInteger('Form info','TrackBar3.Position',0);
      TrackBar4.Position:=IniFile.ReadInteger('Form info','TrackBar4.Position',0);
      TrackBar5.Position:=IniFile.ReadInteger('Form info','TrackBar5.Position',0);
      TrackBar6.Position:=IniFile.ReadInteger('Form info','TrackBar6.Position',0);
      TrackBar7.Position:=IniFile.ReadInteger('Form info','TrackBar7.Position',0);
      TrackBar8.Position:=IniFile.ReadInteger('Form info','TrackBar8.Position',0);
      TrackBar9.Position:=IniFile.ReadInteger('Form info','TrackBar9.Position',0);
      TrackBar10.Position:=IniFile.ReadInteger('Form info','TrackBar10.Position',0);
      TrackBar11.Position:=IniFile.ReadInteger('Form info','TrackBar11.Position',0);
      TrackBar12.Position:=IniFile.ReadInteger('Form info','TrackBar12.Position',0);
      TrackBar13.Position:=IniFile.ReadInteger('Form info','TrackBar13.Position',0);
      TrackBar14.Position:=IniFile.ReadInteger('Form info','TrackBar14.Position',0);
    end
  else showmessage('���� example.ini �� ������!');

  end;

procedure TForm1.Panel3Click(Sender: TObject);
begin

end;

//������ *���������/���������*
procedure TForm1.Button1Click(Sender: TObject);
begin
    //����� ����������
    case RadioGroup1.ItemIndex of
    //������ ������
    1:  begin
          if Button1.Caption = '���������' then begin
            Button1.Caption:= '���������';
            Button2.Enabled:= false;
            Button3.Enabled:= false;
            radiogroup1.Enabled:= false;
            Panel2.Visible:= true;
            //���������� ��������� ���������, ����������� �������
            Label1.Caption:= IntToStr(TrackBar1.Position) + ':' + IntToStr(TrackBar2.Position) + ':' + IntToStr(TrackBar3.Position);
            Label1.Left:= Form1.width div 2 - label1.width div 2;
            //���������� ������� ���� �� ���������
            Label1.Font.Color:= clWindowText;
            Timer6.Enabled:= false; //��������� ����� ������� ������ ����
          end
          else begin
            Button1.Caption:= '���������';
            Button2.Enabled:= true;
            Button3.Enabled:= true;
            radiogroup1.Enabled:= true;
            Panel2.Visible:= false;
            //������� ���������� �������
            //���������� ���������� Ttime2 � ������ �����
            Time2:= StrToTime(Label1.Caption);
            //������������ ������� � ������� �������
            Label1.Caption:= TimeToStr(Time2);
            Label1.Left:= Form1.width div 2 - label1.width div 2;
            Timer6.Enabled:= true; //�������� ����� ������� ������ ����
          end;
        end;
    //������� ��������
    2:  begin
          if Button1.Caption = '���������' then begin
            Button1.Caption:= '���������';
            Button2.Enabled:= false;
            Button3.Enabled:= false;
            radiogroup1.Enabled:= false;
            Panel3.Visible:= true;
            //���������� ��������� ���������, ����������� �������
            Label1.Caption:= IntToStr(TrackBar4.Position) + ':' + IntToStr(TrackBar5.Position) + ':' + IntToStr(TrackBar6.Position);
            Label1.Left:= Form1.width div 2 - label1.width div 2;
            //���������� ������� ���� �� ���������
            Label1.Font.Color:= clWindowText;
            //���������� ������ �� ��������
            Label2.Caption:= '����� 0/' + IntToStr(TrackBar7.Position);
            //����������
            Label2.Left:= Form1.width div 2 - label2.width div 2;
            Timer6.Enabled:= false; //��������� ����� ������� ������ ����
          end
          else begin
            Button1.Caption:= '���������';
            Button2.Enabled:= true;
            Button3.Enabled:= true;
            radiogroup1.Enabled:= true;
            Panel3.Visible:= false;
            //������� ���������� ������� �������
            //���������� ���������� Ttime3 � ������ �����
            Time3:= StrToTime(Label1.Caption);
            //������������ ������� � ������� �������
            Label1.Caption:= TimeToStr(Time3);
            Label1.Left:= Form1.width div 2 - label1.width div 2;
            Timer6.Enabled:= true; //�������� ����� ������� ������ ����
          end;
        end;
    //������ ������
    3:  begin
          if Button1.Caption = '���������'  then begin
            Button1.Caption:= '���������';
            Button2.Enabled:= false;
            Button3.Enabled:= false;
            radiogroup1.Enabled:= false;
            Panel4.Visible:= true;
            //���������� ��������� ���������, ����������� �������
            Label1.Caption:= IntToStr(TrackBar8.Position) + ':' + IntToStr(TrackBar9.Position) + ':' + IntToStr(TrackBar10.Position);
            Label1.Left:= Form1.width div 2 - label1.width div 2;
            Label3.Caption:= IntToStr(TrackBar11.Position) + ':' + IntToStr(TrackBar12.Position) + ':' + IntToStr(TrackBar13.Position);
            Label3.Left:= Form1.width div 2 - label3.width div 2;
            Label4.Caption:= '����� ' + IntToStr(i1) + '/' + IntToStr(TrackBar14.Position);
            Label4.Left:= Form1.width div 2 - label4.width div 2;
            Timer6.Enabled:= false; //��������� ����� ������� ������ ����
          end
          else begin
            Button1.Caption:= '���������';
            Button2.Enabled:= true;
            Button3.Enabled:= true;
            radiogroup1.Enabled:= true;
            Panel4.Visible:= false;
            //������� ���������� �������� ������
            //���������� ���������� Ttime4, Ttime4_1, � ������ �����
            Time4:= StrToTime(Label1.Caption);
            Time4_1:= StrToTime(Label3.Caption);
            //������������ ������� � ������� �������
            Label1.Caption:= TimeToStr(Time4);
            Label1.Left:= Form1.width div 2 - Label1.width div 2;
            Label3.Caption:= TimeToStr(Time4_1);
            Label3.Left:= Form1.width div 2 - Label3.width div 2;
            //���������� ������ �� ��������
            Label4.Caption:= '����� 0/' + IntToStr(TrackBar14.Position);
            //����������
            Label4.Left:= Form1.width div 2 - label4.width div 2;
            Timer6.Enabled:= true; //�������� ����� ������� ������ ����
          end;
        end;
    end;
end;

//������ *��������*
procedure TForm1.Button2Click(Sender: TObject);
begin
    case RadioGroup1.ItemIndex of
      1:  begin
            //���������� ��������� ���������, ����������� �������
            Label1.Caption:= IntToStr(TrackBar1.Position) + ':' + IntToStr(TrackBar2.Position) + ':' + IntToStr(TrackBar3.Position);
            Label1.Left:= Form1.width div 2 - label1.width div 2;
            //���������� ������� ���� �� ���������
            Label1.Font.Color:= clWindowText;
            //���������� ���������� Ttime2 � ������ �����
            //(���������� �� �������� ���������)
            Time2:= StrToTime(Label1.Caption);
            //������������ ������� � ������� �������
            Label1.Caption:= TimeToStr(Time2);
            Label1.Left:= Form1.width div 2 - label1.width div 2;
            Button1.Enabled:= true;    //���������� ������ "���������"
            Button3.Enabled:= true;     //���������� ������ *�����*
            RadioGroup1.Enabled:= true; //���������� RadioGroup1
          end;
      2:  begin
            //���������� ��������� ���������, ����������� �������
            Label1.Caption:= IntToStr(TrackBar4.Position) + ':' + IntToStr(TrackBar5.Position) + ':' + IntToStr(TrackBar6.Position);
            Label1.Left:= Form1.width div 2 - label1.width div 2;
            //���������� ������� ���� �� ���������
            Label1.Font.Color:= clWindowText;
            //���������� ���������� Ttime2 � ������ �����
            //(���������� �� �������� ���������)
            Time3:= StrToTime(Label1.Caption);
            //������������ ������� � ������� �������
            Label1.Caption:= TimeToStr(Time3);
            Label1.Left:= Form1.width div 2 - label1.width div 2;
            Button1.Enabled:= true;    //���������� ������ "���������"
            Button3.Enabled:= true;     //���������� ������ *�����*
            RadioGroup1.Enabled:= true; //���������� RadioGroup1
            //���������� ������ �� ��������
            Label2.Caption:= '����� 0/' + IntToStr(TrackBar7.Position);
            //����������
            Label2.Left:= Form1.width div 2 - label2.width div 2;
          end;
      3:  begin
          //���������� ��������� ���������, ����������� �������
            Label1.Caption:= IntToStr(TrackBar8.Position) + ':' + IntToStr(TrackBar9.Position) + ':' + IntToStr(TrackBar10.Position);
            Label3.Caption:= IntToStr(TrackBar11.Position) + ':' + IntToStr(TrackBar12.Position) + ':' + IntToStr(TrackBar13.Position);
            Label4.Caption:= '����� 0/' + IntToStr(TrackBar14.Position);
            Label1.Left:= Form1.width div 2 - label1.width div 2;
            Label3.Left:= Form1.width div 2 - label3.width div 2;
            Label4.Left:= Form1.width div 2 - label4.width div 2;
            //���������� ������� ���� �� ���������
            Label1.Font.Color:= clWindowText;
            //���������� ���������� Ttime2 � ������ �����
            //(���������� �� �������� ���������)
            Time4:= StrToTime(Label1.Caption);
            Time4_1:= StrToTime(Label3.Caption);
            //������������ ������� � ������� �������
            Label1.Caption:= TimeToStr(Time4);
            Label3.Caption:= TimeToStr(Time4_1);
            Label1.Left:= Form1.width div 2 - label1.width div 2;
            Label3.Left:= Form1.width div 2 - label3.width div 2;
            Button1.Enabled:= true;    //���������� ������ "���������"
            Button3.Enabled:= true;     //���������� ������ *�����*
            RadioGroup1.Enabled:= true; //���������� RadioGroup1
            //���������� ������ �� ��������
//            Label2.Caption:= '����� 0/' + IntToStr(TrackBar7.Position);
            //����������
  //          Label2.Left:= Form1.width div 2 - label2.width div 2;

          end;
    end;
end;

//������ *�����/����*
procedure TForm1.Button3Click(Sender: TObject);
begin
  case RadioGroup1.ItemIndex of
    //������ ������
    1:  begin
          if Button3.Caption = '�����' then begin
            Button3.Caption:= '����'; //����� �� ������ "����"
            Button2.Enabled:= false;  //����� ������ "��������"
            Button1.Enabled:= false;  //����� ������ "���������"
            Timer2.Enabled:= true;    //���������� Timer2
            RadioGroup1.Enabled:= false;  //����� RadioGroup1
            windows.beep(1000,1000);
          end
          else begin
            Button3.Caption:= '�����'; //����� �� ������ "�����"
            Button2.Enabled:= true;    //���������� ������ "��������"
            Button1.Enabled:= true;    //���������� ������ "���������"
            Timer2.Enabled:= false;    //������������� Timer2
            RadioGroup1.Enabled:= true; //���������� RadioGroup1
            windows.beep(900,1000);
          end;
        end;
    //������� ��������
    2:  begin
           if Button3.Caption = '�����' then begin
            Button3.Caption:= '����'; //����� �� ������ "����"
            Button2.Enabled:= false;  //����� ������ "��������"
            Button1.Enabled:= false;  //����� ������ "���������"
            Time3:= StrToTime(Label1.Caption);
            Timer3.Enabled:= true;    //���������� Timer2
            RadioGroup1.Enabled:= false;  //����� RadioGroup1
            r_pm1:=1;
            Label2.Caption:= '����� ' + IntToStr(r_pm1)+ '/' + IntToStr(TrackBar7.Position);
            //����������
            Label2.Left:= Form1.width div 2 - label2.width div 2;
            windows.beep(1000,1000);
          end
          else begin
            Button3.Caption:= '�����'; //����� �� ������ "�����"
            Button2.Enabled:= true;    //���������� ������ "��������"
            Button1.Enabled:= true;    //���������� ������ "���������"
            Timer3.Enabled:= false;    //������������� Timer2
            RadioGroup1.Enabled:= true; //���������� RadioGroup1
            windows.beep(900,1000);
          end;
        end;
    //������� ������
    3:  begin
            if Button3.Caption = '�����' then begin
            Button3.Caption:= '����'; //����� �� ������ "����"
            Button2.Enabled:= false;  //����� ������ "��������"
            Button1.Enabled:= false;  //����� ������ "���������"
            Time4:= StrToTime(Label1.Caption);
            Time4_1:= StrToTime(Label3.Caption);
            Timer4.Enabled:= true;    //���������� Timer2
            RadioGroup1.Enabled:= false;  //����� RadioGroup1
            r_tab1:=1;
            Label4.Caption:= '����� ' + IntToStr(r_tab1)+ '/' + IntToStr(TrackBar14.Position);
            //����������
            Label4.Left:= Form1.width div 2 - label4.width div 2;
            windows.beep(1000,1000);
          end
          else begin
            Button3.Caption:= '�����'; //����� �� ������ "�����"
            Button2.Enabled:= true;    //���������� ������ "��������"
            Button1.Enabled:= true;    //���������� ������ "���������"
            Timer4.Enabled:= false;    //������������� Timer2
            RadioGroup1.Enabled:= true; //���������� RadioGroup1
            windows.beep(900,1000);
          end;

        end;
  end;
end;

//������ *��������/��������*
procedure TForm1.Button4Click(Sender: TObject);
begin
  if Button4.Caption = '��������' then
    begin
      Button4.Caption:= '��������';
      Form2.Show;
    end else
    begin
      Button4.Caption:= '��������';
      Form2.Close;
    end;
//  end;
//  i:=5;
//  timer5.Enabled:= true;}

end;

//����� ����������
procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
    //���� ������� "����"
    if RadioGroup1.ItemIndex = 0 then
    begin
        Button1.enabled:= false;
        Button2.enabled:= false;
        Button3.enabled:= false;
        timer1.Enabled:= true;
    end else
    begin
        Button1.enabled:= true;
        Button2.enabled:= true;
        Button3.enabled:= true;
        timer1.Enabled:= false;
    end;
    //����������/������ ������� 2 ���� ������� �������� (������ ��������� = 2)
    if RadioGroup1.ItemIndex = 2 then Label2.Visible:= true else Label2.Visible:= false;
    //����������/������ ������� 3 ���� ������� ������ (������ ��������� = 3)
    if RadioGroup1.ItemIndex = 3 then Label3.Visible:= true else Label3.Visible:= false;
    //����������/������ ������� 4 ���� ������� ������ (������ ��������� = 3)
    if RadioGroup1.ItemIndex = 3 then Label4.Visible:= true else Label4.Visible:= false;
    //���������� ���������
    case RadioGroup1.ItemIndex of
    0:  begin //������� ����

        end;
    1:  begin  //������ ������
        //���������� �������, ������������ �������
          Label1.Caption:= IntToStr(TrackBar1.Position) + ':' + IntToStr(TrackBar2.Position) + ':' + IntToStr(TrackBar3.Position);
          Time2:= StrToTime(Label1.Caption); //���������� ���������� �� ��������
          Label1.Caption:= TimeToStr(Time2); //�������������� ������� � ������� �������
          Label1.Left:= Form1.width div 2 - label1.width div 2; //����������
          Form2.Label1.Caption:= Label1.Caption; //�������������� ������� �� ������ �����
          Form2.Label1.Left:= Form2.Width div 2 - Form2.Label1.Width div 2;
        end;
    2:  begin  //������� ��������
          Label1.Caption:= IntToStr(TrackBar4.Position) + ':' + IntToStr(TrackBar5.Position) + ':' + IntToStr(TrackBar6.Position);
          Time3:= StrToTime(Label1.Caption); //���������� ���������� �� ��������
          Label1.Caption:= TimeToStr(Time3); //�������������� ������� � ������� �������
          Label1.Left:= Form1.width div 2 - label1.width div 2; //����������
          Label2.Caption:= '����� ' + IntToStr(i) + '/' + IntToStr(TrackBar7.Position); //���������� ������ �� ��������
          Label2.Left:= Form1.width div 2 - label2.width div 2; //����������
          Form2.Label1.Caption:= Label1.Caption; //�������������� ������� �� ������ �����
          Form2.Label1.Left:= Form2.Width div 2 - Form2.Label1.Width div 2;
        end;
    3:  begin  //������� ������
          //������� ����� ������
          Label1.Caption:= IntToStr(TrackBar8.Position) + ':' + IntToStr(TrackBar9.Position) + ':' + IntToStr(TrackBar10.Position);
          Time4:= StrToTime(Label1.Caption); //���������� ���������� �� ��������
          Label1.Caption:= TimeToStr(Time4); //�������������� ������� � ������� �������
          Label1.Left:= Form1.width div 2 - label1.width div 2; //����������
          //������� ����� ������
          Label3.Caption:= IntToStr(TrackBar11.Position) + ':' + IntToStr(TrackBar12.Position) + ':' + IntToStr(TrackBar13.Position);
          Time4_1:= StrToTime(Label3.Caption); //���������� ���������� �� ��������
          Label3.Caption:= TimeToStr(Time4_1); //�������������� ������� � ������� �������
          Label3.Left:= Form1.width div 2 - label3.width div 2; //����������
          //������� ������
          Label4.Caption:= '����� ' + IntToStr(i) + '/' + IntToStr(TrackBar14.Position); //���������� ������ �� ��������
          Label4.Left:= Form1.width div 2 - label4.width div 2; //����������

        end;
    end;
end;

//------------����---------------//
procedure TForm1.Timer1Timer(Sender: TObject);
  var Time1 : TDateTime; // ������� �����
begin
    Time1 := Now(); // �������� ��������� �����
    Label1.Caption:= FormatDateTime('hh:mm:ss',Time1);
    Label1.Left:= Form1.width div 2 - label1.width div 2;
    Form2.Label1.Caption:= Label1.Caption;
    Form2.Label1.Left:= Form2.Width div 2 - Form2.Label1.Width div 2;
    //    TForm2.OnResize;
end;
//------------����� ����---------------//

//-----------������--------------//
procedure TForm1.Timer2Timer(Sender: TObject);
begin
    if Time2 > (1/24/60/61) then begin
        Timer2.Enabled:= true;
        Time2:= Time2 - (1/24/60/60);
        Label1.Caption:= TimeToStr(Time2);
        Label1.Left:= Form1.width div 2 - label1.width div 2;
        Form2.Label1.Caption:= Label1.Caption;
        Form2.Label1.Left:= Form2.width div 2 - Form2.label1.width div 2;
    end else
    begin
        Timer2.Enabled:= false;
        Label1.Font.Color:= clRed;
        Button2.Enabled:= true;
        Button3.Caption:= '�����';
        Button3.Enabled:= false;
        windows.beep(1500,1500);
    end;
end;
//������� ����
procedure TForm1.TrackBar1Change(Sender: TObject);
begin
    Label1.Caption:= IntToStr(TrackBar1.Position) + ':' + IntToStr(TrackBar2.Position) + ':' + IntToStr(TrackBar3.Position);
    Label1.Left:= Form1.width div 2 - label1.width div 2;
end;
//������� ������
procedure TForm1.TrackBar2Change(Sender: TObject);
begin
    Label1.Caption:= IntToStr(TrackBar1.Position) + ':' + IntToStr(TrackBar2.Position) + ':' + IntToStr(TrackBar3.Position);
    Label1.Left:= Form1.width div 2 - label1.width div 2;

end;
//������� �������
procedure TForm1.TrackBar3Change(Sender: TObject);
begin
    Label1.Caption:= IntToStr(TrackBar1.Position) + ':' + IntToStr(TrackBar2.Position) + ':' + IntToStr(TrackBar3.Position);
    Label1.Left:= Form1.width div 2 - label1.width div 2;
end;
//-----------����� �������--------------//
//////////////////////////////////////////
//-----------��������------------------//
//������� ������
procedure TForm1.TrackBar7Change(Sender: TObject);
begin
    Label2.Caption:= '����� ' + IntToStr(i) + '/' + IntToStr(TrackBar7.Position);
    Label2.Left:= Form1.width div 2 - label2.width div 2;
end;
//������� �������
procedure TForm1.TrackBar6Change(Sender: TObject);
begin
    Label1.Caption:= IntToStr(TrackBar4.Position) + ':' + IntToStr(TrackBar5.Position) + ':' + IntToStr(TrackBar6.Position);
    Label1.Left:= Form1.width div 2 - label1.width div 2;
end;
//������� ������
procedure TForm1.TrackBar5Change(Sender: TObject);
begin
    Label1.Caption:= IntToStr(TrackBar4.Position) + ':' + IntToStr(TrackBar5.Position) + ':' + IntToStr(TrackBar6.Position);
    Label1.Left:= Form1.width div 2 - label1.width div 2;
end;
//������� ����
procedure TForm1.TrackBar4Change(Sender: TObject);
begin
    Label1.Caption:= IntToStr(TrackBar4.Position) + ':' + IntToStr(TrackBar5.Position) + ':' + IntToStr(TrackBar6.Position);
    Label1.Left:= Form1.width div 2 - label1.width div 2;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
    if r_pm1 <= TrackBar7.Position  then begin                  //���� ������� ������ ������ ��� ����� �������������� ��������
        if Time3 > (1/24/60/61) then begin                        //���� ������ ������ ����� ������ 0,983 ������
          Time3:= Time3 - (1/24/60/60);                             //��������� ����� �� 1 �������
          Label1.Caption:= TimeToStr(Time3);                        //������������ ���������
          Label1.Left:= Form1.width div 2 - label1.width div 2;     //���������� �������
        end else                                                  //����� (��������� ����� �����)
        begin
          if r_pm1 = TrackBar7.Position then begin                 //���� ����� �����������
            Timer3.Enabled:= false;                                       //������������� ������
            Label1.Font.Color:= clRed;                                    //������ ������� � ������� ����
            Button2.Enabled:= true;                                       //���������� ������ ��������
            Button3.Enabled:= false;                                      //����� ������ ����
            Button3.Caption:= '�����';                                    //������ ������� �� ������
            windows.beep(1500,1500);
            exit;                                                    //��������� ���������
          end;
          //���������� ������ �����, ����������� ����
          Label1.Caption:= IntToStr(TrackBar4.Position) + ':' + IntToStr(TrackBar5.Position) + ':' + IntToStr(TrackBar6.Position);
          Time3:= StrToTime(Label1.Caption); //���������� ���������� �� ��������
          Label1.Caption:= TimeToStr(Time3); //�������������� ������� � ������� �������
          Label1.Left:= Form1.width div 2 - label1.width div 2; //����������
          r_pm1:= r_pm1 + 1;
          Label2.Caption:= '����� ' + IntToStr(r_pm1)+ '/' + IntToStr(TrackBar7.Position);
          windows.beep(1000,1000);
        end;
    end;
end;

//-----------����� ��������------------------//
///////////////////////////////////////////////
//-------------������------------//
//������� ���� ������ ������
procedure TForm1.TrackBar8Change(Sender: TObject);
begin
    Label1.Caption:= IntToStr(TrackBar8.Position) + ':' + IntToStr(TrackBar9.Position) + ':' + IntToStr(TrackBar10.Position);
    Label1.Left:= Form1.width div 2 - label1.width div 2;
end;
//������� ������ ������ ������
procedure TForm1.TrackBar9Change(Sender: TObject);
begin
    Label1.Caption:= IntToStr(TrackBar8.Position) + ':' + IntToStr(TrackBar9.Position) + ':' + IntToStr(TrackBar10.Position);
    Label1.Left:= Form1.width div 2 - label1.width div 2;
end;
//������� ������� ������ ������
procedure TForm1.TrackBar10Change(Sender: TObject);
begin
    Label1.Caption:= IntToStr(TrackBar8.Position) + ':' + IntToStr(TrackBar9.Position) + ':' + IntToStr(TrackBar10.Position);
    Label1.Left:= Form1.width div 2 - label1.width div 2;
end;
//������� ���� ������ ������
procedure TForm1.TrackBar11Change(Sender: TObject);
begin
    Label3.Caption:= IntToStr(TrackBar11.Position) + ':' + IntToStr(TrackBar12.Position) + ':' + IntToStr(TrackBar13.Position);
    Label3.Left:= Form1.width div 2 - label3.width div 2;
end;
//������� ������ ������ ������
procedure TForm1.TrackBar12Change(Sender: TObject);
begin
    Label3.Caption:= IntToStr(TrackBar11.Position) + ':' + IntToStr(TrackBar12.Position) + ':' + IntToStr(TrackBar13.Position);
    Label3.Left:= Form1.width div 2 - label3.width div 2;
end;
//������� ������� ������ ������
procedure TForm1.TrackBar13Change(Sender: TObject);
begin
    Label3.Caption:= IntToStr(TrackBar11.Position) + ':' + IntToStr(TrackBar12.Position) + ':' + IntToStr(TrackBar13.Position);
    Label3.Left:= Form1.width div 2 - label3.width div 2;
end;

procedure TForm1.TrackBar14Change(Sender: TObject);
begin
    Label4.Caption:= '����� ' + IntToStr(i1) + '/' + IntToStr(TrackBar14.Position);
    Label4.Left:= Form1.width div 2 - label4.width div 2;
end;

procedure TForm1.Timer4Timer(Sender: TObject);
begin

if r_tab1 <= TrackBar14.Position  then begin                  //���� ������� ������ ������ ��� ����� �������������� ��������
    if Time4 > (1/24/60/61) then begin                        //���� ������ ������ ����� ������ 0,983 ������
          Time4:= Time4 - (1/24/60/60);                             //��������� ����� �� 1 �������
          Label1.Caption:= TimeToStr(Time4);                        //������������ ���������
          Label1.Left:= Form1.width div 2 - label1.width div 2;     //���������� �������
        end else                                                  //����� (��������� ����� �����)
        begin
        if Time4_1 > (1/24/60/61) then begin                        //���� ������ ������ ����� ������ 0,983 ������
          Time4_1:= Time4_1 - (1/24/60/60);                             //��������� ����� �� 1 �������
          Label3.Caption:= TimeToStr(Time4_1);                        //������������ ���������
          Label3.Left:= Form1.width div 2 - label3.width div 2;     //���������� �������
        end;
    end;

        if (r_tab1 = TrackBar14.Position) and (Time4_1 < (1/24/60/61))then begin                 //���� ����� �����������
            Timer4.Enabled:= false;                                       //������������� ������
            Label1.Font.Color:= clRed;                                    //������ ������� � ������� ����
            Button2.Enabled:= true;                                       //���������� ������ ��������
            Button3.Enabled:= false;                                      //����� ������ ����
            Button3.Caption:= '�����';                                    //������ ������� �� ������
            windows.beep(1500,1500);
            exit;                                                    //��������� ���������
        end;

        if Time4_1 <= (1/24/60/61) then begin
          //���������� ������ �����, ����������� ����
          Label1.Caption:= IntToStr(TrackBar8.Position) + ':' + IntToStr(TrackBar9.Position) + ':' + IntToStr(TrackBar10.Position);
          Label3.Caption:= IntToStr(TrackBar11.Position) + ':' + IntToStr(TrackBar12.Position) + ':' + IntToStr(TrackBar13.Position);
          Time4:= StrToTime(Label1.Caption); //���������� ���������� �� ��������
          Time4_1:= StrToTime(Label3.Caption); //���������� ���������� �� ��������
          Label1.Caption:= TimeToStr(Time4); //�������������� ������� � ������� �������
          Label3.Caption:= TimeToStr(Time4_1); //�������������� ������� � ������� �������
          Label1.Left:= Form1.width div 2 - label1.width div 2; //����������
          Label3.Left:= Form1.width div 2 - label3.width div 2; //����������
          r_tab1:= r_tab1 + 1;
          Label4.Caption:= '����� ' + IntToStr(r_tab1)+ '/' + IntToStr(TrackBar14.Position);
          windows.beep(1000,1000);
        end;

end;

end;
//-------------����� ������------------//
////////////////////////////////////////
//---------------�������� ������----------//
procedure TForm1.Timer5Timer(Sender: TObject);
begin
  if i > 0 then begin
      Label5.Visible:= True;
      Label5.Caption:= IntToStr(i);
//      Label5.Color:= bsClear;
      Label5.Left:= Form1.width div 2 - label5.width div 2;
      dec(i);
      windows.beep(1000,50);
    end else begin
      Timer5.Enabled:= false;
      Label5.Visible:= false;
      windows.beep(0,100);
      windows.beep(1500,1000);
//    end;
  end;


end;

//������������ ��������� ������ ���� � ������� 1 ���.
//� ���� true ���� ������ "�����/����"
procedure TForm1.Timer6Timer(Sender: TObject);
begin
{  if d and i2 < 100 then begin
    inc(i2);
    else
    d:=false;
  end;}
  if getasynckeystate($01)<>0 then begin //���� ������ ������ ����
    inc(i_timer6);                         //��������� ������� �������
    Label6.Caption:= IntToStr(i_timer6);
  end;
  if i_timer6=9 then begin                //���� ������� ������� ������ 10 ����������
    Button3.Click;                        //���� ������ "�����/����"
//    d:= true;
    i_timer6:= -50;                        //���������� �������
  end;

end;

//---------------����� �������� ������----------//

//��������� �����, ���������� �������� ��������
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  IniFile.WriteInteger('Form info','TrackBar1.Position',TrackBar1.Position);
  IniFile.WriteInteger('Form info','TrackBar2.Position',TrackBar2.Position);
  IniFile.WriteInteger('Form info','TrackBar3.Position',TrackBar3.Position);
  IniFile.WriteInteger('Form info','TrackBar4.Position',TrackBar4.Position);
  IniFile.WriteInteger('Form info','TrackBar5.Position',TrackBar5.Position);
  IniFile.WriteInteger('Form info','TrackBar6.Position',TrackBar6.Position);
  IniFile.WriteInteger('Form info','TrackBar7.Position',TrackBar7.Position);
  IniFile.WriteInteger('Form info','TrackBar8.Position',TrackBar8.Position);
  IniFile.WriteInteger('Form info','TrackBar9.Position',TrackBar9.Position);
  IniFile.WriteInteger('Form info','TrackBar10.Position',TrackBar10.Position);
  IniFile.WriteInteger('Form info','TrackBar11.Position',TrackBar11.Position);
  IniFile.WriteInteger('Form info','TrackBar12.Position',TrackBar12.Position);
  IniFile.WriteInteger('Form info','TrackBar13.Position',TrackBar13.Position);
  IniFile.WriteInteger('Form info','TrackBar14.Position',TrackBar14.Position);
  IniFile.Free;
end;
end.
