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
include CMakeFiles/seqopt.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/seqopt.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/seqopt.dir/flags.make

CMakeFiles/seqopt.dir/tsp-seqOpt.cpp.o: CMakeFiles/seqopt.dir/flags.make
CMakeFiles/seqopt.dir/tsp-seqOpt.cpp.o: ../tsp-seqOpt.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/seqopt.dir/tsp-seqOpt.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/seqopt.dir/tsp-seqOpt.cpp.o -c /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/tsp-seqOpt.cpp

CMakeFiles/seqopt.dir/tsp-seqOpt.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/seqopt.dir/tsp-seqOpt.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/tsp-seqOpt.cpp > CMakeFiles/seqopt.dir/tsp-seqOpt.cpp.i

CMakeFiles/seqopt.dir/tsp-seqOpt.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/seqopt.dir/tsp-seqOpt.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/tsp-seqOpt.cpp -o CMakeFiles/seqopt.dir/tsp-seqOpt.cpp.s

# Object files for target seqopt
seqopt_OBJECTS = \
"CMakeFiles/seqopt.dir/tsp-seqOpt.cpp.o"

# External object files for target seqopt
seqopt_EXTERNAL_OBJECTS =

seqopt: CMakeFiles/seqopt.dir/tsp-seqOpt.cpp.o
seqopt: CMakeFiles/seqopt.dir/build.make
seqopt: CMakeFiles/seqopt.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable seqopt"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/seqopt.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/seqopt.dir/build: seqopt

.PHONY : CMakeFiles/seqopt.dir/build

CMakeFiles/seqopt.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/seqopt.dir/cmake_clean.cmake
.PHONY : CMakeFiles/seqopt.dir/clean

CMakeFiles/seqopt.dir/depend:
	cd /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/chends/Desktop/Insper/2019_2/Supercomp/proj2 /home/chends/Desktop/Insper/2019_2/Supercomp/proj2 /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build/CMakeFiles/seqopt.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/seqopt.dir/depend

