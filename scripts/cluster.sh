#!/bin/bash
# Define the clustering script
root="/uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest"
# Define variables
TRAJ="trajout.xtc"
START_TIME=290000  # Start time in ps (290 ns)
END_TIME=300000    # End time in ps (300 ns)

# Loop through all state directories
ml purge
ml gcc/11.2.0
module use /uufs/chpc.utah.edu/common/home/u6048150/spack/local/modules/linux-rocky8-x86_64/Compiler/linux-rocky8-zen2/gcc/11.2.0
ml gromacs/2023.3-gpu
cd $root
for STATE_DIR in state*/; do
(
echo "Processing state directory: $STATE_DIR"
# Loop through subdirectories 1 and 5 within each state directory
for SUB_DIR in 1 5; do
cd "${root}/${STATE_DIR}${SUB_DIR}/replica1"
gmx trjcat -f ../replica*/${TRAJ}.xtc -o ../forClusterCombined2.xtc -cat 
done
) &
done


#!/bin/bash
# Define the directory
root="/uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest"
# Define variables
TRAJ="forClusterCombined2.xtc"
TPR="production.tpr"
OUTPUT_DIR="clustering_output"

# Loop through all state directories
ml purge
ml gcc/11.2.0
module use /uufs/chpc.utah.edu/common/home/u6048150/spack/local/modules/linux-rocky8-x86_64/Compiler/linux-rocky8-zen2/gcc/11.2.0
ml gromacs/2023.3-gpu
cd $root
for STATE_DIR in state*/; do
(
# Loop through subdirectories 1 and 5 within each state directory
for SUB_DIR in 1 5; do
cd "${root}/${STATE_DIR}${SUB_DIR}"
echo "Processing state directory: $STATE_DIR${SUB_DIR}"
rm -vrd $OUTPUT_DIR
echo $(pwd)
mkdir $OUTPUT_DIR
gmx cluster -f ${TRAJ}.xtc -s ./replica1/$TPR -g ${OUTPUT_DIR}/cluster.log -dist ${OUTPUT_DIR}/cluster_dist.xvg -ev ${OUTPUT_DIR}/cluster_ev.xvg -cutoff 1 -cl ${OUTPUT_DIR}/clusterwhole.pdb -n ./replica1/index2.ndx <<EOL
19
0
EOL
gmx cluster -f ${TRAJ}.xtc -s ./replica1/$TPR -g ${OUTPUT_DIR}/cluster.log -cl ${OUTPUT_DIR}/clusterprotein.pdb -cutoff 1 -n ./replica1/index2.ndx <<EOL
19
1
EOL
rm -v *#
cd $root  
done
) &
done
