@echo off 
cd /d %~dp0 
flex 1.l 
bison 1.y 
gcc lex.yy.c 1.tab.c 
a.exe 
pause