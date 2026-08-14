find_program(VALA_COMPILER NAMES valac)
find_program(VAPI_GEN NAMES vapigen)

if (NOT VALA_COMPILER OR NOT VAPI_GEN)
    file(GLOB _vala_bins "/usr/bin/valac-*")
    file(GLOB _vapigen_bins "/usr/bin/vapigen-*")

    if (_vala_bins)
        list(SORT _vala_bins)
        list(REVERSE _vala_bins)
        list(GET _vala_bins 0 VALA_COMPILER)
    endif()

    if (_vapigen_bins)
        list(SORT _vapigen_bins)
        list(REVERSE _vapigen_bins)
        list(GET _vapigen_bins 0 VAPI_GEN)
    endif()
endif()

if (VALA_COMPILER AND VAPI_GEN)
    set(VALA_FOUND TRUE)
    execute_process(
        COMMAND "${VALA_COMPILER}" --version
        OUTPUT_VARIABLE _vala_version
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    string(REGEX MATCH "[0-9]+\\.[0-9]+" VALA_VERSION "${_vala_version}")
    message(STATUS "Found Vala: ${VALA_COMPILER} and ${VAPI_GEN} (version ${VALA_VERSION})")
else()
    set(VALA_FOUND FALSE)
    message(WARNING "Could not find valac/vapigen on this system!")
endif()

mark_as_advanced(VALA_COMPILER VAPI_GEN)
