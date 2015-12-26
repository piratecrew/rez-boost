CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

include(RezBuild)
include(ExternalProject)

set(boost_version ${BOOST_VERSION})

set(url_boost http://downloads.sourceforge.net/project/boost/boost/${boost_version}/boost_${BOOST_MAJOR_VERSION}_${BOOST_MINOR_VERSION}_${BOOST_PATCH_VERSION}.tar.gz)

if(${REZ_BUILD_INSTALL})
    set(install_cmd make install ${make_args})
else()
    set(install_cmd "")
endif()

set(b2_args --prefix=${CMAKE_INSTALL_PREFIX} --exec-prefix=${CMAKE_INSTALL_PREFIX} link=static --toolset=gcc cxxflags=-fPIC)

if(${REZ_BUILD_INSTALL})
    set(install_cmd ./b2 install ${b2_args})
else()
    set(install_cmd "")
endif()

ExternalProject_add(
    boost
    URL ${url_boost}
    PREFIX boost
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ./bootstrap.sh
    INSTALL_COMMAND ${install_cmd}
    BUILD_IN_SOURCE 1
    BUILD_COMMAND ./b2 ${b2_args}
)

rez_install_files(
    cmake/boost.cmake
    DESTINATION .
)
