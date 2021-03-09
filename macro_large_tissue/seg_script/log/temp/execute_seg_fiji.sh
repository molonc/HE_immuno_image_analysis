#!/bin/sh

# batch macro input_filename
# Ref: page 20: https://imagej.nih.gov/ij/docs/macro_reference_guide.pdf
# replace input_filename here by an input image path using snakemake rule
imagej_dir="/home/htran/storage/install_software/Fiji.app"
macro_fn="/home/htran/storage/images_dataset/HE_10_33214/macro/filter_seg_v2.txt"
input_dir="/home/htran/storage/images_dataset/HE_10_33214/macro/testing/"

xvfb-run -a java -Xmx60000m -jar $imagej_dir/jars/ij-1.53c.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir 
