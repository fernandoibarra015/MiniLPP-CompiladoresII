cmake_minimum_required(VERSION 2.6)
project(lpp)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(FLEX)
find_package(BISON)


find_program (TREECC treecc
              PATHS /usr /usr/local /opt /opt/local $ENV{TREECC_DIR}
              PATH_SUFFIXES treecc/bin bin )

if (TREECC)
    message(STATUS "Using treecc executable ${TREECC}")
else(TREECC)
    message(FATAL_ERROR "treecc was not found. Try setting TREECC_DIR environment variable")
endif(TREECC)


add_custom_command (
  OUTPUT MiniLPPAst.cpp MiniLPPAst.hpp
  COMMAND ${TREECC} -o MiniLPPAst.cpp -h MiniLPPAst.hpp ${PROJECT_SOURCE_DIR}/MiniLPPAst.tc
  MAIN_DEPENDENCY ${PROJECT_SOURCE_DIR}/MiniLPPAst.tc
  )


FLEX_TARGET(MiniLPPLexer MiniLPPLexerImpl.l
            ${CMAKE_CURRENT_BINARY_DIR}/MiniLPPLexerImpl.cpp
            DEFINES_FILE ${CMAKE_CURRENT_BINARY_DIR}/MiniLPPLexerImpl.hpp
            )

BISON_TARGET(MiniLPPParser MiniLPPParserImpl.y
            ${CMAKE_CURRENT_BINARY_DIR}/MiniLPPParserImpl.cpp
            DEFINES_FILE ${CMAKE_CURRENT_BINARY_DIR}/MiniLPPParserImpl.hpp
            )

include_directories(${CMAKE_CURRENT_BINARY_DIR})
include_directories(${CMAKE_SOURCE_DIR})

add_executable(${PROJECT_NAME}
    ${FLEX_MiniLPPLexer_OUTPUTS}
    ${BISON_MiniLPPParser_OUTPUTS}
    MiniLPPParser.hpp
    MiniLPPParser.cpp
    MiniLPPLexer.hpp
    MiniLPPLexer.cpp
    MiniLPPAst.hpp
    MiniLPPAst.cpp
    MiniLPPmain.cpp
 )