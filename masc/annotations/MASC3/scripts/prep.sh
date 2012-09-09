#!/bin/bash

source ./config.sh

echo running prep.sh

LOGICAL=$IN/logical
SENTENCE=$IN/sentence
TOKEN=$IN/token
NOUNS=$IN/nc
VERBS=$IN/vc
NAMES=$IN/ne
TEXT=$IN/txtfiles

# Copy over the text files.
java -jar $COPY -in=$TEXT -out=$OUT

# Convert XCES files.
echo opening $SENTENCE
java $OPTS -jar $CONVERT -xces $LOPTS -set=anc -id=s -ann=s -in=$SENTENCE -out=$OUT -rename="Sentence=s" 

echo opening $LOGICAL
java $OPTS -jar $CONVERT -xces $LOPTS -set=anc -ann=logical  -id=logical -in=$LOGICAL -out=$OUT -rename="paragraph=p @speaker=who"  

# Updated 9/9/2011 KBS
echo opening $TOKEN
java $OPTS -jar $CONVERT -xces $LOPTS -set=anc -ann=penn -id=penn -in=$TOKEN -out=$OUT -saveAs=penn -rename="Token=tok @category=msd @root=base" #-exf=string

echo opening $NOUNS
java $OPTS -jar $CONVERT -xces $LOPTS -set=anc -ann=nc -id=nc -in=$NOUNS -out=$OUT -saveAs=nc -rename="np=nchunk NounChunk=nchunk" -accept=nchunk -exf=graf:set

echo opening $VERBS
java $OPTS -jar $CONVERT -xces $LOPTS -set=anc -ann=vc -id=vc -in=$VERBS -out=$OUT -saveAs=vc -rename="vp=vchunk VerbChunk=vchunk VG=vchunk" -accept=vchunk -exf=graf:set

echo opening $NAMES
java $OPTS -jar $CONVERT -xces $LOPTS -set=anc -ann=ne -id=ne -in=$NAMES -out=$OUT -rename="Person=person Date=date Location=location Organization=org @orgType=type @locType=type @gender=sex" -exf="rule rule1 rule2" -id=ne -accept="person date location org" -saveAs=ne



