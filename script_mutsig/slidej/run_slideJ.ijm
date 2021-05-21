//dir=getDirectory("mouse");
//print(dir)

print("\\Clear");

setBatchMode(true);	


dir = getArgument;
dir = '/Users/hoatran/Documents/images_HE/';
if (dir=="") 
	exit ("No argument!");

//macro_dir = File.getParent(dir);
print(dir);
//macro_dir = "/home/htran/storage/images_dataset/large_tissue";
//macro_fn = macro_dir+"/macro/slidej/SlideJdemo0.ijm";

macro_dir = "/Users/hoatran/Documents/images_HE/HE_immuno_image_analysis/macro_large_tissue";
macro_fn = macro_dir+"/slidej/SlideJdemo0.ijm";


print(macro_fn);
if(!File.exists(macro_fn))
  exit ("Check macro file first!");

v = newArray("CD8");
for (i=0; i<v.length; i++) {
	print(v[i]);
	input_dir = dir + v[i];
	if(File.exists(input_dir)){
		output_dir = input_dir+"_tiles";
		if(!File.exists(output_dir)) 
	      	   File.mkdir(output_dir);
    print(input_dir);
    print(output_dir);
		run("SlideJ ", "input="+input_dir+" output="+output_dir+" macro="+macro_fn+" series=1 tile=300 overlap=10 cancel=No");
	} 
	
}


print("Completed");

//if(!File.exists(dir+"log")) File.mkdir(dir+"log");
//selectWindow("Log");
//saveAs("Text", dir+ "log/segment_process_log.txt");
setBatchMode(false);
