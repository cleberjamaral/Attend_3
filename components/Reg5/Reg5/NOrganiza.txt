{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

Autor        : Cássio Lacerda
Nódulo       : NOrganiza.pas
Criação      : 16/10/00 00:30
Descrição    : Componente para Organização de Tabelas
Comentário   : Este componente é derivado do TComponent,
               sua função é organizar uma tabela

 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

unit NOrganiza;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, DB, DBTables;

type
  TNOrganiza = class(TComponent) 
  private
    FCriar        : Bool;
    FTableName    : TFileName;
    FDatabaseName : string;
  protected
  public
//    constructor Create (Aowner:TComponent); override;
//    destructor  Destroy; override;

  published
    property Criar        : bool        read FCriar        write FCriar;
    property TableName    : TFileName   read FTableName    write FTableName;
    property DatabaseName : string      read FDatabaseName write FDatabaseName;
  end;

implementation

end.
