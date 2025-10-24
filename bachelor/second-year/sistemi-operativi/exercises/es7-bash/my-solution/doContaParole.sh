#!/bin/bash
fout=$1
pid=$3

cd "$2"
for f in *; do
	if test -f $f
	then
		# file
		wcount=`cat $f | wc -w`
		rest=`expr $wcount % 2`
		echo Il file $f contiene $wcount parole
		if [[ $rest = 0 ]]
		then
			# even
			echo Report $pid: Il file `pwd`/$f contiene $wcount parole >> $fout
		fi
	elif test -d $f
	then
		# dir
		$0 $fout $f $pid
	fi
done
