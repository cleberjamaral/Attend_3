unit UPrevisaoImp;
//-----------------------------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------------------------
uses
comctrls{p/ RichEdit},
Forms;
//-----------------------------------------------------------------------------------------------
type TFrmPrevisaoImp = class(TForm)
		rePadrao		: TRichEdit;
	public
    //--Construtores
    constructor criarInstancia(pt_rePrevisao : Pointer);
    destructor destruirInstancia();
    procedure OnKeyPress(Sender: TObject; var Key: Char);
    procedure setarPara40Colunas();
	published
//		property OnKeyPress : TNotifyEvent read FBtnClick  write FBtnClick;
end;
//-----------------------------------------------------------------------------------------------
implementation
//-----------------------------------------------------------------------------------------------
constructor TFrmPrevisaoImp.criarInstancia(pt_rePrevisao : Pointer);
begin
	rePadrao := TRichEdit.Create(Self);
//	rePadrao.Parent := Self;
  rePadrao.ReadOnly := true;
  rePadrao := pt_rePrevisao;
end;
//-----------------------------------------------------------------------------------------------
destructor TFrmPrevisaoImp.destruirInstancia();
begin
end;
//-----------------------------------------------------------------------------------------------
procedure TFrmPrevisaoImp.OnKeyPress(Sender: TObject; var Key: Char);
begin
	if Key = #27 then Close();
end;
//-----------------------------------------------------------------------------------------------
procedure TFrmPrevisaoImp.setarPara40Colunas();
const altCaixaTexto = 400;
const larCaixaTexto = 345;
begin
  Width := larCaixaTexto+9;
  Height := altCaixaTexto+27;
  BorderIcons := [biSystemMenu];
end;

end.
