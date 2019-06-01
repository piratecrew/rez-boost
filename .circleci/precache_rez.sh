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
$HOME/rez/bin/rez/rez-bind platform
$HOME/rez/bin/rez/rez-bind arch
$HOME/rez/bin/rez/rez-bind os
$HOME/rez/bin/rez/rez-bind python
git clone https://github.com/piratecrew/rez-python.git
cd rez-python
$HOME/rez/bin/rez/rez-build -i
cd $PWD