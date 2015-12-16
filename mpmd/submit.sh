#!/bin/bash

qsub -A Operations -n 128 -t 30 --mode script ./script.sh
