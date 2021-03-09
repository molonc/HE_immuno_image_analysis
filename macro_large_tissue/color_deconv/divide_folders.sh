#!/bin/bash


SUFF=".png"
suff="_NUC.tif"

series="6_10AS"
marker1="CD57"
maindir="/Users/hoatran/Documents/images_HE/images/$series"
data_dir="${maindir}/${marker1}_tiles/NUC/NUC/"

target_nuc1="${maindir}/${marker1}_tiles/NUC/NUC1"
mkdir $target_nuc1
input_nuc1="${maindir}/${marker1}_tiles/meta_data/nuc1.txt"

while IFS= read -r line
do
echo "$line"
name=${line%$SUFF}$suff
find $data_dir -name "$name" -exec mv {} $target_nuc1 \;  
done < "$input_nuc1"

target_nuc2="${maindir}/${marker1}_tiles/NUC/NUC2"
mkdir $target_nuc2
input_nuc2="${maindir}/${marker1}_tiles/meta_data/nuc2.txt"

while IFS= read -r line
do
echo "$line"
name=${line%$SUFF}$suff
find $data_dir -name "$name" -exec mv {} $target_nuc2 \;  
done < "$input_nuc2"


target_nuc3="${maindir}/${marker1}_tiles/NUC/NUC3"
mkdir $target_nuc3
input_nuc3="${maindir}/${marker1}_tiles/meta_data/nuc3.txt"

while IFS= read -r line
do
echo "$line"
name=${line%$SUFF}$suff
find $data_dir -name "$name" -exec mv {} $target_nuc3 \;  
done < "$input_nuc3"