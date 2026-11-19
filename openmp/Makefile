TARGET = a.out
SRC = openmp_check_threads.cpp
GSL_INC = /opt/ohpc/pub/libs/gnu12/gsl/2.7.1/include
GSL_LIB = /opt/ohpc/pub/libs/gnu12/gsl/2.7.1/lib

CXX ?= g++
CXXFLAGS = -O2 -fopenmp -I$(GSL_INC)
LDFLAGS = -L$(GSL_LIB) -fopenmp
LIBS = -lgsl -lgslcblas -lm

$(TARGET): $(SRC)
	$(CXX) $(CXXFLAGS) $(SRC) $(LDFLAGS) $(LIBS) -o $(TARGET)

clean:
	rm -f $(TARGET)

.PHONY: clean
