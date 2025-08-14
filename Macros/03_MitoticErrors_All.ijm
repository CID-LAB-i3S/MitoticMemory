// Open movie (single channel)

// Select normal lineages file

// clear ROIs in between movies

run("Clear Results");
getPixelSize(unit, pixelWidth, pixelHeight);

rename("tomeasure");
Lineages = File.openDialog("Open SelectedDataframe");
filename = File.getName(Lineages);
open(Lineages);
rowCount = Table.size();

	
for (i = 0; i < rowCount; i++) {

 	selectWindow(filename);
  	frm = getResult("Frame", i);
  	x = getResult("Track_Coordinate_X", i) / pixelWidth;
	y = getResult("Track_Coordinate_Y", i)/ pixelWidth;
	name = getResult("Source_ID", i);
	
	id = "tomeasure";

	selectImage(id);
	
	Stack.setFrame(frm + 1); //trackmate starts with frame 0
	drawOval(x, y, 30, 30);
	setTool("point");
	
	waitForUser("Manually fill Error table and click anywhere to mark your progress");
	roiManager("add");
	roiManager("Select", i);
	roiManager("rename", name);

  	}
//run("Set Measurements...", "centroid stack display redirect=None decimal=3");
roiManager("Deselect");
//roiManager("Measure");
