#!/bin/sh

# batch macro input_filename
# Ref: page 20: https://imagej.nih.gov/ij/docs/macro_reference_guide.pdf
# replace input_filename here by an input image path using snakemake rule
project_dir="/home/htran/storage/images_dataset/large_tissue/macro"
imagej_dir="/home/htran/storage/install_software/ImageJ"
macro_fn="$project_dir/color_deconv/run_imagej_color_deconv.txt"
input_dir="/home/htran/backup/home/htran/storage/images_dataset/large_tissue/2_05/"
log_file="$project_dir/color_deconv/color_deconv_2_05.log"
exec >> $log_file 2>&1 && tail $log_file

xvfb-run -a java -Xmx25000m -jar $imagej_dir/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir 
