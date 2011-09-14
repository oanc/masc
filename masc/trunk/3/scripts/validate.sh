#!/bin/bash

source ./config.sh

echo validate.sh

echo 'root is ' $ROOT
echo 'pwd is ' 
pwd

SCHEMA=http://www.xces.org/ns/GrAF/1.0/graf-1.0.xsd
VALIDATOR=$ROOT/apps/validator/target/validator.jar  #original

#VALIDATOR=$ROOT/apps/validator/target/validator-1.0.0-SNAPSHOT.jar  #debug

echo  java $OPTS -jar  $VALIDATOR -in=$MASC -schema=$SCHEMA -suffix=xml $LOPTS
java $OPTS -jar   $VALIDATOR -in=$MASC -schema=$SCHEMA -suffix=xml $LOPTS  #original 

#echo  java $OPTS -jar  `cygpath -m $VALIDATOR` -in=$MASC -schema=$SCHEMA -suffix=xml $LOPTS
#java $OPTS -jar  `cygpath -m $VALIDATOR` -in=$MASC -schema=$SCHEMA -suffix=xml $LOPTS  #original 


#debug
#echo java -Xmx800M -jar /apps/validator/target/validator.jar
#java -Xmx800M -jar `cygpath -m /home/Frank/workspace/pipeline/2/apps/validator/target/validator.jar`

