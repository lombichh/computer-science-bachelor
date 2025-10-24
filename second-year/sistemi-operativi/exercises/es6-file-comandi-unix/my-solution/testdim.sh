#!/bin/bash
if [ $# -ne 2 ]
then
	echo You should pass 2 arguments
	exit 1
fi

F=$1
B=$2
if [[ !($F = */*) ]] # F is basename
then
	echo $F è un basename
	if [[ -f $HOME/$F ]] # F is file
	then
		echo $F è un file presente nella home
		if [[ -r $HOME/$F ]] # F is readable file
		then
			echo $F è un file leggibile
			if [[ $B = *[0-9]* ]] # N is number
			then
				echo $B è un intero
				D=`ls -l $HOME/$F | awk '{ print $5 }'`
				resto=`expr $D % $B`
				if [[ $resto = 0 ]] # F dimension % B == 0
				then
					echo la dimensione di $F è divisibile per $B
				else
					echo la dimensione di $F non è divisibile per $B
				fi
			else
				echo $B non è un intero
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
