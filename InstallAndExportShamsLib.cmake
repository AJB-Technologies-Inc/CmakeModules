
function(install_and_export_shams_lib TARGET_NAME PUBLIC_HEADERS_DIR VERSION)
    include(GNUInstallDirs)

    # Install the library target and create an export set
    install(TARGETS ${TARGET_NAME}
        EXPORT ${TARGET_NAME}Targets
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/shams
    )

    # Install the public headers into common shams directory
    install(DIRECTORY ${PUBLIC_HEADERS_DIR}
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/shams
        FILES_MATCHING PATTERN "*.h" PATTERN "*.hpp"
    )

    # Install the export targets
    install(EXPORT ${TARGET_NAME}Targets
        FILE ${TARGET_NAME}Targets.cmake
        NAMESPACE shams::
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${TARGET_NAME}
    )

    include(CMakePackageConfigHelpers)
    configure_package_config_file(
        "${CMAKE_CURRENT_LIST_DIR}/Config.cmake.in"
        "${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}Config.cmake"
        INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${TARGET_NAME}
    )

    write_basic_package_version_file(
        "${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}ConfigVersion.cmake"
        VERSION ${VERSION}
        COMPATIBILITY AnyNewerVersion
    )

    install(FILES
        "${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}Config.cmake"
        "${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}ConfigVersion.cmake"
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${TARGET_NAME}
    )

    # Exporting targets to the build tree (useful for subprojects)
    export(EXPORT ${TARGET_NAME}Targets
        FILE "${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}Targets.cmake"
        NAMESPACE shams::
    )
endfunction()