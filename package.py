name = "boost"

version = "1.70.0"

description = \
    """
    Boost provides free peer-reviewed portable C++ source libraries.
    """

build_requires = [
    "python-2.7"
]

@early()
def variants():
    from rez.package_py_utils import expand_requires
    requires = ["platform-**", "os-*.*"]
    return [expand_requires(*requires)]

uuid = "repository.boost"

def commands():
    env.LD_LIBRARY_PATH.prepend("{root}/lib")
    env.BOOST_ROOT = '{root}'
    if building:
        env.CMAKE_MODULE_PATH.append("{root}/cmake")
