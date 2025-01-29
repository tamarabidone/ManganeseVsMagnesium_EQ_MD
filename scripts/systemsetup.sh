#!/bin/bash
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --gres=gpu:1
#SBATCH --job-name=Eq_1.5
#SBATCH --out=consoleoutput.out
#SBATCH --error=error.err
#SBATCH --mail-type=all
#SBATCH --mail-user=robertcoffman12@gmail.com
#SBATCH --account=bidone-gpu-np
#SBATCH --partition=bidone-gpu-np
#SBATCH --array=5
#SBATCH --dependency=singleton

folders=("state1" "state2" "state3" "state4" "state5" "state6" "state7" "state8")

if [ $SLURM_ARRAY_TASK_ID -le 6 ]
then
	if [ -d "/uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[0]}" ]
	then
		cd /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[0]}/$SLURM_ARRAY_TASK_ID
		#cp -r /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/state1/1/charmm36-jul2022.ff ./
	else
		echo "couldn't find directory /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[0]}/${SLURM_ARRAY_TASK_ID}"
	fi
elif [ $SLURM_ARRAY_TASK_ID -ge 7 ] && [ $SLURM_ARRAY_TASK_ID -le 12 ]
then
	subfolder="$(($SLURM_ARRAY_TASK_ID - 6))"
	if [ -d "/uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[1]}/${subfolder}" ]
	then 
		cd /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[1]}/${subfolder}
		cp -r /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/state1/1/charmm36-jul2022.ff ./
	else
		echo "couldn't find directory /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[1]}/${subfolder}"
	fi
elif [ $SLURM_ARRAY_TASK_ID -ge 13 ] && [ $SLURM_ARRAY_TASK_ID -le 18 ]
then
	subfolder="$(($SLURM_ARRAY_TASK_ID - 12))"
	if [ -d "/uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[2]}/${subfolder}" ]
	then
		cd /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[2]}/${subfolder}
		cp -r /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/state1/1/charmm36-jul2022.ff ./
	else
		echo "couldn't find directory /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[2]}/${subfolder}"
	fi
elif [ $SLURM_ARRAY_TASK_ID -ge 19 ] && [ $SLURM_ARRAY_TASK_ID -le 24 ]
then
	subfolder="$(($SLURM_ARRAY_TASK_ID - 18))"
	if [ -d "/uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[3]}/${subfolder}" ]
	then
		cd /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[3]}/${subfolder}
		cp -r /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/state1/1/charmm36-jul2022.ff ./
	else
		echo "couldn't find directory /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[3]}/${subfolder}"
	fi
elif [ $SLURM_ARRAY_TASK_ID -ge 25 ] && [ $SLURM_ARRAY_TASK_ID -le 30 ]
then
	subfolder="$(($SLURM_ARRAY_TASK_ID - 24))"
	if [ -d "/uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[4]}/${subfolder}" ]
	then
		cd /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[4]}/${subfolder}
		cp -r /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/state1/1/charmm36-jul2022.ff ./
	else
		echo "couldn't find directory /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[4]}/${subfolder}"
	fi
elif [ $SLURM_ARRAY_TASK_ID -ge 31 ] && [ $SLURM_ARRAY_TASK_ID -le 36 ]
then
	subfolder="$(($SLURM_ARRAY_TASK_ID - 30))"
	if [ -d "/uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[5]}/${subfolder}" ]
	then
		cd /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[5]}/${subfolder}
		cp -r /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/state1/1/charmm36-jul2022.ff ./
	else
		echo "couldn't find directory /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[5]}/${subfolder}"
	fi
elif [ $SLURM_ARRAY_TASK_ID -ge 37 ] && [ $SLURM_ARRAY_TASK_ID -le 42 ]
then
	subfolder="$(($SLURM_ARRAY_TASK_ID - 36))"
	if [ -d "/uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[6]}/${subfolder}" ]
	then
		cd /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[6]}/${subfolder}
		cp -r /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/state1/1/charmm36-jul2022.ff ./
	else
		echo "couldn't find directory /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[6]}/${subfolder}"
	fi
elif [ $SLURM_ARRAY_TASK_ID -ge 43 ] && [ $SLURM_ARRAY_TASK_ID -le 48 ]
then
	subfolder="$(($SLURM_ARRAY_TASK_ID - 42))"
	if [ -d "/uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[7]}/${subfolder}" ]
	then
		cd /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[7]}/${subfolder}
		cp -r /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/state1/1/charmm36-jul2022.ff ./
	else
		echo "couldn't find directory /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[7]}/${subfolder}"
	fi
