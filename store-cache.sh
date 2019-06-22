#!/bin/bash

if [ -z "$DISABLECACHE" ] ; \
    then echo 'Now not archieve - cached files make are null size. If you not need cache build with: --build-arg DISABLECACHE=something'; \
    touch $TRAVIS_BUILD_DIR/cargo.7z ; \
    touch $TRAVIS_BUILD_DIR/deltachat-core-rust.7z ; \
    touch $TRAVIS_BUILD_DIR/rustup-arc.7z ; \
    else echo Cache are disabled = $DISABLECACHE; \
    # Store cache and upload  \
    echo Store cache and upload;
    cd /c/Users/travis/.cargo ; 7z a -bsp1 -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on -r $TRAVIS_BUILD_DIR/cargo.7z * ; \
    cd $TRAVIS_BUILD_DIR/deltachat-node/deltachat-core-rust/  ; 7z a -bsp1 -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on -r $TRAVIS_BUILD_DIR/deltachat-core-rust.7z * ; \
    cd /c/Users/travis/.rustup/ ; 7z a -bsp1 -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on -r $TRAVIS_BUILD_DIR/rustup-arc.7z * ; \
    fi
