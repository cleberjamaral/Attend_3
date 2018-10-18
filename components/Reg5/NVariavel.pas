{------------------------------------------------------------------------------------------------

              O C E A N O   -    M A R    D E    S O L U Ç Õ E S

-------------------------------------------------------------------------------------------------
                                I N I C I O
-------------------------------------------------------------------------------------------------
Criação      : 17/10/00 20:30
Local        : Escritório, Florianópolis
Autor(es)    : Cássio Lacerda
Descrição    : Componente para Controle de Variáveis
Comentário   : Este componente é derivado do TComponent, sua função é procurar
               na tabela TVariavel o nome da variável e gravar o seu valor passando
               a resposta como uma variat.
-------------------------------------------------------------------------------------------------
Atualização  : DD/MM/AAAA HH:MM
Autor(es)    : Cleber J. Amaral
Comentário   : Inclusão das seguintes funções e procedimentos
               ValorVar
               CriarVariavel
               AlterarVariavel
               RestaurarPadrao
-------------------------------------------------------------------------------------------------}

unit NVariavel;

//-----------------------------------------------------------------------------------------------

interface

//-----------------------------------------------------------------------------------------------

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables;

//-----------------------------------------------------------------------------------------------

type
  TNVariavel = class(TTable)
  private
	 FResposta   : variant;
  protected
  public
		constructor Create (Aowner:TComponent); override;
		destructor  Destroy; override;
		//-- Escreve na propriedade resposta o valor da variavel
		function SetVariavel( Value : string): boolean;
		//-- Retorna o valor variant contido na variavel
		function ValorVar( pvar : string ) : Variant;
		//-- Retorna o valor variant contido na variavel ou cria a variavel
		function ValorVarCria( pvar : string ; pTipo : String ; pValor : Variant ) : Variant;
		//-- Cria nova variavel (caso nao exista)
		procedure CriarVariavel( pVariavel : String ; pTipo : String ; pValor : Variant );
		//-- Altera conteudo da variavel
		procedure AlterarVariavel ( pVariavel : String ; pValor : Variant );
		//-- Restaura valor padrão da variavel
		function RestaurarPadrao( pVari : String ; pValor : Variant ): bool;
		//-- Retorna verdadeiro caso a variavel exista
		function verificarExistenciaVar(pVari : String): bool;

  published
   property Resposta   : variant read FResposta  write FResposta;
  end;
//-----------------------------------------------------------------------------------------------
implementation
//-----------------------------------------------------------------------------------------------
constructor TNVariavel.Create (Aowner:TComponent);
begin
  inherited Create(AOwner);
end;
//-----------------------------------------------------------------------------------------------
destructor TNVariavel.Destroy;
begin
  inherited Destroy;
end;
//-----------------------------------------------------------------------------------------------
//-- Retorna o valor variant contido na variavel
function TNVariavel.ValorVar( pvar : string ) : Variant;
begin
  if (SetVariavel(pvar)) then Result := FResposta else Result := null;
end;
//-----------------------------------------------------------------------------------------------
//-- Retorna o valor variant contido na variavel ou cria a variavel
function TNVariavel.ValorVarCria( pvar : string ; pTipo : String ; pValor : Variant ) : Variant;
begin
	if (verificarExistenciaVar(pvar)) then begin
		Result := ValorVar(pvar);
	end else begin
		CriarVariavel(pvar, pTipo, pValor);
		Result := pValor;
	end;
