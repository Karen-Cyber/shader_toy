AUX_SOURCE_DIRECTORY(. SRC_LIST)
AUX_SOURCE_DIRECTORY(ImGui IMGUI_LIST)

IF(DEBUG)
    ADD_DEFINITIONS(-DDEBUG)
ENDIF()

IF(SRC_LIST)
    ADD_LIBRARY(mysrc STATIC ${SRC_LIST})
ENDIF()

IF(IMGUI_LIST)
    ADD_LIBRARY(imgui STATIC ${IMGUI_LIST})
ENDIF()

MESSAGE("following source files will be linked into library:")
MESSAGE("------------------- SRC LIST -------------------")

FOREACH(src ${SRC_LIST})
    MESSAGE("${src}")
ENDFOREACH()

MESSAGE("------------------- LIST END -------------------")
