#!/bin/sh

# batch macro input_filename
# Ref: page 20: https://imagej.nih.gov/ij/docs/macro_reference_guide.pdf
# replace input_filename here by an input image path using snakemake rule
imagej_dir="/home/htran/storage/install_software/ImageJ"
macro_fn="/home/htran/storage/images_dataset/HE_10_33214/macro/filter_seg.txt"
input_dir="/home/htran/storage/images_dataset/HE_10_33214/CD8_tiles/NUC/"
#input_dir="/home/htran/storage/images_dataset/HE_10_33214/macro/testing/"

xvfb-run -a java -Xmx12000m -jar $imagej_dir/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir 