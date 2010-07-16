#!/bin/bash

source ./config.sh

echo Linking annotations to tokens.

LINK=$ROOT/apps/link-tokens/target/LinkTokens.jar

java $OPTS -jar $LINK -in=$IN -tok=ptbtok -type=ne
java $OPTS -jar $LINK -in=$IN -tok=ptbtok -type=nc
java $OPTS -jar $LINK -in=$IN -tok=ptbtok -type=vc


