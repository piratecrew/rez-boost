#!/bin/bash
if [[ -d "$HOME/rez/bin/rez" ]]; then
    echo "Cache retrieved!"
    exit 0
fi
set -e
OLDPWD=$PWD
cd /tmp
git clone https://github.com/nerdvegas/rez.git
cd rez
python ./install.py -v $HOME/rez
cd ..
mkdir -p $HOME/packages
ls -al $HOME/rez/bin/
ls -al $HOME/rez/bin/rez/
rez-bind platform
rez-bind arch
rez-bind os
git clone https://github.com/piratecrew/rez-python.git
cd rez-python
rez-build -i
echo "PYTHON CONFIGS CFLAGS:"
rez-env python -- python-config --cflags
cd $PWD