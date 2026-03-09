// Open movie before hitting Run
// clear ROIs in between movies

// when prompted, open "_downstream" file


function CreateDialog() {
	Dialog.createNonBlocking("Daughter Death?");

	items = newArray("TRUE", "FALSE", "Slippage", "Other");
	
	label = "If Death = True; if Leaves = FALSE";
	
	Dialog.addRadioButtonGroup(label, items, 3, 1, "TRUE");
	Dialog.addString("want to leave a comment?", "", 20);  // 20 is the field width
	Dialog.show();
}

// set some params;
setColor("white");
zoom = 2;


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
	name = getResult("ID", i);
	
	id = "tomeasure";

	selectImage(id);
	
	Stack.setFrame(frm + 1); //trackmate starts with frame 0 // TODO VERIFY WITH NOTEBOOK
	fillOval(x, y, 10, 10);
	run("Set... ", "zoom=" + zoom*100 + " x=" + x + " y=" + y);
	
	CreateDialog();	
	fate = Dialog.getRadioButton();
	comment = Dialog.getString();

	Table.set("Death", i, fate);
	Table.set("comment", i, comment);
	Table.update;

  	}

newTable = replace(filename, ".csv", "") + "_Filled.csv";

fileDir = File.getDirectory(Lineages);
newfileDir = fileDir + newTable;
print(newfileDir);
Table.save(newfileDir, filename);
