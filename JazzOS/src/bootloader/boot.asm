org 0x7C00
bits 16

jmp short main
nop

bdb_oem: 					db 				'MSWIN4.1'
bdb_bytes_per_sector:		dw				512
bdb_sectors_per_cluster:	db				1
bdb_reserved_sectors:		dw				1
bdb_fat_count:				db				2
bdb_dir_entries_count:		dw				0E0h
bdb_total_sectors:			dw				2880
bdb_media_descriptor_type:	db				0F0h
bdb_sectors_per_fat:		dw				9
bdb_sectors_per_track:		dw				18
bdb_heads:					dw				2
bdb_hidden_sectors:			dd				0
bdb_large_sector_count:		dd				0

ebr_drive_number:			db				0
							db				0
ebr_signature:				db				29h
ebr_volume_id:				db				12h,34h,56h,78h
ebr_volume_lable:			db				"JAZZ OS    "
ebr_system_id:				db				"FAT12   "

main:
	mov ax, 0
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov sp, 0x7C00


	mov si, os_boot_msg
	call print

	; fat structure
	; 4 segments
	; 1 reserved (or resurved_sectors variable)
	; fat_count * sectors_per_fat = 18 sectors for file allocation table
	; Root directory: start 19th sector (right after previous two)
	; Data


	
	hlt
	
halt:
	jmp halt


print:
	mov ah, 0Eh
	mov bh, 0
	jmp print_loop

print_loop:
	;nothing
	lodsb
	cmp al, 0
	je print_done
	int 10h

print_done:
	ret
	

;input: LBA in ax
;cx [bits 0-5]: sector number
;cx [bits 6-15]: cylinder
;dh head
lba_to_chs:
	push ax
	push dx

	xor dx, dx
	div word [bdb_sectors_per_track] ;lba % sectors per track +1 <- sector

	inc dx ;Sector
	mov cx, dx

	xor dx,dx

	div word [bdb_heads]
	mov dh, dl
	mov ch, al
	shl ah, 6
	or cl, ah
	; head (LBA / sectors per track) % number of heads
	; cylinder (LBA / sectors per track) / number of heads

	pop ax
	mov dl,al
	pop ax

	ret


disk_read:
	push ax
	push bx
	push cx
	push dx
	push di

	call lba_to_chs

	mov ah, 02h
	mov di, 3

retry:
	stc;set the carry, as bios doesn't
	int 13h
	jnc doneRead

	call diskReset

	dec di
	test di,di
	jnz retry

failDiskRead:
	mov si, os_boot_msg
	call print
	jmp halt

diskReset:
	pusha
	mov ah, 0
	stc
	int 13h
	jc failDiskRead
	popa
	ret
doneRead:
	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	ret


;print:
;	push ax
;	push bx
;
;	mov al, 1
;	mov bh, 0
;	mov bl, 0fh
;	mov dh, 1
;	mov dl, 1
;	mov cx, 8
;	mov bp, os_boot_msg
;	mov ah, 13h
;	int 10h
;
;	pop bx
;	pop ax
;	ret


os_boot_msg: db 'Hello from bootloader', 0x0D, 0x0A, 0
file_kernel_bin: db 'KERNEL  BIN'
msg_kernel_not_found: db 'Fuck you. You've forgotten about kernel. Live with it', 0x0D, 0x0A, 0
kernel_cluster: dw 0

kernel_load_segment EQU 0x2000
kernel_offset EQU 0

times 510-($-$$) db 0
dw 0AA55h

buffer:
