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
include CMakeFiles/par1opt.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/par1opt.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/par1opt.dir/flags.make

CMakeFiles/par1opt.dir/tsp-par1Opt.cpp.o: CMakeFiles/par1opt.dir/flags.make
CMakeFiles/par1opt.dir/tsp-par1Opt.cpp.o: ../tsp-par1Opt.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/par1opt.dir/tsp-par1Opt.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/par1opt.dir/tsp-par1Opt.cpp.o -c /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/tsp-par1Opt.cpp

CMakeFiles/par1opt.dir/tsp-par1Opt.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/par1opt.dir/tsp-par1Opt.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/tsp-par1Opt.cpp > CMakeFiles/par1opt.dir/tsp-par1Opt.cpp.i

CMakeFiles/par1opt.dir/tsp-par1Opt.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/par1opt.dir/tsp-par1Opt.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/tsp-par1Opt.cpp -o CMakeFiles/par1opt.dir/tsp-par1Opt.cpp.s

# Object files for target par1opt
par1opt_OBJECTS = \
"CMakeFiles/par1opt.dir/tsp-par1Opt.cpp.o"

# External object files for target par1opt
par1opt_EXTERNAL_OBJECTS =

par1opt: CMakeFiles/par1opt.dir/tsp-par1Opt.cpp.o
par1opt: CMakeFiles/par1opt.dir/build.make
par1opt: /usr/lib/gcc/x86_64-linux-gnu/8/libgomp.so
par1opt: /usr/lib/x86_64-linux-gnu/libpthread.so
par1opt: CMakeFiles/par1opt.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable par1opt"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/par1opt.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/par1opt.dir/build: par1opt

.PHONY : CMakeFiles/par1opt.dir/build

CMakeFiles/par1opt.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/par1opt.dir/cmake_clean.cmake
.PHONY : CMakeFiles/par1opt.dir/clean

CMakeFiles/par1opt.dir/depend:
	cd /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/chends/Desktop/Insper/2019_2/Supercomp/proj2 /home/chends/Desktop/Insper/2019_2/Supercomp/proj2 /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build/CMakeFiles/par1opt.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/par1opt.dir/depend
