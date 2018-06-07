;; Module: CONS
;;
;;     Console Input and Output
;;
;; Dependencies:
;;
;;     bdos.def
;;

%include "bdos.def"

global	cons_prstr
;;====
;;
;; Function: cons_prstr
;;
;;     Prints a null-terminated 7-bit ASCII string on the console.
;;     Does not check if the characters ar in printable range.
;;     Does not modify the string.
;;
;; Parameters:
;;
;;      ax - address of the first byte of the string to print
;;
;; Returns:
;;
;;    nothing
;;
;; Modified Registers:
;;
;;     bx, cx, dx
;;
;;====
;
; Register Usage:
;
;     cl - number of system call
;     dl - system call parameter
;     si - current address in the string
;
; Pseudocode:
;
;     pchr := address ot the string
;     while [pchr] <> 0 do:
;         call c_write([pchr])
;         inc pch
;
	section	.bss
prs_pchr	resw	1

	section	.text
cons_prstr:
	mov	[prs_pchr], ax
.lp:
	mov	bx, [prs_pchr]
	mov	dl, [bx]
	cmp	dl, 0
	je	.e
	mov	cl, c_write
	int	ccpmint
	inc	word [prs_pchr]
	jmp	.lp
.e:
	ret



;; Function: cons_prnum
;; TODO
cons_prnum:
	; prints word in ax in hexadecimal
	push ax
	mov al, ah
	call cons_print_byte
	pop ax
cons_print_byte:
	; prints byte in al in hexadecimal
	push ax
	mov cl, 4
	shr al, cl
	call cons_print_nibble
	pop ax
	and al, 0fh
cons_print_nibble:
	; prints the hexadecimal character (al must be < 16)
	cmp al, 10
	jb cons_print_dec_nibble
	add al, 'A'-10-'0'
cons_print_dec_nibble:
	; prints the decimal character in al (must be < 10h)
	add al, '0'
	mov cl, c_write
	mov dl, al
	int ccpmint
	ret

cons_print_bcd_word:
	; prints bcd word in ax, dl <> 0 => include leading zeros
	push bp
	push ax
	mov bp, sp
	cmp dl, 0
	jnz cons_print_bcd4
	test ax, 0f000h
	jnz cons_print_bcd4
	test ax, 0f00h
	jnz cons_print_bcd3
	test ax, 0f0h
	jnz cons_print_bcd2
	jmp cons_print_bcd1
cons_print_bcd4:
	mov al, [bp+1]
	mov cl, 4
	shr al, cl
	call cons_print_dec_nibble
cons_print_bcd3:
	mov al, [bp+1]
	and al, 0fh
	call cons_print_dec_nibble
cons_print_bcd2:
	mov al, [bp]
	mov cl, 4
	shr al, cl
	call cons_print_dec_nibble
cons_print_bcd1:
	mov al, [bp]
	and al, 0fh
	call cons_print_dec_nibble
	add sp, 2
	pop bp
	ret

cons_print_dec:
	; prints decimal number in ax
	push bp
	sub sp, 2
	mov bp, sp
	mov word [bp], 0
	mov dx, ax
	mov cl, 0
cons_pdloop:
	cmp cl, 16
	jz cons_pdpr
	mov ax, word [bp]
	and ax, 0fh
	cmp ax, 4
	jle cons_pdlp1
	add word [bp], 3
cons_pdlp1:
	mov ax, word [bp]
	and ax, 0f0h
	cmp ax, 40h
	jle cons_pdlp2
	add word [bp], 30h
cons_pdlp2:
	mov ax, word [bp]
	and ax, 0f00h
	cmp ax, 400h
	jle cons_pdlp3
	add word [bp], 300h
cons_pdlp3:
	mov ax, word [bp]
	and ax, 0f000h
	cmp ax, 4000h
	jle cons_pdlp4
	add word [bp], 3000h
cons_pdlp4:
	shl word [bp], 1
	jnc cons_pdshld
	shl dx, 1
	jnc cons_pdincd
	inc word [bp]
cons_pdincd:
	inc dx
	inc cl
	jmp cons_pdloop
cons_pdshld:
	inc cl
	shl dx, 1
	jnc cons_pdloop
	inc word [bp]
	jmp cons_pdloop
cons_pdpr:
	cmp dx, 0
	jnz cons_pdfull
	mov ax, word [bp]
	call cons_print_bcd_word
	jmp cons_pdend
cons_pdfull:
	mov al, dl
	call cons_print_dec_nibble
	mov ax, word [bp]
	mov dl, 1	; must ensure that dl is not 0
	call cons_print_bcd_word
cons_pdend:
	add sp, 2
	pop bp
	ret

cons_crlf:
	mov cl, c_write
	mov dl, 0dh
	int ccpmint
	mov cl, c_write
	mov dl, 0ah
	int ccpmint
