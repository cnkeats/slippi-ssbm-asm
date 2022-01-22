@echo off
echo Building netplay.json...
gecko build -c netplay.json -defsym "STG_EXIIndex=1"
echo.

xcopy /y C:\Users\Owner\Documents\prog\slippi-ssbm-asm\Output\Netplay\* C:\Users\Owner\Documents\melee\test_dolphin\Sys\GameSettings\*
