#ifndef GAME_FUNCTIONS_H
#define GAME_FUNCTIONS_H

void initialize_game(int isize, int jsize, const char *image_name, double prob);
void run_game(int isize, int jsize, const char *image_name, int total_steps , int step_for_snap, int evolution_type);
unsigned char upgrade_cell(unsigned char **pixels, int i, int j, int isize, int jsize);

#endif
