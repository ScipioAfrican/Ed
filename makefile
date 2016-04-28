##########################################################
#              makefile  for c++ projects 				 #
#			Please read doc/readme-makefile.txt			 #
##########################################################

EXECUTABLE_NAMES := Education_project

#Global variables
CXX := g++
shell := C:/msys/1.0/bin/sh

#Compilation flags. Please read doc/Usefull_compile_options.txt
CXXFLAGS := -m64 -Ofast -mfpmath=sse -march=core2 -funroll-loops -pipe -flto -fomit-frame-pointer -malign-double
CXX_DEBUG_FLAGS := -m64 -O0 -g2 -ggdb -mfpmath=sse -march=core2 -funroll-loops -ffast-math -flto -pipe -malign-double

#Link flags
LDFLAGS := -pipe
LD_DEBUG_FLAGS := -pipe

#Project root dirs
OBJ_ROOT_DIR := obj
BIN_ROOT_DIR := bin
SRC_ROOT_DIR := src

#Calculated source, objects and bin variables
SOURCES_SUBDIRS:= $(SRC_ROOT_DIR) $(shell ls $(SRC_ROOT_DIR) -R | grep / | sed -e 's/://')
SOURCES := $(wildcard $(addsuffix /*.c*, $(SOURCES_SUBDIRS)))
OBJECTS := $(if $(CTYPE), $(OBJ_ROOT_DIR)/$(CTYPE)/$(patsubst %.cpp,%.o,$(SOURCES)), $(OBJ_ROOT_DIR)/release/$(patsubst %.cpp,%.o,$(SOURCES)))
LTYPE := $(findstring debug, $(CTYPE))
EXECUTABLE := $(if $(LTYPE), $(BIN_ROOT_DIR)/$(EXECUTABLE_NAMES)_$(LTYPE), $(BIN_ROOT_DIR)/$(EXECUTABLE_NAMES))

# Creating exec file
$(EXECUTABLE):$(OBJECTS)
		mkdir -p $(dir $(EXECUTABLE))
ifeq ($(CTYPE),debug) 
		$(CXX) $(LD_DEBUG_FLAGS) $^ -o $@
else
		$(CXX) $(LDFLAGS) $^ -o $@
endif
		
# Creating obj file
$(OBJECTS):$(SOURCES)
		mkdir -p $(dir $(OBJECTS))
ifeq ($(CTYPE),debug) 
		$(CXX) $(CXX_DEBUG_FLAGS) -c $^ -o $@
else

		$(CXX) $(CXXFLAGS) -c $^ -o $@
endif
		
#Clearing target file 
clean: cleanobj cleanbin
				
.PHONY : cleanobj cleanbin

cleanobj: 
		rm -d -r -f $(OBJ_ROOT_DIR)
		
cleanbin:
		rm -d -r -f $(BIN_ROOT_DIR)