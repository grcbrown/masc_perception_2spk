clearinfo

form Tier information
	comment Tier names, separated by spaces
	sentence Tier_names
	comment Which of these are point tiers?
	sentence Point_tiers 
endform

# The tier names can't be empty
if tier_names$ == ""
	exitScript: "We need at least one Tier name"
endif

# Just to keep my naming scheme
# consistent and not change my working script,
# I'm going to rename the variables
tierNames$ = tier_names$
pointTiers$ = point_tiers$

inDir$ = chooseDirectory$: "Select folder with your .wav files"

# make sure they made a choice
if inDir$ == ""
	exitScript: "No folder given. Exiting"
endif

inDir$ = inDir$ + "/"
inDirWild$ = inDir$ + "*.wav"

# Get list of files
wavList = Create Strings as file list: "wavList", inDirWild$

# See how many there are for the loop
numFiles = Get number of strings

#if there are no files, we have a problem
if numFiles == 0
	exitScript: "I didn't find any .wav files in that folder. Exiting"
endif
#  Note that the script exits without error
#  if the value is zero
#  If the loop began with:
#		for i from 1 to 0
#  It wouldn't throw an error, it would just 
#  never run

for fileNum from 1 to numFiles

	# I always select objects explicitly
	# at the beginning of a loop, since
	# they may not be selected by the end
	selectObject: wavList
	wavFile$ = Get string: fileNum
	wav = Read from file: inDir$ + wavFile$

	textGrid = To TextGrid: tierNames$, pointTiers$
	
	# Get the name of the object, use it
	# to create a file name for the TextGrid
	objName$ = selected$: "TextGrid"
	outPath$ = inDir$ + objName$ + ".TextGrid"

	# Since this will be for the "public",
	# be strict about overwriting files
	if fileReadable: outPath$
		pauseScript: objName$ + ".TextGrid" + " exists! Overwrite?"
	endif

	Save as text file: outPath$
	
	# Remove newly opened objects for cleanup
	selectObject: wav
	plusObject: textGrid
	Remove
endfor

# Remove the wav list
selectObject: wavList
Remove

# Tell the user the script ended without error
pauseScript: "Done! The script ran with no errors."