@echo off
setlocal

if "%COMPUTERNAME%"=="DAX" goto dax
if "%COMPUTERNAME%"=="SCOTTY" goto scotty
echo Unknown computer name %%COMPUTERNAME%
goto end

:dax
echo Running on Dax.
set MASC=C:\Corpora2\masc
set CONVERT=C:\dev\workspace\Convert-1.0.0-SNAPSHOT\target\Convert.jar
set ALIGNDIR=C:\dev\workspace\Align-1.0.0-SNAPSHOT
set ALIGN=%ALIGNDIR%\target\Align.jar
set XORO=c:\bin\xoro.bat
goto vars

:scotty
echo Running on Scotty.
set MASC=D:\Corpora\masc
set CONVERT=D:\workspace\Convert\target\Convert.jar
set ALIGNDIR=D:\workspace\Align
set ALIGN=%ALIGNDIR%\target\Align.jar
set COPY=D:\Workspace\copy-files\target\CopyFiles-1.0.0-SNAPSHOT.jar
set XORO=d:\bin\xoro.bat
goto vars

:vars
set IN=%MASC%\FINAL
set DEST=%MASC%\for-release\data
set FN=%MASC%\Framenet
set PTB=%MASC%\ptb
set FNFIX=%ALIGNDIR%\fn-fixes.xml
set PTBFIX=%ALIGNDIR%\ptb-fixes.xml
set MPQA=%IN%\opinion
set LOGFILE=%MASC%\prep-release.log
set LOG=-log=%LOGFILE% -level=info -append
 
:loop
if "%1"=="" goto end
if "%1"=="all" call :all
if "%1"=="headers" call :headers
if "%1"=="text" call :text
if "%1"=="txt" call :text
if "%1"=="c5" call :c5
if "%1"=="logical" call :logical
if "%1"=="ne" call :ne
if "%1"=="cb" call :cb
if "%1"=="event" call :event
if "%1"=="np" call :np
if "%1"=="nc" call :np
if "%1"=="vp" call :vp
if "%1"=="vc" call :vp
if "%1"=="s" call :s
if "%1"=="fn" call :fn
if "%1"=="fn-convert" call :fn-convert
if "%1"=="fn-align" call :fn-align
if "%1"=="ptb" call :ptb
if "%1"=="ptb-convert" call :ptb-convert
if "%1"=="ptb-align" call :ptb-align
if "%1"=="penn" call :penn
if "%1"=="corr" call :corrections
if "%1"=="corrections" call :corrections
if "%1"=="mpqa" call :opinion
if "%1"=="opinion" call :opinion
rem echo Unknown command %1
rem goto end

:next
shift
goto loop

:headers
del %DEST%\*.anc
rem copy %IN%\headers\*.anc %DEST%
java -jar %COPY% -in=%IN%\new-headers -out=%DEST%
goto :EOF

:text
del %DEST%\*.txt
rem copy %IN%\txtfiles\*.txt %DEST%
java -jar %COPY% -in=%IN%\txtfiles -out=%DEST%
copy %MASC%\MASC_CORRECTIONS\*.txt %DEST%
goto :EOF

:c5
echo Processing CLAWS5 tags is temporarily disabled.
rem del %DEST%\*-C5.xml
rem java -jar %CONVERT% -xces -in=%IN%\C5PosTags -out=%DEST% -ann=C5 %LOG% -set=xces
goto :EOF

:s
del %DEST%\*-s.xml
java -jar %CONVERT% -xces -in=%IN%\sentence-boundaries -out=%DEST% -ann=s -log=%LOGFILE% -level=info -set=xces -rename="Sentence=s" -id=s
goto :EOF

:logical
del %DEST%\*-logical.xml
java -jar %CONVERT% -xces -in=%IN%\logical -out=%DEST% -ann=logical %LOG% -set=xces -rename="@speaker=who"
goto :EOF

:penn
del %DEST%\*-penn.xml
del %DEST%\*-hepple.xml
java -jar %CONVERT% -xces -in=%IN%\PennPosTags -out=%DEST% -ann=hepple -saveAs=penn %LOG% -set=xces -rename="Token=tok @category=msd" -id=penn
goto :EOF

:fn
del %DEST%\*-fn.xml 
del /Q %FN%\graf\*.*
del /Q %FN%\aligned\*.*
call :fn-convert
call :fn-align
copy %FN%\aligned\*.* %DEST%
goto :EOF

:fn-convert
java -Xmx1000M -jar %CONVERT% -fn -in=%FN%\original -out=%FN%\graf %LOG% -set=FrameNet
goto :EOF

:fn-align
java -Xmx500M -jar %ALIGN% -src=%FN%\graf -target=%DEST% -dest=%FN%\aligned -type=fn -fix=%FNFIX% -skip %LOG%
goto :EOF

