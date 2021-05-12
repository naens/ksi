@echo off
echo MAKE.BAT: building %1
plm86 %1.plm debug print
rem @if errorlevel 1 goto stop

link86 %1.obj, c:\intel\lib\doslibs.obj, c:\intel\lib\plm86.lib to %1.86 bind
@if errorlevel 1 goto stop

udi2dos %1
@if errorlevel 1 goto stop

:stop

