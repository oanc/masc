#!/bin/bash

source ./config.sh

echo running prep.sh

LOGICAL=$IN/logical
SENTENCE=$IN/sentence
TOKEN=$IN/token
NE=$IN/ne
NC=$IN/nc
VC=$IN/vc

#cd ..

# Copy over the text files.
java -jar $COPY -in=$IN/txtfiles -out=$OUT

# Convert XCES files.
echo opening $SENTENCE
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=s -in=$SENTENCE -out=$OUT -rename="Sentence=s" -id=s #original line

echo opening $LOGICAL
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=logical -in=$LOGICAL -out=$OUT -rename="paragraph=p @speaker=who"  #original line
#java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=logical -in=./logical -out=$OUT -rename="@speaker=who"  #updated on 4/26/2011

# Updated 9/9/2011 KBS
echo opening $TOKEN
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=penn -in=$TOKEN -out=$OUT -saveAs=penn -rename="Token=tok @category=msd" -id=penn #original line

echo opening $NC
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=nc-in=$NC -out=$OUT -saveAs=nc -rename="np=nchunk NounChunk=nchunk" -id=nc -accept=nchunk -exf=graf:set

echo opening $VC
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=vc -in=$VC -out=$OUT -saveAs=vc -rename="vp=vchunk VerbChunk=vchunk VG=vchunk" -id=vc -accept=vchunk -exf=graf:set

echo opening $IN/ne
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=NE -in=$NE -out=$OUT -rename="Person=person Date=date Location=location Organization=org @orgType=type @locType=type @gender=sex" -exf="rule rule1 rule2" -id=ne -accept="person date location org" -saveAs=ne



