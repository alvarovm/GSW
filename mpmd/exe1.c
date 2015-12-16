#include <mpi.h>

int main (int argc, char **argv)
{
    MPI_Comm comm;
    char name[256];
    int rc;
    int world_rank;
    int exe_rank;
    int world_size;
    int exe_size;

    rc = MPI_Init(&argc, &argv);

    rc = MPI_Get_processor_name(name, &rc);

    rc = MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);
    rc = MPI_Comm_size(MPI_COMM_WORLD, &world_size);

    rc = MPI_Comm_split(MPI_COMM_WORLD, (world_rank < 1024), world_rank, &comm);

    rc = MPI_Comm_rank(comm, &exe_rank);
    rc = MPI_Comm_size(comm, &exe_size);

    if (world_rank == 0)
    {
        printf("exe1 world_size:%d world_rank:%d exe_rank:%d\n",
               world_size, world_rank, exe_rank);
    }

    if (exe_rank == 0)
    {
        printf("exe1 exe_size:%d world_rank:%d exe_rank:%d proc:%s\n",
               exe_size, world_rank, exe_rank, name);
    }

    rc = MPI_Finalize();

    return 0;
}
