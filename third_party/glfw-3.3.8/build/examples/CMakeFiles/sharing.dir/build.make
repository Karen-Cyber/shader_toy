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
CMAKE_SOURCE_DIR = I:\VScode_projects\shader_toy\third_party\glfw-3.3.8

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build

# Include any dependencies generated for this target.
include examples/CMakeFiles/sharing.dir/depend.make

# Include the progress variables for this target.
include examples/CMakeFiles/sharing.dir/progress.make

# Include the compile flags for this target's objects.
include examples/CMakeFiles/sharing.dir/flags.make

examples/CMakeFiles/sharing.dir/sharing.c.obj: examples/CMakeFiles/sharing.dir/flags.make
examples/CMakeFiles/sharing.dir/sharing.c.obj: examples/CMakeFiles/sharing.dir/includes_C.rsp
examples/CMakeFiles/sharing.dir/sharing.c.obj: ../examples/sharing.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object examples/CMakeFiles/sharing.dir/sharing.c.obj"
	cd /d I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\examples && F:\Vs_Code\mingw64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles\sharing.dir\sharing.c.obj -c I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\examples\sharing.c

examples/CMakeFiles/sharing.dir/sharing.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/sharing.dir/sharing.c.i"
	cd /d I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\examples && F:\Vs_Code\mingw64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\examples\sharing.c > CMakeFiles\sharing.dir\sharing.c.i

examples/CMakeFiles/sharing.dir/sharing.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/sharing.dir/sharing.c.s"
	cd /d I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\examples && F:\Vs_Code\mingw64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\examples\sharing.c -o CMakeFiles\sharing.dir\sharing.c.s

examples/CMakeFiles/sharing.dir/glfw.rc.obj: examples/CMakeFiles/sharing.dir/flags.make
examples/CMakeFiles/sharing.dir/glfw.rc.obj: ../examples/glfw.rc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building RC object examples/CMakeFiles/sharing.dir/glfw.rc.obj"
	cd /d I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\examples && F:\Vs_Code\mingw64\bin\windres.exe -O coff $(RC_DEFINES) $(RC_INCLUDES) $(RC_FLAGS) I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\examples\glfw.rc CMakeFiles\sharing.dir\glfw.rc.obj

examples/CMakeFiles/sharing.dir/__/deps/glad_gl.c.obj: examples/CMakeFiles/sharing.dir/flags.make
examples/CMakeFiles/sharing.dir/__/deps/glad_gl.c.obj: examples/CMakeFiles/sharing.dir/includes_C.rsp
examples/CMakeFiles/sharing.dir/__/deps/glad_gl.c.obj: ../deps/glad_gl.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object examples/CMakeFiles/sharing.dir/__/deps/glad_gl.c.obj"
	cd /d I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\examples && F:\Vs_Code\mingw64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles\sharing.dir\__\deps\glad_gl.c.obj -c I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\deps\glad_gl.c

examples/CMakeFiles/sharing.dir/__/deps/glad_gl.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/sharing.dir/__/deps/glad_gl.c.i"
	cd /d I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\examples && F:\Vs_Code\mingw64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\deps\glad_gl.c > CMakeFiles\sharing.dir\__\deps\glad_gl.c.i

examples/CMakeFiles/sharing.dir/__/deps/glad_gl.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/sharing.dir/__/deps/glad_gl.c.s"
	cd /d I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\examples && F:\Vs_Code\mingw64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\deps\glad_gl.c -o CMakeFiles\sharing.dir\__\deps\glad_gl.c.s

# Object files for target sharing
sharing_OBJECTS = \
"CMakeFiles/sharing.dir/sharing.c.obj" \
"CMakeFiles/sharing.dir/glfw.rc.obj" \
"CMakeFiles/sharing.dir/__/deps/glad_gl.c.obj"

# External object files for target sharing
sharing_EXTERNAL_OBJECTS =

examples/sharing.exe: examples/CMakeFiles/sharing.dir/sharing.c.obj
examples/sharing.exe: examples/CMakeFiles/sharing.dir/glfw.rc.obj
examples/sharing.exe: examples/CMakeFiles/sharing.dir/__/deps/glad_gl.c.obj
examples/sharing.exe: examples/CMakeFiles/sharing.dir/build.make
examples/sharing.exe: src/libglfw3.a
examples/sharing.exe: examples/CMakeFiles/sharing.dir/linklibs.rsp
examples/sharing.exe: examples/CMakeFiles/sharing.dir/objects1.rsp
examples/sharing.exe: examples/CMakeFiles/sharing.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking C executable sharing.exe"
	cd /d I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\examples && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles\sharing.dir\link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/CMakeFiles/sharing.dir/build: examples/sharing.exe

.PHONY : examples/CMakeFiles/sharing.dir/build

examples/CMakeFiles/sharing.dir/clean:
	cd /d I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\examples && $(CMAKE_COMMAND) -P CMakeFiles\sharing.dir\cmake_clean.cmake
.PHONY : examples/CMakeFiles/sharing.dir/clean

examples/CMakeFiles/sharing.dir/depend:
	$(CMAKE_COMMAND) -E cmake_depends "MinGW Makefiles" I:\VScode_projects\shader_toy\third_party\glfw-3.3.8 I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\examples I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\examples I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\examples\CMakeFiles\sharing.dir\DependInfo.cmake --color=$(COLOR)
.PHONY : examples/CMakeFiles/sharing.dir/depend

