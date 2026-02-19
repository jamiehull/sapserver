include(FetchContent)

function(add_external_library name dir repo tag build)

# Check if cmake target definition already exists
    if(TARGET ${name})
        message(STATUS "Target ${name} already exists, skipping")
        return()
    endif()

# If it does not exist - clone it
	if(NOT EXISTS ${dir}/CMakeLists.txt AND NOT EXISTS ${dir}/README.md)
		message(STATUS "Cloning ${name} from ${repo} to ${dir}")
		if(tag)
			FetchContent_Declare(${name} GIT_REPOSITORY ${repo} GIT_TAG ${tag} GIT_SUBMODULES "" SOURCE_DIR ${dir})
		else()
			FetchContent_Declare(${name} GIT_REPOSITORY ${repo} GIT_SUBMODULES "" SOURCE_DIR ${dir})
		endif()
		FetchContent_MakeAvailable(${name})
	endif()
	
# If it does exist use the local lib
	if(EXISTS ${dir}/CMakeLists.txt)
		message(STATUS "Using existing ${name} at ${dir}")
		if(${build})
			message(STATUS "Building external library: ${name}")
			add_subdirectory(${dir} ${CMAKE_BINARY_DIR}/external/${name})
		endif()
	endif()
endfunction()
