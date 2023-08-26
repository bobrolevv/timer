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
    procedure Timer5Timer(Sender: TObject);  //таймер обратного отсчета
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
//Time2 - таймер, Time3 - поминуты,
//Time4 - табата - работа, Time4_1 - табата - отдых
  {r_pm0,} r_pm1, {r_tab0,} r_tab1, i, i1, i_timer6: Integer;
  //r_pm0 - счетчик исходных раундов в поминутах;
//r_pm1 - счетчик текущих раундов в поминутах;
//i1 - счетчик раундов в табате;
//i_timer6 - счетчик времени удержания клавиши "старт/стоп"
implementation

uses Unit2;

{$R *.dfm}

//создание формы
procedure TForm1.FormCreate(Sender: TObject);
begin
  pathIni:= extractfilepath(application.ExeName)+'MyIni.ini'; //определяем путь к ini
  IniFile:=TIniFile.Create(pathIni); //инициализируем файл ini
  r_pm1:= 0;
  i_timer6:= 0;
  Time3:= StrToTime('00:00:00');
  Panel2.Align:= alBottom;
  Panel3.Align:= alBottom;
  Panel4.Align:= alBottom;
  Panel2.Caption:= '';
  Panel3.Caption:= '';
  Panel4.Caption:= '';
  //выравниваем отступ сверху
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
  //выравниваем отступ слева крутилок таймера
  TrackBar1.Left:= (Button1.Width div 2 - TrackBar1.Width - 20);
  TrackBar2.Left:= TrackBar1.Left + TrackBar2.Width + 10;
  TrackBar3.Left:= TrackBar2.Left + TrackBar2.Width + 10;;
  //выравниваем отступ слева крутилок поминкут
  TrackBar4.Left:= (Button1.Width div 2 - TrackBar4.Width - 65);
  TrackBar5.Left:= TrackBar4.Left + TrackBar5.Width + 10;
  TrackBar6.Left:= TrackBar5.Left + TrackBar6.Width + 10;
  TrackBar7.Left:= TrackBar6.Left + TrackBar6.Width + 50;
  //выравниваем отступ слева крутилок табаты
  TrackBar8.Left:= (Button1.Width div 2 - TrackBar7.Width - 150);
  TrackBar9.Left:= TrackBar8.Left + TrackBar9.Width + 10;
  TrackBar10.Left:= TrackBar9.Left + TrackBar10.Width + 10;
  TrackBar11.Left:= TrackBar10.Left + TrackBar11.Width + 50;
  TrackBar12.Left:= TrackBar11.Left + TrackBar12.Width + 10;
  TrackBar13.Left:= TrackBar12.Left + TrackBar13.Width + 10;
  TrackBar14.Left:= TrackBar13.Left + TrackBar14.Width + 40;
  //выравниваем надпись1 (основной таймер, часы и т.д.)
  Label1.Font.Size:= Form1.Width div 7;
  Label1.Left:= Form1.width div 2 - label1.width div 2;
  Label1.Top:= Label1.Height div 30;
  //выравниваем надпись2 (раунды в поминутах)
  Label2.Font.Size:= Form1.Width div 15;
  Label2.Left:= Form1.width div 2 - label2.width div 2;
  Label2.Top:= Label1.Top + Label1.Height - (Label1.Height div 7);
  //выравниваем надпись3 (доп таймер в табате)
  Label3.Font.Size:= Form1.Width div 10;
  Label3.Left:= Form1.width div 2 - label3.width div 2;
  Label3.Top:= Label1.Top + Label1.Height - (Label1.Height div 7);
  //выравниваем надпись4 (раунды в табате)
  Label4.Font.Size:= Form1.Width div 15;
  Label4.Left:= Form1.width div 2 - label4.width div 2;
  Label4.Top:= Label3.Top + Label3.Height - (Label3.Height div 7);
  //выравниваем надпись5 (обратный отсчет)
  Label5.Font.Size:= Form1.Width div 5;
  Label5.Left:= Form1.width div 2 - label5.width div 2;
  Label5.Top:= Label1.Top;
  Form1.Constraints.MinHeight:= Label1.Height + 100;
  //считываем значения бегунокв из MyIni.ini
  if FileExists(pathIni) then //проверяем есть ли файл INI
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
  else showmessage('Файл example.ini не найден!');

  end;

