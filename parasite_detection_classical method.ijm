run("Duplicate...", "use");
run("Median...", "radius=3");
run("Color Threshold...");
//set colour space to Lab
//set thresholding to Yen
waitForUser("adjust parameters");
run("Convert to Mask");
run("Median...", "radius=3");
run("Analyze Particles...");
