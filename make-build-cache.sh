#!/bin/bash

export DOT_VERSION=v0.105.0-pre2
export DOT_PATH=https://github.com/homdx/test-win-build/releases/download
export DOT_FILE1=ActivePerl-5.28.1.0000-MSWin32-x64-865dc3eb.msi
export DOT_FOLDER1="/c/Users/travis/.cargo"
export DOT_HASH1=fa8aca8f658fa9d579bf7636332453d089b644060587d7625789268f57406891e83ee98afa0162dd7434f253a0485f3b93cbd0ea7c60680321ed40fed88cbf3c
export DOT_FILE2=qt-sources.7z.001
export DOT_FOLDER2="/c/Users/travis/.rustup"
export DOT_HASH2=6439fcdbb254cf500c321f4c6e8a817cd1936357e31090dc9ba04014d9d0de4d77fa24874c85115911606cb2c52d101380ae62a0ca62362dd46a40ef115fe18b
export DOT_FILE3=cargo-indexes.7z
export DOT_HASH3=91a5718b51fd5380fde1e024212c1fa4df4c0c992c8a13e78c1b7baa407e27b78d92cfb4a94cb152a4b119eacd1ee499b9043ef979091ff1f06c0cc1dff78a3b
export DOT_FILE4=Win32OpenSSL-1_1_1d.exe
export DOT_HASH4=6f7e7e2838846893eae2f18019459ebf81da55e590b2c746a4fc34609f58e0e1bb705ee2dbea01c6e8dd59ff0c2c084bbeca3ffc73a8d1afd58a03871eb9d066

echo Get Active Perl and Setup
echo mkdir -pv ${DOT_FOLDER1} ; \
echo cd ${DOT_FOLDER1} ;\
time -p aria2c -x 5 ${DOT_PATH}/${DOT_VERSION}/${DOT_FILE1} ; \
set -e ;\
echo "${DOT_HASH1}  ${DOT_FILE1}" | sha512sum -c ; \
time -p 7z x -y ${DOT_FILE1} ; echo no rm ${DOT_FILE1}

echo Download sources and extract Qt
time -p aria2c -x 5 ${DOT_PATH}/${DOT_VERSION}/${DOT_FILE2} ; \
set -e ;\
echo "${DOT_HASH2}  ${DOT_FILE2}" | sha512sum -c ; \
time -p 7z x -y ${DOT_FILE2} ; rm -vf ${DOT_FILE2}
ls -la

echo Download OpenSSL
time -p aria2c -x 5 ${DOT_PATH}/${DOT_VERSION}/${DOT_FILE4} ; \
set -e ;\
echo "${DOT_HASH4}  ${DOT_FILE4}" | sha512sum -c ; \
echo time -p 7z x -y ${DOT_FILE4} ; echo rm -vf ${DOT_FILE4}
ls -la

exit
#echo Setup Active Perl
#date
#md /c start /w ActivePerl-5.28.1.0000-MSWin32-x64-865dc3eb.msi /qn /norestart
#date
#echo done setup Active Perl
#echo build Full version
  

git clone --recursive --single-branch --branch 5.15 git://github.com/qt/qt5.git  || echo need fix git
cd qt5
git submodule update --remote || echo fix done or error
cd ..
echo start archieve sources qt
7z a -v2g -bsp1 -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on -r $TRAVIS_BUILD_DIR/qt-sources.7z qt5 -xr!.git -xr!.pack
echo list current folder
ls -la
echo list travis build dir
ls -la $TRAVIS_BUILD_DIR/
