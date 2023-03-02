#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <sys/syscall.h>
#include <omp.h>
#include "mpi.h"
#include "write_pgm_images.h"

#define SEED 123
#define MAXVAL 255


/*
	int xsize, ysize: x, y dimensions of the image
	char *image_name: the name of the file to be written
	double prob: the probability that a random cell lives
*/

void initialize_game(int xsize, int ysize, const char *image_name, double prob)
{
	if ((prob < 0) || (prob > 1)){
	    	printf("Probability must be a real number between 0 and 1");
	    	exit(1);
	    	//errno = EDOM;
	    	/*
	    	Needs to add this in the main
	    	
	    	if (errno == EDOM) {
	    	perror("divide");
	  	}
	    	*/
    	}
        /*
        The idea of this function is to split the image along the y axis (so we create long horizontal slices).
        The problem is that xsize % size != 0, where size is the number of MPI processes. In order to improve efficiency,
        I decided to split the image in slices of y-length (xsize / size) and others of y-length (xsize / size) + 1:
        obviously the total sum must be xsize; so the total number of slices with y-length (xsize / size) +1 should be equal to xsize % size.
        
        The consequence of this is that we have a natural division in two different groups, that it is performed by correctly choosing
        start and end indexes (see below).
       
        The last problem is that we need to handle send buffers with different sizes, so we need to use MPI_Gatherv.
        */
        
        srand(SEED);
    	
	double tstart, tend;
        int rank, size;

        int mpi_provided_thread_level;
        
        MPI_Init_thread( NULL, NULL, MPI_THREAD_FUNNELED, &mpi_provided_thread_level);
	//MPI_THREAD_FUNNELED: the process may be multi-threaded, but the application must ensure that only the main thread makes MPI calls
        
        if ( mpi_provided_thread_level < MPI_THREAD_FUNNELED ) {
                printf("a problem arise when asking for MPI_THREAD_FUNNELED level\n");
                MPI_Finalize();
                exit( 1 );
        }


        MPI_Comm_rank(MPI_COMM_WORLD, &rank);
        MPI_Comm_size(MPI_COMM_WORLD, &size);
	tstart = MPI_Wtime();

	// Here we split the image along the x axis???

	int sub_xsize = xsize / size;
	int rest =  xsize % size;
	
	// In the following way we can share part of the image in pieces of sub_xsize and sub_xsize+1, depending on the rest
	int rank_minor_rest = (rank < rest);
	int start = rank * sub_xsize + (rank)*(rank_minor_rest);
	int end = (rank + 1) * sub_xsize + (rank+1)*(rank_minor_rest);
	
	
	if (!rank_minor_rest){         //we need this because the previous assignment from a certain point adds only zeros
	     start += rest;
	     end   += rest;
	}	
	
	unsigned char (*sub_image)[xsize] = malloc((end-start) * ysize * sizeof(unsigned char));
	
	#pragma omp parallel for shared(start, end, ysize, sub_image, prob) collapse(2)
	for(int i = 0; i < end-start; i++){
		for(int k = 0; k < ysize; k++){
			sub_image[i][k] = (((float)rand() / RAND_MAX) < prob) ? (unsigned char) 0 : (unsigned char) 255;  //gives 0 with probability prob, 255 with (1-prob)
		}
	}
		
		
	//printf("The process of rank %d starts with index %d to index %d\n", rank, start, end);
	
	// Allocate recvcounts and displs arrays for MPI_Gatherv
	int sum = 0;
        int *recvcounts = malloc(size * sizeof(int));
        int *displs = malloc(size * sizeof(int));
         //  printf("The size is %d\n",size);

        for (int i = 0; i < size; i++){
		recvcounts[i] = (sub_xsize + (i < rest) ) * ysize;
                displs[i] = sum;
                sum += recvcounts[i];
        }

	unsigned char (*image)[xsize] = malloc(xsize * ysize * sizeof(unsigned char));	
	MPI_Gatherv(sub_image, (end-start) * ysize, MPI_UNSIGNED_CHAR, image, recvcounts, displs, MPI_UNSIGNED_CHAR, 0, MPI_COMM_WORLD);

	if (rank == 0){
		write_pgm_image(image, MAXVAL, xsize, ysize, image_name);
	}

	//MPI_Barrier(MPI_COMM_WORLD);
	free(image);
	free(sub_image);
	free(recvcounts);
	free(displs);
	tend = MPI_Wtime();
     
	// time checks
	#pragma omp parallel
	#pragma omp single
  	{	
	int nthreads = omp_get_num_threads();
	printf("Initializing the game of Life in MPI process of rank %d with %d threads\n", rank, nthreads);
	printf("\t The process took %g sec of wall-clock time\n\n", tend-tstart);
	}

	MPI_Finalize();	
}


