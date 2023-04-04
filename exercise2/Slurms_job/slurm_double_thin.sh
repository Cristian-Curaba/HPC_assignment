#!/bin/bash
#SBATCH --no-requeue
#SBATCH --job-name="Curaba_test"
#SBATCH --partition=THIN
#or FHPC
#SBATCH --nodes=1
#SBATCH --cpus-per-task=12
#SBATCH --exclusive
#SBATCH --time=2:00:00

module load architecture/AMD
module load mkl
module load openBLAS/0.3.21-omp

export code=/u/dssc/ccurab00/scratch/Foundations_of_HPC_2022/Assignment/exercise2
export OMP_NUM_THREADS=12



cd $code
make clean
make cpu

gcc -fopenmp 00_where_I_am.c -o 00_where_I_am.x
rm where_I_am.csv
./00_where_I_am.x >> where_I_am.csv

for i in {0..20}
do	let size=$((2000+2000*$i))
        for j in {1..3}
        do 
           	echo $size
                ./gemm_mkl.x $size $size $size >> 1_double_mkl_thin.csv
                ./gemm_oblas.x $size $size $size >> 1_double_oblas_thin.csv
#              	./gemm_blis.x $size $size $size >> 1_float_blis_64.csv
        done
done
