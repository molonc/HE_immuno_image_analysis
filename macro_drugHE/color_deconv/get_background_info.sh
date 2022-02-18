imagej_dir="/Applications/ImageJ.app"
macro_dir="/Users/hoatran/Documents/images_HE/HE_immuno_image_analysis/macro_large_tissue"
macro_fn="$macro_dir/color_deconv/get_background_info.txt"

marker1="CD57"
echo "Get background info"
java -Xmx10000m -jar $imagej_dir/Contents/Java/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $marker1 
echo "Completed"

# marker2="CD57"
# echo "Get background info"
# java -Xmx10000m -jar $imagej_dir/Contents/Java/ij.jar -ijpath $imagej_dir/ -batch $macro_fn $marker2 
# echo "Completed"