procedure TForm1.Panel3Click(Sender: TObject);
begin

end;

//кнопка *настроить/применить*
procedure TForm1.Button1Click(Sender: TObject);
begin
    //опрос селекторов
    case RadioGroup1.ItemIndex of
    //выбран таймер
    1:  begin
          if Button1.Caption = 'настроить' then begin
            Button1.Caption:= 'применить';
            Button2.Enabled:= false;
            Button3.Enabled:= false;
            radiogroup1.Enabled:= false;
            Panel2.Visible:= true;
            //опрашиваем состояние ползунков, выравниваем надпись
            Label1.Caption:= IntToStr(TrackBar1.Position) + ':' + IntToStr(TrackBar2.Position) + ':' + IntToStr(TrackBar3.Position);
            Label1.Left:= Form1.width div 2 - label1.width div 2;
            //возвращаем надписи цвет по умолчанию
            Label1.Font.Color:= clWindowText;
            Timer6.Enabled:= false; //отключаем опрос нажатия кнопки мыши
          end
          else begin
            Button1.Caption:= 'настроить';
            Button2.Enabled:= true;
            Button3.Enabled:= true;
            radiogroup1.Enabled:= true;
            Panel2.Visible:= false;
            //заводим переменную таймера
            //определяем переменную Ttime2 в фомате чисел
            Time2:= StrToTime(Label1.Caption);
            //отрисовываем надпись в формате времени
            Label1.Caption:= TimeToStr(Time2);
            Label1.Left:= Form1.width div 2 - label1.width div 2;
            Timer6.Enabled:= true; //включаем опрос нажатия кнопки мыши
          end;
        end;
    //выбраны поминуты
    2:  begin
          if Button1.Caption = 'настроить' then begin
            Button1.Caption:= 'применить';
            Button2.Enabled:= false;
            Button3.Enabled:= false;
            radiogroup1.Enabled:= false;
            Panel3.Visible:= true;
            //опрашиваем состояние ползунков, выравниваем надпись
            Label1.Caption:= IntToStr(TrackBar4.Position) + ':' + IntToStr(TrackBar5.Position) + ':' + IntToStr(TrackBar6.Position);
            Label1.Left:= Form1.width div 2 - label1.width div 2;
            //возвращаем надписи цвет по умолчанию
            Label1.Font.Color:= clWindowText;
            //сбрасываем раунды по бегункам
            Label2.Caption:= 'раунд 0/' + IntToStr(TrackBar7.Position);
            //центрируем
            Label2.Left:= Form1.width div 2 - label2.width div 2;
            Timer6.Enabled:= false; //отключаем опрос нажатия кнопки мыши
          end
          else begin
            Button1.Caption:= 'настроить';
            Button2.Enabled:= true;
            Button3.Enabled:= true;
            radiogroup1.Enabled:= true;
            Panel3.Visible:= false;
            //заводим переменную таймера поминут
            //определяем переменную Ttime3 в фомате чисел
            Time3:= StrToTime(Label1.Caption);
            //отрисовываем надпись в формате времени
            Label1.Caption:= TimeToStr(Time3);
            Label1.Left:= Form1.width div 2 - label1.width div 2;
            Timer6.Enabled:= true; //включаем опрос нажатия кнопки мыши
          end;
        end;
    //выбран табата
    3:  begin
          if Button1.Caption = 'настроить'  then begin
            Button1.Caption:= 'применить';
            Button2.Enabled:= false;
            Button3.Enabled:= false;
            radiogroup1.Enabled:= false;
            Panel4.Visible:= true;
            //опрашиваем состояние ползунков, выравниваем надписи
            Label1.Caption:= IntToStr(TrackBar8.Position) + ':' + IntToStr(TrackBar9.Position) + ':' + IntToStr(TrackBar10.Position);
            Label1.Left:= Form1.width div 2 - label1.width div 2;
            Label3.Caption:= IntToStr(TrackBar11.Position) + ':' + IntToStr(TrackBar12.Position) + ':' + IntToStr(TrackBar13.Position);
            Label3.Left:= Form1.width div 2 - label3.width div 2;
            Label4.Caption:= 'раунд ' + IntToStr(i1) + '/' + IntToStr(TrackBar14.Position);
            Label4.Left:= Form1.width div 2 - label4.width div 2;
            Timer6.Enabled:= false; //отключаем опрос нажатия кнопки мыши
          end
          else begin
            Button1.Caption:= 'настроить';
            Button2.Enabled:= true;
            Button3.Enabled:= true;
            radiogroup1.Enabled:= true;
            Panel4.Visible:= false;
            //заводим переменные таймеров табаты
            //определяем переменные Ttime4, Ttime4_1, в фомате чисел
            Time4:= StrToTime(Label1.Caption);
            Time4_1:= StrToTime(Label3.Caption);
            //отрисовываем надписи в формате времени
            Label1.Caption:= TimeToStr(Time4);
            Label1.Left:= Form1.width div 2 - Label1.width div 2;
            Label3.Caption:= TimeToStr(Time4_1);
            Label3.Left:= Form1.width div 2 - Label3.width div 2;
            //сбрасываем раунды по бегункам
            Label4.Caption:= 'раунд 0/' + IntToStr(TrackBar14.Position);
            //центрируем
            Label4.Left:= Form1.width div 2 - label4.width div 2;
            Timer6.Enabled:= true; //включаем опрос нажатия кнопки мыши
          end;
        end;
    end;
