#!/bin/bash

source ./config.sh

echo running prep.sh

#cd ..

# Copy over the text files.
java -jar $COPY -in=$IN/txtfiles -out=$OUT

# Convert XCES files.
echo opening $IN/Sentence
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -id=s -ann=s -in=$IN/Sentence -out=$OUT -rename="Sentence=s" 

echo opening $IN/logical
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=logical  -id=logical -in=$IN/logical -out=$OUT -rename="paragraph=p @speaker=who"  

# Updated 9/9/2011 KBS
echo opening $IN/Token
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=penn -id=penn -in=$IN/Token -out=$OUT -saveAs=penn -rename="Token=tok @category=msd @root=base" 

#echo opening $IN/penn-pos
#java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=hepple -in=$IN/penn-pos -out=$OUT -saveAs=penn -rename="Token=tok @category=msd" -id=penn #original line
#java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=hepple -in=./penn-pos -out=$OUT -saveAs=penn -rename="Token=tok @category=msd" -id=penn #updated on 4/26/2011
# End update 9/9/92011 

echo opening $IN/NP
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=np -id=nc -in=$IN/NP -out=$OUT -saveAs=nc -rename="np=nchunk NounChunk=nchunk" -accept=nchunk -exf=graf:set

echo opening $IN/VP
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=vp -id=vc -in=$IN/VP -out=$OUT -saveAs=vc -rename="vp=vchunk VerbChunk=vchunk VG=vchunk" -accept=vchunk -exf=graf:set

echo opening $IN/NE
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=NE -id=ne -in=$IN/NE -out=$OUT -rename="Person=person Date=date Location=location Organization=org @orgType=type @locType=type @gender=sex" -exf="rule rule1 rule2" -id=ne -accept="person date location org" -saveAs=ne



