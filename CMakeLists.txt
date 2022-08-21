CMAKE_MINIMUM_REQUIRED(VERSION 3.19)
PROJECT(shader_toy)

SET(CMAKE_BUILD_TYPE "Debug")
SET(CMAKE_CXX_STANDARD 14)
SET(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
SET(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/lib)

INCLUDE_DIRECTORIES(${PROJECT_SOURCE_DIR}/include)
   LINK_DIRECTORIES(${PROJECT_SOURCE_DIR}/lib)

SET(GL_LIB opengl32)

OPTION(DEBUG "debug switch" OFF)
OPTION(GEN_SHARED_LIB "generate shared lib .so" OFF)
OPTION(GEN_STATIC_LIB "generate static lib .a" ON)

ADD_SUBDIRECTORY(${PROJECT_SOURCE_DIR}/src)
ADD_SUBDIRECTORY(${PROJECT_SOURCE_DIR}/app)