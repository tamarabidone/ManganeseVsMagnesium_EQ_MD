#!/bin/bash
# Robert Coffman Feb 1,2024
# this runs Tomasz' scripts that uses MDAnalysis and MDTraj to analyze the secondary structure of my trajectory (.xtc) files
# his second script changes the output from the first into numbers instead of Letters. This makes it easier to plot in Matlab.

# allocate some resources and then use:
conda activate mdanalysis
# copy below into terminal
root="/uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest"
folders="state1 state2 state3b state4 state5 state6 state7 state8"
#folders="state7 state8"
#subfolders="1 2 3 4 5 6"
subfolders="6"
for x in $folders
do
for y in $subfolders
do
for z in {1..25}
do
if [ -d "/uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${x}/${y}/replica${z}" ]; then
cd /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${x}/${y}/replica${z}
python ${root}/analysisScripts/Use/secondaryStart.py ioned secondary_structure_start
python ${root}/analysisScripts/Use/digitize.py secondary_structure_start
python ${root}/analysisScripts/Use/secondary.py trajout trajout secondary_structure
python ${root}/analysisScripts/Use/digitize.py secondary_structure
rm -v trajout_only.xtc
rm -v trajout_only.pdb
rm -v secondary_structure.dat
rm -v ioned_only.pdb
rm -v secondary_structure_start.dat
fi
done
done
done

exit
