@echo off
setlocal

if "%COMPUTERNAME%"=="DAX" goto dax
if "%COMPUTERNAME%"=="SCOTTY" goto scotty
echo Unknown computer name %%COMPUTERNAME%
goto end

:dax
echo Running on Dax.
set MASC=C:\Corpora2\masc\for-release\data
set EDGER=C:\dev\workspace\edger\target\MascEdger.jar
set OUT=C:\temp\masc
goto main

:scotty
echo Running on Scotty.
set MASC=D:\Corpora\masc\for-release\data
set EDGER=D:\workspace\linktotokens\target\MascEdger.jar
set OUT=D:\temp\masc
goto main


:main

del /Q %OUT%\*.*
java -jar %EDGER% -in=%MASC% -out=%OUT% -itype=NE -otype=NE -new -tok=PTBTOK
java -jar %EDGER% -in=%MASC% -out=%OUT% -itype=NC -otype=NC -new -tok=PTBTOK
java -jar %EDGER% -in=%MASC% -out=%OUT% -itype=VC -otype=VC -new -tok=PTBTOK
copy %OUT%\*.* %MASC%

:end
echo Edges created to tokens.
endlocal
