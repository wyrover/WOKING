program Test01;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  ffmpeg.Avcodec in '..\Head\ffmpeg.Avcodec.pas',
  ffmpeg.Avdevice in '..\Head\ffmpeg.Avdevice.pas',
  ffmpeg.Avfilter in '..\Head\ffmpeg.Avfilter.pas',
  ffmpeg.Avformat in '..\Head\ffmpeg.Avformat.pas',
  ffmpeg.Avutil in '..\Head\ffmpeg.Avutil.pas',
  ffmpeg.Common in '..\Head\ffmpeg.Common.pas',
  ffmpeg.Swresample in '..\Head\ffmpeg.Swresample.pas',
  ffmpeg.Swscale in '..\Head\ffmpeg.Swscale.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
