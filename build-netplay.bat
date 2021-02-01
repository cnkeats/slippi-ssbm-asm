@echo off
echo Building netplay.json...
gecko build -c netplay.json -defsym "STG_EXIIndex=1"
echo.

xcopy C:\Users\Calvin\Documents\prog\slippi-ssbm-asm\Output\Netplay\GALE01r2.ini C:\Users\Calvin\Documents\prog\slippi-online\Binary\x64\Sys\GameSettings /Y
xcopy C:\Users\Calvin\Documents\prog\slippi-ssbm-asm\Output\Netplay\GALJ01r2.ini C:\Users\Calvin\Documents\prog\slippi-online\Binary\x64\Sys\GameSettings /Y
