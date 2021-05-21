
Change parameters in the file run_imagej_color_deconv.txt
// Parameters setting
//if max intensity in one image is above this threshold -- given image contains objs, can set based on images
background_threshold=50;	
//marker type can be MYC or Ki67
marker_type="MYC"; 

Execute file using script execute_color_deconvolution.sh
Change input image folder here


Download plugin to ImageJ/plugins/ folder first
https://imagejdocu.tudor.lu/plugin/color/colour_deconvolution/start
https://blog.bham.ac.uk/intellimic/g-landini-software/colour-deconvolution-2/

Or use the plugins from merfish/demo/segmentation_plugins_Hoa/