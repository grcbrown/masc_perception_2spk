# Change intensity and duration of sounds according to file names in tab-separated text file
# 
# For each group of sound files, file names must be listed in order
# in 1st 2 columns (minus '.wav'), with 3rd column as output name
# Table must have header row
#
# Author: Grace Brown 9/18/24

form Edit intensity and duration from table
	comment Give the directory of the sound files: 
	sentence soundDir /Users/gracebrown/Desktop/test/
	comment Give the directory where edited files will be saved:
	sentence saveDir /Users/gracebrown/Desktop/out/
	comment Give the name of the tab-separated text file:
	sentence inputTable C:\Users\Example
	comment What's the lowest reasonable pitch (for PSOLA)?
	   		positive crazylowh1 50
	comment What's the highest reasonable pitch?
	   		positive crazyhighh1 600
endform

# remove any objects open in object window
select all
numberOfSelectedObjects = numberOfSelected ()
if numberOfSelectedObjects > 0
     Remove
endif

# read in table; first row will be treated as headers
Read Table from tab-separated file... 'inputTable$'
Rename... table

select Table table

# get number of rows in table
numRows = Get number of rows

for i to numRows
	
	# get names of sound files and name of final concatenated file
	filename1$ = Table_table$ [i, 1]
	filename2$ = Table_table$ [i, 2]
	outname$ = Table_table$ [i, 3]

		# open 1st sound file
		Read from file... 'soundDir$''filename1$'.wav
				
		# open 2nd sound file
		Read from file... 'soundDir$''filename2$'.wav

			selectObject ("Sound 'filename1$'")
			ref_duration = Get total duration

			selectObject ("Sound 'filename2$'")
			old_duration = Get total duration
			durfactor = ref_duration/old_duration

			selectObject ("Sound 'filename2$'")
			Lengthen (overlap-add)... 'crazylowh1' 'crazyhighh1' 'durfactor'
			Rename... 'filename2$'_dur
			

			# adjust Intensity
			selectObject ("Sound 'filename1$'")
			ref_Int = Get intensity (dB)

			selectObject ("Sound 'filename2$'_dur")
			Scale intensity... ref_Int

			# save concatenated sounds to wav file 
			Write to WAV file... 'saveDir$''outname$'.wav

			select all
			minus Table table
			Remove
	
endfor

select all
Remove
writeInfoLine: "Files successfully created!"


