#!/bin/bash

source ./config.sh

#cd ..

# Copy over the text files and headers.
java -jar $COPY -in=$IN/txtfiles -out=$OUT
java -jar $COPY -in=$IN/new-headers -out=$OUT

# Convert XCES files.
java $OPTS -jar $CONVERT -xces $LOPTS -set=anc -ann=s -in=$IN/sentence-boundaries -out=$OUT -rename="Sentence=s" -id=s
java $OPTS -jar $CONVERT -xces $LOPTS -set=anc -ann=logical -in=$IN/logical -out=$OUT -rename="@speaker=who" -id=logical -exf="graf:set graf:id graf:edge"
java $OPTS -jar $CONVERT -xces $LOPTS -set=anc -ann=hepple -in=$IN/penn-pos -out=$OUT -saveAs=penn -rename="Token=tok @category=msd" -id=penn -exf=string
java $OPTS -jar $CONVERT -xces $LOPTS -set=anc -ann=np -in=$IN/noun-chunks -out=$OUT -saveAs=nc -rename="np=nchunk NounChunk=nchunk" -id=nc -accept=nchunk -exf="graf:set graf:id graf:edge"
java $OPTS -jar $CONVERT -xces $LOPTS -set=anc -ann=vp -in=$IN/verb-chunks -out=$OUT -saveAs=vc -rename="vp=vchunk VerbChunk=vchunk VG=vchunk" -id=vc -accept=vchunk -exf="graf:set graf:id graf:edge"
java $OPTS -jar $CONVERT -xces $LOPTS -set=anc -ann=NE -in=$IN/ne-all -out=$OUT -rename="Person=person Date=date Location=location Organization=org @orgType=type @locType=type @gender=sex" -exf="rule rule1 rule2" -id=ne -accept="person date location org" -saveAs=ne
#java $OPTS -jar $CONVERT -xces $LOPTS -set=anc -ann=coRef -in=$IN/coRef -out=$OUT -id=coref -saveAs=coref

# Align the opinion data
#java $OPTS -jar $ALIGN $LOPTS -src=$IN/opinion/graf -target=$OUT -dest=$OUT -type=mpqa -fix=$FIX/opinion-fixes.xml 

echo Done.


