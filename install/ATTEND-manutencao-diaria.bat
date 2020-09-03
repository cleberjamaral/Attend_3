@echo off

PATH=%path%;%ProgramFiles%\Firebird\Firebird_2_1\bin;%ProgramFiles(x86)%\Firebird\Firebird_2_1\bin;%ProgramFiles%\Firebird\Firebird_2_5\bin;%ProgramFiles(x86)%\Firebird\Firebird_2_5\bin;

cd\

IF EXIST "%PROGRAMFILES(X86)%" (GOTO 64BIT) ELSE (GOTO 32BIT)
:64BIT
cd %ProgramFiles(x86)%\Softiza\Attend3_5\baseib\
GOTO ENDCheckOS
:32BIT
cd %ProgramFiles%\Softiza\Attend3_5\baseib\
GOTO ENDCheckOS
:ENDCheckOS

isql -u SYSDBA -p masterkey "COMMERCE.FDB" -i ATTEND-manutencao-diaria.sql
gbak -B -G -USER SYSDBA -PAS masterkey "COMMERCE.FDB" "COMMERCE_back.gbk"

del COMMERCE_back7.gbk
ren COMMERCE_back6.gbk COMMERCE_back7.gbk
ren COMMERCE_back5.gbk COMMERCE_back6.gbk
ren COMMERCE_back4.gbk COMMERCE_back5.gbk
ren COMMERCE_back3.gbk COMMERCE_back4.gbk
ren COMMERCE_back2.gbk COMMERCE_back3.gbk
ren COMMERCE_back1.gbk COMMERCE_back2.gbk
ren COMMERCE_back.gbk COMMERCE_back1.gbk

@echo on