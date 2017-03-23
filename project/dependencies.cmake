#               Copyright Marek Dalewski 2017
# Distributed under the Boost Software License, Version 1.0.
#     (See accompanying file LICENSE_1_0.txt or copy at
#           http://www.boost.org/LICENSE_1_0.txt)



##### Boost --------------------------------------------------------------------

# Set options
set(Boost_NO_BOOST_CMAKE     ON)
set(Boost_USE_STATIC_LIBS    ON)
set(Boost_USE_STATIC_RUNTIME OFF)
set(Boost_USE_MULTITHREADED  ON)

# Set required components (by main executable)
set(Boost_COMPONENTS)

# Set required components (by test executables)
if(ENABLE_TESTING)
    set(Boost_COMPONENTS ${Boost_COMPONENTS})
endif()

# Find package
find_package(Boost 1.56.0 COMPONENTS ${Boost_COMPONENTS} REQUIRED)

# Set include directories
list(APPEND project.include ${Boost_INCLUDE_DIRS})

# Set libraries to link
list(APPEND project.link)



##### Vendor -------------------------------------------------------------------

# Make vendor directory
file(MAKE_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/../vendor)

# Set include directories
list(APPEND project.include ${CMAKE_CURRENT_LIST_DIR}/../vendor)



##### Vendor - variadic --------------------------------------------------------

# Isolate dependency setup in function
function(dependency_variadic)

    # Set dependency informations
    set(dep.location ${CMAKE_CURRENT_LIST_DIR}/../vendor/variadic)
    set(dep.version  v0.1-alpha)
    set(dep.log      ${dep.location}/${dep.version}.log)

    # Set download informations
    set(download.src    https://github.com/daishe/variadic/releases/download/${dep.version}/variadic.tar.gz)
    set(download.dst    ${dep.location}/../variadic-${dep.version}.tar.gz)
    set(download.sha256 81fa19b11d0e72511b48ad866c65ae9cf85cc975996a9115ac408ddb2c8fa451)

    # Continue only if a log file is not there
    if(NOT EXISTS ${dep.log})

        # Create root directory
        file(MAKE_DIRECTORY ${dep.location})

        # Download
        file(DOWNLOAD ${download.src} ${download.dst} EXPECTED_HASH SHA256=${download.sha256} TLS_VERIFY ON)

        # Extract
        execute_process(COMMAND ${CMAKE_COMMAND} -E tar xzf ${download.dst} WORKING_DIRECTORY ${dep.location})

        # Remove downloaded archive
        file(REMOVE ${download.dst})

        # Create log
        file(WRITE ${dep.log} "[\"version\": \"${dep.version}\"]")

    endif()

endfunction()

# Load dependency
dependency_variadic()

# Set include directories
list(APPEND project.include ${CMAKE_CURRENT_LIST_DIR}/../vendor/variadic/include)
