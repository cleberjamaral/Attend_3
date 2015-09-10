//-----------------------------------------------------------------------------------------------
unit UFunDB;
//-----------------------------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------------------------
uses
	DBTables, 	//-- TQuery e Update
	Dialogs,		//-- MsgDls
	Sysutils,	//-- Função StrToInt
	Controls,	//-- TWinControl
	StdCtrls,	//-- TComboBox
	dbctrls,		//-- TDBLookupComboBox
	comctrls,	//-- TDateTimePicker
	extctrls,	//-- TPanel
	DB;			//-- TUpdateKind
//-----------------------------------------------------------------------------------------------
type
	TFunDB = class
	protected
	private
	public
		constructor criarInstancia();
		destructor destruirInstancia();
		procedure commitDireto(var pt_DB : TDatabase);
		procedure iniciarTransacao(var pt_DB : TDatabase);
		procedure finalizarTransacao(var pt_DB : TDatabase);
		procedure cancelarTransacao(var pt_DB : TDatabase);
		procedure iniciarQuery(pQuery: TQuery);
		procedure abrirQuery(pQuery: TQuery;pSQL : string);
		function verificarExistenciaDeRegistro(pQuery: TQuery;pSQL : string): boolean;
		function buscarMaxContador(pQuery: TQuery; pTabela : String): integer;
		function retornarVariavel(var pt_Query: TQuery; var pt_TempQuery: TQuery; var pt_iaeUpdateSQL: TUpdateSQL; p_Variavel, p_ValorPadrao : String):String;
		function retornarVariavelFloat(var pt_Query: TQuery; var pt_TempQuery : TQuery; var pt_iaeUpdateSQL : TUpdateSQL; p_Variavel: String; p_ValorPadrao: Real):Real;
		function retornarVariavelInt(var pt_Query: TQuery; var pt_TempQuery : TQuery; var pt_iaeUpdateSQL : TUpdateSQL; p_Variavel: String; p_ValorPadrao: Integer):Integer;
		function alterarVariavel(var pt_Query, pt_TempQuery: TQuery; var pt_iaeUpdateSQL: TUpdateSQL; p_Variavel, p_NovoValor : String): integer;
		procedure atualizarCampos(var pt_Parent: TWinControl; p_Acao: Integer; p_Operacao: TUpdateKind; var pt_qDefault: TQuery);
		procedure atualizarQuery(var pt_Query: TQuery);
		function registrar(var pt_Parent: TWinControl; p_Operacao: TUpdateKind; var pt_qDefault: TQuery): Integer;
		function registrarGrupo(p_Str: String; p_Operacao: TUpdateKind; var pt_qDefault: TQuery): Integer;
		procedure executarRefresh(var pt_Parent: TWinControl; var pt_qDefault: TQuery);
		procedure executarQuery(var pQuery: TQuery;pSQL : string);
		procedure salvarAlteracoesQuery(var pQuery: TQuery; var pDB: TDatabase);
end;
//-----------------------------------------------------------------------------------------------
	const c_Limpa =	0;
	const c_Grava =	1;
	const c_Carrega =	2;
//-----------------------------------------------------------------------------------------------
implementation
//-----------------------------------------------------------------------------------------------
constructor TFunDB.criarInstancia();
begin
end;
//----------------------------------------------------------------------------
destructor TFunDB.destruirInstancia();
begin
end;
//----------------------------------------------------------------------------
procedure TFunDB.commitDireto(var pt_DB : TDatabase);
begin
	pt_DB.StartTransaction();
	try
		pt_DB.Commit(); // on success, commit the changes;
	 except
		pt_DB.Rollback(); // on failure, undo the changes
	end;
end;
//----------------------------------------------------------------------------
procedure TFunDB.iniciarTransacao(var pt_DB : TDatabase);
begin
	pt_DB.StartTransaction();
end;
//----------------------------------------------------------------------------
procedure TFunDB.finalizarTransacao(var pt_DB : TDatabase);
begin
	try
		if (pt_DB.InTransaction) then pt_DB.Commit(); // on success, commit the changes;
	 except
		if (pt_DB.InTransaction) then pt_DB.Rollback(); // on failure, undo the changes
	end;
