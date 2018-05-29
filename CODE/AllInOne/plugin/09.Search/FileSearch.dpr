library FileSearch;
{$IF CompilerVersion >= 21.0}
{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
{$IFEND}

uses
  System.SysUtils,
  System.Classes,
  Unit1 in 'Unit1.pas' {frmFileSearch},
  uMFTSearchFile in 'uMFTSearchFile.pas';

{$R *.res}

exports
  ShowDllForm;

begin

end.
