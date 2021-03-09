#!/bin/sh


## Linux command
# log_file="/home/htran/storage/images_dataset/HE_10_33214/macro/cell_type/cell_type_CD8.log"
# exec >> $log_file 2>&1 && tail $log_file
# # batch macro input_filename
# # Ref: page 20: https://imagej.nih.gov/ij/docs/macro_reference_guide.pdf
# # replace input_filename here by an input image path using snakemake rule
# imagej_dir="/home/htran/storage/install_software/ImageJ"
# macro_fn="/home/htran/storage/images_dataset/HE_10_33214/macro/cell_type/cell_type_CD8.txt"
# input_dir="/home/htran/storage/images_dataset/HE_10_33214/CD8_tiles/"
# #input_dir="/home/htran/storage/images_dataset/HE_10_33214/macro/testing/"
# 
# xvfb-run -a java -Xmx15000m -jar $imagej_dir/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir 




imagej_dir="/Applications/ImageJ.app"
macro_dir="/Users/hoatran/Documents/images_HE/HE_immuno_image_analysis/macro_large_tissue"
macro_fn="$macro_dir/cell_type/cell_type_CD8_6_10AS.txt"
project_dir="/Users/hoatran/Documents/images_HE/images/"


# series="4_S01"
# series="5_06"
series="6_10AS"
marker1="CD8"
log_dir="$macro_dir/cell_type/log"
# mkdir $log_dir
log_file="$log_dir/ct_${marker1}_${series}_21.log"
echo $log_file
exec >> $log_file 2>&1 && tail $log_file

input_dir1="${project_dir}${series}/${marker1}_tiles/NUC/NUC_SEG2/"

# Just for testing
#input_dir1="${project_dir}${series}/${marker1}_tiles/testing/"
# /Users/hoatran/Documents/images_HE/images/4_S01/CD8_tiles/testing
# input_dir1="${project_dir}${series}/${marker1}_tiles/BK_NUC/"
echo $input_dir1
echo "Detect cell types"
java -Xmx20000m -jar $imagej_dir/Contents/Java/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir1 
echo "Completed"
