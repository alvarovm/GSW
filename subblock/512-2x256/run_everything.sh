#!/bin/bash

LOCARGS="--block $COBALT_PARTNAME ${COBALT_CORNER:+--corner} $COBALT_CORNER ${COBALT_SHAPE:+--shape} $COBALT_SHAPE"

echo "LOCARGS = " $LOCARGS
echo "COBALT_PARTNAME = " $COBALT_PARTNAME
echo "COBALT_CORNER   = " $COBALT_CORNER
echo "COBALT_SHAPE    = " $COBALT_SHAPE

exe=$HOME/MY_EXECUTABLE

# per-subjob arguments: 256 ranks, 1 rank per node
runjob_args="--verbose INFO -n 256 -p 1 : $exe"


BLOCKS=`get-bootable-blocks --size 512 $COBALT_PARTNAME` 

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
  shape="4x2x4x4x2"
  corner_list=$(/soft/cobalt/bgq_hardware_mapper/get-corners.py $BLOCK $shape)
  for corner in $corner_list 
  do
    echo starting job on corner $corner
    runjob --block $BLOCK --corner $corner --shape $shape $runjob_args &
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