// xsize, ysize are the dimensions of 2d array pixels
unsigned char upgrade_cell(int xsize, int ysize, unsigned char (*pixels)[xsize], int i, int j){
    /*
    int A[8];		//stores the 8 neighboors
    int x, y;

    for (int k = 0; k < 4; k++) {
        x = i + (k / 3) - 1; 		//row-major order
        y = j + (k % 3) - 1;
        x = (x + xsize) % xsize;
        y = (y + ysize) % ysize;
        A[k] = (int) pixels[x][y];
    }
    
    for (int k = 5; k < 9; k++) {
        x = i + (k / 3) - 1;
        y = j + (k % 3) - 1;
        x = (x + xsize) % xsize;
        y = (y + ysize) % ysize;
        A[k-1] = (int) pixels[x][y];
    }

    // Perform the calculation to update the cell based on the values of its neighbors
    // ...
     
     int sum = 0;
     for (int i = 0; i < 8; i++) {
     	sum += A[i];
     }
     
     */
    
    //all 9 neighbor cells
    int x_mod[3] = {(xsize + i - 1) % xsize, i % xsize, (xsize + i + 1) % xsize};
    int y_mod[3] = {(ysize + j - 1) % ysize, j % ysize, (ysize + j + 1) % ysize};
    int sum = pixels[x_mod[0]][y_mod[0]] + pixels[x_mod[0]][y_mod[1]] + pixels[x_mod[0]][y_mod[2]] +
              pixels[x_mod[1]][y_mod[0]] + pixels[x_mod[1]][y_mod[2]] +
              pixels[x_mod[2]][y_mod[0]] + pixels[x_mod[2]][y_mod[1]] + pixels[x_mod[2]][y_mod[2]];

     
     // a cell becomes, or remains, alive if 2 to 3 cells in its neighborhood are alive; (ALIVE is 0, DEAD is 255)
     // Note that 1275 = 255*5, 1530 = 255*6
     return ((sum == 1275) || (sum == 1530)) ? (unsigned char)  0 : (unsigned char) 255;
}



/*
	int xsize, ysize      : x,y dimension of the image
	image_name            : file name in which the starting image is stored
	total_steps           : the total number of steps that the function has to reach
	step_for_snap         : frequency of snapshot creation
	evolution_type        : 0 means ordered evolution, other means static evolution

*/

