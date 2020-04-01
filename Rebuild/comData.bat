@echo off
echo ****************************************************
echo *               compresing Data...                 *
echo ****************************************************
"Rebuild/derecmp.exe" nc uncdata/Artnem artnem
"Rebuild/derecmp.exe" kc uncdata/Artkos artkos
"Rebuild/derecmp.exe" ec uncdata/mapeni mapeni
"Rebuild/derecmp.exe" ec uncdata/map16 map16
"Rebuild/derecmp.exe" kc uncdata/map256 map256
"Rebuild/derecmp.exe" ec uncdata/sslayout sslayout
echo ****************************************************
echo *            compress Succesfull!!!!!!             *
echo ****************************************************
pause