run("Duplicate...", "use");
run("Median...", "radius=3");
run("32-bit");
setAutoThreshold("Otsu");
run("Convert to Mask");
run("Fill Holes", "");
run("Median...", "radius=3");
run("Watershed");
run("Analyze Particles...");
