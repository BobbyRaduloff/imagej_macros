//This macro was used to tile the enhanced  original images.
// Define the number of rows and columns in the grid
numRows = 10;
numCols = 10;

// Get the width and height of the original image
imageWidth = getWidth();
imageHeight = getHeight();

// Calculate the width and height of each grid cell
cellWidth = imageWidth / numCols;
cellHeight = imageHeight / numRows;

// Create a folder to save the segments
outputFolder = "/Users/User/Desktop/DATA/Pre-processed/Smear1";
File.makeDirectory(outputFolder);

// Split the image into grid cells and save each cell as a separate image
for (row = 0; row < numRows; row++) {
    for (col = 0; col < numCols; col++) {
        // Calculate coordinates for the current grid cell
        x = col * cellWidth;
        y = row * cellHeight;

        // Define ROI for the current grid cell
        makeRectangle(x, y, cellWidth, cellHeight);

        // Save the current cell to the output folder with two-digit numbering
        run("Duplicate...", " ");
        segmentNumber = row * numCols + col + 1;
        
        // Add leading zero if segmentNumber is less than 10
        segmentName = "Tile_" + segmentNumber + ".tiff";
        saveAs(outputFolder + segmentName);

        // Close the current cell without saving changes
        close();
    }
}
