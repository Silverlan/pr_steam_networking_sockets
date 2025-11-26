include(${CMAKE_SOURCE_DIR}/cmake/pr_common.cmake)

set(PROJ_NAME ${PROJ_NAME_PREFIX}_client)
pr_add_library(${PROJ_NAME} SHARED)

pr_add_dependency(${PROJ_NAME} client TARGET PUBLIC)
pr_add_dependency(${PROJ_NAME} ${PROJ_NAME_PREFIX}_shared TARGET PUBLIC)
pr_add_dependency(${PROJ_NAME} networkmanager TARGET)

if(CONFIG_USE_STEAMWORKS_NETWORKING MATCHES ON)
	pr_add_compile_definitions(${PROJ_NAME} -DUSE_STEAMWORKS_NETWORKING)

	pr_add_external_dependency(${PROJ_NAME} steamworks LIBRARY)
else()
	pr_add_external_dependency(${PROJ_NAME} valve_gamenetworkingsockets LIBRARY)
endif()

pr_add_headers(${PROJ_NAME} "include/")
pr_add_sources(${PROJ_NAME} "src/")

set(BASE_DIR "${CMAKE_CURRENT_LIST_DIR}/../shared/")
pr_add_headers(${PROJ_NAME} "${CMAKE_CURRENT_LIST_DIR}/../shared/include/" BASE_DIRS "${BASE_DIR}")
pr_add_sources(${PROJ_NAME} "${CMAKE_CURRENT_LIST_DIR}/../shared/src/")

pr_finalize(${PROJ_NAME})
