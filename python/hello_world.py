#!/bgsys/tools/python2.7.5-gnu-20130730/bin/python
#
# sample submit line(s):
#
#   export BG_PYTHON=/bgsys/tools/python2.7.5-gnu-20130730/bin/python
#   export BG_PYTHON_LIB=/bgsys/tools/python2.7.5-gnu-20130730/lib64
#   qsub -n 128  -t 20 -A MyProject --env LD_LIBRARY_PATH=$BG_PYTHON_LIB $BG_PYTHON ./hello_world.py
#

from mpi4py import MPI
import sys

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

print "Hello World from rank %s of %s" %(rank,size)

sys.exit()
