.model small
.stack 100h
.data
    tb1 db 'Nhap ma sinh vien:$'
    a db 'AT160346$'
    dem dw 1
    masv dw 100 dup('$')
    tb2 db 10,13, 'Nhap sai ma sinh vien!$'
    tb3 db 10,13, 'Ten cua ban la: Tran Thi Thanh$'
    tb5 db 10,13, 'Nhap chuoi: $'
    chuoi dw 100 dup('$')
    tb6 db 10,13, ' Chuoi in hoa la: $'
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    lea dx,tb1
    int 21h
    
    mov ah,10
    lea dx,masv
    int 21h
    
    mov cx,0
    lea si,masv+2
    lea di,a
sosanh:
    mov bx,0
    mov ax,0
    inc cx
    mov al,[si]
    mov bl,[di]
    cmp bl,'$'
    je ten
    cmp al,bl
    je cong
    inc si
    inc di
    jmp sosanh 
cong:
    inc si
    inc di
    inc dem
    jmp sosanh
    
ten:
   cmp dem,cx
   je goiten  
   jne loi
    
goiten:    
    mov ah,9
    lea dx,tb3
    int 21h    
    jmp caub
loi:    
    mov ah,9
    lea dx,tb2
    int 21h
    jmp ketthuc

caub:
    mov ah,9
    lea dx,tb5
    int 21h
    
    mov ah,10
    lea dx,chuoi
    int 21h
    
    mov ah,9
    lea dx,tb6
    int 21h
    
    lea si,chuoi+2
lap:
    mov ax,0
    mov al,[si]
    inc si
    cmp al,'$'
    je ketthuc
    cmp al,'a'
    jl hienthi
    cmp al,'z'
    jl hoa
    
hienthi:
    mov dx,0
    mov dl,al
    mov ah,2
    int 21h
    jmp lap
    
hoa:
    mov dx,0
    mov dl,al
    sub dl,32
    mov ah,2
    int 21h
    jmp lap
    
ketthuc:    
    mov ah,4ch
    int 21h
    
main endp
end
