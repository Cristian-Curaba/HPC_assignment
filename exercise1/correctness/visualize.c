#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <getopt.h>

#include "../main/write_pgm_images.h"

#define K_DFLT 100
#define MAXVAL 255

int   x      = K_DFLT;			//rectangular grid
int   y      = K_DFLT;
char *fname  = NULL;

int main ( int argc, char **argv ){

  char *optstring = "x:y:f:";

  int c;
  while ((c = getopt(argc, argv, optstring)) != -1) {
    switch(c) {
    
    case 'x':
      x = atoi(optarg); break;
      
    case 'y':
      y = atoi(optarg); break;

    case 'f':
      printf("\n%s\n", optarg);
      fname = (char*)malloc( sizeof(optarg)+1 );
      sprintf(fname, "%s", optarg );
      break;

    default :
      printf("argument -%c not known\n", c ); break;
    }
  }
  
    unsigned char *image;
    int maxval = MAXVAL;
    read_pgm_image((void **)&image, &maxval, &x, &y, fname);
    unsigned char (*pixels)[x] = (unsigned char (*)[x])image;              // set the pointer to a 2d array

    printf("* means alive, the blank space means dead.\n");
    for (int i = 0; i < x; i++) {
        for (int j = 0; j < y; j++) {
            (pixels[i][j] == (unsigned char) 0)? printf("*|") : printf(" |");
        }
        printf("\n");
    }

    return 0;
}
