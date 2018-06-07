;; Program: hello
;;
;;     Prints the 'Hello, world!' message.
;;

extern	cons_prstr

	segment code

start:
	mov	ax, msg
	call	cons_prstr

	mov	cl, p_termcpm
	mov	dx, 0
	call	ccpm

ccpm:
	int	ccpmint
	ret

%include "bdos.def"

	segment	data

msg	db	'Hello, world!', 0
