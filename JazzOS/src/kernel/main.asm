org 0x0
bits 16

start:
	mov si, msg
	call print
	hlt

halt:
	jmp halt
print:
	mov ah, 0Eh
	mov bh, 0
	jmp print_loop

print_loop:
	lodsb
	cmp al, 0
	jz done_printing
	int 10h
	jmp print_loop
done_printing:
	ret

msg db "hello from kernel", 0x0D, 0x0A, 0