end;

//кнопка *сбросить*
procedure TForm1.Button2Click(Sender: TObject);
begin
    case RadioGroup1.ItemIndex of
      1:  begin
            //опрашиваем состояние ползунков, выравниваем надпись
            Label1.Caption:= IntToStr(TrackBar1.Position) + ':' + IntToStr(TrackBar2.Position) + ':' + IntToStr(TrackBar3.Position);
            Label1.Left:= Form1.width div 2 - label1.width div 2;
            //возвращаем надписи цвет по умолчанию
            Label1.Font.Color:= clWindowText;
            //определяем переменную Ttime2 в фомате чисел
            //(сбрасываем на значение ползунков)
            Time2:= StrToTime(Label1.Caption);
            //отрисовываем надпись в формате времени
            Label1.Caption:= TimeToStr(Time2);
            Label1.Left:= Form1.width div 2 - label1.width div 2;
            Button1.Enabled:= true;    //активируем кнопку "настроить"
            Button3.Enabled:= true;     //активируем кнопку *старт*
            RadioGroup1.Enabled:= true; //активируем RadioGroup1
          end;
      2:  begin
            //опрашиваем состояние ползунков, выравниваем надпись
            Label1.Caption:= IntToStr(TrackBar4.Position) + ':' + IntToStr(TrackBar5.Position) + ':' + IntToStr(TrackBar6.Position);
            Label1.Left:= Form1.width div 2 - label1.width div 2;
            //возвращаем надписи цвет по умолчанию
            Label1.Font.Color:= clWindowText;
            //определяем переменную Ttime2 в фомате чисел
            //(сбрасываем на значение ползунков)
            Time3:= StrToTime(Label1.Caption);
            //отрисовываем надпись в формате времени
            Label1.Caption:= TimeToStr(Time3);
            Label1.Left:= Form1.width div 2 - label1.width div 2;
            Button1.Enabled:= true;    //активируем кнопку "настроить"
            Button3.Enabled:= true;     //активируем кнопку *старт*
            RadioGroup1.Enabled:= true; //активируем RadioGroup1
            //сбрасываем раунды по бегункам
            Label2.Caption:= 'раунд 0/' + IntToStr(TrackBar7.Position);
            //центрируем
            Label2.Left:= Form1.width div 2 - label2.width div 2;
          end;
      3:  begin
          //опрашиваем состояние ползунков, выравниваем надпись
            Label1.Caption:= IntToStr(TrackBar8.Position) + ':' + IntToStr(TrackBar9.Position) + ':' + IntToStr(TrackBar10.Position);
            Label3.Caption:= IntToStr(TrackBar11.Position) + ':' + IntToStr(TrackBar12.Position) + ':' + IntToStr(TrackBar13.Position);
            Label4.Caption:= 'раунд 0/' + IntToStr(TrackBar14.Position);
            Label1.Left:= Form1.width div 2 - label1.width div 2;
            Label3.Left:= Form1.width div 2 - label3.width div 2;
            Label4.Left:= Form1.width div 2 - label4.width div 2;
            //возвращаем надписи цвет по умолчанию
            Label1.Font.Color:= clWindowText;
            //определяем переменную Ttime2 в фомате чисел
            //(сбрасываем на значение ползунков)
            Time4:= StrToTime(Label1.Caption);
            Time4_1:= StrToTime(Label3.Caption);
            //отрисовываем надпись в формате времени
            Label1.Caption:= TimeToStr(Time4);
            Label3.Caption:= TimeToStr(Time4_1);
            Label1.Left:= Form1.width div 2 - label1.width div 2;
            Label3.Left:= Form1.width div 2 - label3.width div 2;
            Button1.Enabled:= true;    //активируем кнопку "настроить"
            Button3.Enabled:= true;     //активируем кнопку *старт*
            RadioGroup1.Enabled:= true; //активируем RadioGroup1
            //сбрасываем раунды по бегункам
