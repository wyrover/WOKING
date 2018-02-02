program hpe;
{$IF CompilerVersion >= 21.0}
{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
{$IFEND}

{$R *.dres}

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {frmHookPE};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmHookPE, frmHookPE);
  Application.Run;
end.
