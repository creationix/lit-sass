include(GenerateExportHeader)
cmake_minimum_required (VERSION 2.6)
project (cencode C)
add_library(cencode SHARED libsass/cencode.c)

project (sass CXX)
include_directories(libsass)
add_library(sass SHARED
  libsass/ast.cpp
  libsass/base64vlq.cpp
  libsass/bind.cpp
  libsass/constants.cpp
  libsass/context.cpp
  libsass/contextualize.cpp
  libsass/cssize.cpp
  libsass/error_handling.cpp
  libsass/eval.cpp
  libsass/expand.cpp
  libsass/extend.cpp
  libsass/file.cpp
  libsass/functions.cpp
  libsass/inspect.cpp
  libsass/node.cpp
  libsass/json.cpp
  libsass/emitter.cpp
  libsass/output.cpp
  libsass/parser.cpp
  libsass/plugins.cpp
  libsass/position.cpp
  libsass/prelexer.cpp
  libsass/remove_placeholders.cpp
  libsass/sass.cpp
  libsass/sass_util.cpp
  libsass/sass_values.cpp
  libsass/sass_context.cpp
  libsass/sass_functions.cpp
  libsass/sass_interface.cpp
  libsass/sass2scss.cpp
  libsass/source_map.cpp
  libsass/to_c.cpp
  libsass/to_string.cpp
  libsass/units.cpp
  libsass/utf8_string.cpp
  libsass/util.cpp
)
include(CheckCXXCompilerFlag)
CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)
CHECK_CXX_COMPILER_FLAG("-std=c++0x" COMPILER_SUPPORTS_CXX0X)
if(COMPILER_SUPPORTS_CXX11)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
elseif(COMPILER_SUPPORTS_CXX0X)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
else()
        message(STATUS "The compiler ${CMAKE_CXX_COMPILER} has no C++11 support. Please use a different C++ compiler.")
endif()

target_link_libraries(sass cencode)
