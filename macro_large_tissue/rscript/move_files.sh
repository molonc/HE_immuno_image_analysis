#!/bin/bash
input_dir="/Users/hoatran/Documents/images_HE/images/3_08/CD57_tiles/NUC"
# input_dir="/Users/hoatran/Documents/images_HE/images/4_S01/CD57_tiles/NUC"
# input_dir="/Users/hoatran/Documents/images_HE/images/6_10AS/CD8_tiles/NUC"
# input_dir="/Users/hoatran/Documents/images_HE/images/6_10AS/CD57_tiles/NUC"
new_dir="$input_dir/NUC_SEG2"
mkdir $new_dir

input="$input_dir/NUC_SEG/fn1.txt"
while IFS= read -r line
do
  echo "$line"
  mv "$input_dir/NUC_SEG/$line" "$new_dir/"
done < "$input"