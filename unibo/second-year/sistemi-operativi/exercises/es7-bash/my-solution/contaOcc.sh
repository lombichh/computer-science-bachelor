#!/bin/bash
recursive_cmd=""
if [[ "$0" = /* ]]
then
	# se $0 è un path assoluto
	dir_name=`dirname "$0"`
	recursive_cmd="$dir_name/doContaOcc.sh"
elif [[ "$0" = */* ]]
then
	# se c'è uno slash, ma non inizia con /
	# $0 è un path relativo
	dir_name=`dirname "$0"`
	recursive_cmd="`pwd`/$dir_name/doContaOcc.sh"
else
	# Non si tratta nè di un path relativo, nè di uno
	# assoluto, il comando $0 sarà cercato in $PATH.
	recursive_cmd=doContaOcc.sh
fi
#Invoco il comando ricorsivo
echo "" > $HOME/report.log
"$recursive_cmd" "$1" "$2" "$3"
