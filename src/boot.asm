use16
org 0x7C00
SECTOR_NUMBER=8
BOOT_LOAD_ADDRESS=0x8000
jmp BOOTLOADER_start

BOOTLOADER_start:
    mov ah, 0x0E
    mov [BOOTLOADER_drive], dl
    mov ax, 0x0003
    int 0x10
    mov ah, 0x02
    mov bh, 0x00
    mov dx, 0x0000
    int 0x10
    mov ah, 0x0E
    mov si, BOOTLOADER_msg
.loop:
    mov al, [si]
    cmp al, 0x00
    jz .endloop
    int 0x10
    inc si
    jmp .loop
.endloop:
    mov ax, 0x0000
    mov es, ax
    mov ah, 0x02
    mov al, SECTOR_NUMBER
    mov cx, 0x0002
    mov dh, 0x00
    mov dl, [BOOTLOADER_drive]
    mov bx, BOOT_LOAD_ADDRESS
    int 0x13
    mov dl, [BOOTLOADER_drive]
    jmp BOOT_LOAD_ADDRESS
    jmp $

BOOTLOADER_msg: db "Hello World!", 0xA, 0xD, 0x0
BOOTLOADER_drive: db 0x00
times 0x1FE-($-$$) db 0x00
dw 0xAA55
org BOOT_LOAD_ADDRESS
_entry:
jmp _start
_start:
    mov ah, 0x0E
    mov si, msg
.loop:
    mov al, [si]
    cmp al, 0x00
    jz .endloop
    int 0x10
    inc si
    jmp .loop
.endloop:
    jmp $

msg: db "Hello World from the OS!", 0xD, 0xA, 0x0
times (SECTOR_NUMBER*0x200)-($-$$) db 0x00

