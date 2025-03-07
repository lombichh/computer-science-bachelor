#!/bin/bash
#$recursive_command $dir $n $suffix $outfile

cd $1

x=0
y=0


for file in *; do
   #echo executing on file=$file
   if [[ -f "$file" ]]; then
      proprietario=`stat -c %U "$file"`
      # echo prop: $proprietario user: $USER
      if [[ "$proprietario" = "$USER" ]]; then
         x=`expr $x + 1`
      fi
      if [[ "$file" = *"$suffix" ]]; then
         y=`expr $y + 1`
      fi
  elif [[ -d "$file" ]]; then
    #echo "Starting recursion on dir `pwd`/$file"
    "$0" "$file" "$2" "$3" "$4"
  fi
done


#se arrivo qui, vuol dire che ho scorso tutto il contenuto di $1. Ora posso effettuare il controllo x+y>n
tot=`expr $x + $y`
echo $x $y $tot
if [[ $tot -gt $2 ]] ;then
  echo `pwd` $x $y >> "$4"
fi