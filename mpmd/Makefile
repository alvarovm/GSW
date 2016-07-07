CC=mpixlc_r

all: exe1.x exe2.x

exe1.x: exe1.o
	$(CC) -o $@ $^

exe2.x: exe2.o
	$(CC) -o $@ $^

clean::
	rm *.o exe1.x exe2.x

run::
	./submit.sh
