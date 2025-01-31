mol new trajout.pdb
set sel1 [atomselect top "chain A"]
set sel2 [atomselect top "chain B"]
set sel3 [atomselect top "chain C"]
$sel1 set segname A
$sel2 set segname B
$sel3 set segname C
set sel4 [atomselect top all]
$sel4 writepdb trajout2.pdb
mol delete all
mol new trajout2.pdb
mol addfile trajout.xtc waitfor all
set sel1 [atomselect top "chain A"]
set sel2 [atomselect top "chain B"]
set sel3 [atomselect top "chain C"]
$sel1 set segname A
$sel2 set segname B
$sel3 set segname C
package require hbonds
hbonds -sel1 [atomselect top "segname A or segname B or resname MG or (resname Cal and (resid 2002 to 2003))"] -sel2 [atomselect top "segname C"] -frames 1160:1200 -ang 90 -dist 3.475 -type unique -writefile yes -upsel no -plot no -log hbond.log -writefile yes -detailout detailsUnique.dat -outdir ./Hbonds 
hbonds -sel1 [atomselect top "segname A or segname B"] -sel2 [atomselect top "segname C"] -frames 1160:1200 -ang 90 -dist 3.475 -type pair -writefile yes -upsel no -plot no -log hbond.log -writefile yes -detailout detailsUnique.dat -outdir ./HbondsPair 
puts "finished hbonds"
#package require saltbr
#saltbr -sel [atomselect top "protein or resname MG or resname Cal or resname MN2P"] -outdir ./salt -frames 1160:1200
exit