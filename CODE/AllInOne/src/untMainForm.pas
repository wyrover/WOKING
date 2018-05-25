unit untMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus;

type
  TForm1 = class(TForm)
    pgcAll: TPageControl;
    tsConfig: TTabSheet;
    chkTrayIco: TCheckBox;
    trycnTools: TTrayIcon;
    pmTools: TPopupMenu;
    mniConfig: TMenuItem;
    mniLine0ne: TMenuItem;
    mniExit: TMenuItem;
    mniShowForm: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mniExitClick(Sender: TObject);
    procedure mniConfigClick(Sender: TObject);
    procedure mniShowFormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FbExit: Boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not FbExit then
  begin
    if chkTrayIco.Checked then
    begin
      Hide;
      trycnTools.Visible := True;
      Action             := caNone;
    end
    else
    begin
      Action := caFree;
    end;
  end
  else
  begin
    Action := caFree;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FbExit := False;
end;

procedure TForm1.mniConfigClick(Sender: TObject);
begin
  //
end;

procedure TForm1.mniExitClick(Sender: TObject);
begin
  FbExit := True;
  Close;
end;

procedure TForm1.mniShowFormClick(Sender: TObject);
begin
  //
end;

end.
