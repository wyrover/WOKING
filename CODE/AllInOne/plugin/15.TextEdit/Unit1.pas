unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit2: TEdit;
    Button2: TButton;
    Label2: TLabel;
    Edit3: TEdit;
    Button3: TButton;
    Label3: TLabel;
    Edit4: TEdit;
    Button4: TButton;
    Label4: TLabel;
    Edit5: TEdit;
    Button5: TButton;
    Label5: TLabel;
    Edit6: TEdit;
    Button6: TButton;
    Label7: TLabel;
    Button8: TButton;
    Label8: TLabel;
    Edit7: TEdit;
    Button9: TButton;
    Label10: TLabel;
    Edit8: TEdit;
    Label11: TLabel;
    Edit9: TEdit;
    Button10: TButton;
    Label9: TLabel;
    Button11: TButton;
    Label12: TLabel;
    Button12: TButton;
    Label6: TLabel;
    Button7: TButton;
    Label14: TLabel;
    Label15: TLabel;
    Edit10: TEdit;
    Edit11: TEdit;
    Button15: TButton;
    Button14: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure MyDrag(var Msg: TWMDropFiles); message WM_DropFiles;
  end;

var
  Form1                                 : TForm1;

implementation

{$R *.dfm}

uses ShellAPI, StrUtils, untDrag;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if not OpenDialog1.Execute then Exit;

  Edit1.Text := OpenDialog1.FileName;

end;

procedure DeleteLine(FileName: string; S: string);
var
  MyStringList                          : TStrings;
  i, j, Count                           : Integer;
begin
  FileName := ExtractShortPathName(FileName);
  if not FileExists(FileName) then
  begin
    MessageBox(application.Handle, '没有找到文件', '系统提示：                   dbyoung@sina.com', 64);
    Exit;
  end;

  if S = '' then
  begin
    MessageBox(application.Handle, '请在前面的输入框输入字符串', '系统提示：                   dbyoung@sina.com', 64);
    Exit;
  end;

  CopyFile(pChar(FileName), pChar(FileName + '.bak'), false);
  MyStringList := TStringList.Create;
  MyStringList.LoadFromFile(FileName);
  Count := MyStringList.Count;
  for i := Count - 1 downto 0 do
  begin
    J := pos(UpperCase(s), UpperCase(MyStringList[i]));
    if J <> 0 then
      MyStringList.Delete(i);
  end;
  MyStringList.SaveToFile(FileName);
  MessageBox(Application.Handle, '操作完成！', '系统提示：                   dbyoung@sina.com', 64);
  ShellExecute(Application.Handle, 'Open', 'Notepad.exe', pChar(FileName), nil, SW_SHOW);
end;

procedure DeleteOutLine(FileName: string; S: string);
var
  MyStringList                          : TStrings;
  i, j, Count                           : Integer;
begin
  FileName := ExtractShortPathName(FileName);
  if not FileExists(FileName) then
  begin
    MessageBox(application.Handle, '没有找到文件', '系统提示：                   dbyoung@sina.com', 64);
    Exit;
  end;

  if S = '' then
  begin
    MessageBox(application.Handle, '请在前面的输入框输入字符串', '系统提示：                   dbyoung@sina.com', 64);
    Exit;
  end;

  CopyFile(pChar(FileName), pChar(FileName + '.bak'), false);
  MyStringList := TStringList.Create;
  MyStringList.LoadFromFile(FileName);
  Count := MyStringList.Count;
  for i := Count - 1 downto 0 do
  begin
    J := pos(UpperCase(s), UpperCase(MyStringList[i]));
    if J = 0 then MyStringList.Delete(i);
  end;
  MyStringList.SaveToFile(FileName);
  MessageBox(Application.Handle, '操作完成！', '系统提示：                   dbyoung@sina.com', 64);
  ShellExecute(Application.Handle, 'Open', 'Notepad.exe', pChar(FileName), nil, SW_SHOW);
end;

procedure DeleteHeadIn(FileName: string; S: string);
var
  MyStringList                          : TStrings;
  i, j, Count                           : Integer;
