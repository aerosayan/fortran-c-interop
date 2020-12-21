all:
	gfortran -c send.F90
	gcc -c main.c
	gfortran send.o main.o
clean:
	rm *.o a.out
