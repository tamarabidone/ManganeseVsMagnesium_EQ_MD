# RC Feb 5, 2024
# 
# Measure the distance of the ADMIDAS ion from residues 123, 126, 127 and 335 in the B-I domain. 
mol new trajout.pdb waitfor all
mol addfile trajout.xtc waitfor all
set outfile [open ./DistanceADMIDAS_all.dat w]
puts $outfile "#! Frame Dist123-ADMIDAS Dist126-ADMIDAS Dist127-ADMIDAS Dist335-ADMIDAS "
set molist [molinfo list]
set frame_num [molinfo top get numframes]
# the Calcium resid is 2002 for condition 1 and condition 6. The residue numbers are not the same across them because 
# RGD comes before ions if RGD is present in the pdb file. I need to somehow set the chain
# make selections for position of reference atom and test atom
set ad70 [atomselect [lindex $molist 0] "chain X and residue 695 to 720"]
$ad70 set chain I
$ad70 delete
set ad70 [atomselect [lindex $molist 0] "chain I and resid 2002"]
set ad71 [atomselect [lindex $molist 0] "chain B and resid 123 and name O"]
set ad72 [atomselect [lindex $molist 0] "chain B and resid 126 and name CG"]
set ad73 [atomselect [lindex $molist 0] "chain B and resid 127 and name CG"]
set ad74 [atomselect [lindex $molist 0] "chain B and resid 335 and oxygen"]
if {[$ad70 num] == 0} {
close $outfile
exit
}
# A-Ser404-B-Val403. Tests the swing out of the hybrid domain, which is not present in my system.
#$a71 delete; $a72 delete; $integrin3 delete;  $integrin4 delete; $integrin5 delete; $integrin3a delete; $all0 delete; $all1 delete; $all2 delete
for {set i 0} {$i < $frame_num} {incr i} {
$ad70 frame $i
$ad71 frame $i
$ad72 frame $i
$ad73 frame $i
$ad74 frame $i
set dis1 [veclength [vecsub [measure center $ad70 weight mass] [measure center $ad71 weight mass] ] ]
set dis2 [veclength [vecsub [measure center $ad70 weight mass] [measure center $ad72 weight mass] ] ]
set dis3 [veclength [vecsub [measure center $ad70 weight mass] [measure center $ad73 weight mass] ] ]
set dis4 [veclength [vecsub [measure center $ad70 weight mass] [measure center $ad74 weight mass] ] ]
puts $outfile "$i $dis1 $dis2 $dis3 $dis4"
}
$ad70 delete
$ad71 delete
$ad72 delete
$ad73 delete
$ad74 delete
close $outfile
exit
