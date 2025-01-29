import numpy as np
import sys

ss = sys.argv[1]

mapping = {'H':1, 'E':0.5, 'C':0.0}

a = np.loadtxt(ss+'.dat', dtype=str)

b= np.vectorize(mapping.get)(a)

np.savetxt(ss+'_digitized.dat', b, fmt = '%.1f')

