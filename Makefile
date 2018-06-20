hello:
	nasm -g -f obj cons.asm -o cons.obj -l cons.lst
	nasm -g -f obj hello.asm -o hello.obj -l hello.lst
