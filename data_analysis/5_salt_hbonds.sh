#!/bin/bash
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=4G
#SBATCH --job-name=salt
#SBATCH --out=consoleoutput_Salt.out
#SBATCH --error=error_Salt.err
#SBATCH --mail-type=all
#SBATCH --mail-user=robertcoffman12@gmail.com
#SBATCH --account=bidone-gpu-np
#SBATCH --partition=bidone-gpu-np
#SBATCH --array=1-8

shopt -s extglob
folders=("state1" "state2" "state3b" "state4" "state5" "state6" "state7" "state8")
conditions="6"

# state1
if [ $SLURM_ARRAY_TASK_ID -eq 1 ]
then
	for k in $conditions
	do
		for j in {1..25}
		do
			if [ -d "/uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[0]}/${k}/replica${j}" ]; then
			cd /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[0]}/${k}/replica${j}
ml purge
ml vmd/1.9.4a
rm -dr Hbonds
mkdir Hbonds
mkdir HbondsPair
mkdir salt
vmd -dispdev text -e /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/analysisScripts/Use/saltme.tcl
cd ./salt/
echo $(pwd)
rm -v !(*chainC*)
cd ..
mkdir gmxHbond
cd gmxHbond
ml purge
ml use /uufs/chpc.utah.edu/common/home/u6048150/spack/local/modules/linux-rocky8-x86_64/Compiler/linux-rocky8-x86_64/gcc/11.2.0/
ml gcc/11.2.0 gromacs/2024.1-gpu
gmx make_ndx -f ../production.tpr -n ../index2.ndx -o Hbondindex.ndx <<EOL
ri 696-698
name 19 RGD
ri 1-695 | ri 699-705
name 20 Int_Ions
q
EOL
gmx hbond -f ../trajout.xtc -s ../NVTequilibration.tpr -n Hbondindex.ndx -o test.ndx -pf -an -num -dist -dan -m -r 19 -t 20 -b 290000 -e 300000
cat test.ndx | grep -wA 99999999999999 " hbonds_RGDall-Int_frame_0 " > test2.txt
rm -v *#
cd ..
rm -v *#
			else
				echo "couldn't find directory /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[0]}/${k}/replica${j}"
			fi
		done
	done
# state2
elif [ $SLURM_ARRAY_TASK_ID -eq 2 ] 
then
	for k in $conditions
	do
		for j in {1..25}
		do
			if [ -d "/uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[1]}/${k}/replica${j}" ]; then
			cd /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[1]}/${k}/replica${j}
ml purge
ml vmd/1.9.4a
rm -dr Hbonds
mkdir Hbonds
mkdir HbondsPair
mkdir salt
vmd -dispdev text -e /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/analysisScripts/Use/saltme.tcl
cd ./salt/
echo $(pwd)
rm -v !(*chainC*)
cd ..
mkdir gmxHbond
cd gmxHbond
ml purge
ml use /uufs/chpc.utah.edu/common/home/u6048150/spack/local/modules/linux-rocky8-x86_64/Compiler/linux-rocky8-x86_64/gcc/11.2.0/
ml gcc/11.2.0 gromacs/2024.1-gpu
gmx make_ndx -f ../production.tpr -n ../index2.ndx -o Hbondindex.ndx <<EOL
ri 696-698
name 19 RGD
ri 1-695 | ri 699-705
name 20 Int_Ions
q
EOL
gmx hbond -f ../trajout.xtc -s ../NVTequilibration.tpr -n Hbondindex.ndx -o test.ndx -pf -an -num -dist -dan -m -r 19 -t 20 -b 290000 -e 300000
cat test.ndx | grep -wA 99999999999999 " hbonds_RGDall-Int_frame_0 " > test2.txt
rm -v *#
cd ..
rm -v *#
				else
					echo "couldn't find directory /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[1]}/${k}/replica${j}"
				fi
			done
		done

# state 3b
elif [ $SLURM_ARRAY_TASK_ID -eq 3 ] 
then
	for k in $conditions
	do
		for j in {1..25}
		do
			if [ -d "/uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[2]}/${k}/replica${j}" ]; then			
			cd /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[2]}/${k}/replica${j}
