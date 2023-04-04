#!/bin/bash
#SBATCH --no-requeue
#SBATCH --job-name="test_folive00"
#SBATCH --partition=EPYC
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --exclusive
#SBATCH --time=1:00:00

module load architecture/AMD
module load openMPI/4.1.4/gnu/12.2.1

export code=/u/dssc/folive00/Foundations_of_HPC_2022/Assignment/exercise1
export OMP_NUM_THREADS=8
export OMP_PLACES=cores
export OMP_PROC_BIND=close

cd $code
mpicc -fopenmp main/main.c main/game_functions.c main/write_pgm_images.c
# rm statistics/STATISTICS.csv
cd correctness

# echo -e "N_test, Img_dims, n, s, O or S, nOMP, nMPI, MPI_loc, MPI_rank, Time(sec), MPI_Scv(sec), MPI_Gav(sec), for_loop(sec), Affinity  \n" >> ../statistics/STATISTICS.csv
# echo -e "\n"
 
mpirun -np 1 --map-by socket ../a.out -r -x 30 -y 40 -e 1 -n 10 -s 1 -f correct_30x40.pgm

./visualize.x -x 30 -y 40 -f correct_30x40.pgm >> visualizing_correct_30x40.txt
