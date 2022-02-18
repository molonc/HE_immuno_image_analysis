#!/bin/sh

#basePath=/home/htran/storage/images_dataset/drug_images
basePath=/home/htran/storage/images_dataset/drug_images/Ki67_tiles
script_dir=/home/htran/Projects/HE_immuno_image_analysis/macro_drugHE/seg_script

# log_file="${basePath}stardist_given_folder.log"
# exec >> $log_file 2>&1 && tail $log_file


inputDir="${basePath}/NUC/"
outputDir="${basePath}/SEG/"
echo $inputDir
echo $outputDir
echo "Segment files..."

script_fn="${script_dir}/exe_stardist_from_folder.py"

/home/htran/anaconda3/envs/mypytorch/bin/python $script_fn --input_dir $inputDir --output_dir $outputDir



