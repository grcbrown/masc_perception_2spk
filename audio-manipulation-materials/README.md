# Audio Manipulation

The files included here are what I used to do the audio manipulation necessary for stimuli creation. It contains .praat files and their output. 

To perform similar manipulations, follow this workflow: 

## Preparing your files
1. Start with individual clips of all stimulus tokens in a .wav format
2. Use `createTextGrid.praat` to generate textgrids for each .wav file. These will have the same name as whatever your .wav file is called. 
3. Minimally annotate the /s/ segment, the preceding chunk (pt 1) and the following chunk (pt 2) as intervals in Tier 1. Here is an example: B1_SN1_1 | B1_SN1_s | B1_SN1_2. It is also helpful to annotate all consonants and vowels separately (or all phonemes), if you would like to measure phoneme-dependent features within the stimuli. Do this in Tier 2. 
4. Normalize the intensity for all files using `normalize_intensity.praat`. To run this script, make sure all audio files are in a single folder. 

## Splicing 
1. Extract the pt1 chunk, /s/ token, and pt2 chunk from all stimuli. Use the `Extract` command for each Sound + TextGrid pair. This should produce 3 sound objects. Remove all original Sound + TextGrid pairs from your Praat environment. Use `save_audio_list.praat` to mass-save all of these objects. 
2. Copy /s/ chunks to a temporary folder. These are the items that we will be splicing, and we want whatever we splice in to match the original /s/ production in terms of intensity (post-normalization) and duration. 
3. Add the /s/ tokens you want to replace the original /s/ tokens with to the same temporary folder. 
4. Create a .tsv file that has the names of the original /s/ token files in the first column, the name of the replacement tokens in the second column, and the name of the output file in the third column. See `246_splice.txt` for an example. Make sure that each column has a header (e.g., file1, file2, out). 
5. Run `intensity&duration.praat`. This will match the intensity and duration of the new /s/ tokens to the original tokens that they are replacing. 
6. Copy the output files (new /s/ tokens) to a different temporary file. 
7. Add the pt1 chunk and pt2 chunk for all stimuli to the same temporary file. 
8. In a .tsv file, write the names of the pt1 chunks in the first column, the name of the /s/ tokens in the second column, the names of the pt2 chunks in the third column, and the names of the output files in the fourth column. The elements of a single row will correspond to a single concatenated .wav file. Make sure that each column has a header. For an example, see `concatenate.txt`. 
9. Run the `concatenate.praat` script. 




