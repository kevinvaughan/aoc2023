#!/usr/bin/env sh
if [ -z "$1" ]; then echo "Usage: $0 filename"; exit 1; fi

gawk -f ./rank.gawk "$1" | sort -n | awk '{print NR, $1, $2, $3, NR*$3; sum+=NR*$3} END {print "Total:", sum}'