#!/bin/bash

# esercitazione6.2.sh 

if test $# -lt 3
then echo Errore nel numero di parametri
        exit
fi

Fout="$1"
case "$Fout" in    #verifico che sia un nome assoluto
    /*) ;;    
    *)  echo  $Fout non è un nome assoluto
        exit 1;;
esac

#se Fout esiste già lo rimuovo 
#controllo opzionale: in questo esercizio, scriverò sul file con >. 
#Pertanto, se il file dovesse già esistere, verrà comunque sovrascritto
if [ -f "$Fout" ]; then
    rm $Fout
fi

N="$2"
if ! [[ "$N" =~ ^[0-9]+$ ]] ; then
  echo $N non è un intero positivo
  exit 2
fi
 
shift 2 # faccio scorrere i primi due parametri in ingresso per ciclare solo sui nomi delle directory


for i in "$@" 
## ancora meglio di for i in $* in quanto permette di ciclare su directory con spazi nel nome
do
    case "$i" in    #verifico che sia un nome assoluto
    /*) ;;    
    *)  echo  $i non è un nome assoluto
        exit 1;;
    esac
    if [ ! -d "$i" ]
    then    echo Il  parametro $i deve essere una directory esistente
            exit 2
    fi
done

TOT=0
MAX=0
maxFile=""
for d in "$@" 
do
    for i in "$d"/*  # per ciclare su tutti i file del direttorio d
    do
        if [ -f "$i" ]
        then
            U=`ls -l "$i" | awk '{print $3}'` 
            if [ $U = $USER ]
            then 
                TOT=`expr $TOT + 1 ` 
                ncar=`tail -n $N "$i" | wc -c`
                if [ $ncar -gt $MAX ]; then
                    #ho trovato un file con più caratteri nelle ultime N linee -> aggiorno il massimo corrente
                    MAX=$ncar
                    maxFile="$i" 
                fi
                echo $i è di proprietà dell\'utente $S, ncar=$ncar
            fi
        fi
    done
done

echo "Il file con il maggior numero di caratteri nelle ultime $N linee è $maxFile. (ncar=$MAX)"

echo "Numero totale di file di proprietà dell\'utente $USER: $TOT" > $Fout 

