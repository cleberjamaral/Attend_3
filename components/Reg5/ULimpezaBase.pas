unit ULimpezaBase;
//-----------------------------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------------------------
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, Mask, ToolEdit, ExtCtrls, UFuncoes, ComCtrls, UFunGeral;
//-----------------------------------------------------------------------------------------------
type
	TfrmLimpezaBase = class(TForm)
		lbOrigem: TListBox;
		Label2: TLabel;
		lbDestino: TListBox;
		Label3: TLabel;
		btnLimparBase: TBitBtn;
		btnEnviarTodos: TBitBtn;
		btnEnviar: TBitBtn;
		btnVoltar: TBitBtn;
		btnVoltarTodos: TBitBtn;
		MenuSuperior: TMainMenu;
		MBase: TMenuItem;
    mitEnviarTodos: TMenuItem;
    mitEnviar: TMenuItem;
    mitVoltar: TMenuItem;
    mitVoltarTodas: TMenuItem;
		MDados: TMenuItem;
		MLimpar: TMenuItem;
		gbxPeriodo: TGroupBox;
		dtpDataIni: TDateTimePicker;
		dtpDataFim: TDateTimePicker;
		procedure FormActivate(Sender: TObject);
		procedure BtVoltarClick(Sender: TObject);
		procedure btnEnviarTodosClick(Sender: TObject);
		procedure btnLimparBaseClick(Sender: TObject);
		procedure BtVoltarTodasClick(Sender: TObject);
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		procedure btnEnviarClick(Sender: TObject);
  private
		{ Private declarations }
		FunGeral			: TFunGeral;
  protected
	 { Protected declarations }
	 listaDeTabelas : TStringList;
	 listaDeNomeTabelas : TStringList;
  public
	 { Public declarations }
    function verifiqueItemsDestino(qualItem:string):boolean;
  end;
//-----------------------------------------------------------------------------------------------
var
  frmLimpezaBase: TfrmLimpezaBase;
//-----------------------------------------------------------------------------------------------
implementation {$R *.DFM}
//-----------------------------------------------------------------------------------------------
uses UTabTele;
//-----------------------------------------------------------------------------------------------
procedure TfrmLimpezaBase.FormActivate(Sender: TObject);
begin
  lbOrigem.clear;
  lbDestino.clear;
  lbOrigem.items.add('Pedidos');
  listaDeTabelas := TStringList.create;
  listaDeNomeTabelas := TStringList.create;
  dtpDataIni.Date:=0;
  dtpDataFim.Date:=Date()-365;
  BtnVoltarTodos.Enabled:=false;
end;
//-----------------------------------------------------------------------------------------------
function TfrmLimpezaBase.verifiqueItemsDestino(qualItem:string):boolean;
var i      :integer;
    estado :boolean;
begin
  estado:=false;
  i:=0 ;
  while i<=Self.lbDestino.Items.Count-1 do
    if ansiCompareStr(Self.lbDestino.Items.Strings[i],qualItem)=0 then
      begin
        estado:=true;
		  i:=Self.lbDestino.Items.Count;
		end
	 else
		i:=i+1;
	 result:=estado;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmLimpezaBase.BtVoltarClick(Sender: TObject);
begin
	if(lbDestino.items.count > 0) then begin
		if(lbDestino.itemIndex >= 0) then begin
			Self.lbOrigem.Items.Add(Self.lbDestino.items[lbDestino.itemIndex]);
			Self.lbDestino.Items.Delete(lbDestino.itemIndex);
			btnEnviarTodos.Enabled := true;
		end;
		if(lbDestino.items.count = 0) then BtnVoltarTodos.enabled:=false;
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmLimpezaBase.btnEnviarTodosClick(Sender: TObject);
var i: integer;
begin
	for i:=0 to Self.lbOrigem.Items.Count-1 do
		if not(Self.verifiqueItemsDestino(Self.lbOrigem.Items[i])) then
			Self.lbDestino.Items.Add(Self.lbOrigem.items[i]);
	btnEnviarTodos.Enabled:=false;
	btnVoltarTodos.enabled:=true;
	lbOrigem.Clear;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmLimpezaBase.btnLimparBaseClick(Sender: TObject);
var	tabelaAtiva,
		sql         : string;
		contador     : integer;
begin
	if (dtpDataFim.Date < dtpDataIni.Date) then begin
		MessageDlg('Período incorreto!', mtWarning, [mbOk], 0);
		Exit;
	end;

	if (lbDestino.items.count <= 0) then begin
		MessageDlg('Selecione a(s) base(s)!', mtWarning, [mbOk], 0);
		Exit;
	end;

	if (MessageDlg('Você realmente deseja excluir os dados das bases selecionadas?', mtWarning, [mbYes, mbNo], 0) = mrYes) then begin
		if (MessageDlg('Lembre-se, os dados contidos nas bases selecionadas serão excluídos. Você confirma?', mtWarning, [mbYes, mbNo], 0) = mrYes) then begin
			for contador:= 0 to lbDestino.items.count -1 do begin
				tabelaAtiva := lbDestino.items[contador];

				//--CadPedi
				if (tabelaAtiva = 'Pedidos') then begin
					if (FTabTele.limparBase_Pedidos(dtpDataIni.Date,dtpDataFim.Date) = 0) then begin
						MessageDlg('Dados da tabela de pedidos excluídos com sucesso!', mtInformation, [mbOk], 0);
					end else begin
						MessageDlg('Erro na exclusão de pedidos!', mtError, [mbOk], 0);
					end;
				end;

			end;
		end;
	end;
	btnVoltarTodos.Click();
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmLimpezaBase.BtVoltarTodasClick(Sender: TObject);
var i:integer;
begin
	for i:=0 to Self.lbDestino.Items.Count-1 do Self.lbOrigem.Items.Add(Self.lbDestino.items[i]);
	btnEnviarTodos.Enabled := true;
	btnVoltarTodos.Enabled := false;
	lbDestino.Clear;
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmLimpezaBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release();
end;
//-----------------------------------------------------------------------------------------------
procedure TfrmLimpezaBase.btnEnviarClick(Sender: TObject);
begin
	if (lbOrigem.items.count>0) then begin
		if(lbOrigem.itemIndex>=0) then begin
			if not(Self.verifiqueItemsDestino(lbOrigem.items[lbOrigem.itemIndex])) then begin
				Self.lbDestino.Items.Add(Self.lbOrigem.items[lbOrigem.itemIndex]);
				Self.lbOrigem.Items.Delete(lbOrigem.itemIndex);
				btnVoltarTodos.Enabled := true;
			end else begin
				MessageDlg('Não é possivel alterar a mesma base duas vezes!', mtError, [mbOk], 0);
			end;
		end;
	end;
	if (lbOrigem.items.count = 0) then btnEnviarTodos.enabled:=false;
end;
//-----------------------------------------------------------------------------------------------
end.
//-----------------------------------------------------------------------------------------------
