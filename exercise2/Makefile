### MKL libraries
###
###
MKL= -L${MKLROOT}/lib/intel64  -lmkl_intel_lp64 -lmkl_gnu_thread -lmkl_core -lgomp -lpthread -lm -ldl

### OpenBLAS libraries 
OPENBLASROOT=${OPENBLAS_ROOT}
### BLIS library
BLISROOT:=/u/dssc/ccurab00/scratch/blis

cpu: gemm_mkl.x gemm_oblas.x gemm_blis.x


gemm_mkl.x: gemm.c
	gcc -DUSE_FLOAT -DMKL $^ -m64 -I${MKLROOT}/include $(MKL)  -o $@

gemm_oblas.x: gemm.c
	gcc -DUSE_FLOAT -DOPENBLAS $^ -m64 -I${OPENBLASROOT}/include -L/${OPENBLASROOT}/lib -lopenblas -lpthread -o $@ -fopenmp

gemm_blis.x: gemm.c
#	gcc -DUSE_FLOAT  -DBLIS $^ -m64 -I${BLISROOT}/include/blis -L${BLISROOT}/lib -o $@ -lpthread  -lblis -fopenmp -lm
clean:
	rm -rf *.x
