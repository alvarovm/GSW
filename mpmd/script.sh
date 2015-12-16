#!/bin/bash

runjob --block $COBALT_PARTNAME --np $((128*16)) --ranks-per-node 16 --mapping mapfile : ./exe1.x
