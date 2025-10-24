#!/bin/bash
# invoker dell'esercizio 7.1 (AK)
#Controllo argomenti
if [[ $# != 2 ]]; then
    echo "Errore: numero di argomenti non corretto" 
    echo  "Usage: $0 dir" 
    exit 1
fi


case "$1" in
/*) 
    #la directory inizia per /
    #controllo anche che sia davvero una directory esistente  
    if ! [[ -d "$1" ]]; then
        echo "Errore: $1 non esiste o non è una directory" 
        exit 3
    fi
    ;;
*)
    #il nome della directory non inizia per /, quindi non è un path assoluto
    echo "$1 non è una directory assoluta" 
    exit 4
    ;;
esac

dir="$1"

case "$2" in
/*) ;;
*)
    #il nome della directory non inizia per /, quindi non è un path assoluto
    echo "$2 non è una directory assoluta" 
    exit 4
    ;;
esac

Fout="$2"

# creo il file di report e ne elimino il contenuto qualora esista già:
> "$Fout"
# Infatti, se il file esiste già è necessario che venga troncato perchè 
# le successive scritture avverranno in append


recfile=recursion.sh
#definizione della stringa da invocare per l'esecuzione del file comandi ricorsivo:
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

#innesco la ricorsione
"$recursive_command" "$dir" "$Fout"
#NB: nontare che ci sono i doppi apici attorno a ogni parametro. 
#Ciò permette di evitare malfunzionamenti in caso essi contengano spazi.

