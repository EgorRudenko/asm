org 0x7c00
bit 16

start:
	mov si, msg
	call print
	hlt

print:
	mov ah, 0Eh
	mov bh, 0
	jmp print_loop

print_loop:
	lodsb
	cmp al, 0
	jz done_printing
	int 10h
done_printing:
	ret

halt:
	jmp halt


msg db "hello from kernel", 0x0D, 0x0A, 0
times 510-($-$$) db 0
dw 0AA55h
