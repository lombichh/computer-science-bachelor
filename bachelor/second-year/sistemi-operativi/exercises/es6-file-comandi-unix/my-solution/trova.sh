#!/bin/bash
if [[ $# < 2 ]]
then
	echo Devi passare almeno 2 argomenti
	exit 1
fi

M=$1
if [[ $M = *[!0-9]* ]]
then
	echo $M non è un intero positivo
	exit 1
fi

shift
for dir in $*; do
	if [[ !(-d $dir) ]]
	then
		echo $dir non è il percorso assoluto di una directory esistente
		exit 1
	fi
done

read fout
if [[ !($fout = /*) ]]
then
	echo $fout non è il nome assoluto di un file
	exit 1
fi

tot=0
maxnword=-1
maxfile=""
for dir in $*; do
	for file in "$dir"/*; do
		if [[ -f $file ]]
		then
			owner=`ls -l $file | awk '{ print $3 }'`
			if [[ $owner=`whoami` ]]
			then
				tot=`expr $tot + 1`
				nword=`head -n $M $file | wc -w`
				if [[ $nword -gt $maxnword ]]
				then
					maxnword=$nword
					maxfile=$file
				fi
			fi
		fi
	done
done

echo $maxfile
echo $tot > $fout
