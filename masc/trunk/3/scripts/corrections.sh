#!/bin/bash

source ./config.sh

echo running corrections.sh

cd $ROOT

echo Processing corrected files.

GRAF=$IN/corrections/GrAF
XCES=$IN/corrections/XCES

echo java $OPTS -jar $CORRECT -in=$GRAF -out=$OUT $LOPTS
java $OPTS -jar $CORRECT -in=$GRAF -out=$OUT $LOPTS

echo java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -set=xces -ann=s -id=s -rename="Sentence=s"
java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -set=xces -ann=s -id=s -rename="Sentence=s"

echo java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -set=xces -ann=logical -rename="@speaker=who"
java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -set=xces -ann=logical -rename="@speaker=who"

echo java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -set=xces -ann=hepple -id=penn -rename="Token=tok @category=msd" -saveAs=penn
java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -set=xces -ann=hepple -id=penn -rename="Token=tok @category=msd" -saveAs=penn

echo java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -set=xces -ann=penn -id=penn -rename="Token=tok @category=msd" -saveAs=penn
java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -set=xces -ann=penn -id=penn -rename="Token=tok @category=msd" -saveAs=penn

echo java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -ann=nc -set=xces -rename="np=nchunk NounChunk=nchunk" -id=nc -accept=nchunk -exf=graf:set
java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -ann=nc -set=xces -rename="np=nchunk NounChunk=nchunk" -id=nc -accept=nchunk -exf=graf:set

echo java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -ann=vc -set=xces -rename="VG=vchunk" -id=vc -accept=vchunk -exf=graf:set
java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -ann=vc -set=xces -rename="VG=vchunk" -id=vc -accept=vchunk -exf=graf:set

echo java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -ann=ne -set=xces -rename="Person=person Date=date Location=location Organization=org @orgType=type @locType=type @gender=sex" -exf="rule rule1 rule2" -id=ne -accept="person date location org"
java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -ann=ne -set=xces -rename="Person=person Date=date Location=location Organization=org @orgType=type @locType=type @gender=sex" -exf="rule rule1 rule2" -id=ne -accept="person date location org"



