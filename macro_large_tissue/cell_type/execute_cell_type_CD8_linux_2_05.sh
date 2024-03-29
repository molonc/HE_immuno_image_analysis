#!/bin/sh

## Linux command

imagej_dir="/home/htran/storage/install_software/ImageJ"
macro_dir="/home/htran/Projects/HE_immuno_image_analysis/macro_large_tissue"
macro_fn="$macro_dir/cell_type/cell_type_CD8_linux_v3.txt"
# project_dir="/home/htran/storage/images_dataset/"

# in case of 1_10 serie
# project_dir="/home/htran/storage/images_dataset/large_tissue/"

# in case of 2_05 serie
project_dir="/home/htran/backup/home/htran/storage/images_dataset/large_tissue/"

# series="HE_10_33214"
# series="1_10"
series="2_05"
# series="3_08"
# series="4_S01"
# series="5_06"
# series="6_10AS"
marker1="CD8"
log_dir="$macro_dir/cell_type/log"
# mkdir $log_dir
log_file="$log_dir/ct_${marker1}_${series}.log"
echo $log_file
exec >> $log_file 2>&1 && tail $log_file

input_dir="${project_dir}${series}/${marker1}_tiles/SEG/"
echo $input_dir
echo "Detect cell types"
xvfb-run -a java -Xmx25000m -jar $imagej_dir/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir
echo "Completed"

