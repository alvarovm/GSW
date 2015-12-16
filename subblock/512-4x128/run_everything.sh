#!/bin/bash

LOCARGS="--block $COBALT_PARTNAME ${COBALT_CORNER:+--corner} $COBALT_CORNER ${COBALT_SHAPE:+--shape} $COBALT_SHAPE"

echo "LOCARGS = " $LOCARGS
echo "COBALT_PARTNAME = " $COBALT_PARTNAME
echo "COBALT_CORNER   = " $COBALT_CORNER
echo "COBALT_SHAPE    = " $COBALT_SHAPE

exe=$HOME/MY_EXECUTABLE

# per-subjob arguments: 128 ranks, 1 rank per node
runjob_args="--verbose INFO -n 128 -p 1 : $exe"

shape="2x2x4x4x2"
corner_list=$(/soft/cobalt/bgq_hardware_mapper/get-corners.py $COBALT_PARTNAME $shape)
corner=( $corner_list )

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

for i in {0..3}
do

 echo starting job on corner ${corner[$i]}
 runjob --block $COBALT_PARTNAME --corner ${corner[$i]} --shape $shape $runjob_args &
 sleep 10

done

#
# Releasing blocks 
#

for BLOCK in $BLOCKS
do

  boot-block --block $BLOCK --free & 

done
wait