ml purge
ml vmd/1.9.4a
rm -dr Hbonds
mkdir Hbonds
mkdir HbondsPair
mkdir salt
vmd -dispdev text -e /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/analysisScripts/Use/saltme.tcl
cd ./salt/
echo $(pwd)
rm -v !(*chainC*)
cd ..
mkdir gmxHbond
cd gmxHbond
ml purge
ml use /uufs/chpc.utah.edu/common/home/u6048150/spack/local/modules/linux-rocky8-x86_64/Compiler/linux-rocky8-x86_64/gcc/11.2.0/
ml gcc/11.2.0 gromacs/2024.1-gpu
gmx make_ndx -f ../production.tpr -n ../index2.ndx -o Hbondindex.ndx <<EOL
ri 696-698
name 19 RGD
ri 1-695 | ri 699-705
name 20 Int_Ions
q
EOL
gmx hbond -f ../trajout.xtc -s ../NVTequilibration.tpr -n Hbondindex.ndx -o test.ndx -pf -an -num -dist -dan -m -r 19 -t 20 -b 290000 -e 300000
cat test.ndx | grep -wA 99999999999999 " hbonds_RGDall-Int_frame_0 " > test2.txt
rm -v *#
cd ..
rm -v *#
				else
					echo "couldn't find directory /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[2]}/${k}/replica${j}"
				fi
			done
		done

# state 4
elif [ $SLURM_ARRAY_TASK_ID -eq 4 ] 
then
	for k in $conditions
	do
		for j in {1..25}
		do
			if [ -d "/uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[3]}/${k}/replica${j}" ]; then			
			cd /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[3]}/${k}/replica${j}
ml purge
ml vmd/1.9.4a
rm -dr Hbonds
mkdir Hbonds
mkdir HbondsPair
mkdir salt
vmd -dispdev text -e /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/analysisScripts/Use/saltme.tcl
cd ./salt/
echo $(pwd)
rm -v !(*chainC*)
cd ..
mkdir gmxHbond
cd gmxHbond
ml purge
ml use /uufs/chpc.utah.edu/common/home/u6048150/spack/local/modules/linux-rocky8-x86_64/Compiler/linux-rocky8-x86_64/gcc/11.2.0/
ml gcc/11.2.0 gromacs/2024.1-gpu
gmx make_ndx -f ../production.tpr -n ../index2.ndx -o Hbondindex.ndx <<EOL
ri 696-698
name 19 RGD
ri 1-695 | ri 699-705
name 20 Int_Ions
q
EOL
gmx hbond -f ../trajout.xtc -s ../NVTequilibration.tpr -n Hbondindex.ndx -o test.ndx -pf -an -num -dist -dan -m -r 19 -t 20 -b 290000 -e 300000
cat test.ndx | grep -wA 99999999999999 " hbonds_RGDall-Int_frame_0 " > test2.txt
rm -v *#
cd ..
rm -v *#
				else
					echo "couldn't find directory /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[3]}/${k}/replica${j}"
				fi
			done
		done

# state 5	
elif [ $SLURM_ARRAY_TASK_ID -eq 5 ] 
then
	for k in $conditions
	do
		for j in {1..25}
		do
			if [ -d "/uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[4]}/${k}/replica${j}" ]; then			
			cd /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[4]}/${k}/replica${j}
ml purge
ml vmd/1.9.4a
rm -dr Hbonds
mkdir Hbonds
mkdir HbondsPair
mkdir salt
vmd -dispdev text -e /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/analysisScripts/Use/saltme.tcl
cd ./salt/
echo $(pwd)
rm -v !(*chainC*)
cd ..
mkdir gmxHbond
cd gmxHbond
ml purge
ml use /uufs/chpc.utah.edu/common/home/u6048150/spack/local/modules/linux-rocky8-x86_64/Compiler/linux-rocky8-x86_64/gcc/11.2.0/
ml gcc/11.2.0 gromacs/2024.1-gpu
gmx make_ndx -f ../production.tpr -n ../index2.ndx -o Hbondindex.ndx <<EOL
ri 696-698
name 19 RGD
ri 1-695 | ri 699-705
name 20 Int_Ions
q
EOL
gmx hbond -f ../trajout.xtc -s ../NVTequilibration.tpr -n Hbondindex.ndx -o test.ndx -pf -an -num -dist -dan -m -r 19 -t 20 -b 290000 -e 300000
cat test.ndx | grep -wA 99999999999999 " hbonds_RGDall-Int_frame_0 " > test2.txt
rm -v *#
cd ..
rm -v *#
				else
					echo "couldn't find directory /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[4]}/${k}/replica${j}"
				fi			
			done
		done

# state 6	
elif [ $SLURM_ARRAY_TASK_ID -eq 6 ] 
then
	for k in $conditions
	do
		for j in {1..25}
		do
			if [ -d "/uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[5]}/${k}/replica${j}" ]; then			
			cd /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[5]}/${k}/replica${j}
