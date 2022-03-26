# AUTOGENERATED, DON'T CHANGE THIS FILE!

if (NOT fmt_FIND_VERSION OR fmt_FIND_VERSION VERSION_LESS 7.1)
    set(fmt_FIND_VERSION 7.1)
endif()

if (NOT USERVER_CHECK_PACKAGE_VERSIONS)
  unset(fmt_FIND_VERSION)
endif()

if (TARGET fmt)
  if (NOT fmt_FIND_VERSION)
      set(fmt_FOUND ON)
      return()
  endif()

  if (fmt_VERSION)
      if (fmt_FIND_VERSION VERSION_LESS_EQUAL fmt_VERSION)
          set(fmt_FOUND ON)
          return()
      else()
          message(FATAL_ERROR
              "Already using version ${fmt_VERSION} "
              "of fmt when version ${fmt_FIND_VERSION} "
              "was requested."
          )
      endif()
  endif()
endif()

set(FULL_ERROR_MESSAGE "Could not find `fmt` package.\n\tDebian: sudo apt update && sudo apt install libfmt-dev\n\tMacOS: brew install fmt\n\tFedora: sudo dnf install fmt-devel")


include(FindPackageHandleStandardArgs)

find_library(fmt_LIBRARIES_fmt
  NAMES fmt
)
list(APPEND fmt_LIBRARIES ${fmt_LIBRARIES_fmt})

find_path(fmt_INCLUDE_DIRS_fmt_format_h
  NAMES fmt/format.h
)
list(APPEND fmt_INCLUDE_DIRS ${fmt_INCLUDE_DIRS_fmt_format_h})



if (fmt_VERSION)
  set(fmt_VERSION ${fmt_VERSION})
endif()

if (fmt_FIND_VERSION AND NOT fmt_VERSION)
  include(DetectVersion)

  if (UNIX AND NOT APPLE)
    deb_version(fmt_VERSION libfmt-dev)
    rpm_version(fmt_VERSION fmt-devel)
  endif()
  if (APPLE)
    brew_version(fmt_VERSION fmt)
  endif()
endif()

 
find_package_handle_standard_args(
  fmt
    REQUIRED_VARS
      fmt_LIBRARIES
      fmt_INCLUDE_DIRS
      
    FAIL_MESSAGE
      "${FULL_ERROR_MESSAGE}"
)
mark_as_advanced(
  fmt_LIBRARIES
  fmt_INCLUDE_DIRS
  
)

if (NOT fmt_FOUND)
  if (fmt_FIND_REQUIRED)
      message(FATAL_ERROR "${FULL_ERROR_MESSAGE}. Required version is at least ${fmt_FIND_VERSION}")
  endif()

  return()
endif()

if (fmt_FIND_VERSION)
  if (fmt_VERSION VERSION_LESS fmt_FIND_VERSION)
      message(STATUS
          "Version of fmt is '${fmt_VERSION}'. "
          "Required version is at least '${fmt_FIND_VERSION}'. "
          "Ignoring found fmt."
          "Note: Set -DUSERVER_CHECK_PACKAGE_VERSIONS=0 to skip package version checks if the package is fine."
      )
      set(fmt_FOUND OFF)
      return()
  endif()
endif()

 
if (NOT TARGET fmt)
  add_library(fmt INTERFACE IMPORTED GLOBAL)

  target_include_directories(fmt INTERFACE ${fmt_INCLUDE_DIRS})
  target_link_libraries(fmt INTERFACE ${fmt_LIBRARIES})
  
  # Target fmt is created
endif()

if (fmt_VERSION)
  set(fmt_VERSION "${fmt_VERSION}" CACHE STRING "Version of the fmt")
endif()
