program Test01;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  untOpenCV in 'untOpenCV.pas',
  untOpenCVType in 'untOpenCVType.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
