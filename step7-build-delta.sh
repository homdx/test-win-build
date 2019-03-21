#!/bin/bash

if [ $TRAVIS ]
then
echo "Travis run. Change path env. start1 build botan"
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

cd deltachat-node
patch for 0.39 travis build
cp  -v../package.json.039.patch .
echo patching 0.39 version for travis build
patch -p0 <package.json.039.patch
npm install || echo Error build. Show log build && cat /cygdrive/c/Users/travis/AppData/Roaming/npm-cache/_logs\*.log && /bin/false
