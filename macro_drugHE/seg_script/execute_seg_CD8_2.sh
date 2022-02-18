#!/bin/sh

# batch macro input_filename
# Ref: page 20: https://imagej.nih.gov/ij/docs/macro_reference_guide.pdf
# replace input_filename here by an input image path using snakemake rule
# project_dir="/home/htran/storage/images_dataset/large_tissue/macro"
# imagej_dir="/home/htran/storage/install_software/ImageJ"
# macro_fn="$project_dir/seg_script/filter_seg.txt"
# input_dir="/home/htran/backup/home/htran/storage/images_dataset/large_tissue/2_05/CD8_tiles/"
# log_file="$project_dir/seg_script/seg_CD8_2_05.log"
# exec >> $log_file 2>&1 && tail $log_file
# xvfb-run -a java -Xmx15000m -jar $imagej_dir/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir 


imagej_dir="/Applications/ImageJ.app"
macro_dir="/Users/hoatran/Documents/images_HE/HE_immuno_image_analysis/macro_large_tissue"
macro_fn="$macro_dir/seg_script/filter_seg_CD8_v2.txt"
project_dir="/Users/hoatran/Documents/images_HE/images/"


series="4_S01"
# series="5_06"
# series="6_10AS"
marker1="CD8"
log_file="$macro_dir/seg_script/seg_${marker1}_${series}_2.log"
echo $log_file
exec >> $log_file 2>&1 && tail $log_file

input_dir1="${project_dir}${series}/${marker1}_tiles/NUC/NUC1/"
# input_dir1="${project_dir}${series}/${marker1}_tiles/BK_NUC/"
echo $input_dir1
echo "Segment images"
java -Xmx25000m -jar $imagej_dir/Contents/Java/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir1 
echo "Completed"