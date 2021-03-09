#!/bin/bash
input="/Users/hoatran/Documents/images_HE/images/download_link.txt"
while IFS= read -r line
do
  echo "$line"
  wget "$line"
done < "$input"



/Users/hoatran/Downloads/input_test/
/Users/hoatran/Downloads/output_test/
/Users/hoatran/Documents/images_HE/HE_immuno_image_analysis/macro_large_tissue/slidej/SlideJdemo0.ijm
run("SlideJ ", "input=/Users/hoatran/Documents/images_HE/input_test/ output=/Users/hoatran/Documents/images_HE/output_test/ macro=/Users/hoatran/Documents/images_HE/HE_immuno_image_analysis/macro_large_tissue/slidej/SlideJdemo0.ijm series=1 tile=40 overlap=0 cancel=Yes");
