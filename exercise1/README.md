
# Exercise 1 - Parallel Programming

### Foundations of HPC @ UniTS-DSSC 2022

**Assignment for the _Foundations of High Performance Computing course at “Data Science and Scientific Computing”, University of Trieste, 2022-2023**

_Stefano Cozzini_   `stefano.cozzini at areasciencepark.it`
_Luca Tornatore_   `luca.tornatore at inaf.it`

**Due time: 1 week before taking the oral exam**

------

## Game of Life

You’ll be prompted to implement a parallel version of a variant of the famous Conway’s “_game of life_” ( references: [1](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life), [2](https://conwaylife.com/) ), that is cellular automaton which plays autonomously on a infinite 2D grid.
The game itself has several exciting properties and pertains to a very interesting field, but we leave to the readers going deeper into it at will.

### Addition to the v1.0 of the text

You are required to provide a scalability study:

- *OpenMP scalability*: fix the number of MPI tasks to 1 per socket, and report the behaviour of the code when you increase the number of threads per task from 1 up to the number of cores present on the socket;

- *Strong MPI scalability*: given a fixed size (you may opt for several increasing sizes) show the run-time behaviour when you increase the number of MPI tasks (use as many nodes as possible, depending on the machine you run on);
 
- *Weak MPI scalability*: given an initial size, show to run-time behaviour when you scale up from 1 socket (saturated with OpenMP threads) up to as many sockets you can keeping fixed the workload per MPI task.

## FILES:
- `Assignment_exercise1.pdf` : the complete text of the exercise
- `read_write_pgm_images.c` : and example showing how to read and write a pgm image file
- `get_args.c` : an example showing how to deal with command-line arguments

### ADDED FILES:
- 'main' folder contains:
    - 'read_write_pgm_images.c'
    - 'game_functions.c' which contains the basic functions to build and run the setup of Game of Life (more infos are on source codes)
    - header files for both the source codes.

- 'correctness' folder contains a toy image of 30x40 with 10 successive snapshots (nMPI = 1, nOMP = 8, for notations see the final report); using visualize.x it can be shown that 
    the rules are applied correctly. All details are explained in the README.md inside the folder.

- 'test_job.sh' is a slurm file that creates a job for executing a single test on an image (omp threadization and mpi processees should be checked before every test)

- 'visualize.c' is a source code that print on the shell the pgm images; clearly it is helpful in visualizing the correctness of images evolution only for small examples.
    It is helpful also for visualizing snapshots.
- 'small_exp_100x100.pgm', 'big_exp_10000x10000.pgm' and 'exp_1000x1000.pgm' are starting images used for experiments (explained in the report) of size respectively 100x100, 10000x10000, 1000x1000.

## HOW TO RUN THE GAME OF LIFE:
- you can run directly the 'test_job.sh' file using 'sbatch test_job.sh' command. Note that you have to set all input parameters previously: the number of MPI processes and the location, the number
    of OMP threads for each MPI process and the input image with the specific dimensions. The sbatch file authomatically sends a request for some cores and load all necessary modules. It is
    possible also to build csv files with the data used for writing the report

## DATASETS
In the folder 'test_images' there are the datasets used to make the final report. In particular, they are split into datasets used for OMP scalability test, and MPI scalability. 
The tables inside each csv file have the same columns; the following is the legend:
- N_test: the number of the test; in order to obtain results which area statistically more significant we can increase the number of test for each task;
- Img_dims: dimensions of the input image
- n: is the number of total updates of the input image
- s: the frequence for the snapshots
- O or S: O stands for the 'Ordered GOL' while S for 'Static GOL' (GOL = Game of Life)
- nOMP: number of OMP threads (more details on the notations are in the project)
- nMPI: numbe of MPI processes
- MPI_loc: location of MPI processes (could be core, L3cache, socket, node, ...)
- MPI_rank: the rank of a single MPI process
- Time(sec): the overall time for completing n updates of the input image
- MPI_Scv(sec): MPI_Scv stands for MPI_Scatterv; this represent the time taken by a single MPI_Scatterv call
- MPI_Gav(sec): the time taken by a single MPI_Gatherv call
- for_loop(sec): the time taken for the central loop that updates slices of the image (more details of it are in the report)
- Affinity: just the specific OMP_PLACES and OMP_PROC_BIND used to make the test.

