This folder contains all the final code that I wrote which was used to generate
	the 3D data set that was displayed with the volume renderer. 
The procedure was as follows:
	1) Call initScript.m to convert the input multi-layer TIFF file into individual images
	2) Call segmentScript.m to run the segmentation on each of the images and get results
	3) Call dataScript.m to generate the 3D data from the result iamges and make it a multi-layer TIFF file

getSegImage.m is a function called by the script in Step 2
getKMeansImage.m is a function called by getSegImage.m