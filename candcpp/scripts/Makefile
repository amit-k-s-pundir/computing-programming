objects = s.o

s: $(objects)
	g++ -o s $(objects) s.cpp -L${LIB_DIR} -I{INCLUDE_DIR}

s.o: s.cpp
	g++ -o s s.cpp -L/opt/boost/lib -I/opt/boost/include

clean:
	rm s $(objects)
