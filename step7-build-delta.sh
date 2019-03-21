#!/bin/bash

if [ $TRAVIS ]
then
echo "Travis run. Change path env. start1 build botan"
export PATH=/usr/bin:/usr/local/bin:$PATH
cd $TRAVIS_BUILD_DIR
else
echo "No travis runing"
fi

cd deltachat-node
echo rollback to 0.39
git checkout f510d6ee015407362ee78d2ff05c6d81ac123b0b || echo error commit
git submodule update --recursive || echo error submodule update
npm install || echo need rollback to 0.39 version and fix build for travis