end;
//----------------------------------------------------------------------------
procedure TFunDB.cancelarTransacao(var pt_DB : TDatabase);
begin
	if (pt_DB.InTransaction) then pt_DB.Rollback(); // on failure, undo the changes
end;
//----------------------------------------------------------------------------
//-- Inicia uma query p/ inserção do código SQL - Barney - 300102
procedure TFunDB.iniciarQuery(pQuery: TQuery);
begin
  pQuery.close;
  pQuery.SQL.Clear;
end;
//-----------------------------------------------------------------------------------------------
//-- Abre uma query e vai p/ o primeiro registro- Barney - 070202
procedure TFunDB.abrirQuery(pQuery: TQuery;pSQL : string);
begin
  iniciarQuery(pQuery);
  pQuery.SQL.Add(pSQL);
  pQuery.Open();
  pQuery.First();
end;
//-----------------------------------------------------------------------------------------------
//-- Verifica se há registro valido na consulta
//-- ATENÇÃO - não utilize funções de agregação de SQL como SUM e semelhantes
//-- Esse tipo de função altera o formato de retorno do SQL
function TFunDB.verificarExistenciaDeRegistro(pQuery: TQuery;pSQL : string): boolean;
begin
  abrirQuery(pQuery,pSQL);
  if (pQuery.EOF = pQuery.BOF) then result := false else result := true;
end;

//-- Retorna o valor maximo + 1 do contador da tabela
function TFunDB.buscarMaxContador(pQuery : TQuery; pTabela : String): integer;
var sql : string;
begin
	sql := 'SELECT max(contador) as maxContador FROM '+pTabela;
	abrirQuery(pQuery,sql);
	result := pQuery.fieldByName('maxContador').asInteger+1
end;

//-- Devolve o valor string de uma variavel
function TFunDB.retornarVariavel(var pt_Query : TQuery; var pt_TempQuery : TQuery; var pt_iaeUpdateSQL : TUpdateSQL; p_Variavel, p_ValorPadrao : String):String;
begin
	try
		pt_Query.Close();
		pt_Query.ParamByName('Nome').AsString := UpperCase(p_Variavel);
		pt_Query.Open();
		//-- Verifica se existe a variavel
		if (pt_Query.Eof <> pt_Query.Bof) then begin
			//-- Captura solicitada
			result := pt_Query.FieldByName('Dado').AsString;
		end else begin
			//-- Cria Variavel
			pt_iaeUpdateSQL.Query[ukInsert].ParamByName('Contador').AsInteger := buscarMaxContador(pt_TempQuery,'Variavel');
			pt_iaeUpdateSQL.Query[ukInsert].ParamByName('Nome').AsString      := UpperCase(p_Variavel);
			pt_iaeUpdateSQL.Query[ukInsert].ParamByName('Dado').AsString      := p_ValorPadrao;
			pt_iaeUpdateSQL.Query[ukInsert].ExecSQL();
			result := p_ValorPadrao;
		end;
	except
		result := 'ERRO!';
	end;
end;
//-----------------------------------------------------------------------------------------------
//-- Devolve o valor Float de uma variavel
function TFunDB.retornarVariavelFloat(var pt_Query: TQuery; var pt_TempQuery : TQuery; var pt_iaeUpdateSQL : TUpdateSQL; p_Variavel: String; p_ValorPadrao: Real):Real;
begin
	try
		pt_Query.Close();
		pt_Query.ParamByName('Nome').AsString := UpperCase(p_Variavel);
		pt_Query.Open();
		//-- Verifica se existe a variavel
		if (pt_Query.Eof <> pt_Query.Bof) then begin
			//-- Captura solicitada
			result := pt_Query.FieldByName('Dado').AsFloat;
		end else begin
			//-- Cria Variavel
			pt_iaeUpdateSQL.Query[ukInsert].ParamByName('Contador').AsInteger := buscarMaxContador(pt_TempQuery,'Variavel');
			pt_iaeUpdateSQL.Query[ukInsert].ParamByName('Nome').AsString      := UpperCase(p_Variavel);
			pt_iaeUpdateSQL.Query[ukInsert].ParamByName('Dado').AsString      := FloatToStr(p_ValorPadrao);
			pt_iaeUpdateSQL.Query[ukInsert].ExecSQL();
			result := p_ValorPadrao;
		end;
	except
		result := NULL;
	end;
