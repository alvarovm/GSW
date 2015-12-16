#!/bin/bash -x

#
# Divides 512 nodes in 64 node blocks
#   with shape 4x2x2x2x2
# 
exe=test.x
args="-j 1"
nodes=64
shape=4x2x2x2x2
rpn=16
physical_corners=$(/soft/cobalt/bgq_hardware_mapper/get-corners.py $COBALT_PARTNAME ${shape})
j=0
for physical_corner in $physical_corners
do
    # spawn these in the background
    runjob --np $(($nodes*$rpn)) --ranks-per-node $rpn --block $COBALT_PARTNAME --corner $physical_corner --shape $shape : $exe $args > $j.out 2> $j.err &

   # need to pause between startups otherwise startup can fail 
   sleep 5
   j=$(($j+1))
done

# wait for all jobs to finish
wait
