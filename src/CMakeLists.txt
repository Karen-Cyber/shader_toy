FILE(GLOB_RECURSE SRC_LIST ${PROJECT_SOURCE_DIR}/src/*.cpp ${PROJECT_SOURCE_DIR}/src/*.c)

IF(DEBUG)
    ADD_DEFINITIONS(-DDEBUG)
ENDIF()

IF(SRC_LIST)
    ADD_LIBRARY(mysrc STATIC ${SRC_LIST})
ENDIF()

IF(IMGUI_LIST)
    ADD_LIBRARY(imgui STATIC ${IMGUI_LIST})
ENDIF()


MESSAGE("------------------- SRC LIST -------------------")

FOREACH(src ${SRC_LIST})
    MESSAGE("${src}")
ENDFOREACH()

MESSAGE("------------------- LIST END -------------------")
