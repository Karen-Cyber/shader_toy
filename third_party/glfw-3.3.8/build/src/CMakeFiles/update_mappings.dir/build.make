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

# Utility rule file for update_mappings.

# Include the progress variables for this target.
include src/CMakeFiles/update_mappings.dir/progress.make

src/CMakeFiles/update_mappings:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Updating gamepad mappings from upstream repository"
	cd /d I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\src && F:\CMake3.19.5\bin\cmake.exe -P I:/VScode_projects/shader_toy/third_party/glfw-3.3.8/CMake/GenerateMappings.cmake mappings.h.in mappings.h

update_mappings: src/CMakeFiles/update_mappings
update_mappings: src/CMakeFiles/update_mappings.dir/build.make

.PHONY : update_mappings

# Rule to build all files generated by this target.
src/CMakeFiles/update_mappings.dir/build: update_mappings

.PHONY : src/CMakeFiles/update_mappings.dir/build

src/CMakeFiles/update_mappings.dir/clean:
	cd /d I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\src && $(CMAKE_COMMAND) -P CMakeFiles\update_mappings.dir\cmake_clean.cmake
.PHONY : src/CMakeFiles/update_mappings.dir/clean

src/CMakeFiles/update_mappings.dir/depend:
	$(CMAKE_COMMAND) -E cmake_depends "MinGW Makefiles" I:\VScode_projects\shader_toy\third_party\glfw-3.3.8 I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\src I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\src I:\VScode_projects\shader_toy\third_party\glfw-3.3.8\build\src\CMakeFiles\update_mappings.dir\DependInfo.cmake --color=$(COLOR)
.PHONY : src/CMakeFiles/update_mappings.dir/depend

