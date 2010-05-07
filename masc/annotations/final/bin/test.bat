@echo off
setlocal

echo %0 %1 %2
:loop
if "%1"=="a" goto a
if "%1"=="b" goto b
goto end

:next
shift
goto loop

:a
echo Found a
goto next

:b
echo Found b
goto next

:end
echo Done.

endlocal