#!/bin/sh

# bfconvert command line tool
# ./showinf -omexml /home/htran/storage/images_dataset/drug_images/metadata/TMA_Ki67.scn
# ./bfconvert -series 3 /home/htran/storage/images_dataset/drug_images/Ki67/Ki67.tif /home/htran/storage/images_dataset/drug_images/Ki67_tiles/Ki67_S3.tiff
#https://docs.openmicroscopy.org/bio-formats/5.7.1/users/comlinetools/display.html
#https://docs.openmicroscopy.org/bio-formats/5.7.1/users/comlinetools/conversion.html
# batch macro input_filename
# Ref: page 20: https://imagej.nih.gov/ij/docs/macro_reference_guide.pdf
# replace input_filename here by an input image path using snakemake rule
imagej_dir="/home/htran/storage/install_software/ImageJ"
script_dir="/home/htran/Projects/HE_immuno_image_analysis/macro_drugHE"
input_dir="/home/htran/storage/images_dataset/drug_images/"

macro_fn="${script_dir}/slidej/run_imagej_slideJ.txt"
#log_dir="/home/htran/storage/images_dataset/large_tissue/macro"
log_file="${input_dir}slidej_Ki67.log"
exec >> $log_file 2>&1 && tail $log_file

xvfb-run -a java -Xmx40000m -jar $imagej_dir/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir 

  