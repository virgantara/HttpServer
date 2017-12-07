program HttpServer;

uses
  Forms,
  uFrmMain in 'uFrmMain.pas' {Form1},
  uIniFileProcs in 'uIniFileProcs.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
