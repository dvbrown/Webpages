/*
This macro expects files in a slide specific directory to be labelled 1_OLIG.tif etc
The second field of this slide is to be named 2_OLIG.tif. The macros goes through and does a background correction
binarisation and merging of channels. 
The number of fields is currently HARD CODED. I should change this eventually
It then runs the Squaash algorithm to quantify object based coolocalisation.
*/

// Retrieve the parameters for the current iteration
dir1 = getDirectory("Choose the parental folder containing the images");
list = getFileList(dir1);

// Background correct, threshold and make binary
function binarise(image) 
	{
	open(dir1 + image);
	run("Subtract Background...", "rolling=100");
	setAutoThreshold("Moments");
	setOption("BlackBackground", false);
	run("Make Binary", "thresholded remaining black");
	}

//.................................................................
function merge(image1, image2, mergedFilename) {
	//Merge channels and save a new file
	run("Merge Channels...", "c1=" + image1 + " c2=" + image2 + " create");
	run("Size...", "width=900 height=668 constrain average interpolation=Bilinear");
	saveAs("Tiff", dir1 + mergedFilename);
	}

//.................................................................

// Run the Squash algorithm
function run_squassh(targetDirectory) 
	{
	run("Squassh", "  colored labeled save number=1 threshold_channel_1=0.0015 threshold_channel_2=0.0015 regularization=0.050 regularization=0.050 minimum_object_intensity,_channel_1=0.150 _channel_2=0.150 exclude standard=0.80 standard=0.80 remove=0 local=Automatic noise=Gauss " + "text1="dir1);
	}


//.................................................................
// Loop through the list of file names and get pairs of Olig2 and CD44 together

// Intialise a new array containing the first letter of the filenames
fields = newArray("1","2","3");

for (i=0; i<fields.length; i++){
	sampleStart = fields[i];
	olig = sampleStart + "_" + "OLIG.tif";
	CD44 = sampleStart + "_" + "CD44.tif";

	mergedFilename = sampleStart + "_merged.tif";
	print("The script is running ", olig, " ", CD44, "\n");

	binarise(olig);
	binarise(CD44);
	merge(olig, CD44, mergedFilename);
	close();	
	}