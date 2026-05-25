#set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/../)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/../)

add_definitions(-DGLEW_STATIC -D__DOOM__ -D__DOOM_DLL__)

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
	add_definitions(-DID_ENABLE_CURL=0)
	add_definitions(-DXTHREADS)
	
	set(CMAKE_CXX_FLAGS         "${CMAKE_CXX_FLAGS} -std=c++11 -Wno-format-security -Wno-invalid-offsetof -fvisibility=hidden -fno-unsafe-math-optimizations -fno-strict-aliasing -fPIC")
	set(CMAKE_CXX_FLAGS_DEBUG   "${CMAKE_CXX_FLAGS_DEBUG} -g -fno-omit-frame-pointer -O0")
	set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3 -DNDEBUG -msse2")
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
	add_definitions(-DID_ENABLE_CURL=0)
	add_definitions(-DXTHREADS)
	
	set(CMAKE_CXX_FLAGS         "${CMAKE_CXX_FLAGS} -std=c++11 -Wno-format-security -Wno-invalid-offsetof -fvisibility=hidden -fno-unsafe-math-optimizations -fno-strict-aliasing -fPIC")
	set(CMAKE_CXX_FLAGS_DEBUG   "${CMAKE_CXX_FLAGS_DEBUG} -g -fno-omit-frame-pointer -O0")
	set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3 -DNDEBUG -msse2")
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
	if(ID_ALLOW_TOOLS)
		set(CMAKE_MFC_FLAG 2)
		add_definitions(-D_AFXDLL -DID_ALLOW_TOOLS)
	endif()

	if(ID_UNICODE)
		add_definitions(-D_UNICODE)
	endif()

	set(CMAKE_EXE_LINKER_FLAGS      "${CMAKE_EXE_LINKER_FLAGS} /STACK:16777216,16777216 /LARGEADDRESSAWARE")
	set(CMAKE_SHARED_LINKER_FLAGS   "${CMAKE_SHARED_LINKER_FLAGS} /STACK:16777216,16777216 /LARGEADDRESSAWARE")
	
	set(CMAKE_CXX_FLAGS         "${CMAKE_CXX_FLAGS} /DWIN32 /D_WIN32 /D_WINDOWS /EHsc /GR /fp:fast /GS- /MP /W3 /D_USE_32BIT_TIME_T /D_CRT_SECURE_NO_DEPRECATE /D_CRT_NONSTDC_NO_DEPRECATE")
	set(CMAKE_CXX_FLAGS_DEBUG   "${CMAKE_CXX_FLAGS_DEBUG} /D_DEBUG /MDd /Od /Zi")
	set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MD /O2 /GL")
	set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO} /MD /O2 /GL /Zi")
		
	set_property(GLOBAL PROPERTY PREDEFINED_TARGETS_FOLDER  "")
	set_property(GLOBAL PROPERTY USE_FOLDERS ON)
endif()

set(CMAKE_C_FLAGS         ${CMAKE_CXX_FLAGS})
set(CMAKE_C_FLAGS_DEBUG   ${CMAKE_CXX_FLAGS_DEBUG})
set(CMAKE_C_FLAGS_RELEASE ${CMAKE_CXX_FLAGS_RELEASE})

if(UNIX)
	set(CMAKE_SHARED_LIBRARY_PREFIX "")
endif()

macro(set_cpu_arch target)
	if(UNIX)
		if(CMAKE_SIZEOF_VOID_P EQUAL 8 AND ID_ENFORCE32BIT)
			set_target_properties(${target} PROPERTIES COMPILE_FLAGS "-m32" LINK_FLAGS "-m32")
		endif()
	endif()
endmacro(set_cpu_arch)
