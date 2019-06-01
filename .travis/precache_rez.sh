#!/bin/bash
if [[ -d "$HOME/rez/bin/rez" ]]; then
    echo "Cache retrieved!"
    exit 0
fi
OLDPWD=$PWD
cd /tmp
git clone https://github.com/nerdvegas/rez.git
cd rez
python ./install.py -v $HOME/rez
cd ..
mkdir -p $HOME/packages
/root/rez/bin/rez/rez-bind platform
/root/rez/bin/rez/rez-bind arch
/root/rez/bin/rez/rez-bind os
/root/rez/bin/rez/rez-bind python
git clone https://github.com/piratecrew/rez-python.git
cd rez-python
/root/rez/bin/rez/rez-build -i
cd $PWD