program Project1;
{$IF CompilerVersion >= 21.0}
{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
{$IFEND}

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1} ,
  Unit2 in 'Unit2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title             := 'IP…®√Ë';
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