ml purge
ml vmd/1.9.4a
rm -dr Hbonds
mkdir Hbonds
mkdir HbondsPair
mkdir salt
vmd -dispdev text -e /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/analysisScripts/Use/saltme.tcl
cd ./salt/
echo $(pwd)
rm -v !(*chainC*)
cd ..
mkdir gmxHbond
cd gmxHbond
ml purge
ml use /uufs/chpc.utah.edu/common/home/u6048150/spack/local/modules/linux-rocky8-x86_64/Compiler/linux-rocky8-x86_64/gcc/11.2.0/
ml gcc/11.2.0 gromacs/2024.1-gpu
gmx make_ndx -f ../production.tpr -n ../index2.ndx -o Hbondindex.ndx <<EOL
ri 696-698
name 19 RGD
ri 1-695 | ri 699-705
name 20 Int_Ions
q
EOL
gmx hbond -f ../trajout.xtc -s ../NVTequilibration.tpr -n Hbondindex.ndx -o test.ndx -pf -an -num -dist -dan -m -r 19 -t 20 -b 290000 -e 300000
cat test.ndx | grep -wA 99999999999999 " hbonds_RGDall-Int_frame_0 " > test2.txt
rm -v *#
cd ..
rm -v *#
				else
					echo "couldn't find directory /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[5]}/${k}/replica${j}"
				fi
			done
		done

# state 7	
elif [ $SLURM_ARRAY_TASK_ID -eq 7 ] 
then
	for k in $conditions
	do
		for j in {1..25}
		do
			if [ -d "/uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[6]}/${k}/replica${j}" ]; then			
			cd /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[6]}/${k}/replica${j}
ml purge
ml vmd/1.9.4a
rm -dr Hbonds
mkdir Hbonds
mkdir HbondsPair
mkdir salt
vmd -dispdev text -e /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/analysisScripts/Use/saltme.tcl
cd ./salt/
echo $(pwd)
rm -v !(*chainC*)
cd ..
mkdir gmxHbond
cd gmxHbond
ml purge
ml use /uufs/chpc.utah.edu/common/home/u6048150/spack/local/modules/linux-rocky8-x86_64/Compiler/linux-rocky8-x86_64/gcc/11.2.0/
ml gcc/11.2.0 gromacs/2024.1-gpu
gmx make_ndx -f ../production.tpr -n ../index2.ndx -o Hbondindex.ndx <<EOL
ri 696-698
name 19 RGD
ri 1-695 | ri 699-705
name 20 Int_Ions
q
EOL
gmx hbond -f ../trajout.xtc -s ../NVTequilibration.tpr -n Hbondindex.ndx -o test.ndx -pf -an -num -dist -dan -m -r 19 -t 20 -b 290000 -e 300000
cat test.ndx | grep -wA 99999999999999 " hbonds_RGDall-Int_frame_0 " > test2.txt
rm -v *#
cd ..
rm -v *#
				else
					echo "couldn't find directory /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[6]}/${k}/replica${j}"
				fi				
			done
		done

# state 8
elif [ $SLURM_ARRAY_TASK_ID -eq 8 ] 
then
	for k in $conditions
	do
		for j in {1..25}
		do
			if [ -d "/uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[7]}/${k}/replica${j}" ]; then			
			cd /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[7]}/${k}/replica${j}
ml purge
ml vmd/1.9.4a
rm -dr Hbonds
mkdir Hbonds
mkdir HbondsPair
mkdir salt
vmd -dispdev text -e /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/analysisScripts/Use/saltme.tcl
cd ./salt/
echo $(pwd)
rm -v !(*chainC*)
cd ..
mkdir gmxHbond
cd gmxHbond
ml purge
ml use /uufs/chpc.utah.edu/common/home/u6048150/spack/local/modules/linux-rocky8-x86_64/Compiler/linux-rocky8-x86_64/gcc/11.2.0/
ml gcc/11.2.0 gromacs/2024.1-gpu
gmx make_ndx -f ../production.tpr -n ../index2.ndx -o Hbondindex.ndx <<EOL
ri 696-698
name 19 RGD
ri 1-695 | ri 699-705
name 20 Int_Ions
q
EOL
gmx hbond -f ../trajout.xtc -s ../NVTequilibration.tpr -n Hbondindex.ndx -o test.ndx -pf -an -num -dist -dan -m -r 19 -t 20 -b 290000 -e 300000
cat test.ndx | grep -wA 99999999999999 " hbonds_RGDall-Int_frame_0 " > test2.txt
rm -v *#
cd ..
rm -v *#
				else
					echo "couldn't find directory /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/${folders[7]}/${k}/replica${j}"
				fi		
			done
		done

fi


