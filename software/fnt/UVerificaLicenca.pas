//-----------------------------------------------------------------------------------------------
// TIPOS DE LICENÇAS:
// 0 = DEMO
// 1 = FREEWARE
// 2 = PERMANENTE
// 255 = IRREGULAR
//-----------------------------------------------------------------------------------------------
unit UVerificaLicenca;
//-----------------------------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------------------------
type VerificaLicenca = class
//-----------------------------------------------------------------------------------------------
protected
public
  constructor criarInstancia();
  //-- Verifica se a licenca gerada está ok
  function verificarLicenca(p_Licenca: string): byte;
  procedure setarParametros(p_A,p_B,p_C,p_D,p_E,p_F,p_H,p_J,p_K,p_L,p_N,p_O:Integer);
end;
//-----------------------------------------------------------------------------------------------
var
	VerificaLicenca1: VerificaLicenca;
	//-- Valores padrão são para Tele 1.1
	nA : Integer = 19; //-- 1 a 25
	nB : Integer =  9; //-- 1 a 25
	nC : Integer =  7; //-- 1 a 25
	nD : Integer =  5; //-- 1 a 25
	nE : Integer = 21; //-- 1 a 25
	nF : Integer =  6; //-- 1 a 25
	nG : Integer =  0; //-- 0
	nH : Integer = 17; //-- 1 a 25
	nI : Integer =  0; //-- 0
	nJ : Integer = 16; //-- 1 a 25
	nK : Integer = 20; //-- 1 a 25
	nL : Integer =  4; //-- 1 a 25
	nM : Integer =  0; //-- 0
	nN : Integer = 22; //-- 1 a 25
	nO : Integer = 12; //-- 1 a 25
//-----------------------------------------------------------------------------------------------
implementation
//-----------------------------------------------------------------------------------------------
constructor VerificaLicenca.criarInstancia();
begin
end;
//----------------------------------------------------------------------------------------------------//
//-- Verifica se a licenca gerada está ok
function VerificaLicenca.verificarLicenca(p_Licenca: string): byte;
var licOriginal: string;
	 licChecagem: string;
	 licenca : array[0..15] of byte;
	 semente1: byte;
	 semente2: byte;
	 semente3: byte;
	 semente4: byte;
	 i : byte;
begin
  if ((p_Licenca = '') or (p_Licenca = '    -    -    -    ')) then begin
	 result := 255;
	 Exit;
  end;

  licOriginal := p_Licenca;
  while (pos('-',licOriginal) > 0) do Delete(licOriginal,pos('-',licOriginal),1);
  semente1 := Ord(licOriginal[9 ])-65;
  semente2 := Ord(licOriginal[7 ])-65;
  semente3 := Ord(licOriginal[13])-65;
  semente4 := Ord(licOriginal[16])-65;
  //-- Gera licenca de acrodo com as sementes
  if (semente3 >= nA) then licenca[0 ] := semente3-nA+65 else licenca[0 ] := semente3+(25-nA)+65;
  if (semente2 >= nB) then licenca[1 ] := semente2-nB+65 else licenca[1 ] := semente2+(25-nB)+65;
  if (semente3 <= nC) then licenca[2 ] := nC-semente3+65 else licenca[2 ] := semente3-nC+65;
  if (semente1 >= nD) then licenca[3 ] := semente1-nD+65 else licenca[3 ] := semente1+(25-nD)+65;
  if (semente3 <= nE) then licenca[4 ] := nE-semente3+65 else licenca[4 ] := semente3-nE+65;
  if (semente1 >= nF) then licenca[5 ] := semente1-nF+65 else licenca[5 ] := semente1+(25-nF)+65;
  if (semente2 <= nG) then licenca[6 ] := nG-semente2+65 else licenca[6 ] := semente2-nG+65;
  if (semente2 <= nH) then licenca[7 ] := nH-semente2+65 else licenca[7 ] := semente2-nH+65;
  if (semente1 <= nI) then licenca[8 ] := nI-semente1+65 else licenca[8 ] := semente1-nI+65;
  if (semente1 >= nJ) then licenca[9 ] := semente1-nJ+65 else licenca[9 ] := semente1+(25-nJ)+65;
  if (semente3 <= nK) then licenca[10] := nK-semente3+65 else licenca[10] := semente3-nK+65;
  if (semente2 >= nL) then licenca[11] := semente2-nL+65 else licenca[11] := semente2+(25-nL)+65;
  if (semente3 <= nM) then licenca[12] := nM-semente3+65 else licenca[12] := semente3-nM+65;
  if (semente2 >= nN) then licenca[13] := semente2-nN+65 else licenca[13] := semente2+(25-nN)+65;
  if (semente3 <= nO) then licenca[14] := nO-semente3+65 else licenca[14] := semente3-nO+65;
  licenca[15] := semente4+65;
  licChecagem := '';
  for i:= 0 to 15 do licChecagem := licChecagem+Chr(licenca[i]);
  if (licChecagem = licOriginal) then
  begin
    // [LER EM UVERIFICALICENCA -> TIPOS DE LICENÇAS] //
    case semente4 of
      0..7:   result := 0; //--DEMO
      8..15:  result := 1; //--FREE
		16..23: result := 2; //--PERM
    else
      result := 255; //--Erro //-- IRREGULAR
    end;
  end
  else
  begin
	 result := 255; //--Erro //-- IRREGULAR
  end;
end;
//-----------------------------------------------------------------------------------------------
procedure VerificaLicenca.setarParametros(p_A,p_B,p_C,p_D,p_E,p_F,p_H,p_J,p_K,p_L,p_N,p_O:Integer);
begin
	nA := p_A;
	nB := p_B; //-- 1 a 25
	nC := p_C; //-- 1 a 25
	nD := p_D; //-- 1 a 25
	nE := p_E; //-- 1 a 25
	nF := p_F; //-- 1 a 25
	nG := 0; //-- 0
	nH := p_H; //-- 1 a 25
	nI := 0; //-- 0
	nJ := p_J; //-- 1 a 25
	nK := p_K; //-- 1 a 25
	nL := p_L; //-- 1 a 25
	nM := 0; //-- 0
	nN := p_N; //-- 1 a 25
	nO := p_O; //-- 1 a 25
end;
//-----------------------------------------------------------------------------------------------
end.
//-----------------------------------------------------------------------------------------------
//   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM   FIM
//-----------------------------------------------------------------------------------------------
