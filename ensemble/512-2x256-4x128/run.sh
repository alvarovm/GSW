#!/bin/bash
#COBALT -t 15 
#COBALT -n 512 
#COBALT -A ALCF_Getting_Started  
#COBALT --disable_preboot 

LOCARGS="--block $COBALT_PARTNAME ${COBALT_CORNER:+--corner} $COBALT_CORNER ${COBALT_SHAPE:+--shape} $COBALT_SHAPE"

echo "LOCARGS = " $LOCARGS
echo "COBALT_PARTNAME = " $COBALT_PARTNAME
echo "COBALT_CORNER   = " $COBALT_CORNER
echo "COBALT_SHAPE    = " $COBALT_SHAPE

exe=./hello_mpi_f90

# per-subjob arguments: 128 ranks, 1 rank per node

BLOCKS=`get-bootable-blocks --size 256 $COBALT_PARTNAME` 

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
for BLOCK in $BLOCKS
do
  shape="2x2x4x4x2"
  corner_list=$(/soft/cobalt/bgq_hardware_mapper/get-corners.py $BLOCK $shape)
  for corner in $corner_list 
  do
    echo starting job on corner $corner
    echo "runjob --block $BLOCK --corner $corner --shape $shape --verbose INFO  --ranks-per-node 1 : $exe >  $COBALT_JOBID-$corner-$BLOCK.output & "
    runjob --block $BLOCK --corner $corner --shape $shape --verbose INFO  --ranks-per-node 1 : $exe >  $COBALT_JOBID-$corner-$BLOCK.output &
    sleep 10
  done
done

#
# Releasing blocks 
#

for BLOCK in $BLOCKS
do

  boot-block --block $BLOCK --free & 

done
wait
