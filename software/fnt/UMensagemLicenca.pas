unit UMensagemLicenca;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TfrmMensagemLicenca = class(TForm)
    memMensagem: TMemo;
    timLicenca: TTimer;
	 btnRegistrarDepois: TBitBtn;
	 procedure timLicencaTimer(Sender: TObject);
	 procedure FormClose(Sender: TObject; var Action: TCloseAction);
	 procedure btnRegistrarDepoisClick(Sender: TObject);
  private
	 { Private declarations }
	 tempoEspera: integer;
  public
	 { Public declarations }
	 procedure setarDiasSemRegistro(p_dias: integer);
  end;
//-----------------------------------------------------------------------------------------------
var frmMensagemLicenca: TfrmMensagemLicenca;
//-----------------------------------------------------------------------------------------------
implementation {$R *.DFM}
//-----------------------------------------------------------------------------------------------
procedure TfrmMensagemLicenca.timLicencaTimer(Sender: TObject);
begin
	tempoEspera := tempoEspera-timLicenca.Interval;

	if (tempoEspera <= 0) then begin
		tempoEspera := 0;
		btnRegistrarDepois.Enabled := true;

		btnRegistrarDepois.Caption := 'Registrar Depois';
	end else begin
		btnRegistrarDepois.Caption := 'Registrar Depois... '+IntToStr(tempoEspera div 1000);
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmMensagemLicenca.setarDiasSemRegistro(p_dias: integer);
begin
	timLicenca.Interval := 100; //-- 100 mili segundos
	tempoEspera := p_dias*timLicenca.Interval;

	//-- Tempo mínimo é de 5 segundos
	if (tempoEspera < 5000) then tempoEspera := 5000;

	btnRegistrarDepois.Caption := 'Registrar Depois';
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmMensagemLicenca.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
	if not (btnRegistrarDepois.Enabled) then Abort();
	Release();
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmMensagemLicenca.btnRegistrarDepoisClick(Sender: TObject);
begin
	Close();
end;
//-----------------------------------------------------------------------------------------------
end.
//-----------------------------------------------------------------------------------------------
//   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM
//-----------------------------------------------------------------------------------------------