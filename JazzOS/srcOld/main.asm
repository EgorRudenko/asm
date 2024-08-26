org 0x7C00
bits 16

main:
	mov ax, 0
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov sp, 0x7c00
	
	call print
	mov cx, 20
	mov dx, 20
	
	mov ah, 0
	mov al, 13h
	int 10h

	call pix
	hlt
	
halt:
	jmp halt

print:
	push ax
	push bx

	mov al, 1
	mov bh, 0
	mov bl, 0fh
	mov dh, 1
	mov dl, 1
	mov cx, 8
	mov bp, os_boot_msg
	mov ah, 13h
	int 10h

	pop bx
	pop ax
	ret

pix:
	mov al, 0b1010
	mov bh, 0
	inc cx
	inc dx

	mov ah, 0Ch
	int 10h

	cmp cx, 100
	jl pix
	cmp dx, 100
	jl pix

	ret


os_boot_msg: DB 'Hello', 0x0D, 0x0A, 0
times 510-($-$$) db 0
dw 0AA55h

