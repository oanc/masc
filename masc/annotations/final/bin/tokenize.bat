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

copy %DATA%\*ptb.xml %BACK%
copy %DATA%\*fn.xml %BACK%
copy %DATA%\*penn.xml %BACK%

java -cp %SPLITTER% org.anc.graf.splitter.App -in=%DATA% -out=%TOKENS%\ptb -type=ptb -set=PTB
java -cp %SPLITTER% org.anc.graf.splitter.App -in=%DATA% -out=%TOKENS%\fn -type=fn -set=FrameNet

java -cp %SPLITTER% org.anc.graf.tokens.MergeTokens -penn=%DATA% -ptb=%TOKENS%\ptb -fn=%TOKENS%\fn -out=%TOKENS%\QUARKS -log=quarks.log -source=ptb -target=fn

copy %TOKENS%\fn\*.xml %DATA%
copy %TOKENS%\ptb\*.xml %DATA%
copy %TOKENS%\quarks\*.xml %DATA%

:end
echo Quarkification complete.
endlocal