elif [ $SLURM_ARRAY_TASK_ID -ge 49 ] && [ $SLURM_ARRAY_TASK_ID -le 54 ]
then
	subfolder="$(($SLURM_ARRAY_TASK_ID - 48))"
	if [ -d "/uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[8]}/${subfolder}" ]
	then
		cd /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[8]}/${subfolder}
		cp -r /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/state1/1/charmm36-jul2022.ff ./
	else
		echo "couldn't find directory /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[8]}/${subfolder}"
	fi
fi

# Use gromacs 2022.5 with the current best gpu support 
# avx2_256, CUDA 12.1, openmpi, plumed, and intel-oneapi-mkl/2022.2.1
module purge
#module use /uufs/chpc.utah.edu/common/home/u6048150/spack/local/modules/linux-rocky8-x86_64/MPI/linux-rocky8-skylake/gcc/11.2.0/openmpi/4.1.5
#module use /uufs/chpc.utah.edu/common/home/u6048150/spack/local/modules/linux-rocky8-x86_64/Compiler/linux-rocky8-skylake/gcc/11.2.0
#ml gcc/11.2.0 gromacs/2022.5-gpu
ml gcc/11.2.0
module use /uufs/chpc.utah.edu/common/home/u6048150/spack/local/modules/linux-rocky8-x86_64/Compiler/linux-rocky8-zen2/gcc/11.2.0
ml gromacs/2023.3-gpu

num=$SLURM_JOB_GPUS
n="${num//[^[:digit:]]/}"
o=${#n}
echo " gpus allocated ${#n} "
#x=$((n*2))
if [ $((o%2)) -eq 0 ];
then
	x=8
else
	x=$((o*2))
fi
echo $x

#export GMX_ENABLE_DIRECT_GPU_COMM=1

init=ioned
mini_prefix=minimization
equi_prefix=NVTequilibration
prod_prefix=NPTequilibration
prod_step=production


# Minimization
# In the case that there is a problem during minimization using a single precision of GROMACS, please try to use 
# a double precision of GROMACS only for the minimization step.
gmx pdb2gmx -f state1.pdb -o start.pdb -p topol.top -ignh<<EOF
1
1
EOF
gmx editconf -d 1.5 -f start.pdb -o boxed.pdb
gmx solvate -cp boxed.pdb -cs spc216.gro -o solved.pdb -p topol.top
gmx grompp -f ../../ions.mdp -c solved.pdb -p topol.top -o ioned.tpr
gmx genion -s ioned.tpr -o ioned.pdb -p topol.top -pname NA -nname CL -conc 0.15 -neutral<<EOF
14
EOF
gmx grompp -f ../../minim.mdp -o ${mini_prefix}.tpr -c ${init}.pdb -r ${init}.pdb -p topol.top
gmx mdrun -ntomp 16 -ntmpi 1 -v -deffnm ${mini_prefix} -s ${mini_prefix}.tpr


# Equilibration
wait 15
gmx grompp -f ../../nvt.mdp -o ${equi_prefix}.tpr -c ${mini_prefix}.gro -r ${init}.pdb -p topol.top
gmx mdrun -ntomp 16 -ntmpi 1 -v -deffnm ${equi_prefix} -cpi ${equi_prefix}.cpt -nb gpu -bonded gpu &> equilibration1_${SLURM_JOB_ID}.log

wait 15
gmx grompp -f ../../npt.mdp -o ${prod_prefix}.tpr -c ${equi_prefix}.gro -r ${equi_prefix}.gro -p topol.top
gmx mdrun -ntomp 16 -ntmpi 1 -v -deffnm ${prod_prefix} -cpi ${prod_prefix}.cpt -maxh 72 -nb gpu -bonded gpu &> equilibration2_${SLURM_JOB_ID}.log
#mpirun -np $x gmx_mpi mdrun -ntomp 8 -v -deffnm ${prod_prefix} -cpi ${prod_prefix}.cpt -maxh 72 -pme gpu -npme 1 -ntomp_pme 1 -pmefft gpu -notunepme -nb gpu -bonded gpu -plumed plumed.dat &> production${SLURM_JOB_ID}.log


## production
#gmx grompp -f ../../mdreplica2.mdp -o ${prod_step}.tpr -c ${prod_prefix}.gro -r ${prod_prefix}.gro -p topol.top
#gmx mdrun -ntomp 4 -v -deffnm ${prod_step} -cpi ${prod_step}.cpt -maxh 72 -pme gpu -npme 1 -ntomp_pme 1 -pmefft gpu -notunepme -nb gpu -bonded gpu &> production${SLURM_JOB_ID}.log

echo "... Job Finished at `date`"
