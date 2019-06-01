#!/bin/bash
OLDPWD=$PWD
cd /tmp
git clone https://github.com/nerdvegas/rez.git
cd rez
python ./install.py -v $HOME/rez
cd ..
mkdir -p $HOME/packages
ls -al $HOME/rez/bin/
ls -al $HOME/rez/bin/rez/
export PATH=$HOME/rez/bin/rez:$PATH
rez-bind platform
rez-bind arch
rez-bind os
rez-bind python
git clone https://github.com/piratecrew/rez-python.git
cd rez-python
rez-build -i
cd $PWD