//            Label2.Caption:= 'раунд 0/' + IntToStr(TrackBar7.Position);
            //центрируем
  //          Label2.Left:= Form1.width div 2 - label2.width div 2;

          end;
    end;
end;

//кнопка *старт/стоп*
procedure TForm1.Button3Click(Sender: TObject);
begin
  case RadioGroup1.ItemIndex of
    //выбран таймер
    1:  begin
          if Button3.Caption = 'старт' then begin
            Button3.Caption:= 'стоп'; //пишем на кнопке "стоп"
            Button2.Enabled:= false;  //гасим кнопку "сбросить"
            Button1.Enabled:= false;  //гасим кнопку "настроить"
            Timer2.Enabled:= true;    //активируем Timer2
            RadioGroup1.Enabled:= false;  //гасим RadioGroup1
            windows.beep(1000,1000);
          end
          else begin
            Button3.Caption:= 'старт'; //пишем на кнопке "старт"
            Button2.Enabled:= true;    //активируем кнопку "сбросить"
            Button1.Enabled:= true;    //активируем кнопку "настроить"
            Timer2.Enabled:= false;    //останавливаем Timer2
            RadioGroup1.Enabled:= true; //активируем RadioGroup1
            windows.beep(900,1000);
          end;
        end;
    //выбраны поминуты
    2:  begin
           if Button3.Caption = 'старт' then begin
            Button3.Caption:= 'стоп'; //пишем на кнопке "стоп"
            Button2.Enabled:= false;  //гасим кнопку "сбросить"
            Button1.Enabled:= false;  //гасим кнопку "настроить"
            Time3:= StrToTime(Label1.Caption);
            Timer3.Enabled:= true;    //активируем Timer2
            RadioGroup1.Enabled:= false;  //гасим RadioGroup1
            r_pm1:=1;
            Label2.Caption:= 'раунд ' + IntToStr(r_pm1)+ '/' + IntToStr(TrackBar7.Position);
            //центрируем
            Label2.Left:= Form1.width div 2 - label2.width div 2;
            windows.beep(1000,1000);
          end
          else begin
            Button3.Caption:= 'старт'; //пишем на кнопке "старт"
            Button2.Enabled:= true;    //активируем кнопку "сбросить"
            Button1.Enabled:= true;    //активируем кнопку "настроить"
            Timer3.Enabled:= false;    //останавливаем Timer2
            RadioGroup1.Enabled:= true; //активируем RadioGroup1
            windows.beep(900,1000);
          end;
        end;
    //выбрана табата
    3:  begin
            if Button3.Caption = 'старт' then begin
            Button3.Caption:= 'стоп'; //пишем на кнопке "стоп"
            Button2.Enabled:= false;  //гасим кнопку "сбросить"
            Button1.Enabled:= false;  //гасим кнопку "настроить"
            Time4:= StrToTime(Label1.Caption);
            Time4_1:= StrToTime(Label3.Caption);
            Timer4.Enabled:= true;    //активируем Timer2
            RadioGroup1.Enabled:= false;  //гасим RadioGroup1
            r_tab1:=1;
            Label4.Caption:= 'раунд ' + IntToStr(r_tab1)+ '/' + IntToStr(TrackBar14.Position);
            //центрируем
            Label4.Left:= Form1.width div 2 - label4.width div 2;
            windows.beep(1000,1000);
          end
          else begin
            Button3.Caption:= 'старт'; //пишем на кнопке "старт"
            Button2.Enabled:= true;    //активируем кнопку "сбросить"
            Button1.Enabled:= true;    //активируем кнопку "настроить"
            Timer4.Enabled:= false;    //останавливаем Timer2
            RadioGroup1.Enabled:= true; //активируем RadioGroup1
            windows.beep(900,1000);
          end;

        end;
  end;
