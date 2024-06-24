#!/bin/bash

#invocato con "$recursive_command" "$str" "$extension" "$dir" PID

cd "$3" #entra nella directory data
for file in * ; do #per ogni elemento della directory corrente
    if [ -f "$file" ] # $file è un file ordinario:
    then
        if [[ "$file" = *"$2" ]]; then
            n_occ=`grep -o "$1" "$file" | wc -l` 
            echo Report $4: il file `pwd`/$file contiene $n_occ occorrenze di $1 >> "$HOME/report.log"
        fi
    elif test -d "$file"    # $file è una directory
    then
        echo "Invocazione ricorsiva sulla directory `pwd`/$file"
        "$0" "$1" "$2" "$file" $4    #invocazione ricorsiva
    fi
done

