{ = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

                 O C E A N O   -    M A R    S O L U Ç Õ E S

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
                                I N I C I O
= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
Autor        : Equipe Oceano Tecnologia
Local        : Escritório, Florianópolis
Data         :
Versão       : 1.0
Descrição    : pacote de componentes Oceano para Delphi 2.0
Comentário   :
= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

unit NRegCom2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs, StdCtrls, ExtCtrls,
  NImpExp, NOrganiza, NVariavel, NMensagem, NInspetor, NMiniCad, NInternet,
  NPcSupor, NPcClien, NPergunta, OExpira, BINA;

procedure Register;

implementation

{= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =}

procedure Register;
begin
  RegisterComponents('Oceano', [
                                TNVariavel,
                                TNImpExp,
                                TNOrganiza,
                                TNMensagem,
                                TNPergunta,
                                TNInspetor,
                                TNMiniCad,
                                TNInternet,
                                TNpcSuporte,
                                TNpcCliente,
                                TOExpira,
                                TBina
                                ]);
end;

end.
