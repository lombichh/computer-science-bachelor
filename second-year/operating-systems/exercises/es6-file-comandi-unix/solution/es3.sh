#!/bin/bash

#esercitazione 6.3

if test $# -ne 3
then echo Errore nel numero di parametri
        exit
fi
M=$1
S=$2
filedir="$3"

if ! test -f "$filedir" -a -r "$filedir"; then
    echo il file $filedir non esiste o non può essere letto
    exit
fi

for d in `cat $filedir`
do
    if ! test -d $d 
    then    echo il nome $d non corrisponde a una directory esistente
    else 
        for f in $d/* ; do
            if [ -f "$f" ]; then
                count=`grep -o $S "$f"|wc -l`
                if [ $count -gt $M ]; then
                    dim=`cat "$f" | wc -c`
                    echo Il file $f contiene $dim caratteri.
                fi
            fi
        done        
    fi
done
