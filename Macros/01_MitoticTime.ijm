// only on 1-ch images!!!
// clear ROIs in between movies

run("Clear Results");
getPixelSize(unit, pixelWidth, pixelHeight);

rename("tomeasure");
Lineages = File.openDialog("Select a File");
filename = File.getName(Lineages);
open(Lineages);
rowCount = Table.size();

	
for (i = 0; i < rowCount; i++) {
 	//selectWindow("20250627_IM_H2B-GFP_MitoStop_02_lineages.csv");
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
	
	waitForUser("Mark Mitotic Onset");
	roiManager("add");
	roiManager("Select", i);
	roiManager("rename", name);

  	}
run("Set Measurements...", "centroid stack display redirect=None decimal=3");
roiManager("Deselect");
roiManager("Measure");
