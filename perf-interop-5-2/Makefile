all:
	gfortran -c -g -O2 -fopenmp -mavx2 send.F90
	gcc -c -g -O2 -fopenmp -mavx2 main.c
	gfortran -g -O2 -fopenmp -mavx2 send.o main.o
clean:
	rm *.o a.out
