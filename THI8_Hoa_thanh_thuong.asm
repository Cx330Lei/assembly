.model small
.stack 100h
.data
     tb1 db 'Nhap vao ma sinh vien: $'
     masv db 100 dup('$')
     tb2 db 10,13, 'Ten sinh vien la: $'
     tb3 db 10,13, 'Tran Thi Thanh$'
     tb4 db 10,13, 'Nhap ma sinh vien sai!$'
     ten db 'AT160346$'
     cong dw 1
     tb5 db 10,13, 'nhap chuoi: $'
     chuoi dw 100 dup('$')
     tb6 db 10,13, 'Chuyen HOA thanh thuong: $'
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
    lea di,ten
lap:   
    mov ax,0
    inc cx
    mov al,[si]
    cmp [di],'$'
    je sosanh
    cmp [di],al
    je dem
    inc si
    inc di
    jmp lap
dem:
    inc si
    inc di 
    inc cong
    jmp lap
    
sosanh:
    cmp cx,cong
    je hienten
    jne sai
    
hienten:
    mov ah,9
    lea dx,tb2
    int 21h
    lea dx,tb3
    int 21h
    jmp caub
sai:
    mov ah,9
    lea dx,tb4
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
lap2:
    mov ax,0
    mov al,[si]
    inc si
    cmp al,13
    je ketthuc
    cmp al,'Z'
    jg hienthi          
    cmp al,'A'
    jge  chuyen
     
hienthi:
    mov dl,al
    mov ah,2
    int 21h
    jmp lap2
chuyen:
    mov dl,al
    add dl,32
    mov ah,2
    int 21h
    jmp lap2             
ketthuc:    
    MOV AH,4CH
    INT 21h               
main endp  

end