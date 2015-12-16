export BG_PYTHON=/bgsys/tools/python2.7.5-gnu-20130730/bin/python
export BG_PYTHON_LIB=/bgsys/tools/python2.7.5-gnu-20130730/lib64

qsub -n 128  -t 20 -A MyProject --env LD_LIBRARY_PATH=$BG_PYTHON_LIB $BG_PYTHON ./hello_world.py
