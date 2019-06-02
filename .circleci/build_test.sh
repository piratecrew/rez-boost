mkdir build_test_${VERSION}
cd build_test_${VERSION}

cat > greet.cpp << EOF
#include <boost/python.hpp>

char const* greet()
{
   return "hello, world";
}

BOOST_PYTHON_MODULE(hello_ext)
{
    using namespace boost::python;
    def("greet", greet);
}
EOF

cat > package.py << EOF
name = "boost_test"

version = "1.70.0"

description = """
    Test Boost build
    """

build_requires = [
    "boost-1.70.0"
]

requires = [
    "python-2.7"
]

def commands():
    env.PYTHONPATH.append("{root}/python")
EOF

cat > CMakeLists.txt << EOF
CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

include(RezBuild)
include(RezRepository)
set(boost_COMPONENTS python)
rez_find_packages(boost python PREFIX pkg AUTO)
link_directories(\${boost_LIBRARY_DIRS})

add_library(hello_ext SHARED greet.cpp)
target_include_directories(hello_ext PRIVATE \${pkg_INCLUDE_DIRECTORIES})
target_link_libraries(hello_ext PRIVATE \${pkg_LIBRARIES})
set_target_properties(hello_ext PROPERTIES PREFIX "")

install(TARGETS hello_ext DESTINATION python)
EOF

rez-build -i -- -- VERBOSE=1
rez-env boost_test -- python -c "import hello_ext;print hello_ext.greet()"

