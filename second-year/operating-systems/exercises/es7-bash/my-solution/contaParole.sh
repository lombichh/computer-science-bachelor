#!/bin/bash

# check arguments
fout=$1
if [[ ! $fout = /* ]] # check absolute name
then
	echo $fout non è un nome assoluto
	exit 1
fi
echo "" > $fout

shift
for d in $*; do
	if ! test -d $d # check dir existance
	then
		echo $d non è il nome assoluto di un direttorio esistente
	fi
done

# start recursion

recursive_cmd=""
if [[ $0 = /* ]]
then
	# $0 absolute path
	dir_name=`dirname $0`
	recursive_cmd=$dir_name/doContaParole.sh
elif [[ $0 = */* ]]
then
	# $0 relative path
	dir_name=`dirname $0`
	recursive_cmd=`pwd`/$dir_name/doContaParole.sh
else
	# $0 no relative and no absolute -> search in $PATH.
	recursive_cmd=doContaParole.sh
fi

for d in $*; do
	$recursive_cmd $fout $d $$
done

echo Il numero totale di file che contengono un numero pari di parole equivale a `wc -l $fout`
