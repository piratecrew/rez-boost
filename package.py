name = "boost"

version = "1.62.0"

description = \
    """
    Boost provides free peer-reviewed portable C++ source libraries.
    """

build_requires = [
    "python-2.7"
]

variants = [
    ["platform-linux", "os-CentOS-7"]
]

uuid = "repository.boost"

def commands():
    env.LD_LIBRARY_PATH.prepend("{root}/lib")
    env.BOOST_ROOT = '{root}'
    if building:
        env.CMAKE_MODULE_PATH.append("{root}/cmake")
