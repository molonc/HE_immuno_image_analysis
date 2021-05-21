#!/bin/sh

# batch macro input_filename
# Ref: page 20: https://imagej.nih.gov/ij/docs/macro_reference_guide.pdf


## Linux version
# project_dir="/home/blahblah/macro"
# imagej_dir="/home/blahblah/install_software/ImageJ"

# macro_fn="$project_dir/seg_script/filter_seg.txt"
# input_dir="/home/blahblah/"

# log_file="$project_dir/seg_script/seg_${series}.log"
# exec >> $log_file 2>&1 && tail $log_file
# echo "Segment images"
# xvfb-run -a java -Xmx20000m -jar $imagej_dir/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir 
# echo "Completed"

## Mac version
imagej_dir="/Applications/ImageJ.app"
macro_dir="/Users/blahblah/script_mutsig"
macro_fn="$macro_dir/seg_script/filter_seg.txt"
project_dir="/Users/blahblah/images/"


series="SA1051D"
marker="MYC"  #//marker type can be "MYC"" or "Ki67"

log_file="$macro_dir/seg_script/seg_${marker}_${series}.log"
exec >> $log_file 2>&1 && tail $log_file

## input_dir is folder that contain Nucleus channel
input_dir="${project_dir}${series}/NUC/"
# input_dir="${project_dir}${series}/${marker}_tiles/NUC/"

echo $input_dir
echo "Segment images"
java -Xmx25000m -jar $imagej_dir/Contents/Java/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir 
echo "Completed"

