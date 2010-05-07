@echo off
setlocal

if "%COMPUTERNAME%"=="DAX" goto dax
if "%COMPUTERNAME%"=="SCOTTY" goto scotty
echo Unknown computer name %%COMPUTERNAME%
goto end

:dax
echo Running on Dax.
set MASC=C:\Corpora2\masc
goto vars

:scotty
echo Running on Scotty.
set MASC=D:\Corpora\masc
set SPLITTER=D:\Workspace\graph-splitter\target\graph-splitter.jar
set TOKENS=D:\Temp\tokens
set BACK=%TOKENS%\backups

goto vars

:vars
set IN=%MASC%\FINAL
set DATA=%MASC%\for-release\data

:loop

del %DATA%\*-ptb.xml
del %DATA%\*-ptb.xml
del %DATA%\*-fn.xml
del %DATA%\*-fntok.xml
del %DATA%\*-penn.xml
del %DATA%\*-seg.xml


copy BACK%\*.* %DATA%

:end
echo Quarkification reversed.
endlocal