end;

//кнопка *показать/спрятать*
procedure TForm1.Button4Click(Sender: TObject);
begin
  if Button4.Caption = 'показать' then
    begin
      Button4.Caption:= 'спрятать';
      Form2.Show;
    end else
    begin
      Button4.Caption:= 'показать';
      Form2.Close;
    end;
//  end;
//  i:=5;
//  timer5.Enabled:= true;}

end;

//опрос селекторов
procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
    //если выбраны "часы"
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
    //показываем/прячем надпись 2 если выбраны поминуты (индекс селектора = 2)
    if RadioGroup1.ItemIndex = 2 then Label2.Visible:= true else Label2.Visible:= false;
    //показываем/прячем надпись 3 если выбрана табата (индекс селектора = 3)
    if RadioGroup1.ItemIndex = 3 then Label3.Visible:= true else Label3.Visible:= false;
    //показываем/прячем надпись 4 если выбрана табата (индекс селектора = 3)
    if RadioGroup1.ItemIndex = 3 then Label4.Visible:= true else Label4.Visible:= false;
    //опрашиваем селекторы
    case RadioGroup1.ItemIndex of
    0:  begin //выбраны часы

        end;
    1:  begin  //выбран таймер
        //опрашиваем бегунки, отрисоваваем надпись
          Label1.Caption:= IntToStr(TrackBar1.Position) + ':' + IntToStr(TrackBar2.Position) + ':' + IntToStr(TrackBar3.Position);
          Time2:= StrToTime(Label1.Caption); //сбрасываем переменную по бегункам
          Label1.Caption:= TimeToStr(Time2); //перерисовываем надпись в формате времени
          Label1.Left:= Form1.width div 2 - label1.width div 2; //центрируем
          Form2.Label1.Caption:= Label1.Caption; //перерисоваваем надпись на второй форме
          Form2.Label1.Left:= Form2.Width div 2 - Form2.Label1.Width div 2;
        end;
    2:  begin  //выбраны поминуты
          Label1.Caption:= IntToStr(TrackBar4.Position) + ':' + IntToStr(TrackBar5.Position) + ':' + IntToStr(TrackBar6.Position);
          Time3:= StrToTime(Label1.Caption); //сбрасываем переменную по бегункам
          Label1.Caption:= TimeToStr(Time3); //перерисовываем надпись в формате времени
          Label1.Left:= Form1.width div 2 - label1.width div 2; //центрируем
          Label2.Caption:= 'раунд ' + IntToStr(i) + '/' + IntToStr(TrackBar7.Position); //сбрасываем раунды по бегункам
          Label2.Left:= Form1.width div 2 - label2.width div 2; //центрируем
          Form2.Label1.Caption:= Label1.Caption; //перерисоваваем надпись на второй форме
          Form2.Label1.Left:= Form2.Width div 2 - Form2.Label1.Width div 2;
        end;
    3:  begin  //выбрана табата
          //заводим время работы
          Label1.Caption:= IntToStr(TrackBar8.Position) + ':' + IntToStr(TrackBar9.Position) + ':' + IntToStr(TrackBar10.Position);
          Time4:= StrToTime(Label1.Caption); //сбрасываем переменную по бегункам
          Label1.Caption:= TimeToStr(Time4); //перерисовываем надпись в формате времени
          Label1.Left:= Form1.width div 2 - label1.width div 2; //центрируем
          //заводим время отдыха
          Label3.Caption:= IntToStr(TrackBar11.Position) + ':' + IntToStr(TrackBar12.Position) + ':' + IntToStr(TrackBar13.Position);
          Time4_1:= StrToTime(Label3.Caption); //сбрасываем переменную по бегункам
          Label3.Caption:= TimeToStr(Time4_1); //перерисовываем надпись в формате времени
          Label3.Left:= Form1.width div 2 - label3.width div 2; //центрируем
          //заводим раунды
          Label4.Caption:= 'раунд ' + IntToStr(i) + '/' + IntToStr(TrackBar14.Position); //сбрасываем раунды по бегункам
          Label4.Left:= Form1.width div 2 - label4.width div 2; //центрируем

        end;
    end;
