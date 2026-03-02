// Open movie (single channel)

// Select normal lineages file

// clear ROIs in between movies

function CreateDialog() {
	Dialog.createNonBlocking("Mitotic Stopwatch");

	items = newArray("normal", "Laggings", "Massive Missegregation", 
		"DNA bridge", "Misaligned", "MN", "Multipolar Division", 
		"Cytokinesis Failure", "Slippage", "Mitotic Death", "Other");
	items_2 = newArray("blank", "Laggings", "Massive Missegregation", 
		"DNA bridge", "Misaligned", "MN", "Multipolar Division", 
		"Cytokinesis Failure", "Slippage", "Mitotic Death", "Other");
	
	label = "error analysis";
	label_2 = "error analysis 2";
	
	Dialog.addRadioButtonGroup(label, items, 4, 3, "normal");
	Dialog.addString("If other, please specify:", "", 20);  // 20 is the field width
	Dialog.addRadioButtonGroup(label_2, items_2, 4, 3, "blank");
	Dialog.addString("If other, please specify:", "", 20);  // 20 is the field width
	Dialog.show();
}

// set some params;
setColor("white");
//setLineWidth(2);
zoom = 2;


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
	fillOval(x - 15, y - 60, 30, 30);
	zoom = 2;
	run("Set... ", "zoom=" + zoom*100 + " x=" + x + " y=" + y);
	
	CreateDialog();	
	errorType = Dialog.getRadioButton();
	otherText = Dialog.getString();
	errorType_2 = Dialog.getRadioButton();
	otherText_2 = Dialog.getString();
	
	// Add this row to the table immediately
	Table.set("1st Error Type", i, errorType);
	Table.set("comment", i, otherText);
	Table.set("2nd Error Type", i, errorType_2);
	Table.set("comment 2", i, otherText_2);
	Table.update;

  	}

//saveDir = "Z:/_Elias/microscopy/modified/"
//Table.save(saveDir + "AO_results.csv", "AO_Results");

newTable = replace(filename, ".csv", "") + "_ErrorAnalysis.csv";

fileDir = File.getDirectory(Lineages);
newfileDir = fileDir + newTable;
print(newfileDir);
Table.save(newfileDir, filename);