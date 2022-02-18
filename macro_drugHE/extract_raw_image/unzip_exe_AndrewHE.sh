
#!/bin/sh

# basePath=/home/htran/storage/images_dataset/large_tissue/1_10/
basePath="/home/htran/storage/images_dataset/drug_images/Ki67_tiles/"
script_dir=/home/htran/storage/python_workspace/stardist/examples/2D/

log_file="${basePath}zipfile.log"
exec >> $log_file 2>&1 && tail $log_file

# inputDir="${basePath}Ki67_BIN/"
# outputDir="${inputDir}"
# echo $inputDir
# echo $outputDir
# echo "Zipping files "
# script_fn="${script_dir}/zip_images.py"
# /home/htran/anaconda3/envs/mypytorch/bin/python $script_fn --input_dir $inputDir --output_dir $outputDir


# inputDir="${basePath}SEG/"
# outputDir="${basePath}SEG_compressed/"
# echo $inputDir
# echo $outputDir
# echo "Zipping files "
# script_fn="${script_dir}/zip_images.py"
# /home/htran/anaconda3/envs/mypytorch/bin/python $script_fn --input_dir $inputDir --output_dir $outputDir

inputDir="${basePath}Ki67/"
outputDir="${basePath}Ki67_compressed/"
echo $inputDir
echo $outputDir
echo "Zipping files "
script_fn="${script_dir}/zip_images.py"
/home/htran/anaconda3/envs/mypytorch/bin/python $script_fn --input_dir $inputDir --output_dir $outputDir


# inputDir="${basePath}/CD57_tiles/filtered_NUC/"
# outputDir="${basePath}/CD57_tiles/compressed_filtered_NUC/"
# echo $inputDir
# echo $outputDir
# echo "Zipping files "
# script_fn="${script_dir}/zip_images.py"
# /home/htran/anaconda3/envs/mypytorch/bin/python $script_fn --input_dir $inputDir --output_dir $outputDir
# 
# 
# 
# inputDir="${basePath}/CD8_tiles/filtered_NUC/"
# outputDir="${basePath}/CD8_tiles/compressed_filtered_NUC/"
# echo $inputDir
# echo $outputDir
# 
# echo "Zipping files "
# /home/htran/anaconda3/envs/mypytorch/bin/python $script_fn --input_dir $inputDir --output_dir $outputDir





