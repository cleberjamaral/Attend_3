{------------------------------------------------------------------------------------------------
                       O C E A N O   T E C N O L O G I A
                        M A R    D E    S O L U Ç Õ E S
-------------------------------------------------------------------------------------------------
  1 Criação
    1.1 Data - Hora.: 01/03/2002 08h
    1.2 Local.......: Escritorio Pessoal - Sao Jose
  2 Autoria
    2.1 Analise.....: Cássio Lacerda
    2.2 Programação.: Cleber Jorge Amaral
  3 Descrição
    3.1 Projeto.....: Geral
    3.2 Classe......: Sobre
    3.3 Comentário..: Envia e-mail e abre URL
-------------------------------------------------------------------------------------------------
  1 Atualização
    1.1 Data - Hora.:
    1.2 Local.......:
  2 Autoria
    2.1 Programação.:
  3 Descrição
    3.3 Comentário..:
------------------------------------------------------------------------------------------------}
unit USobre;
//-----------------------------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------------------------
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Gauges, Buttons, jpeg, Menus;
//-----------------------------------------------------------------------------------------------
type
  TfrmSobre = class(TForm)
    timBarraDeProgresso: TTimer;
    Panel2: TPanel;
    panCentral: TPanel;
	 Gauge1: TGauge;
    Image1: TImage;
    labFile: TLabel;
    labDate: TLabel;
    labApp: TLabel;
    btnFechar: TBitBtn;
    labWebSite: TLabel;
    labSuporte1: TLabel;
    labEmailSuporte: TLabel;
    labSuporte2: TLabel;
    Label2: TLabel;
    labMsn1: TLabel;
    labMsn2: TLabel;
    Gauge2: TGauge;
    Image2: TImage;
    Image3: TImage;
    MainMenu1: TMainMenu;
    mitSobre: TMenuItem;
    mitFechar: TMenuItem;
    procedure timBarraDeProgressoTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnFecharClick(Sender: TObject);
    procedure mitFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
//-----------------------------------------------------------------------------------------------
var frmSobre: TfrmSobre;
	Ascending: Bool;
//-----------------------------------------------------------------------------------------------
implementation
//-----------------------------------------------------------------------------------------------
uses UFuncoes;
//-----------------------------------------------------------------------------------------------
{$R *.DFM}
//-----------------------------------------------------------------------------------------------
procedure TfrmSobre.timBarraDeProgressoTimer(Sender: TObject);
begin
	if (Ascending) then begin
		if (Gauge1.Progress < 100)	then begin
			Gauge1.Progress := Gauge1.Progress + 1;
			Gauge2.Progress := Gauge2.Progress - 1;
		end else begin
			Ascending := false;
		end;
	end else begin
		if (Gauge1.Progress > 0) then begin
			Gauge1.Progress := Gauge1.Progress - 1;
			Gauge2.Progress := Gauge2.Progress + 1;
		end else begin
			Ascending := true;
		end;
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmSobre.FormShow(Sender: TObject);
begin
	timBarraDeProgresso.Enabled  := True;
	labApp.Caption  := Application.Title;
	labFile.Caption := 'Arquivo : '+Application.ExeName;
	labDate.Caption := 'Data da liberação: '+DateToStr(FileDateToDateTime(FileAge(Application.ExeName)));
	btnFechar.SetFocus();
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmSobre.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  timBarraDeProgresso.Enabled := False;
  release;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmSobre.FormKeyPress(Sender: TObject; var Key: Char);
begin
	if Key = #27 then Close();
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmSobre.btnFecharClick(Sender: TObject);
begin
	try
		Close();
	except
		MessageDlg('Erro ao fechar a janela!', mtError, [mbOk], 0);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmSobre.mitFecharClick(Sender: TObject);
begin
	Close();
end;

end.
//-----------------------------------------------------------------------------------------------
//   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM
//-----------------------------------------------------------------------------------------------

