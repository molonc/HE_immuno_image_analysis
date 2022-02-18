#!/bin/sh

# batch macro input_filename
# Ref: page 20: https://imagej.nih.gov/ij/docs/macro_reference_guide.pdf
# replace input_filename here by an input image path using snakemake rule
# imagej_dir="/home/htran/storage/install_software/ImageJ"
# macro_fn="/home/htran/storage/images_dataset/large_tissue/macro/stain_mask/mask_stain_area.txt"
# input_dir="/home/htran/storage/images_dataset/large_tissue/1_10/"
# log_dir="/home/htran/storage/images_dataset/large_tissue/macro"

imagej_dir="/home/htran/storage/install_software/ImageJ"
script_dir="/home/htran/Projects/HE_immuno_image_analysis/macro_drugHE"
macro_fn="${script_dir}/cell_type/cell_type_v2.txt"
input_dir="/home/htran/storage/images_dataset/drug_images/Ki67_tiles/"
log_file="${script_dir}/stain_mask_Ki67.log"
exec >> $log_file 2>&1 && tail $log_file

xvfb-run -a java -Xmx40000m -jar $imagej_dir/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir 


