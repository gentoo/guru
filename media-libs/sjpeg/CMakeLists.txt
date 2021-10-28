# Copyright 2020 Google LLC.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

cmake_minimum_required(VERSION 2.8.7)

project(sjpeg
        LANGUAGES C CXX)
set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 11)

# Options for coder / decoder executables.
option(SJPEG_ENABLE_SIMD "Enable any SIMD optimization." ON)
option(SJPEG_BUILD_EXAMPLES "Build the sjpeg / vjpeg command line tools." ON)

set(SJPEG_DEP_LIBRARIES)
set(SJPEG_DEP_INCLUDE_DIRS)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING
    "Build type: Release, Debug or RelWithDebInfo" FORCE
  )
endif()

include(GNUInstallDirs)

set(PROJECT_VERSION 0.1)

################################################################################
# Android only.

if(ANDROID)
  include_directories(${SJPEG_ANDROID_NDK_PATH}/sources/android/cpufeatures)
  add_library(cpufeatures
    STATIC ${SJPEG_ANDROID_NDK_PATH}/sources/android/cpufeatures/cpu-features.c
  )
  target_link_libraries(cpufeatures dl)
  set(SJPEG_DEP_LIBRARIES ${SJPEG_DEP_LIBRARIES} cpufeatures)
  set(SJPEG_DEP_INCLUDE_DIRS ${SJPEG_DEP_INCLUDE_DIRS}
      ${SJPEG_ANDROID_NDK_PATH}/sources/android/cpufeatures
  )
endif()

## Check for SIMD extensions.
include(${CMAKE_CURRENT_LIST_DIR}/cmake/cpu.cmake)

################################################################################
# sjpeg source files.

# Build the sjpeg library.
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src/ ${SJPEG_DEP_INCLUDE_DIRS})
add_library(sjpeg ${CMAKE_CURRENT_SOURCE_DIR}/src/bit_writer.cc
  ${CMAKE_CURRENT_SOURCE_DIR}/src/bit_writer.h
  ${CMAKE_CURRENT_SOURCE_DIR}/src/colors_rgb.cc
  ${CMAKE_CURRENT_SOURCE_DIR}/src/dichotomy.cc
  ${CMAKE_CURRENT_SOURCE_DIR}/src/enc.cc
  ${CMAKE_CURRENT_SOURCE_DIR}/src/fdct.cc
  ${CMAKE_CURRENT_SOURCE_DIR}/src/headers.cc
  ${CMAKE_CURRENT_SOURCE_DIR}/src/md5sum.h
  ${CMAKE_CURRENT_SOURCE_DIR}/src/jpeg_tools.cc
  ${CMAKE_CURRENT_SOURCE_DIR}/src/score_7.cc
  ${CMAKE_CURRENT_SOURCE_DIR}/src/sjpeg.h
  ${CMAKE_CURRENT_SOURCE_DIR}/src/sjpegi.h
  ${CMAKE_CURRENT_SOURCE_DIR}/src/yuv_convert.cc
)
if(SJPEG_DEP_LIBRARIES)
  target_link_libraries(sjpeg ${SJPEG_DEP_LIBRARIES})
endif()

# Make sure the OBJECT libraries are built with position independent code
# (it is not ON by default).
set_target_properties(sjpeg PROPERTIES POSITION_INDEPENDENT_CODE ON)

# Set the version numbers.
set_target_properties(sjpeg PROPERTIES VERSION ${PROJECT_VERSION}
                      SOVERSION ${PROJECT_VERSION})

# Find the standard image libraries.
set(SJPEG_DEP_IMG_LIBRARIES)
set(SJPEG_DEP_IMG_INCLUDE_DIRS)
foreach(I_LIB PNG JPEG)
  find_package(${I_LIB})
  set(SJPEG_HAVE_${I_LIB} ${${I_LIB}_FOUND})
  if(${I_LIB}_FOUND)
    set(SJPEG_DEP_IMG_LIBRARIES ${SJPEG_DEP_IMG_LIBRARIES}
        ${${I_LIB}_LIBRARIES})
    set(SJPEG_DEP_IMG_INCLUDE_DIRS ${SJPEG_DEP_IMG_INCLUDE_DIRS}
        ${${I_LIB}_INCLUDE_DIRS})
  endif()
endforeach()

# Find the OpenGL/GLUT libraries.
set(SJPEG_DEP_GL_LIBRARIES)
set(SJPEG_DEP_GL_INCLUDE_DIRS)
find_package(OpenGL)
if(OPENGL_gl_LIBRARY)
  set(SJPEG_DEP_GL_LIBRARIES
      ${SJPEG_DEP_GL_LIBRARIES} ${OPENGL_gl_LIBRARY})
  set(SJPEG_DEP_GL_INCLUDE_DIRS
      ${SJPEG_DEP_GL_INCLUDE_DIRS} ${OPENGL_INCLUDE_DIR})
  set(SJPEG_HAVE_OPENGL TRUE)
endif()
find_package(GLUT)
if(GLUT_FOUND)
  set(SJPEG_DEP_GL_LIBRARIES
      ${SJPEG_DEP_GL_LIBRARIES} ${GLUT_glut_LIBRARY})
  set(SJPEG_DEP_GL_INCLUDE_DIRS
      ${SJPEG_DEP_GL_INCLUDE_DIRS} ${GLUT_INCLUDE_DIR})
  set(SJPEG_HAVE_GLUT TRUE)
endif()

