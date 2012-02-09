#!/bin/bash

source ./config.sh

echo running tokenize.sh

#cd ..

#LOPTS=-log=./release.log\ -level=trace\ -append
# Perform quarkification

echo java $OPTS -cp $SPLITTER org.anc.graf.splitter.App -in=$OUT -out=$WORK/tokens/ptb -type=ptb -set=PTB $LOPTS
java $OPTS -cp $SPLITTER org.anc.graf.splitter.App -in=$OUT -out=$WORK/tokens/ptb -type=ptb -set=ptb $LOPTS
#java $OPTS -cp $SPLITTER org.anc.graf.splitter.App -in=$OUT -out=$WORK/tokens/ptb -type=ptb -set=PTB $LOPTS


echo java $OPTS -cp $SPLITTER org.anc.graf.splitter.App -in=$OUT -out=$WORK/tokens/fn -type=fn -set=FrameNet $LOPTS
java $OPTS -cp $SPLITTER org.anc.graf.splitter.App -in=$OUT -out=$WORK/tokens/fn -type=fn -set=fn $LOPTS

echo java $OPTS -cp $SPLITTER org.anc.graf.tokens.MergeTokens -penn=$OUT -ptb=$WORK/tokens/ptb -fn=$WORK/tokens/fn -out=$WORK/tokens/quarks $LOPTS # -source=ptb -target=fn
java $OPTS -cp $SPLITTER org.anc.graf.tokens.MergeTokens -penn=$OUT -ptb=$WORK/tokens/ptb -fn=$WORK/tokens/fn -out=$WORK/tokens/quarks $LOPTS # -source=ptb -target=fn

echo cp $WORK/tokens/fn/*.xml $OUT
cp $WORK/tokens/fn/*.xml $OUT

echo cp $WORK/tokens/ptb/*.xml $OUT
cp $WORK/tokens/ptb/*.xml $OUT

echo cp $WORK/tokens/quarks/*.xml $OUT
cp $WORK/tokens/quarks/*.xml $OUT
