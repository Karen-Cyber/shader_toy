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
include src/CMakeFiles/mysrc.dir/depend.make

# Include the progress variables for this target.
include src/CMakeFiles/mysrc.dir/progress.make

# Include the compile flags for this target's objects.
include src/CMakeFiles/mysrc.dir/flags.make

src/CMakeFiles/mysrc.dir/glad.c.obj: src/CMakeFiles/mysrc.dir/flags.make
src/CMakeFiles/mysrc.dir/glad.c.obj: src/CMakeFiles/mysrc.dir/includes_C.rsp
src/CMakeFiles/mysrc.dir/glad.c.obj: ../src/glad.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=I:\VScode_projects\shader_toy\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object src/CMakeFiles/mysrc.dir/glad.c.obj"
	cd /d I:\VScode_projects\shader_toy\build\src && F:\Vs_Code\mingw64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles\mysrc.dir\glad.c.obj -c I:\VScode_projects\shader_toy\src\glad.c

src/CMakeFiles/mysrc.dir/glad.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/mysrc.dir/glad.c.i"
	cd /d I:\VScode_projects\shader_toy\build\src && F:\Vs_Code\mingw64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E I:\VScode_projects\shader_toy\src\glad.c > CMakeFiles\mysrc.dir\glad.c.i

src/CMakeFiles/mysrc.dir/glad.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/mysrc.dir/glad.c.s"
	cd /d I:\VScode_projects\shader_toy\build\src && F:\Vs_Code\mingw64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S I:\VScode_projects\shader_toy\src\glad.c -o CMakeFiles\mysrc.dir\glad.c.s

src/CMakeFiles/mysrc.dir/shader.cpp.obj: src/CMakeFiles/mysrc.dir/flags.make
src/CMakeFiles/mysrc.dir/shader.cpp.obj: src/CMakeFiles/mysrc.dir/includes_CXX.rsp
src/CMakeFiles/mysrc.dir/shader.cpp.obj: ../src/shader.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=I:\VScode_projects\shader_toy\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object src/CMakeFiles/mysrc.dir/shader.cpp.obj"
	cd /d I:\VScode_projects\shader_toy\build\src && F:\Vs_Code\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles\mysrc.dir\shader.cpp.obj -c I:\VScode_projects\shader_toy\src\shader.cpp

src/CMakeFiles/mysrc.dir/shader.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/mysrc.dir/shader.cpp.i"
	cd /d I:\VScode_projects\shader_toy\build\src && F:\Vs_Code\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E I:\VScode_projects\shader_toy\src\shader.cpp > CMakeFiles\mysrc.dir\shader.cpp.i

src/CMakeFiles/mysrc.dir/shader.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/mysrc.dir/shader.cpp.s"
	cd /d I:\VScode_projects\shader_toy\build\src && F:\Vs_Code\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S I:\VScode_projects\shader_toy\src\shader.cpp -o CMakeFiles\mysrc.dir\shader.cpp.s

src/CMakeFiles/mysrc.dir/stb_image.cpp.obj: src/CMakeFiles/mysrc.dir/flags.make
src/CMakeFiles/mysrc.dir/stb_image.cpp.obj: src/CMakeFiles/mysrc.dir/includes_CXX.rsp
src/CMakeFiles/mysrc.dir/stb_image.cpp.obj: ../src/stb_image.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=I:\VScode_projects\shader_toy\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object src/CMakeFiles/mysrc.dir/stb_image.cpp.obj"
	cd /d I:\VScode_projects\shader_toy\build\src && F:\Vs_Code\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles\mysrc.dir\stb_image.cpp.obj -c I:\VScode_projects\shader_toy\src\stb_image.cpp

src/CMakeFiles/mysrc.dir/stb_image.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/mysrc.dir/stb_image.cpp.i"
	cd /d I:\VScode_projects\shader_toy\build\src && F:\Vs_Code\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E I:\VScode_projects\shader_toy\src\stb_image.cpp > CMakeFiles\mysrc.dir\stb_image.cpp.i

src/CMakeFiles/mysrc.dir/stb_image.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/mysrc.dir/stb_image.cpp.s"
	cd /d I:\VScode_projects\shader_toy\build\src && F:\Vs_Code\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S I:\VScode_projects\shader_toy\src\stb_image.cpp -o CMakeFiles\mysrc.dir\stb_image.cpp.s

# Object files for target mysrc
mysrc_OBJECTS = \
"CMakeFiles/mysrc.dir/glad.c.obj" \
"CMakeFiles/mysrc.dir/shader.cpp.obj" \
"CMakeFiles/mysrc.dir/stb_image.cpp.obj"

# External object files for target mysrc
mysrc_EXTERNAL_OBJECTS =

../lib/libmysrc.a: src/CMakeFiles/mysrc.dir/glad.c.obj
../lib/libmysrc.a: src/CMakeFiles/mysrc.dir/shader.cpp.obj
../lib/libmysrc.a: src/CMakeFiles/mysrc.dir/stb_image.cpp.obj
../lib/libmysrc.a: src/CMakeFiles/mysrc.dir/build.make
../lib/libmysrc.a: src/CMakeFiles/mysrc.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=I:\VScode_projects\shader_toy\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking CXX static library ..\..\lib\libmysrc.a"
	cd /d I:\VScode_projects\shader_toy\build\src && $(CMAKE_COMMAND) -P CMakeFiles\mysrc.dir\cmake_clean_target.cmake
	cd /d I:\VScode_projects\shader_toy\build\src && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles\mysrc.dir\link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/CMakeFiles/mysrc.dir/build: ../lib/libmysrc.a

.PHONY : src/CMakeFiles/mysrc.dir/build

src/CMakeFiles/mysrc.dir/clean:
	cd /d I:\VScode_projects\shader_toy\build\src && $(CMAKE_COMMAND) -P CMakeFiles\mysrc.dir\cmake_clean.cmake
.PHONY : src/CMakeFiles/mysrc.dir/clean

src/CMakeFiles/mysrc.dir/depend:
	$(CMAKE_COMMAND) -E cmake_depends "MinGW Makefiles" I:\VScode_projects\shader_toy I:\VScode_projects\shader_toy\src I:\VScode_projects\shader_toy\build I:\VScode_projects\shader_toy\build\src I:\VScode_projects\shader_toy\build\src\CMakeFiles\mysrc.dir\DependInfo.cmake --color=$(COLOR)
.PHONY : src/CMakeFiles/mysrc.dir/depend
