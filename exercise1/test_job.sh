#!/bin/bash
#SBATCH --no-requeue
#SBATCH --job-name="test_folive00"
#SBATCH --partition=EPYC
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=128
#SBATCH --exclusive
#SBATCH --time=1:00:00

module load architecture/AMD
module load openMPI/4.1.4/gnu/12.2.1

export code=/u/dssc/folive00/Foundations_of_HPC_2022/HPC_assignment/exercise1
export OMP_NUM_THREADS=65
export OMP_PLACES=cores
export OMP_PROC_BIND=close

cd $code
mpicc -fopenmp main/main.c main/game_functions.c main/write_pgm_images.c
# rm statistics/STATISTICS.csv
cd test_images

# echo -e "N_test, Img_dims, n, s, O or S, nOMP, nMPI, MPI_loc, MPI_rank, Time(sec), MPI_Scv(sec), MPI_Gav(sec), for_loop(sec), Affinity  \n" >> ../statistics/STATISTICS.csv
echo -e "\n"

for j in {1..2}
do	
	echo -e "$j, 1000x1000, , , , , ,socket, , , , , , cores close" >> ../statistics/STATISTICS.csv	
	mpirun -np 2 --map-by socket ../a.out -r -x 1000 -y 1000 -e 1 -n 100 -s 50 -f exp_1000x1000.pgm >> ../statistics/STATISTICS.csv

done

