#!/bin/bash
if [ $# -ne 2 ]
then
	echo You should pass 1 argument
	exit 1
fi

F=$1
N=$2
if [[ !($F = */*) ]]
then
	echo $F è un basename
	if [[ -f $HOME/$F ]]
	then
		echo $F è un file presente nella home
		if [[ -r $HOME/$F ]]
		then
			echo $F è un file leggibile
			if [[ $N = *[0-9]* ]]
			then
				echo $N è un intero
			else
				echo $N non è un intero
				exit 1
			fi
		else
			echo $F non è un file leggibile
			exit 1
		fi
	else
		echo $F non è un file presente nella home
		exit 1
	fi
else
	echo $F non è un basename
	exit 1
fi
