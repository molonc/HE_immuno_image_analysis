#!/bin/sh

# batch macro input_filename
# Ref: page 20: https://imagej.nih.gov/ij/docs/macro_reference_guide.pdf
# replace input_filename here by an input image path using snakemake rule
# project_dir="/home/htran/storage/images_dataset/large_tissue/macro"
# imagej_dir="/home/htran/storage/install_software/ImageJ"
# macro_fn="$project_dir/color_deconv/run_imagej_color_deconv.txt"
# input_dir="/home/htran/backup/home/htran/storage/images_dataset/large_tissue/2_05/"
# Linux version
# xvfb-run -a java -Xmx25000m -jar $imagej_dir/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir 



imagej_dir="/Applications/ImageJ.app"
macro_dir="/Users/hoatran/Documents/images_HE/HE_immuno_image_analysis/macro_large_tissue"
macro_fn="$macro_dir/color_deconv/run_imagej_color_deconv2.txt"
project_dir="/Users/hoatran/Documents/images_HE/images/"

# series="3_08"
# series="4_S01"
# series="5_06"
series="6_10AS"
marker1="CD8"
marker2="CD57"

## Attention: need contain raw folder inside NUC/ BK_NUC folder
# log_file="$macro_dir/color_deconv/color_deconv_${marker1}_${series}.log"
log_file="$macro_dir/color_deconv/color_deconv_${marker2}_${series}.log"
echo $log_file
exec >> $log_file 2>&1 && tail $log_file

input_dir1="${project_dir}${series}/${marker1}_tiles/"
input_dir2="${project_dir}${series}/${marker2}_tiles/"

# echo "Deconv images"
# java -Xmx30000m -jar $imagej_dir/Contents/Java/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir1 
# echo "Completed"

echo "Deconv images"
java -Xmx20000m -jar $imagej_dir/Contents/Java/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir2
echo "Completed"