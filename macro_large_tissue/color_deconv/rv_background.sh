#!/bin/bash


#target="/directory with images"

while read line
do
    name=$line
    echo "Text read from file - $name"
    rm $name
    #find "${target}" -name "$name" -exec cp {} /found_files \;    

done < $1