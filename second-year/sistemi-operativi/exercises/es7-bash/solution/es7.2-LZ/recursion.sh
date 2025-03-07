#!/bin/bash

#invocato con "$recursive_command" "$Fout" "$dir" PID

cd "$3" #entra nella directory data
for file in * ; do #per ogni elemento della directory corrente
    if [ -f "$file" ] # $file è un file ordinario:
    then
        #determino il numero di parole nel file:
        N=`cat "$file" | wc -w` #wc legge da stdin. In questo modo evito che l'out di wc includa il nome del file
        #alternativa:
        #nw=`wc -w "$file" | awk '{print $1}'`
        if test `expr $N % 2` = 0 #se il numero di parole è pari
        then
            echo Report $3: Il file `pwd`/$file contiene $N parole >> "$1"
	    count=`expr $count + 1`
        fi
    elif test -d "$file"    # $file è una directory
    then
        echo "Invocazione ricorsiva sulla directory `pwd`/$file"
        "$0" "$1" "$2" "$file" $4    #invocazione ricorsiva
    fi
done

