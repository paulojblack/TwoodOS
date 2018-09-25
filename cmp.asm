mov bx, 5

cmp bx, 4

jle lthane
jl lthan
mov al, 'C'
jmp ex

lthane:
    mov al, 'A'
    jmp ex
lthan:
    mov al, 'b'
    jmp ex

ex:


mov ah, 0x0e
int 0x10

jmp $

times 510-($-$$) db 0
dw 0xaa55