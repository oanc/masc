#!/bin/bash

source ./config.sh

#cd ..
SCHEMA=http://www.xces.org/ns/GrAF/1.0/graf-1.0.xsd
VALIDATOR=$APPS/validator/target/validator.jar

java $OPTS -jar $VALIDATOR -in=$OUT -schema=$SCHEMA -suffix=xml $LOPTS

