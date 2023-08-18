/*
 * Macro to add scale bar to multiple images in a folder using defined function
 */

// Create a dialog box for user inputs
#@ File (label = "Directory 488", style = "directory") input_488
#@ File (label = "Directory 647", style = "directory") input_647
#@ File (label = "Output directory", style = "directory") output
#@ String (label = "File suffix", value = ".tif") suffix 
#@ String (label = "Target green", value = "antibody1") target_green
#@ String (label = "Target red", value = "antibody2") target_red

// Create variables
file_list_488 = getFileList(input_488);
file_list_647 = getFileList(input_647);
file_list_488 = Array.sort(file_list_488);
file_list_647 = Array.sort(file_list_647);

// Verify that folder contains the same number of files and make montage on the opened images

if (file_list_488.length != file_list_647.length) {
    print("Error: The number of files in the two folders is not the same");
    exit();
} else {
    for (i = 0; i < file_list_488.length; i++) {
        // open the "488" image
        run("Bio-Formats", "open=[" + input_488 + File.separator + file_list_488[i] + "] autoscale color_mode=Default rois_import=[ROI manager] split_channels view=Hyperstack stack_order=XYCZT");     
        // Transform images to 8-bit
        run("8-bit");       
        // Subtract Backrgound
        run("Subtract Background...");        
        // Add the "Green" LUT color
        run("Green");        
        // Rename the image with the name of the antibody used 
        rename(target_green);
        
        // open the "647" image
        run("Bio-Formats", "open=[" + input_647 + File.separator + file_list_647[i] + "] autoscale color_mode=Default rois_import=[ROI manager] split_channels view=Hyperstack stack_order=XYCZT");
        // Transform images to 8-bit
        run("8-bit");
         // Subtract Backrgound
        run("Subtract Background...");
        // Add the "Magenta" LUT color
        run("Magenta");        
        // Rename the image with the name of the antibody used
        rename(target_red);
        
        // Merge the two images
        run("Merge Channels...", "c2=[" + target_green + "] c6=[" + target_red + "] create keep");
        // Rename the Composite image
        rename("Merged"); 
        // Flatten the image
        run("Flatten");
        // Create a Stack
        run("Images to Stack", "use keep");
        // Make Montage
        run("Make Montage...", "columns=3 rows=1 scale=0.75 title=[" + input_488 + "] font=24 label");

        // Add the scale bar
        run("Scale Bar...", "width=5 height=5 thickness=8 font=24 bold overlay");
        // Save the montage
        saveAs("Tiff", output + File.separator + "Montage_" + file_list_488[i] + ".tif");

        // Close images
        close("*");
    }
}
