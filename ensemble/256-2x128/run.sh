#!/bin/bash
#COBALT -n 256
#COBALT -t 15 
#COBALT -A ALCF_Getting_Started 
#COBALT --disable_preboot

BLOCKS=`get-bootable-blocks --size 128 $COBALT_PARTNAME`

#--size size of the subpartitions

#
# Booting blocks
#

for BLOCK in $BLOCKS 
do

 boot-block --block $BLOCK &

done
wait

#
# Loading blocks
#

echo $BLOCKS
for BLOCK in $BLOCKS
do

 echo "runjob --block $BLOCK -n 128 --verbose=INFO : a.out  > $COBALT_JOBID-$corner-$BLOCK.output& "
 runjob --block $BLOCK -n 128 --verbose=INFO : hello_mpi_f90 > $COBALT_JOBID-$BLOCK.output & 

done
wait

#
# Releasing blocks 
#

for BLOCK in $BLOCKS
do

 boot-block --block $BLOCK --free &

done
wait
