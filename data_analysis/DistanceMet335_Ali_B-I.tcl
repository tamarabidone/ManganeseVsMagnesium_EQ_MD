# RC Feb 5, 2024
# used to print the distance of the Met-335 Oxygen from the 2 crystal structure references. (2vdr(open) and 3t3p(closed))

mol new trajout.pdb waitfor all
mol addfile trajout.xtc waitfor all
# this should be the open and closed crystal structure of integrin....
mol new /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/2vdr(open).psf waitfor all
mol addfile /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/2vdr(open).pdb waitfor all
mol new /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/3t3p(closed).psf waitfor all
mol addfile /uufs/chpc.utah.edu/common/home/bidone-group3/robert/1_HeadpieceTest/3t3p(closed).pdb waitfor all
set outfile [open ./DistanceMet335.dat w]
puts $outfile "#! Frame DistOpen DistClosed Met-335_Oxygen"
set frame_num [molinfo 0 get numframes]
set molist [molinfo list]
# prepare atomselections for alignment
set integrin0 [atomselect [lindex $molist 0] "chain A" frame 0]; set integrin0b [atomselect [lindex $molist 0] "chain B" frame 0]
set integrin1 [atomselect [lindex $molist 1] "segname PROA" frame 0]; set integrin1b [atomselect [lindex $molist 1] "segname PROB" frame 0]
set integrin2 [atomselect [lindex $molist 2] "segname PROA" frame 0]; set integrin2b [atomselect [lindex $molist 2] "segname PROB" frame 0]
$integrin0 set segname PROA; $integrin0b set segname PROB
$integrin1 set chain A; $integrin1b set chain B
$integrin2 set chain A; $integrin2b set chain B
set all0 [atomselect [lindex $molist 0] all frame 0]
set all1 [atomselect [lindex $molist 1] all]
set all2 [atomselect [lindex $molist 2] all]
$integrin0 delete; $integrin0b delete;  $integrin1 delete; $integrin1b delete; $integrin2 delete; $integrin2b delete
# prepare atomselections for alignment (these residues are excluded because their motion is what is going to be measured).
set integrin0 [atomselect [lindex $molist 0] "segname PROB and alpha and not (resid 332 to 352 or resid 120 to 148 or resid 109 to 112)" frame 0]
set integrin1 [atomselect [lindex $molist 1] "segname PROB and alpha and not (resid 332 to 352 or resid 120 to 148 or resid 109 to 112)" frame 0]
set integrin2 [atomselect [lindex $molist 2] "segname PROB and alpha and not (resid 332 to 352 or resid 120 to 148 or resid 109 to 112)" frame 0]
#successive frames to align to reference
set integrin0a [atomselect [lindex $molist 0] "segname PROB and alpha and not (resid 332 to 352 or resid 120 to 148 or resid 109 to 112)" frame 0]
# align the trajectory with the 'closed' state
set align1 [measure fit $integrin1 $integrin0]
set align2 [measure fit $integrin2 $integrin0]
$all1 move $align1
$all2 move $align2
for {set h 0} {$h < $frame_num} {incr h} {
	$integrin0a frame $h
	$all0 frame $h
	set M [measure fit $integrin0a $integrin0] 
	$all0 move $M
}
# make selections for position of reference atom and test atom
set a70 [atomselect [lindex $molist 0] "chain B and resid 335 and name O" frame 0]
set a71 [atomselect [lindex $molist 1] "chain B and resid 335 and name O" frame 0]
set a72 [atomselect [lindex $molist 2] "chain B and resid 335 and name O" frame 0]
# record the position of the reference atoms
set a7Center [measure center $a71 weight mass]
set a72Center [measure center $a72 weight mass]
#$a71 delete; $a72 delete; $integrin3 delete;  $integrin4 delete; $integrin5 delete; $integrin3a delete; $all0 delete; $all1 delete; $all2 delete
for {set i 0} {$i < $frame_num} {incr i} {
$a70 frame $i
puts $outfile "$i [veclength [vecsub [measure center $a70 weight mass] $a7Center ] ] [veclength [vecsub [measure center $a70 weight mass] $a72Center ] ]"
}
$a70 delete
close $outfile