end;
//-----------------------------------------------------------------------------------------------
//-- Devolve o valor Int de uma variavel
function TFunDB.retornarVariavelInt(var pt_Query: TQuery; var pt_TempQuery : TQuery; var pt_iaeUpdateSQL : TUpdateSQL; p_Variavel: String; p_ValorPadrao: Integer):Integer;
begin
	try
		pt_Query.Close();
		pt_Query.ParamByName('Nome').AsString := UpperCase(p_Variavel);
		pt_Query.Open();
		//-- Verifica se existe a variavel
		if (pt_Query.Eof <> pt_Query.Bof) then begin
			//-- Captura solicitada
			result := pt_Query.FieldByName('Dado').AsInteger;
		end else begin
			//-- Cria Variavel
			pt_iaeUpdateSQL.Query[ukInsert].ParamByName('Contador').AsInteger := buscarMaxContador(pt_TempQuery,'Variavel');
			pt_iaeUpdateSQL.Query[ukInsert].ParamByName('Nome').AsString      := UpperCase(p_Variavel);
			pt_iaeUpdateSQL.Query[ukInsert].ParamByName('Dado').AsString      := IntToStr(p_ValorPadrao);
			pt_iaeUpdateSQL.Query[ukInsert].ExecSQL();
			result := p_ValorPadrao;
		end;
	except
		result := NULL;
	end;
end;
//-----------------------------------------------------------------------------------------------
//-- Altera o valor String de uma variavel
function TFunDB.alterarVariavel(var pt_Query, pt_TempQuery : TQuery; var pt_iaeUpdateSQL : TUpdateSQL; p_Variavel, p_NovoValor : String): integer;
begin
	try
		pt_Query.Close();
		pt_Query.ParamByName('Nome').AsString := UpperCase(p_Variavel);
		pt_Query.Open();
		//-- Verifica se existe a variavel
		if (pt_Query.Eof <> pt_Query.Bof) then begin//-- Se existe a variavel
			//-- Solicita Captura
			pt_iaeUpdateSQL.Query[ukModify].ParamByName('OLD_Nome').AsString := UpperCase(p_Variavel);
			pt_iaeUpdateSQL.Query[ukModify].ParamByName('Dado').AsString     := p_NovoValor;
			pt_iaeUpdateSQL.Query[ukModify].ExecSQL();
			result := 0;
		end else begin
			//-- Cria Variavel
			pt_iaeUpdateSQL.Query[ukInsert].ParamByName('Contador').AsInteger := buscarMaxContador(pt_TempQuery,'Variavel');
			pt_iaeUpdateSQL.Query[ukInsert].ParamByName('Nome').AsString      := UpperCase(p_Variavel);
			pt_iaeUpdateSQL.Query[ukInsert].ParamByName('Dado').AsString      := p_NovoValor;
			pt_iaeUpdateSQL.Query[ukInsert].ExecSQL();
			result := 0;
		end;
	except
		result := -1;
	end;
end;
//-----------------------------------------------------------------------------------------------
procedure TFunDB.atualizarCampos(var pt_Parent : TWinControl; p_Acao: Integer; p_Operacao: TUpdateKind; var pt_qDefault: TQuery);
var	i:	Integer;
		fieldName: String;
		var iaeDefault: TUpdateSQL;
		var tmpCombo: TComboBox;
		var tmpEdit: TEdit;
		var tmplcbCombo: TDBLookupComboBox;
		var tmpDateTimep: TDateTimePicker;
		var tmpPanel: TPanel;
		var tmpPageControl: TPageControl;
		var tmpTabSheet: TTabSheet;
