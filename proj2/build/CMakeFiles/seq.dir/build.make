# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.13

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/chends/Desktop/Insper/2019_2/Supercomp/proj2

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build

# Include any dependencies generated for this target.
include CMakeFiles/seq.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/seq.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/seq.dir/flags.make

CMakeFiles/seq.dir/tsp-seq.cpp.o: CMakeFiles/seq.dir/flags.make
CMakeFiles/seq.dir/tsp-seq.cpp.o: ../tsp-seq.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/seq.dir/tsp-seq.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/seq.dir/tsp-seq.cpp.o -c /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/tsp-seq.cpp

CMakeFiles/seq.dir/tsp-seq.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/seq.dir/tsp-seq.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/tsp-seq.cpp > CMakeFiles/seq.dir/tsp-seq.cpp.i

CMakeFiles/seq.dir/tsp-seq.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/seq.dir/tsp-seq.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/tsp-seq.cpp -o CMakeFiles/seq.dir/tsp-seq.cpp.s

# Object files for target seq
seq_OBJECTS = \
"CMakeFiles/seq.dir/tsp-seq.cpp.o"

# External object files for target seq
seq_EXTERNAL_OBJECTS =

seq: CMakeFiles/seq.dir/tsp-seq.cpp.o
seq: CMakeFiles/seq.dir/build.make
seq: CMakeFiles/seq.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable seq"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/seq.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/seq.dir/build: seq

.PHONY : CMakeFiles/seq.dir/build

CMakeFiles/seq.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/seq.dir/cmake_clean.cmake
.PHONY : CMakeFiles/seq.dir/clean

CMakeFiles/seq.dir/depend:
	cd /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/chends/Desktop/Insper/2019_2/Supercomp/proj2 /home/chends/Desktop/Insper/2019_2/Supercomp/proj2 /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build/CMakeFiles/seq.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/seq.dir/depend

