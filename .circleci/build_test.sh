mkdir build_test_${VERSION}
cd build_test_${VERSION}

cat > greet.cpp << EOF
#include <boost/python.hpp>

BOOST_PYTHON_MODULE(hello_ext)
{
    using namespace boost::python;
    def("greet", greet);
}
EOF

cat > package.py << EOF
name = "boost_test"

version = "${VERSION}"

description = \
    """
    Test Boost build
    """

build_requires = [
    "boost-${VERSION}"
]

def commands():
    env.PYTHONPATH.append("{root}/python")
EOF

cat > CMakeLists.txt << EOF
CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

include(RezBuild)
include(RezRepository)

rez_find_packages(PREFIX pkg AUTO)

add_library(hello_ext SHARED greet.cpp)
target_link_directories(hello_ext ${pkg_INCLUDE_DIRS})
target_include_directories(hello_ext PRIVATE ${pkg_INCLUDE_DIRS})
target_link_libraries(hello_ext PRIVATE ${pkg_LIBRARIES})

install(TARGETS hello_ext DESTINATION python)
EOF

rez-build -i -- -- VERBOSE=1
rez-env boost_test -- python -c "import hello_ext;print hello_ext.greet()"

