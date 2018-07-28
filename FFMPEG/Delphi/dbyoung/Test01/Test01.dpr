program Test01;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  ffmpeg.Avutil.Time in '..\Head\ffmpeg.Avutil.Time.pas',
  ffmpeg.Common in '..\Head\ffmpeg.Common.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
