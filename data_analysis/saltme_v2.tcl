puts [pwd]
mol new trajout.pdb
mol addfile trajout.xtc waitfor all
set sel1 [atomselect top "chain A"]
set sel2 [atomselect top "chain B"]
set sel3 [atomselect top "chain C"]
$sel1 set segname A
$sel2 set segname B
$sel3 set segname C
set sel4 [atomselect top "protein or resname MG or resname Cal or resname MN2P"]
animate write dcd trajout2.dcd beg 1 end -1 waitfor all sel $sel4 top
animate write pdb trajout2.pdb beg 0 end 0 waitfor all sel $sel4 top
#$sel4 writepdb trajout2.pdb
exit

mol delete all
mol new trajout2.pdb
mol addfile trajout2.dcd waitfor all
set keep [atomselect top "(chain B and (resid 122 or resid 123 or resid 215) and (name N or name HN)) or (chain C and resid 495 and (name OD1 or name OD2)) or (chain A and resid 224 and (name OD1 or name OD2)) or (chain C and resid 493 and (name NH1 or name NH2 or name HH12 or name HH11 or name HH21 or name HH22))"]
animate write dcd specific.dcd beg 1 end -1 waitfor all sel $keep top
animate write pdb specific.pdb beg 0 end 0 waitfor all sel $keep top 
package require hbonds
file mkdir HbondsOriginalTraj
hbonds -sel1 [atomselect top "(segname A and resid 224) or (segname B and (resid 122 or resid 123 or resid 215))"] -sel2 [atomselect top "segname C and (resid 493 or resid 495)"] -frames 1160:1200 -ang 90 -dist 3.475 -type pair -writefile yes -upsel no -plot no -log hbondpair.log -writefile yes -outfile hbondpair.dat -detailout detailspair.dat -outdir ./HbondsOriginalTraj 
mol delete all
mol new specific.pdb
mol addfile specific.dcd waitfor all
file delete -force Hbonds
file delete -force HbondsPair
file mkdir HbondsPair
file mkdir Hbonds
hbonds -sel1 [atomselect top "segname A or segname B or resname MG or (resname Cal and (resid 2002 to 2003))"] -sel2 [atomselect top "segname C"] -frames 1160:1200 -ang 90 -dist 3.475 -type unique -writefile yes -outfile hbondsUnique.dat -upsel no -plot no -log hbondUnique.log -writefile yes -detailout detailsUnique.dat -outdir ./Hbonds 
hbonds -sel1 [atomselect top "segname A or segname B"] -sel2 [atomselect top "segname C"] -frames 1160:1200 -ang 90 -dist 3.475 -type pair -writefile yes -upsel no -plot no -log hbondpair.log -writefile yes -outfile hbondpair.dat -detailout detailspair.dat -outdir ./HbondsPair 

hbonds -sel1 [atomselect top "segname A or segname B or resname MG or (resname Cal and (resid 2002 to 2003))"] -sel2 [atomselect top "segname C"] -frames all -ang 90 -dist 3.475 -type unique -writefile yes -outfile hbondsUniqueAll.dat -upsel no -plot no -log hbondsUniqueAll.log -writefile yes -detailout detailsUniqueAll.dat -outdir ./Hbonds 
hbonds -sel1 [atomselect top "segname A or segname B"] -sel2 [atomselect top "segname C"] -frames all -ang 90 -dist 3.475 -type pair -writefile yes -outfile hbondspairAll.dat -upsel no -plot no -log hbondspairAll.log -writefile yes -detailout detailspairAll.dat -outdir ./HbondsPair 
puts "finished hbonds"
#package require saltbr
#saltbr -sel [atomselect top "protein or resname MG or resname Cal or resname MN2P"] -outdir ./salt -frames 1160:1200
exit