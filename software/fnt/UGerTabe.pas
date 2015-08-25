{------------------------------------------------------------------------------------------------
                       O C E A N O   T E C N O L O G I A
                        M A R    D E    S O L U Ç Õ E S
-------------------------------------------------------------------------------------------------
  1 Criação
    1.1 Data - Hora.: 28/01/02 18h
    1.2 Local.......: Escritorio Pessoal - Sao Jose
  2 Autoria
    2.1 Analise.....: Cleber Jorge Amaral
    2.2 Programação.: Cleber Jorge Amaral
  3 Descrição
    3.1 Projeto.....: Geral
    3.2 Classe......: Gerente de tabelas
    3.3 Comentário..: Criado p/ q o cliente tenha uma ferramenta
          intermediaria entre interface do programa e manipulador de
          banco de dados (ex.: DBD)
-------------------------------------------------------------------------------------------------
  1 Atualização
    1.1 Data - Hora.:
    1.2 Local.......:
  2 Autoria
    2.1 Programação.:
  3 Descrição
    3.3 Comentário..:
------------------------------------------------------------------------------------------------}
unit UGerTabe;
//-----------------------------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------------------------
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, db, DBTables, ExtCtrls, UFunDB,
  ComCtrls;
//-----------------------------------------------------------------------------------------------
type
  TFGerTabe = class(TForm)
    tTabela: TTable;
    dsTabela: TDataSource;
    pgcGerente: TPageControl;
    tshData: TTabSheet;
    Panel1: TPanel;
    cbxTabela: TComboBox;
    btnSave: TBitBtn;
    dbgTabela: TDBGrid;
    tshSQL: TTabSheet;
    memSQL: TMemo;
    btnOpen: TBitBtn;
    btnExecute: TBitBtn;
    qryTemp: TQuery;
    dscTemp: TDataSource;
    DBGrid1: TDBGrid;
    procedure cbxTabelaChange(Sender: TObject);
	 procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
  private
    { Private declarations }
		alias: string;
		FunDB				: TFunDB;
  public
	 { Public declarations }
	 procedure listarTabelas();
  end;
//-----------------------------------------------------------------------------------------------
var FGerTabe: TFGerTabe;
//-----------------------------------------------------------------------------------------------
implementation {$R *.DFM}
//-----------------------------------------------------------------------------------------------
uses UTabTele;
//-----------------------------------------------------------------------------------------------
procedure TFGerTabe.listarTabelas();
var	I: Integer;
		MyStringList: TStringList;
begin

	MyStringList := TStringList.Create;

	tTabela.DBSession.GetTableNames(tTabela.DatabaseName,'',false,false,MyStringList);
	cbxTabela.Items := MyStringList;

	MyStringList.Free;

end;
//-----------------------------------------------------------------------------------------------
procedure TFGerTabe.cbxTabelaChange(Sender: TObject);
begin
	tTabela.Close();
	tTabela.tableName := cbxTabela.text;
	tTabela.Open();
end;
//-----------------------------------------------------------------------------------------------
procedure TFGerTabe.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Release();
end;
//-----------------------------------------------------------------------------------------------
procedure TFGerTabe.FormShow(Sender: TObject);
begin
	listarTabelas();
end;

procedure TFGerTabe.btnSaveClick(Sender: TObject);
begin
	FunDB.iniciarTransacao(FTabTele.DBCommerce);
	if (tTabela.UpdatesPending) then begin
		tTabela.CommitUpdates();
	end;
	FunDB.finalizarTransacao(FTabTele.DBCommerce);
end;

procedure TFGerTabe.btnExecuteClick(Sender: TObject);
begin
	qryTemp.Close();
	qryTemp.SQL.Text := memSQL.Text;
	qryTemp.ExecSQL();
end;

procedure TFGerTabe.btnOpenClick(Sender: TObject);
begin
	qryTemp.Close();
	qryTemp.SQL.Text := memSQL.Text;
   qryTemp.Open();
end;

end.
//-----------------------------------------------------------------------------------------------

