section .data
	hello db 3,2,4,1,0

section .text
	global _start

_start:
	call bubbleSort
	jmp done
bubbleSort:
	push eax
	push ebx
	push ecx
	push edx
	mov eax, hello
	mov ecx, hello
	inc ecx
	mov ebx, 0 ; do further
	jmp bubbleSortLoop
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
	mov [edx], eax
	mov [eax], ebx
	mov [ebx], edx
	mov ebx, 1
	pop edx
	pop ecx
	pop eax
	jmp underLoop
endSort:
	cmp ebx, 1
	mov eax, hello
	mov ecx, hello
	inc ecx
	je bubbleSort
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret


done:
	mov ebx, hello
	mov eax, 1
	int 80h
