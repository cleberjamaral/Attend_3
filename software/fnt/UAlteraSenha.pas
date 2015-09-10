unit UAlteraSenha;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TFAlteraSenha = class(TForm)
    edtSenhaAtual: TEdit;
    labSenhaAtual: TLabel;
    labNovaSenha: TLabel;
    edtNovaSenha: TEdit;
    labConfirmaSenha: TLabel;
    edtConfirmaSenha: TEdit;
    btConfirmar: TBitBtn;
    btCancelar: TBitBtn;
    procedure edtSenhaAtualKeyPress(Sender: TObject; var Key: Char);
    procedure btConfirmarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAlteraSenha: TFAlteraSenha;
//-----------------------------------------------------------------------------------------------
implementation
//-----------------------------------------------------------------------------------------------
uses UTabTele, UFuncoes;{$R *.DFM}
//-----------------------------------------------------------------------------------------------
procedure TFAlteraSenha.edtSenhaAtualKeyPress(Sender: TObject; var Key: Char);
begin
  try
    If Key = #13 Then Begin
      SelectNext(Sender as tWinControl, True, True );
      Key := #0;
    end;
  except
    MessageDlg('Erro ao focar próximo campo! {UAlteraSenha[001]}', mtError, [mbOk], 0);
  end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFAlteraSenha.btConfirmarClick(Sender: TObject);
var	criptSenha : string;
		senha : string;
begin
	if (FTabTele.retornarVariavel('acessoSenha01',FTabTele.retornarVarSenhaCriptPadrao()) <> NULL) then
		criptSenha := FTabTele.retornarVariavel('acessoSenha01',FTabTele.retornarVarSenhaCriptPadrao())
	else
		criptSenha := '';
	if (Length(criptSenha) > 0) then senha := Decrypt(criptSenha,981,12674,35891);
	//-- Verifica se a senha está correta
	if (UpperCase(edtSenhaAtual.Text) = UpperCase(senha)) then begin
		//-- Verifica se a nova senha confere com a confirmação
		if (edtNovaSenha.Text = edtConfirmaSenha.Text) then begin
			FTabTele.alterarVariavel('acessoSenha01',FTabTele.retornarSenhaCriptografada(edtNovaSenha.Text));
			MessageDlg('A senha foi alterada com sucesso!', mtInformation, [mbOk], 0);
			Close();
		end else begin
			MessageDlg('A senha não confere com a confirmação de senha!', mtInformation, [mbOk], 0);
			edtNovaSenha.Clear();
			edtConfirmaSenha.Clear();
			edtNovaSenha.SetFocus();
		end;
	end else begin
		MessageDlg('Senha incorreta!', mtInformation, [mbOk], 0);
		edtSenhaAtual.Clear();
		edtNovaSenha.Clear();
		edtConfirmaSenha.Clear();
		edtSenhaAtual.SetFocus();
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFAlteraSenha.FormCreate(Sender: TObject);
begin
  Caption := 'Alterar senha: '+FTabTele.retornarVariavel('acessoUsuario01','Gerente');
end;
//-----------------------------------------------------------------------------------------------
procedure TFAlteraSenha.btCancelarClick(Sender: TObject);
begin
  Close();
end;
//-----------------------------------------------------------------------------------------------
end.
//-----------------------------------------------------------------------------------------------
//   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM
//-----------------------------------------------------------------------------------------------
