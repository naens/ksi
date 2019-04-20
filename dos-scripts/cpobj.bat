@echo off
:prompt
set /p a=Copy .OBJ files here? Y/N?
if /i "%a%" == "Y" goto copy
if /i "%a%" == "N" goto exit
goto :prompt

:copy
copy %KSI-DISK%\KSI\LIB\*.OBJ .

:exit
