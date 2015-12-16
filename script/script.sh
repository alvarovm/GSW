#!/bin/bash
#COBALT -t 15 
#COBALT -n 8 
#COBALT -A IonSolvation  

thre=8
modes=4
nodes=$COBALT_JOBSIZE
nps=$(($nodes * $modes))


bin=hello_mpi_f90

runjob --np $nps -p $modes \
       --envs  XLSMPOPTS=parthds=8 --envs BG_THREADLAYOUT=4 --envs OMP_WAIT_POLICY=active \
       --envs OMP_NUM_THREADS=$thre  --envs BG_COREDUMPONERROR=1 --block $COBALT_PARTNAME  :  $bin  > hello_mpi_f90-$COBALT_JOBID-$COBALT_JOBSIZE.output
