#!/bin/bash

source config.sh

#cd ..

# Copy over the text files and headers.
java -jar $COPY -in=$IN/txtfiles -out=$OUT
java -jar $COPY -in=$IN/new-headers -out=$OUT

# Convert XCES files.
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=s -in=$IN/sentence-boundaries -out=$OUT -rename="Sentence=s" -id=s
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=logical -in=$IN/logical -out=$OUT -rename="@speaker=who"
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=hepple -in=$IN/penn-pos -out=$OUT -saveAs=penn -rename="Token=tok @category=msd" -id=penn
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=np -in=$IN/noun-chunks -out=$OUT -saveAs=nc -rename="np=nchunk NounChunk=nchunk" -id=nc -accept=nchunk -exf=graf:set
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=vp -in=$IN/verb-chunks -out=$OUT -saveAs=vc -rename="vp=vchunk VerbChunk=vchunk VG=vchunk" -id=vc -accept=vchunk -exf=graf:set
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=NE -in=$IN/ne-all -out=$OUT -rename="Person=person Date=date Location=location Organization=org @orgType=type @locType=type @gender=sex" -exf="rule rule1 rule2" -id=ne -accept="person date location org" -saveAs=ne

# Convert the Committed Belief data.  One file (in CB-new) also needs to be aligned.
CBWORK=$WORK/committed-belief
if [ -e $CBWORK ] ; then
	rm -f $CBWORK/*.*
else
	mkdir -p $CBWORK
fi
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=CB -in=$IN/committed-belief -out=$OUT -saveAs=cb -id=cb
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=CB -in=$IN/CB-new -out=$CBWORK -saveAs=cb -id=cb
cp $IN/CB-new/*.txt $CBWORK
java $OPTS -jar $ALIGN $LOPTS -src=$CBWORK -target=$OUT -dest=$OUT -type=cb

# Convert and align the event data.
rm -f %IN/event/graf
cp %IN/event/xces/*.txt %IN/event/graf
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=event -in=$IN/event/xces -out=$IN/event/graf -saveAs=event -id=ev
java $OPTS -jar $ALIGN $LOPTS -src=$IN/event/graf -target=$MASC -dest=$OUT -type=event -fix=$FIX/event-fixes.xml

# Align the opinion data
java $OPTS -jar $ALIGN $LOPTS -src=$IN/opinion/graf -target=$OUT -dest=$OUT -type=mpqa -fix=$FIX/opinion-fixes.xml

#####################################################
## THE REMAINDER IS PERFORMED IN SEPARATE SCRIPTS. ##
#####################################################

# Validate headers. The -in=OUT is because we are validating the files in the MASC destination directory.
# ./validate-headers.sh

# Fix logical

# Link vc, nc, and ne to ptb tokens

# Parse everything

# Validate everything.

# Divy up.

echo Done.


