#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <getopt.h>
#include "write_pgm_images.h"
#include "game_functions.h"


#define INIT 0
#define RUN  1

#define K_DFLT 100

#define ORDERED 0
#define STATIC  1


char fname_deflt[] = "game_of_life.pgm";

int   action = 0;
					//i/r for inizialiazing/running
int   x      = K_DFLT;			//rectangular grid
int   y      = K_DFLT;
float p      = 0.05;			//Probability of a cell to be alive in inizialiazing
int   e      = ORDERED;			//Ordered=1, Static=0
int   n      = 5;			//Numbers of iterations
int   s      = 1;			//Screen every s iterations
char *fname  = NULL;			//Name of the file


int main ( int argc, char **argv ){

  char *optstring = "irx:y:p:e:n:s:f:";

  int c;
  while ((c = getopt(argc, argv, optstring)) != -1) {
    switch(c) {
      
    case 'i':
      action = INIT;
      break;
      
    case 'r':
      action = RUN; break;
      
    case 'x':
      x = atoi(optarg); break;
      
    case 'y':
      y = atoi(optarg); break;
      
    case 'p':
      p = atof(optarg); break;

    case 'e':
      e = atoi(optarg); break;
      
    case 'n':
      n = atoi(optarg); break;

    case 's':
      s = atoi(optarg); break;

    case 'f':
      printf("\n%s\n", optarg);
      fname = (char*)malloc( sizeof(optarg)+1 );
      sprintf(fname, "%s", optarg );
      break;

    default :
      printf("argument -%c not known\n", c ); break;
    }
  }
  
  if (!action){
  	initialize_game(x, y, fname, p);
  } else if (action){
  	run_game(x, y, fname, n, s, e);
  }

  if ( fname != NULL )
      free ( fname );
     

  return 0;
}