end;
//-----------------------------------------------------------------------------------------------
//-- Retorna o valor da variavel
function TNVariavel.SetVariavel(Value : string): boolean;
begin
  if not FindKey( [ value ] ) then begin
	 ShowMessage('Variável '+value+' Inexistente');
	 Result := false;
  end
  else begin
	 if FieldbyName('Tipo').Value = 'S' then FResposta := FieldbyName('StValor').Value;
	 if FieldbyName('Tipo').Value = '$' then FResposta := FieldbyName('MoValor').Value;
	 if FieldbyName('Tipo').Value = 'I' then FResposta := FieldbyName('InValor').Value;
	 if FieldbyName('Tipo').Value = 'F' then FResposta := FieldbyName('FlValor').Value;
	 if FieldbyName('Tipo').Value = 'L' then FResposta := FieldbyName('LoValor').Value;
	 if FieldbyName('Tipo').Value = 'D' then FResposta := FieldbyName('DtValor').AsDateTime;
	 if FieldbyName('Tipo').Value = 'T' then FResposta := FieldbyName('TmValor').Value;
	 Result := true;
  end;
end;
//-----------------------------------------------------------------------------------------------
procedure TNVariavel.CriarVariavel( pVariavel : String ; pTipo : String ; pValor : Variant );
begin
  if not FindKey([pVariavel]) then begin
	 Append;
	 FieldbyName('Variavel').Text := pVariavel;
	 FieldbyName('Tipo').Text     := pTipo;
	 if pTipo = 'S' then FieldbyName('StValor').Value := pValor;
	 if pTipo = '$' then FieldbyName('MoValor').Value := pValor;
	 if pTipo = 'I' then FieldbyName('InValor').Value := pValor;
	 if pTipo = 'F' then FieldbyName('FlValor').Value := pValor;
	 if pTipo = 'L' then FieldbyName('LoValor').Value := pValor;
	 if pTipo = 'D' then FieldbyName('DtValor').Value := pValor;
	 if pTipo = 'T' then FieldbyName('TmValor').Value := pValor;
	 Post;
	 ShowMessage('A Variável "'+pVariavel+'" foi criada com sucesso!');
  end;
end;
//-----------------------------------------------------------------------------------------------
procedure TNVariavel.AlterarVariavel( pVariavel : String ; pValor : Variant );
begin
//--  Esse procedimento deve reveber 2 parametros:
//--  pvariavel = string q determina o nome da variavel do TVariavel (Procura)
//--  pValor = é um valor variant q determina o dado a ser armazenado no registro
//--  Sua funcao é receber o nome e valor a armazenar no registro "nome" da tabela TVariave - BARNEY
  if not FindKey([pVariavel]) then begin
   ShowMessage('Não foi possível encontrar a variável '+pVariavel+' !');
  end
  else begin
    Edit;
    if FieldbyName('Tipo').Value = 'S' then FieldbyName('StValor').Value := pValor;
    if FieldbyName('Tipo').Value = '$' then FieldbyName('MoValor').Value := pValor;
    if FieldbyName('Tipo').Value = 'I' then FieldbyName('InValor').Value := pValor;
	 if FieldbyName('Tipo').Value = 'F' then FieldbyName('FlValor').Value := pValor;
    if FieldbyName('Tipo').Value = 'L' then FieldbyName('LoValor').Value := pValor;
    if FieldbyName('Tipo').Value = 'D' then FieldbyName('DtValor').Value := pValor;
    if FieldbyName('Tipo').Value = 'T' then FieldbyName('TmValor').Value := pValor;
    Post;
  end;
end;
//-----------------------------------------------------------------------------------------------
//-- Restaura valor padrão da variavel
function TNVariavel.RestaurarPadrao( pVari : String ; pValor : Variant ): bool;
begin
  if MessageDlg('Deseja restaurar o valor padrão de '+pVari+' ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    AlterarVariavel(pVari, pValor);
    Result := true;
  end
  else begin
    Result := false;
  end;
end;
//-----------------------------------------------------------------------------------------------
//-- Retorna verdadeiro caso a variavel exista
function TNVariavel.verificarExistenciaVar(pVari : String): bool;
begin
  result := FindKey([pVari]);
end;
//-----------------------------------------------------------------------------------------------
end.
//-----------------------------------------------------------------------------------------------
//   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM
//-----------------------------------------------------------------------------------------------

