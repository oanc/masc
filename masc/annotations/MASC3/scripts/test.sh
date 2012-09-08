#!/bin/bash

source ./config.sh

case $1 in
	1.*)
		echo "Version 1.x"
		;;
	2|2.*)
		echo "Version 2.x"
		;;
	*)
		echo "Unknown version."
		;;
esac
echo "Done"