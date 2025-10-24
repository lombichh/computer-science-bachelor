#!/bin/bash
# esercitazione6.1.sh 

if test $# -ne 2
then 
  echo Errore nel numero di parametri
  exit 1
fi


F="$1"
case "$F" in    
  */*) echo $F non è un basename ;;    
  *)  if [ ! -f "$HOME/$F" ]; then
        echo $F non è un file
        exit 2
      fi
      if [ ! -r "$HOME/$F" ]; then
        echo $F non è leggibile
        exit 3
      fi
esac


B="$2"
if ! [[ "$B" =~ ^[0-9]+$ ]] ; then
  echo $B non è un intero positivo
  exit 4
fi


D=`ls -l "$HOME/$F" | awk '{print $5}'`
#IN ALTERNATIVA: D=`stat --format="%s" "$HOME/$F" `
resto=`expr $D % $B`

if [ $resto = 0 ]; then
  echo Il file $HOME/$F ha dimensione $D, divisibile per $B 
fi
