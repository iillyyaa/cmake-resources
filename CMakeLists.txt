cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
project(cmake-resources VERSION 1.0.0 LANGUAGES CXX)

function(reproduce)
    cmake_parse_arguments(ARG
        ""
        ""
        "RESOURCES"
        ${ARGN})
    list(GET ARG_UNPARSED_ARGUMENTS 0 target)
    list(REMOVE_AT ARG_UNPARSED_ARGUMENTS 0)
    set(sources ${ARG_UNPARSED_ARGUMENTS})
    set(program_name ${PROJECT_NAME}${target})

    add_executable(${target} ${sources})

    if (ARG_RESOURCES)
        set(resources_dir ${program_name}-resources)
        set(dest_resources ${ARG_RESOURCES})
        list(TRANSFORM dest_resources PREPEND ${resources_dir}/)
        add_custom_command(OUTPUT ${dest_resources}
            COMMENT "Copying ${target} resources to ${resources_dir}"
            DEPENDS ${ARG_RESOURCES}
            WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
            COMMAND rm -rf ${CMAKE_CURRENT_BINARY_DIR}/${resources_dir}
            COMMAND mkdir -p ${CMAKE_CURRENT_BINARY_DIR}/${resources_dir}
            COMMAND cp --parents ${ARG_RESOURCES} ${CMAKE_CURRENT_BINARY_DIR}/${resources_dir}
        )
        add_custom_target(${target}_resources DEPENDS ${dest_resources})
        add_dependencies(${target} ${target}_resources)
    endif()
endfunction()

reproduce(module1 module1.cpp RESOURCES shared-resourceA.xyz)
reproduce(module2 module2.cpp RESOURCES shared-resourceA.xyz)
