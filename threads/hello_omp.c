// Example program using MPI and OpenMP threads
#include "mpi.h"
#include <omp.h>
#include <stdio.h>

main( int argc, char** argv )
{
  int nthreads, tid;
  int rank, size;

  MPI_Init( &argc, &argv );
  MPI_Comm_rank( MPI_COMM_WORLD, &rank );
  MPI_Comm_size( MPI_COMM_WORLD, &size );

  for ( int orderRanks = 0; orderRanks < size; orderRanks++ ) {
    if ( rank == orderRanks ) {
#pragma omp parallel private(tid)
      {
        tid= omp_get_thread_num();
        printf("Hello world from rank %d, thread %d\n", rank, tid);

        if (tid == 0) {
          nthreads= omp_get_num_threads();
          printf("Rank %d number of threads= %d\n", rank, nthreads);
        }
      }
    }
    MPI_Barrier( MPI_COMM_WORLD );
  }
  fflush( stdout );
  MPI_Finalize();
  return 0;
}
