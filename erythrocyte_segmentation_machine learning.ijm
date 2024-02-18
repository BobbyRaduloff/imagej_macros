//This macro was used to manually segment the erythrocytes from the prediction maps in the Machine Learning method. 
run("Duplicate...", "use");
run("Median...", "radius=3");
run("Brightness/Contrast...");
waitForUser("manually adjust the brightness and contrast");
getMinAndMax(min, max);
setMinAndMax(min, max);
run("Duplicate...", " ");
run("Median...", "radius=5");
run("Threshold...");
waitForUser
run("Convert to Mask");
run("Median...", "radius=5");
run("Analyze Particles...", "size=30-Infinity show=[Overlay Masks] display include overlay");
