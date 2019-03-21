#!/bin/bash

if [ $TRAVIS ]
then
echo "Travis run. Goto home build folder"
export PATH=/usr/bin:/usr/local/bin:$PATH
cd $TRAVIS_BUILD_DIR
else
echo "No travis runing"
fi

echo "Setup Meson from sources"
git clone --recursive https://github.com/mesonbuild/meson.git
cd meson
python3 setup.py build
python3 setup.py install
meson --version || echo error meson info
cd ..

cp libetpan-mailsmtp-cygwin.patch deltachat-node/deltachat-core/libs/libetpan
cd deltachat-node/deltachat-core/libs/libetpan
dos2unix src/low-level/smtp/mailsmtp.c
dos2unix libetpan-mailsmtp-cygwin.patch
echo 'patching libetpan in deltachat-core'
patch -p0 <libetpan-mailsmtp-cygwin.patch

if [ $TRAVIS ]
then
echo "Travis run. Goto home build folder"
cd $TRAVIS_BUILD_DIR
else
echo "No travis runing"
cd .. && cd .. && cd .. && cd ..
fi

cd deltachat-node
patch for 0.39 travis build
cp  -v ../package.json.039.patch .
dos2unix package.json*
echo patching 0.39 version for travis build
patch -p0 <package.json.039.patch
npm install || echo Error build

cd deltachat-core
echo build deltachat-core with meson
echo meson reconfigure
meson --reconfigure .
echo status of meson reconfigure is $?
meson
echo status of meson is $?
echo build deltachat-core with ninja
ninja
echo status of ninja is $?
cd ..
echo 'attempt for npm install' && npm install || echo Error build. Show log build && cat /cygdrive/c/Users/travis/AppData/Roaming/npm-cache/_logs/*.log && /bin/false
