#!/bin/sh

basePath=/home/htran/storage/images_dataset/drug_images
script_dir=/home/htran/storage/python_workspace/stardist/examples/2D/

log_file="${basePath}stardist.log"
exec >> $log_file 2>&1 && tail $log_file


inputDir="${basePath}/SEG/"
image_fn=Ki67_NUC.tif
outputDir="${inputDir}"
echo $inputDir
echo $outputDir
echo "Segment files..."
script_fn="${script_dir}/exe_stardist.py"
/home/htran/anaconda3/envs/mypytorch/bin/python $script_fn --input_dir $inputDir --image_fn $image_fn --output_dir $outputDir



