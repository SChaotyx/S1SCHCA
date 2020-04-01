@echo off
echo ****************************************************
echo *          Compiled Rom is Starting...             *
echo ****************************************************
REM include.exe sonic1.asm s1comb.asm
REM snasm68k.exe -emax 0 -p -o ae- s1comb.asm, S1Built.bin
"Rebuild/asm68k.exe" /i /k /p /o ae- sonic1.asm, S1Built.bin
"Rebuild/rompad.exe" S1Built.bin 255 0
"Rebuild/fixheadr.exe" S1Built.bin
echo ****************************************************
echo *          Compiled Rom Succesfull!!!!!!           *
echo ****************************************************
pause
rem S1Built.bin