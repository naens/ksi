plm86 hello.plm debug print
@if errorlevel 1 goto stop

link86 hello.obj, c:\intel\lib\doslibs.obj, c:\intel\lib\plm86.lib to hello.86 bind
@if errorlevel 1 goto stop

udi2dos hello
@if errorlevel 1 goto stop

:stop

                                        