#!/bin/bash

export DOT_VERSION=cached-0.104a.0
export DOT_PATH=https://github.com/homdx/test-win-build/releases/download
export DOT_FILE1=cargo.7z
export DOT_FOLDER1=".cargo"
export DOT_HASH1=2f85ad9b5b6f1d8ae645b6fdd0fb921a1de92d764b006bf0affad6d323dc063d
export DOT_FILE2=rustup-arc.7z
export DOT_FOLDER2=".rustup"
export DOT_HASH2=dcdecb33076da9c17d689f627cb3931b7bdc8db14e2564064b65ce063fcaa189

echo ${DOT_FILE}

if [ -z "$DISABLECACHE" ] ; \
    then echo 'Now enable Cached files for rust. If you not need cache build with: --build-arg DISABLECACHE=something'; \
    set -ex ; \
    time -p aria2c -x 5 ${DOT_PATH}/${DOT_VERSION}/${DOT_FILE1} ; \
    echo "${DOT_HASH1}  ${DOT_FILE1}" | sha256sum -c ; \
    mkdir -pv ${DOT_FOLDER1} ; \
    cd ${DOT_FOLDER1} ;\
    time -p 7z x -y ../${DOT_FILE1} ; cd .. ; rm ${DOT_FILE1} ; \
    time -p aria2c -x 5 ${DOT_PATH}/${DOT_VERSION}/${DOT_FILE2} ; \
    echo "${DOT_HASH2}  ${DOT_FILE2}" | sha256sum -c ; \
    mkdir -pv ${DOT_FOLDER2} ; \
    cd ${DOT_FOLDER2} ;
    time -p 7z x -y ../${DOT_FILE2} ; cd .. ; rm ${DOT_FILE2} ; \
    else echo Cache are disabled = $DISABLECACHE; \
    # Build full version \
    echo build Full version; 
fi
