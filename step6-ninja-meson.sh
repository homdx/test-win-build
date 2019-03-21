
#!/bin/bash

if [ $TRAVIS ]
then
echo "Travis run. Change path env. start1 build botan"
export PATH=/usr/bin:/usr/local/bin:$PATH
cd $TRAVIS_BUILD_DIR
else
echo "No travis runing"
fi

echo detect python
python3 --version
echo detect pip version
easy_install-3.6 pip
pip --version || pip3 --version
python3 -m pip --version
wget https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py
python3.6 -m pip --version
echo update pip3
python3.6 -m pip install pip --upgrade
echo show upadted pip3 version
python3.6 -m pip --version

echo "Setup Meson from sources"
git clone --recursive https://github.com/mesonbuild/meson.git
cd meson
python3 setup.py build
python3 setup.py install

cd ..

echo "Setup re2c from sources. Deps need for ninja"
echo make re2c
git clone --recursive https://github.com/skvadrik/re2c.git
cd re2c
find . -name \*.m4|xargs dos2unix
find . -name \*.ac|xargs dos2unix
find . -name \*.am|xargs dos2unix
dos2unix autogen.sh
./autogen.sh
echo configure
./configure --help
./configure CXXFLAGS="-std=gnu++11" \
    && echo make && make
echo status of make command is $?    
find . -name \*.exe
echo now make install
make install
echo status of make install is $?
ls -la /usr/local/bin
echo done install
cd ..

echo make ninja
#git clone --recursive https://github.com/ninja-build/ninja
#cd ninja
#python3 configure.py --help
#python3 configure.py --verbose
#echo status of python3 configure $?
#make
#echo status of make $?
#make install
#echo status of make install $?
#ninja --version
echo Get Binary for ninja
wget https://github.com/ninja-build/ninja/releases/download/v1.9.0/ninja-win.zip
unzip ninja-win.zip
cp -v ninja.exe /usr/local/bin
ls -la *.exe
chmod +x /usr/local/bin/ninja.exe
echo listing usr local bin
sleep 30
ls -la /usr/local/bin
#chmod +x ninja.exe
#echo start build with ninja
ninja.exe --version
#make
echo status of make ninja $?
meson --version
