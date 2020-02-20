#!/bin/bash

export DOT_VERSION=v0.105.0-pre2
export DOT_PATH=https://github.com/homdx/test-win-build/releases/download
export DOT_FILE1=ActivePerl-5.28.1.0000-MSWin32-x64-865dc3eb.msi
export DOT_FOLDER1="/c/Users/travis/.cargo"
export DOT_HASH1=fa8aca8f658fa9d579bf7636332453d089b644060587d7625789268f57406891e83ee98afa0162dd7434f253a0485f3b93cbd0ea7c60680321ed40fed88cbf3c
export DOT_FILE2=rustup-arc.7z
export DOT_FOLDER2="/c/Users/travis/.rustup"
export DOT_HASH2=ca0bfa11054f5f4d8a1cb4ea1dbd5b7f5fa195ab5004d437c5ff1969414dc92460140b72ab392fb9f6e59dfc663407cc1a94828e29f6ea3eecf35446426f08c0
export DOT_FILE3=cargo-indexes.7z
export DOT_HASH3=91a5718b51fd5380fde1e024212c1fa4df4c0c992c8a13e78c1b7baa407e27b78d92cfb4a94cb152a4b119eacd1ee499b9043ef979091ff1f06c0cc1dff78a3b
export DOT_FILE4=deltachat-snapshot-sources.7z
export DOT_HASH4=9118ed8b392d29aeb694db4cb7355b3d48f11aa88331ac461d521bbc023c72a52a8ef1df06fc6987181b512f6233028e40a556920684505397329da61201c89c

echo Get Active Perl and Setup
mkdir -pv ${DOT_FOLDER1} ; \
cd ${DOT_FOLDER1} ;\
time -p aria2c -x 5 ${DOT_PATH}/${DOT_VERSION}/${DOT_FILE1} ; \
set -e ;\
echo "${DOT_HASH1}  ${DOT_FILE1}" | sha512sum -c ; \
time -p 7z x -y ${DOT_FILE1} ; echo no rm ${DOT_FILE1}

echo Setup Active Perl
date
cmd /c start /w ActivePerl-5.28.1.0000-MSWin32-x64-865dc3eb.msi /qn /norestart
date
echo done setup Active Perl
echo build Full version
  

git clone --recursive --single-branch --branch 5.15 git://github.com/qt/qt5.git  || echo need fix git
cd qt5
git submodule update --remote || echo fix done or error
echo start archieve sources qt
7z a -bsp1 -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on -v1999m -r ../qt-sources.7z qt5 -xr!.gi
