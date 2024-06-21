#!/bin/bash

#usage esame dirin N suffix dirout


if [[ $# -ne 4 ]]; then
    #1>&2 redirige stdout in stderr
    echo "Errore: numero di argomenti non corretto" 1>&2
    exit 1
fi

#controllo che N sia un intero positivo 
if ! [[ "$2" =~ ^[0-9]+$ ]] ; then
  echo $2 non è un intero positivo
  exit 2
fi
n=$2
suffix=$3

if ! [[ -d "$1" ]] ; then
    echo -e "Il file $1 non è una directory" 
    exit 1
fi
dir=$1
if ! [[ "$dir" = /* ]]; then
        echo "Errore: $dir deve essere un path assoluto" 1>&2
        exit 1
fi

dirout=$4
if ! [[ "$dirout" = /* ]]; then
        echo "Errore: $dir deve essere un path assoluto" 1>&2
        exit 1
fi
if [[ -d "$dirout" ]] ; then
   echo ERRORE: dirout esiste già
   exit 1
fi
mkdir $dirout


outfile="$dirout/report.txt"

case "$0" in
    # La directory inizia per / Path assoluto.
    /*) 
    dir_name=`dirname $0`
    recursive_command="$dir_name"/rec_search.sh
    ;;
    */*)
    # La directory non inizia per slash, ma ha uno slash al suo interno.
    # Path relativo.
    dir_name=`dirname $0`
    recursive_command="`pwd`/$dir_name/rec_search.sh"
    ;;
    *)
    # Path né assoluto né relativo, il comando deve essere nel $PATH
    recursive_command=rec_search.sh
    ;;
esac

$recursive_command $dir $n $suffix $outfile

