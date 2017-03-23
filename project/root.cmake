#               Copyright Marek Dalewski 2017
# Distributed under the Boost Software License, Version 1.0.
#     (See accompanying file LICENSE_1_0.txt or copy at
#           http://www.boost.org/LICENSE_1_0.txt)



##### Project ------------------------------------------------------------------

# Project name
project(popt)



##### Source files and directories ---------------------------------------------

# Project source files
set(project.source.main "${CMAKE_CURRENT_LIST_DIR}/main.cpp")
file(
    GLOB_RECURSE tmp
    RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_LIST_DIR}/src/*.c
    ${CMAKE_CURRENT_LIST_DIR}/src/*.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/*.h
    ${CMAKE_CURRENT_LIST_DIR}/src/*.hpp
)
list(APPEND project.source "${tmp}")

# Project header files locations
list(APPEND project.include "${CMAKE_CURRENT_LIST_DIR}/include" "${CMAKE_CURRENT_LIST_DIR}/src")



##### Flags and definitions ----------------------------------------------------

# Compiler definitions
list(APPEND project.define)
# list(APPEND project.define.debug                )
# list(APPEND project.define.release        NDEBUG)
# list(APPEND project.define.relwithdebinfo NDEBUG)
# list(APPEND project.define.minsizerel     NDEBUG)

# Compiler flags
list(APPEND project.cflags -Wall -std=gnu++17 -std=c++17)
# list(APPEND project.cflags.debug          -O0 -g)
# list(APPEND project.cflags.release        -O3   )
# list(APPEND project.cflags.relwithdebinfo -O2 -g)
# list(APPEND project.cflags.minsizerel     -Os   )

if(MINGW OR MSYS OR CYGWIN OR CMAKE_COMPILER_IS_GNUCXX)
    list(APPEND project.cflags -Wextra)
endif()

# Linker flags
set(project.lflags "${project.lflags}")



##### Dependencies -------------------------------------------------------------

# Project dependencies (see dependencies.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/dependencies.cmake)



##### No main target -----------------------------------------------------------



##### Tests --------------------------------------------------------------------

# Enable testing - user option
option("${PROJECT_NAME}_TESTING" "If this option is enabled, a set of new executables is created (with project tests)." ON)
get_property(options.test VARIABLE PROPERTY "${PROJECT_NAME}_TESTING")

# If testing is enabled include required packages
if(${options.test})
    include(${CMAKE_CURRENT_LIST_DIR}/test.cmake)
endif()
