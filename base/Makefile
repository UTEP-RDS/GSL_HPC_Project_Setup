TARGET = a.out
SRC = main.cpp
TARGET = a.out
SRC = main.cpp
GSL_INC = /opt/ohpc/pub/libs/gnu12/gsl/2.7.1/include
GSL_LIB = /opt/ohpc/pub/libs/gnu12/gsl/2.7.1/lib

$(TARGET): $(SRC)
	g++ -I$(GSL_INC) -L$(GSL_LIB) $(SRC) -lgsl -lgslcblas -lm -o $(TARGET)


