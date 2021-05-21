#!/bin/sh

# batch macro input_filename
# Ref: page 20: https://imagej.nih.gov/ij/docs/macro_reference_guide.pdf

# Linux version
imagej_dir="/home/htran/storage/install_software/ImageJ"


# macro directory
macro_fn="/home/blahblah/slidej/run_imagej_slideJ.txt"

# input image directory  
input_dir="/home/blahblah/large_tissue/"

series="SA1051D"  # series of data use
log_dir="/home/blahblah/large_tissue"
log_file="${log_dir}/slidej__${series}.log"
exec >> $log_file 2>&1 && tail $log_file

echo "Crop big image into many blocks"
# Linux version
xvfb-run -a java -Xmx20000m -jar $imagej_dir/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir 


# Mac version
#java -Xmx20000m -jar $imagej_dir/Contents/Java/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir


# Window version TO DO