begin
	if (pt_qDefault <> nil) then iaeDefault := TUpdateSQL(pt_qDefault.UpdateObject) else Exit;
	for i := 0 to (pt_Parent.ControlCount-1) do begin
	try
		//-- Componentes Parent de componentes
		if (pt_Parent.Controls[i].ClassNameIs('TPanel')) then begin
			tmpPanel := TPanel(pt_Parent.Controls[i]);
			atualizarCampos(TWinControl(tmpPanel),p_Acao,p_Operacao,pt_qDefault);
		end;
		if (pt_Parent.Controls[i].ClassNameIs('TPageControl')) then begin
			tmpPageControl := TPageControl(pt_Parent.Controls[i]);
			atualizarCampos(TWinControl(tmpPageControl),p_Acao,p_Operacao,pt_qDefault);
		end;
		if (pt_Parent.Controls[i].ClassNameIs('TTabSheet')) then begin
			tmpTabSheet := TTabSheet(pt_Parent.Controls[i]);
			atualizarCampos(TWinControl(tmpTabSheet),p_Acao,p_Operacao,pt_qDefault);
		end;
		//-- Componentes Filhos
		if (pt_Parent.Controls[i].ClassNameIs('TEdit')) then begin
			tmpEdit := TEdit(pt_Parent.Controls[i]);
			fieldName := Copy(tmpEdit.Name,4,Length(tmpEdit.Name)-3);
			case (p_Acao) of
				c_Limpa: tmpEdit.Clear();
				c_Grava: begin
					if (pt_qDefault.FieldByName(fieldName).DataType = ftInteger) then begin
						if (tmpEdit.Text = '') then tmpEdit.Text := '0';
						iaeDefault.Query[p_Operacao].ParamByName(fieldName).AsInteger := StrToInt(tmpEdit.Text);
					end else begin
						iaeDefault.Query[p_Operacao].ParamByName(fieldName).AsString := tmpEdit.Text;
					end;
				end;
				c_Carrega: begin
					tmpEdit.Text := pt_qDefault.FieldByName(fieldName).AsString;
					tmpEdit.MaxLength := pt_qDefault.FieldByName(fieldName).Size;
				end;
			end;
		end;
		if (pt_Parent.Controls[i].ClassNameIs('TComboBox')) then begin
			tmpCombo := TComboBox(pt_Parent.Controls[i]);
			fieldName := Copy(tmpCombo.Name,4,Length(tmpCombo.Name)-3);
			case (p_Acao) of
				c_Limpa: tmpCombo.ItemIndex := -1;
				c_Grava: iaeDefault.Query[p_Operacao].ParamByName(fieldName).AsInteger := tmpCombo.ItemIndex;
				c_Carrega: tmpCombo.ItemIndex := pt_qDefault.FieldByName(fieldName).AsInteger;
			end;
		end;
		if (pt_Parent.Controls[i].ClassNameIs('TDBLookupComboBox')) then begin
			tmplcbCombo := TDBLookupComboBox(pt_Parent.Controls[i]);
			fieldName := Copy(tmplcbCombo.Name,4,Length(tmplcbCombo.Name)-3);
			case (p_Acao) of
				c_Limpa: tmplcbCombo.KeyValue := '-1';
				c_Grava: iaeDefault.Query[p_Operacao].ParamByName(fieldName).AsInteger := StrToInt(tmplcbCombo.KeyValue);
				c_Carrega: if (pt_qDefault.FieldByName(fieldName).AsString <> '') then tmplcbCombo.KeyValue := pt_qDefault.FieldByName(fieldName).AsString;
			end;
		end;

		if (pt_Parent.Controls[i].ClassNameIs('TDateTimePicker')) then begin
			tmpDateTimep := TDateTimePicker(pt_Parent.Controls[i]);
			fieldName := Copy(tmpDateTimep.Name,4,Length(tmpDateTimep.Name)-3);
			case (p_Acao) of
				c_Limpa: tmpDateTimep.DateTime := Now();
				c_Grava: iaeDefault.Query[p_Operacao].ParamByName(fieldName).AsDateTime := tmpDateTimep.DateTime;
				c_Carrega: if (pt_qDefault.FieldByName(fieldName).AsString <> '') then tmpDateTimep.DateTime := pt_qDefault.FieldByName(fieldName).AsDateTime; else tmpDateTimep.DateTime := Now();
			end;
		end;
	except
		MessageDlg('Erro ao processar campo: '+fieldName, mtError, [mbOk], 0);
	end;
	end;
