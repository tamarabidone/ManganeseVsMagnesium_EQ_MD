# ManganeseVsMagnesium_EQ_MD

This repository contains simulation data for 8 activation states of integrin alpha2b beta3 under two different conditions, with 10-24 replicas each.

## Directory Structure

- `States/`: Contains minimized and equilibrated states under different conditions and the last 10ns of the replica production runs.
- `mdp_files/`: Contains the .mdp files used for running simulations.
- `scripts/`: Contains scripts used for processing and simulation.
- `data_analysis/`: Contains files related to data analysis.

## Usage

1. **Navigate** to the desired state and condition folder.
2. **View** the contents to understand the simulation setup.
3. **Use** the provided `.mdp` files and scripts for further processing.

## Contact

For questions or further information, please contact [Your Name] at [your_email@example.com].



The files in this repository are for the paper titled: "Mn2+ accelerates ligand binding-site activation of αIIbβ3 integrin: insight from all-atom simulation" By R.E. Coffman, R. Kolasangiani, and T.C. Bidone

List of File Types:
.xtc: Trajectory files are in .xtc format and have been reduced considerably to fit in this repository.
.pdb:
.gro:
.tpr
.inp
.mdp
.tcl
.py
.matlab

state1 through state8 .pdb files are the hand edited files used for further processing and simulation. They are derived from
3zdy, 3zdz, 3ze0, 3ze1, and 3ze2.

For minimization and equilibration, the .mdp files were used in the following order: ions.mdp, minim.mdp, nvt.mdp, npt.mdp, mdreplica.mdp