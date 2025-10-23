find_program(INTROSPECTION_SCANNER NAMES g-ir-scanner)
find_program(INTROSPECTION_COMPILER NAMES g-ir-compiler)

if (INTROSPECTION_SCANNER AND INTROSPECTION_COMPILER)
    set(GOBJECT_INTROSPECTION_FOUND TRUE)
    message(STATUS "Found GObject Introspection: ${INTROSPECTION_SCANNER}")
else()
    set(GOBJECT_INTROSPECTION_FOUND FALSE)
    message(WARNING "Could not find GObject Introspection tools (g-ir-scanner, g-ir-compiler)")
endif()

mark_as_advanced(INTROSPECTION_SCANNER INTROSPECTION_COMPILER)
