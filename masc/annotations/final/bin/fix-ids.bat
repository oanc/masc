@echo off
setlocal

if "%COMPUTERNAME%"=="DAX" goto dax
if "%COMPUTERNAME%"=="SCOTTY" goto scotty
echo Unknown computer name %%COMPUTERNAME%
goto end

:dax
echo Running on Dax.
set MASC=C:\Corpora2\masc\for-release\data
set APP=C:\dev\workspace\check-ids\target\CheckIds.jar
set OUT=C:\temp\sentences
goto main

:scotty
echo Running on Scotty.
set MASC=D:\Corpora\masc\for-release\data
set APP=D:\workspace\check-ids\target\CheckIds.jar
set OUT=D:\temp\sentences
goto main


:main

del /Q %OUT%\*.*
java -jar %APP% -in=%MASC% -out=%OUT% -filter=*-s.xml -level=warn
copy %OUT%\*.* %MASC%

:end
echo Sentence ID generation complete.
endlocal