end;

//------------часы---------------//
procedure TForm1.Timer1Timer(Sender: TObject);
  var Time1 : TDateTime; // текущее время
begin
    Time1 := Now(); // получить системное время
    Label1.Caption:= FormatDateTime('hh:mm:ss',Time1);
    Label1.Left:= Form1.width div 2 - label1.width div 2;
    Form2.Label1.Caption:= Label1.Caption;
    Form2.Label1.Left:= Form2.Width div 2 - Form2.Label1.Width div 2;
    //    TForm2.OnResize;
end;
//------------конец часы---------------//

//-----------таймер--------------//
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
        Button3.Caption:= 'старт';
        Button3.Enabled:= false;
        windows.beep(1500,1500);
    end;
end;
//заводим часы
procedure TForm1.TrackBar1Change(Sender: TObject);
begin
    Label1.Caption:= IntToStr(TrackBar1.Position) + ':' + IntToStr(TrackBar2.Position) + ':' + IntToStr(TrackBar3.Position);
    Label1.Left:= Form1.width div 2 - label1.width div 2;
end;
//заводим минуты
procedure TForm1.TrackBar2Change(Sender: TObject);
begin
    Label1.Caption:= IntToStr(TrackBar1.Position) + ':' + IntToStr(TrackBar2.Position) + ':' + IntToStr(TrackBar3.Position);
    Label1.Left:= Form1.width div 2 - label1.width div 2;

end;
//заводим секунды
procedure TForm1.TrackBar3Change(Sender: TObject);
begin
    Label1.Caption:= IntToStr(TrackBar1.Position) + ':' + IntToStr(TrackBar2.Position) + ':' + IntToStr(TrackBar3.Position);
    Label1.Left:= Form1.width div 2 - label1.width div 2;
end;
//-----------конец таймера--------------//
//////////////////////////////////////////
//-----------поминуты------------------//
//заводим раунды
procedure TForm1.TrackBar7Change(Sender: TObject);
begin
    Label2.Caption:= 'раунд ' + IntToStr(i) + '/' + IntToStr(TrackBar7.Position);
    Label2.Left:= Form1.width div 2 - label2.width div 2;
end;
//заводим секунды
procedure TForm1.TrackBar6Change(Sender: TObject);
begin
    Label1.Caption:= IntToStr(TrackBar4.Position) + ':' + IntToStr(TrackBar5.Position) + ':' + IntToStr(TrackBar6.Position);
    Label1.Left:= Form1.width div 2 - label1.width div 2;
end;
//заводим минуты
procedure TForm1.TrackBar5Change(Sender: TObject);
begin
    Label1.Caption:= IntToStr(TrackBar4.Position) + ':' + IntToStr(TrackBar5.Position) + ':' + IntToStr(TrackBar6.Position);
    Label1.Left:= Form1.width div 2 - label1.width div 2;
