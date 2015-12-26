name = "boost"

version = "1.55.0"

description = \
    """
    boost
    """

variants = [
    ["platform-linux"]
]

requires = [
    "python"
]

uuid = "repository.boost"

def commands():
    env.CMAKE_MODULE_PATH.append("{root}/cmake")
    env.LD_LIBRARY_PATH.append("{root}/lib")
    env.BOOST_ROOT = '{root}'
