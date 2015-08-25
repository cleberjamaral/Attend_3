unit SID;

interface

Uses Classes, Forms;

Type
  TSID = Class(TComponent)
  private
    Procedure GetTipo;
    Procedure GetTelefone;
    Procedure GetHoradeInicio;
    Procedure GetDatadeInicio;
    Procedure GetTempo;
    Procedure GetRxChar(Sender: TObject; Count: Integer);
    { Private declarations }
  public
    { Public declarations }
      Tipo            : String;
      Telefone        : String;
      HoraDeInicio    : String;
      DataDeInicio    : String;
      Tempo           : String;
      OnInicioChamada : TNotifyEvent;
      OnFimChamada    : TNotifyEvent;
      OnRxMem         : TNotifyEvent;
    constructor Create(AOwner: TComponent); override;
    end;

  Var SIDObj : TSid;
  Function AbreComPort(Porta : Byte) : Boolean;

implementation

Uses Sysutils,CPort;

Var Port : TComPort;
    Registro,
    MsgSid          : String;
    EsperaInicio,
    EsperaFim       : Boolean;

Function Extract(S:String;Delim:Char;Nro:Byte) : String;
Var x,
    P_Ant,
    P_Del  : Byte;
    s1,
    s2  : String;
Begin
  P_Ant:=1;
  s1:=s;
  For x:=1 to Nro do Begin
      s1:=Copy(s1,P_Ant,255);
      P_Del:=Pos(Delim,s1);
      If P_Del>0 Then
        s2:=Copy(s1,1,P_Del-1)
      Else
         s2:=s1;
      P_Ant:=P_Del+1;
  end;
  Extract:=s2;
end; // Extract

Function Right_(s : string;ct : Word) : String;
Begin
  Right_ := Copy(s,Length(s)+1-ct,ct);
end;

Function Left_(s : string;ct : Word) : String;
Begin
  Left_ := Copy(s,1,ct);
end;

Function AbreComPort(Porta : Byte) : Boolean;
Begin
  SidObj := TSid.Create(Application);
  Port   := TComPort.Create(Application);
  With Port do Begin
    BaudRate          := br9600;
    Databits          := dbEight;
    StopBits          := sbOneStopBit;
    Parity.Bits       := prNone;
    Buffer.OutputSize := 32;
    Buffer.InputSize  := 32;
    OnRxChar          := SidObj.GetRxChar;
    Port              := 'Com' + IntToStr(Porta);
    Connected         := True;
  end;
  Result:=True;
  Try
    Port.Open;
  Except
    Result := False;
  end;
end;

Procedure TSid.GetTipo ;
Begin
  Tipo := Copy(Registro,1,1);
end;

Procedure TSid.GetTelefone;
Begin
  Telefone := Copy(Extract(Registro,' ',2),1,255);
end;

Procedure TSid.GetHoradeInicio;
Begin
  HoraDeInicio := Extract(Registro,' ',3);
end;

Procedure TSid.GetDatadeInicio ;
Begin
  DataDeInicio := Extract(Registro,' ',4);
end;

Procedure TSid.GetTempo;
Begin
  Tempo := Left_(Registro,8);
End;

Procedure TSid.GetRxChar(Sender: TObject; Count: Integer);
Var s : String;
Begin
  Port.ReadStr(s,Count);
  MsgSid:=MsgSid+s;
  If EsperaInicio then Begin
     If (Length(MsgSid)>13) and (Right_(MsgSid,1)=' ') Then Begin
        EsperaInicio := False;
        EsperaFim    := True;
        Registro     := MsgSid;
        GetTipo;
        GetTelefone;
        GetHoradeInicio;
        GetDatadeInicio;
        MsgSid := '';
        if Assigned(OnInicioChamada) then OnInicioChamada(self);
     end; // length(msgsid...
  end; // EsperaInicio
  If Right_(MsgSid,1)=#10 Then Begin
     Registro := MsgSID;
     MsgSid   := '';
     If EsperaFim Then Begin
       EsperaInicio := True;
       EsperaFim    := False;
       GetTempo;
       if Assigned(OnFimChamada) then OnFimChamada(self);
       end
     Else
        if Assigned(OnRxMem) then OnRxMem(self);
  end; //Right_(...
end; //GetRxChar

constructor TSid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  EsperaInicio := True;
  EsperaFim    := False;
  MsgSid       := '';
  Registro     := '';
end;

end.