:ptb
del %DEST%\*-ptb.xml
del /Q %PTB%\graf\*.*
del /Q %PTB%\aligned\*.*
rem java -Xmx500M -jar %CONVERT% -ptb -in=%PTB%\original -out=%PTB%\graf %LOG% -set=PTB
rem java -Xmx500M -jar %ALIGN% -src=%PTB%\graf -target=%MASC%\FINAL\txtfiles -dest=%PTB%\aligned -type=ptb -fix=%PTBFIX% -skip %LOG%
call :ptb-convert
call :ptb-align
copy %PTB%\aligned\*.* %DEST%
goto :EOF

:ptb-convert
rem del /Q %PTB%\graf\*.*
java -Xmx800M -jar %CONVERT% -ptb -in=%PTB%\original -out=%PTB%\graf %LOG% -set=PTB -id=ptb
del /Q %PTB%\graf\enron-thread-*.*
goto :EOF

:ptb-align
rem del /Q %PTB%\aligned\*.*
java -Xmx500M -jar %ALIGN% -src=%PTB%\graf -target=%DEST% -dest=%PTB%\aligned -type=ptb -fix=%PTBFIX% -skip %LOG%
goto :EOF

:np
del %DEST%\*-nc.xml
del %DEST%\*-np.xml
java -jar %CONVERT% -xces -in=%IN%\nounchunks -out=%DEST% -ann=np -saveAs=nc %LOG% -set=xces -rename="np=nchunk NounChunk=nchunk" -id=nc
goto :EOF

:vp
del /Q %DEST%\*-vc.xml
del /Q %DEST%\*-vp.xml
java -Xmx500M -jar %CONVERT% -xces -in=%IN%\VerbChunks -out=%DEST% -ann=vp -saveAs=vc -set=xces -rename="VG=vchunk" -id=vc %LOG%
goto :EOF

:cb
del /Q %DEST%\*-CB.xml
del /Q %DEST%\*-cb.xml
java -Xmx500M -jar %CONVERT% -xces -in=%IN%\Committed-Belief -out=%DEST% -ann=CB -saveAs=cb -set=xces -id=cb %LOG%
goto :EOF

:event
del /Q %DEST%\*-event.xml
java -Xmx500M -jar %CONVERT% -xces -in=%IN%\event -out=%DEST% -ann=event -saveAs=event -set=xces -id=ev %LOG%
goto :EOF

:ne
del /Q %DEST%\*-NE.xml
del /Q %IN%\NE-all\*.*
echo Running XORO
call %XORO% combine-ne.xoro
java -jar %CONVERT% -xces -in=%IN%\NE-All -out=%DEST% -ann=NE %LOG% -set=xces -rename="Person=person Date=date Location=location Organization=org @orgType=type @locType=type @gender=sex" -exf="rule rule1 rule2" -id=ne
goto :EOF

:opinion
del /Q %DATA%\*-mpqa.xml
del /Q %MPQA%\aligned\*.*
del /Q %MPQA%\graf
call %XORO% opinion.xoro
java -Xmx500M -jar %ALIGN% -src=%MPQA%\graf -target=%DEST% -dest=%MPQA%\aligned -type=mpqa %LOG% -skip
goto :EOF

:corr
:corrections
copy %MASC%\MASC_CORRECTIONS\*.xml %DEST%
goto :EOF

:all
del /Q %DEST%\*.*
call :headers
call :text
call :s
call :c5
call :logical
call :vp
call :np
call :penn
call :ptb
call :fn
call :ne
call :cb
call :event
call :corrections
call :opinion
goto end

REM java -jar %CONVERT% -xces -set=masc -in=%IN%\C5PosTags -out=%DEST% -ann=C5 -log=prep-c5.log 
REM java -jar %CONVERT% -xces -set=masc -in=%IN%\logical -out=%DEST% -ann=logical -log=prep-logical.log
REM java -jar %CONVERT% -xces -set=masc -in=%IN%\NE-organization -out=%DEST% -ann=NE -log=prep-ne.log
REM java -jar %CONVERT% -xces -set=masc -in=%IN%\nounchunks -out=%DEST% -ann=np -log=prep-np.log
REM java -jar %CONVERT% -xces -set=masc -in=%IN%\sentence-boundaries -out=%DEST% -ann=s -log=prep-s.log
REM java -Xmx500M -jar %CONVERT% -fn -in=%FN%\original\ANC_all -out=%FN%\graf -log=prep-fn.log
REM java -Xmx500M -jar %ALIGN% -src=%FN%\graf -target=%MASC%\FINAL\txtfiles -dest=%DEST% -type=fn -fix=%FNFIX%
REM java -Xmx500M -jar %CONVERT% -ptb -in=%PTB%\original -out=%PTB%\graf -log=prep-ptb.log
REM java -Xmx500M -jar %ALIGN% -src=%PTB%\graf -target=%MASC%\FINAL\txtfiles -dest=%DEST% -type=ptb -fix=%PTBFIX%

:end
echo Release preparation complete.
endlocal