# build the sjpeg-utils library
include_directories(${SJPEG_DEP_IMG_INCLUDE_DIRS})
add_library(sjpeg-utils
            ${CMAKE_CURRENT_SOURCE_DIR}/examples/utils.cc
            ${CMAKE_CURRENT_SOURCE_DIR}/examples/utils.h
)

if(WIN32)
  # quiet warnings related to fopen, sscanf
  target_compile_definitions(sjpeg-utils PRIVATE _CRT_SECURE_NO_WARNINGS)
endif()
if(SJPEG_HAVE_OPENGL)
  # check pthread for GL libraries
  set(THREADS_PREFER_PTHREAD_FLAG ON)
  find_package(Threads)
  if(Threads_FOUND)
    if(CMAKE_USE_PTHREADS_INIT)
      list(APPEND SJPEG_DEP_GL_LIBRARIES ${CMAKE_THREAD_LIBS_INIT})
    endif()
  endif()
  target_compile_definitions(sjpeg-utils PUBLIC SJPEG_HAVE_OPENGL)
  add_definitions(${OPENGL_DEFINITIONS})
endif()
if(SJPEG_HAVE_GLUT)
  add_definitions(${GLUT_DEFINITIONS})
endif()
if(SJPEG_HAVE_JPEG)
  target_compile_definitions(sjpeg-utils PUBLIC SJPEG_HAVE_JPEG)
endif()
if(SJPEG_HAVE_PNG)
  target_compile_definitions(sjpeg-utils PUBLIC SJPEG_HAVE_PNG)
endif()
if(SJPEG_DEP_IMG_LIBRARIES)
  # check pthread for GL libraries
  target_link_libraries(sjpeg-utils ${SJPEG_DEP_IMG_LIBRARIES}
                        ${SJPEG_DEP_GL_LIBRARIES})
endif()
# set_target_properties(sjpeg-utils PROPERTIES POSITION_INDEPENDENT_CODE ON)

# Build the executables if asked for.
if(SJPEG_BUILD_EXAMPLES)
  # sjpeg
  add_executable(sjpeg-bin ${CMAKE_CURRENT_SOURCE_DIR}/examples/sjpeg.cc)
  target_link_libraries(sjpeg-bin sjpeg sjpeg-utils)
  set_target_properties(sjpeg-bin PROPERTIES OUTPUT_NAME sjpeg)

  # vjpeg
  include_directories(${SJPEG_DEP_GL_INCLUDE_DIRS})
  add_executable(vjpeg ${CMAKE_CURRENT_SOURCE_DIR}/examples/vjpeg.cc)
  # Force to link against pthread.
  include(CheckCXXSourceCompiles)
  set(CMAKE_REQUIRED_FLAGS_INI ${CMAKE_REQUIRED_FLAGS})
  set(CMAKE_REQUIRED_FLAGS "-Wl,--no-as-needed")
  check_cxx_source_compiles("int main(void){return 0;}" FLAG_NO_AS_NEEDED)
  set(CMAKE_REQUIRED_FLAGS ${CMAKE_REQUIRED_FLAGS_INI})
  if(FLAG_NO_AS_NEEDED)
    target_link_libraries(vjpeg "-Wl,--no-as-needed")
  endif()

  # check whether we need to include GLUT/glut.h or GL/glut.h
  include(CheckIncludeFileCXX)
  check_include_file_cxx(GLUT/glut.h HAVE_GLUT_GLUT_H)
  check_include_file_cxx(GL/glut.h HAVE_GL_GLUT_H)
  if(HAVE_GLUT_GLUT_H)
    add_definitions(-DHAVE_GLUT_GLUT_H)
  elseif(HAVE_GL_GLUT_H)
    add_definitions(-DHAVE_GL_GLUT_H)
  endif()
  target_link_libraries(vjpeg ${SJPEG_DEP_GL_LIBRARIES} sjpeg sjpeg-utils)

  install(TARGETS sjpeg-bin vjpeg RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
endif()

# Install the different headers and libraries.
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/src/sjpeg.h
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(TARGETS sjpeg
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})

# Create the CMake version file.
include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/sjpegConfigVersion.cmake"
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY AnyNewerVersion
)

# Create the Config file.
include(CMakePackageConfigHelpers)
set(ConfigPackageLocation ${CMAKE_INSTALL_DATADIR}/sjpeg/cmake/)
configure_package_config_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/cmake/sjpegConfig.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/sjpegConfig.cmake
  INSTALL_DESTINATION ${ConfigPackageLocation}
)

# Install the generated CMake files.
install(
  FILES "${CMAKE_CURRENT_BINARY_DIR}/sjpegConfigVersion.cmake"
        "${CMAKE_CURRENT_BINARY_DIR}/sjpegConfig.cmake"
  DESTINATION ${ConfigPackageLocation}
)


################################################################################
# Man page.
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/man/sjpeg.1
              ${CMAKE_CURRENT_SOURCE_DIR}/man/vjpeg.1
  DESTINATION ${CMAKE_INSTALL_MANDIR}/man1)

message(STATUS "<<< Gentoo configuration >>>
Build type      ${CMAKE_BUILD_TYPE}
Install path    ${CMAKE_INSTALL_PREFIX}
Compiler flags:
C               ${CMAKE_C_FLAGS}
C++             ${CMAKE_CXX_FLAGS}
Linker flags:
Executable      ${CMAKE_EXE_LINKER_FLAGS}
Module          ${CMAKE_MODULE_LINKER_FLAGS}
Shared          ${CMAKE_SHARED_LINKER_FLAGS}\n")
