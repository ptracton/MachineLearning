

CC = clang
RM = /bin/rm


CFLAGS = -c -Wall -Werror


all:
	clang decision_tree.c $(CFLAGS) -o decision_tree.o
	clang main.c $(CFLAGS) -o main.o
	clang $(LDFLAGS) *.o -o dt
