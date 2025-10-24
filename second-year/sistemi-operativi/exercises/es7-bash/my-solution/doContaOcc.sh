#!/bin/bash
cd "$1"
count=0
for f in *; do
	if test -f $f
	then
		# file
		inStr=$2
		str=$3
		
		if [[ $f = *$inStr* ]]
		then
			occ=`cat $f | grep -o $str | wc -w`
			echo Il file `pwd`/$f contiene $occ occorrenze di $str >> $HOME/report.log
			count+=1
		fi
	elif test -d $f
	then
		# dir
		$0 $f $2 $3
	fi
done
echo La directory `pwd` contiene $count file che contengono la stringa $str
