extern printf

section .data
	year dd 2000
	comm db "%d", 10, 0
	
section .text
	global main

main:
	mov ebx, 0
	mov eax, [year]
	shr eax, 1
	adc ebx, 0
	shr eax, 1 
	adc ebx, 0
	cmp ebx, 0
	jg notReally
	mov eax, [year]
	mov ebx, 100
	mov edx, 0
	div ebx
	cmp edx, 0
	je isItReally
	mov eax, 1
	jmp end

isItReally:
	mov ebx, 0
	shr eax, 1
	adc ebx, 0
	shr eax, 1 
	adc ebx, 0
	cmp ebx, 0
	je yeah
	jg nooo
	jmp end

nooo:
	mov eax, 0
	jmp end
yeah:
	mov eax, 1
	jmp end

notReally:
	mov eax, 0
	jmp end
end:
	push eax 
	push comm
	call printf
	mov eax, 1
	int 80h
