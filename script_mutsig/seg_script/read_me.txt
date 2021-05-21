
Change parameters in the file filter_seg.txt, depend on image, we need to change this parameters.
// Parameters setting
spot_seeds_threshold=25000; #similar to threshold 120/255 8 bits image, here in 16 images, we can use threshold of [25000, 30000] for low intensity images,  [30000,45000] for high intensity images to get spots - center of objects that above this threshold, if this threshold is low, program run slowly
minSize=4.5;  //minimum diameter of object 
maxSize=9;  //maximum diameter of object 
input_dir = dir+"NUC/";
output_dir = dir+"NUC_SEG/";



Execute file using script execute_color_deconvolution.sh
Change input image folder here
