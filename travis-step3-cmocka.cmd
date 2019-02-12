@echo off
echo windows execute cygwin
set path=c:\tools\cygwin\bin;%path%
rem echo %path%
dos2unix step3-cmocka.sh
sh step3-cmocka.sh
