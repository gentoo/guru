# This makefile only makes the unit test, benchmark and pngdetail and showpng
# utilities. It does not make the PNG codec itself as shared or static library.
# That is because:
# LodePNG itself has only 1 source file (lodepng.cpp, can be renamed to
# lodepng.c) and is intended to be included as source file in other projects and
# their build system directly.


CC ?= gcc
CXX ?= g++

CFLAGS += -W -Wall -Wextra -ansi -pedantic -Wno-unused-function
CXXFLAGS += -W -Wall -Wextra -ansi -pedantic

all: unittest benchmark pngdetail showpng lodepng.so

%.o: %.cpp
	@mkdir -p `dirname $@`
	$(CXX) -I ./ $(CXXFLAGS) -fPIC -c $< -o $@

lodepng.so: lodepng.o
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -fPIC -shared -Wl,-soname,lodepngn.so $^ -o $@

unittest: lodepng.so lodepng_util.o lodepng_unittest.o
	$(CXX) $^ $(CXXFLAGS) $(LDFLAGA) -fPIE -o $@ -L. -llodepng

benchmark: lodepng.so lodepng_benchmark.o
	$(CXX) $^ $(CXXFLAGS) $(LDFLAGS) -fPIE -lSDL -o $@ -L. -llodepng

pngdetail: lodepng.so lodepng_util.o pngdetail.o
	$(CXX) $^ $(CXXFLAGS) $(LDFLAGS) -fPIE -o $@ -L. -llodepng

showpng: lodepng.so examples/example_sdl.o
	$(CXX) -I ./ $^ $(CXXFLAGS) $(LDFLAGS) -fPIE -lSDL -o $@ -L. -llodepng

clean:
	rm -f unittest benchmark pngdetail showpng lodepng_unittest.o lodepng_benchmark.o lodepng.o lodepng_util.o pngdetail.o examples/example_sdl.o
