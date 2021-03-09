#!/bin/sh

# imagej_dir="/home/htran/storage/install_software/ImageJ"
imagej_dir="/Applications/ImageJ.app"
macro_dir="/Users/hoatran/Documents/images_HE/HE_immuno_image_analysis/macro_large_tissue"
macro_fn="$macro_dir/slidej/run_imagej_slideJ_v2.txt"
# input_dir="/home/htran/backup/home/htran/storage/images_dataset/large_tissue/3_08/"
#input_dir="/Users/hoatran/Documents/images_HE/images/4_S01/"
#log_file="$macro_dir/slidej/slidej_4_S01.log"
# exec >> $log_file 2>&1 && tail $log_file

#echo "Crop big image into many blocks"
# xvfb-run -a java -Xmx20000m -jar $imagej_dir/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir 
#java -Xmx20000m -jar $imagej_dir/Contents/Java/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir 
#echo "Completed"


#input_dir5="/Users/hoatran/Documents/images_HE/images/5_06/"
#log_file5="$macro_dir/slidej/slidej_5_06.log"
#exec >> $log_file5 2>&1 && tail $log_file5

#echo "Crop big image into many blocks"
# xvfb-run -a java -Xmx20000m -jar $imagej_dir/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir 
#java -Xmx20000m -jar $imagej_dir/Contents/Java/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir5 

#echo "Completed"


input_dir6="/Users/hoatran/Documents/images_HE/images/6_10AS/"
log_file6="$macro_dir/slidej/slidej_6_10AS.log"
#exec >> $log_file6 2>&1 && tail $log_file6

echo "Crop big image into many blocks"
# xvfb-run -a java -Xmx20000m -jar $imagej_dir/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir 
java -Xmx60000m -jar $imagej_dir/Contents/Java/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $input_dir6

echo "Completed"