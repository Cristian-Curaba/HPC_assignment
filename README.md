---
title: "Repository for the HPC assignment 2022/2023"
authors: Filippo Olivetti and Cristian Curaba
date: "april 2023"
---

The project is carried out by **Filippo Olivetti** and **Cristian Curaba**. This repository contains our solutions for the 2022-2023 assignment from the "High Performance Computing" course in Data Science and Scientific Computing master degree at Units.

To a detailed explanation of the project look at the *report.pdf* file. Each folder contains a readme file which will help navigate through the project.

### Exercise1

The exercise consists in implementing and testing the **Conways's Game of Life** with an openMP+MPI hybrid approach. All the mandatory instructions are executed.

### Exercise2

The second exercise aims to benchmark the mkl and oblas libraries for a dense matrix multiplication (in parallel). The benchmarking includes an analysis of the scalability in two ways:

-   Measuring time and Gflops of executions increasing the size of the matrix at fixed number of cores (64 for EPYC and 12 for THIN) for single and double precision. Different threads allocation policies were also tested.
-   Measuring time and Gflops of executions increasing the number of cores at a fixed matrix size for both single and double precision.

All the results are shown in the report.pdf and discussed.
