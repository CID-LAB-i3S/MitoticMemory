// Macro to semi-automatically annotate fates of isolated track endpoints that appear 
// before the movie ends 

// Open 1-Ch movie
// Select appropriate "_downstream.csv" (after trackmate lineage parsing)
// Annotated table will be saved automatically in the same folder

// Important: Always close table between movies!


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

 	selectWindow(filename);
  	frm = getResult("Frame", i);
  	x = getResult("Track_Coordinate_X", i) / pixelWidth;
	y = getResult("Track_Coordinate_Y", i)/ pixelWidth;
	name = getResult("ID", i);
	
	id = "tomeasure";

	selectImage(id);
	
	Stack.setFrame(frm + 1); //trackmate starts with frame 0 
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
