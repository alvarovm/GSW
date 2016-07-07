FC = mpixlc_r
OPTFLAGS = -O3 -qsmp=omp
FFLAGS = $(OPTFLAGS) -g 

all:  hello_omp

hello_mpi_f90: hello_mpi.f90
	$(FC) $(FFLAGS) -o hello_omp hello_omp.c

clean:
	rm -rf hello_omp.c
	rm -rf *.lst
