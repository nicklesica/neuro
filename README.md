# neuro

This archive contains the Matlab code used for analyzing neural activity from the Lesica lab database as of December 2020.

It relies the neural activity being stored in a specific format. 

The data from a single experiment are stored in a single file. Each R_* variable in each file contains the responses to one sound stored as a binary sparse matrix R_<sound> with size <time_bins> x <cells>.

For each R_* there are matching BLK_* and IX_* variables

BLK_*  is the presentation order within the experiment for the response for each cell in R_* (this can be used e.g. to determine whether two cells were recorded simultaneously or whether two trials were recorded successively or with a long gap between them)

IX_* is the list of cells that actually have responses for a given sound and trial (all R_* matrices contain columns for all cells, but some of those columns may be empty) 

Two example data files are included with the archive, along with an analysis script for decoding the responses to consonant-vowel syllables.
  






