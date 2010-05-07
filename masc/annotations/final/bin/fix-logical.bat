@echo off
setlocal

if "%COMPUTERNAME%"=="DAX" goto dax
if "%COMPUTERNAME%"=="SCOTTY" goto scotty
echo Unknown computer name %%COMPUTERNAME%
goto end

:dax
echo Running on Dax.
set MASC=C:\Corpora2\masc\for-release\data
set APP=C:\dev\workspace\make-tree\target\MakeTree.jar
set OUT=C:\temp\logical
goto main

:scotty
echo Running on Scotty.
set MASC=D:\Corpora\masc\for-release\data
set APP=D:\workspace\make-tree\target\MakeTree.jar
set OUT=D:\temp\logical
goto main

:main
if exists %OUT% goto run
mkdir %OUT%
if %ERRORLEVEL% LEQ 1 goto run
echo Unable to create output directory %OUT%
goto end

:run
del /Q %OUT%\*.*
java -jar %APP% -in=%MASC% -out=%OUT% -atype=logical -level=warn
copy %OUT%\*.* %MASC%

echo Logical annotations fixed.

:end
endlocal
