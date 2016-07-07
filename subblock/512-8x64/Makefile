CC=mpixlc_r

all: test.x

test.x: test.o
	$(CC) -o $@ $^


clean::
	rm *.x

run::
	./submit.sh
