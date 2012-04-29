#!/bin/bash

source ./config.sh
cd $ROOT

echo Processing corrected files.

GRAF=$IN/corrections/GrAF
XCES=$IN/corrections/XCES
TEMP=/tmp/corrections

#java $OPTS -jar $CORRECT -in=$GRAF -out=$OUT $LOPTS

if [ -e $TEMP ] ; then
	rm -rf $TEMP
fi

mkdir $TEMP

grate scripts/corrections.gr8 $IN/txtfiles $GRAF $TEMP
java $OPTS -jar $CONVERT -xces $LOPTS -in=$TEMP -out=$OUT -set=xces -exf="graf:id graf:set" -id=nc -ann=nc -rename="np=nchunk NounChunk=nchunk" -accept=nchunk 
java $OPTS -jar $CONVERT -xces $LOPTS -in=$TEMP -out=$OUT -set=xces -exf="graf:id graf:set" -id=vc -ann=vc -rename="VG=vchunk"
java $OPTS -jar $CONVERT -xces $LOPTS -in=$TEMP -out=$OUT -set=xces -exf="graf:id graf:set" -id=ne -ann=ne -rename="Person=person Date=date Location=location Organization=org @orgType=type @locType=type @gender=sex" -exf="rule rule1 rule2" -accept="person date location org"
java $OPTS -jar $CONVERT -xces $LOPTS -in=$TEMP -out=$OUT -set=xces -exf="graf:id graf:set" -id=penn -ann=penn -rename="Token=tok @category=msd" -saveAs=penn
java $OPTS -jar $CONVERT -xces $LOPTS -in=$TEMP -out=$OUT -set=xces -ann=s -id=s -rename="Sentence=s"
java $OPTS -jar $CONVERT -xces $LOPTS -in=$TEMP -out=$OUT -set=xces -ann=logical -id=logical -rename="@speaker=who"
rm -rf $TEMP
#exit

java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -set=xces -ann=s -id=s -rename="Sentence=s"
java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -set=xces -ann=logical -id=logical -rename="@speaker=who"
java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -set=xces -ann=hepple -id=penn -rename="Token=tok @category=msd" -saveAs=penn
java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -set=xces -ann=penn -id=penn -rename="Token=tok @category=msd" -saveAs=penn
java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -ann=nc -set=xces -rename="np=nchunk NounChunk=nchunk" -id=nc -accept=nchunk -exf=graf:set
java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -ann=vc -set=xces -rename="VG=vchunk" -id=vc -accept=vchunk -exf=graf:set
java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -ann=ne -set=xces -rename="Person=person Date=date Location=location Organization=org @orgType=type @locType=type @gender=sex" -exf="rule rule1 rule2" -id=ne -accept="person date location org"