begin
  FileName := ExtractShortPathName(FileName);
  if not FileExists(FileName) then
  begin
    MessageBox(application.Handle, '没有找到文件', '系统提示：                   dbyoung@sina.com', 64);
    Exit;
  end;

  if S = '' then
  begin
    MessageBox(application.Handle, '请在前面的输入框输入字符串', '系统提示：                   dbyoung@sina.com', 64);
    Exit;
  end;

  CopyFile(pChar(FileName), pChar(FileName + '.bak'), false);
  MyStringList := TStringList.Create;
  MyStringList.LoadFromFile(FileName);
  Count := MyStringList.Count;
  for i := Count - 1 downto 0 do
  begin
    J := pos(s, MyStringList[i]);
    if J <> 0 then MyStringList[i] := RightBStr(MyStringList[i], Length(MyStringList[i]) - j - Length(s));
  end;
  MyStringList.SaveToFile(FileName);
  MessageBox(Application.Handle, '操作完成！', '系统提示：                   dbyoung@sina.com', 64);
  ShellExecute(Application.Handle, 'Open', 'Notepad.exe', pChar(FileName), nil, SW_SHOW);
end;

procedure DeleteHeadNo(FileName: string; S: string);
var
  MyStringList                          : TStrings;
  i, j, Count                           : Integer;
begin
  FileName := ExtractShortPathName(FileName);
  if not FileExists(FileName) then
  begin
    MessageBox(application.Handle, '没有找到文件', '系统提示：                   dbyoung@sina.com', 64);
    Exit;
  end;

  if S = '' then
  begin
    MessageBox(application.Handle, '请在前面的输入框输入字符串', '系统提示：                   dbyoung@sina.com', 64);
    Exit;
  end;

  CopyFile(pChar(FileName), pChar(FileName + '.bak'), false);
  MyStringList := TStringList.Create;
  MyStringList.LoadFromFile(FileName);
  Count := MyStringList.Count;
  for i := Count - 1 downto 0 do
  begin
    J := pos(s, MyStringList[i]);
    if J <> 0 then MyStringList[i] := RightBStr(MyStringList[i], Length(MyStringList[i]) - j - 1);
  end;
  MyStringList.SaveToFile(FileName);
  MessageBox(Application.Handle, '操作完成！', '系统提示：                   dbyoung@sina.com', 64);
  ShellExecute(Application.Handle, 'Open', 'Notepad.exe', pChar(FileName), nil, SW_SHOW);
end;

procedure DeleteEndIn(FileName: string; S: string);
var
  MyStringList                          : TStrings;
  i, j, Count                           : Integer;
begin
  FileName := ExtractShortPathName(FileName);
  if not FileExists(FileName) then
  begin
    MessageBox(application.Handle, '没有找到文件', '系统提示：                   dbyoung@sina.com', 64);
    Exit;
  end;

  if S = '' then
  begin
    MessageBox(application.Handle, '请在前面的输入框输入字符串', '系统提示：                   dbyoung@sina.com', 64);
    Exit;
  end;

  CopyFile(pChar(FileName), pChar(FileName + '.bak'), false);
  MyStringList := TStringList.Create;
  MyStringList.LoadFromFile(FileName);
  Count := MyStringList.Count;
  for i := Count - 1 downto 0 do
  begin
    J := pos(s, MyStringList[i]);
    if J <> 0 then MyStringList[i] := LeftBStr(MyStringList[i], J - 1);
  end;
  MyStringList.SaveToFile(FileName);
  MessageBox(Application.Handle, '操作完成！', '系统提示：                   dbyoung@sina.com', 64);
  ShellExecute(Application.Handle, 'Open', 'Notepad.exe', pChar(FileName), nil, SW_SHOW);
end;

procedure DeleteEndNo(FileName: string; S: string);
var
  MyStringList                          : TStrings;
  i, j, Count                           : Integer;
