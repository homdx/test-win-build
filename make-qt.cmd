echo on
echo configure vs
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" x86
echo start build
jom.exe /s
echo end build
echo start install
jom.exe install /s
echo done install
