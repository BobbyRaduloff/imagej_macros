input_folder = "C:/Users/User/Desktop/DATA/Pre-processed/Smear1/Tiled";
output_folder = "C:/Users/User/Desktop/DATA/Pre-processed/Smear1/corrected";
list = getFileList(input_folder);
for (i = 0; i < list.length; i++) {
    if (endsWith(list[i], ".jpg") || endsWith(list[i], ".jpeg")|| endsWith(list[i], ".JPG")|| endsWith(list[i], ".png")|| endsWith(list[i], ".tiff")|| endsWith(list[i], ".bmp")) {
        open(input_folder + "/" + list[i]);
        
run("Set Measurements...", " mean redirect=None decimal=3");
waitForUser("Draw a region over background"); //wait for user drawing rectangular
if (selectionType==-1) waitForUser("Draw a region over background"); //if notjhing is selected, give an errow message
run("Select None"); //deselect rectangular
ti = getInfo("slice.label");   //use if your want the name of slice shall be your file name //writes name of stack into "ti"
run("Duplicate...", "title=rgbstk-temp"); //creates a dublicate of the current image with the name "rgbstk-temp"

//check if new image "rgbstk-temp" is RGB-Type
origBit = bitDepth; //writes bit-depth (8, 16, 24 or 32 bit depth) into "origBit"  
if (bitDepth() != 24) exit("Active image is not RGB"); //checks, if active image is RGB-type (24-bit depth)
//make an RGB stack of "rgbstk-temp"
run("RGB Stack"); //transfer "rgbstk-temp" into RGB channel
run("Restore Selection"); //Restore the selection of the rectangual from use input

//measure mean grey value of all three RGB slices of stack
val = newArray(3); //define variable for 3 values
for (s=1;s<=3;s++) { //repeat for all three slices of the RGB stack
setSlice(s); //go to the slice with the number x
run("Measure"); //measure the selected area with the predefined settings --> mean grey value
val[s-1] = getResult("Mean"); //safe value of each measurement into "val"
}
run("Select None"); //deselect rectangular area
val1 = Array.copy(val);

//convert images in 32-bit for later calculations
run("16-bit");
run("32-bit"); //converting to 32-bit prevents running out of integers --> transfer to floating point number

//determining minimum, maximum and mean of the val-saved values
Array.getStatistics(val, min, max, mean);

//white balance for first slice
for (s=1; s<=3; s++) {
setSlice(s);
dR = val[s-1] - mean;
if (dR < 0) {
run("Add...", "slice value="+ abs(dR));
} else if (dR > 0) {
run("Subtract...", "slice value="+ abs(dR));
}
}

//convert back to RGB
run("16-bit"); //convert from 32- to 16-bit
run("Convert Stack to RGB"); //combine R,G, and B-slice to corrected RGB-image

close("\\Others");
        saveAs("tiff", output_folder + "/result_" + list[i]);
        run("Close All");
        run("Clear Results");
    }
}
