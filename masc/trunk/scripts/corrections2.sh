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

# Converts the GrAF files to XCES and puts them in the TEMP directory.
grate scripts/corrections.gr8 $IN/txtfiles $GRAF $TEMP $METADATA/MASC2-resource-header.xml
#exit

# Converts files in the TEMP directory and places them in the data/data directory.
java $OPTS -jar $CONVERT -xces $LOPTS -in=$TEMP -out=$OUT -set=anc -exf="graf:id graf:set" -id=nc -ann=nc -rename="np=nchunk NounChunk=nchunk" -accept=nchunk 
java $OPTS -jar $CONVERT -xces $LOPTS -in=$TEMP -out=$OUT -set=anc -exf="graf:id graf:set" -id=vc -ann=vc -rename="VG=vchunk vp=vchunk VerbChunk=vchunk"
java $OPTS -jar $CONVERT -xces $LOPTS -in=$TEMP -out=$OUT -set=anc -exf="graf:id graf:set" -id=ne -ann=ne -rename="Person=person Date=date Location=location Organization=org @orgType=type @locType=type @gender=sex" -exf="rule rule1 rule2" -accept="person date location org"
java $OPTS -jar $CONVERT -xces $LOPTS -in=$TEMP -out=$OUT -set=anc -exf="graf:id graf:set" -id=penn -ann=penn -rename="Token=tok @category=msd" -saveAs=penn #-exf="string graf:set graf:id graf:edge"
java $OPTS -jar $CONVERT -xces $LOPTS -in=$TEMP -out=$OUT -set=anc -ann=s -id=s -rename="Sentence=s" -exf="graf:set graf:id graf:edge"
java $OPTS -jar $CONVERT -xces $LOPTS -in=$TEMP -out=$OUT -set=xces -ann=logical -id=logical -rename="@speaker=who" -exf="graf:set graf:id graf:edge"
#rm -rf $TEMP
#exit

# Convert the XCES files.
java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -set=anc -ann=s -id=s -rename="Sentence=s" -exf="graf:set graf:id graf:edge"
java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -set=xces -ann=logical -id=logical -rename="@speaker=who" -exf="graf:set graf:id graf:edge"
java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -set=anc -ann=hepple -id=penn -rename="Token=tok @category=msd" -saveAs=penn -exf="graf:set graf:id graf:edge"
java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -set=anc -ann=penn -id=penn -rename="Token=tok @category=msd" -saveAs=penn -exf="graf:set graf:id graf:edge"
java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -ann=nc -set=anc -rename="np=nchunk NounChunk=nchunk" -id=nc -accept=nchunk -exf="graf:set graf:id graf:edge"
java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -ann=vc -set=anc -rename="VG=vchunk vp=vchunk VerbChunk=vchunk" -id=vc -accept=vchunk -exf="graf:set graf:id graf:edge"
java $OPTS -jar $CONVERT -xces $LOPTS -in=$XCES -out=$OUT -ann=ne -set=anc -rename="Person=person Date=date Location=location Organization=org @orgType=type @locType=type @gender=sex" -exf="rule rule1 rule2 graf:set graf:id graf:edge" -id=ne -accept="person date location org"



