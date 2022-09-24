cmake_minimum_required(VERSION 3.10)
project(xge-mac CXX)

#set (CMAKE_PREFIX_PATH /opt/systemc)
find_package(SystemCLanguage CONFIG REQUIRED)
find_package(verilator HINTS $ENV{VERILATOR_ROOT})

set (CMAKE_CXX_STANDARD ${SystemC_CXX_STANDARD} CACHE STRING
        "C++ standard to build all targets. Supported values are 98, 11, and 14.")
set (CMAKE_CXX_STANDARD_REQUIRED ${SystemC_CXX_STANDARD_REQUIRED} CACHE BOOL
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
set(HDL_SOURCE_FILES
        ${PROJECT_ROOT}/rtl/verilog/xge_mac.v
        )
verilate(xge-mac
        INCLUDE_DIRS ${PROJECT_ROOT}/rtl/include
        INCLUDE_DIRS ${PROJECT_ROOT}/rtl/verilog
        INCLUDE_DIRS ${PROJECT_ROOT}/rtl/megafunctions_altera
        VERILATOR_ARGS ${VERILATOR_FLAGS}
        SOURCES ${HDL_SOURCE_FILES})
