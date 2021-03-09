#!/bin/sh

# batch macro input_filename
# Ref: page 20: https://imagej.nih.gov/ij/docs/macro_reference_guide.pdf
# replace input_filename here by an input image path using snakemake rule

## Linux version
# project_dir="/home/htran/storage/images_dataset/large_tissue/macro"
# imagej_dir="/home/htran/storage/install_software/ImageJ"
# macro_fn="$project_dir/seg_script/filter_seg.txt"
# input_dir="/home/htran/backup/home/htran/storage/images_dataset/large_tissue/2_05/CD57_tiles/"
# log_file="$project_dir/seg_script/seg_CD57_2_05.log"
# exec >> $log_file 2>&1 && tail $log_file

##Linux version
# xvfb-run -a java -Xmx20000m -jar $imagej_dir/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir 


## Mac version
imagej_dir="/Applications/ImageJ.app"
macro_dir="/Users/hoatran/Documents/images_HE/HE_immuno_image_analysis/macro_large_tissue"
macro_fn="$macro_dir/seg_script/filter_seg_CD57.txt"
project_dir="/Users/hoatran/Documents/images_HE/images/"


# series="3_08"
# series="5_06"
series="6_10AS"
marker1="CD57"

input_dir1="${project_dir}${series}/${marker1}_tiles/NUC/NUC3/"
# input_dir1="${project_dir}${series}/${marker1}_tiles/BK_NUC/"
# log_file="$macro_dir/seg_script/seg_CD57_4_S01.log"
log_file="$macro_dir/seg_script/seg_${marker1}_$series.log"
exec >> $log_file 2>&1 && tail $log_file

echo "Segment images"
java -Xmx25000m -jar $imagej_dir/Contents/Java/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir1 
echo "Completed"