LIBDIRS = -L /usr/local/lib
INCDIRS = -I /usr/include -I /usr/local/include/GL -I ./shared -I/usr/include/GL
SRCPATH = ./
SHAREDPATH = ./shared/

CC = gcc
CFLAGS = $(COMPILERFLAGS) -g $(INCDIRS)
LIBS = -lglut -lGL -lGLU -lm

prog : Block

.cpp.o : 
	$(CC) -c $(CCFLAGS) $(INCDIRS) $*.cpp

.c.o :
	$(CC) -c $(CCFLAGS) $(INCDIRS) $*.c

Block.o : $(SRCPATH)Block.cpp

math3d.o : $(SHAREDPATH)math3d.cpp

gltools.o : $(SHAREDPATH)gltools.cpp

Block : Block.o gltools.o math3d.o
	$(CC) $(CFLAGS) -o Block $(LIBDIRS) $(SRCPATH)Block.cpp $(SHAREDPATH)math3d.cpp $(SHAREDPATH)gltools.cpp $(SHAREDPATH)GLee.c $(LIBS)

clean:
	rm -f *.o


