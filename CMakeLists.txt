cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
project(cmake-resources VERSION 1.0.0 LANGUAGES CXX)

add_executable(module1 module1.cpp)
add_custom_command(OUTPUT module1-resources/dest-resourceA.xyz
    COMMENT "Copying module1 resources to module1-resources"
    DEPENDS shared-resourceA.xyz
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    COMMAND rm -rf ${CMAKE_CURRENT_BINARY_DIR}/module1-resources
    COMMAND mkdir -p ${CMAKE_CURRENT_BINARY_DIR}/module1-resources
    COMMAND cp shared-resourceA.xyz ${CMAKE_CURRENT_BINARY_DIR}/module1-resources/dest-resourceA.xyz
)
add_custom_target(module1_resources DEPENDS module1-resources/dest-resourceA.xyz)
add_dependencies(module1 module1_resources)



add_executable(module2 module2.cpp)
add_custom_command(OUTPUT module2-resources/dest-resourceA.xyz
    COMMENT "Copying module2 resources to module2-resources"
    DEPENDS shared-resourceA.xyz
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    COMMAND rm -rf ${CMAKE_CURRENT_BINARY_DIR}/module2-resources
    COMMAND mkdir -p ${CMAKE_CURRENT_BINARY_DIR}/module2-resources
    COMMAND cp shared-resourceA.xyz ${CMAKE_CURRENT_BINARY_DIR}/module2-resources/dest-resourceA.xyz
)
add_custom_target(module2_resources DEPENDS module2-resources/dest-resourceA.xyz)
add_dependencies(module2 module2_resources)
