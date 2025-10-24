#!/bin/bash
# file comandi ricorsivo dell'esercizio 7.1 
# invocato con "$recursive_command" "$dir" "$inStr" "$str" 

cd "$1"
count=0
for file in * ; do    #per ogni elemento contenuto nella directory corrente:
    if test -f "$file" #$file è un file ordinario, non una directory
    then
	#echo file=$file
	if [[ "$file" = *"$2"* ]] #considero solo i file che nel nome contengono la stringa inStr
	then
	    #conto le occorrenze di str nel file
	     X=`grep -o "$3" "$file"| wc -l`
	     echo Il file `pwd`/$file contiene $X occorrenze di $3 >> "$HOME/report.log"
	     count=`expr $count + 1` 
	fi
    elif test -d "$file"  #file è una directory
    then
        echo "Invocazione ricorsiva sulla directory `pwd`/$file"
        "$0" "$file" "$2" "$3" #invocazione ricorsiva
    fi
done

echo Directory `pwd`: ci sono $count file il cui nome contiene $2