begin
  FileName := ExtractShortPathName(FileName);
  if not FileExists(FileName) then
  begin
    MessageBox(application.Handle, '没有找到文件', '系统提示：                   dbyoung@sina.com', 64);
    Exit;
  end;

  if S = '' then
  begin
    MessageBox(application.Handle, '请在前面的输入框输入字符串', '系统提示：                   dbyoung@sina.com', 64);
    Exit;
  end;

  CopyFile(pChar(FileName), pChar(FileName + '.bak'), false);
  MyStringList := TStringList.Create;
  MyStringList.LoadFromFile(FileName);
  Count := MyStringList.Count;
  for i := Count - 1 downto 0 do
  begin
    J := pos(s, MyStringList[i]);
    if J <> 0 then MyStringList[i] := LeftBStr(MyStringList[i], J + Length(S) - 1);
  end;
  MyStringList.SaveToFile(FileName);
  MessageBox(Application.Handle, '操作完成！', '系统提示：                   dbyoung@sina.com', 64);
  ShellExecute(Application.Handle, 'Open', 'Notepad.exe', pChar(FileName), nil, SW_SHOW);
end;

procedure AddLineNum(FileName: string);
var
  MyStringList                          : TStrings;
  i, Count                              : Integer;
begin
  FileName := ExtractShortPathName(FileName);
  if not FileExists(FileName) then
  begin
    MessageBox(application.Handle, '没有找到文件', '系统提示：                   dbyoung@sina.com', 64);
    Exit;
  end;

  CopyFile(pChar(FileName), pChar(FileName + '.bak'), false);
  MyStringList := TStringList.Create;
  MyStringList.LoadFromFile(FileName);
  Count := MyStringList.Count;
  for i := 0 to Count - 1 do MyStringList[i] := inttostr(i) + Chr(9) + MyStringList[i];
  MyStringList.SaveToFile(FileName);
  MessageBox(Application.Handle, '操作完成！', '系统提示：                   dbyoung@sina.com', 64);
  ShellExecute(Application.Handle, 'Open', 'Notepad.exe', pChar(FileName), nil, SW_SHOW);
end;

procedure SearchReplaceStr(FIleName: string; SearchStr, ReplaceStr: string);
var
  MyStringList                          : TStrings;
  i, j, Count                           : Integer;
begin
  FileName := ExtractShortPathName(FileName);
  if not FileExists(FileName) then
  begin
    MessageBox(application.Handle, '没有找到文件', '系统提示：                   dbyoung@sina.com', 64);
    Exit;
  end;

  if (SearchStr = '') then
  begin
    MessageBox(application.Handle, '请在前面的输入框输入字符串', '系统提示：                   dbyoung@sina.com', 64);
    Exit;
  end;

  CopyFile(pChar(FileName), pChar(FileName + '.bak'), false);
  MyStringList := TStringList.Create;
  MyStringList.LoadFromFile(FileName);
  Count := MyStringList.Count;
  for i := 0 to Count - 1 do
  begin
    J := pos(SearchStr, MyStringList[i]);
    if J <> 0 then
    begin
      MyStringList[i] := StringReplace(MyStringList[i], SearchStr, ReplaceStr, [rfReplaceAll]);
    end;
  end;
  MyStringList.SaveToFile(FileName);
  MessageBox(Application.Handle, '操作完成！', '系统提示：                   dbyoung@sina.com', 64);
  ShellExecute(Application.Handle, 'Open', 'Notepad.exe', pChar(FileName), nil, SW_SHOW);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if TButton(Sender).Tag = 2 then DeleteLine(Edit1.Text, Edit2.Text);
  if TButton(Sender).Tag = 3 then DeleteHeadIn(Edit1.Text, Edit3.Text);
  if TButton(Sender).Tag = 4 then DeleteHeadNo(Edit1.Text, Edit4.Text);
  if TButton(Sender).Tag = 5 then DeleteEndIn(Edit1.Text, Edit5.Text);
  if TButton(Sender).Tag = 6 then DeleteEndNo(Edit1.Text, Edit6.Text);
  if TButton(Sender).Tag = 7 then DeleteOutLine(Edit1.Text, Edit7.Text);
  if TButton(Sender).Tag = 8 then SearchReplaceStr(Edit1.Text, Edit8.Text, Edit9.Text);
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  AddLineNum(Edit1.Text);
end;

