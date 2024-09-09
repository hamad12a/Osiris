# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.30

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /workspaces/cmake-3.30.3-linux-x86_64/bin/cmake

# The command to remove a file.
RM = /workspaces/cmake-3.30.3-linux-x86_64/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /workspaces/Osiris

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /workspaces/Osiris/build

# Include any dependencies generated for this target.
include Source/CMakeFiles/Osiris.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include Source/CMakeFiles/Osiris.dir/compiler_depend.make

# Include the progress variables for this target.
include Source/CMakeFiles/Osiris.dir/progress.make

# Include the compile flags for this target's objects.
include Source/CMakeFiles/Osiris.dir/flags.make

Source/CMakeFiles/Osiris.dir/dllmain.cpp.o: Source/CMakeFiles/Osiris.dir/flags.make
Source/CMakeFiles/Osiris.dir/dllmain.cpp.o: /workspaces/Osiris/Source/dllmain.cpp
Source/CMakeFiles/Osiris.dir/dllmain.cpp.o: Source/CMakeFiles/Osiris.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/workspaces/Osiris/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object Source/CMakeFiles/Osiris.dir/dllmain.cpp.o"
	cd /workspaces/Osiris/build/Source && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT Source/CMakeFiles/Osiris.dir/dllmain.cpp.o -MF CMakeFiles/Osiris.dir/dllmain.cpp.o.d -o CMakeFiles/Osiris.dir/dllmain.cpp.o -c /workspaces/Osiris/Source/dllmain.cpp

Source/CMakeFiles/Osiris.dir/dllmain.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/Osiris.dir/dllmain.cpp.i"
	cd /workspaces/Osiris/build/Source && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /workspaces/Osiris/Source/dllmain.cpp > CMakeFiles/Osiris.dir/dllmain.cpp.i

Source/CMakeFiles/Osiris.dir/dllmain.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/Osiris.dir/dllmain.cpp.s"
	cd /workspaces/Osiris/build/Source && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /workspaces/Osiris/Source/dllmain.cpp -o CMakeFiles/Osiris.dir/dllmain.cpp.s

Source/CMakeFiles/Osiris.dir/LinuxEndpoints.s.o: Source/CMakeFiles/Osiris.dir/flags.make
Source/CMakeFiles/Osiris.dir/LinuxEndpoints.s.o: /workspaces/Osiris/Source/LinuxEndpoints.s
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/workspaces/Osiris/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building ASM-ATT object Source/CMakeFiles/Osiris.dir/LinuxEndpoints.s.o"
	cd /workspaces/Osiris/build/Source && /usr/bin/as $(ASM-ATT_INCLUDES) $(ASM-ATT_FLAGS) -o CMakeFiles/Osiris.dir/LinuxEndpoints.s.o /workspaces/Osiris/Source/LinuxEndpoints.s

# Object files for target Osiris
Osiris_OBJECTS = \
"CMakeFiles/Osiris.dir/dllmain.cpp.o" \
"CMakeFiles/Osiris.dir/LinuxEndpoints.s.o"

# External object files for target Osiris
Osiris_EXTERNAL_OBJECTS =

Source/libOsiris.so: Source/CMakeFiles/Osiris.dir/dllmain.cpp.o
Source/libOsiris.so: Source/CMakeFiles/Osiris.dir/LinuxEndpoints.s.o
Source/libOsiris.so: Source/CMakeFiles/Osiris.dir/build.make
Source/libOsiris.so: Source/CMakeFiles/Osiris.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/workspaces/Osiris/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX shared library libOsiris.so"
	cd /workspaces/Osiris/build/Source && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/Osiris.dir/link.txt --verbose=$(VERBOSE)
	cd /workspaces/Osiris/build/Source && /usr/bin/strip /workspaces/Osiris/build/Source/libOsiris.so

# Rule to build all files generated by this target.
Source/CMakeFiles/Osiris.dir/build: Source/libOsiris.so
.PHONY : Source/CMakeFiles/Osiris.dir/build

Source/CMakeFiles/Osiris.dir/clean:
	cd /workspaces/Osiris/build/Source && $(CMAKE_COMMAND) -P CMakeFiles/Osiris.dir/cmake_clean.cmake
.PHONY : Source/CMakeFiles/Osiris.dir/clean

Source/CMakeFiles/Osiris.dir/depend:
	cd /workspaces/Osiris/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /workspaces/Osiris /workspaces/Osiris/Source /workspaces/Osiris/build /workspaces/Osiris/build/Source /workspaces/Osiris/build/Source/CMakeFiles/Osiris.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : Source/CMakeFiles/Osiris.dir/depend

