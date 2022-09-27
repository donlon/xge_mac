cmake_minimum_required(VERSION 3.10)
project(xge-mac C CXX)

set(SIMULATOR "QUESTA_SIM" CACHE STRING "")
set(QUESTA_PATH "C:/questasim64" CACHE STRING "")

if (SIMULATOR STREQUAL "SYSTEMC") # OSCI System C
    #set (CMAKE_PREFIX_PATH /opt/systemc)
    #set(SystemCLanguage_DIR ../../cmake/SystemCLanguage)
    find_package(SystemCLanguage CONFIG REQUIRED)
    find_package(verilator HINTS $ENV{VERILATOR_ROOT})
elseif (SIMULATOR STREQUAL "QUESTASIM")
    # Create imported target SystemC::systemc
    add_library(SystemC::systemc SHARED IMPORTED)
    set(SystemC_CXX_STANDARD 17)
    set(SystemC_CXX_STANDARD_REQUIRED ON)
    set(_INCLUDE_DIRS "${QUESTA_PATH}/include/systemc" "${QUESTA_PATH}/include" "${QUESTA_PATH}/include/ac_types")
    set(THREADS_PREFER_PTHREAD_FLAG ON)
    find_package(Threads)
    if (NOT CMAKE_USE_PTHREADS_INIT)
        message(SEND_ERROR "Failed to find the Pthreads library required to implement the SystemC coroutines and async_request_update() of primitive channels on Unix.")
    endif (NOT CMAKE_USE_PTHREADS_INIT)
    set_target_properties(SystemC::systemc PROPERTIES
            INTERFACE_COMPILE_DEFINITIONS "\$<\$<BOOL:OFF>:SC_DISABLE_VIRTUAL_BIND>;\$<\$<BOOL:>:WIN32>;\$<\$<AND:\$<BOOL:ON>,\$<OR:\$<BOOL:>,\$<BOOL:>>>:;SC_WIN_DLL>"
            INTERFACE_COMPILE_OPTIONS "\$<\$<CXX_COMPILER_ID:MSVC>:/vmg;/MP>"
            INTERFACE_INCLUDE_DIRECTORIES "${_INCLUDE_DIRS}"
            INTERFACE_LINK_LIBRARIES "\$<\$<BOOL:1>:Threads::Threads>"
            )
    #set_property(TARGET SystemC::systemc APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
    set_target_properties(SystemC::systemc PROPERTIES
            IMPORTED_IMPLIB "${QUESTA_PATH}/win64/libsystemc_gcc74.lib"
            )
else ()
    message(FATAL_ERROR "Unknown simulator ${SIMULATOR}")
endif ()

set(CMAKE_CXX_STANDARD ${SystemC_CXX_STANDARD} CACHE STRING
        "C++ standard to build all targets. Supported values are 98, 11, and 14.")
set(CMAKE_CXX_STANDARD_REQUIRED ${SystemC_CXX_STANDARD_REQUIRED} CACHE BOOL
        "The with CMAKE_CXX_STANDARD selected C++ standard is a requirement.")

set(PROJECT_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/../..)

add_executable(xge-mac
        ${PROJECT_ROOT}/tbench/systemc/crc.cpp
        ${PROJECT_ROOT}/tbench/systemc/sc_cpu_if.cpp
        ${PROJECT_ROOT}/tbench/systemc/sc_main.cpp
        ${PROJECT_ROOT}/tbench/systemc/sc_packet.cpp
        ${PROJECT_ROOT}/tbench/systemc/sc_pkt_generator.cpp
        ${PROJECT_ROOT}/tbench/systemc/sc_pkt_if.cpp
        ${PROJECT_ROOT}/tbench/systemc/sc_scoreboard.cpp
        ${PROJECT_ROOT}/tbench/systemc/sc_testbench.cpp
        ${PROJECT_ROOT}/tbench/systemc/sc_testcases.cpp
        ${PROJECT_ROOT}/tbench/systemc/sc_xgmii_if.cpp
        )
target_compile_options(xge-mac PRIVATE -Wall -Wextra -Wno-unused-parameter -Wno-unused-variable)
target_link_libraries(xge-mac SystemC::systemc)

set(VERILATOR_FLAGS -sc -Wno-WIDTH --trace +define+SIM_NO_PCS +define+BIGENDIAN)

if (SIMULATOR STREQUAL "SYSTEMC") # OSCI System C
    verilate(xge-mac
            INCLUDE_DIRS ${PROJECT_ROOT}/rtl/include
            INCLUDE_DIRS ${PROJECT_ROOT}/rtl/verilog
            INCLUDE_DIRS ${PROJECT_ROOT}/rtl/megafunctions_altera
            VERILATOR_ARGS ${VERILATOR_FLAGS}
            SOURCES ${PROJECT_ROOT}/rtl/verilog/xge_mac.v)
    target_compile_definitions(xge-mac PRIVATE VERILATOR)
elseif (SIMULATOR STREQUAL "QUESTA_SIM")
    target_compile_definitions(xge-mac PRIVATE MTI_SYSTEMC)
endif ()
