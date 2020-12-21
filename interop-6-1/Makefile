all:
	gfortran -c -g -O3 send.F90
	gcc -c -g -O3 main.c
	gfortran -g -O3 send.o main.o
clean:
	rm *.o *.mod a.out
