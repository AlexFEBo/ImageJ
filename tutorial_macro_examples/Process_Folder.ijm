/*
 * Macro to add scale bar to multiple images in a folder
 */

// Create a dialog box for input
#@ File (label = "Directory 488", style = "directory") input_488
#@ File (label = "Directory 647", style = "directory") input_647
#@ File (label = "Output directory", style = "directory") output
#@ String (label = "File suffix", value = ".tif") suffix 

// Create variables
file_list_488 = getFileList(input_488);
file_list_647 = getFileList(input_647);
file_list_488 = Array.sort(file_list_488);
file_list_647 = Array.sort(file_list_647);

// Verify that folder contains the same number of files and add scale bars to each image

if (file_list_488.length != file_list_647.length){
	print("Error: The number of files in the two folders is not the same");
	exit();
} else {
	for (i = 0; i < file_list_488.length; i++){
		run("Bio-Formats", "open=[" + input_488 + File.separator + file_list_488[i] + "] autoscale color_mode=Default rois_import=[ROI manager] split_channels view=Hyperstack stack_order=XYCZT");
		run("Scale Bar...", "width=5 height=5 horizontal bold overlay");
		saveAs("Tiff", output + File.separator + file_list_488[i]);
		close();
		run("Bio-Formats", "open=[" + input_647 + File.separator + file_list_647[i] + "] autoscale color_mode=Default rois_import=[ROI manager] split_channels view=Hyperstack stack_order=XYCZT");
		run("Scale Bar...", "width=5 height=5 horizontal bold overlay");
		saveAs("Tiff", output + File.separator + file_list_647[i]);
		close();
		}
	}

// Define a function to add scale bar to each image

function addScaleBar(input,output, file){
	// Open images using Bio-Formats
	run("Bio-Formats", "open=[" + input + File.separator + file + "] autoscale color_mode=Default rois_import=[ROI manager] split_channels view=Hyperstack stack_order=XYCZT");
	// Add the scale bar
	run("Scale Bar...", "width=5 height=5 horizontal bold overlay");
	print("Processing: " + input + File.separator + file);
	print("Saving to: " + output);
}