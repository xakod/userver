# AUTOGENERATED, DON'T CHANGE THIS FILE!

if (NOT mongoc-1.0_FIND_VERSION OR mongoc-1.0_FIND_VERSION VERSION_LESS 1.16.0)
    set(mongoc-1.0_FIND_VERSION 1.16.0)
endif()

if (NOT USERVER_CHECK_PACKAGE_VERSIONS)
  unset(mongoc-1.0_FIND_VERSION)
endif()

if (TARGET mongoc-1.0)
  if (NOT mongoc-1.0_FIND_VERSION)
      set(mongoc-1.0_FOUND ON)
      return()
  endif()

  if (mongoc-1.0_VERSION)
      if (mongoc-1.0_FIND_VERSION VERSION_LESS_EQUAL mongoc-1.0_VERSION)
          set(mongoc-1.0_FOUND ON)
          return()
      else()
          message(FATAL_ERROR
              "Already using version ${mongoc-1.0_VERSION} "
              "of mongoc-1.0 when version ${mongoc-1.0_FIND_VERSION} "
              "was requested."
          )
      endif()
  endif()
endif()

set(FULL_ERROR_MESSAGE "Could not find `mongoc-1.0` package.\n\tDebian: sudo apt update && sudo apt install libyandex-taxi-mongo-c-driver-dev\n\tMacOS: brew install yandex-taxi-mongo-c-driver")


include(FindPackageHandleStandardArgs)





if (mongoc-1.0_VERSION)
  set(mongoc-1.0_VERSION ${mongoc-1.0_VERSION})
endif()

if (mongoc-1.0_FIND_VERSION AND NOT mongoc-1.0_VERSION)
  include(DetectVersion)

  if (UNIX AND NOT APPLE)
    deb_version(mongoc-1.0_VERSION libyandex-taxi-mongo-c-driver-dev)
  endif()
  if (APPLE)
    brew_version(mongoc-1.0_VERSION yandex-taxi-mongo-c-driver)
  endif()
endif()

find_package(mongoc-1.0 1.16.0
 )
set(mongoc-1.0_FOUND ${mongoc-1.0_FOUND})
 

if (NOT mongoc-1.0_FOUND)
  if (mongoc-1.0_FIND_REQUIRED)
      message(FATAL_ERROR "${FULL_ERROR_MESSAGE}. Required version is at least ${mongoc-1.0_FIND_VERSION}")
  endif()

  return()
endif()

if (mongoc-1.0_FIND_VERSION)
  if (mongoc-1.0_VERSION VERSION_LESS mongoc-1.0_FIND_VERSION)
      message(STATUS
          "Version of mongoc-1.0 is '${mongoc-1.0_VERSION}'. "
          "Required version is at least '${mongoc-1.0_FIND_VERSION}'. "
          "Ignoring found mongoc-1.0."
          "Note: Set -DUSERVER_CHECK_PACKAGE_VERSIONS=0 to skip package version checks if the package is fine."
      )
      set(mongoc-1.0_FOUND OFF)
      return()
  endif()
endif()

 
if (NOT TARGET mongoc-1.0)
  add_library(mongoc-1.0 INTERFACE IMPORTED GLOBAL)

  target_include_directories(mongoc-1.0 INTERFACE ${mongoc-1.0_INCLUDE_DIRS})
  target_link_libraries(mongoc-1.0 INTERFACE ${mongoc-1.0_LIBRARIES})
  
  # Target mongoc-1.0 is created
endif()

if (mongoc-1.0_VERSION)
  set(mongoc-1.0_VERSION "${mongoc-1.0_VERSION}" CACHE STRING "Version of the mongoc-1.0")
endif()
