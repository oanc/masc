#!/bin/bash

source ./config.sh

echo running link-tokens.sh
echo Linking annotations to tokens.

LINK=./apps/link-tokens/target/LinkTokens.jar
#LOPTS=-level=debug

java $OPTS -jar $LINK $LOPTS -in=$MASC -tok=penn -type=ne
java $OPTS -jar $LINK $LOPTS -in=$MASC -tok=penn -type=nc
java $OPTS -jar $LINK $LOPTS -in=$MASC -tok=penn -type=vc


