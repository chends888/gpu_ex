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
include CMakeFiles/locsea-bb-opt.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/locsea-bb-opt.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/locsea-bb-opt.dir/flags.make

CMakeFiles/locsea-bb-opt.dir/tsp-locsea-bb.cpp.o: CMakeFiles/locsea-bb-opt.dir/flags.make
CMakeFiles/locsea-bb-opt.dir/tsp-locsea-bb.cpp.o: ../tsp-locsea-bb.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/locsea-bb-opt.dir/tsp-locsea-bb.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/locsea-bb-opt.dir/tsp-locsea-bb.cpp.o -c /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/tsp-locsea-bb.cpp

CMakeFiles/locsea-bb-opt.dir/tsp-locsea-bb.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/locsea-bb-opt.dir/tsp-locsea-bb.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/tsp-locsea-bb.cpp > CMakeFiles/locsea-bb-opt.dir/tsp-locsea-bb.cpp.i

CMakeFiles/locsea-bb-opt.dir/tsp-locsea-bb.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/locsea-bb-opt.dir/tsp-locsea-bb.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/tsp-locsea-bb.cpp -o CMakeFiles/locsea-bb-opt.dir/tsp-locsea-bb.cpp.s

# Object files for target locsea-bb-opt
locsea__bb__opt_OBJECTS = \
"CMakeFiles/locsea-bb-opt.dir/tsp-locsea-bb.cpp.o"

# External object files for target locsea-bb-opt
locsea__bb__opt_EXTERNAL_OBJECTS =

locsea-bb-opt: CMakeFiles/locsea-bb-opt.dir/tsp-locsea-bb.cpp.o
locsea-bb-opt: CMakeFiles/locsea-bb-opt.dir/build.make
locsea-bb-opt: /usr/lib/gcc/x86_64-linux-gnu/8/libgomp.so
locsea-bb-opt: /usr/lib/x86_64-linux-gnu/libpthread.so
locsea-bb-opt: CMakeFiles/locsea-bb-opt.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable locsea-bb-opt"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/locsea-bb-opt.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/locsea-bb-opt.dir/build: locsea-bb-opt

.PHONY : CMakeFiles/locsea-bb-opt.dir/build

CMakeFiles/locsea-bb-opt.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/locsea-bb-opt.dir/cmake_clean.cmake
.PHONY : CMakeFiles/locsea-bb-opt.dir/clean

CMakeFiles/locsea-bb-opt.dir/depend:
	cd /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/chends/Desktop/Insper/2019_2/Supercomp/proj2 /home/chends/Desktop/Insper/2019_2/Supercomp/proj2 /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build /home/chends/Desktop/Insper/2019_2/Supercomp/proj2/build/CMakeFiles/locsea-bb-opt.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/locsea-bb-opt.dir/depend

