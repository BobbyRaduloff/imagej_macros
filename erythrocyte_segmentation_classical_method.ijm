//This macro was used to segment the  erythrocytes in the Classical Method, and to later segment the parasites and white blood cells from the Machine learning prediction maps
run("Duplicate...", "use");
run("Median...", "radius=3");
run("32-bit");
setAutoThreshold("Otsu");
run("Convert to Mask");
run("Fill Holes", "");
run("Median...", "radius=3");
run("Watershed");
run("Analyze Particles...");