end;
//---------------------------------------------------------------------------
procedure TFunDB.atualizarQuery(var pt_Query: TQuery);
begin
  pt_Query.Close();
  pt_Query.Open();
end;
//---------------------------------------------------------------------------
function TFunDB.registrar(var pt_Parent: TWinControl; p_Operacao: TUpdateKind; var pt_qDefault: TQuery): Integer;
var	tableName: String;
		var iaeDefault: TUpdateSQL;
//		savePlace: TBookmark;
		var dbDefault: TDatabase;
		var qryTemp: TQuery;
begin
//-- p_Parent: TPanel, TForm ou outro controlador que contem os componentes linkados ao DB
//-- p_Operacao: Tipo de transação (ukDelete, ukInsert ou ukModify)
//-- p_qDefault: Query que esta ligada a tabela em questão
	qryTemp := TQuery.Create(nil);
	try
		//-- Inicializa ponteiros
		dbDefault := pt_qDefault.Database;
		qryTemp.DatabaseName := pt_qDefault.DatabaseName;
		iaeDefault := TUpdateSQL(pt_qDefault.UpdateObject);
//		savePlace := pt_qDefault.GetBookmark();
		//-- Processo de gravação de registro
		tableName := Copy(pt_qDefault.Name,4,Length(pt_qDefault.Name)-1);
		iniciarTransacao(dbDefault);
		if ((p_Operacao = ukDelete)or(p_Operacao = ukModify)) then iaeDefault.Query[p_Operacao].ParamByName('OLD_CONTADOR').AsInteger := pt_qDefault.FieldByName('CONTADOR').AsInteger;
		if (p_Operacao = ukInsert) then iaeDefault.Query[p_Operacao].ParamByName('CONTADOR').AsInteger     := buscarMaxContador(qryTemp,tableName);
		if (p_Operacao = ukModify) then iaeDefault.Query[p_Operacao].ParamByName('CONTADOR').AsInteger     := pt_qDefault.FieldByName('CONTADOR').AsInteger;
		if ((p_Operacao = ukInsert)or(p_Operacao = ukModify)) then atualizarCampos(pt_Parent,c_Grava,p_Operacao,pt_qDefault);
		iaeDefault.Query[p_Operacao].ExecSQL();
		finalizarTransacao(dbDefault);
		atualizarQuery(pt_qDefault);

		if (p_Operacao = ukInsert) or (p_Operacao = ukModify) then begin
			if not (pt_qDefault.Locate('CONTADOR',iaeDefault.Query[p_Operacao].ParamByName('CONTADOR').AsInteger,[loCaseInsensitive])) then
				pt_qDefault.First();
		end;

		if (p_Operacao = ukDelete) then pt_qDefault.Prior();
		// else if (pt_qDefault.RecordCount > 0) then pt_qDefault.GotoBookmark(savePlace);
		MessageDlg('Operação realizada com sucesso!', mtInformation, [mbOk], 0);
		atualizarCampos(pt_Parent,c_Carrega,ukInsert,pt_qDefault);//-- Enviando ukInsert apenas para evitar erro
		result := 0;
	except
		finalizarTransacao(dbDefault);
		atualizarCampos(pt_Parent,c_Carrega,ukInsert,pt_qDefault);//-- Enviando ukInsert apenas para evitar erro
		MessageDlg('Erro ao realizar operação!', mtError, [mbOk], 0);
		result := -1;
	end;
end;
//---------------------------------------------------------------------------
//-- Inclui, altera e exclui grupos através da tabela de grupos ativa
function TFunDB.registrarGrupo(p_Str: String; p_Operacao: TUpdateKind; var pt_qDefault: TQuery): Integer;
var	tableName: String;
		var iaeDefault: TUpdateSQL;
		savePlace: TBookmark;
		var dbDefault: TDatabase;
		var qryTemp: TQuery;
		newName: String;
