#include <mpi.h>

int main (int argc, char **argv)
{
    int rank;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    if (rank == 0)
        printf("hello, world: %s %s\n", argv[1], argv[2]);
    MPI_Finalize();

    return 0;
}
