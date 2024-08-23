extern printf

section .data
	form db "%s %s%s", 10, 0
	a dd "One for", 0
	b dd "you", 0
	c dd ", one for me", 0
	d dd "Alice", 0					; This is name if given, if not - just nothing
section .text
	global main

main:
	mov eax, [d]
	cmp eax, 0
	je whoAreYou
	push c
	push d
	push a
	push form
	call printf
	jmp end

whoAreYou:
	push c
	push b
	push a
	push form
	call printf
	jmp end

end:
	mov eax, 1
	int 80h
