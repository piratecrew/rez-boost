#!/bin/bash
mkdir -p /tmp/REZ/packages

if [[ -d "/tmp/REZ/rez/bin/rez" ]]; then
    echo "Cache Exists Skipping!"
    exit 0
fi
set -e
OLDPWD=$PWD
cd /tmp
git clone https://github.com/nerdvegas/rez.git
cd rez
python ./install.py -v /tmp/REZ/rez
cd ..
/tmp/REZ/rez/bin/rez/rez-bind platform
/tmp/REZ/rez/bin/rez/rez-bind arch
/tmp/REZ/rez/bin/rez/rez-bind os
git clone https://github.com/piratecrew/rez-python.git
cd rez-python
/tmp/REZ/rez/bin/rez/rez-build -i
cd $PWD