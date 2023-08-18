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
		Addscalebar(input,output,file_list[i]);
	}
}

// Define the function Addscalebar

function Addscalebar(input,output, file){
	// Open images using Bio-Formats
    run("Bio-Formats", "open=[" + input + File.separator + file + "] autoscale color_mode=Default rois_import=[ROI manager] split_channels view=Hyperstack stack_order=XYCZT");
	// Add the scale bar
    run("Scale Bar...", "width=5 height=5 thickness=10 font=24 horizontal bold overlay");
	print("Processing: " + input + File.separator + file);
	print("Saving to: " + output);
}

// -------------------------------- //


// Test for creating a new function to create an multicolor image panel

// Get dimensions of the first image
firstImagePath = input + File.separator + file_list[0];
print(firstImagePath);
run("Bio-Formats", "open=[" + firstImagePath + "] autoscale color_mode=Default rois_import=[ROI manager] split_channels view=Hyperstack stack_order=XYCZT");
width = getWidth();
height = getHeight();
print(width);
print(height);
close();

// Loop through the remaining images
for (i = 1; i < file_list.length; i++) {
    imagePath = input + File.separator + file_list[i];
    run("Bio-Formats", "open=[" + ImagePath + "] autoscale color_mode=Default rois_import=[ROI manager] split_channels view=Hyperstack stack_order=XYCZT");

    // Compare dimensions with the first image
    if (getWidth() != width || getHeight() != height) {
        // Close the image if dimensions don't match
        close(); 




    // First we want to process images 2by2
    // This new function get the Title of each open image
function processFile(input,output, file){
	// Open images using Bio-Formats
    run("Bio-Formats", "open=[" + input + File.separator + file + "] autoscale color_mode=Default rois_import=[ROI manager] split_channels view=Hyperstack stack_order=XYCZT");
	title = getTitle();
	print(title);
}