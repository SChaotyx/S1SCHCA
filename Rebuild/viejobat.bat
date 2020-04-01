@echo off
REM include.exe sonic1.asm s1comb.asm
REM snasm68k.exe -emax 0 -p -o ae- s1comb.asm, Sonic1Build.Smd
rem asm68k /k /p /o ae- sonic1.asm, Sonic1Build.Smd >Resultado.txt, , sonic.lst 
rem rompad.exe Sonic1Build.Smd 255 0
rem fixheadr.exe Sonic1Build.smd
rem Sonic1Build.smd

REM ::: automatic recompression of data - disabled by default because it's slow
REM ::: remove "REM" from the lines below to re-enable it
REM derecmp.exe nc artnem_u artnem
REM derecmp.exe kc artkos_u artkos
REM derecmp.exe ec mapeni_u mapeni
REM derecmp.exe ec map16_u map16
REM derecmp.exe kc map256_u map256
REM derecmp.exe ec sslay_u sslayout

REM ::: automatic decompression of data
REM ::: remove "REM" from the lines below to re-enable it
derecmp.exe nd artnem uncdata/Artnem
derecmp.exe kd artkos uncdata/Artkos
derecmp.exe ed mapeni uncdata/mapeni
derecmp.exe ed map16 uncdata/map16
derecmp.exe kd map256 uncdata/map256
derecmp.exe ed sslay uncdat/sslayout
pause