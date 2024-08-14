set(GENERAL_FLAGS "-pthread")
if (CMAKE_CXX_COMPILER_ID MATCHES GNU)
	
	if (ARMv8)
		set(GENERAL_FLAGS "${GENERAL_FLAGS} -mfix-cortex-a53-835769 -mfix-cortex-a53-843419")
	endif()
	
	set(WARNING_FLAGS "-Wall -Wextra -Wcast-qual -Wlogical-op -Wundef -Wformat=2 -Wpointer-arith -Werror")
	if (CMAKE_CXX_COMPILER_VERSION VERSION_GREATER 7.5.0)
		set(WARNING_FLAGS "${WARNING_FLAGS} -Wstrict-overflow=2")
	endif()
	
	if (STATIC_BINARY)
		set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static")
	else()
		set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static-libgcc -static-libstdc++")
	endif()
	
elseif (CMAKE_CXX_COMPILER_ID MATCHES Clang)
	
	if (ARMv8)
		set(GENERAL_FLAGS "${GENERAL_FLAGS} -mfix-cortex-a53-835769")
	endif()
	
	set(WARNING_FLAGS "-Wall -Wextra -Wno-undefined-internal -Wunreachable-code-aggressive -Wmissing-prototypes -Wmissing-variable-declarations -Werror")
	
endif()

if (DISABLE_WARNINGS)
	set(WARNING_FLAGS "-w")
endif()

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${GENERAL_FLAGS} ${WARNING_FLAGS}")
set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} ${GENERAL_FLAGS} ${WARNING_FLAGS}")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${GENERAL_FLAGS} ${WARNING_FLAGS}")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} ${GENERAL_FLAGS} ${WARNING_FLAGS}")
