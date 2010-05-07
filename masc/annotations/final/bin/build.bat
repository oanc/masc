@echo off
setlocal

if "%COMPUTERNAME%"=="DAX" goto dax
if "%COMPUTERNAME%"=="SCOTTY" goto scotty
echo Unknown computer %COMPUTERNAME%
goto end

:dax
set WORKSPACE=c:\dev\workspace
set GRAF=graf-api
set CONVERT=Convert-1.0.0-SNAPSHOT
set ALIGN=Align-1.0.0-SNAPSHOT 

goto start

:scotty
rem echo Environment needs to be set up for scotty.
set WORKSPACE=d:\Workspace
set GRAF=graf
set CONVERT=convert
set ALIGN=align
goto start

:start
if "%1"=="" goto all

:loop
if "%1"=="" goto end
if "%1"=="all" goto :all
if "%1"=="graf" call :graf
if "%1"=="convert" call :convert
if "%1"=="align" call :align

:next
shift
goto loop

:graf
pushd %WORKSPACE%\%GRAF%
cmd /c mvn clean deploy
popd
goto :EOF

:convert
pushd %WORKSPACE%\%CONVERT%
cmd /c mvn clean package
popd
goto :EOF

:align
pushd %WORKSPACE%\%ALIGN%
cmd /c mvn clean package
popd
goto :EOF

:all
call :graf
call :convert
call :align
rem fall through

:end
echo Build complete.
endlocal