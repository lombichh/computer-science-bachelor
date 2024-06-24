#!/bin/bash

#sintassi di invocazione:
#hit str extension dir1…dirN

#Controllo argomenti
if [[ $# -lt 2 ]]; then
    echo "Errore: numero di argomenti non corretto" 
    echo  "Usage: $0 Fout dir1…dirN" 
    exit 1
fi


Fout="$1"


#faccio scorrere gli argomenti in ingresso per avere solo i direttori (i.e. butto via il primo argomento)
shift

for dir in "$@"; do  #vedi spiegazione sotto per "$@"
    case "$dir" in
        /*) 
        #la directory inizia per /
        #controllo anche che sia davvero una directory esistente  
        if ! [[ -d "$dir" ]]; then
            echo "Errore: $2 non esiste o non è una cartella" 
            exit 5
        fi
        ;;
        *)
        #la directory non inizia per /, quindi non è un path assoluto
        echo "$dir non è una directory assoluta" 
        exit 6
        ;;
    esac
done
# se usassimo la forma <for dir in $*; do> e ci fosse un file/direttorio con spazi "pippo pluto", esso darebbe luogo a due esecuzioni del ciclo: 
# la prima con $dir=pippo e la seconda con $dir=pluto. Questo ovviamente non è corretto.
# la forma <for dir in "$@"; do>  permette di iterare correttamente anche in caso di nomi di  file/direttori con spazi.
# Con $@ se un file/direttorio si chiamasse "pippo pluto", verrebbe fatta una sola esecuzione del ciclo con $dir="pippo pluto"

#definizione della stringa da invocare per l'esecuzione del file comandi ricorsivo:
recfile=recursion.sh

case "$0" in
    # il file comandi è stato invocato con un / Path assoluto.
    /*) 
    dir_name=`dirname $0`
    recursive_command="$dir_name"/$recfile
    ;;
    */*)
    # il file comandi è stato invocato con un path relativo.
    dir_name=`dirname $0`
    recursive_command="`pwd`/$dir_name/$recfile"
    ;;
    *)
    #Path né assoluto né relativo, il comando è nel $PATH
    recursive_command=$recfile
    ;;
esac

#innesco la ricorsione su ogni directory fornita:
for dir in "$@"; do
    echo "Invocazione del file comandi ricorsivo su $dir" 
    "$recursive_command" "$Fout" "$dir" $$
done

#stampa del numero totale dei file contenenti un numero pari di parole:
echo  Sono stati trovati `cat "$HOME/report.log" | grep $$ | wc -l` file con le caratteristiche date.

