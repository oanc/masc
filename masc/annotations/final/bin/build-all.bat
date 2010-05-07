@echo off
setlocal

pushd \workspace\graf
cmd /c mvn install

cd ..\Convert
cmd /c mvn package

cd ..\Align
cmd /c mvn package

popd

endlocal
