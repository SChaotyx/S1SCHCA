@echo off
echo ****************************************************
echo *             Decompresing Data...                 *
echo ****************************************************
REM ::: automatic decompression of data
REM ::: remove "REM" from the lines below to re-enable it
"Rebuild/derecmp.exe" nd artnem uncdata/Artnem
"Rebuild/derecmp.exe" kd artkos uncdata/Artkos
"Rebuild/derecmp.exe" ed mapeni uncdata/mapeni
"Rebuild/derecmp.exe" ed map16 uncdata/map16
"Rebuild/derecmp.exe" kd map256 uncdata/map256
"Rebuild/derecmp.exe" ed sslayout uncdata/sslayout
echo ****************************************************
echo *          Decompress Succesfull!!!!!!             *
echo ****************************************************
pause