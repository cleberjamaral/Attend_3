{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

Autores      : Cássio Lacerda e Cleber Amaral
Nódulo       : NInternet.pas
Criação      : 10/11/2000
Comentário   : Baseado no componente GoToWeb de CRESTO Sylvain

 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

unit NInternet;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Shellapi, DsgnIntf;

type
  TBrowserState=(gwMaximized,gwNormal);
  TNInternet = class(TComponent)
  private
    FUrl:String;
    FEmail:String;
    FBrowserState:TBrowserState;
    FEMailSubject:String;
    procedure SetUrl(value:string);
    procedure SetEMail(value:string);
    procedure SetBrowserState(value:TBrowserState);
    procedure SetEmailSubject(value:string);
  public
    constructor Create(aOwner : TComponent); override;
    function IsAnyBrowser : boolean;
    function BrowserPath:string;
    function Execute : boolean;
    function SendEMail:boolean;
  published
    property Url : string read FUrl write SetUrl;
    property EMail : string read FEMail write SetEMail;
    property EMailSubject : string read FEmailSubject write SetEMailSubject;
    property BrowserState : TBrowserState read FBrowserState write SetBrowserState;
  end;

  function GwToSw(GwValue:TBrowserState):integer;

implementation

  const nbr_extension=4;
        extension:array[0..nbr_extension-1] of string=('.HTM','.HTML','.SHTML','.SHTM');
        
  var para:string;


function FindBrowser:string;
  var c:byte;
      hkey1,hkey2:hkey;
      typ,taille:integer;
      tmp:array[0..1024] of char;
begin
  c:=0;
  repeat
    if regopenkeyex(hkey_classes_root,pchar(extension[c]),0,key_all_access,hkey1)=0 then
    begin
      if regqueryvalueex(hkey1,nil,nil,@typ,nil,@taille)=error_success then
      begin
        regqueryvalueex(hkey1,nil,nil,nil,@tmp,@taille);
        if tmp<>'' then
        if regopenkeyex(hkey_classes_root,pchar(tmp+'\shell\open\command'),0,key_all_access,hkey2)=error_success then
        begin
          if regqueryvalueex(hkey2,nil,nil,@typ,nil,@taille)=error_success then
          begin
            regqueryvalueex(hkey2,nil,nil,nil,@tmp,@taille);
            if tmp<>'' then
            begin
{              Arrange;}
              RegCloseKey(hkey2);
              FindBrowser:=strpas(tmp){tmpstr};
              Exit;
            end;
          end;
          regclosekey(hkey2);
        end;
        if regopenkeyex(hkey1,'shell\open\command',0,key_all_access,hkey2)=error_success then
        begin
          if regqueryvalueex(hkey2,nil,nil,@typ,nil,@taille)=error_success then
          begin
            regqueryvalueex(hkey2,nil,nil,nil,@tmp,@taille);
            if tmp<>'' then
            begin
{             Arrange;}
              RegCloseKey(hkey2);
              FindBrowser:=strpas(tmp){tmpstr};
              Exit;
            end;
          end;
        end;
      end;
      regclosekey(hkey1);
    end;
    inc(c);
  until c=nbr_extension;
  FindBrowser:='';
end;

function GwToSw(GwValue:TBrowserState):integer;
begin
  case GwValue of
    gwMaximized: GwToSw:=SW_MAXIMIZE;
    gwNormal: GwToSw:=SW_SHOWNORMAL;
    else GwToSw:=0;
  end;
end;

{ TNInternet }

constructor TNInternet.create(aOwner : Tcomponent);
begin
  inherited create(aOwner);
  FUrl          := 'nsoftwares.com';
  FEmail        := 'suporte@nsoftwares.com';
  FEMailSubject := 'Suporte';
end;

function TNInternet.IsAnyBrowser : boolean;
begin
  IsAnyBrowser:=FileExists(BrowserPath);
end;

procedure TNInternet.SetEmailSubject(value:string);
begin
  FEmailSubject:=value;
end;

procedure TNInternet.SetBrowserState(value:TBrowserState);
begin
  FBrowserState:= value;
end;

procedure TNInternet.SetUrl(value:string);
begin
  FUrl:=value;
end;

procedure TNInternet.SetEMail(value:string);
begin
  FEMail:=value;
end;

function TNInternet.BrowserPath:string;
  var tmp:string;
      s,c:word;
begin
  tmp:=findbrowser;
  if tmp<>'' then
  begin
    c:=length(tmp)+1;
    repeat
      dec(c);
      para:=uppercase(copy(tmp,c-3,4));
    until (para='.EXE') or (para='.BAT') or (para='.COM');
    if c<length(tmp) then
    begin
      s:=c;
      para:=trim(copy(tmp,c+1,length(tmp)-(c)));
      c:=1;
      while (c<=length(para)) do
        if para[c]='"' then delete(para,c,1) else inc(c);
      if para<>'' then
      begin
        c:=1;
        while c<=length(para) do
        begin
          if para[c]='%' then
          begin
            while (c<=length(para)) and (para[c]<>' ') do delete(para,c,1);
          end else inc(c);
        end;
      end;
      para:=trim(para);
      delete(tmp,s+1,length(tmp)-s);
    end else para:='';
    if tmp[1]='"' then delete(tmp,1,1);
  end;
  BrowserPath:=tmp;
end;

function TNInternet.Execute:boolean;
  var tmp:string;
begin
  tmp:=BrowserPath;
  if tmp<>'' then
  begin
    if shellexecute(application.handle,nil,pchar(tmp),pchar(para+' '+FUrl),nil,GwToSw(FBrowserState))<33 then Execute:=false else Execute:=true;
  end else Execute:=false;
end;

function TNInternet.SendEMail:boolean;
  var tmp:string;
begin
  tmp:=BrowserPath;
  if tmp<>'' then
  begin
    if shellexecute(application.handle,nil,pchar(tmp),pchar(para+' mailto:'+FEMail+'?subject='+FEMailSubject),nil,GwToSw(FBrowserState))<33 then
      SendEMail:=false
    else
      SendEMail:=true;
  end else SendEMail:=false;
end;


end.
