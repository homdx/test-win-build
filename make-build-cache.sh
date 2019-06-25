#!/bin/bash

export DOT_VERSION=cached-0.104b.0
export DOT_PATH=https://github.com/homdx/test-win-build/releases/download
export DOT_FILE1=cargo.7z
export DOT_FOLDER1="/c/Users/travis/.cargo"
export DOT_HASH1=2f07c168ac68c60d2be3625551c1f8ce56c6c5ab17c0f24e1e09d4826c8026addb2ef21bcead8c276bc8ce531a1ebb47bef266edbb540b011be31c41221ffe67
export DOT_FILE2=rustup-arc.7z
export DOT_FOLDER2="/c/Users/travis/.rustup"
export DOT_HASH2=3aaa93485b0de6b1fafdc7a1d11d230280cd8181700e48beb5da1d80647a592d14bb923e4fd4cb67c5bc608ebcde4f643859edd68bf67bf761ffbc01b8601a5c
export DOT_FILE3=cargo-indexes.7z
export DOT_HASH3=34f79331f3865eb2e7523cda76b0469822feab86287759aa6d86fa06926146ca3cc00e4982ac8e87f8c98ed5018d06f8edbd379fe376dd5b65a1f2d7052599ee
export DOT_FILE4=deltachat-snapshot-sources.7z
export DOT_HASH4=deb4fc2f1f9fc97663a521a17192d4bbd2300c387ae1f88a99f551836639ee890fb9017379456e7bb8317104a5f2e341591166a34a87ab421f97c4eb10e341e5

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
    echo "${DOT_HASH3}  ${DOT_FILE4}" | sha512sum -c ; \
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
    git clone --recursive https://github.com/deltachat/deltachat-desktop ; \
    cd deltachat-node ; cargo --version ; cargo update --verbose ; cargo --version ; \
fi
