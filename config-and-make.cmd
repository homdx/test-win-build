echo on
echo configure vs
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" x86
echo configure qt
configure.bat -debug -recheck-all -I "C:/Program Files (x86)/OpenSSL-Win32/include" -L "C:/Program Files (x86)/OpenSSL-Win32/lib" -prefix C:/Qt515 -opensource -confirm-license -nomake examples -nomake tests -skip qtwebengine
