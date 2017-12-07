unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Sockets;

type
  TForm1 = class(TForm)
    mmo1: TMemo;
    btnStart: TButton;
    btnStop: TButton;
    btnExit: TButton;
    tcpsrvr1: TTcpServer;
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure tcpsrvr1Accept(Sender: TObject; ClientSocket: TCustomIpClient);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FHost : string;
    FPort : integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  IniFiles, uIniFileProcs;


{$R *.dfm}

procedure TForm1.btnExitClick(Sender: TObject);
begin
  btnStopClick(Sender);
  Close;
end;

procedure TForm1.btnStartClick(Sender: TObject);
begin
  tcpsrvr1.Open;
  mmo1.Lines.Add(DateTimeToStr(Now)+': server started');
end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
  tcpsrvr1.Close;
  mmo1.Lines.Add(DateTimeToStr(Now)+': server stopped');
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  inif : TIniFile;
begin
  inif := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'HttpServer.ini');

  FHost := INIFReadString(inif, 'Server','host','localhost');
  FPort := INIFReadInteger(inif, 'Server','port',7777);

  tcpsrvr1.LocalHost := FHost;
  tcpsrvr1.LocalPort := IntToStr(FPort);
end;

procedure TForm1.tcpsrvr1Accept(Sender: TObject; ClientSocket: TCustomIpClient);
var
  sLine, sPath : string;
  iHTTPPos : integer;
  strList : TStringList;
begin
  sLine := ' ';
  while ClientSocket.Connected and (sLine <> '') do
  begin
    sLine := ClientSocket.Receiveln();
    mmo1.Lines.Add(sLine);

    if Copy(sLine, 1,3) = 'GET' then
    begin
      iHTTPPos := Pos('HTTP', sLine);

      sPath := Copy(sLine, 5, iHTTPPos-6);
      mmo1.Lines.Add('Path: '+sPath);
    end;

    if sPath = '/' then
    begin
      sPath := 'index.html';
    end;
  end;

  if FileExists('htdocs/'+sPath) then
  begin
    strList := TStringList.Create;
    strList.LoadFromFile('htdocs/'+sPath);
    ClientSocket.Sendln('HTTP/1.1 200 OK');
    ClientSocket.Sendln('');
    ClientSocket.Sendln(strList.Text);
    strList.Free;
    Exit;
  end;

  ClientSocket.Sendln('HTTP/1.1 404 Not Found');
  ClientSocket.Sendln('');
  ClientSocket.Sendln('<h1>404 Not Found</h1><br><br>Path: '+sPath);
  ClientSocket.Close;
end;

end.
