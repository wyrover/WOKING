program DBInit;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {frmDB};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmDB, frmDB);
  Application.Run;
end.