procedure DelHelpPas(FileName: string);
var
  PasFileName                           : string;
  a                                     : TStrings; i, Count: integer; s, t: string; StartLine, EndLine, j, k: Integer;
label ppp, qqq;
begin

  PasFileName := FileName;
  if not FileExists(FileName) then
  begin
    MessageBox(application.Handle, '没有找到文件', '系统提示：                   dbyoung@sina.com', 64);
    Exit;
  end;

  CopyFile(pChar(PasFileName), pChar(PasFileName + '.bak'), false);

  //1：如果一行第一个字符是'{'，且第二个字符不是$，最后一个字符是'}'，则删除此行；
  a := TStringList.Create;
  a.LoadFromFile(PasFileName);
  Count := a.Count;
  for i := Count - 1 downto 0 do
  begin
    s := Trim(a.Strings[i]);
    if LeftStr(s, 1) = '{' then
    begin
      if LeftStr(s, 2) <> '{$' then
      begin
        if RightStr(s, 1) = '}' then
        begin
          a.Delete(i);
        end;
      end;
    end;
  end;
  a.SaveToFile(PasFileName);
  a.Free;

  //2：如果一行前两个字符是//，删除行；
  a := TStringList.Create;
  a.LoadFromFile(PasFileName);
  Count := a.Count;
  for i := Count - 1 downto 0 do
  begin
    s := Trim(a.Strings[i]);
    if LeftStr(s, 2) = '//' then
    begin
      a.Delete(i);
    end;
  end;
  a.SaveToFile(PasFileName);
  a.Free;

  //3：如果一行前两个字符是(*，后两个字符是*),删除行；
  a := TStringList.Create;
  a.LoadFromFile(PasFileName);
  Count := a.Count;
  for i := Count - 1 downto 0 do
  begin
    s := Trim(a.Strings[i]);
    if (RightStr(s, 2) = '*)') and (LeftStr(S, 2) = '(*') then a.Delete(i);
  end;
  a.SaveToFile(PasFileName);
  a.Free;

  //4：如果一行最后两个字符是*)，直到找到一行最前的两个字符是(*,删除所有行；
  ppp:
  a := TStringList.Create;
  a.LoadFromFile(PasFileName);
  Count := a.Count;
  for i := Count - 1 downto 0 do
  begin
    s := Trim(a.Strings[i]);
    if RightStr(s, 2) = '*)' then
    begin
      EndLine := i;
      for j := i downto 0 do
      begin
        s := Trim(a.Strings[j]);
        if LeftStr(s, 2) = '(*' then
        begin
          StartLine := j;
          for k := EndLine downto StartLine do a.Delete(k);
          a.SaveToFile(PasFileName);
          a.Free;
          goto ppp;
        end;
      end;
    end;
  end;
  a.Free;


  //4: 如果一行最后是注释{}、(*,*)、//      (或中间暂且忽略
  a := TStringList.Create;
  a.LoadFromFile(PasFileName);
  Count := a.Count;
  for i := 0 to Count - 1 do
  begin
    s := a.Strings[i];
    j := pos('{', s);
    t := midStr(s, j + 1, 1);
    if (j <> 0) and (T <> '$') then
    begin
      if j > 1 then
      begin
        if RightStr(TrimRight(s), 1) = '}' then   //一行
        begin
          a.Strings[i] := LeftStr(a.Strings[i], j - 1);
        end
      end;
    end;
  end;
  a.SaveToFile(PasFileName);
  a.Free;


  //5：如果一行最后一个字符是}，且此行首不是{$，直到找到上一行最前的一个字符是{,且第二个字符不是$,删除所有行；因为一行包含{}的行已经删除，所以不用考虑；
  qqq:
  a := TStringList.Create;
  a.LoadFromFile(PasFileName);
  Count := a.Count;
  for i := Count - 1 downto 0 do
  begin
    s := Trim(a.Strings[i]);
    if (RightStr(s, 1) = '}') and (LeftStr(s, 2) <> '{$') then
    begin
      EndLine := i;
      for j := i downto 0 do
      begin
        s := Trim(a.Strings[j]);
        if (LeftStr(s, 1) = '{') and (LeftStr(S, 2) <> '{$') then
        begin
          StartLine := j;
          for k := EndLine downto StartLine do a.Delete(k);
          a.SaveToFile(PasFileName);
          a.Free;
          goto qqq;
        end;
      end;
    end;
  end;
  a.Free;

  MessageBox(0, '操作完成！', '系统提示：                             dbyoung@sina.com', MB_OK or MB_ICONINFORMATION);
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  DelHelpPas(Edit1.Text);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DragAcceptFiles(Handle, True);
end;

