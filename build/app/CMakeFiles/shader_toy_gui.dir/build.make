# CMAKE generated file: DO NOT EDIT!
# Generated by "MinGW Makefiles" Generator, CMake Version 3.19

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

SHELL = cmd.exe

# The CMake executable.
CMAKE_COMMAND = F:\CMake3.19.5\bin\cmake.exe

# The command to remove a file.
RM = F:\CMake3.19.5\bin\cmake.exe -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = I:\VScode_projects\shader_toy

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = I:\VScode_projects\shader_toy\build

# Include any dependencies generated for this target.
include app/CMakeFiles/shader_toy_gui.dir/depend.make

# Include the progress variables for this target.
include app/CMakeFiles/shader_toy_gui.dir/progress.make

# Include the compile flags for this target's objects.
include app/CMakeFiles/shader_toy_gui.dir/flags.make

app/CMakeFiles/shader_toy_gui.dir/shader_toy_gui.cpp.obj: app/CMakeFiles/shader_toy_gui.dir/flags.make
app/CMakeFiles/shader_toy_gui.dir/shader_toy_gui.cpp.obj: app/CMakeFiles/shader_toy_gui.dir/includes_CXX.rsp
app/CMakeFiles/shader_toy_gui.dir/shader_toy_gui.cpp.obj: ../app/shader_toy_gui.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=I:\VScode_projects\shader_toy\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object app/CMakeFiles/shader_toy_gui.dir/shader_toy_gui.cpp.obj"
	cd /d I:\VScode_projects\shader_toy\build\app && F:\Vs_Code\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles\shader_toy_gui.dir\shader_toy_gui.cpp.obj -c I:\VScode_projects\shader_toy\app\shader_toy_gui.cpp

app/CMakeFiles/shader_toy_gui.dir/shader_toy_gui.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/shader_toy_gui.dir/shader_toy_gui.cpp.i"
	cd /d I:\VScode_projects\shader_toy\build\app && F:\Vs_Code\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E I:\VScode_projects\shader_toy\app\shader_toy_gui.cpp > CMakeFiles\shader_toy_gui.dir\shader_toy_gui.cpp.i

app/CMakeFiles/shader_toy_gui.dir/shader_toy_gui.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/shader_toy_gui.dir/shader_toy_gui.cpp.s"
	cd /d I:\VScode_projects\shader_toy\build\app && F:\Vs_Code\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S I:\VScode_projects\shader_toy\app\shader_toy_gui.cpp -o CMakeFiles\shader_toy_gui.dir\shader_toy_gui.cpp.s

# Object files for target shader_toy_gui
shader_toy_gui_OBJECTS = \
"CMakeFiles/shader_toy_gui.dir/shader_toy_gui.cpp.obj"

# External object files for target shader_toy_gui
shader_toy_gui_EXTERNAL_OBJECTS =

../bin/shader_toy_gui.exe: app/CMakeFiles/shader_toy_gui.dir/shader_toy_gui.cpp.obj
../bin/shader_toy_gui.exe: app/CMakeFiles/shader_toy_gui.dir/build.make
../bin/shader_toy_gui.exe: ../lib/libmysrc.a
../bin/shader_toy_gui.exe: app/CMakeFiles/shader_toy_gui.dir/linklibs.rsp
../bin/shader_toy_gui.exe: app/CMakeFiles/shader_toy_gui.dir/objects1.rsp
../bin/shader_toy_gui.exe: app/CMakeFiles/shader_toy_gui.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=I:\VScode_projects\shader_toy\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ..\..\bin\shader_toy_gui.exe"
	cd /d I:\VScode_projects\shader_toy\build\app && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles\shader_toy_gui.dir\link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
app/CMakeFiles/shader_toy_gui.dir/build: ../bin/shader_toy_gui.exe

.PHONY : app/CMakeFiles/shader_toy_gui.dir/build

app/CMakeFiles/shader_toy_gui.dir/clean:
	cd /d I:\VScode_projects\shader_toy\build\app && $(CMAKE_COMMAND) -P CMakeFiles\shader_toy_gui.dir\cmake_clean.cmake
.PHONY : app/CMakeFiles/shader_toy_gui.dir/clean

app/CMakeFiles/shader_toy_gui.dir/depend:
	$(CMAKE_COMMAND) -E cmake_depends "MinGW Makefiles" I:\VScode_projects\shader_toy I:\VScode_projects\shader_toy\app I:\VScode_projects\shader_toy\build I:\VScode_projects\shader_toy\build\app I:\VScode_projects\shader_toy\build\app\CMakeFiles\shader_toy_gui.dir\DependInfo.cmake --color=$(COLOR)
.PHONY : app/CMakeFiles/shader_toy_gui.dir/depend

