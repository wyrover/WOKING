program X64;
{$IF CompilerVersion >= 21.0}
{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
{$IFEND}

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {frmCarX64};

{$R *.res}

begin
  Application.Initialize;
  Application.ShowMainForm      := False;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCarX64, frmCarX64);
  Application.Run;

end.
