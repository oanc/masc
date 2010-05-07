@echo off
setlocal

for /F %%i in ('dir /B event\*.*') do set FILE=%%i & call :rename
goto end

:rename
set NEWFILE=%FILE:~0,-11%-event.xml
move event\%FILE% event\%NEWFILE%
goto :EOF

:end
echo Renaming complete.
endlocal