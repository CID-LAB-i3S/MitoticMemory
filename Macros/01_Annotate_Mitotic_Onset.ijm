// Macro to semi-automatically annotate NEBD to set mitotic onsets
// Will be integrated with metaphase-anaphase data to calculate mitotic durations 

// Open 1-Ch movie
// Select appropriate "_lineages.csv" (after trackmate lineage parsing)
// clear ROIs in between movies

run("Clear Results");
getPixelSize(unit, pixelWidth, pixelHeight);

rename("tomeasure");
Lineages = File.openDialog("Select a File");
filename = File.getName(Lineages);
open(Lineages);
rowCount = Table.size();

// set some params;
setColor("white");
//setLineWidth(2);
zoom = 2;
	
for (i = 0; i < rowCount; i++) {

 	selectWindow(filename);
  	frm = getResult("Frame", i);
  	x = getResult("Track_Coordinate_X", i) / pixelWidth;
	y = getResult("Track_Coordinate_Y", i)/ pixelWidth;
	name = getResult("Source_ID", i);
	
	id = "tomeasure";

	selectImage(id);
	
	Stack.setFrame(frm + 1); //trackmate starts with frame 0 
	fillOval(x - 15, y - 60, 30, 30);
	zoom = 2;
	run("Set... ", "zoom=" + zoom*100 + " x=" + x + " y=" + y);
	setTool("point");
	
	waitForUser("Mark Mitotic Onset");
	roiManager("add");
	roiManager("Select", i);
	roiManager("rename", name);

  	}
run("Set Measurements...", "centroid stack display redirect=None decimal=3");
roiManager("Deselect");
roiManager("Measure");
