#!/bin/sh

#./bfconvert -bigtiff /home/htran/storage/images_dataset/drug_images/Ki67/TMA_Ki67.scn /home/htran/storage/images_dataset/drug_images/Ki67_tiles/Ki67_C0.tif
# /home/htran/storage/install_software/bftools/bfconvert -bigtiff /home/htran/storage/images_dataset/drug_images/Ki67_tiles/Ki67_C0.tif  /home/htran/storage/images_dataset/drug_images/Ki67_tiles/Ki67_crop_1000_1000.tif
# /home/htran/storage/install_software/bftools/bfconvert -timepoint 14 /home/htran/storage/images_dataset/drug_images/Ki67_tiles/Ki67_C0.tif /home/htran/storage/images_dataset/drug_images/Ki67_tiles/Ki67_crop_1000_1000.tif

#
# split_channels.txt
# batch macro input_filename
# Ref: page 20: https://imagej.nih.gov/ij/docs/macro_reference_guide.pdf
# replace input_filename here by an input image path using snakemake rule
imagej_dir="/home/htran/storage/install_software/ImageJ"
script_dir="/home/htran/Projects/HE_immuno_image_analysis/macro_drugHE"
# input_dir="/home/htran/storage/images_dataset/drug_images/Ki67/"
input_dir="/home/htran/storage/images_dataset/drug_images/Ki67_C0/"
macro_fn="${script_dir}/color_deconv/split_channels.txt"
#log_dir="/home/htran/storage/images_dataset/large_tissue/macro"
# log_file="${input_dir}log/rescale.log"
# exec >> $log_file 2>&1 && tail $log_file



echo "Rescale images"
xvfb-run -a java -Xmx55000m -jar $imagej_dir/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir
echo "Completed"
