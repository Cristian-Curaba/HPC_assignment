---
title: "Exercise2"
authors: Filippo Olivetti and Cristian Curaba
date: "2023-03-31"
output:
  html_document:
    df_print: paged
editor_options:
  markdown:
    wrap: sentence
---

## R Markdown

In the following itemize we describe the content of this folder.

-   In the pwd we have the *'gemm.c'* and *'gemm_threads.c'* codes used to run the libraries.
    The Makefile can compile the '*gemm.c'* code with both the mkl and oblas libraries typing 'make cpu', which results in executables *'gemm_mkl.x'* and *'gemm_oblas.x'* (change `-DUSE_DOUBLE` with `-DOUBLE` if needed).

-   In *'aux_code'* folder there's a simple code (and his executable) to check the behavior of threads.

-   In *'aux_csv_files'* folder there are some auxiliary output files that we used to check the behavior of different threads affinity.
    There's also the output file of the auxiliary code *'/aux_code/00_where_I\_am.c'*.

-   In *'csv_files'* folder there's data we collected following the instructions of the assignment.
    In the *'.csv'* files there are 4 columns which respectively represent: type of input data, time [ms] of execution, dimensions of the square matrices, average number of Gflops.

-   The *'Slurm.out'* folder contains the output information of the slurm jobs files.

-   The *'Slurm_job'* folder contains the batch scripts.
    Typing `sbatch slurm_name.sh` in orfeo client node will submit the batch script to Slurm.
