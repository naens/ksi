;; Program: hello
;;
;;     Prints the 'Hello, world!' message.
;;

extern	cons_prstr

	SEGMENT CODE

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

	SEGMENT DATA

msg	db	'Hello, world!', 0