void run_game(int xsize, int ysize, const char *image_name, int total_steps , int step_for_snap, int evolution_type){
	int time_steps = 0;
	double tstart,tend;
	int maxval = MAXVAL;
	unsigned char *image;
	char snapshot_string[18];
	read_pgm_image((void **)&image, &maxval, &xsize, &ysize, image_name);
	unsigned char (*pixels)[xsize] = (unsigned char (*)[xsize])image;              // set the pointer to a 2d array

	
	if (evolution_type == 0) {               //	ordered evolution
	    
	     
	     tstart = omp_get_wtime();
	     for(time_steps = 0; time_steps < total_steps; time_steps++){
	     	    
	    	    #pragma omp parallel for shared(xsize,ysize,pixels) collapse(2)
		     for ( int i = 0; i < xsize; i++ ){
			for ( int j = 0; j < ysize; j++ ){
			    pixels[i][j] = upgrade_cell(xsize,ysize,pixels,i,j);
			    
			}
		     }
		     
		     
		     if ( time_steps % step_for_snap == 0){                                   //this will create the snapshots
  			sprintf(snapshot_string, "snapshot_O_%05d", time_steps);
		     	write_pgm_image(pixels, MAXVAL, xsize, ysize, snapshot_string);
		     }  
	     
	     }
	     
	    
	     // just to show the final image
	     if (time_steps % step_for_snap != 0){
	     	sprintf(snapshot_string, "snapshot_S_%05d", time_steps);
		write_pgm_image(pixels, MAXVAL, xsize, ysize, snapshot_string);
	     }

	     tend = omp_get_wtime();
	     
	     

	#pragma omp parallel
        #pragma omp single
        {
        int nthreads = omp_get_num_threads();
        printf("Running the ORDERED game of Life with %d threads...\n", nthreads);
        printf("\t The process took %g sec of wall-clock time\n\n", tend-tstart);
        }

	
	} else {		// STATIC EVOLUTION

        int rank, size;

	int mpi_provided_thread_level;
	MPI_Init_thread( NULL, NULL, MPI_THREAD_FUNNELED, &mpi_provided_thread_level);
	
	tstart = MPI_Wtime();
	if ( mpi_provided_thread_level < MPI_THREAD_FUNNELED ) {
		printf("a problem arise when asking for MPI_THREAD_FUNNELED level\n");
		MPI_Finalize();
		exit( 1 );
	}
	
        MPI_Comm_rank(MPI_COMM_WORLD, &rank);
        MPI_Comm_size(MPI_COMM_WORLD, &size);

	// Here we split the image along the x axis
	int sub_xsize = xsize / size;
	int rest =  xsize % size;
	
	// In the following way we can share part of the image in pieces of sub_xsize and sub_xsize+1, depending on the rest
	int rank_minor_rest = (rank < rest);
	int start = rank * sub_xsize + (rank)*(rank_minor_rest);
	int end = (rank + 1) * sub_xsize + (rank+1)*(rank_minor_rest);
	
	
	if (!rank_minor_rest){         //we need this because the previous assignment from a certain point adds only zeros
	     start += rest;
	     end   += rest;
	}
	
		
	// Allocate recvcounts and displs arrays for MPI_Gatherv
        int sum = 0;
        int *recvcounts = malloc(size * sizeof(int));
	int *sendcounts = malloc(size * sizeof(int));
        int *displs = malloc(size * sizeof(int));
	int *senddispls = malloc(size * sizeof(int));

        
	int double_ysize = 2* ysize;
        for (int i = 0; i < size; i++){
                recvcounts[i] = (sub_xsize + (i < rest) ) * ysize;
		sendcounts[i] = recvcounts[i]+ double_ysize;
                displs[i] = sum;
		senddispls[i] = sum-ysize;
                sum += recvcounts[i];
        }

	senddispls[0] = 0;
       	senddispls[size-1] = 0;
	sendcounts[0] = xsize * ysize;
       	sendcounts[size-1] = xsize * ysize;

	// The following variable is needed below because when the rank is 0 or size-1, we need also the 'other side' of the matrix in order to update.
	// But this gives some troubles because we have to set MPI_Scatterv properly. Hence, I decided that in the case of rank == 0 or rank == size-1,
	// we send all the matrix for the update (even if we don't need all the matrix to do it). In particular, in the case the MPI processes are 1 or 2,
	//  all matrix is sent among processes every iteration for iteration.
	//  The +2 is due to the fact that for every slice we need exactly one row above and one row below in order to update the image.
	
	int end_minus_start = ((rank > 0) && (rank < size-1))? (end-start+2) : xsize;
	
	unsigned char (*sub_image)[xsize] = malloc((end-start) * ysize * sizeof(unsigned char));
	unsigned char (*data_image)[xsize] = malloc(end_minus_start * ysize * sizeof(unsigned char));
	/*	
	for (int i = 0; i < size; i++){
		printf("For i = %d \n senddispls[i] = %d, sendcounts[i] = %d\n",i, senddispls[i], sendcounts[i]);
	}
	printf("For MPI process %d the start index is %d, the end is %d and end_minus_start is %d \n\n", rank, start, end, end_minus_start);
	*/
	    
	int fix_start = ((rank >0) && (rank < size -1))? 1 : start;
	int temp_init;
	double mean1 = 0;
	double mean2 = 0;
	double mean3 = 0;
	for(int time_steps = 0; time_steps < total_steps; time_steps++){
		// just for printing
		//printf("Image %d contents:\n", time_steps);
		temp_init  = fix_start;
		
		mean1 = MPI_Wtime();
	    	MPI_Barrier(MPI_COMM_WORLD);
		// This is the least possible part of the image needed to evaluate sub_image below
		MPI_Scatterv(pixels, sendcounts, senddispls, MPI_UNSIGNED_CHAR, data_image, end_minus_start * ysize, MPI_UNSIGNED_CHAR, 0, MPI_COMM_WORLD);
		mean1 = MPI_Wtime()-mean1;

		mean2 = MPI_Wtime();
		#pragma omp parallel for shared(temp_init,xsize,ysize,pixels,sub_image) collapse(2)
		for(int temp = temp_init; temp < end-start+temp_init; temp++){
			for(int k = 0; k < ysize; k++){
				sub_image[temp-temp_init][k] = upgrade_cell(xsize,ysize,data_image,temp,k);  //upgrade each cell
			}
		}
		mean2 = MPI_Wtime()-mean2;

		mean3 = MPI_Wtime();
		MPI_Barrier(MPI_COMM_WORLD);
		MPI_Gatherv(sub_image, (end-start) * ysize, MPI_UNSIGNED_CHAR, pixels, recvcounts, displs, MPI_UNSIGNED_CHAR, 0, MPI_COMM_WORLD);
		mean3 = MPI_Wtime()-mean3;
	        
	        if ( time_steps % step_for_snap == 0){                                   //this will create the snapshots
	         
      		   if (rank == 0) {
		      sprintf(snapshot_string, "snapshot_S_%05d", time_steps);
	     	      write_pgm_image(pixels, MAXVAL, xsize, ysize, snapshot_string);
	     	   }
	        }
	     /*
	        //reuse memory
		if (rank == 0){
	        unsigned char (*temp_ptr)[xsize] = next_image;
	        next_image = pixels;           
	        pixels = temp_ptr;
		}
	     */	
	
	     
	    	    
	 }
	 
	    
	free(data_image);
	free(senddispls);
	free(sendcounts);
	free(sub_image);
	free(recvcounts);
	free(displs);
	    
	tend = MPI_Wtime();
	    
	// just to show the final image
	    
	if (time_steps % step_for_snap != 0){
		if (rank == 0){
	        	sprintf(snapshot_string, "snapshot_S_%05d", time_steps);
	        	write_pgm_image(pixels, MAXVAL, xsize, ysize, snapshot_string);
		}
	    }

	
	#pragma omp parallel
        #pragma omp single
        {
        int nthreads = omp_get_num_threads();
        printf("Running the STATIC game of Life in MPI process of rank %d with %d threads...\n", rank, nthreads);
        printf("\t The process took %g sec of wall-clock time\n", tend-tstart);
	printf("\t MPI_Gatherv = %g, for loop (in single MPI process) = %g, MPI_Scatterv = %g\n\n", mean1, mean2, mean3);
        }

	MPI_Finalize();
	}

        
}