end;
//заводим часы
procedure TForm1.TrackBar4Change(Sender: TObject);
begin
    Label1.Caption:= IntToStr(TrackBar4.Position) + ':' + IntToStr(TrackBar5.Position) + ':' + IntToStr(TrackBar6.Position);
    Label1.Left:= Form1.width div 2 - label1.width div 2;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
    if r_pm1 <= TrackBar7.Position  then begin                  //если счетчик кругов меньше или равен установленному значению
        if Time3 > (1/24/60/61) then begin                        //если таймер одного круга больше 0,983 секуны
          Time3:= Time3 - (1/24/60/60);                             //уменьшаем время на 1 секунду
          Label1.Caption:= TimeToStr(Time3);                        //отрисовываем изменения
          Label1.Left:= Form1.width div 2 - label1.width div 2;     //центрируем надпись
        end else                                                  //иначе (кончилось время круга)
        begin
          if r_pm1 = TrackBar7.Position then begin                 //если круги закончились
            Timer3.Enabled:= false;                                       //останавливаем таймер
            Label1.Font.Color:= clRed;                                    //красим надпись в красный цвет
            Button2.Enabled:= true;                                       //активируем кнопку сбросить
            Button3.Enabled:= false;                                      //гасим кнопку стоп
            Button3.Caption:= 'старт';                                    //меняем надпись на кнопке
            windows.beep(1500,1500);
            exit;                                                    //завершаем процедуру
          end;
          //сбрасываем таймер круга, увеличиваем круг
          Label1.Caption:= IntToStr(TrackBar4.Position) + ':' + IntToStr(TrackBar5.Position) + ':' + IntToStr(TrackBar6.Position);
          Time3:= StrToTime(Label1.Caption); //сбрасываем переменную по бегункам
          Label1.Caption:= TimeToStr(Time3); //перерисовываем надпись в формате времени
          Label1.Left:= Form1.width div 2 - label1.width div 2; //центрируем
          r_pm1:= r_pm1 + 1;
          Label2.Caption:= 'раунд ' + IntToStr(r_pm1)+ '/' + IntToStr(TrackBar7.Position);
          windows.beep(1000,1000);
        end;
    end;
end;

//-----------конец поминуты------------------//
///////////////////////////////////////////////
//-------------табата------------//
//заводим часы работы табаты
procedure TForm1.TrackBar8Change(Sender: TObject);
begin
    Label1.Caption:= IntToStr(TrackBar8.Position) + ':' + IntToStr(TrackBar9.Position) + ':' + IntToStr(TrackBar10.Position);
    Label1.Left:= Form1.width div 2 - label1.width div 2;
end;
//заводим минуты работы табаты
procedure TForm1.TrackBar9Change(Sender: TObject);
begin
    Label1.Caption:= IntToStr(TrackBar8.Position) + ':' + IntToStr(TrackBar9.Position) + ':' + IntToStr(TrackBar10.Position);
    Label1.Left:= Form1.width div 2 - label1.width div 2;
end;
//заводим секунды работы табаты
procedure TForm1.TrackBar10Change(Sender: TObject);
begin
    Label1.Caption:= IntToStr(TrackBar8.Position) + ':' + IntToStr(TrackBar9.Position) + ':' + IntToStr(TrackBar10.Position);
    Label1.Left:= Form1.width div 2 - label1.width div 2;
end;
//заводим часы отдыха табаты
procedure TForm1.TrackBar11Change(Sender: TObject);
begin
    Label3.Caption:= IntToStr(TrackBar11.Position) + ':' + IntToStr(TrackBar12.Position) + ':' + IntToStr(TrackBar13.Position);
    Label3.Left:= Form1.width div 2 - label3.width div 2;
end;
//заводим минуты отдыха табаты
procedure TForm1.TrackBar12Change(Sender: TObject);
begin
    Label3.Caption:= IntToStr(TrackBar11.Position) + ':' + IntToStr(TrackBar12.Position) + ':' + IntToStr(TrackBar13.Position);
    Label3.Left:= Form1.width div 2 - label3.width div 2;
end;
//заводим секунды отдыха табаты
procedure TForm1.TrackBar13Change(Sender: TObject);
begin
    Label3.Caption:= IntToStr(TrackBar11.Position) + ':' + IntToStr(TrackBar12.Position) + ':' + IntToStr(TrackBar13.Position);
    Label3.Left:= Form1.width div 2 - label3.width div 2;
