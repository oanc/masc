#!/bin/bash

source ./config.sh

echo Linking annotations to tokens.

LINK=./apps/link-tokens/target/LinkTokens.jar
#LOPTS=-level=debug

java $OPTS -jar $LINK $LOPTS -in=$MASC -tok=ptbtok -type=ne
java $OPTS -jar $LINK $LOPTS -in=$MASC -tok=ptbtok -type=nc
java $OPTS -jar $LINK $LOPTS -in=$MASC -tok=ptbtok -type=vc


