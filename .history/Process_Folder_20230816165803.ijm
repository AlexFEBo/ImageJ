/*
 * Macro to add scale bar to multiple images in a folder
 */

// Create a dialog box for input
#@ File (label = "Input directory", style = "directory") input
#@ File (label = "Output directory", style = "directory") output
#@ String (label = "File suffix", value = ".tif") suffix 

// Create variables
file_list = getFileList(input);
file_list = Array.sort(file_list);
file_num = file_list.length

// Loop to access the desired elements and apply a function called processFile 
for (i = 0; i < file_num; i++){
	if (endsWith(file_list[i], suffix)){
		processFile(input,output,file_list[i]);
	}
}

// Define the function processFile

function processFile(input,output, file){
	// Open images using Bio-Formats
    run("Bio-Formats", "open=[" + input + File.separator + file + "] autoscale color_mode=Default rois_import=[ROI manager] split_channels view=Hyperstack stack_order=XYCZT");
	title = getTitle();
	print(title);
// Add the scale bar
    //run("Scale Bar...", "width=5 height=5 thickness=10 font=24 horizontal bold overlay");
	//print("Processing: " + input + File.separator + file);
	//print("Saving to: " + output);
}