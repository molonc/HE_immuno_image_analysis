#!/bin/bash


SUFF="png"
suff="tif"


# series="3_08"
# marker1="CD57"

# series="6_10AS"
# marker1="CD8"

series="6_10AS"
marker1="CD57"

# maindir="/Users/hoatran/Documents/images_HE/images/4_S01"
maindir="/Users/hoatran/Documents/images_HE/images/$series"
echo $maindir
cd "$maindir/${marker1}_rescaled_raw/background/"
ls  *.png > background.txt
target_nuc="${maindir}/${marker1}_tiles/BACKGROUND/"
data_dir="${maindir}/${marker1}_tiles"
mkdir $target_nuc
input_nuc="${maindir}/${marker1}_rescaled_raw/background/background.txt"

while IFS= read -r line
do
  echo "$line"
  name=${line%.$SUFF}.$suff
  find $data_dir -name "$name" -exec mv {} $target_nuc \;  
done < "$input_nuc"

cd "$maindir/${marker1}_rescaled_raw/bk_nuc/"
ls  *.png > bk_nuc.txt
target_nuc1="${maindir}/${marker1}_tiles/BK_NUC/"
data_dir="${maindir}/${marker1}_tiles"
mkdir $target_nuc1
input_nuc1="${maindir}/${marker1}_rescaled_raw/bk_nuc/bk_nuc.txt"

while IFS= read -r line
do
  echo "$line"
  name=${line%.$SUFF}.$suff
  find $data_dir -name "$name" -exec mv {} $target_nuc1 \;  
done < "$input_nuc1"

cd "$maindir/${marker1}_rescaled_raw/nuc/"
ls  *.png > nuc.txt
target_nuc2="${maindir}/${marker1}_tiles/NUC/"
data_dir="${maindir}/${marker1}_tiles"
mkdir $target_nuc2
input_nuc2="${maindir}/${marker1}_rescaled_raw/nuc/nuc.txt"

while IFS= read -r line
do
  echo "$line"
  name=${line%.$SUFF}.$suff
  find $data_dir -name "$name" -exec mv {} $target_nuc2 \;  
done < "$input_nuc2"



# # cd "$maindir/CD57_rescaled_raw/background/"
# # ls  *.png > background.txt
# target_nuc="$maindir/CD57_tiles/BACKGROUND/"
# data_dir="$maindir/CD57_tiles"
# mkdir $target_nuc
# input_nuc="$maindir/CD57_rescaled_raw/background/background.txt"
# 
# while IFS= read -r line
# do
#   echo "$line"
#   name=${line%.$SUFF}.$suff
#   find $data_dir -name "$name" -exec mv {} $target_nuc \;  
# done < "$input_nuc"
# 
# # cd "$maindir/CD57_rescaled_raw/bk_nuc/"
# # ls  *.png > bk_nuc.txt
# target_nuc1="$maindir/CD57_tiles/BK_NUC/"
# data_dir="$maindir/CD57_tiles"
# mkdir $target_nuc1
# input_nuc1="$maindir/CD57_rescaled_raw/bk_nuc/bk_nuc.txt"
# 
# while IFS= read -r line
# do
#   echo "$line"
#   name=${line%.$SUFF}.$suff
#   find $data_dir -name "$name" -exec mv {} $target_nuc1 \;  
# done < "$input_nuc1"
# 
# # cd "$maindir/CD57_rescaled_raw/nuc/"
# # ls  *.png > nuc.txt
# target_nuc2="$maindir/CD57_tiles/NUC/"
# data_dir="$maindir/CD57_tiles"
# mkdir $target_nuc2
# input_nuc2="$maindir/CD57_rescaled_raw/nuc/nuc.txt"
# 
# while IFS= read -r line
# do
#   echo "$line"
#   name=${line%.$SUFF}.$suff
#   find $data_dir -name "$name" -exec mv {} $target_nuc2 \;  
# done < "$input_nuc2"


#while read line
#do
#    name=$line
    # echo "Text read from file - $name"
    # rm $name
    # wget "$line"
    #find "${target}" -name "$name" -exec cp {} /found_files \;    

# done < $1