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
include tests/CMakeFiles/triangle-vulkan.dir/depend.make

# Include the progress variables for this target.
include tests/CMakeFiles/triangle-vulkan.dir/progress.make

# Include the compile flags for this target's objects.
include tests/CMakeFiles/triangle-vulkan.dir/flags.make

tests/CMakeFiles/triangle-vulkan.dir/triangle-vulkan.c.obj: tests/CMakeFiles/triangle-vulkan.dir/flags.make
tests/CMakeFiles/triangle-vulkan.dir/triangle-vulkan.c.obj: tests/CMakeFiles/triangle-vulkan.dir/includes_C.rsp
tests/CMakeFiles/triangle-vulkan.dir/triangle-vulkan.c.obj: ../tests/triangle-vulkan.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object tests/CMakeFiles/triangle-vulkan.dir/triangle-vulkan.c.obj"
	cd /d I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\tests && F:\Vs_Code\mingw64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles\triangle-vulkan.dir\triangle-vulkan.c.obj -c I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\tests\triangle-vulkan.c

tests/CMakeFiles/triangle-vulkan.dir/triangle-vulkan.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/triangle-vulkan.dir/triangle-vulkan.c.i"
	cd /d I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\tests && F:\Vs_Code\mingw64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\tests\triangle-vulkan.c > CMakeFiles\triangle-vulkan.dir\triangle-vulkan.c.i

tests/CMakeFiles/triangle-vulkan.dir/triangle-vulkan.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/triangle-vulkan.dir/triangle-vulkan.c.s"
	cd /d I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\tests && F:\Vs_Code\mingw64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\tests\triangle-vulkan.c -o CMakeFiles\triangle-vulkan.dir\triangle-vulkan.c.s

tests/CMakeFiles/triangle-vulkan.dir/__/deps/glad_vulkan.c.obj: tests/CMakeFiles/triangle-vulkan.dir/flags.make
tests/CMakeFiles/triangle-vulkan.dir/__/deps/glad_vulkan.c.obj: tests/CMakeFiles/triangle-vulkan.dir/includes_C.rsp
tests/CMakeFiles/triangle-vulkan.dir/__/deps/glad_vulkan.c.obj: ../deps/glad_vulkan.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object tests/CMakeFiles/triangle-vulkan.dir/__/deps/glad_vulkan.c.obj"
	cd /d I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\tests && F:\Vs_Code\mingw64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles\triangle-vulkan.dir\__\deps\glad_vulkan.c.obj -c I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\deps\glad_vulkan.c

tests/CMakeFiles/triangle-vulkan.dir/__/deps/glad_vulkan.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/triangle-vulkan.dir/__/deps/glad_vulkan.c.i"
	cd /d I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\tests && F:\Vs_Code\mingw64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\deps\glad_vulkan.c > CMakeFiles\triangle-vulkan.dir\__\deps\glad_vulkan.c.i

tests/CMakeFiles/triangle-vulkan.dir/__/deps/glad_vulkan.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/triangle-vulkan.dir/__/deps/glad_vulkan.c.s"
	cd /d I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\tests && F:\Vs_Code\mingw64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\deps\glad_vulkan.c -o CMakeFiles\triangle-vulkan.dir\__\deps\glad_vulkan.c.s

# Object files for target triangle-vulkan
triangle__vulkan_OBJECTS = \
"CMakeFiles/triangle-vulkan.dir/triangle-vulkan.c.obj" \
"CMakeFiles/triangle-vulkan.dir/__/deps/glad_vulkan.c.obj"

# External object files for target triangle-vulkan
triangle__vulkan_EXTERNAL_OBJECTS =

tests/triangle-vulkan.exe: tests/CMakeFiles/triangle-vulkan.dir/triangle-vulkan.c.obj
tests/triangle-vulkan.exe: tests/CMakeFiles/triangle-vulkan.dir/__/deps/glad_vulkan.c.obj
tests/triangle-vulkan.exe: tests/CMakeFiles/triangle-vulkan.dir/build.make
tests/triangle-vulkan.exe: src/libglfw3.a
tests/triangle-vulkan.exe: tests/CMakeFiles/triangle-vulkan.dir/linklibs.rsp
tests/triangle-vulkan.exe: tests/CMakeFiles/triangle-vulkan.dir/objects1.rsp
tests/triangle-vulkan.exe: tests/CMakeFiles/triangle-vulkan.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking C executable triangle-vulkan.exe"
	cd /d I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\tests && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles\triangle-vulkan.dir\link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
tests/CMakeFiles/triangle-vulkan.dir/build: tests/triangle-vulkan.exe

.PHONY : tests/CMakeFiles/triangle-vulkan.dir/build

tests/CMakeFiles/triangle-vulkan.dir/clean:
	cd /d I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\tests && $(CMAKE_COMMAND) -P CMakeFiles\triangle-vulkan.dir\cmake_clean.cmake
.PHONY : tests/CMakeFiles/triangle-vulkan.dir/clean

tests/CMakeFiles/triangle-vulkan.dir/depend:
	$(CMAKE_COMMAND) -E cmake_depends "MinGW Makefiles" I:\VScode_projects\shader_toy\third_party\glfw-3.3.8 I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\tests I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\tests I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\tests\CMakeFiles\triangle-vulkan.dir\DependInfo.cmake --color=$(COLOR)
.PHONY : tests/CMakeFiles/triangle-vulkan.dir/depend

