run("Duplicate...", " ");


run("Median...", "radius=2");
run("Mean...", "radius=2");
setAutoThreshold("Otsu dark");
setOption("BlackBackground", true);    	
setThreshold(120, 255);					
run("Convert to Mask");
run("Fill Holes");
run("Open");    		
    										
