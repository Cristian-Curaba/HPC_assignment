# HOW IT WORKS

This folder contains just an example that proves the correctness of the algorithm (in the Static case). All the set up to run another time the experiment is given by the .sh file.
The external parameter n=10 and s=1, so all snapshots are made during every iteration of the experiment. 

The source code visualize.c and the executable visualize.x gives the possibility to visualize all the images. The syntax to run it is:

./visualize.x -x 30 -y 40 -f snapshot_S_00000

where 30 and 40 are the dimensions of the image, and 'snapshot_S_00000' is the image we want to visualize.

Finally, recall that correct_30x40.pgm is the input image, and the snapshot are enumerated from 0 up to n-1.
