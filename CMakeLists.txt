CMAKE_MINIMUM_REQUIRED(VERSION 3.19)
PROJECT(shader_toy)

SET(CMAKE_BUILD_TYPE "Debug")
SET(CMAKE_CXX_STANDARD 14)
SET(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
SET(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/lib)

# find all include directories
MACRO(FIND_HEADER_DIRECTORIES return_list)
    FILE(GLOB_RECURSE new_list *.h)
    SET(dir_list "")
    FOREACH(file_path ${new_list})
        GET_FILENAME_COMPONENT(dir_path ${file_path} PATH)
        SET(dir_list ${dir_list} ${dir_path})
    ENDFOREACH()
    LIST(REMOVE_DUPLICATES dir_list)
    SET(${return_list} ${dir_list})
ENDMACRO()
FIND_HEADER_DIRECTORIES(return_list)
INCLUDE_DIRECTORIES(${return_list})
# additional include,  so that when you include  some header
# you could just enter file name, or you can enter the whole
# path or part of the path to indicate the header file.
INCLUDE_DIRECTORIES(${PROJECT_SOURCE_DIR}/include)
MESSAGE("------------------- HEAD LIST -------------------")
FOREACH(header_path ${return_list})
    MESSAGE("${header_path}")
ENDFOREACH()
MESSAGE("------------------- LSIT  END -------------------")

LINK_DIRECTORIES(${PROJECT_SOURCE_DIR}/lib)

SET(GL_LIB opengl32)

OPTION(DEBUG "debug switch" OFF)
OPTION(GEN_SHARED_LIB "generate shared lib .so" OFF)
OPTION(GEN_STATIC_LIB "generate static lib .a" ON)

ADD_SUBDIRECTORY(${PROJECT_SOURCE_DIR}/src)
ADD_SUBDIRECTORY(${PROJECT_SOURCE_DIR}/app)