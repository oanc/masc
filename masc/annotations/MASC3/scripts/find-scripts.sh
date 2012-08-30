#!/bin/bash

DATA=/tmp/scripts

for f in `ls *.sh` ; do
	#grep .sh $f > $DATA
	#echo "FILE: $f"
	grep "\.sh$" $f | grep -v echo | grep -v source | grep -v "#" | tr -d '\t'
	grep .groovy $f | cut -d\  -f 2
	grep .gr8 $f | cut -d\  -f 2
	#echo
done

#cat $DATA #| sort -u
