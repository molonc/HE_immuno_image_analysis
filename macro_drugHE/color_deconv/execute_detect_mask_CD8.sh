#!/bin/sh

# batch macro input_filename
# Ref: page 20: https://imagej.nih.gov/ij/docs/macro_reference_guide.pdf
# replace input_filename here by an input image path using snakemake rule
# project_dir="/home/htran/storage/images_dataset/large_tissue/macro"
# imagej_dir="/home/htran/storage/install_software/ImageJ"
# macro_fn="$project_dir/color_deconv/detect_mask_CD8.txt"
# input_dir="/home/htran/backup/home/htran/storage/images_dataset/large_tissue/2_05/"
# log_file="$project_dir/color_deconv/detect_mask_CD8_2_05.log"
# exec >> $log_file 2>&1 && tail $log_file
# 
# xvfb-run -a java -Xmx15000m -jar $imagej_dir/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir 

project_dir="/Users/hoatran/Documents/images_HE/images/4_S01/"
imagej_dir="/Applications/ImageJ.app"
macro_dir="/Users/hoatran/Documents/images_HE/HE_immuno_image_analysis/macro_large_tissue"
macro_fn="$macro_dir/color_deconv/detect_mask_mac_version.txt"

log_file="$macro_dir/color_deconv/detect_mask_CD8_4_S01.log"
exec >> $log_file 2>&1 && tail $log_file

echo "Detect mask and cut off green area"
java -Xmx15000m -jar $imagej_dir/Contents/Java/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $project_dir
echo "Completed"
