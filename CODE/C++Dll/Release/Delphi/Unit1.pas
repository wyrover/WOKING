unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  CTest = class(TObject)
  private
    FhModule: THandle;
  public
    constructor Create;
    function fnTest(): Integer;                   // 1020
    procedure CTest();                            // 1070
    function MyAdd(const a, b: Integer): Integer; // 10A0
  end;

type
  TForm1 = class(TForm)
    btn1: TButton;
    btn2: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FTest: CTest;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

// function fnTest(): Integer; stdcall; external 'test.dll' name '?fnTest@@YAHXZ';
// procedure CTest_CTest(); stdcall; external 'test.dll' name '??0CTest@@QEAA@XZ';

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
begin
  FTest.fnTest;
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  FTest.CTest();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FTest := CTest.Create;
end;

{ CTest }

constructor CTest.Create;
begin
  inherited;
  FhModule := LoadLibrary('test.dll');
end;

procedure CTest.CTest;
var
  intAddress: Integer;
begin
  intAddress := FhModule + $1050;
  asm
    jmp intAddress;
  end;
end;

function CTest.fnTest: Integer;
var
  intAddress: Integer;
begin
  Result     := 0;
  intAddress := FhModule + $1020;
  asm
    push eax
    jmp intAddress;
  end;
end;

function CTest.MyAdd(const a, b: Integer): Integer;
begin
  Result := 0;
end;

end.
