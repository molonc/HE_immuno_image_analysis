#!/bin/sh

# batch macro input_filename
# Ref: page 20: https://imagej.nih.gov/ij/docs/macro_reference_guide.pdf


project_dir="/home/blahblah/macro"
imagej_dir="/home/install_software/ImageJ"
macro_fn="$project_dir/color_deconv/run_imagej_color_deconv.txt"

# where you keep images
series="SA1051D" # series or patient id
marker="MYC"  #//marker type can be "MYC"" or "Ki67"
input_dir="/home/large_tissue/${series}/"
log_file="$project_dir/color_deconv/color_deconv_${series}_${marker}.log"
exec >> $log_file 2>&1 && tail $log_file

echo "Deconv images"

## Linux version
xvfb-run -a java -Xmx25000m -jar $imagej_dir/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir 

## Mac version
# java -Xmx20000m -jar $imagej_dir/Contents/Java/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir

# Window version TO DO

echo "Completed"
