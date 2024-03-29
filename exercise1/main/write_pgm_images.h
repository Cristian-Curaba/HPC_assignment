#ifndef WRITE_PGM_IMAGES_H
#define WRITE_PGM_IMAGES_H

void write_pgm_image( void *image, int maxval, int isize, int jsize, const char *image_name);
void read_pgm_image( void **image, int *maxval, int *isize, int *jsize, const char *image_name);

#endif
