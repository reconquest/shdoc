cmake_minimum_required(VERSION 3.5)
project(shdoc)

set(${PROJECT_NAME}_AUTHOR "Ryan Sinnet")
set(${PROJECT_NAME}_VERSION "1.0.0")

set(DOC_BINARY_DIR "${CMAKE_BINARY_DIR}/doc")

add_custom_target(doc-build-directory ALL
  COMMAND ${CMAKE_COMMAND} -E make_directory ${DOC_BINARY_DIR}/${PROJECT_NAME}
  )

function(add_doc doc_file)
  get_filename_component(doc_file_name ${doc_file} NAME)
  set(doc_out_file ${DOC_BINARY_DIR}/${PROJECT_NAME}/${doc_file_name})
  add_custom_command(
    OUTPUT ${doc_out_file}
    COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_SOURCE_DIR}/${doc_file}" "${doc_out_file}"
    DEPENDS doc-build-directory
    )
  string(REPLACE / - doc_target "doc-${doc_out_file}")
  add_custom_target(${doc_target} ALL DEPENDS ${doc_out_file})
endfunction()

add_doc(LICENSE)
add_doc(README.md)

install(DIRECTORY ${DOC_BINARY_DIR}/${PROJECT_NAME} TYPE DOC)
install(PROGRAMS shdoc TYPE BIN)

set(CPACK_GENERATOR "DEB")
set(CPACK_DEBIAN_PACKAGE_DEPENDS "gawk")
set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE "all")
set(CPACK_DEBIAN_PACKAGE_DESCRIPTION "Generates code docs from shell code.")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Ryan Sinnet <rsinnet@misorobotics.com>")
set(CPACK_SYSTEM_NAME "${CPACK_DEBIAN_PACKAGE_ARCHITECTURE}")

set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
set(CPACK_PACKAGE_VERSION "${${PROJECT_NAME}_VERSION}")

include(CPack)
