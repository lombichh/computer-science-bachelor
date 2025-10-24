#!/bin/bash
# esercitazione6.1.sh 

if test $# -ne 1
then 
  echo Errore nel numero di parametri
  exit 1
fi

KB="$1"
if ! [[ "$KB" =~ ^[0-9]+$ ]] ; then
  echo $KB non è un intero positivo
  exit 2
fi

echo Immetti il basename del file da analizzare. Il file deve trovarsi nella tua home 
read Fin

case "$Fin" in    
  */*) echo $Fin non è un basename ;;    
  *)  if [ ! -f "$HOME/$Fin" ]; then
        echo $Fin non è un file
        exit 3
      fi
      if [ ! -r "$HOME/$Fin" ]; then
        echo $Fin non è leggibile
        exit 4
      fi
  esac


dim_byte=`ls -l "$HOME/$Fin" | awk '{print $5}'`
#IN ALTERNATIVA: dim_byte=`stat --format="%s" "$HOME/$Fin" `
D=`expr $dim_byte / 1024`

if [ $D -gt $KB ]; then
  echo Il file $HOME/$Fin ha dimensione $D, maggiore di $KB KByte
else
  echo Il file $HOME/$Fin ha dimensione $D, minore di $KB KByte
fi
