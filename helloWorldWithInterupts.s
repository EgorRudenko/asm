section .data
	text dd "Hello, world", 0AH, 0DH, "$"
section .text
	global main

main:
	mov eax, 4
	mov ebx, 1
	mov ecx, text
	mov edx, 15

	int 80h

	mov eax, 1
	int 80h
