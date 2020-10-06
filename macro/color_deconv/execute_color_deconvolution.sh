#!/bin/sh

# batch macro input_filename
# Ref: page 20: https://imagej.nih.gov/ij/docs/macro_reference_guide.pdf
# replace input_filename here by an input image path using snakemake rule
imagej_dir="/home/htran/storage/install_software/ImageJ"
macro_fn="/home/htran/storage/images_dataset/HE_10_33214/macro/run_imagej_color_deconv.txt"
input_dir="/home/htran/storage/images_dataset/HE_10_33214/"

xvfb-run -a java -Xmx10240m -jar $imagej_dir/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir 
