program Test01;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  ffmpeg.Avcodec in '..\lib\ffmpeg\ffmpeg.Avcodec.pas',
  ffmpeg.Avdevice in '..\lib\ffmpeg\ffmpeg.Avdevice.pas',
  ffmpeg.Avfilter in '..\lib\ffmpeg\ffmpeg.Avfilter.pas',
  ffmpeg.Avformat in '..\lib\ffmpeg\ffmpeg.Avformat.pas',
  ffmpeg.Avutil in '..\lib\ffmpeg\ffmpeg.Avutil.pas',
  ffmpeg.Common in '..\lib\ffmpeg\ffmpeg.Common.pas',
  ffmpeg.Swresample in '..\lib\ffmpeg\ffmpeg.Swresample.pas',
  ffmpeg.Swscale in '..\lib\ffmpeg\ffmpeg.Swscale.pas',
  ffmpeg.Postproc in '..\lib\ffmpeg\ffmpeg.Postproc.pas',
  ffmpeg.sdl2 in '..\lib\ffmpeg\ffmpeg.sdl2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
