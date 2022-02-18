#!/bin/sh


bfconvert_fn="/home/htran/storage/install_software/bftools/bfconvert"
#bfconvert_fn="${script_dir}/bfconvert"
input_dir="/home/htran/storage/images_dataset/drug_images/"
# input_fn="${input_dir}metadata/TMA_Ki67.scn"
# input_fn="${input_dir}Ki67/SA609_Ki67.tif"

log_file="${input_dir}Ki67/bftools_extract_series.log"
exec >> $log_file 2>&1 && tail $log_file
output_dir="${input_dir}Ki67_tiles/"
input_fn="${output_dir}SA609_Ki67_S0.tif"
mkdir $output_dir
# for series_id in "0" "1" "2" "5" "6" "7" "10" "11" "12" "15" "16"
# for series_id in "2" "3" "4" "5" "6"
for series_id in "0" 
  do
    output_fn="${output_dir}SA609_Ki67_S${series_id}_crop.tif"
    echo "${series_id}"
    echo "${output_fn}"
    $bfconvert_fn -crop 1800,1300,28650,17100 -timepoint 0 $input_fn $output_fn
  done
  
# for series_id in "13" "4" "8" "9" "14" "3"
#   do
#     output_fn="${input_dir}Ki67_tiles/Ki67_S${series_id}.tif"
#     echo "${series_id}"
#     echo "${output_fn}"
#     $bfconvert_fn -series $series_id $input_fn $output_fn
#   done

echo "Completed"
