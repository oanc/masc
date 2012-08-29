#!/bin/bash
set -e
source ./config.sh

echo "Running mpqa.sh"

echo "mpqa.gr8"
grate scripts/mpqa.gr8 $IN/opinion $WORK/mpqa
mv -f $WORK/mpqa/mpqa-fixes.xml $FIX
#xoro D:/Corpora/MASC2/ci/scripts/mpqa.xoro D:/Corpora/MASC2/ci/data/originals/opinion D:/Corpora/MASC2/ci/data/working/mpqa

# Convert from XCES to GrAF.
echo "Converting XCES to GrAF"
java $OPTS -jar $CONVERT -xces $LOPTS -set=mpqa -id=mpqa -ann=mpqa -in=$WORK/mpqa -out=$WORK/mpqa  #original line

# Generate the "fix" file 
#echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > $FIX/mpqa-fixes.xml
#groovy D:/Corpora/MASC2/ci/scripts/mpqafixes.groovy >> $FIX/mpqa-fixes.xml

echo "Aligning MPQA files."
java $OPTS -jar $ALIGN -type=mpqa $LOPTS -src=$WORK/mpqa -target=$OUT -dest=$OUT -fix=$FIX/mpqa-fixes.xml

echo "Done."


