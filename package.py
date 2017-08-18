name = "boost"

version = "1.62.0"

description = \
    """
    Boost provides free peer-reviewed portable C++ source libraries.
    """

variants = [
    ["platform-linux", "python-2.7"]
]

uuid = "rezpo.boost"

def commands():
    env.LD_LIBRARY_PATH.append("{root}/lib")
    env.BOOST_ROOT = '{root}'
    if building:
        env.CMAKE_MODULE_PATH.append("{root}/cmake")
