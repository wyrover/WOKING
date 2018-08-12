program ccf;
{$IF CompilerVersion >= 21.0}
{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
{$IFEND}

uses
  Vcl.Forms,
  untMainForm in 'untMainForm.pas' {frmCamera},
  untUSBCamera in 'untUSBCamera.pas',
  untEffect in 'untEffect.pas';

{$R *.res}

begin
  OnlyRunOneInstance;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCamera, frmCamera);
  Application.Run;

end.
