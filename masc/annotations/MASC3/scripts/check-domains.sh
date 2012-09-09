#!/bin/bash

source ./config.sh

set -eu

JAR=$APPS/check-domains/target/check-domains.jar

java -jar $JAR $DATA/release