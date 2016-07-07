FC = mpixlf90_r
OPTFLAGS = -O3 -qarch=qp -qtune=qp -qstrict
FFLAGS = $(OPTFLAGS) -g 

all:  hello_mpi_f90

hello_mpi_f90: hello_mpi.f90
	$(FC) $(FFLAGS) -o hello_mpi_f90 hello_mpi.f90

clean:
	rm -rf hello_mpi_f90
	rm -rf *.lst