end;

procedure TForm1.TrackBar14Change(Sender: TObject);
begin
    Label4.Caption:= 'раунд ' + IntToStr(i1) + '/' + IntToStr(TrackBar14.Position);
    Label4.Left:= Form1.width div 2 - label4.width div 2;
end;

procedure TForm1.Timer4Timer(Sender: TObject);
begin

if r_tab1 <= TrackBar14.Position  then begin                  //если счетчик кругов меньше или равен установленному значению
    if Time4 > (1/24/60/61) then begin                        //если таймер одного круга больше 0,983 секуны
          Time4:= Time4 - (1/24/60/60);                             //уменьшаем время на 1 секунду
          Label1.Caption:= TimeToStr(Time4);                        //отрисовываем изменения
          Label1.Left:= Form1.width div 2 - label1.width div 2;     //центрируем надпись
        end else                                                  //иначе (кончилось время круга)
        begin
        if Time4_1 > (1/24/60/61) then begin                        //если таймер одного круга больше 0,983 секуны
          Time4_1:= Time4_1 - (1/24/60/60);                             //уменьшаем время на 1 секунду
          Label3.Caption:= TimeToStr(Time4_1);                        //отрисовываем изменения
          Label3.Left:= Form1.width div 2 - label3.width div 2;     //центрируем надпись
        end;
    end;

        if (r_tab1 = TrackBar14.Position) and (Time4_1 < (1/24/60/61))then begin                 //если круги закончились
            Timer4.Enabled:= false;                                       //останавливаем таймер
            Label1.Font.Color:= clRed;                                    //красим надпись в красный цвет
            Button2.Enabled:= true;                                       //активируем кнопку сбросить
            Button3.Enabled:= false;                                      //гасим кнопку стоп
            Button3.Caption:= 'старт';                                    //меняем надпись на кнопке
            windows.beep(1500,1500);
            exit;                                                    //завершаем процедуру
        end;

        if Time4_1 <= (1/24/60/61) then begin
          //сбрасываем таймер круга, увеличиваем круг
          Label1.Caption:= IntToStr(TrackBar8.Position) + ':' + IntToStr(TrackBar9.Position) + ':' + IntToStr(TrackBar10.Position);
          Label3.Caption:= IntToStr(TrackBar11.Position) + ':' + IntToStr(TrackBar12.Position) + ':' + IntToStr(TrackBar13.Position);
          Time4:= StrToTime(Label1.Caption); //сбрасываем переменную по бегункам
          Time4_1:= StrToTime(Label3.Caption); //сбрасываем переменную по бегункам
          Label1.Caption:= TimeToStr(Time4); //перерисовываем надпись в формате времени
          Label3.Caption:= TimeToStr(Time4_1); //перерисовываем надпись в формате времени
          Label1.Left:= Form1.width div 2 - label1.width div 2; //центрируем
          Label3.Left:= Form1.width div 2 - label3.width div 2; //центрируем
          r_tab1:= r_tab1 + 1;
          Label4.Caption:= 'раунд ' + IntToStr(r_tab1)+ '/' + IntToStr(TrackBar14.Position);
          windows.beep(1000,1000);
        end;

end;

end;
//-------------конец табата------------//
////////////////////////////////////////
//---------------обратный отсчет----------//
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

//отслеживание удержание кнопки мыши в течении 1 сек.
//и если true жмем кнопку "старт/стоп"
procedure TForm1.Timer6Timer(Sender: TObject);
begin
{  if d and i2 < 100 then begin
    inc(i2);
    else
    d:=false;
  end;}
  if getasynckeystate($01)<>0 then begin //если нажата кнопка мыши
    inc(i_timer6);                         //запускаем счетчик времени
    Label6.Caption:= IntToStr(i_timer6);
  end;
  if i_timer6=9 then begin                //если нажатие длиться дольше 10 милисекунд
    Button3.Click;                        //жмем кнопку "старт/стоп"
//    d:= true;
    i_timer6:= -50;                        //сбрасываем счетчик
  end;

end;

//---------------конец обратный отсчет----------//

//закрываем форму, запоминаем значения бегунков
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
