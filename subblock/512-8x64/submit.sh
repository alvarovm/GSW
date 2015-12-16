#!/bin/bash

qsub -A <MyProject> -n 128 -t 20 --mode script ./script.sh
