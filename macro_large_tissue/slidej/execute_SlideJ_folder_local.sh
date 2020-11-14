#!/bin/sh

# batch macro input_filename
# Ref: page 20: https://imagej.nih.gov/ij/docs/macro_reference_guide.pdf
# replace input_filename here by an input image path using snakemake rule
imagej_dir = "/Users/miu/Downloads/ImageJ.app"
macro_fn = "/Users/miu/Downloads/FirstCase/input_10_08_20/testing/macro/run_imagej_slideJ.txt"
input_dir = "/Users/miu/Downloads/FirstCase/input_10_08_20/testing/"

xvfb-run -a java -Xmx63488m -jar $imagej_dir/Contents/Java/ij.jar -ijpath $imagej_dir -batch $macro_fn $input_dir 