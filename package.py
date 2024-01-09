name = "boost"

version = "1.82.0"

description = \
    """
    Boost provides free peer-reviewed portable C++ source libraries.
    """
private_build_requires = [
    "python-3"
]

build_requires = [
    "gcctoolset-9"
]

variants = [
    ["platform-linux", "~python-3.9"],
    ["platform-linux", "~python-3.10"]
]

hashed_variants = True

build_command = "make -f {root}/Makefile {install}"

uuid = "repository.boost"

def commands():
    env.LD_LIBRARY_PATH.prepend("{root}/lib")
    env.BOOST_ROOT = '{root}'
    if building:
        env.CMAKE_MODULE_PATH.append("{root}/cmake")
