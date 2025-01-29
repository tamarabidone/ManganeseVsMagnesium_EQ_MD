import mdtraj
import MDAnalysis as mda
import numpy as np
import sys

xtc = sys.argv[1]
pdb = sys.argv[2]
out = sys.argv[3]

u = mda.Universe(pdb+'.pdb', xtc+'.xtc')
a = u.select_atoms("segid B and resid 127:146")

with mda.Writer(xtc+'_only.xtc', n_atoms=a.n_atoms) as W:
	for ts in u.trajectory:
		W.write(a)

with mda.Writer(pdb+'_only.pdb', n_atoms=a.n_atoms) as W:
		W.write(a)

t = mdtraj.load(xtc+'_only.xtc', top=pdb+'_only.pdb')

t_dssp = mdtraj.compute_dssp(t)

np.savetxt(out+'.dat', t_dssp, fmt='%s')