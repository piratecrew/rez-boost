CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

include(RezBuild)
include(RezRepository)
include(ExternalProject)

set(boost_version ${BOOST_VERSION})

rez_set_archive(boost_path boost/boost_${BOOST_MAJOR_VERSION}_${BOOST_MINOR_VERSION}_${BOOST_PATCH_VERSION}.tar.gz http://downloads.sourceforge.net/project/boost/boost/${boost_version}/boost_${BOOST_MAJOR_VERSION}_${BOOST_MINOR_VERSION}_${BOOST_PATCH_VERSION}.tar.gz)

if(${REZ_BUILD_INSTALL})
    set(install_cmd make install ${make_args})
else()
    set(install_cmd "")
endif()

# Overrides for CI, Travis
set(boost_modules $ENV{OVERRIDE_BOOST_MODULES})
set(b2_args -d0 --prefix=${CMAKE_INSTALL_PREFIX} ${boost_modules} --exec-prefix=${CMAKE_INSTALL_PREFIX} link=static,shared --toolset=gcc cxxflags=-fPIC)

if(${REZ_BUILD_INSTALL})
    set(install_cmd ./b2 install ${b2_args})
else()
    set(install_cmd "")
endif()

ExternalProject_add(
    boost
    URL ${boost_path}
    PREFIX boost
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ./bootstrap.sh
    INSTALL_COMMAND ${install_cmd}
    BUILD_IN_SOURCE 1
    BUILD_COMMAND ./b2 ${b2_args}
)

install(
    FILES cmake/boost.cmake
    DESTINATION cmake
)