begin
	qryTemp := TQuery.Create(nil);
	try
		//-- Inicializa ponteiros
		dbDefault := pt_qDefault.Database;
		qryTemp.DatabaseName := pt_qDefault.DatabaseName;
		iaeDefault := TUpdateSQL(pt_qDefault.UpdateObject);
		savePlace := pt_qDefault.GetBookmark();
		//-- Processo de gravação de registro
		tableName := Copy(pt_qDefault.Name,4,Length(pt_qDefault.Name)-1);
		iniciarTransacao(dbDefault);
		if ((p_Operacao = ukDelete)or(p_Operacao = ukModify)) then iaeDefault.Query[p_Operacao].ParamByName('OLD_CONTADOR').AsInteger := pt_qDefault.FieldByName('CONTADOR').AsInteger;
		if (p_Operacao = ukInsert) then iaeDefault.Query[p_Operacao].ParamByName('CONTADOR').AsInteger     := buscarMaxContador(qryTemp,tableName);
		if (p_Operacao = ukModify) then iaeDefault.Query[p_Operacao].ParamByName('CONTADOR').AsInteger     := pt_qDefault.FieldByName('CONTADOR').AsInteger;
		if ((p_Operacao = ukInsert)or(p_Operacao = ukModify)) then begin
			newName := 'Nome';
			if (p_Operacao = ukModify) then newName := p_Str;
			if (InputQuery('Novo Grupo', 'Nome', newName)) then begin
				//-- Verifica se já existe grupo com este nome
				iniciarQuery(qryTemp);
				qryTemp.SQL.Add('SELECT CONTADOR FROM '+tableName+' WHERE UPPER(NOME) = UPPER(:NOME)');
				qryTemp.ParamByName('NOME').AsString := newName;
				qryTemp.Open();
				if (qryTemp.Eof <> qryTemp.Bof) then begin
					MessageDlg('Operação cancelada! Já existe grupo com este nome.', mtInformation, [mbOk], 0);
					finalizarTransacao(dbDefault);
					result := -1;
					Exit;
				end;
				iaeDefault.Query[p_Operacao].ParamByName('NOME').AsString          := newName;
			end else begin
				finalizarTransacao(dbDefault);
				result := -1;
				Exit;
			end;
		end;
		iaeDefault.Query[p_Operacao].ExecSQL();
		finalizarTransacao(dbDefault);
		atualizarQuery(pt_qDefault);
		if (p_Operacao = ukDelete) then pt_qDefault.Prior() else if (pt_qDefault.RecordCount > 0) then pt_qDefault.GotoBookmark(savePlace);
		MessageDlg('Operação realizada com sucesso!', mtInformation, [mbOk], 0);
		result := 0;
	except
		finalizarTransacao(dbDefault);
		MessageDlg('Erro ao realizar operação!', mtError, [mbOk], 0);
		result := -1;
	end;
