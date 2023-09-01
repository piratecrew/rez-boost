name = "boost"

version = "1.70.0"

description = \
    """
    Boost provides free peer-reviewed portable C++ source libraries.
    """
private_build_requires = [
    "python-3"
]

@early()
def build_requires():
    # check if the system gcc is too old <9
    # then we require devtoolset-9
    requirements = ["~python-3"]
    from subprocess import check_output
    gcc_major = int(check_output(r"gcc -dumpversion | cut -f1 -d.", shell=True).strip().decode())
    if gcc_major < 9:
        requirements.append("devtoolset-9")

    return requirements

variants = [
    ["platform-linux", "~python-3.7"],
    ["platform-linux", "~python-3.9"]
]

hashed_variants = True

build_command = "make -f {root}/Makefile {install}"

uuid = "repository.boost"

def commands():
    env.LD_LIBRARY_PATH.prepend("{root}/lib")
    env.BOOST_ROOT = '{root}'
    if building:
        env.CMAKE_MODULE_PATH.append("{root}/cmake")
