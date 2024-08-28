section .data
	hello db 3,2,4,1,0	; integers more than zero and less than 10, because I don't want convert fucking not 1 digit numbers to ascii
	char db 0
	charDouble dd 0

section .text
	global _start

_start:
	call bubbleSort
	call print
	jmp done
bubbleSort:
	push eax
	push ebx
	push ecx
bubbleSortGeneralSetup:
	mov eax, hello
	mov ecx, hello
	inc ecx
	mov ebx, 0 ; do further
	jmp bubbleSortLoop

print:
	push eax
	push ebx
	push ecx
	push edx
	mov eax, hello
	mov ebx, 1			; file (none, console)
	mov edx, 1			; length of char
	jmp print_loop

print_loop:
	cmp byte [eax], 0
	je finish_printing
	push eax
	mov cl, byte [eax]
	add cl, 48
	mov [char], cl
	mov [charDouble], ecx
	mov eax, 4
	mov ecx, charDouble
	int 80h
	pop eax
	inc eax
	jmp print_loop

finish_printing:
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret

bubbleSortLoop:
	cmp byte [ecx], 0
	je endSort
	mov dl, [ecx]
	cmp byte [eax], dl 
	jg swap
underLoop:
	inc eax
	inc ecx
	jmp bubbleSortLoop
swap:
	push eax
	push ecx
	push edx
	xor edx, edx
	mov dl, [eax]
	push edx
	mov dl, [ecx]
	mov [eax], dl
	pop edx
	mov [ecx], dl
	mov ebx, 1
	pop edx
	pop ecx
	pop eax
	jmp underLoop
endSort:
	mov eax, hello
	mov ecx, hello
	inc ecx
	cmp ebx, 1
	je bubbleSortGeneralSetup
	pop ecx
	pop ebx
	pop eax
	ret
done:
	mov ebx, 1
	mov eax, 1
	int 80h
