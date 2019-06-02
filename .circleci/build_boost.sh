#!/bin/bash
set -e
mkdir -pv ${REZ_REPO_PAYLOAD_DIR}
echo "CREATED REZ_REPO_PAYLOAD_DIR ${REZ_REPO_PAYLOAD_DIR}"
BOOST_ARCHIVE_URL=http://downloads.sourceforge.net/project/boost/boost/${BOOST_VERSION}/boost_$(echo ${BOOST_VERSION} | tr "." "_").tar.gz
echo "BOOST ARCHIVE URL ${BOOST_ARCHIVE_URL}"
OLDPWD=$PWD
mkdir -p ${REZ_REPO_PAYLOAD_DIR}/boost
cd ${REZ_REPO_PAYLOAD_DIR}/boost
curl -LO $BOOST_ARCHIVE_URL
cd $OLDPWD
sed -i s/version.*=.*/version=\"${BOOST_VERSION}\"/ package.py
/tmp/REZ/rez/bin/rez/rez-build -i