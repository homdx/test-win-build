[![Build Status](https://travis-ci.org/homdx/test-win-build.svg?branch=master)](https://travis-ci.org/homdx/test-win-build)

*DeltaChat Windows release and CI builder for Windows*

Download DeltaChat windows:

https://github.com/homdx/test-win-build/releases



**Reproduce in your Windows build env:**

1. Setup https://chocolatey.org
2. Setup Git to windows

`choco install nodejs.install aria2`

3. ```
   git clone https://github.com/homdx/test-win-build
   cd test-win-build
   dos2unix *.sh
   chmod +x *.sh
   #setup Travis variables and paths
   export TRAVIS=true
   export TRAVIS_BUILD_DIR=~/test-win-build
   ```
4. reproduce all step in file .travis.yml

Builder for windows

Progress bar for Travis-CI
* [x]  main application deltachat (unpacked)
* [ ]  main application deltachat (packed)