end;
//-----------------------------------------------------------------------------------------------
{//-- Nao foi possivel implementar verificacao de vinculos sem conhecer o nome do grupo antes
//-- Inclui, altera e exclui grupos através de mensagens
function TFunDB.registrarGrupoPeloNome(p_Operacao: TUpdateKind; var pt_qDefault: TQuery): Integer;
var	tableName: String;
		var iaeDefault: TUpdateSQL;
		savePlace: TBookmark;
		var dbDefault: TDatabase;
		var qryTemp: TQuery;
		newName: String;
		idGrupo:	Integer;
begin
	qryTemp := TQuery.Create(nil);
	try
		//-- Inicializa ponteiros
		dbDefault := pt_qDefault.Database;
		qryTemp.DatabaseName := pt_qDefault.DatabaseName;
		iaeDefault := TUpdateSQL(pt_qDefault.UpdateObject);
		//-- Processo de gravação de registro
		tableName := Copy(pt_qDefault.Name,4,Length(pt_qDefault.Name)-1);
		iniciarTransacao(dbDefault);

		if (p_Operacao <> ukInsert) then begin
			if not (InputQuery('Cadastro de grupo', 'Nome do grupo', newName)) then begin
				MessageDlg('Operação cancelada!', mtInformation, [mbOk], 0);
				Exit;
			end;

			iniciarQuery(qryTemp);
			qryTemp.SQL.Add('SELECT CONTADOR FROM CLIENTEGRUPO WHERE UPPER(NOME) = UPPER(:GRUPO)');
			qryTemp.ParamByName('GRUPO').AsString := newName;
			qryTemp.Open();
			if (qryTemp.Eof <> qryTemp.Bof) then begin
				idGrupo := qryTemp.FieldByName('CONTADOR').AsInteger;
			end else begin
				MessageDlg('O grupo não existe!', mtInformation, [mbOk], 0);
				Exit;
			end;
		end;

		if ((p_Operacao = ukDelete)or(p_Operacao = ukModify)) then iaeDefault.Query[p_Operacao].ParamByName('OLD_CONTADOR').AsInteger := idGrupo;
		if (p_Operacao = ukInsert) then iaeDefault.Query[p_Operacao].ParamByName('CONTADOR').AsInteger     := buscarMaxContador(qryTemp,tableName);
		if (p_Operacao = ukModify) then iaeDefault.Query[p_Operacao].ParamByName('CONTADOR').AsInteger     := idGrupo;
		if ((p_Operacao = ukInsert)or(p_Operacao = ukModify)) then begin

			if (InputQuery('Novo Grupo', 'Nome', newName)) then begin
				//-- Verifica se já existe grupo com este nome
				iniciarQuery(qryTemp);
				qryTemp.SQL.Add('SELECT CONTADOR FROM '+tableName+' WHERE UPPER(NOME) = UPPER(:NOME)');
				qryTemp.ParamByName('NOME').AsString := newName;
				qryTemp.Open();
				if (qryTemp.Eof <> qryTemp.Bof) then begin
					MessageDlg('Operação cancelada! Já existe grupo com este nome.', mtInformation, [mbOk], 0);
					finalizarTransacao(dbDefault);
					result := -1;
					Exit;
				end;
				iaeDefault.Query[p_Operacao].ParamByName('NOME').AsString          := newName;
			end else begin
				finalizarTransacao(dbDefault);
				result := -1;
				Exit;
			end;
		end;
		iaeDefault.Query[p_Operacao].ExecSQL();
		finalizarTransacao(dbDefault);
		atualizarQuery(pt_qDefault);
		MessageDlg('Operação realizada com sucesso!', mtInformation, [mbOk], 0);
		result := 0;
	except
		finalizarTransacao(dbDefault);
		MessageDlg('Erro ao realizar operação!', mtError, [mbOk], 0);
		result := -1;
	end;
end;
}
//---------------------------------------------------------------------------
procedure TFunDB.executarRefresh(var pt_Parent: TWinControl; var pt_qDefault: TQuery);
var	savePlace: TBookmark;
begin
	try
		savePlace := pt_qDefault.GetBookmark();
		atualizarQuery(pt_qDefault);
		pt_qDefault.GotoBookmark(savePlace);
		atualizarCampos(pt_Parent,c_Carrega,ukInsert,pt_qDefault);//-- Enviando ukInsert apenas para evitar erro
	except
		MessageDlg('Erro ao executar refresh!', mtError, [mbOk], 0);
	end;
end;
//---------------------------------------------------------------------------
procedure TFunDB.executarQuery(var pQuery: TQuery; pSQL : string);
begin
  iniciarQuery(pQuery);
  pQuery.SQL.add(pSQL);
  pQuery.ExecSQL;
end;
//-----------------------------------------------------------------------------------------------
procedure TFunDB.salvarAlteracoesQuery(var pQuery: TQuery; var pDB: TDatabase);
begin
	if (pQuery.UpdatesPending) then begin
		if (MessageDlg('Salvar as alterações?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
			pDB.StartTransaction();
			try
				pQuery.ApplyUpdates(); // try to write the updates to the database
				pDB.Commit(); // on success, commit the changes;
			except
				pDB.Rollback(); // on failure, undo the changes
			end;
			pQuery.CommitUpdates(); // on success, clear the cache
		end;
	end;
end;
//-----------------------------------------------------------------------------------------------
end.
//-----------------------------------------------------------------------------------------------
//   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM
//-----------------------------------------------------------------------------------------------


