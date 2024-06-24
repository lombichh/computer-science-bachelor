#!/bin/bash
# file comandi ricorsivo dell'esercizio 7.1 
# invocato con "$recursive_command" "$dir" "$Fout" 

cd "$1"
count=0
for file in * ; do    #per ogni elemento contenuto nella directory corrente:
    if test -f "$file" #$file è un file ordinario, non una directory
    then
        #determino il numero di parole nel file:
        N=`cat "$file" | wc -w` #wc legge da stdin. In questo modo evito che l'out di wc includa il nome del file
        #alternativa:
        #nw=`wc -w "$file" | awk '{print $1}'`
        if test `expr $N % 2` = 0 #se il numero di parole è pari
        then
            echo Il file `pwd`/$file contiene $N parole >> "$2"
	    count=`expr $count + 1`
        fi
    elif test -d "$file"  #file è una directory
    then
        echo "Invocazione ricorsiva sulla directory `pwd`/$file"
        "$0" "$file" "$2" #invocazione ricorsiva
    fi
done

echo Directory `pwd`: ci sono $count file contenenti un numero pari di parole
