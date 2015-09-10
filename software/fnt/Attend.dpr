{------------------------------------------------------------------------------------------------

              O C E A N O   -    M A R    D E    S O L U Ç Õ E S

-------------------------------------------------------------------------------------------------
										  I N I C I O
-------------------------------------------------------------------------------------------------
Criação      : 11/10/2001 02:00:00
Local        : Escritório, Florianópolis
Autor(es)    : Cleber J. Amaral
Descrição    :
Comentário   :
-------------------------------------------------------------------------------------------------
Atualização  :
Autor(es)    :
Comentário   :
-------------------------------------------------------------------------------------------------}

program Attend;

//-----------------------------------------------------------------------------------------------

uses
  Forms,
  UTabTele in 'UTabTele.pas' {FTabTele: TDataModule},
  UPedidoUltimo in 'UPedidoUltimo.pas' {frmPedidoUltimo},
  UPedido in 'UPedido.pas' {frmPedido},
  URelPedi in 'URelPedi.pas' {frmRelatorio},
  UPedidoFinalizacao in 'UPedidoFinalizacao.pas' {frmPedidoFinalizacao},
  ULimpezaBase in 'ULimpezaBase.pas' {frmLimpezaBase},
  UProdutoGrupoManipulacao in 'UProdutoGrupoManipulacao.pas' {frmProdutoGrupoManipulacao},
  UClienteGrupoManipulacao in 'UClienteGrupoManipulacao.pas' {frmClienteGrupoManipulacao},
  USobre in 'USobre.pas' {frmSobre},
  UFuncoes in 'UFuncoes.pas' {FFuncoes},
  UInicial in 'UInicial.pas' {FInicial},
  URelatorio in 'URelatorio.pas',
  UPessoa in 'UPessoa.pas',
  UObservacao in 'UObservacao.pas' {frmObservacao},
  UImpPedi in 'UImpPedi.pas',
  UGerTabe in 'UGerTabe.pas' {FGerTabe},
  UAlteraSenha in 'UAlteraSenha.pas' {FAlteraSenha},
  ULicenca in 'ULicenca.pas' {frmLicenca},
  UVerificaLicenca in 'UVerificaLicenca.pas',
  UPrevisaoImp in 'UPrevisaoImp.pas',
  UFunDB in 'UFunDB.pas',
  UProduto in 'UProduto.pas' {frmProduto},
  UCliente in 'UCliente.pas' {frmCliente},
  UFunGeral in 'UFunGeral.pas',
  UPedidoExpedicao in 'UPedidoExpedicao.pas' {frmPedidoExpedicao},
  UEntregador in 'UEntregador.pas' {frmEntregador},
  USplash in 'USplash.pas' {frmSplash},
  UMensagemLicenca in 'UMensagemLicenca.pas' {frmMensagemLicenca},
  UClienteGrupo in 'UClienteGrupo.pas' {frmClienteGrupo},
  UProdutoGrupo in 'UProdutoGrupo.pas' {frmProdutoGrupo};

{$define tele}

{$R *.RES}

//-----------------------------------------------------------------------------------------------
begin
	Application.Title := 'Softiza Attend';
	Application.HelpFile := 'Help.hlp';
	frmSplash := TfrmSplash.Create(Application);
	Application.CreateForm(TFTabTele, FTabTele);
   frmSplash.Gauge1.Progress := 00;
	frmSplash.Show;
	Application.CreateForm(TFInicial, FInicial);
	frmSplash.Gauge1.Progress := 10;
	frmSplash.Update;
	Application.CreateForm(TFFuncoes, FFuncoes);
	frmSplash.Gauge1.Progress := 20;
	frmSplash.Update;
	Application.CreateForm(TFrmObservacao, FrmObservacao);
	frmSplash.Gauge1.Progress := 30;
	frmSplash.Update;
	Application.CreateForm(TFrmRelatorio,FrmRelatorio);
	frmSplash.Gauge1.Progress := 40;
	frmSplash.Update;
	Application.CreateForm(TFrmClienteGrupo,FrmClienteGrupo);
	frmSplash.Gauge1.Progress := 50;
	frmSplash.Update;
	Application.CreateForm(TFrmProdutoGrupo,FrmProdutoGrupo);
	frmSplash.Gauge1.Progress := 60;
	frmSplash.Update;
	Application.CreateForm(TFrmPedidoUltimo, FrmPedidoUltimo);
	frmSplash.Gauge1.Progress := 80;
	frmSplash.Update;
	Application.createForm(TFrmPedidoFinalizacao,FrmPedidoFinalizacao);
	frmSplash.Gauge1.Progress := 90;
	frmSplash.Update;
	Application.createForm(TfrmPedido,frmPedido);
	frmSplash.Gauge1.Progress := 100;
	frmSplash.Update;
	Application.Initialize;
	frmSplash.Hide;
	frmSplash.Free;
	Application.Run;
//-----------------------------------------------------------------------------------------------
end.
//-----------------------------------------------------------------------------------------------
//   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM
//-----------------------------------------------------------------------------------------------
