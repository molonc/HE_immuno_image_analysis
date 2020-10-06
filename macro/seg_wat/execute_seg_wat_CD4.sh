#!/bin/sh
log_file="/home/htran/storage/images_dataset/HE_10_33214/macro/seg_wat_CD4.log"
exec >> $log_file 2>&1 && tail $log_file
# batch macro input_filename
# Ref: page 20: https://imagej.nih.gov/ij/docs/macro_reference_guide.pdf
# replace input_filename here by an input image path using snakemake rule
imagej_dir="/home/htran/storage/install_software/ImageJ"
macro_fn="/home/htran/storage/images_dataset/HE_10_33214/macro/seg_wat.txt"
input_dir="/home/htran/storage/images_dataset/HE_10_33214/CD4_tiles/NUC/SEG/"
#input_dir="/home/htran/storage/images_dataset/HE_10_33214/macro/testing/"

xvfb-run -a java -Xmx15000m -jar $imagej_dir/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir 


