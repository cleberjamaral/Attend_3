unit SidControl_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : $Revision:   1.88  $
// File generated on 12/09/01 15:51:23 from Type Library described below.

// ************************************************************************ //
// Type Lib: \\SERVIDOR\G\OCEANO\COMP\OCEANO\BINA\SID.OCX (1)
// IID\LCID: {ACE9E93E-79AD-11D4-9290-00E07D799725}\0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\SYSTEM\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINDOWS\SYSTEM\STDVCL40.DLL)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, OleCtrls, StdVCL;

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  SidControlMajorVersion = 2;
  SidControlMinorVersion = 0;

  LIBID_SidControl: TGUID = '{ACE9E93E-79AD-11D4-9290-00E07D799725}';

  IID__Sid: TGUID = '{9F51C805-79B7-11D4-9290-00E07D799725}';
  DIID___Sid: TGUID = '{9F51C807-79B7-11D4-9290-00E07D799725}';
  CLASS_Sid: TGUID = '{9F51C806-79B7-11D4-9290-00E07D799725}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _Sid = interface;
  _SidDisp = dispinterface;
  __Sid = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Sid = _Sid;


// *********************************************************************//
// Interface: _Sid
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9F51C805-79B7-11D4-9290-00E07D799725}
// *********************************************************************//
  _Sid = interface(IDispatch)
    ['{9F51C805-79B7-11D4-9290-00E07D799725}']
    function  Get_Telefone: WideString; safecall;
    function  Get_DataDeInicio: WideString; safecall;
    function  Get_HoraDeInicio: WideString; safecall;
    function  Get_Tempo: WideString; safecall;
    function  Get_AbreComPort(var Porta: Smallint): Smallint; safecall;
    property Telefone: WideString read Get_Telefone;
    property DataDeInicio: WideString read Get_DataDeInicio;
    property HoraDeInicio: WideString read Get_HoraDeInicio;
    property Tempo: WideString read Get_Tempo;
    property AbreComPort[var Porta: Smallint]: Smallint read Get_AbreComPort;
  end;

// *********************************************************************//
// DispIntf:  _SidDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9F51C805-79B7-11D4-9290-00E07D799725}
// *********************************************************************//
  _SidDisp = dispinterface
    ['{9F51C805-79B7-11D4-9290-00E07D799725}']
    property Telefone: WideString readonly dispid 1745027076;
    property DataDeInicio: WideString readonly dispid 1745027075;
    property HoraDeInicio: WideString readonly dispid 1745027074;
    property Tempo: WideString readonly dispid 1745027073;
    property AbreComPort[var Porta: Smallint]: Smallint readonly dispid 1745027072;
  end;

// *********************************************************************//
// DispIntf:  __Sid
// Flags:     (4240) Hidden NonExtensible Dispatchable
// GUID:      {9F51C807-79B7-11D4-9290-00E07D799725}
// *********************************************************************//
  __Sid = dispinterface
    ['{9F51C807-79B7-11D4-9290-00E07D799725}']
    procedure InicioChamada; dispid 1;
    procedure FimChamada; dispid 2;
    procedure RxMem; dispid 3;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TSid
// Help String      : 
// Default Interface: _Sid
// Def. Intf. DISP? : No
// Event   Interface: __Sid
// TypeFlags        : (32) Control
// *********************************************************************//
  TSid = class(TOleControl)
  private
    FOnInicioChamada: TNotifyEvent;
    FOnFimChamada: TNotifyEvent;
    FOnRxMem: TNotifyEvent;
    FIntf: _Sid;
    function  GetControlInterface: _Sid;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    function  Get_AbreComPort(var Porta: Smallint): Smallint;
  public
    property  ControlInterface: _Sid read GetControlInterface;
    property  DefaultInterface: _Sid read GetControlInterface;
    property Telefone: WideString index 1745027076 read GetWideStringProp;
    property DataDeInicio: WideString index 1745027075 read GetWideStringProp;
    property HoraDeInicio: WideString index 1745027074 read GetWideStringProp;
    property Tempo: WideString index 1745027073 read GetWideStringProp;
    property AbreComPort[var Porta: Smallint]: Smallint read Get_AbreComPort;
  published
    property OnInicioChamada: TNotifyEvent read FOnInicioChamada write FOnInicioChamada;
    property OnFimChamada: TNotifyEvent read FOnFimChamada write FOnFimChamada;
    property OnRxMem: TNotifyEvent read FOnRxMem write FOnRxMem;
  end;

procedure Register;

implementation

uses ComObj;

procedure TSid.InitControlData;
const
  CEventDispIDs: array [0..2] of DWORD = (
    $00000001, $00000002, $00000003);
  CControlData: TControlData2 = (
    ClassID: '{9F51C806-79B7-11D4-9290-00E07D799725}';
    EventIID: '{9F51C807-79B7-11D4-9290-00E07D799725}';
    EventCount: 3;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$80040154*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnInicioChamada) - Cardinal(Self);
end;

procedure TSid.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _Sid;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TSid.GetControlInterface: _Sid;
begin
  CreateControl;
  Result := FIntf;
end;

function  TSid.Get_AbreComPort(var Porta: Smallint): Smallint;
begin
  Result := DefaultInterface.Get_AbreComPort(Porta);
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TSid]);
end;

end.