procedure DeleteBlankLine(FileName: string);
var
  MyStringList                          : TStrings;
  i, Count                              : Integer;
begin
  FileName := ExtractShortPathName(FileName);
  if not FileExists(FileName) then
  begin
    MessageBox(application.Handle, '没有找到文件', '系统提示：                   dbyoung@sina.com', 64);
    Exit;
  end;

  CopyFile(pChar(FileName), pChar(FileName + '.bak'), false);
  MyStringList := TStringList.Create;
  MyStringList.LoadFromFile(FileName);
  Count := MyStringList.Count;
  for i := Count - 1 downto 0 do
  begin
    if Trim(MyStringList[i]) = '' then MyStringList.Delete(i);
  end;
  MyStringList.SaveToFile(FileName);
  MessageBox(Application.Handle, '操作完成！', '系统提示：                   dbyoung@sina.com', 64);
  ShellExecute(Application.Handle, 'Open', 'Notepad.exe', pChar(FileName), nil, SW_SHOW);
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
  DeleteBlankLine(Edit1.Text);
end;

procedure TForm1.MyDrag(var Msg: TWMDropFiles);
var
  hDrop                                 : Cardinal;
begin
  hDrop := Msg.Drop;                              //这个是拖放句柄
  Edit1.Text := GetDragFileName(hDrop);           //在这里可以用GetDragFileName和GetDragFileCount)
  //最后记得要用这两句话：
  DragFinish(hDrop);
  Msg.Result := 0;
end;


procedure TForm1.Button12Click(Sender: TObject);
var
  i, Count                              : Integer;
  T                                     : TStrings;
begin
  T := TStringList.Create;
  T.LoadFromFile(Edit1.Text);
  Count := T.Count;
  for i := 0 to Count - 1 do T.Strings[i] := Trim(T.Strings[i]);
  T.SaveToFile(Edit1.Text);
  T.Free;
  ShellExecute(Application.Handle, 'Open', 'Notepad.exe', pChar(Edit1.Text), nil, SW_SHOW);
end;

procedure TForm1.Button14Click(Sender: TObject);
var
  i, Count                              : Integer;
  T                                     : TStrings;
begin
  T := TStringList.Create;
  T.LoadFromFile(Edit1.Text);
  Count := T.Count;
  for i := 0 to Count - 1 do T.Strings[i] := T.Strings[i] + ' ' + Edit10.Text;
  T.SaveToFile(Edit1.Text);
  T.Free;
  ShellExecute(Application.Handle, 'Open', 'Notepad.exe', pChar(Edit1.Text), nil, SW_SHOW);
end;

procedure TForm1.Button15Click(Sender: TObject);
var
  i, Count                              : Integer;
  T                                     : TStrings;
begin
  T := TStringList.Create;
  T.LoadFromFile(Edit1.Text);
  Count := T.Count;
  for i := 0 to Count - 1 do T.Strings[i] := Edit11.Text + ' ' + T.Strings[i];
  T.SaveToFile(Edit1.Text);
  T.Free;
  ShellExecute(Application.Handle, 'Open', 'Notepad.exe', pChar(Edit1.Text), nil, SW_SHOW);
end;

end.

