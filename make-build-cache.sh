#!/bin/bash

export DOT_VERSION=cached-0.105.0
export DOT_PATH=https://github.com/homdx/test-win-build/releases/download
export DOT_FILE1=cargo.7z
export DOT_FOLDER1="/c/Users/travis/.cargo"
export DOT_HASH1=73ec5d45ced651b7d48ba49d2ee7f01bca11a1ed619118189e7608e91ebb5911a3b74d604ff78ee0e6b2676b923aa82c39a3fc55224e84ef0d615d4e74634bfe
export DOT_FILE2=rustup-arc.7z
export DOT_FOLDER2="/c/Users/travis/.rustup"
export DOT_HASH2=7002c15d5f7febf8fdecea5fd1e0a4e5665492efb8a516526c4ace68b72eb9ae5761eb9d0ae2ba110168bb9a0d8c063b867dc525582b7cf491bd75b9d37a9fa5
export DOT_FILE3=cargo-indexes.7z
export DOT_HASH3=93e0e55175c3e0c96cdf6a88bc4556626822395a18214efbb6ef73ef18dfca903f8612fd9d56e6707bbd8b793d217b5755abf8339476e3ede7e05e61e605a547
export DOT_FILE4=deltachat-snapshot-sources.7z
export DOT_HASH4=7ea5b939ab3ab9b546e8e3c6cb4c3fe2ab3680ba691e51df1452aa69c1b178a5e82f86e060e1bb787e0babfe002cc60108c8befd274bc49528bdafc002225c67

if [ -z "$DISABLECACHE" ] ; \
    then echo 'Now enable Cached files for rust. If you not need cache build with: --build-arg DISABLECACHE=something'; \
    set -ex ; \
    mkdir -pv ${DOT_FOLDER1} ; \
    cd ${DOT_FOLDER1} ;\
    time -p aria2c -x 5 ${DOT_PATH}/${DOT_VERSION}/${DOT_FILE1} ; \
    echo "${DOT_HASH1}  ${DOT_FILE1}" | sha512sum -c ; \
    time -p 7z x -y ${DOT_FILE1} ; rm ${DOT_FILE1} ; cd ..; \
    mkdir -pv ${DOT_FOLDER2} ; \
    cd ${DOT_FOLDER2} ;
    time -p aria2c -x 5 ${DOT_PATH}/${DOT_VERSION}/${DOT_FILE2} ; \
    echo "${DOT_HASH2}  ${DOT_FILE2}" | sha512sum -c ; \
    time -p 7z x -y ${DOT_FILE2} ; rm ${DOT_FILE2} ; cd .. ; \
    cd $TRAVIS_BUILD_DIR ; \
    time -p aria2c -x 5 ${DOT_PATH}/${DOT_VERSION}/${DOT_FILE3} ; \
    echo "${DOT_HASH3}  ${DOT_FILE3}" | sha512sum -c ; \
    time -p 7z x -y ${DOT_FILE3} ; rm ${DOT_FILE3} ; \
    time -p aria2c -x 5 ${DOT_PATH}/${DOT_VERSION}/${DOT_FILE4} ; \
    echo "${DOT_HASH4}  ${DOT_FILE4}" | sha512sum -c ; \
    time -p 7z x -y ${DOT_FILE4} ; rm ${DOT_FILE4} ; \
    cp -pv cargo-config2 /c/Users/travis/.cargo/config ; \
    set +ex ; \
    else echo Cache are disabled = $DISABLECACHE build full version with cache; \
    # Build full version \
    echo build Full version; \
    export PATH=/c/Users/travis/.cargo/bin:$PATH ; \
    cd /c/ProgramData/chocolatey/bin ; \
    wget --quiet https://static.rust-lang.org/rustup/dist/i686-pc-windows-gnu/rustup-init.exe ; \
    ./rustup-init.exe -y --default-toolchain nightly ; \
    cd $TRAVIS_BUILD_DIR/ ; git clone --bare https://github.com/rust-lang/crates.io-index.git ; \
    echo 'no copy only update cargo cp -pv cargo-config2 /c/Users/travis/.cargo/config' ; \
    export PATH=/c/Users/travis/.cargo/bin:/c/Program\ Files/nodejs:$PATH ; \
    echo git latest sources ; \
    cd $TRAVIS_BUILD_DIR ; git clone https://github.com/deltachat/deltachat-node --recursive ; \
    cd deltachat-node ; \
    git checkout 7a8e05d8f9af4cd62a7441b3acf311dad61f66c8 ; \
    cd .. ; \
    git clone --recursive https://github.com/deltachat/deltachat-desktop ; \
    cd deltachat-desktop ; \
    git checkout ca0460c5bf90a5ebb5bfe2aa794799030d8e23ca ; \
    cd .. ; \
    echo 'git ready for build' ; \
    cd deltachat-node ; cargo --version ; cargo update --verbose ; cargo --version ; \
fi
