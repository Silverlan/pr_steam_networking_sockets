include(${CMAKE_SOURCE_DIR}/cmake/pr_common.cmake)

set(PROJ_NAME ${PROJ_NAME_PREFIX}_shared)
pr_add_library(${PROJ_NAME} STATIC)

pr_add_dependency(${PROJ_NAME} ishared TARGET PUBLIC)
pr_add_dependency(${PROJ_NAME} networkmanager TARGET)

if(CONFIG_USE_STEAMWORKS_NETWORKING MATCHES ON)
	pr_add_compile_definitions(${PROJ_NAME} -DUSE_STEAMWORKS_NETWORKING)

	pr_add_external_dependency(${PROJ_NAME} steamworks LIBRARY)
else()
	pr_add_external_dependency(${PROJ_NAME} valve_gamenetworkingsockets LIBRARY)
endif()

pr_init_module(${PROJ_NAME})

pr_finalize(${PROJ_NAME})
